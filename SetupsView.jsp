<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="dmsmanager.DmsMng"%> 
<%@ page import="dbmanager.DBConnectionManager"%> 

<!-- HTML -->
<html>
<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />
<head>
</head>
<body>
<%
	String meastype = request.getParameter("meastype");
	Connection dbconn = null;
	dbconn = ((DBConnectionManager)(session.getAttribute("sess_dbconn"))).getDBConnection();
	Statement statement = dbconn.createStatement();
%>
<select class='custominput' style="width:auto" name='setupSelect' id='setupSelect' onChange="EnableParams();" disabled="disabled">
	<%
		out.println("<option value=''></option>");
		String q = "SELECT * FROM exp_vw_measurement_setups where Measurement="+meastype;
		ResultSet rs = statement.executeQuery(q);
		while(rs.next())
		{
			out.println("<option value='"+rs.getInt("ID")+"' >"+rs.getString("Setup_Description")+"</option>");
		}
	%>
</select>
<%
rs.close();
statement.close();
%>
</body>
</html>