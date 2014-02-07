import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Types;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dmsmanager.DmsMng;

public class CreateSetupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String setupid = request.getParameter("setupid");
		Connection dbconn = null;
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
		PrintWriter writer;
		String callback = "";
        try 
		{
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;		
		
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
			CallableStatement cstmt;
			String q = "";
			
			q = "{? = call create_measurement_setup("+setupid+",'','')}";
			cstmt = dbconn.prepareCall(q);
			cstmt.registerOutParameter(1, Types.TINYINT);
			cstmt.execute();
			callback = Integer.toString(cstmt.getInt(1)); // return value			

			cstmt.close();
			dbconn.close();
			writer = response.getWriter();
			writer.write(callback);
			writer.flush();
        } 
		catch (SQLException e) 
		{
			e.printStackTrace();
			callback = "error";
			writer = response.getWriter();
			writer.write(callback);
			writer.flush();
		} 
		catch (ClassNotFoundException e) 
		{
			e.printStackTrace();
			callback = "error";
			writer = response.getWriter();
			writer.write(callback);
			writer.flush();
		}
    }
}