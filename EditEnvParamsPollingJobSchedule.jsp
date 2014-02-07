<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="dmsmanager.DmsMng"%> 


<!-- HTML -->
<html>
<head>
</head>
<body>
<%
	Connection dbconn = null;
	String user_db = DmsMng.dbuser;
	String pwd_db = DmsMng.dbpwd;
	String ip_db = DmsMng.dbHostIp;
	String ip_host = DmsMng.webHostIp;
	String name_db = DmsMng.dbName;
		
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
	Statement statement = dbconn.createStatement();
	Statement statement2 = dbconn.createStatement();
	String taskid = request.getParameter("param1");
	String jobid = request.getParameter("param2");
	String q1 = "Select * from vw_exposed_clock_status_polling_job where Polling_Job="+jobid;
	ResultSet rs = statement.executeQuery(q1);
	rs.next();
	
	String q2 = "Select Polling_Name, Job from vw_exposed_clock_status_polling_task where ID='"+taskid+"'";
	ResultSet rs2 = statement2.executeQuery(q2);
	rs2.next();
	String taskName = rs2.getString("Polling_Name");
%>
<table width="100%">
	<tr>
		<td align="left">
			Edit polling schedule information for task: <b><%out.println(taskName);%></b>
		</td>
		<td align="right">
		</td>
	</tr>
</table>
<br>

<table id="env_editjobscheduletab">
	<%
	out.println("<tr class='label'>");
		out.println("<td>Start Date: </td>");
		out.println("<td>Start Hour: </td>");
		out.println("<td>Start Minute: </td>");
		out.println("<td>Every Hours: </td>");
		out.println("<td>Enabled: </td>");
	out.println("</tr>");
	out.println("<tr class='text'>");
		String startdate = new SimpleDateFormat("YYYY/MM/dd").format(rs.getTimestamp("Start_Date"));
		out.println("<td valign='top'><input id='env_jobScheduleEditStartDate' type='text' class='custominput' maxlength='45' value='"+startdate+"'/></td>");
		out.println("<td valign='top'><select class='custominput' name='env_jobScheduleEditStartHour' id='env_jobScheduleEditStartHour'>");
			out.println("<option value=''></option>");
			if (rs.getInt("Start_Hour") == 0)
				out.println("<option value='0' selected>00</option>");
			else
				out.println("<option value='0'>00</option>");
			if (rs.getInt("Start_Hour") == 1)
				out.println("<option value='1' selected>01</option>");
			else
				out.println("<option value='1'>01</option>");
			if (rs.getInt("Start_Hour") == 2)
				out.println("<option value='2' selected>02</option>");
			else
				out.println("<option value='2'>02</option>");
			if (rs.getInt("Start_Hour") == 3)
				out.println("<option value='3' selected>03</option>");
			else
				out.println("<option value='3'>03</option>");
			if (rs.getInt("Start_Hour") == 4)
				out.println("<option value='4' selected>04</option>");
			else
				out.println("<option value='4'>04</option>");
			if (rs.getInt("Start_Hour") == 5)
				out.println("<option value='5' selected>05</option>");
			else
				out.println("<option value='5'>05</option>");
			if (rs.getInt("Start_Hour") == 6)
				out.println("<option value='6' selected>06</option>");
			else
				out.println("<option value='6'>06</option>");
			if (rs.getInt("Start_Hour") == 7)
				out.println("<option value='7' selected>07</option>");
			else
				out.println("<option value='7'>07</option>");
			if (rs.getInt("Start_Hour") == 8)
				out.println("<option value='8' selected>08</option>");
			else
				out.println("<option value='8'>08</option>");
			if (rs.getInt("Start_Hour") == 9)
				out.println("<option value='9' selected>09</option>");
			else
				out.println("<option value='9'>09</option>");
			int j = 0;
			for (j = 10; j < 24; j++)
			{
				if (j == rs.getInt("Start_Hour"))
				{
					out.println("<option value='"+j+"' selected>"+j+"</option>");
				}
				else
				{
					out.println("<option value='"+j+"'>"+j+"</option>");
				}
			}
		out.println("</select></td>");
		out.println("<td>");
			out.println("<select class='custominput' name='env_jobScheduleEditStartMinute' id='env_jobScheduleEditStartMinute' value='"+rs.getInt("Start_Minute")+"'>");
				out.println("<option value=''></option>");
				if (rs.getInt("Start_Minute") == 0)
				out.println("<option value='00' selected>00</option>");
				else
					out.println("<option value='00'>00</option>");
				if (rs.getInt("Start_Minute") == 1)
					out.println("<option value='01' selected>01</option>");
				else
					out.println("<option value='01'>01</option>");
				if (rs.getInt("Start_Minute") == 2)
					out.println("<option value='02' selected>02</option>");
				else
					out.println("<option value='02'>02</option>");
				if (rs.getInt("Start_Minute") == 3)
					out.println("<option value='03' selected>03</option>");
				else
					out.println("<option value='03'>03</option>");
				if (rs.getInt("Start_Minute") == 4)
					out.println("<option value='04' selected>04</option>");
				else
					out.println("<option value='04'>04</option>");
				if (rs.getInt("Start_Minute") == 5)
					out.println("<option value='05' selected>05</option>");
				else
					out.println("<option value='05'>05</option>");
				if (rs.getInt("Start_Minute") == 6)
					out.println("<option value='06' selected>06</option>");
				else
					out.println("<option value='06'>06</option>");
				if (rs.getInt("Start_Minute") == 7)
					out.println("<option value='07' selected>07</option>");
				else
					out.println("<option value='07'>07</option>");
				if (rs.getInt("Start_Minute") == 8)
					out.println("<option value='08' selected>08</option>");
				else
					out.println("<option value='08'>08</option>");
				if (rs.getInt("Start_Minute") == 9)
					out.println("<option value='09' selected>09</option>");
				else
					out.println("<option value='09'>09</option>");
				for (j = 10; j < 60; j++)
				{
					if (j == rs.getInt("Start_Minute"))
					{
						out.println("<option value='"+j+"' selected>"+j+"</option>");
					}
					else
					{
						out.println("<option value='"+j+"'>"+j+"</option>");
					}
				}
			out.println("</select>");
		out.println("</td>");
		out.println("<td>");
			out.println("<select class='custominput' name='env_jobScheduleEditEveryHours' id='env_jobScheduleEditEveryHours'>");
				out.println("<option value=''></option>");
				if (rs.getInt("Every_Hours") == 1)
					out.println("<option value='1' selected>1</option>");
				else
					out.println("<option value='1'>1</option>");
				if (rs.getInt("Every_Hours") == 2)
					out.println("<option value='2' selected>2</option>");
				else
					out.println("<option value='2'>2</option>");
				if (rs.getInt("Every_Hours") == 3)
					out.println("<option value='3' selected>3</option>");
				else
					out.println("<option value='3'>3</option>");
				if (rs.getInt("Every_Hours") == 4)
					out.println("<option value='4' selected>4</option>");
				else
					out.println("<option value='4'>4</option>");
				if (rs.getInt("Every_Hours") == 5)
					out.println("<option value='5' selected>5</option>");
				else
					out.println("<option value='5'>5</option>");
				if (rs.getInt("Every_Hours") == 6)
					out.println("<option value='6' selected>6</option>");
				else
					out.println("<option value='6'>6</option>");
				if (rs.getInt("Every_Hours") == 7)
					out.println("<option value='7' selected>7</option>");
				else
					out.println("<option value='7'>7</option>");
				if (rs.getInt("Every_Hours") == 8)
					out.println("<option value='8' selected>8</option>");
				else
					out.println("<option value='8'>8</option>");
				if (rs.getInt("Every_Hours") == 9)
					out.println("<option value='9' selected>9</option>");
				else
					out.println("<option value='9'>9</option>");
				for (j = 10; j < 24; j++)
				{
					if (j == rs.getInt("Every_Hours"))
						out.println("<option value='"+j+"' selected>"+j+"</option>");
					else
						out.println("<option value='"+j+"'>"+j+"</option>");
				}
			out.println("</select>");
		out.println("</td>");
		if (rs.getInt("Is_Enabled") == 1) out.println("<td valign='top'><input id='env_jobScheduleEditIsEnabled' type='checkbox' checked/></td>");
		else out.println("<td valign='top'><input id='env_jobScheduleEditIsEnabled' type='checkbox'/></td>");
	out.println("</tr>");
	out.println("<tr class='label'>");
		out.println("<td>Next Execution: </td>");
	out.println("</tr>");
	out.println("<tr class='text'>");
		if (rs.getDate("Next_Execution") != null)
		{
			String nextexec = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(rs.getTimestamp("Next_Execution"));
			out.println("<td valign='top'><font color='grey'>"+nextexec+"</font></td>");
		}
		else
			out.println("<td valign='top'>-</td>");	
	out.println("</tr>");
	%>
</table>
<br>
<%
out.println("<input type='button' value='Apply' onclick=Env_modificaJobSchedule('"+taskid+"','"+jobid+"','"+ip_host+"');></input>");
out.println("<input type='button' value='Cancel' onclick=Env_CloseEditJobSchedule('"+taskid+"','"+jobid+"');></input>");
%>   
</body>


<!-- SCRIPT -->
<script>
function Env_modificaJobSchedule(task,job,ip_host)
{
	var ripetition = document.getElementById("env_jobScheduleEditEveryHours").value;
	var starth = document.getElementById("env_jobScheduleEditStartHour").value;
	var startm = document.getElementById("env_jobScheduleEditStartMinute").value;
	var startd = document.getElementById("env_jobScheduleEditStartDate").value;
	var endd = document.getElementById("env_jobScheduleEditNextExec").value;
	var enable = document.getElementById("env_jobScheduleEditIsEnabled").checked;
	$.get("http://"+ip_host+":8080/dms/UpdateJobScheduleServlet?job="+job+"&ripet="+ripetition+"&starth="+starth+"&startm="+startm+"&startd="+startd+"&endd="+endd+"&enable="+enable);		
	$('#tabs-5').load('EnvParamsView.jsp?randvar='+random);
}
</script>
<script type="text/javascript" charset="utf-8">
	function Env_CloseEditJobSchedule(task, job){
		var random = new Date().getTime();
		$('#elemento5').load('ViewPollingJob.jsp?param1='+task+'&param2='+job, "randvar="+random);
		if ((document.getElementById("querytext")) != null)
		{
			var query = document.getElementById("querytext").value;
			$('#container1').load('Visualize.jsp?param='+query+'&view_id=2', "randvar="+random);
		}
	}
</script>
<script language="JavaScript" type="text/javascript">
var NS4 = (navigator.appName == "Netscape" && parseInt(navigator.appVersion) < 5);

function Env_addOption(theSel, theText, theValue)
{
  var newOpt = new Option(theText, theValue);
  var selLength = theSel.length;
  theSel.options[selLength] = newOpt;
}

function Env_deleteOption(theSel, theIndex)
{ 
  var selLength = theSel.length;
  if(selLength>0)
  {
    theSel.options[theIndex] = null;
  }
}

function Env_moveOptions(theSelFrom, theSelTo)
{
  var selLength = theSelFrom.length;
  var selectedText = new Array();
  var selectedValues = new Array();
  var selectedCount = 0;
  
  var i;
  
  // Find the selected Options in reverse order
  // and delete them from the 'from' Select.
  for(i=selLength-1; i>=0; i--)
  {
    if(theSelFrom.options[i].selected)
    {
      selectedText[selectedCount] = theSelFrom.options[i].text;
      selectedValues[selectedCount] = theSelFrom.options[i].value;
      deleteOption(theSelFrom, i);
      selectedCount++;
    }
  }
  
  // Add the selected text/values in reverse order.
  // This will add the Options to the 'to' Select
  // in the same order as they were in the 'from' Select.
  for(i=selectedCount-1; i>=0; i--)
  {
    addOption(theSelTo, selectedText[i], selectedValues[i]);
  }
  
  if(NS4) history.go(0);
}
</script>
<script>
	$(function() {
		$("#env_jobScheduleEditStartDate").datepicker({dateFormat: 'yy-mm-dd'});
		$("#env_jobScheduleEditNextExec").datepicker({dateFormat: 'yy-mm-dd'});
	});
</script>

</html>