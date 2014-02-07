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

public class StartManualMeasurementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String signalid = request.getParameter("signalid");
		String setupid = request.getParameter("setupid");

        Socket clientSocket = null;
        PrintWriter out = null;
        BufferedReader in = null;
		Connection dbconn = null;
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
		String callback = "";
		// PrintWriter printwriter;
		PrintWriter writer;
		int resID = 0;

		// just for dry run test
		boolean db_enabled = false;

        try 
		{
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;

			Class.forName("com.mysql.jdbc.Driver");
			clientSocket = new Socket();
			clientSocket.connect(new InetSocketAddress("10.10.20.162", 11957), 2000);
			//clientSocket.connect(new InetSocketAddress("10.10.29.3", 11957), 2000);
			clientSocket.setSoTimeout(10000);  // 10 secondi sulla readLine
            
			if (db_enabled)
			{
				CallableStatement cstmt;
				String q = "";
				
				dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
				q = "{? = call create_manual_measurement("+signalid+", "+setupid+", -1, 27, 26)}";
				cstmt = dbconn.prepareCall(q);
				cstmt.registerOutParameter(1, Types.TINYINT);
				cstmt.execute();
				resID = cstmt.getInt(1); // return value			
							
				cstmt.close();
				dbconn.close();
			}
			else
			{
				resID = 1;
			}
			// callback = Integer.toString(resID);
			
			// ok creazione strutture sul db -> call al gateway
			if (resID != 0)
			{
				out = new PrintWriter(clientSocket.getOutputStream(), true);
				in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
				// printwriter = new PrintWriter(clientSocket.getOutputStream(),true);
				String command = "SCHDL;EXEC;"+resID;
				out.println(command);
				callback = in.readLine();
				in.close();
				out.close();
			}
			else
			{
				callback = "ERR;0000;Database error";
			}
			
        } 
		catch (UnknownHostException e) 
		{
			callback = "ERR;0000;"+e.getMessage()+" (UnknownHostException)";
			// writer = response.getWriter();
			// writer.write(callback);
			// writer.flush();
            e.printStackTrace();
        } 
		catch (IOException e) 
		{
			// Filtrare il tipo di I/O Error
			callback = "ERR;0000;"+e.getMessage()+" (IOException)";
			// clientSocket.close();
			// writer = response.getWriter();
			// writer.write(callback);
			// writer.flush();
            e.printStackTrace();
        } 
		catch (SQLException e) {
			callback = "ERR;0000;"+e.getMessage()+" (SQLException)";
			// writer = response.getWriter();
			// writer.write(callback);
			// writer.flush();
			e.printStackTrace();
		} 
		catch (ClassNotFoundException e) {
			callback = "ERR;0000;"+e.getMessage()+" (ClassNotFoundException)";
			// writer = response.getWriter();
			// writer.write(callback);
			// writer.flush();
			e.printStackTrace();
		}
		catch (Exception e) {
			callback = "ERR;0000;"+e.getMessage()+" (Exception)";
			// writer = response.getWriter();
			// writer.write(callback);
			// writer.flush();
			e.printStackTrace();
		}
		finally
		{
			clientSocket.close();
			writer = response.getWriter();
			writer.write(callback);
			writer.flush();
		}
    }
}