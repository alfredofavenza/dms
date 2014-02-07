import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.TimeZone;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dmsmanager.DmsMng;

public class CreateEnvTaskPoolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
	    Connection dbconn = null;
		String description = request.getParameter("description");
		String type = request.getParameter("type");
		String startdate = request.getParameter("startdate");
		String starthour = request.getParameter("starthour");
		String startminute = request.getParameter("startminute");
		String hour = request.getParameter("hour");
		String minute = request.getParameter("minute");
		if (hour == "") hour = "NULL";
		if (minute == "") minute = "NULL";
		String dow = "NULL";
		String dom = "NULL";
		String month = "NULL";
		
		String lv_serverDateNowInUTC="";//Will hold the final converted date 
		SimpleDateFormat lv_formatter; 
		Date lv_serverDateNow = new Date();
		lv_formatter = new SimpleDateFormat("yyy-MM-dd HH:mm z'('Z')'"); 		
		lv_formatter.setTimeZone(TimeZone.getTimeZone("UTC"));  
		lv_serverDateNowInUTC = lv_formatter.format(lv_serverDateNow);  
		try
		{
			lv_serverDateNow = lv_formatter.parse(lv_serverDateNowInUTC);
		}
		catch (Exception e) {}
		
		if (starthour.equals("")) starthour = Integer.toString(lv_serverDateNow.getHours());
		if (startminute.equals("")) startminute = Integer.toString(lv_serverDateNow.getMinutes());
		String start = startdate+" "+starthour+":"+startminute;
		if (startdate.equals("")) start = "NULL";
		Date myDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
		try
		{
			myDate = sdf.parse(start);
		}
		catch (Exception e) {}
		
		String callback = "";
		if ((myDate.getTime() < lv_serverDateNow.getTime()))
		{
			//callback = startdate+"  "+myDate.toString()+"-"+myDate.getTime()+", "+lv_serverDateNow.toString()+"-"+lv_serverDateNow.getTime()+" -> Select a start time after the current UTC time";
			callback = "Select a start time after the current UTC time";
		}
		else
		{
			callback = "";
			try {
				user_db = DmsMng.dbuser;
				pwd_db = DmsMng.dbpwd;
				ip_db = DmsMng.dbHostIp;
				name_db = DmsMng.dbName;
								
				Class.forName("com.mysql.jdbc.Driver");
				dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
				CallableStatement cstmt;
				String q = "";
				if (start == "NULL")
				{
					q = "{call create_pool_task_container(66, 'cuncurrent', '"+description+"', '"+type+"', NULL, "+minute+", "+hour+", "+dow+", "+dom+", "+month+")}";
				}
				else
				{
					q = "{call create_pool_task_container(66, 'cuncurrent', '"+description+"', '"+type+"', '"+start+"', "+minute+", "+hour+", "+dow+", "+dom+", "+month+")}";
				}
				//String q = "{call create_pool_task_container(66, 'cuncurrent', 'ALFREDO', 'at_every', '25-03-2013 22:10', NULL, NULL, NULL, NULL, NULL)}";
				cstmt = dbconn.prepareCall(q);       		
				cstmt.close();
				
				String poolid = "";
				Statement st = dbconn.createStatement();
				String query = "SELECT max(id) from task";
				ResultSet res = st.executeQuery(query);
				while(res.next())
				{
					poolid = Integer.toString(res.getInt(1));
				}
				res.close();
				String q1 = "";
				Statement st1 = dbconn.createStatement();
				q1 = "Select EnvDataLogger_ID, EnvDataLogger_Name from vw_available_envdata_loggers_for_polling";
				ResultSet res1 = st1.executeQuery(q1);
				String q2 = "";
				callback = poolid;
				CallableStatement cstmt1;
				while (res1.next())
				{	
					q2 = "{call create_env_monitoring_polling_task(NULL, "+res1.getInt("EnvDataLogger_ID")+", 'all', "+poolid+", '"+res1.getString("EnvDataLogger_Name")+"')}";
					cstmt1 = dbconn.prepareCall(q2);
					cstmt1.execute();
					//cstmt1.close();
					//callback = res1.getInt("EnvDataLogger_ID") +" "+ poolid + " "+ res1.getString("EnvDataLogger_Name");
				}
				//
				dbconn.close();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		PrintWriter writer = response.getWriter();
		writer.write(callback);
		writer.flush();
	}

}