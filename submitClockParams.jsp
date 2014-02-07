<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<html>
<body>

<b>Parameters:</b><br>

<%
	String user_db = "";
	String pwd_db = "";
	String ip_db = "";
	Connection dbconn = null;
	user_db = DmsMng.dbuser;
	pwd_db = DmsMng.dbpwd;
	ip_db = DmsMng.dbHostIp;
	String name_db = DmsMng.dbName;
	
	//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
	//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
	
	String poolid = request.getParameter("poolid").toString();

	String binaryParams = request.getParameter("binparam").toString();
	int num_param = 0;
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
	
	Statement stmt = dbconn.createStatement();
	String sql = "select ID, Polling_Task, Paramenter_ID, Is_Enabled exp_vw_clock_status_pools_info where ID = and Polling_Task = and Is_Enabled = 1";
	ResultSet rs = stmt.executeQuery(sql);
	
	String clocksQuery = "";
	String paramsQuery = "";
	Enumeration<String> enumeration = request.getParameterNames();
	String paramclock = "";
	while (enumeration.hasMoreElements()) {
		paramclock = (String) enumeration.nextElement();
		StringTokenizer st = new StringTokenizer(paramclock, "^");
		if (st.hasMoreTokens())
		{
			String parameter = st.nextToken();
			out.println(parameter);
			String clock = st.nextToken();
			out.println(clock);

			sql = "update vw_exposed_clock_status_polling_config set Is_Enabled = 1 where Clock_Name='"+clock+"' and Parameter_Name='"+parameter+"'";
			out.println(sql);
			stmt.executeUpdate(sql);
		}
		//while (st.hasMoreTokens()) 
		//{
			//String parameter = st.nextToken();
			//out.println(parameter);
			//parameter = parameter.substring(6);
			//String clock = st.nextToken();
			//out.println(clock);
			//sql = "update vw_exposed_clock_status_polling_info set Is_Enabled = 1 where Polling_Task="+task+" and Clock_Name="+clockName+" and Parameter_Name="+paramName;
			//sql = "update vw_exposed_clock_status_polling_config set Is_Enabled = 1 where Clock_Name='"+clock+"' and Parameter_Name='"+parameter+"'";
			//stmt.executeUpdate(sql);
		//}
		//stmt.close();
		//dbconn.close();
		//out.println(paramclock);
		//out.println("<br>--------------<br>");
	}
	stmt.close();
	dbconn.close();
	// Enumeration requestParameters = request.getParameter(clockname).getParameterValues();
	// while (requestParameters.hasMoreElements()) {
		// String element = (String) requestParameters.nextElement();
		// String value = request.getParameter(element);
		// out.println(value+"<br>");
	// }
	// out.println("<br>");
	
	// String parameterName = (String) enumeration.nextElement();
	// Enumeration enumeration2 = enumeration.nextElement().getParameterValues();
	// while (enumeration2.hasMoreElements()
	// {
		// String parameterValue = (String) enumeration2.nextElement();
		// out.println(parameterName+"<br>");
	// }
	
	// if (parameterName.startsWith("clock_"))
	// {
		// clocksQuery = clocksQuery + parameterName.substring(6) + " - ";
	// }
	// else if (parameterName.startsWith("param_"))
	// {
		//parameterName = parameterName.substring(7);
		// paramsQuery = paramsQuery + parameterName.substring(7) + " - ";
	// }
	//out.println(parameterName+"<br>");
//}

// out.println(clocksQuery);
// out.println("<br>");
// out.println(paramsQuery);
// String[] checkboxNamesList = request.getParameterValues("clock_elem");
// out.println(request.getParameterValues(checkboxNamesList[0]));
// for (int i = 0; i < checkboxNamesList.length; i++) 
// {
    // String myCheckBoxValue = request.getParameterValues(checkboxNamesList[i]);

    //if null, it means checkbox is not in request, so unchecked 
    // if (myCheckBoxValue == null)
        // writer.append(checkboxNamesList[i] + "=unchecked");

    //if is there, it means checkbox checked
    // else
        // writer.append(checkboxNamesList[i] + "=checked");
// }

%>
</body></html>