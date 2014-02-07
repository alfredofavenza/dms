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
	Connection dbconn = null;
	String user_db = DmsMng.dbuser;
	String pwd_db = DmsMng.dbpwd;
	String ip_db = DmsMng.dbHostIp;
	String ip_host = DmsMng.webHostIp;
	String name_db = DmsMng.dbName;
		
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
	Statement statement = dbconn.createStatement();
	String q = "Select Parameter_Name from vw_exposed_clock_status_polling_config";
	ResultSet rs = statement.executeQuery(q);
	
	Calendar currentDate = Calendar.getInstance();
	Date d = new Date(currentDate.getTime().getYear(), currentDate.getTime().getMonth(), currentDate.getTime().getDate());
	int hours = currentDate.getTime().getHours();
	int minutes =  currentDate.getTime().getMinutes();
%>

<table width="100%">
	<tr>
		<td align="left">
			Polling task | Creating new...
		</td>
		<td align="right"></td>
	</tr>
</table>
<br>
<table>
<tr class="label">
		<td align="left">
			Description:
		</td>
</tr>
<tr class="text">
		<td align="left" valign="top">
			<input class="custominput" id="env_createScheduleDescription" type="text" maxlength="100" autofocus/>
		</td>
</tr>

<tr class="label">
		<td>
			Start Date:
		</td>
		<td>
			Start Hour:
		</td>
		<td>
			Start Minute:
		</td>
</tr>
<tr class="text">
		<td align="left" valign="top">
		    <div class="demo">
		    	<%
			    out.println("<input class='custominput' id='env_createScheduleDatepicker' type='text' onChange='Env_checkNullDate()' value='"+d+"'>");
		    	%>
			</div>
		</td>
		<td>
			<select class='custominput' name='env_createScheduleStartHour' id='env_createScheduleStartHour'>
				<option value='' selected>now</option>
				<%
				String selected = "";
				for (int j = 0; j < 24; j++)
				{
					//if (j == hours) selected = "selected";
					selected = "";
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
				%>
			</select>
		</td>
		<td align="left" valign="top">
			<select class='custominput' name='env_createScheduleStartMinute' id='env_createScheduleStartMinute'>
				<option value='' selected>now</option>
				<%
				for (int j = 0; j < 60; j++)
				{
					//if (j == minutes) selected = "selected";
					selected = "";
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
				%>
			</select>
		</td>
</tr>

<tr class="label">
		<td align="left">
			Schedule Type:
		</td>
		<td>
			Hour:
		</td>
		<td>
			Minute:
		</td>
</tr>
<tr class="text">
		<td align="left" valign="top">
			<select class='custominput' name='env_createScheduleExecutionType' id='env_createScheduleExecutionType'>
				<option value='every'>every</option>
				<option value='at every' selected>at every</option>		
			</select>
		</td>
		<td align="left" valign="top">
			<select class='custominput' name='env_createScheduleHour' id='env_createScheduleHour'>
				<option value=""></option>
				<%
				for (int j = 0; j <= 24; j++)
				{
					if (j==0) out.println("<option value='"+j+"' selected>00</option>");
					else if (j==1) out.println("<option value='"+j+"' selected>1</option>");
					else if (j==2) out.println("<option value='"+j+"'>2</option>");
					else if (j==3) out.println("<option value='"+j+"'>3</option>");
					else if (j==4) out.println("<option value='"+j+"'>4</option>");
					else if (j==5) out.println("<option value='"+j+"'>5</option>");
					else if (j==6) out.println("<option value='"+j+"'>6</option>");
					else if (j==7) out.println("<option value='"+j+"'>7</option>");
					else if (j==8) out.println("<option value='"+j+"'>8</option>");
					else if (j==9) out.println("<option value='"+j+"'>9</option>");
					else out.println("<option value='"+j+"'>"+j+"</option>");
				}
				%>
			</select>
		</td>
		<td align="left" valign="top">
			<select class='custominput' name='env_createScheduleMinute' id='env_createScheduleMinute'>
				<option value=""></option>
				<%
				for (int j = 0; j <= 60; j++)
				{
					if (j==0) out.println("<option value='"+j+"' selected>00</option>");
					else if (j==1) out.println("<option value='"+j+"'>1</option>");
					else if (j==2) out.println("<option value='"+j+"'>2</option>");
					else if (j==3) out.println("<option value='"+j+"'>3</option>");
					else if (j==4) out.println("<option value='"+j+"'>4</option>");
					else if (j==5) out.println("<option value='"+j+"'>5</option>");
					else if (j==6) out.println("<option value='"+j+"'>6</option>");
					else if (j==7) out.println("<option value='"+j+"'>7</option>");
					else if (j==8) out.println("<option value='"+j+"'>8</option>");
					else if (j==9) out.println("<option value='"+j+"'>9</option>");
					else out.println("<option value='"+j+"'>"+j+"</option>");
				}
				%>
			</select>
		</td>
</tr>
<tr>
	<td>
		<br>
		<%
		out.println("<input type='button' value='Next' onclick=Env_CreateTaskFirstStage('"+ip_host+"');></input>");
		%>
		<input type="button" value="Cancel" onclick="Env_CancelTaskCreation();"/>
	</td>
</tr>
</table>
</body>

<script>
	var dayNow = new Date(dateNow.getUTCFullYear(), dateNow.getUTCMonth(), dateNow.getUTCDate());
	//var dateNow = new Date();
	var hourNow = dateNow.getHours();
	var minuteNow = dateNow.getMinutes();
	document.getElementById("env_createScheduleDatepicker").value = dayNow.getTime();
	//document.getElementById("env_createScheduleDatepicker").value = dateNow.getTime();
	document.getElementById("env_createScheduleStartHour").value = hourNow;
	document.getElementById("env_createScheduleStartMinute").value = minuteNow;
</script>
<script>
	$(function() {
		$("#env_createScheduleDatepicker").datepicker(
		{
			dateFormat: 'yy-mm-dd',
			minDate: new Date(Date.now())
		});
	});
</script>
<script>
	function Env_checkNullDate()
	{
		if (document.getElementById("env_createScheduleDatepicker").value == "")
		{
			document.getElementById("env_createScheduleStartHour").disabled = true;
			document.getElementById("env_createScheduleStartHour").selectedIndex = 1;
			
			document.getElementById("env_createScheduleStartMinute").disabled = true;
			document.getElementById("env_createScheduleStartMinute").selectedIndex = 1;
		}
		else
		{
			document.getElementById("env_createScheduleStartHour").disabled = false;
			document.getElementById("env_createScheduleStartHour").selectedIndex = 0;
			
			document.getElementById("env_createScheduleStartMinute").disabled = false;
			document.getElementById("env_createScheduleStartMinute").selectedIndex = 0;
		}
	}
</script>
<!-- SCRIPT -->
<script>
function Env_CreateTaskFirstStage(ip_host)
{
	var random = new Date().getTime();
	var description = document.getElementById("env_createScheduleDescription").value;
	var startdate = document.getElementById("env_createScheduleDatepicker").value;
	var starthour = document.getElementById("env_createScheduleStartHour").value;
	var startminute = document.getElementById("env_createScheduleStartMinute").value;
	var executiontype = document.getElementById("env_createScheduleExecutionType").value;
	var hour = document.getElementById("env_createScheduleHour").value;
	var minute = document.getElementById("env_createScheduleMinute").value;
	if (description == "")
	{
		alert("Insert a valid description for this pool");
	}
	else
	{
		$.get("http://"+ip_host+":8080/dms/CreateEnvTaskPoolServlet?description="+description+"&type="+executiontype+"&startdate="+startdate+"&starthour="+starthour+"&startminute="+startminute+"&hour="+hour+"&minute="+minute+"&randvar="+random,
			function(data)
			{
				if (data == "none")
				{
					$('#elemento5').load('ViewEnvParamsTaskPool.jsp?poolid=&poolname=&addclockactive=block');
				}
				else
				{
					$('#elemento5').load('ViewEnvParamsTaskPool.jsp?poolid='+data+'&poolname=&addclockactive=none');
				}
			}
			
		);
	}
}
</script>
<script type="text/javascript" charset="utf-8">
	function Env_CancelTaskCreation(){
		var random = new Date().getTime();
		$('#tabs-5').load('EnvParamsView.jsp?randvar='+random);
	}
</script>

</html>