package dbmanager;

// import java.io.*;
// import java.net.*;
import java.sql.Connection;
import java.sql.DriverManager;
// import java.sql.PreparedStatement;
// import java.sql.CallableStatement;
// import java.sql.ResultSet;
// import java.sql.ResultSetMetaData;
import java.sql.SQLException;
// import java.sql.Statement;
// import java.sql.Types;
// import javax.servlet.RequestDispatcher;
// import javax.servlet.ServletContext;
// import javax.servlet.ServletException;
// import javax.servlet.http.HttpServlet;
// import javax.servlet.http.HttpServletRequest;
// import javax.servlet.http.HttpServletResponse;
// import javax.servlet.http.HttpSession;
import dmsmanager.DmsMng;


public class DBConnectionManager {

	private Connection dbconn;
	
	// --------------------------------------------------------------------------------------------
	// --------------------------------------------------------------------------------------------
	public DBConnectionManager() throws ClassNotFoundException, SQLException {

		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			this.dbconn = DriverManager.getConnection("jdbc:mysql://"+DmsMng.dbHostIp+":3306/"+DmsMng.dbName+"?zeroDateTimeBehavior=round", DmsMng.dbuser, DmsMng.dbpwd);
		}
		catch (SQLException e) {
//			callback = "ERR;0000;"+e.getMessage()+" (SQLException)";
			e.printStackTrace();
		} 
		catch (ClassNotFoundException e) {
//			callback = "ERR;0000;"+e.getMessage()+" (ClassNotFoundException)";
			e.printStackTrace();
		}
		catch (Exception e) {
//			callback = "ERR;0000;"+e.getMessage()+" (Exception)";
			e.printStackTrace();
		}
		finally {}		
	}
	
	// --------------------------------------------------------------------------------------------
	// --------------------------------------------------------------------------------------------
	public void closeConnection() throws SQLException {

		try
		{
			this.dbconn.close();
		}
		catch (SQLException e) {
//			callback = "ERR;0000;"+e.getMessage()+" (SQLException)";
			e.printStackTrace();
		} 
		catch (Exception e) {
//			callback = "ERR;0000;"+e.getMessage()+" (Exception)";
			e.printStackTrace();
		}
		finally {}
		
	}
	
	// --------------------------------------------------------------------------------------------
	// --------------------------------------------------------------------------------------------
	public Connection getDBConnection() {
		return this.dbconn;
	}

}
