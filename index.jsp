<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.io.*"%>
<%@ page import="dmsmanager.DmsMng"%> 
<%@ page import="dbmanager.DBConnectionManager"%> 

<!-- HTML -->
<%
	if(session.getAttribute("sess_auth") == null){
		response.sendRedirect("login.jsp");
	}

	session.setAttribute("db_user", DmsMng.dbuser);
	session.setAttribute("db_pwd", DmsMng.dbpwd);
	session.setAttribute("db_ip", DmsMng.dbHostIp);
	session.setAttribute("db_name", DmsMng.dbName);
	session.setAttribute("host_ip", DmsMng.webHostIp);
	
	String everything = "";
	
	//File name = new File("./webapps/dms/dbconfig.txt");
	//BufferedReader br = new BufferedReader(new FileReader(name));
    //try {
    //    StringBuilder sb = new StringBuilder();
    //    String line = br.readLine();
	//	line = br.readLine();
	//	session.setAttribute("db_name", line);
    //   line = br.readLine();
	//	line = br.readLine();
	//	session.setAttribute("db_ip", line);
    //    if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
	//	if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
    //} finally {
    //    br.close();
    //}	
%>
<html>
<%
	//out.println(name_db);
	//out.println(ip_db);
%>
<head>
<!-- STYLE -->
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<title>INRIM Web DMS</title>	
<%
	out.println("<link rel='shortcut icon' href='http://"+session.getAttribute("host_ip")+":8080/immagini/faviconINRIM2.ico'>");
%>
<link rel="shortcut icon" href="immagini/faviconINRIM.ico">
</head>

<body id="dt_example" onload="loadTable();" class="ex_highlight_row">

<jsp:useBean id="dbsession" scope="session" class="dbmanager.DBConnectionManager" />
<%session.setAttribute("sess_dbconn", dbsession);%>

	<table width=100%>
		<tr>
			<td>
			<img src='immagini/INRIM_logo.jpg' width="200" style="padding-left:2px;padding-top:2px;"/>
			</td>
			<td align="right" style="padding-right:20px;font:Verdana;font-size:14px;color:black;">
				<div id = "timestamp" >
				</div>
				Welcome <% out.println(session.getAttribute("sess_user")); %>
				<br>
				<a href="login.jsp">logout</a>
				<br>
				<font color="white"> Version: 2.0 </font>
				<br>
				<font color="blue"> Session ID: <% out.println(session.getId()); %>
				<br>
				DB IP: <% out.println(session.getAttribute("db_ip")); %> - DB schema: <% out.println(session.getAttribute("db_name")); %> 
				</font>
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td align = "right" style="padding-right:20px;font:Verdana;font-size:14px;color:black;">
			</td>
		</tr>
	</table>
		
	<!-- the tabs --> 
	<ul class="tabs">  
		<li><a href="#">Data Access</a></li>
		<%
		if ((session.getAttribute("sess_user")).equals("admin"))
		{
			out.println("<li><a href='#'>Manual Execution</a></li>");
			out.println("<li><a href='#'>Configure</a></li>");
			out.println("<li><a href='#'>Events Log</a></li>");
			out.println("<li><a href='#'>PLC Alarms</a></li>");
		}
		%>
	</ul> 

	<div class="panes" align="center"> 
		<div id="container1" align="left">
		</div>
		<%
			if ((session.getAttribute("sess_user")).equals("admin"))
			{
				out.println("<div id='container2' align='left'>");
				out.println("</div>");
				out.println("<div id='container3' align='left'>");	
				out.println("</div>");
				out.println("<div id='container4' align='left'>");	
				out.println("</div>");
				out.println("<div id='container5' align='left'>");	
				out.println("</div>");
			}
		%>
	</div>
</body>

<!-- SCRIPT -->
<script type="text/javascript" language="javascript" src="datatables/js/jquery.js"></script>
<script type="text/javascript" language="javascript" src="datatables/js/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="datatables/js/jquery.tools.min.js"></script>
<!--[if IE]><script language="javascript" type="text/javascript" src="datatables/js/excanvas.min.js"></script><![endif]-->

<script type="text/javascript" charset="utf-8">
$(function() { 
    $("ul.tabs").tabs("div.panes > div"); 
});
</script>
<script type="text/javascript" charset="utf-8">
(function(){
  var bsa = document.createElement('script');
     bsa.type = 'text/javascript';
     bsa.async = true;
     bsa.src = '//s3.buysellads.com/ac/bsa.js';
  (document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(bsa);
})();
</script>
<script type="text/javascript" charset="utf-8">
	function loadTable(){
		$('#container1').load('ChooseViewTable.jsp');
		$('#container2').load('ManualExecution.jsp');
		$('#container3').load('Configure.jsp');
		$('#container4').load('EventLogView.jsp');
		//$('#container5').load('PLCAlarmView.jsp');
	}
</script>
<script>
function checkSessionTimeout()
{
}
</script>
<script type="text/javascript" charset="utf-8">
function getTime() {
	var currentTime = new Date();
	var month = currentTime.getMonth() + 1;
	var day = currentTime.getDate();
	var year = currentTime.getFullYear();
	var h = currentTime.getHours();
	if (h<=9) h = "0"+h;
	var m = currentTime.getMinutes();
	if (m<=9) m = "0"+m;
	var s = currentTime.getSeconds();
	if (s<=9) s = "0"+s;
	document.getElementById("timestamp").innerHTML = day + "/" + month + "/" + year + " " + h + "." + m + "." + s;
	setTimeout("getTime()",1000);
};
</script>

</html>




