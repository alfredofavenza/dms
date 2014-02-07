<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 
<%@ page import="bean.TaskObject"%> 

<html>
<head>
<link rel="stylesheet" type="text/css" href="TableTools/media/css/TableTools.css" />
<link rel="stylesheet" type="text/css" href="datatables/css/tabs.css"/>
<style type="text/css" media="screen">
    @import "datatables/css/demo_table_jui.css";
	@import "datatables/css/demo_table.css";
	@import "datatables/css/demo_page.css";
    @import "datatables/css/inrim.css";
	@import "datatables/css/site_jui.ccss";
	@import "datatables/css/jquery-ui-1.7.2.custom.css";
	@import "datatables/css/tabs.css"
	@import "TableTools/media/css/TableTools.css";
	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes example in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#example_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
</style> 
</head>
<body>
HOLA!!!
<% 
	TaskObject obj = (TaskObject)request.getAttribute("savedTask");
	if (obj != null)
	{
		out.println(obj.getTaskId());
		out.println(obj.getTaskName());
		out.println(obj.getClock(0).getClockName());
		out.println(obj.getClock(0).getParameter(0).getParameterName());
	}
	else out.println("OBJ è nullo!");	
	out.println("<a href='http://localhost:8080/dms/CreateTaskObjectServlet?taskid=22&taskname=pippo' target='ilframe'>Click2 qui</a>");	
%>
<input type="button" value="Back" onclick="BackToServlet(22,'pippo','localhost');"/>
</body>

<script type="text/javascript" charset="utf-8">
	function BackToServlet(taskid, taskname, ip_host){
		var random = new Date().getTime();		
		$.get("http://"+ip_host+":8080/dms/UpdateTaskObjectServlet?taskid='"+taskid+"'&taskname='"+taskname+"'&randvar="+random, 
				function(data) {
					alert("Back da chiamata JSP");
				}
			);
	}
</script>

</html>