import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dmsmanager.DmsMng;

import bean.TaskObject;

public class CreateTaskObjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
	    Connection dbconn = null;

		try {
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;
			
			//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
			//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
			
			String taskId = request.getParameter("taskid");
			int taskIdInt = Integer.parseInt(taskId);
		    String taskName = request.getParameter("taskname");

			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
			Statement statement = dbconn.createStatement();
			Statement statement2 = dbconn.createStatement();
			String q = "Select distinct(Clock_Name), Is_Enabled from vw_exposed_clock_status_polling_info where Polling_Task="+taskId;
			ResultSet rs = statement.executeQuery(q);
			String q2;
			ResultSet rs2;
			
			TaskObject taskObj = new TaskObject(taskIdInt, taskName);
			int i = 0;
			while(rs.next())
			{
				taskObj.addClock(rs.getString("Clock_Name"), 1, rs.getInt("Is_Enabled"));
				q2 = "Select Parameter_Name, Is_Enabled from vw_exposed_clock_status_polling_info where Polling_Task='"+taskId+"' and Clock_Name='"+rs.getString("Clock_Name")+"'";
				rs2 = statement2.executeQuery(q2);
				while(rs2.next())
				{
					taskObj.getClock(i).addParameter(rs2.getString("Parameter_Name"), rs2.getInt("Is_Enabled"));
				}
				i++;
			}
			dbconn.close();
			request.setAttribute("savedTask", taskObj);
			RequestDispatcher rd = request.getRequestDispatcher("ViewPollingTask.jsp?taskid="+taskId);
			rd.forward(request, response);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	 
	}
}