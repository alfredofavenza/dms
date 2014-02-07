
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PLCReadValServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    PrintWriter out = response.getWriter();
		try 
		{
			URL url = new URL("http://www.whizkidtech.redprince.net/cgi-bin/c");
			URLConnection connection = url.openConnection();
			DataInputStream inStream;
			String inputLine;
			inStream = new DataInputStream(connection.getInputStream());
			while((inputLine = inStream.readLine()) != null)
			{
				out.println(inputLine);
			}
			inStream.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

}
