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
<style type="text/css" media="screen">
	#el01 {padding:0} /* Remove padding */
	#el02 { /* Text and background colour, blue on light gray */
		color:#00f;
		background-color:#ddd
	}
	#el03 {background:url(/i/icon-info.gif) no-repeat 100% 50%} /* Background image */
	#el04 {border-width:6px} /* Border width */
	#el05 {border:2px dotted #00f} /* Border width, style and colour */
	#el06 {border:none} /* No border */
	#el07 {font-family:"Courier New",Courier} /* Different font */
	#el08 {font-size:2em} /* Bigger text */
	#el09 {font-size:0.5em} /* Smaller text */
	#el10 {font-weight:bold} /* Bold text */
	#el11 {padding:2em} /* Increase padding */
	#el12 {text-align:right} /* Change text alignment */
	fieldset p {margin:0} /* Remove margins from p elements inside fieldsets */
</style>
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

	
	//Query estrazione dati
	Statement statement = dbconn.createStatement();
	String q = "SELECT * FROM vw_exposed_signal_info order by ID asc";
	ResultSet rs = statement.executeQuery(q);
%>
<fieldset id="el04" style="width:200px">
<legend>General Information</legend>
<table>
	<tr class="label">
			<td align="left">
				Signal:
			</td>
			<td align="left">
				<div id="signalLogicalChLbl" style="visibility:hidden">Channel:</div>
			</td>
			<td align="left">
				<div id="signalDelayNsLbl" style="visibility:hidden">Delay (ns):</div>
			</td>
	</tr>
	<tr class="text">
		<td align="left" valign="top">
			<!--<select class='custominput' style="width:200px" name='signalSelect' id='signalSelect' onChange='EnableMeasType();'>-->
			<%
				out.println("<select class='custominput' style='width:200px' name='signalSelect' id='signalSelect' onchange='getChannelAndDelay();EnableMeasType();EnableTemplate();'>");
				out.println("<option value='' ></option>");
				while(rs.next())
				{
					out.println("<option value='"+rs.getInt("ID")+"'>"+rs.getString("Signal_Name")+"</option>");
				}
			%>
			</select>
		</td>
		<td>
			<div id ="signalLogicCh">
			</div>
		</td>
		<td>
			<div id ="signalDelayNs">
			</div>
		</td>
	</tr>
	<tr class="label">
		<td align="left">
			Measurement Type:
		</td>
		<td align="left">
			Setup:
		</td>
	</tr>
	<tr class="text">
		<td align="left" valign="top">
			<label for="typegroup"><input type='radio' name='typegroup' id='timetype' value='1' disabled />time</label><br>
			<label for="typegroup"><input type='radio' name='typegroup' id='freqtype' value='2' disabled />freq</label>
		</td>
		<td align="left" valign="top">
			<select class='custominput' style="width:200px" name='setupSelect' id='setupSelect' onChange="EnableParams();" disabled="disabled">
				<%
					out.println("<option value='' ></option>");
					q = "SELECT * FROM exp_vw_measurement_setups";
					rs = statement.executeQuery(q);
					while(rs.next())
					{
						out.println("<option value='"+rs.getInt("ID")+"' >"+rs.getString("Setup_Description")+"</option>");
					}
				%>
			</select>
		</td>
	</tr>
</table>
</fieldset>
<div id="setupParams" style="visibility:hidden">
</div>
</body>
</html>

<script>
var num = 0;
</script>
<script>
function Vai()
{
	num = setInterval(function(){alert("Ciao")}, 3000);
}
</script>
<script>
function Ferma()
{
	clearInterval(num);
}
</script>

<script>
function EnableMeasType()
{
	document.getElementById("timetype").disabled = false;
	document.getElementById("timetype").checked = true;
	document.getElementById("freqtype").disabled = false;
}
</script>

<script>
function EnableTemplate()
{
	document.getElementById("setupSelect").disabled = false;
	/*
	if (document.getElementById("timetype").checked)
	{
		document.getElementById("gateTimeParam").style.visibility = 'hidden';
		document.getElementById("gateTimeLbl").style.visibility = 'hidden';
		document.getElementById("armgroup").selectedIndex = 0;		
	}
	else
	{
		document.getElementById("gateTimeParam").style.visibility = 'visible';
		document.getElementById("gateTimeLbl").style.visibility = 'visible';
		document.getElementById("armgroup").selectedIndex = 1;	
	}
	*/
	document.getElementById("setupSelect").selectedIndex = 1;	
	EnableParams();
}
</script>
<script>
function EnableParams()
{
	var setupid = document.getElementById("setupSelect").value;
	$('#setupParams').load('SetupParamsView.jsp?setupid='+setupid);
	document.getElementById("setupParams").style.visibility = 'visible';
	if (document.getElementById("timetype").checked)
	{
		document.getElementById("gateTimeParam").style.visibility = 'hidden';
		document.getElementById("gateTimeLbl").style.visibility = 'hidden';
	}
}
</script>

<script>
function getChannelAndDelay(signalid)
{
	var signalid = document.getElementById("signalSelect").value;
	document.getElementById("signalLogicalChLbl").style.visibility = 'visible';
	document.getElementById("signalDelayNsLbl").style.visibility = 'visible';
	$('#signalLogicCh').load('SignalLogicChannel.jsp?signalid='+signalid);
	$('#signalDelayNs').load('SignalDelayNs.jsp?signalid='+signalid);
}
</script>
