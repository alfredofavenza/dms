<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- STYLE -->

<!-- HTML -->
<html>
<head>
</head>
<body>
<div id="formtitle">
New Event Log
</div>
<br>
<br>
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
<!-- <form action="insertEventLogServlet" method="POST" onsubmit="return ValidateForm();"> -->
<table id="newEventrecord">
	<tr class="label">
		<td id="eventTypeLbl">
			Type:
		</td>
		<td id="eventSeverityLbl">
			Severity:
		</td>
		<td>
			Description:
		</td>
	</tr>
	<tr class="text">
		<td valign="top">
			<select class="custominput" name="eventType" id="eventType" onClick="clearBox('eventType');" onChange="loadEventDetails(document.getElementById('eventType').value);">
				<option value=""></option>
				<%
					rs = statement.executeQuery("Select id,evtName from event_type");
					while (rs.next())
					{
						int id = rs.getInt("id");
						out.println("<option value='"+id+"' id='"+id+"'>"+rs.getString("evtName")+"</option>");
					}
				%>
			</select>
		</td>
		<td valign="top">
			<select class="custominput" name="eventSeverity" id="eventSeverity" onClick="clearBox('eventSeverity');" disabled>
				<option value=""></option>
				<%
					rs = statement.executeQuery("Select * from event_severity");
					while (rs.next())
					{
						if (rs.getString("evsName").equals("Information"))
						{
							out.println("<option value='"+rs.getString("id")+"' selected>"+rs.getString("evsName")+"</option>");
						}
						else
						{
							out.println("<option value='"+rs.getString("id")+"'>"+rs.getString("evsName")+"</option>");
						}
					}
					rs.close();
					statement.close();
					dbconn.close();
				%>
			</select>
		</td>
		<td>
			<textarea class="custominput" id="eventDescription" name="eventDescription" cols="30" rows="2" style="resize:none;"></textarea>
		</td>
	</tr>
</table>
<div id="eventDetails">
</div>
<br>
<table>
	<tr>
		<td style="padding: 0px 0px 0px 20px;">
			<%
			out.println("<input type='submit' id='ok' value='Ok' onClick=Validate('"+ip_host+"');></input>");
			%>
		</td>
		<td>
			<input type="button" id="cancel" value="Cancel" onClick="CancelEvent()"/>
		</td>
	</tr>
</table>
<!-- </form> -->
</body>


<!-- SCRIPT -->
<script>
	function setSeverity()
	{
		if (document.getElementById('eventType').value = "Message")
		{
			document.getElementById('eventSeverity').disabled = false;
		}
		else
		{
			document.getElementById('eventSeverity').disabled = true;
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function clearBox(element){
		if (element == "eventType")
		{
			document.getElementById('eventTypeLbl').innerHTML = "Type:";
		}
		else if (element == "eventSeverity")
		{
			document.getElementById('eventSeverityLbl').innerHTML = "Severity:";
		}
		else if (element == "datepickerTimeTagSteering")
		{
			document.getElementById('datepickerTimeTagSteeringLbl').innerHTML = "Applied at time (UTC):";
		}
		else if (element == "clockSteering")
		{
			document.getElementById('clockSteeringLbl').innerHTML = "Master Clock:";
		}
		else if (element == "freqCorrSteering")
		{
			document.getElementById('freqCorrSteeringLbl').innerHTML = "Frequency Correction (E-14):";
		}
		else if (element == "driftCorrSteering")
		{
			document.getElementById('driftCorrSteeringLbl').innerHTML = "Drift Correction (E-15/day):";
		}
		else if (element == "datepickerTimeTagClockStep")
		{
			document.getElementById('datepickerTimeTagClockStepLbl').innerHTML = "Occurred at time (UTC):";
		}
		else if (element == "clockClockStep")
		{
			document.getElementById('clockClockStepLbl').innerHTML = "Affected Clock:";
		}
		else if (element == "timeStep")
		{
			document.getElementById('timeStepLbl').innerHTML = "Time Step (ns):";
		}
		else if (element == "freqStep")
		{
			document.getElementById('freqStepLbl').innerHTML = "Frequency Step (ns/day):";
		}
		else if (element == "operatorSteering")
		{
			document.getElementById('operatorSteeringLbl').innerHTML = "Operator:";
		}
		else if (element == "operatorClockStep")
		{
			document.getElementById('operatorClockStepLbl').innerHTML = "Operator:";
		}
		else if ((element == "hourTimeTagSteering") || (element == "minTimeTagSteering") || (element == "secTimeTagSteering"))
		{
			document.getElementById('timeSteeringLbl').innerHTML = "";
		}
		else if ((element == "hourTimeTagClockStep") || (element == "minTimeTagClock") || (element == "secTimeTagClock"))
		{
			document.getElementById('timeClockStepLbl').innerHTML = "";
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function loadEventDetails(tableid){
		var random = new Date().getTime();
		$('#eventDetails').load('CreateEventLogDetails.jsp?table='+tableid, "rand ="+random);
		if (document.getElementById('eventType').value == 3)
		{
			document.getElementById('eventSeverity').disabled = false;
		}
		else
		{
			document.getElementById('eventSeverity').disabled = true;
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function Validate(ip_host){
		var res = true;
		var sdt;
		var dt;
		var hours;
		var minutes;
		var seconds;
		if (document.getElementById('eventType').value == "")
		{
			if ((document.getElementById('eventTypeLbl').innerHTML).indexOf("Mandatory") == -1)
				document.getElementById('eventTypeLbl').innerHTML = document.getElementById('eventTypeLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			if (document.getElementById('eventSeverity').value == "")
			{
				if ((document.getElementById('eventSeverityLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('eventSeverityLbl').innerHTML = document.getElementById('eventSeverityLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			}
			res = false;
		}
		if (document.getElementById('eventType').value == "3")
		{
			if (document.getElementById('eventSeverity').value == "")
			{
				if ((document.getElementById('eventSeverityLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('eventSeverityLbl').innerHTML = document.getElementById('eventSeverityLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				res = false;
			}
			if (res == true)
			{
				OkEvent(ip_host);
			}
		}
		else if (document.getElementById('eventType').value == "1")
		{
			if (document.getElementById('eventSeverity').value == "")
			{
				if ((document.getElementById('eventSeverityLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('eventSeverityLbl').innerHTML = document.getElementById('eventSeverityLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				res = false;
			}
			if (document.getElementById('datepickerTimeTagSteering').value == "")
			{
				if ((document.getElementById('datepickerTimeTagSteeringLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('datepickerTimeTagSteeringLbl').innerHTML = document.getElementById('datepickerTimeTagSteeringLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				res = false;
			}
			sdt = new Date(document.getElementById('datepickerTimeTagSteering').value);
			dt = new Date();
			hours = dt.getHours();
			minutes = dt.getMinutes();
			seconds = dt.getSeconds();
			if ((document.getElementById('datepickerTimeTagSteering').value != "") && (sdt.toDateString() == dt.toDateString()) && (document.getElementById('hourTimeTagSteering').value > hours))
			{
				document.getElementById('timeSteeringLbl').innerHTML = "<font color=red size=2><i>Selected time greater than current time</i></font>";
				res = false;
			}
			if ((document.getElementById('datepickerTimeTagSteering').value != "") && (sdt.toDateString() == dt.toDateString()) && (document.getElementById('hourTimeTagSteering').value == hours) && (document.getElementById('minTimeTagSteering').value > minutes))
			{
				document.getElementById('timeSteeringLbl').innerHTML = "<font color=red size=2><i>Selected time greater than current time</i></font>";
				res = false;
			}
			if ((document.getElementById('datepickerTimeTagSteering').value != "") && (sdt.toDateString() == dt.toDateString()) && (document.getElementById('hourTimeTagSteering').value == hours) && (document.getElementById('minTimeTagSteering').value == minutes) && (document.getElementById('secTimeTagSteering').value > seconds))
			{
				document.getElementById('timeSteeringLbl').innerHTML = "<font color=red size=2><i>Selected time greater than current time</i></font>";				
				res = false;
			}
			if (document.getElementById('clockSteering').value == "")
			{
				if ((document.getElementById('clockSteeringLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('clockSteeringLbl').innerHTML = document.getElementById('clockSteeringLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				res = false;
			}
			if ((document.getElementById('freqCorrSteering').value == "") && (document.getElementById('driftCorrSteering').value == ""))
			{
				if ((document.getElementById('freqCorrSteeringLbl').innerHTML).indexOf("Mandatory") == -1)
				{
					document.getElementById('freqCorrSteeringLbl').innerHTML = document.getElementById('freqCorrSteeringLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
					document.getElementById('driftCorrSteeringLbl').innerHTML = document.getElementById('driftCorrSteeringLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				}
				res = false;
			}
			if (document.getElementById('operatorSteering').value == "")
			{
				if ((document.getElementById('operatorSteeringLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('operatorSteeringLbl').innerHTML = document.getElementById('operatorSteeringLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				res = false;
			}
			if (res == true)
			{
				CheckDataTypes(document.getElementById('eventType').value, ip_host);
			}
		}
		else if (document.getElementById('eventType').value == "2")
		{
			if (document.getElementById('eventSeverity').value == "")
			{
				if ((document.getElementById('eventSeverityLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('eventSeverityLbl').innerHTML = document.getElementById('eventSeverityLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				res = false;
			}
			if (document.getElementById('datepickerTimeTagClockStep').value == "")
			{
				if ((document.getElementById('datepickerTimeTagClockStepLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('datepickerTimeTagClockStepLbl').innerHTML = document.getElementById('datepickerTimeTagClockStepLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				res = false;
			}
			sdt = new Date(document.getElementById('datepickerTimeTagClockStep').value);
			dt = new Date();
			hours = dt.getHours();
			minutes = dt.getMinutes();
			seconds = dt.getSeconds();
			if ((document.getElementById('datepickerTimeTagClockStep').value != "") && (sdt.toDateString() == dt.toDateString()) && (document.getElementById('hourTimeTagClockStep').value > hours))
			{
				document.getElementById('timeClockStepLbl').innerHTML = "<font color=red size=2><i>Selected time greater than current time</i></font>";
				res = false;
			}
			if ((document.getElementById('datepickerTimeTagClockStep').value != "") && (sdt.toDateString() == dt.toDateString()) && (document.getElementById('hourTimeTagClockStep').value == hours) && (document.getElementById('minTimeTagClock').value > minutes))
			{
				document.getElementById('timeClockStepLbl').innerHTML = "<font color=red size=2><i>Selected time greater than current time</i></font>";
				res = false;
			}
			if ((document.getElementById('datepickerTimeTagClockStep').value != "") && (sdt.toDateString() == dt.toDateString()) && (document.getElementById('hourTimeTagClockStep').value == hours) && (document.getElementById('minTimeTagClock').value == minutes) && (document.getElementById('secTimeTagClock').value > seconds))
			{
				document.getElementById('timeClockStepLbl').innerHTML = "<font color=red size=2><i>Selected time greater than current time</i></font>";
				res = false;
			}
			if (document.getElementById('clockClockStep').value == "")
			{
				if ((document.getElementById('clockClockStepLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('clockClockStepLbl').innerHTML = document.getElementById('clockClockStepLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				res = false;
			}
			if ((document.getElementById('timeStep').value == "") && (document.getElementById('freqStep').value == ""))
			{
				if ((document.getElementById('timeStepLbl').innerHTML).indexOf("Mandatory") == -1)
				{
					document.getElementById('timeStepLbl').innerHTML = document.getElementById('timeStepLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
					document.getElementById('freqStepLbl').innerHTML = document.getElementById('freqStepLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				}
				res = false;
			}
			if (document.getElementById('operatorClockStep').value == "")
			{
				if ((document.getElementById('operatorClockStepLbl').innerHTML).indexOf("Mandatory") == -1)
					document.getElementById('operatorClockStepLbl').innerHTML = document.getElementById('operatorClockStepLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
				res = false;
			}
			if (res == true)
			{
				CheckDataTypes(document.getElementById('eventType').value, ip_host);
			}
		}
	}
</script>
<script>
function isInteger(s) {
  return (s.toString().search(/^-?[0-9]+$/) == 0);
}
</script>
<script>
function isDouble(s) {
  return (s.toString().search(/^-?[0-9]+.+[0-9]$/) == 0);
}
</script>
<script>
	function CheckDataTypes(tipo, ip_host)
	{
		if (tipo == 1)
		{
			var value1 = document.getElementById('freqCorrSteering').value;
			var value2 = document.getElementById('driftCorrSteering').value;
			if ((value1 != "") && (value2 != ""))
			{
				if (((isDouble(value1)) || (isInteger(value1))) && ((isDouble(value2)) || (isInteger(value2))))
				{
					OkEvent(ip_host);
				}
				else
				{
					document.getElementById('freqCorrSteeringLbl').innerHTML = document.getElementById('freqCorrSteeringLbl').innerHTML + " <font color=red size=2><i>Number needed</i></font>";
					document.getElementById('driftCorrSteeringLbl').innerHTML = document.getElementById('driftCorrSteeringLbl').innerHTML + " <font color=red size=2><i>Number needed</i></font>";
				}
			}
			else if (value1 != "")
			{
				if ((isDouble(value1)) || (isInteger(value1)))
				{
					OkEvent(ip_host);
				}
				else
				{
					document.getElementById('freqCorrSteeringLbl').innerHTML = document.getElementById('freqCorrSteeringLbl').innerHTML + " <font color=red size=2><i>Number needed</i></font>";
				}
			}
			else
			{
				if ((isDouble(value2)) || (isInteger(value2)))
				{
					OkEvent(ip_host);
				}
				else
				{
					//document.getElementById('driftCorrSteering').style.backgroundColor="#FF0000";
					document.getElementById('driftCorrSteeringLbl').innerHTML = document.getElementById('driftCorrSteeringLbl').innerHTML + " <font color=red size=2><i>Number needed</i></font>";
				}
			}
		}
		else if (tipo == 2)
		{
			var value1 = document.getElementById('timeStep').value;
			var value2 = document.getElementById('freqStep').value;
			if ((value1 != "") && (value2 != ""))
			{
				if (((isDouble(value1)) || (isInteger(value1))) && ((isDouble(value2)) || (isInteger(value2))))
				{
					OkEvent(ip_host);
				}
				else
				{
					document.getElementById('timeStepLbl').innerHTML = document.getElementById('timeStepLbl').innerHTML + " <font color=red size=2><i>Number needed</i></font>";
					document.getElementById('freqStepLbl').innerHTML = document.getElementById('freqStepLbl').innerHTML + " <font color=red size=2><i>Number needed</i></font>";
				}
			}
			else if (value1 != "")
			{
				if ((isDouble(value1)) || (isInteger(value1)))
				{
					OkEvent(ip_host);
				}
				else
				{
					document.getElementById('timeStepLbl').innerHTML = document.getElementById('timeStepLbl').innerHTML + " <font color=red size=2><i>Number needed</i></font>";
				}
			}
			else
			{
				if ((isDouble(value2)) || (isInteger(value2)))
				{
					OkEvent(ip_host);
				}
				else
				{
					document.getElementById('freqStepLbl').innerHTML = document.getElementById('freqStepLbl').innerHTML + " <font color=red size=2><i>Number needed</i></font>";
				}
			}
		}

	}
</script>
<script type="text/javascript" charset="utf-8">
	function OkEvent(ip_host){
		var random = new Date().getTime();
		var type = document.getElementById('eventType').value;
		var severity = document.getElementById('eventSeverity').value;
		var desc = document.getElementById('eventDescription').value;
		if (type == 1)
		{
			var dateTimeTag = document.getElementById('datepickerTimeTagSteering').value;
			var hourTimeTag = document.getElementById('hourTimeTagSteering').value;
			var minTimeTag = document.getElementById('minTimeTagSteering').value;
			var secTimeTag = document.getElementById('secTimeTagSteering').value;
			var clock = document.getElementById('clockSteering').value;
			var freqCorr = document.getElementById('freqCorrSteering').value;
			freqCorr = freqCorr.replace(",",".");
			var driftCorr = document.getElementById('driftCorrSteering').value;
			driftCorr = driftCorr.replace(",",".");
			var operator = document.getElementById('operatorSteering').value;
			var description = document.getElementById("descriptionSteering").value;
			$.get('http://'+ip_host+':8080/dms/InsertEventLogServlet?evType='+type+'&evSev='+severity+'&evDesc='+desc+'&dateTimeTag='+dateTimeTag+'&hourTimeTag='+hourTimeTag+'&minTimeTag='+minTimeTag+'&secTimeTag='+secTimeTag+'&clock='+clock+'&freqCorr='+freqCorr+'&driftCorr='+driftCorr+'&operator='+operator+'&description='+description);
			alert("New steering event added");
			$('#eventLogView').load('EventLogView.jsp', "rand ="+random);
		}
		else if (type == 2)
		{
			var dateTimeTag = document.getElementById('datepickerTimeTagClockStep').value;
			var hourTimeTag = document.getElementById('hourTimeTagClockStep').value;
			var minTimeTag = document.getElementById('minTimeTagClock').value;
			var secTimeTag = document.getElementById('secTimeTagClock').value;
			var clock = document.getElementById('clockClockStep').value;
			var timeStep = document.getElementById('timeStep').value;
			timeStep = timeStep.replace(",",".");
			var freqStep = document.getElementById('freqStep').value;
			freqStep = freqStep.replace(",",".");
			var operator = document.getElementById('operatorClockStep').value;
			var description = document.getElementById("descriptionClockStep").value;
			$.get('http://'+ip_host+':8080/dms/InsertEventLogServlet?evType='+type+'&evSev='+severity+'&evDesc='+desc+'&dateTimeTag='+dateTimeTag+'&hourTimeTag='+hourTimeTag+'&minTimeTag='+minTimeTag+'&secTimeTag='+secTimeTag+'&clock='+clock+'&timeStep='+timeStep+'&freqStep='+freqStep+'&operator='+operator+'&description='+description);

			alert("New clock step event added");
			$('#eventLogView').load('EventLogView.jsp', "rand ="+random);
		}
		else if (type == 3)
		{
			$.get('http://'+ip_host+':8080/dms/InsertEventLogServlet?evType='+type+'&evSev='+severity+'&evDesc='+desc);
			alert("New generic event added");
			$('#eventLogView').load('EventLogView.jsp', "rand ="+random);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function CancelEvent(){
		var random = new Date().getTime();
		$('#eventLogTable').load('EventLogTable.jsp', "rand ="+random);
		filterEventLog();
	}
</script>

</html>