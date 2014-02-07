import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.TimeZone;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dmsmanager.DmsMng;

public class UpdatePoolScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
		String scheduleid = request.getParameter("scheduleid");
		String startdate = request.getParameter("startdate");
		String starthour = request.getParameter("starthour");
		String startminute = request.getParameter("startminute");
		String exectype = request.getParameter("executiontype");
		String hour = request.getParameter("hour");
		String minute = request.getParameter("minute");
		String enabled = request.getParameter("enabled");
		
		String lv_dateFormateInUTC="";//Will hold the final converted date 
		SimpleDateFormat lv_formatter; 
		Date lv_localDate = new Date();
		lv_formatter = new SimpleDateFormat("yyy-MM-dd HH:mm z'('Z')'"); 		
		lv_formatter.setTimeZone(TimeZone.getTimeZone("UTC"));  
		lv_dateFormateInUTC = lv_formatter.format(lv_localDate);  
		try
		{
			lv_localDate = lv_formatter.parse(lv_dateFormateInUTC);
		}
		catch (Exception e) {}
		
		if (starthour.equals("")) starthour = Integer.toString(lv_localDate.getHours());
		if (startminute.equals("")) startminute = Integer.toString(lv_localDate.getMinutes());
		String start = startdate+" "+starthour+":"+startminute;
		if (startdate.equals("")) start = "NULL";
		Date date1 = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
		try
		{
			date1 = sdf.parse(start);
		}
		catch (Exception e) {}
		
		String callback = "";
		
		if (hour == "") hour = "NULL";
		if (minute == "") minute = "NULL";
	    Connection dbconn = null;
		
		if ((date1.getTime() < lv_localDate.getTime()))
		{
			//callback = startdate+"  "+date1.toString()+"-"+date1.getTime()+", "+lv_localDate.toString()+"-"+lv_localDate.getTime()+" -> Select a start time after the current UTC time";
			callback = "Select a start time after the current UTC time";
		}
		else
		{
			callback = "none";
			try {
				user_db = DmsMng.dbuser;
				pwd_db = DmsMng.dbpwd;
				ip_db = DmsMng.dbHostIp;
				name_db = DmsMng.dbName;
								
				Class.forName("com.mysql.jdbc.Driver");
				dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
				CallableStatement cstmt;
				String q = "";
				if (start.equals("NULL"))
				{
					q = "{call update_job_schedule("+scheduleid+", '"+exectype+"', NULL, "+hour+", "+minute+", "+enabled+", 1)}";
				}
				else
				{
					q = "{call update_job_schedule("+scheduleid+", '"+exectype+"', '"+start+"', "+hour+", "+minute+", "+enabled+", 1)}";
				}
				//String q = "{call update_job_schedule("+scheduleid+", '"+exectype+"', '', "+hour+", "+minute+", "+enabled+", 1)}";
				cstmt = dbconn.prepareCall(q);
				cstmt.execute();
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