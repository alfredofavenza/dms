<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="dmsmanager.DmsMng"%> 
<!-- STYLE -->


<!-- HTML -->
<html>
<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />
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
	Statement statement3 = dbconn.createStatement();
	String poolid = request.getParameter("param1");
	String poolname ="";
	int poolScheduleID = 0;
	String selected = "";

	String q2 = "SELECT * FROM exp_vw_env_monitoring_polling_pools where ID="+poolid;
	ResultSet rs2 = statement2.executeQuery(q2);
	if (rs2.next())
	{
		poolname = rs2.getString("Polling Description");
		poolScheduleID = rs2.getInt("Polling Schedule");
	}
	String q1 = "Select * from exp_vw_pool_task_schedule where Schedule_ID="+poolScheduleID;
	ResultSet rs = statement.executeQuery(q1);
	rs.next();
%>
<table width="100%">
	<tr>
		<td align="left">
			Polling task: <b><%out.println(poolname);%></b> | Schedule
		</td>
		<td align="right">
			<%
				out.println("<a href='#' onclick='Env_EditPoolSchedule("+poolid+");'>Edit</a>");
			%>
			|
			<%
				out.println("<a href='#' onclick='Env_CloseViewPoolSchedule();'>Back</a>");
			%>
		</td>
	</tr>
</table>
<br>

<table id="viewEnvParamsPoolSchedule">
	<%
	int j;
	out.println("<tr class='label'>");
		out.println("<td>Start Date: </td>");
		out.println("<td>Start Hour: </td>");
		out.println("<td>Start Minute: </td>");
	out.println("</tr>");	
	out.println("<tr class='text'>");
		if (rs.getTimestamp("Start_Date") != null)
		{
			String startdate = new SimpleDateFormat("YYYY-MM-dd").format(rs.getTimestamp("Start_Date"));
			out.println("<td valign='top'>");
				out.println("<div class='demo'>");
					out.println("<input class='custominput' id='env_datepickerStartDate' onChange='Env_checkNullDate()' onClick='Env_setBackground()' type='text' value="+startdate+" disabled />");
			    out.println("</div>");
		    out.println("</td>");
		}
		else
		{
			out.println("<td valign='top'>");
				out.println("<div class='demo'>");
					out.println("<input class='custominput' id='env_datepickerStartDate' onChange='Env_checkNullDate()' onClick='Env_setBackground()' type='text' disabled />");
   		 		out.println("</div>");
			out.println("</td>");
		}
		out.println("<td align='left' valign='top'>");
			out.println("<select class='custominput' name='env_poolScheduleViewStartHour' id='env_poolScheduleViewStartHour' disabled>");			
			    if (rs.getObject("Start_Hour") == "") out.println("<option value='' selected>now</option>");
				else out.println("<option value=''>now</option>");
				for (j = 0; j < 24; j++)
				{
					if (j == rs.getInt("Start_Hour")) selected = "selected";
					if (j==0) out.println("<option value='"+j+"' "+selected+">00</option>");
					else if (j==1) out.println("<option value='"+j+"' "+selected+">01</option>");
					else if (j==2) out.println("<option value='"+j+"' "+selected+">02</option>");
					else if (j==3) out.println("<option value='"+j+"' "+selected+">03</option>");
					else if (j==4) out.println("<option value='"+j+"' "+selected+">04</option>");
					else if (j==5) out.println("<option value='"+j+"' "+selected+">05</option>");
					else if (j==6) out.println("<option value='"+j+"' "+selected+">06</option>");
					else if (j==7) out.println("<option value='"+j+"' "+selected+">07</option>");
					else if (j==8) out.println("<option value='"+j+"' "+selected+">08</option>");
					else if (j==9) out.println("<option value='"+j+"' "+selected+">09</option>");
					else out.println("<option value='"+j+"' "+selected+">"+j+"</option>");
					selected = "";
				}
			out.println("</select>");
		out.println("</td>");
		out.println("<td align='left' valign='top'>");
			out.println("<select class='custominput' name='env_poolScheduleViewStartMinute' id='env_poolScheduleViewStartMinute' disabled>");
				if (rs.getObject("Start_Minute") == null) out.println("<option value='' selected>now</option>");
				else out.println("<option value=''>now</option>");
			    for (j = 0; j < 60; j++)
				{
			    	if (j == rs.getInt("Start_Minute")) selected = "selected";
			    	if (j==0) out.println("<option value='"+j+"' "+selected+">00</option>");
			    	else if (j==1) out.println("<option value='"+j+"' "+selected+">01</option>");
					else if (j==2) out.println("<option value='"+j+"' "+selected+">02</option>");
					else if (j==3) out.println("<option value='"+j+"' "+selected+">03</option>");
					else if (j==4) out.println("<option value='"+j+"' "+selected+">04</option>");
					else if (j==5) out.println("<option value='"+j+"' "+selected+">05</option>");
					else if (j==6) out.println("<option value='"+j+"' "+selected+">06</option>");
					else if (j==7) out.println("<option value='"+j+"' "+selected+">07</option>");
					else if (j==8) out.println("<option value='"+j+"' "+selected+">08</option>");
					else if (j==9) out.println("<option value='"+j+"' "+selected+">09</option>");
					else out.println("<option value='"+j+"' "+selected+">"+j+"</option>");
			    	selected = "";
				}
			out.println("</select>");
		out.println("</td>");	
	out.println("</tr>");
	out.println("<tr class='label'>");
		out.println("<td>Schedule Type: </td>");
		out.println("<td>Hour: </td>");
		out.println("<td>Minute: </td>");
	out.println("</tr>");
	out.println("<tr class='text'>");
		out.println("<td>");
			out.println("<select class='custominput' name='env_poolScheduleViewExecution' id='env_poolScheduleViewExecution' disabled>");
				if (rs.getString("Execution_Type").equals("every"))
					out.println("<option value='every' selected>every</option>");
				else
					out.println("<option value='every'>every</option>");
				if (rs.getString("Execution_Type").equals("at every"))
					out.println("<option value='at every' selected>at every</option>");
				else
					out.println("<option value='at every'>at every</option>");
			out.println("</select>");
		out.println("</td>");	
		out.println("<td>");
			out.println("<select class='custominput' name='env_poolScheduleViewEveryHours' id='env_poolScheduleViewEveryHours' disabled>");
				if (rs.getObject("Hour") == null)
					out.println("<option value='' selected></option>");
				else
					out.println("<option value=''></option>");
				if ((rs.getObject("Hour") != null) && (rs.getInt("Hour") == 0))
					out.println("<option value='0' selected>0</option>");
				else
					out.println("<option value='0'>0</option>");
				if (rs.getInt("Hour") == 1)
					out.println("<option value='1' selected>1</option>");
				else
					out.println("<option value='1'>1</option>");
				if (rs.getInt("Hour") == 2)
					out.println("<option value='2' selected>2</option>");
				else
					out.println("<option value='2'>2</option>");
				if (rs.getInt("Hour") == 3)
					out.println("<option value='3' selected>3</option>");
				else
					out.println("<option value='3'>3</option>");
				if (rs.getInt("Hour") == 4)
					out.println("<option value='4' selected>4</option>");
				else
					out.println("<option value='4'>4</option>");
				if (rs.getInt("Hour") == 5)
					out.println("<option value='5' selected>5</option>");
				else
					out.println("<option value='5'>5</option>");
				if (rs.getInt("Hour") == 6)
					out.println("<option value='6' selected>6</option>");
				else
					out.println("<option value='6'>6</option>");
				if (rs.getInt("Hour") == 7)
					out.println("<option value='7' selected>7</option>");
				else
					out.println("<option value='7'>7</option>");
				if (rs.getInt("Hour") == 8)
					out.println("<option value='8' selected>8</option>");
				else
					out.println("<option value='8'>8</option>");
				if (rs.getInt("Hour") == 9)
					out.println("<option value='9' selected>9</option>");
				else
					out.println("<option value='9'>9</option>");
				for (j = 10; j <= 24; j++)
				{
					if (j == rs.getInt("Hour"))
						out.println("<option value='"+j+"' selected>"+j+"</option>");
					else
						out.println("<option value='"+j+"'>"+j+"</option>");
				}
			out.println("</select>");
		out.println("</td>");
		out.println("<td>");
			out.println("<select class='custominput' name='env_poolScheduleViewEveryMinute' id='env_poolScheduleViewEveryMinute' disabled>");
				if (rs.getObject("Minute") == null)
					out.println("<option value='' selected></option>");
				else
			   		out.println("<option value=''></option>");
				if ((rs.getObject("Minute") != null) && (rs.getInt("Minute") == 0))
					out.println("<option value='0' selected>0</option>");
				else
				if (rs.getInt("Minute") == 1)
					out.println("<option value='1' selected>1</option>");
				else
					out.println("<option value='1'>1</option>");
				if (rs.getInt("Minute") == 2)
					out.println("<option value='2' selected>2</option>");
				else
					out.println("<option value='2'>2</option>");
				if (rs.getInt("Minute") == 3)
					out.println("<option value='3' selected>3</option>");
				else
					out.println("<option value='3'>3</option>");
				if (rs.getInt("Minute") == 4)
					out.println("<option value='4' selected>4</option>");
				else
					out.println("<option value='4'>4</option>");
				if (rs.getInt("Minute") == 5)
					out.println("<option value='5' selected>5</option>");
				else
					out.println("<option value='5'>5</option>");
				if (rs.getInt("Minute") == 6)
					out.println("<option value='6' selected>6</option>");
				else
					out.println("<option value='6'>6</option>");
				if (rs.getInt("Minute") == 7)
					out.println("<option value='7' selected>7</option>");
				else
					out.println("<option value='7'>7</option>");
				if (rs.getInt("Minute") == 8)
					out.println("<option value='8' selected>8</option>");
				else
					out.println("<option value='8'>8</option>");
				if (rs.getInt("Minute") == 9)
					out.println("<option value='9' selected>9</option>");
				else
					out.println("<option value='9'>9</option>");
				for (j = 10; j <= 60; j++)
				{
					if (j == rs.getInt("Minute"))
						out.println("<option value='"+j+"' selected>"+j+"</option>");
					else
						out.println("<option value='"+j+"'>"+j+"</option>");
				}
			out.println("</select>");
		out.println("</td>");
	out.println("</tr>");
	out.println("<tr class='label'>");
		out.println("<td>Enabled: </td>");
		out.println("<td>Execution Time: </td>");
	out.println("</tr>");	
	out.println("<tr class='text'>");
		out.println("<td>");
		String checked = "";
		if (rs.getInt("Is_Enabled") == 1)
		{
			out.println("<input id='env_taskpoolenabled' type='checkbox' checked disabled>");
		}
		else
		{
			out.println("<input id='env_taskpoolenabled' type='checkbox' disabled>");
		}
		out.println("</td>");
		if (rs.getDate("Execution_Time") != null)
		{
			String nextexec = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(rs.getTimestamp("Execution_Time"));
			out.println("<td valign='top'><font color='grey'>"+nextexec+"</font></td>");
		}
		else
		{
			out.println("<td valign='top'>-</td>");	
		}
	out.println("</tr>");
	%>
</table>
<br>
<table>
	<tr>
		<!--<td><div id="env_poolScheduleBack"><input type="button" value="Back" onclick="CloseViewPoolSchedule();"/></div></td>-->
		<td>
			<div id="env_poolScheduleOk">
				<%
				out.println("<input type='button' value='Apply' onClick=Env_OkEditPoolSchedule('"+poolid+"','"+poolScheduleID+"','"+ip_host+"');>");
				%>
			</div>
		</td>
		<td>
			<div id="env_poolScheduleCancel">
				<%
				out.println("<input type='button' value='Cancel' onclick='Env_CancelEditPoolSchedule("+poolid+", "+poolScheduleID+");'/>");
				%>
			</div>
		</td>
	</tr>
</table>

</body>


<!-- SCRIPT -->
<script>
	document.getElementById("env_poolScheduleOk").style.display = 'none';
	document.getElementById("env_poolScheduleCancel").style.display = 'none';
</script>

<script>
	function Env_checkNullDate()
	{
		if (document.getElementById("env_datepickerStartDate").value == "")
		{
			document.getElementById("env_poolScheduleViewStartHour").disabled = true;
			document.getElementById("env_poolScheduleViewStartHour").selectedIndex = 1;
			
			document.getElementById("env_poolScheduleViewStartMinute").disabled = true;
			document.getElementById("env_poolScheduleViewStartMinute").selectedIndex = 1;
		}
		else
		{
			document.getElementById("env_poolScheduleViewStartHour").disabled = false;
			document.getElementById("env_poolScheduleViewStartHour").selectedIndex = 0;
			
			document.getElementById("env_poolScheduleViewStartMinute").disabled = false;
			document.getElementById("env_poolScheduleViewStartMinute").selectedIndex = 0;
		}
	}
</script>
<script>
	//$(function() {
	//	$( "#env_datepickerStartDate" ).datepicker({dateFormat: 'yy-mm-dd'});
	//});
	$(function() {
		$( "#env_datepickerStartDate" ).datepicker(
		{
			dateFormat: 'yy-mm-dd',
			minDate: new Date(Date.now())
		});
	});
</script>
<script>
	function Env_setBackground()
	{
		document.getElementById("env_datepickerStartDate").style.backgroundColor = "#f1f1f1";
	}
</script>
<script type="text/javascript" charset="utf-8">
	function Env_EditPoolSchedule(poolScheduleID){
		document.getElementById("env_poolScheduleOk").style.display = 'block';
		document.getElementById("env_poolScheduleCancel").style.display = 'block';
		document.getElementById("env_datepickerStartDate").disabled = false;
		if (document.getElementById("env_datepickerStartDate").value != "")
		{
			document.getElementById("env_poolScheduleViewStartHour").disabled = false;
			document.getElementById("env_poolScheduleViewStartMinute").disabled = false;
		}
		document.getElementById("env_poolScheduleViewExecution").disabled = false;
		document.getElementById("env_poolScheduleViewEveryHours").disabled = false;
		document.getElementById("env_poolScheduleViewEveryMinute").disabled = false;
		document.getElementById("env_taskpoolenabled").disabled = false;
	}
</script>
<script type="text/javascript" charset="utf-8">
	function Env_CancelEditPoolSchedule(poolid, poolScheduleID){
		var random = new Date().getTime();
		document.getElementById("env_poolScheduleOk").style.display = 'none';
		document.getElementById("env_poolScheduleCancel").style.display = 'none';
		document.getElementById("env_datepickerStartDate").disabled = true;
		document.getElementById("env_poolScheduleViewStartHour").disabled = true;
		document.getElementById("env_poolScheduleViewStartMinute").disabled = true;
		document.getElementById("env_taskpoolenabled").disabled = true;
		document.getElementById("env_poolScheduleViewEveryHours").disabled = true;
		document.getElementById("env_poolScheduleViewEveryMinute").disabled = true;
		$('#elemento5').load('ViewEnvParamsTaskPoolSchedule.jsp?param1='+poolid, "randvar="+random);
	}
</script>
<script type="text/javascript" charset="utf-8">
	function Env_OkEditPoolSchedule(poolid, poolScheduleID, host_ip){
		var random = new Date().getTime();
		var startdate = document.getElementById("env_datepickerStartDate").value;
		var starthour = document.getElementById("env_poolScheduleViewStartHour").value;
		var startminute = document.getElementById("env_poolScheduleViewStartMinute").value;
		var executiontype = document.getElementById("env_poolScheduleViewExecution").value;
		var hour = document.getElementById("env_poolScheduleViewEveryHours").value;
		var minute = document.getElementById("env_poolScheduleViewEveryMinute").value;
		var enabled;
		if (document.getElementById("env_taskpoolenabled").checked) enabled = 1;
		else enabled = 0;	
		$.get('http://'+host_ip+':8080/dms/UpdatePoolScheduleServlet?scheduleid='+poolScheduleID+'&startdate='+startdate+'&starthour='+starthour+'&startminute='+startminute+'&executiontype='+executiontype+'&hour='+hour+'&minute='+minute+'&enabled='+enabled+'&randvar='+random, 
			function(data)
			{
				if (data == "none")
				{
					$('#elemento5').load('ViewEnvParamsTaskPoolSchedule.jsp?param1='+poolid, "randvar="+random);
				}
				else
				{
					alert(data);
					//$('#elemento5').load('ViewTaskPoolSchedule.jsp?param1='+poolid, "randvar="+random);
				}
			}
		);
		
	}
</script>

<script>
function Env_CreateTaskSecondStage(ip_host)
{
    var stageCode = 1;
	var taskId;
			
	alert("New task created (stage 2)");+
	$('#tabs-5').load('EnvParamsView.jsp?randvar='+random);
}
</script>
<script>
	function Env_CloseViewPoolSchedule()
	{
		$('#tabs-5').load('EnvParamsView.jsp?randvar='+random);
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

</html>