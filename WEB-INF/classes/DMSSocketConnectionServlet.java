import java.io.*;
import java.net.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class DMSSocketConnectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
        Socket clientSocket = null;
        PrintWriter out = null;
        BufferedReader in = null;
		String num = request.getParameter("num");

        try 
		{
            clientSocket = new Socket("10.10.20.162", 11957);
            out = new PrintWriter(clientSocket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
			for (int i=0;i<18;i++)
			{
				in.readLine();
			}
			String command = "SCHDL;EXEC;"+num;
			//String command = "SCHDL;EXEC;5";
			out.println(command);
			
			String callback = "";

			callback = callback + in.readLine();

			in.close();
			out.close();
			clientSocket.close();
			
			PrintWriter writer = response.getWriter();
			writer.write(callback);
			writer.flush();
        } 
		catch (UnknownHostException e) 
		{
            System.err.println("Don't know about host: 10.10.20.162.");
            System.exit(1);
        } catch (IOException e) 
		{
            System.err.println("Couldn't get I/O for "
                               + "the connection to: 10.10.20.162.");
            System.exit(1);
        }
    }
}