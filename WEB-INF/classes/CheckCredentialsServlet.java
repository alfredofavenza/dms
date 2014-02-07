
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dmsmanager.DmsMng;


public class CheckCredentialsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
	    String username = request.getParameter("username");
		String password = request.getParameter("password");
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
		Connection dbconn = null;
		if (username.equals(""))
		{
			response.sendRedirect("login.jsp");
		}
		else
		{
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;
			
			//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
			//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
				dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
				Statement statement = dbconn.createStatement();
				ResultSet rs = statement.executeQuery("select * from dms_users where username='"+username+"'");
				if (rs.next())
				{
					if ((rs.getString("password")).equals(password)) 
					{
						response.sendRedirect("index.jsp");
						session.setAttribute("sess_auth", true);
						session.setAttribute("sess_user", rs.getString("username"));
					}
					else
					{
						// Wrong password
						session.setAttribute("sess_login_res",-1);
						response.sendRedirect("login.jsp");
					}
				}
				else
				{
					// Wrong username
					session.setAttribute("sess_login_res",-2);
					response.sendRedirect("login.jsp");
				}
				rs.close();
				statement.close();
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
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException
	{
		doGet(request,response);
	}
}
