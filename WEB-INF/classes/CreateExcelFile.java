
import java.sql.*;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import java.io.FileOutputStream;
import java.io.File;
import java.io.IOException;
import dmsmanager.DmsMng;

public class CreateExcelFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    String query = request.getParameter("param");
		String filename = request.getParameter("filename");
	    Connection dbconn = null;
		String user_db = "";
		String pwd_db = "";
		String ip_db = "";
		String name_db = "";
		try {
			user_db = DmsMng.dbuser;
			pwd_db = DmsMng.dbpwd;
			ip_db = DmsMng.dbHostIp;
			name_db = DmsMng.dbName;
			
			//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
			//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
			
			String webapp_root = getServletContext().getRealPath("/");
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
			Statement statement = dbconn.createStatement();
			
			File directory = new File(webapp_root+"/exported/");
			// Get all files in directory
			File[] files = directory.listFiles();
			for (File file : files)
			{
				// Delete each file
				if (!file.delete())
				{
				   // Failed to delete file
				   System.out.println("Failed to delete "+file);
				}
			}
			
			query = query.replace("|"," ");
			ResultSet rs = statement.executeQuery(query);
			ResultSetMetaData rsmd = rs.getMetaData();
			int numOfCols = rsmd.getColumnCount();
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet1 = wb.createSheet("new sheet");
			int i = 0;
			int j = 0;
			int k = 1;
			HSSFRow headerrow = sheet1.createRow(i);
			for (i = 1; i <= numOfCols; i++)
			{
				if (!rsmd.getColumnName(i).equals("ID"))
				{
					HSSFCell cell = headerrow.createCell(j);
					cell.setCellValue((String)rsmd.getColumnName(i));
					j++;
				}
			}
			i = 1;
			while (rs.next())
			{
				HSSFRow row = sheet1.createRow(i);
				k = 0;
				for (j = 0; j < numOfCols; j++)
				{
					if (!rsmd.getColumnName(j+1).equals("ID"))
					{
						HSSFCell cell = row.createCell(k);
						if ((rsmd.getColumnType(j+1) == Types.INTEGER) || (rsmd.getColumnType(j+1) == Types.TINYINT) || (rsmd.getColumnType(j+1) == Types.SMALLINT)) 
						{
							cell.setCellValue((int)rs.getObject(j+1));
						}
						else if ((rsmd.getColumnType(j+1) == Types.VARCHAR) || (rsmd.getColumnType(j+1) == Types.CHAR) || (rsmd.getColumnType(j+1) == Types.LONGVARCHAR))
						{
							cell.setCellValue((String)rs.getObject(j+1));
						}					
						else if (rsmd.getColumnType(j+1) == Types.BIGINT)
						{
							cell.setCellValue((long)(rs.getLong(j+1)));
						}
						else if ((rsmd.getColumnType(j+1) == Types.DECIMAL) || (rsmd.getColumnType(j+1) == Types.NUMERIC))
						{
							cell.setCellValue(rs.getDouble(j+1));
						}
						else if ((rsmd.getColumnType(j+1) == Types.DOUBLE) || (rsmd.getColumnType(j+1) == Types.FLOAT))
						{
							cell.setCellValue((double)(rs.getDouble(j+1)));
						}
						else if (rsmd.getColumnType(j+1) == Types.REAL)
						{
							cell.setCellValue((float)(rs.getFloat(j+1)));
						}
						else if (rsmd.getColumnType(j+1) == Types.BIT)
						{	
							cell.setCellValue((rs.getBoolean(j+1)));
						}
						else if (rsmd.getColumnType(j+1) == Types.TIME)
						{
							cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(rs.getTime(j+1)));
						}
						else if (rsmd.getColumnType(j+1) == Types.TIMESTAMP)
						{
							cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(rs.getTimestamp(j+1)));

						}
						else if (rsmd.getColumnType(j+1) == Types.DATE)
						{
							cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(rs.getDate(j+1)));
						}
						k++;
					}
				}
				i++;
			}
			rs.close();
			statement.close();
			dbconn.close();
			FileOutputStream fileOut = new FileOutputStream(webapp_root+"/exported/"+filename+".xls");
			wb.write(fileOut);
			fileOut.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doGet(request,response);
	}
}
