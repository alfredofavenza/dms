import java.io.*;
import java.net.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// import dmsmanager.DmsMng;

public class GetMeasurementResultsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
        Socket clientSocket = null;
        PrintWriter out = null;
        BufferedReader in = null;
		String callback = "";
		PrintWriter writer;

        try 
		{
            clientSocket = new Socket();
			//clientSocket.connect(new InetSocketAddress("10.10.29.3", 11957), 2000);
			clientSocket.connect(new InetSocketAddress("10.10.20.162", 11957), 2000);
			clientSocket.setSoTimeout(1500);  // 1.5 secondi sulla readLine
            
			out = new PrintWriter(clientSocket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
			// PrintWriter printwriter = new PrintWriter(clientSocket.getOutputStream(),true);
			
			String command = "DTMNG;GET_LAST_MEASURE;";
			out.println(command);	
			String resline = in.readLine();
			
			// il comando restituisce un errore -> si ritorna l'intera stringa di risposta
			if (resline.toUpperCase().contains("ERR"))
			{
				callback = resline;
			}
			// il comando restituisce quanto richiesto (header) -> leggo la riga successiva, quella dei dati
			else
			{
				callback = in.readLine();
			}
			in.close();
			out.close();
        } 
		catch (UnknownHostException e) 
		{
			callback = "ERR;0000;"+e.getMessage()+" (UnknownHostException)";
            e.printStackTrace();
        } 
		catch (IOException e) 
		{
			callback = "ERR;0000;"+e.getMessage()+" (IOException)";
            e.printStackTrace();
		}
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