<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- HTML -->
<html>
<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />
<head>
</head>
<body>
<%
	out.println("<input type='radio' name='measTypeGroup' id='timetype' value='1' onclick=UpdateSetups(1); checked disabled/>Time Interval");
	out.println("<input type='radio' name='measTypeGroup' id='freqtype' value='2' onclick=UpdateSetups(2); disabled/>Frequency");
%>

</body>
</html>

<script>
function UpdateSetups(type)
{
	$('#setupsSelect').load('SetupsView.jsp?meastype='+type, function(){
		document.getElementById("setupSelect").disabled = false;
		document.getElementById("setupSelect").selectedIndex = 1;
		if (document.getElementById("setupSelect").length > 1)
		{
			EnableParams();
		}
		else
		{
			document.getElementById("setupParams").style.visibility = 'hidden';
			document.getElementById("buttonsDiv").style.visibility = 'hidden';
		}
	});
}
</script>
<script>
function UpdateParams()
{
	if (document.getElementById("freqtype").checked)
	{
		document.getElementById("gateTimeParam").disabled = false;
		document.getElementById("freqarm").checked = true; 
	}
	else
	{
		document.getElementById("gateTimeParam").disabled = true;
		document.getElementById("timearm").checked = true; 
	}
	if (document.getElementById("inputatriggerLevel").value == "1.00")
	{
		document.getElementById("inputatriggerLevel").value = "0.00";
	}
	else
	{
		document.getElementById("inputatriggerLevel").value = "1.00";
	}
	if (document.getElementById("inputbtriggerLevel").value == "1.00")
	{
		document.getElementById("inputbtriggerLevel").value = "0.00";
	}
	else
	{
		document.getElementById("inputbtriggerLevel").value = "1.00";
	}	
}
</script>
