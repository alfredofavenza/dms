import java.io.*;
import java.net.*;
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

public class SaveSetupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String setupid = request.getParameter("setupid");
		String name = request.getParameter("setupname");
		String description = request.getParameter("setupdesc");
		Connection dbconn = null;
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
		PrintWriter writer;
        try 
		{
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;
			String callback = "";
		
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
			CallableStatement cstmt;
			String q = "";
			q = "{? = call update_measurement_setup("+setupid+","+name+","+description+",NULL,NULL)}";
			cstmt = dbconn.prepareCall(q);
			cstmt.registerOutParameter(1, Types.TINYINT);
			cstmt.execute();
			callback = Integer.toString(cstmt.getInt(1)); // return value			

			//callback = callback;
			writer = response.getWriter();
			writer.write(callback);
			writer.flush();
			cstmt.close();
			dbconn.close();
        } 
		catch (UnknownHostException e) 
		{
            System.err.println("Don't know about host: 10.10.20.162.");
            System.exit(1);
        } 
		catch (IOException e) 
		{
            System.err.println("Couldn't get I/O for "
                               + "the connection to: 10.10.20.162.");
            System.exit(1);
        } 
		catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    }
}