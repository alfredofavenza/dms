
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dmsmanager.DmsMng;

public class CreateClockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String name = request.getParameter("name");
		String serial = request.getParameter("serial");
		String clockclass = request.getParameter("clockclass");
		String signal = request.getParameter("signal");
		String master = request.getParameter("master");
		String enabled = request.getParameter("enabled");

		String user_db = "";
		String pwd_db = "";	
		String ip_db = "";
		String name_db = "";
	    Connection dbconn = null;
		Statement statement = null;
		ResultSet rs = null;
		PreparedStatement pstat = null;
		try {
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;
			
			//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
			//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
			
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
			
			if (master.equals("true"))
			{
				statement = dbconn.createStatement();
				String q = "SELECT id FROM clock where master = true";
				rs = statement.executeQuery(q);
				if (rs.next())
				{
					q = "UPDATE clock SET master = false WHERE id = "+rs.getInt("id");
					pstat = dbconn.prepareStatement(q);
					pstat.executeUpdate();
					pstat.close();
				}
				rs.close();
				statement.close();
			}
			
			CallableStatement cstmt;
			String q = "{call create_clock ("+name+", "+serial+", "+clockclass+", "+signal+", "+master+", "+enabled+")}";
			cstmt = dbconn.prepareCall(q);
			cstmt.executeUpdate(); 
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
