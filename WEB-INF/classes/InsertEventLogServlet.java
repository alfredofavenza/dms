
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.StringTokenizer;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dmsmanager.DmsMng;

public class InsertEventLogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
		StringTokenizer st1;
	    String eventType = request.getParameter("evType");
		String eventSeverity = request.getParameter("evSev");
		String eventSource = (String)session.getAttribute("sess_user");
		String eventDescription = request.getParameter("evDesc");
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
			
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
			CallableStatement cstmt;

			if (eventType.equals("1"))
			{
				String timeTag = request.getParameter("dateTimeTag");
				st1 = new StringTokenizer(timeTag,"/");
				String year = st1.nextToken();
				String month = st1.nextToken();
				String day = st1.nextToken();
				String hours = request.getParameter("hourTimeTag");
				String minutes = request.getParameter("minTimeTag");
				String seconds = request.getParameter("secTimeTag");
		        timeTag = year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
				String freqCorr = request.getParameter("freqCorr");
				if (freqCorr == "") freqCorr = null;
				String driftCorr = request.getParameter("driftCorr");
				if (driftCorr == "") driftCorr = null;
				String operator = request.getParameter("operator");
				String description = request.getParameter("description");
				cstmt = dbconn.prepareCall("{call report_steering_event("+eventType+","+eventSeverity+",'"+eventSource+"','"+eventDescription+"','"+timeTag+"',"+freqCorr+","+driftCorr+",'"+operator+"','"+description+"')}");
				cstmt.executeUpdate(); 
			}
			else if (eventType.equals("2"))
			{
				String timeTag = request.getParameter("dateTimeTag");
				st1 = new StringTokenizer(timeTag,"/");
				String year = st1.nextToken();
				String month = st1.nextToken();
				String day = st1.nextToken();
				String hours = request.getParameter("hourTimeTag");
				String minutes = request.getParameter("minTimeTag");
				String seconds = request.getParameter("secTimeTag");
		        timeTag = year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
				String clock = request.getParameter("clock");
				String timeStep = request.getParameter("timeStep");
				if (timeStep == "") timeStep = null;
				String freqStep = request.getParameter("freqStep");
				if (freqStep == "") freqStep = null;
				String operator = request.getParameter("operator");
				String description = request.getParameter("description");
				cstmt = dbconn.prepareCall("{call report_clock_step_event("+eventType+","+eventSeverity+",'"+eventSource+"','"+eventDescription+"','"+timeTag+"','"+clock+"',"+timeStep+","+freqStep+",'"+operator+"','"+description+"')}");
			    cstmt.executeUpdate(); 
			}
			else if (eventType.equals("3"))
			{
				cstmt = dbconn.prepareCall("{call report_generic_event("+eventType+","+eventSeverity+",'"+eventSource+"','"+eventDescription+"',null)}");
			    cstmt.executeUpdate(); 
			}
			
			dbconn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException
	{
		doGet(request,response);
	}

}
