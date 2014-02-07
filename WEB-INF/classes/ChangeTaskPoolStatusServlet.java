import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dmsmanager.DmsMng;

public class ChangeTaskPoolStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
		
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		String parametertype = request.getParameter("paramtype");
		
	    Connection dbconn = null;
		try {
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;
			
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);			
			String q = "";
			String q1 = "";
			String q2 = "";
			int poolScheduleID = 0;
			Statement statement = null;
			Statement statement1 = null;
			CallableStatement cstmt = null;
			ResultSet rs = null;
			ResultSet rs1 = null;
			
			if (parametertype.equals("clock"))
			{
				q = "SELECT * FROM exp_vw_clock_status_polling_pools where ID="+id;
			}
			else
			{
				q = "SELECT * FROM exp_vw_env_monitoring_polling_pools where ID="+id;
			}
			statement = dbconn.createStatement();
			rs = statement.executeQuery(q);
			if (rs.next())
			{
				poolScheduleID = rs.getInt("Polling Schedule");
			}
			q1 = "Select * from exp_vw_pool_task_schedule where Schedule_ID="+poolScheduleID;
			statement1 = dbconn.createStatement();
			rs1 = statement1.executeQuery(q1);
			if (rs1.next())
			{
				String start = rs1.getString("Start_Date")+" "+rs1.getString("Start_Hour")+":"+rs1.getString("Start_Minute");
				q2 = "{call update_job_schedule("+rs1.getInt("Schedule_ID")+", '"+rs1.getString("Execution_Type")+"', '"+start+"', "+rs1.getInt("Hour")+", "+rs1.getInt("Minute")+", "+status+", 1)}";
			}
			cstmt = dbconn.prepareCall(q2);
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

}