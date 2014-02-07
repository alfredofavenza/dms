import java.io.*;
//import java.sql.Connection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import dmsmanager.DmsMng;

import bean.TaskObject;

public class UpdateTaskObjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
		//String user_db = "";
		//String pwd_db = "";
		//String ip_db = "";
		//String name_db = "";
	    //Connection dbconn = null;

		//try {
			//user_db = DmsMng.dbuser;
			//pwd_db = DmsMng.dbpwd;
			//ip_db = DmsMng.dbHostIp;
			//name_db = DmsMng.dbName;
			
			//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
			//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
			
			//String taskId = request.getParameter("taskid");
			//int taskId = Integer.parseInt(request.getParameter("taskid"));
			//int taskId = 22;
		    //String taskName = request.getParameter("taskname");
			//String taskName = "pippo";
			// Class.forName("com.mysql.jdbc.Driver");
			// dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
			// Statement statement = dbconn.createStatement();
			// Statement statement1 = dbconn.createStatement();
			// Statement statement2 = dbconn.createStatement();
			// String q = "Select distinct(Clock_Name), Is_Enabled from vw_exposed_clock_status_polling_info where Polling_Task="+taskId;
			// ResultSet rs = statement.executeQuery(q);
			// String q2;
			// ResultSet rs2;
			//String pippo = "pippo";
			
			//TaskObject taskObj = new TaskObject(taskId, taskName);
			
			// int i = 0;
			// while(rs.next())
			// {
				// taskObj.addClock(rs.getString("Clock_Name"), 1, rs.getInt("Is_Enabled"));
				// q2 = "Select Parameter_Name, Is_Enabled from vw_exposed_clock_status_polling_info where Polling_Task='"+taskId+"' and Clock_Name='"+rs.getString("Clock_Name")+"'";
				// rs2 = statement2.executeQuery(q2);
				// while(rs2.next())
				// {
					// taskObj.getClock(i).AddParameter(rs2.getString("Parameter_Name"), rs2.getInt("Is_Enabled"));
				// }
				// i++;
			// }
			//dbconn.close();
			// //session.setAttribute("savedTask", taskObj);

			
			//RequestDispatcher rd = request.getRequestDispatcher("/dms/ViewPollingTask.jsp?param1=17");
			//rd.include(request, response);
			//response.sendRedirect("ViewPollingTask.jsp?param1=17");
			//getServletContext().getRequestDispatcher("../../ViewPollingTask.jsp").forward(request, response); 
			//rd.include(request, response);
			
			//theBean = DataBean.getBean(request,beanClassName); 
			//request.setAttribute("myBean"),theBean); 
			
			//ServletContext sc = this.getServletContext();
			//String text = null;
			// String text = (String)request.getAttribute("servletName");
			// String text2 = "RISPOSTADAJSP";
			// if ((text.compareTo(text2) == 0))
			// {
				// request.setAttribute("servletName", "servletToJsp_2");
				// RequestDispatcher rd = request.getRequestDispatcher("esempio2.jsp");
				// rd.forward(request, response);
			// }
			// else
			// {
				//request.setAttribute("servletName", "servletToJsp");
				TaskObject taskObj = (TaskObject)session.getAttribute("savedTask");
				//TaskObject taskObj2 = new TaskObject(3, "plutone");
				//taskObj2 = (TaskObject)session.getAttribute("savedTask");
				request.setAttribute("savedTask", taskObj);
				RequestDispatcher rd = request.getRequestDispatcher("esempio2.jsp");
				rd.forward(request, response);
			// }			
			//request.getRequestDispatcher("/esempio.jsp").include(request, response); 
			
			//getServletContext().getRequestDispatcher("ViewPollingTask.jsp").forward(request, response); 
		//} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		//} 
		//catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		//}	
	}
}