<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- STYLE -->
<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />

<!-- HTML -->
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
	ResultSet rs;
%>
<div id="eventLogView">
	<table style="width:100%">
		<tr>
			<td>
				<a href="#" onClick="openTimeFilter()" id="timeFilter">[+]Select Events</a>
			</td>
			<td align="right">
				<!--<input type="button" value="New" onclick="newEventLog();"/>-->
				<a href="#" onclick="newEventLog();">New</a>
			</td>
		</tr>
	</table>
	<div id="eventLogTimeFilter" style="padding: 0px 0px 10px 45px" align="left">
	<table>
		<tr>
			<td style='padding: 0px 0px 0px 0px;'>
				<label for="dateFrom">From:</label><br>
			</td>
			<td style='padding: 0px 20px 0px 0px;'>
			    <div class="demo">
				    <input class="custominput" id="datepickerFrom" type="text">
				</div><!-- End demo -->	
			</td>
			<td>
				<select class="custominput" name="hourFrom" id="hourFrom">
					<option value=''></option>
					<option value='00'>00</option>
					<option value='01'>01</option>
					<option value='02'>02</option>
					<option value='03'>03</option>
					<option value='04'>04</option>
					<option value='05'>05</option>
					<option value='06'>06</option>
					<option value='07'>07</option>
					<option value='08'>08</option>
					<option value='09'>09</option>
					<%
						int i = 0;
						for (i = 10; i < 24; i++)
						{
							out.println("<option value='"+i+"'>"+i+"</option>");
						}
					%>
				</select>
			</td>
			<td>
			:
			</td>
			<td>
				<select class="custominput" name="minFrom" id="minFrom">
					<option value=''></option>
					<option value='00'>00</option>
					<option value='01'>01</option>
					<option value='02'>02</option>
					<option value='03'>03</option>
					<option value='04'>04</option>
					<option value='05'>05</option>
					<option value='06'>06</option>
					<option value='07'>07</option>
					<option value='08'>08</option>
					<option value='09'>09</option>
					<%
						for (i = 10; i < 60; i++)
						{
							out.println("<option value='"+i+"'>"+i+"</option>");
						}
					%>
				</select>
			</td>
			<td>
			:
			</td>
			<td>
				<select class="custominput" name="secFrom" id="secFrom">
					<option value=''></option>
					<option value='00'>00</option>
					<option value='01'>01</option>
					<option value='02'>02</option>
					<option value='03'>03</option>
					<option value='04'>04</option>
					<option value='05'>05</option>
					<option value='06'>06</option>
					<option value='07'>07</option>
					<option value='08'>08</option>
					<option value='09'>09</option>
					<%
						for (i = 10; i < 60; i++)
						{
							out.println("<option value='"+i+"'>"+i+"</option>");
						}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td style='padding: 0px 0px 0px 0px;'>
				<label for="dateTo">To:</label><br>
			</td>
			<td style='padding: 0px 20px 0px 0px;'>
			    <div class="demo">
				    <input class="custominput" id="datepickerTo" type="text">
				</div><!-- End demo -->	
			</td>
			<td>
				<select class="custominput" name="hourTo" id="hourTo">
					<option value=''></option>
					<option value='00'>00</option>
					<option value='01'>01</option>
					<option value='02'>02</option>
					<option value='03'>03</option>
					<option value='04'>04</option>
					<option value='05'>05</option>
					<option value='06'>06</option>
					<option value='07'>07</option>
					<option value='08'>08</option>
					<option value='09'>09</option>
					<%
						//int i = 0;
						for (i = 10; i < 24; i++)
						{
							out.println("<option value='"+i+"'>"+i+"</option>");
						}
					%>
				</select>
			</td>
			<td>
			:
			</td>
			<td>
				<select class="custominput" name="minTo" id="minTo">
					<option value=''></option>
					<option value='00'>00</option>
					<option value='01'>01</option>
					<option value='02'>02</option>
					<option value='03'>03</option>
					<option value='04'>04</option>
					<option value='05'>05</option>
					<option value='06'>06</option>
					<option value='07'>07</option>
					<option value='08'>08</option>
					<option value='09'>09</option>
					<%
						for (i = 10; i < 60; i++)
						{
							out.println("<option value='"+i+"'>"+i+"</option>");
						}
					%>
				</select>
			</td>
			<td>
			:
			</td>
			<td>
				<select class="custominput" name="secTo" id="secTo">
					<option value=''></option>
					<option value='00'>00</option>
					<option value='01'>01</option>
					<option value='02'>02</option>
					<option value='03'>03</option>
					<option value='04'>04</option>
					<option value='05'>05</option>
					<option value='06'>06</option>
					<option value='07'>07</option>
					<option value='08'>08</option>
					<option value='09'>09</option>
					<%
						for (i = 10; i < 60; i++)
						{
							out.println("<option value='"+i+"'>"+i+"</option>");
						}
					%>
				</select>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				Type:
			</td>
			<td>
				<select class="custominput" name="typeFilter" id="typeFilter">
					<option value=''></option>
					<%
						rs = statement.executeQuery("Select id, evtName from event_type");
						while (rs.next())
						{
							out.println("<option value='"+rs.getString("evtName")+"'>"+rs.getString("evtName")+"</option>");
						};
					%>
				</select>
			</td>
			<td style="padding:0 0 0 20">
				Severity:
			</td>
			<td>
				<select class="custominput" name="severityFilter" id="severityFilter">
					<option value=''></option>
					<%
						rs = statement.executeQuery("Select id, evsName from event_severity");
						while (rs.next())
						{
							out.println("<option value='"+rs.getString("evsName")+"'>"+rs.getString("evsName")+"</option>");
						};
					%>
				</select>
			</td>
			<td style="padding:0 0 0 20">
				Originator:
			</td>
			<td>
				<select class="custominput" name="sourceFilter" id="sourceFilter">
					<option value=''></option>
					<%
						rs = statement.executeQuery("Select username from dms_users");
						while (rs.next())
						{
							out.println("<option value='"+rs.getString("username")+"'>"+rs.getString("username")+"</option>");
						};
						rs.close();
						statement.close();
						dbconn.close();
					%>
				</select>
			</td>
		<tr>
		<tr>
			<td>
				<input type="button" value="Ok" onclick="filterEventLog()"/>
			</td>
			<td>
				<input type="button" value="Reset" onclick="resetFilterEventLog();"/>
			</td>
		</tr>
	</table>
	</div>
	<div id="demo1">
		<div id="tabsEventLog">
			<ul>
				<li id="firstTab"><a href="#eventLogTable">Event Log Viewer</a></li>
			</ul>
			<div id="eventLogTable">
			</div>
		</div>
	</div>
</div>
<!-- SCRIPT -->
<script src="datatables/css/picker/jquery-ui.min.js" type="text/javascript"></script>
<script src="datatables/css/picker/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>

<script type="text/javascript" language="javascript" src="datatables/js/jquery-ui-tabs.js"></script>
<script type="text/javascript" charset="utf-8" src="TableTools/media/js/ZeroClipboard.js"></script>
<script type="text/javascript" charset="utf-8" src="TableTools/media/js/TableTools.js"></script>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$("#tabsEventLog").tabs( {
			"show": function(event, ui) {
				var oTable = $('div.dataTables_scrollBody>table.display', ui.panel).dataTable();
				if ( oTable.length > 0 ) {
					oTable.fnAdjustColumnSizing();
				}
			}
		} );
	} );
</script>

<script>
	var random = new Date().getTime();
	$('#eventLogTable').load('EventLogTable.jsp', "rand ="+random);
	document.getElementById('secondTab').style.visibility = 'hidden';
	//document.getElementById('eventLogTableDetails').style.visibility = 'hidden';
	//document.getElementById("eventLogTableDetails").style.display = 'none'; 
</script>
<script type="text/javascript" charset="utf-8">
	function newEventLog(){	
		var random = new Date().getTime();
		if (document.getElementById("timeFilter").innerHTML == '[-]Select Events')
		{	
			document.getElementById("timeFilter").innerHTML = '[+]Select Events';
			document.getElementById("eventLogTimeFilter").style.visibility = 'hidden';
			document.getElementById("eventLogTimeFilter").style.display = 'none'; 
		}
		$('#eventLogTable').load('CreateEventLog.jsp', "rand ="+random);	
	}
</script>
<script>
	function closeDetails(){
		document.getElementById('tabo').style.visibility = 'hidden';
	}
</script>
<script type="text/javascript" charset="utf-8">
	function filterEventLog(){
		var random = new Date().getTime();
		var type = document.getElementById('typeFilter').value;
		if (type == "Time Frequency Steps") type = "TimeFrequencySteps";
		var severity = document.getElementById('severityFilter').value;
		var source = document.getElementById('sourceFilter').value;
		var df = document.getElementById('datepickerFrom').value;
		var hf = document.getElementById('hourFrom').value;
		var mf = document.getElementById('minFrom').value;
		var sf = document.getElementById('secFrom').value;
		var dt = document.getElementById('datepickerTo').value;
		var ht = document.getElementById('hourTo').value;
		var mt = document.getElementById('minTo').value;
		var st = document.getElementById('secTo').value;
		
		//var arr1 = df.split("/");
		//var arr2 = dt.split("/");
		//var date1 = new Date(arr1[2],arr1[0],arr1[1]);
		//var date2 = new Date(arr2[2],arr2[0],arr2[1]);
		var arr1 = df.split("-");
		var arr2 = dt.split("-");
		var date1 = new Date(arr1[0],arr1[1],arr1[2]);
		var date2 = new Date(arr2[0],arr2[1],arr2[2]);
		var r1 = date1.getTime();
		var r2 = date2.getTime();
		if (r1 > r2)
		{
			alert("The Start date must occur before the end date");
			document.getElementById('datepickerFrom').value = "";
			document.getElementById('datepickerTo').value = "";
		}
		else if (r1 === r2)
		{
			if (hf > ht)
			{
				alert("The Start hour must occur before the end hour");
				document.getElementById('hourFrom').value = "";
				document.getElementById('minFrom').value = "";
				document.getElementById('secFrom').value = "";
				document.getElementById('hourTo').value = "";
				document.getElementById('minTo').value = "";
				document.getElementById('secTo').value = "";
			}
			else if ((hf === ht) && (mf > mt))
			{
				alert("The Start minute must occur before the end minute");
				document.getElementById('hourFrom').value = "";
				document.getElementById('minFrom').value = "";
				document.getElementById('secFrom').value = "";
				document.getElementById('hourTo').value = "";
				document.getElementById('minTo').value = "";
				document.getElementById('secTo').value = "";
			}
			else if ((hf === ht) && (mf === mt) && (sf > st))
			{
				alert("The Start second must occur before the end second");
				document.getElementById('hourFrom').value = "";
				document.getElementById('minFrom').value = "";
				document.getElementById('secFrom').value = "";
				document.getElementById('hourTo').value = "";
				document.getElementById('minTo').value = "";
				document.getElementById('secTo').value = "";
			}
			else 
			{
				$('#eventLogTable').load('EventLogTable.jsp?dateF='+df+'&hourF='+hf+'&minF='+mf+'&secF='+sf+'&dateT='+dt+'&hourT='+ht+'&minT='+mt+'&secT='+st+'&type='+type+'&severity='+severity+'&source='+source, "rand ="+random);
			}
		}
		else 
		{
			$('#eventLogTable').load('EventLogTable.jsp?dateF='+df+'&hourF='+hf+'&minF='+mf+'&secF='+sf+'&dateT='+dt+'&hourT='+ht+'&minT='+mt+'&secT='+st+'&type='+type+'&severity='+severity+'&source='+source, "rand ="+random);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function resetFilterEventLog(){
		var random = new Date().getTime();
		var df = document.getElementById('datepickerFrom').value = "";
		var hf = document.getElementById('hourFrom').value = "";
		var mf = document.getElementById('minFrom').value = "";
		var sf = document.getElementById('secFrom').value = "";
		var dt = document.getElementById('datepickerTo').value = "";
		var ht = document.getElementById('hourTo').value = "";
		var mt = document.getElementById('minTo').value = "";
		var st = document.getElementById('secTo').value = "";
		var st = document.getElementById('typeFilter').value = "";
		var st = document.getElementById('severityFilter').value = "";
		var st = document.getElementById('sourceFilter').value = "";
		$('#eventLogTable').load('EventLogTable.jsp', "rand ="+random);
	}
</script>
<script>
	$(function() {
		$( "#datepickerFrom" ).datepicker({dateFormat: 'yy-mm-dd'});
		$( "#datepickerTo" ).datepicker({dateFormat: 'yy-mm-dd'});
	});
</script>
<script type="text/javascript" charset="utf-8">
	function Copy(){
		document.getElementById("date1").value = document.getElementById("date").value;
	}
</script>
<script type="text/javascript" charset="utf-8">
	document.getElementById("eventLogTimeFilter").style.visibility = 'hidden';
	document.getElementById("eventLogTimeFilter").style.display = 'none'; 
	function openTimeFilter()
	{
		if (document.getElementById("timeFilter").innerHTML == '[+]Select Events')
		{	
			document.getElementById("timeFilter").innerHTML = '[-]Select Events';
			document.getElementById("eventLogTimeFilter").style.visibility = 'visible';
			document.getElementById("eventLogTimeFilter").style.display = "block"; 
		}
		else
		{
			document.getElementById("timeFilter").innerHTML = '[+]Select Events';
			document.getElementById("eventLogTimeFilter").style.visibility = 'hidden';
			document.getElementById("eventLogTimeFilter").style.display = 'none'; 
		}
	}
</script>
