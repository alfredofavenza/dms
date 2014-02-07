import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.StringTokenizer;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dmsmanager.DmsMng;

public class UpdatePollingTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    PrintWriter out = response.getWriter();
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
			
			String sql = "";
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
			Statement stmt = dbconn.createStatement();
			sql = "update vw_exposed_clock_status_polling_config SET Is_Enabled = 0 where Is_Enabled = 1";
			stmt.executeUpdate(sql);
			Enumeration enumeration = request.getParameterNames();
			String paramclock = "";
			while (enumeration.hasMoreElements()) {
				paramclock = (String) enumeration.nextElement();
				StringTokenizer st = new StringTokenizer(paramclock, "^");
				if (st.hasMoreTokens())
				{
					String parameter = st.nextToken();
					String clock = st.nextToken();
					sql = "update vw_exposed_clock_status_polling_config set Is_Enabled = 1 where Clock_Name='"+clock+"' and Parameter_Name='"+parameter+"'";
					out.println(sql);
					stmt.executeUpdate(sql);
				}
			}
			stmt.close();
			dbconn.close();	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
}