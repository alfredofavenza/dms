import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dmsmanager.DmsMng;

public class UpdatePollingTaskEnvParametersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
		String taskId = request.getParameter("taskid");
		String paramsNum = request.getParameter("paramsnum");
		String paramsList = request.getParameter("paramslist");
		String paramsSetting = request.getParameter("paramsetting");
	    Connection dbconn = null;
		try {
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;
			
			//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
			//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
			
			String sql = "";
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
			CallableStatement cstmt;
			sql = "{call update_env_monitoring_polling_setup("+taskId+", "+paramsNum+", '"+paramsList+"', "+paramsSetting+")}";
			cstmt = dbconn.prepareCall(sql);
			cstmt.execute();
			cstmt.close();
			dbconn.close();	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
}