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
			Polling schedule information for task: <b><%out.println(taskName);%></b>
		</td>
		<td align="right">
			<%
				out.println("<a href='#' onclick='modificaJobSchedule("+taskid+","+jobid+");'>Edit</a>");
			%>
		</td>
	</tr>
</table>
<br>

<table id="viewsjobschedule">
	<%
	int j;
	out.println("<tr class='label'>");
		out.println("<td>Start Date: </td>");
		out.println("<td>Start Time: </td>");
		//out.println("<td>Start Time: </td>");
		//out.println("<td>Start Minute: </td>");
		out.println("<td>Every Hours: </td>");
		out.println("<td>Enabled: </td>");
	out.println("</tr>");
	out.println("<tr class='text'>");
		String startdate = new SimpleDateFormat("YYYY/MM/dd").format(rs.getTimestamp("Start_Date"));
		out.println("<td valign='top'><input id='jobScheduleViewStartDate' type='text' class='custominput' maxlength='45' value='"+startdate+"' disabled/></td>");
		out.println("<td valign='top'><input id='jobScheduleViewStartDate' type='text' class='custominput' maxlength='25' value='"+rs.getInt("Start_Hour")+":"+rs.getInt("Start_Minute")+"' disabled/></td>");
		
		// out.println("<td valign='top'><select class='custominput' name='jobScheduleViewStartHour' id='jobScheduleViewStartHour' disabled>");
			// String s_hour = "";
			// out.println("<option value=''></option>");
			// if (rs.getInt("Start_Hour") == 0)
				// //out.println("<option value='00' selected>00</option>");
				// s_hour = "00";
			// else
				// //out.println("<option value='00'>00</option>");
				// s_hour = "00";
			// if (rs.getInt("Start_Hour") == 1)
				// //out.println("<option value='01' selected>01</option>");
				// s_hour = "01";
			// else
				// //out.println("<option value='01'>01</option>");
				// s_hour = "01";
			// if (rs.getInt("Start_Hour") == 2)
				// //out.println("<option value='02' selected>02</option>");
				// s_hour = "02";
			// else
				// //out.println("<option value='02'>02</option>");
				// s_hour = "02";
			// if (rs.getInt("Start_Hour") == 3)
				// //out.println("<option value='03' selected>03</option>");
				// s_hour = "03";
			// else
				// //out.println("<option value='03'>03</option>");
				// s_hour = "03";
			// if (rs.getInt("Start_Hour") == 4)
				// //out.println("<option value='04' selected>04</option>");
				// s_hour = "04";
			// else
				// //out.println("<option value='04'>04</option>");
				// s_hour = "04";
			// if (rs.getInt("Start_Hour") == 5)
				// //out.println("<option value='05' selected>05</option>");
				// s_hour = "05";
			// else
				// //out.println("<option value='05'>05</option>");
				// s_hour = "05";
			// if (rs.getInt("Start_Hour") == 6)
				// //out.println("<option value='06' selected>06</option>");
				// s_hour = "06";
			// else
				// //out.println("<option value='06'>06</option>");
				// s_hour = "06";
			// if (rs.getInt("Start_Hour") == 7)
				// //out.println("<option value='07' selected>07</option>");
				// s_hour = "07";
			// else
				// //out.println("<option value='07'>07</option>");
				// s_hour = "07";
			// if (rs.getInt("Start_Hour") == 8)
				// //out.println("<option value='08' selected>08</option>");
				// s_hour = "08";
			// else
				// //out.println("<option value='08'>08</option>");
				// s_hour = "08";
			// if (rs.getInt("Start_Hour") == 9)
				// //out.println("<option value='09' selected>09</option>");
				// s_hour = "09";
			// else
				// //out.println("<option value='09'>09</option>");
				// s_hour = "09";
			// j = 0;
			// for (j = 10; j < 24; j++)
			// {
				// if (j == rs.getInt("Start_Hour"))
				// {
					// //out.println("<option value='"+j+"' selected>"+j+"</option>");
					// //s_hour = j.toString();
				// }
				// else
				// {
					// out.println("<option value='"+j+"'>"+j+"</option>");

				// }
			// }
		// out.println("</select></td>");
		// out.println("<td>");
			// out.println("<select class='custominput' name='jobScheduleViewStartMinute' id='jobScheduleViewStartMinute' value='"+rs.getInt("Start_Minute")+"' disabled>");
				// out.println("<option value=''></option>");
				// if (rs.getInt("Start_Minute") == 0)
				// out.println("<option value='00' selected>00</option>");
				// else
					// out.println("<option value='00'>00</option>");
				// if (rs.getInt("Start_Minute") == 1)
					// out.println("<option value='01' selected>01</option>");
				// else
					// out.println("<option value='01'>01</option>");
				// if (rs.getInt("Start_Minute") == 2)
					// out.println("<option value='02' selected>02</option>");
				// else
					// out.println("<option value='02'>02</option>");
				// if (rs.getInt("Start_Minute") == 3)
					// out.println("<option value='03' selected>03</option>");
				// else
					// out.println("<option value='03'>03</option>");
				// if (rs.getInt("Start_Minute") == 4)
					// out.println("<option value='04' selected>04</option>");
				// else
					// out.println("<option value='04'>04</option>");
				// if (rs.getInt("Start_Minute") == 5)
					// out.println("<option value='05' selected>05</option>");
				// else
					// out.println("<option value='05'>05</option>");
				// if (rs.getInt("Start_Minute") == 6)
					// out.println("<option value='06' selected>06</option>");
				// else
					// out.println("<option value='06'>06</option>");
				// if (rs.getInt("Start_Minute") == 7)
					// out.println("<option value='07' selected>07</option>");
				// else
					// out.println("<option value='07'>07</option>");
				// if (rs.getInt("Start_Minute") == 8)
					// out.println("<option value='08' selected>08</option>");
				// else
					// out.println("<option value='08'>08</option>");
				// if (rs.getInt("Start_Minute") == 9)
					// out.println("<option value='09' selected>09</option>");
				// else
					// out.println("<option value='09'>09</option>");
				// for (j = 10; j < 60; j++)
				// {
					// if (j == rs.getInt("Start_Minute"))
					// {
						// out.println("<option value='"+j+"' selected>"+j+"</option>");
					// }
					// else
					// {
						// out.println("<option value='"+j+"'>"+j+"</option>");
					// }
				// }
			// out.println("</select>");
		// out.println("</td>");
		
		
		
		out.println("<td>");
			out.println("<select class='custominput' name='jobScheduleViewEveryHours' id='jobScheduleViewEveryHours' disabled>");
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
		if (rs.getInt("Is_Enabled") == 1) out.println("<td valign='top'><input id='viewpollingjobenabled' type='checkbox' checked disabled/></td>");
		else out.println("<td valign='top'><input id='viewpollingjobenabled' type='checkbox' disabled/></td>");
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
<input type="button" value="Back" onclick="CloseViewJobSchedule();"/>      
</body>


<!-- SCRIPT -->
<script>
function modificaPollingJob(task,job)
{
	var random = new Date().getTime();
	$('#paramacq').load('EditPollingJob.jsp?param1='+task+'&param2='+job, "randvar="+random);
	if ((document.getElementById("querytext")) != null)
	{
		var query = document.getElementById("querytext").value;
		$('#container1').load('Visualize.jsp?param='+query+'&view_id=2', "randvar="+random);
	}
}
</script>
<script type="text/javascript" charset="utf-8">
	function modificaJobSchedule(taskid, jobid){
		var random = new Date().getTime();
		$('#elemento4').load('EditPollingJobSchedule.jsp?param1='+taskid+'&param2='+jobid, "randvar="+random);
	}
</script>
<script type="text/javascript" charset="utf-8">
	function CloseViewJobSchedule(){
		var random = new Date().getTime();
		$('#elemento4').load('ParamsAcqView.jsp', "randvar="+random);
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