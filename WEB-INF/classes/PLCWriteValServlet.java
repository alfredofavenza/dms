
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

public class PLCWriteValServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try 
		{
			URL url = new URL("http://10.10.3.210/cgi-bin/writeVal.exe");
			URLConnection connection = url.openConnection();
			connection.setDoOutput(true);
			
			PrintStream outStream = new PrintStream(connection.getOutputStream());
			outStream.println("dataname="+URLEncoder.encode("pippo")+"&datavalue="+URLEncoder.encode("pluto"));
			outStream.flush();
			outStream.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

}
