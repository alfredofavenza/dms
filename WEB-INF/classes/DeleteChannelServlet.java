
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

import dmsmanager.DmsMng;

public class DeleteChannelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		String channel = request.getParameter("channel");
		String safemode = request.getParameter("safemode");
		String user_db = "";
		String pwd_db = "";	
		String ip_db = "";
		String name_db = "";
	    Connection dbconn = null;
		try {
			String callBack = "";
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;
			
			//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
			//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
			
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
						
			CallableStatement cstmt;
			String q = "{call delete_switching_path ("+channel+","+safemode+")}";
			cstmt = dbconn.prepareCall(q);
			//cstmt.executeUpdate(); 
			boolean results = cstmt.execute();
			//Loop through the available result sets.
			while (results) {
				ResultSet rs = cstmt.getResultSet();
				//Retrieve data from the result set.
				while (rs.next()) {
					callBack = Integer.toString(rs.getInt("retcode"));
					callBack = callBack + "|" + rs.getString("retmsg");
				}
				rs.close();
				//Check for next result set
				PrintWriter writer = response.getWriter();
				writer.write(callBack);
				writer.flush();
				results = cstmt.getMoreResults();
			} 
			cstmt.close();
			dbconn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

}
