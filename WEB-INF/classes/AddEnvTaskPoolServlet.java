import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dmsmanager.DmsMng;

public class AddEnvTaskPoolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
	    Connection dbconn = null;
		String poolid = request.getParameter("poolid");
		String clockid = request.getParameter("clockid");
		String clockname = request.getParameter("clockname");

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
			String q = "";

			q = "{call create_clock_status_polling_task(NULL, "+clockid+", 'all', "+poolid+", '"+clockname+"')}";
			cstmt = dbconn.prepareCall(q);
			cstmt.execute();
			cstmt.close();
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