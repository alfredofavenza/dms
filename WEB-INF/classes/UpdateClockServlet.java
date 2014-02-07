
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

public class UpdateClockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String serial = request.getParameter("serial");
		String clockclass = request.getParameter("clockclass");
		String signal = request.getParameter("signal");
		String master = request.getParameter("master");
		String enabled = request.getParameter("enabled");
		String newmasterid = request.getParameter("newmasterid");

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
			String q = "";
			PreparedStatement pstat = null;
			Statement statement = null;
			ResultSet rs = null;
			CallableStatement cstmt = null;
			
			if (master.equals("false") && !(newmasterid.equals("")))
			{
				q = "UPDATE clock SET master = true WHERE id = "+newmasterid;
				pstat = dbconn.prepareStatement(q);
				pstat.executeUpdate();
			}
			else if (master.equals("true"))
			{
				q = "Select id from clock where master = 1";
				statement = dbconn.createStatement();
				rs = statement.executeQuery(q);
				while (rs.next())
				{
					q = "UPDATE clock SET master = 0 WHERE id = "+rs.getInt("id");
					pstat = dbconn.prepareStatement(q);
					pstat.executeUpdate();
				}
				rs.close();
				statement.close();
			}
			q = "{call update_clock ("+id+", "+name+", "+serial+", "+clockclass+", "+signal+", "+master+", "+enabled+")}";
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
