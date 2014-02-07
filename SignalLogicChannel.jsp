<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="dbmanager.DBConnectionManager"%> 

<!-- HTML -->
<html>
<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />
<head>
</head>
<body>
<%
	Connection dbconn = null;
	
	String signalId = request.getParameter("signalid");
		
	dbconn = ((DBConnectionManager)(session.getAttribute("sess_dbconn"))).getDBConnection();
	
	//Query estrazione dati
	Statement statement = dbconn.createStatement();
	String q = "SELECT Logical_Channel FROM vw_exposed_signal_info where ID ="+signalId;
	ResultSet rs = statement.executeQuery(q);
	while(rs.next())
	{
		out.println(rs.getInt("Logical_Channel"));
	}
	rs.close();
	statement.close();
%>

</body>
</html>
