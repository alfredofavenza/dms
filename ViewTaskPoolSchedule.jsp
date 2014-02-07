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
	
	//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
	//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
	
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
	Statement statement = dbconn.createStatement();
	Statement statement2 = dbconn.createStatement();
	Statement statement3 = dbconn.createStatement();
	String poolid = request.getParameter("param1");
	String poolname ="";
	int poolScheduleID = 0;
	String selected = "";

	String q2 = "SELECT * FROM exp_vw_clock_status_polling_pools where ID="+poolid;
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
				out.println("<a href='#' onclick='EditPoolSchedule("+poolid+");'>Edit</a>");
			%>
			|
			<%
				out.println("<a href='#' onclick='CloseViewPoolSchedule();'>Back</a>");
			%>
		</td>
	</tr>
</table>
<br>

<table id="viewPoolschedule">
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
					out.println("<input class='custominput' id='datepickerStartDate' onChange='checkNullDate()' onClick='setBackground()' type='text' value="+startdate+" disabled />");
			    out.println("</div>");
		    out.println("</td>");
		}
		else
		{
			out.println("<td valign='top'>");
				out.println("<div class='demo'>");
					out.println("<input class='custominput' id='datepickerStartDate' onChange='checkNullDate()' onClick='setBackground()' type='text' disabled />");
   		 		out.println("</div>");
			out.println("</td>");
		}
		out.println("<td align='left' valign='top'>");
			out.println("<select class='custominput' name='poolScheduleViewStartHour' id='poolScheduleViewStartHour' disabled>");			
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
			out.println("<select class='custominput' name='poolScheduleViewStartMinute' id='poolScheduleViewStartMinute' disabled>");
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
			out.println("<select class='custominput' name='poolScheduleViewExecution' id='poolScheduleViewExecution' disabled>");
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
			out.println("<select class='custominput' name='poolScheduleViewEveryHours' id='poolScheduleViewEveryHours' disabled>");
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
			out.println("<select class='custominput' name='poolScheduleViewEveryMinute' id='poolScheduleViewEveryMinute' disabled>");
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
			out.println("<input id='taskpoolenabled' type='checkbox' checked disabled>");
		}
		else
		{
			out.println("<input id='taskpoolenabled' type='checkbox' disabled>");
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
		<!--<td><div id="poolScheduleBack"><input type="button" value="Back" onclick="CloseViewPoolSchedule();"/></div></td>-->
		<td>
			<div id="poolScheduleOk">
				<%
				out.println("<input type='button' value='Apply' onClick=OkEditPoolSchedule('"+poolid+"','"+poolScheduleID+"','"+ip_host+"');>");
				%>
			</div>
		</td>
		<td>
			<div id="poolScheduleCancel">
				<%
				out.println("<input type='button' value='Cancel' onclick='CancelEditPoolSchedule("+poolid+", "+poolScheduleID+");'/>");
				%>
			</div>
		</td>
	</tr>
</table>

</body>


<!-- SCRIPT -->
<script>
	document.getElementById("poolScheduleOk").style.display = 'none';
	document.getElementById("poolScheduleCancel").style.display = 'none';
</script>

<script>
	function checkNullDate()
	{
		if (document.getElementById("datepickerStartDate").value == "")
		{
			document.getElementById("poolScheduleViewStartHour").disabled = true;
			document.getElementById("poolScheduleViewStartHour").selectedIndex = 1;
			
			document.getElementById("poolScheduleViewStartMinute").disabled = true;
			document.getElementById("poolScheduleViewStartMinute").selectedIndex = 1;
		}
		else
		{
			document.getElementById("poolScheduleViewStartHour").disabled = false;
			document.getElementById("poolScheduleViewStartHour").selectedIndex = 0;
			
			document.getElementById("poolScheduleViewStartMinute").disabled = false;
			document.getElementById("poolScheduleViewStartMinute").selectedIndex = 0;
		}
	}
</script>
<script>
	//$(function() {
	//	$( "#datepickerStartDate" ).datepicker({dateFormat: 'yy-mm-dd'});
	//});
	$(function() {
		$( "#datepickerStartDate" ).datepicker(
		{
			dateFormat: 'yy-mm-dd',
			minDate: new Date(Date.now())
		});
	});
</script>
<script>
	function setBackground()
	{
		document.getElementById("datepickerStartDate").style.backgroundColor = "#f1f1f1";
	}
</script>
<script type="text/javascript" charset="utf-8">
	function EditPoolSchedule(poolScheduleID){
		document.getElementById("poolScheduleOk").style.display = 'block';
		document.getElementById("poolScheduleCancel").style.display = 'block';
		document.getElementById("datepickerStartDate").disabled = false;
		if (document.getElementById("datepickerStartDate").value != "")
		{
			document.getElementById("poolScheduleViewStartHour").disabled = false;
			document.getElementById("poolScheduleViewStartMinute").disabled = false;
		}
		document.getElementById("poolScheduleViewExecution").disabled = false;
		document.getElementById("poolScheduleViewEveryHours").disabled = false;
		document.getElementById("poolScheduleViewEveryMinute").disabled = false;
		document.getElementById("taskpoolenabled").disabled = false;
	}
</script>
<script type="text/javascript" charset="utf-8">
	function CancelEditPoolSchedule(poolid, poolScheduleID){
		var random = new Date().getTime();
		document.getElementById("poolScheduleOk").style.display = 'none';
		document.getElementById("poolScheduleCancel").style.display = 'none';
		document.getElementById("datepickerStartDate").disabled = true;
		document.getElementById("poolScheduleViewStartHour").disabled = true;
		document.getElementById("poolScheduleViewStartMinute").disabled = true;
		document.getElementById("taskpoolenabled").disabled = true;
		document.getElementById("poolScheduleViewEveryHours").disabled = true;
		document.getElementById("poolScheduleViewEveryMinute").disabled = true;
		$('#elemento4').load('ViewTaskPoolSchedule.jsp?param1='+poolid, "randvar="+random);
	}
</script>
<script type="text/javascript" charset="utf-8">
	function OkEditPoolSchedule(poolid, poolScheduleID, host_ip){
		var random = new Date().getTime();
		var startdate = document.getElementById("datepickerStartDate").value;
		var starthour = document.getElementById("poolScheduleViewStartHour").value;
		var startminute = document.getElementById("poolScheduleViewStartMinute").value;
		var executiontype = document.getElementById("poolScheduleViewExecution").value;
		var hour = document.getElementById("poolScheduleViewEveryHours").value;
		var minute = document.getElementById("poolScheduleViewEveryMinute").value;
		var enabled;
		if (document.getElementById("taskpoolenabled").checked) enabled = 1;
		else enabled = 0;	
		//alert(poolScheduleID+","+startdate+","+starthour+","+startminute+","+hour+","+minute);
		$.get('http://'+host_ip+':8080/dms/UpdatePoolScheduleServlet?scheduleid='+poolScheduleID+'&startdate='+startdate+'&starthour='+starthour+'&startminute='+startminute+'&executiontype='+executiontype+'&hour='+hour+'&minute='+minute+'&enabled='+enabled+'&randvar='+random, 
			function(data)
			{
				if (data == "none")
				{
					$('#elemento4').load('ViewTaskPoolSchedule.jsp?param1='+poolid, "randvar="+random);
				}
				else
				{
					alert(data);
					//$('#elemento4').load('ViewTaskPoolSchedule.jsp?param1='+poolid, "randvar="+random);
				}
			}
		);
		
	}
</script>

<script>
function CreateTaskSecondStage(ip_host)
{
    var stageCode = 1;
	var taskId;
			
	alert("New task created (stage 2)");+
	$('#tabs-4').load('ParamsAcqView.jsp?randvar='+random);
}
</script>
<script>
	function CloseViewPoolSchedule()
	{
		$('#tabs-4').load('ParamsAcqView.jsp?randvar='+random);
	}
</script>

<script language="JavaScript" type="text/javascript">
var NS4 = (navigator.appName == "Netscape" && parseInt(navigator.appVersion) < 5);

function addOption(theSel, theText, theValue)
{
  var newOpt = new Option(theText, theValue);
  var selLength = theSel.length;
  theSel.options[selLength] = newOpt;
}

function deleteOption(theSel, theIndex)
{ 
  var selLength = theSel.length;
  if(selLength>0)
  {
    theSel.options[theIndex] = null;
  }
}

function moveOptions(theSelFrom, theSelTo)
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