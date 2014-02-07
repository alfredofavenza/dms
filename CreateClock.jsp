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
New Clock
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
		<td id="createClockNameLbl">
			Name:
		</td>
		<td id="createClockSerialNumberLbl">
			Serial Number (4 digits):
		</td>
		<td id="createClockClassLbl">
			Class:
		</td>
	</tr>
	<tr class="text">
		<td>
			<input id="clockname" type="text" class="custominput" maxlength="32" onclick="ResetCreateLbl('createClockNameLbl');">
		</td>
		<td>
			<input id="clockserial" type="text" class="custominput" maxlength="4" onclick="ResetCreateLbl('createClockSerialNumberLbl');">
		</td>
		<td>
			<select id="clockclasse" name="clockclasse" class="custominput" onclick="ResetCreateLbl('createClockClassLbl');">
			<option value=""></option>
			<%
				String q = "SELECT id, description FROM clock_class";
				ResultSet rs = statement.executeQuery(q);
				while (rs.next())
				{
					out.println("<option value='"+rs.getInt("id")+"'>"+rs.getString("description")+"</option>");
				}
			%>
			</select>
		</td>
	</tr>
	<tr class="label">
		<td>
			Associated Signal:
		</td>
		<td>
			Master:
		</td>
		<td>
			Enabled:
		</td>
		<td>
		</td>
	</tr>
	<tr class="text">
		<td>
		<select id="clocksignal" name="clocksignal" class="custominput"  style="width:100;">
		<option value=""></option>
		<%
			q = "SELECT id, name FROM vw_available_signals_for_clock";
			rs = statement.executeQuery(q);
			while (rs.next())
			{
				out.println("<option value='"+rs.getInt("id")+"'>"+rs.getString("name")+"</option>");
			}
			rs.close();
			statement.close();
			dbconn.close();
		%>
		</select>
		</td>
		<td>	
			<input id="clockmaster" type="checkbox" onChange="ChangeMaster();" disabled>
		</td>
		<td>
			<input id="clockenabled" type="checkbox" checked>
		</td>
	</tr>
</table>
<br>
<%
out.println("<input type='button' value='Ok' onclick=ValidateClockCreate('"+ip_host+"');></input>");
%>
<input type="button" value="Cancel" onclick="CancelClock();"/>
</body>


<!-- SCRIPT -->
<script>
	function ResetCreateLbl(element)
	{
		if (element == "createClockNameLbl") document.getElementById(element).innerHTML = "Name:";
		else if (element == "createClockSerialNumberLbl") document.getElementById(element).innerHTML = "Serial Number (4 digits):";
		else if (element == "createClockClassLbl") document.getElementById(element).innerHTML = "Class:";
	}
</script>
<script>
	function ChangeMaster() {
		var master_ori = document.getElementById("clockmaster2").checked;
		var master_set = document.getElementById("clockmaster").checked;
		if ((master_ori == true) && (master_set == false)) 
		{
			document.getElementById("selectNewMaster").style.visibility = 'visible';
		}
		else if ((master_ori == false) && (master_set == true)) 
		{
			alert("New Master Clock");
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function ValidateClockCreate(iphost){
		var res = true;
		if (document.getElementById('clockname').value == "")
		{
			if ((document.getElementById('createClockNameLbl').innerHTML).indexOf("Mandatory") == -1)
				document.getElementById('createClockNameLbl').innerHTML = document.getElementById('createClockNameLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			res = false;
		}
		if (document.getElementById('clockserial').value == "")
		{
			if ((document.getElementById('createClockSerialNumberLbl').innerHTML).indexOf("Mandatory") == -1)
				document.getElementById('createClockSerialNumberLbl').innerHTML = document.getElementById('createClockSerialNumberLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			res = false;
		}
		if (document.getElementById('clockclasse').value == "")
		{
			if ((document.getElementById('createClockClassLbl').innerHTML).indexOf("Mandatory") == -1)
				document.getElementById('createClockClassLbl').innerHTML = document.getElementById('createClockClassLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			res = false;
		}
		if (res == true)
		{
			OkClock(iphost);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function OkClock(ip_host){
		var random = new Date().getTime();
		var name = document.getElementById("clockname").value;
		var serial = document.getElementById("clockserial").value;
		var classe = document.getElementById("clockclasse").value;
		var signal = document.getElementById("clocksignal").value;
		if (signal == "") signal = "null";
		var master;
		if (document.getElementById("clockmaster").checked) master = true;
		else master = false;
		var enabled;
		if (document.getElementById("clockenabled").checked) enabled = true;
		else enabled = false;
		$.get("http://"+ip_host+":8080/dms/CreateClockServlet?name='"+name+"'&serial='"+serial+"'&clockclass="+classe+"&signal="+signal+"&master="+master+"&enabled="+enabled+"&randvar="+random);
		alert("New clock created");
		$('#tabs-2').load('ClockView.jsp', "randvar="+random);
		if ((document.getElementById("querytext")) != null)
		{
			var query = document.getElementById("querytext").value;
			$('#container1').load('Visualize.jsp?param='+query+'&view_id=2', "randvar="+random);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function CancelClock(){
		var random = new Date().getTime();
		$('#tabs-2').load('ClockView.jsp', "randvar="+random);
	}
</script>

</html>