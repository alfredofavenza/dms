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
New Signal
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
%>
<table id="newrecord">
	<tr class="label">
		<td id="signalNameLbl">
			Name:
		</td>
		<td>
			Description:
		</td>
		<td>
			Enabled:
		</td>
	</tr>
	<tr class="text">
		<td>
			<input class="custominput" id="createsignalname" type="text" maxlength="20" onClick="clearBox('createsignalname');">
		</td>
		<td>
			<input class="custominput" id="createsignaldesc" type="text" maxlength="45" onClick="clearBox('createsignaldesc');">
		</td>
		<td>
			<input class="custominput" id="createsignalenabled" type="checkbox" checked>
		</td>
	</tr>
	<tr class="label">
		<td id="classIdLbl">
			Class:
		</td>
		<td id="channelLbl">
			Associated Channel:
		</td>
	</tr>
	<tr class="text">
		<td>
			<select class="custominput" name="createsignalclasse" id="createsignalclasse" onClick="clearBox('createsignalclasse');">
			<option value=""></option>
			<%
				String q = "SELECT id, name FROM signal_class";
				ResultSet rs = statement.executeQuery(q);
				while (rs.next())
				{
					out.println("<option value='"+rs.getString("id")+"'>"+rs.getString("name")+"</option>");
				}
			%>
			</select>
		</td>
		<td>
			<select class="custominput" name="createsignalchannel" id="createsignalchannel" onClick="clearBox('createsignalchannel');">
			<option value=""></option>
			<%
				q = "SELECT Free_Channel from vw_available_channels";
				rs = statement.executeQuery(q);
				while (rs.next())
				{
					out.println("<option value='"+rs.getInt("Free_Channel")+"'>"+rs.getInt("Free_Channel")+"</option>");
				}
				rs.close();
				statement.close();
				dbconn.close();
			%>
			</select>
		</td>
	</tr>
	<tr class="label">
		<td>
			Delay (ns):
		</td>
		<td>
			Offset (ns):
		</td>
	</tr>
	<tr class="text">
		<td>
			<input class="custominput" id="createsignaldelay" type="float" size="25" value="0.0" onClick="clearBox('createsignaldelay');">
		</td>
		<td>
			<input class="custominput" id="createsignaloffset" type="float" size="25" value="0.0" onClick="clearBox('createsignaloffset');">
		</td>
	</tr>
	<tr class="label">
		<td>
			Change Description:
		</td>
	</tr>
	<tr class="text">
		<td>
			<input class="custominput" id="createsignalhd" type="text" maxlength="255">
		</td>
	</tr>
</table>
<br>
<%
out.println("<input type='button' value='Ok' onclick=ValidateSignal('"+ip_host+"');></input>");
%>
<input type="button" value="Cancel" onclick="CancelSignal();"/>
</body>


<!-- SCRIPT -->
<script type="text/javascript" charset="utf-8">
	function clearBox(element){
		document.getElementById(element).style.backgroundColor="#f1f1f1";
		if (element == "createsignalname") document.getElementById("signalNameLbl").innerHTML = "Name:";
		else if (element == "createsignalclasse") document.getElementById("classIdLbl").innerHTML = "Class:";
		else if (element == "createsignalchannel") document.getElementById("channelLbl").innerHTML = "Associated Channel:";
	}
</script>
<script type="text/javascript" charset="utf-8">
	function ValidateSignal(iphost){
		var res = true;
		if (document.getElementById('createsignalname').value == "")
		{
			//document.getElementById('createsignalname').style.backgroundColor="#FF0000";
			if ((document.getElementById('signalNameLbl').innerHTML).indexOf("Mandatory") == -1)
				document.getElementById('signalNameLbl').innerHTML = document.getElementById('signalNameLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			res = false;
		}
		if (document.getElementById('createsignalclasse').value == "")
		{
			//document.getElementById('createsignalclasse').style.backgroundColor="#FF0000";
			if ((document.getElementById('classIdLbl').innerHTML).indexOf("Mandatory") == -1)
				document.getElementById('classIdLbl').innerHTML = document.getElementById('classIdLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			res = false;
		}
		if ((document.getElementById('createsignalchannel').value == ""))
		{
			if ((document.getElementById('channelLbl').innerHTML).indexOf("Mandatory") == -1)
				document.getElementById('channelLbl').innerHTML = document.getElementById('channelLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			res = false;
		}
		if (res == true)
		{
			CheckSignalDataTypes(iphost);
		}
	}
</script>
<script>
	function CheckSignalDataTypes(ip_host)
	{
		var value1 = document.getElementById('createsignaldelay').value;
		var value2 = document.getElementById('createsignaloffset').value;
		if ((value1 != "") && (value2 != ""))
		{
			if (((isDouble(value1)) || (isInteger(value1))) && ((isDouble(value2)) || (isInteger(value2))))
			{
				OkSignal(ip_host);
			}
			else
			{
				document.getElementById('createsignaldelay').style.backgroundColor="#FF0000";
				document.getElementById('createsignaloffset').style.backgroundColor="#FF0000";
			}
		}
		else if (value1 != "")
		{
			if ((isDouble(value1)) || (isInteger(value1)))
			{
				OkSignal(ip_host);
			}
			else
			{
				document.getElementById('createsignaldelay').style.backgroundColor="#FF0000";
			}
		}
		else
		{
			if ((isDouble(value2)) || (isInteger(value2)))
			{
				OkSignal(ip_host);
			}
			else
			{
				document.getElementById('createsignaloffset').style.backgroundColor="#FF0000";
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
<script type="text/javascript" charset="utf-8">
	function OkSignal(ip_host){
		var random = new Date().getTime();
		var name = document.getElementById("createsignalname").value;
		var desc = document.getElementById("createsignaldesc").value;
		var enabled;
		if (document.getElementById("createsignalenabled").checked) enabled = true;
		else enabled = false;
		var sigclass = document.getElementById("createsignalclasse").value;
		var channel = document.getElementById("createsignalchannel").value;
		var delay = document.getElementById("createsignaldelay").value*0.000000001;
		var offset = document.getElementById("createsignaloffset").value*0.000000001;
		var hdesc = document.getElementById("createsignalhd").value;
		$.get("http://"+ip_host+":8080/dms/CreateSignalServlet?name='"+name+"'&desc='"+desc+"'&sigclass="+sigclass+"&channel="+channel+"&enabled="+enabled+"&delay="+delay+"&offset="+offset+"&hdesc='"+hdesc+"'&randvar="+random);		
		alert("New signal created.");
		$('#tabs-1').load('SignalView.jsp', "randvar="+random);
		if (document.getElementById("querytext") != null)
		{
			var query = document.getElementById("querytext").value;
			$('#container1').load('Visualize.jsp?param='+query+'&view_id=1', "randvar="+random);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function CancelSignal(){
		var random = new Date().getTime();
		$('#tabs-1').load('SignalView.jsp?randvar='+random);
	}
</script>

</html>
