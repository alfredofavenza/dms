import java.io.*;
import java.net.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StopManualMeasurementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Socket clientSocket = null;
        PrintWriter out = null;
        BufferedReader in = null;
		PrintWriter writer;
		String callback = "";

		// (Diego, 21.11) Al momento non sembra servire a questo livello l'interazione col db: lascio comunque commentate le relative parti di codice
		// Connection dbconn = null;
		// String user_db = "";
		// String pwd_db = "";
		// String ip_db = "";
		// String name_db = "";
		
        try 
		{
			// user_db = DmsMng.dbuser;
			// pwd_db = DmsMng.dbpwd;
			// ip_db = DmsMng.dbHostIp;
			// name_db = DmsMng.dbName;			
			// Class.forName("com.mysql.jdbc.Driver");
			
            clientSocket = new Socket();
			clientSocket.connect(new InetSocketAddress("10.10.20.162", 11957), 2000);
			//clientSocket.connect(new InetSocketAddress("10.10.29.3", 11957), 2000);
			clientSocket.setSoTimeout(10000);  // 10 secondi sulla readLine
            
			out = new PrintWriter(clientSocket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
			// PrintWriter printwriter = new PrintWriter(clientSocket.getOutputStream(),true);
			
			String command = "SCHDL;STOP;";
			out.println(command);
			callback = in.readLine();
        } 
		catch (UnknownHostException e) 
		{
			callback = "ERR;0000;"+e.getMessage()+" (UnknownHostException)";
            e.printStackTrace();
        } 
		catch (IOException e) 
		{
			// Filtrare il tipo di I/O Error
			callback = "ERR;0000;"+e.getMessage()+" (IOException)";
            e.printStackTrace();
        } 
		// catch (SQLException e) {
			// callback = "ERR;0000;"+e.getMessage()+" (SQLException)";
			// e.printStackTrace();
		// } 
		// catch (ClassNotFoundException e) {
			// callback = "ERR;0000;"+e.getMessage()+" (ClassNotFoundException)";
			// e.printStackTrace();
		// }
		catch (Exception e) {
			callback = "ERR;0000;"+e.getMessage()+" (Exception)";
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