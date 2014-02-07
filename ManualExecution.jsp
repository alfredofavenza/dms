<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="dmsmanager.DmsMng"%> 
<%@ page import="dbmanager.DBConnectionManager"%> 
<%@ page language="java" import="java.sql.Connection"%>
<%@ page language="java" import="java.io.*"%>
<%@ page language="java" import="java.net.*"%>

<%@ page import="java.util.ArrayList" language="java" %>

<!-- HTML -->

<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />
<link rel="stylesheet" type="text/css" href="TableTools/media/css/TableTools.css" />
<link rel="stylesheet" type="text/css" href="datatables/css/tabs.css"/>

<style type="text/css" media="screen">
	#el01 {padding:0} /* Remove padding */
	#el02 { /* Text and background colour, blue on light gray */
		color:#00f;
		background-color:#ddd
	}
	#el03 {background:url(/i/icon-info.gif) no-repeat 100% 50%} /* Background image */
	#el04 { -width:6px} /*   width */
	#el05 { :2px dotted #00f} /*   width, style and colour */
	#el06 { :none} /* No   */
	#el07 {font-family:"Courier New",Courier} /* Different font */
	#el08 {font-size:2em} /* Bigger text */
	#el09 {font-size:0.5em} /* Smaller text */
	#el10 {font-weight:bold} /* Bold text */
	#el11 {padding:2em} /* Increase padding */
	#el12 {text-align:right} /* Change text alignment */
	fieldset p {margin:0} /* Remove margins from p elements inside fieldsets */
</style>
<style type="text/css" media="screen">
    @import "datatables/css/demo_table_jui.css";
	@import "datatables/css/demo_table.css";
	@import "datatables/css/demo_page.css";
    @import "datatables/css/inrim.css";
	@import "datatables/css/site_jui.ccss";
	@import "datatables/css/jquery-ui-1.7.2.custom.css";
	@import "datatables/css/tabs.css"
	@import "TableTools/media/css/TableTools.css";
	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes example in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#example_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
</style> 
<style>
	#saveSetupPopUp1 {
		visibility: hidden;
		width: 450px;
		height: 130px;
		background-color: #ccc;
		border: 1px solid #000;
		padding: 10px 20px;
		z-index:1;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-left: -225px;
		margin-top: -35px;
	}
</style>
<style>
	#saveSetupPopUp2 {
		visibility: hidden;
		width: 450px;
		height: 130px;
		background-color: #ccc;
		border: 1px solid #000;
		padding: 10px 20px;
		z-index:1;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-left: -225px;
		margin-top: -35px;
	}
</style>

<%
	Connection dbconn = null;
	dbconn = ((DBConnectionManager)(session.getAttribute("sess_dbconn"))).getDBConnection();
	
	//Query estrazione dati
	Statement statement = dbconn.createStatement();
	String q = "SELECT * FROM vw_exposed_signal_info order by ID asc";
	ResultSet rs = statement.executeQuery(q);

%>
<div id="saveSetupPopUp1" align="center">
	<table>
		<tr>
			<td align="center"><label id="popupMsg"></label></td>
		</tr>
		<tr>
			<td>
				The setup has been modified:<br><br>
				<input type='radio' name='saveSetupGroup' id='saveandrun' onClick='SetButtonLabel();' checked>Save new setup and execute measure<br>
				<input type='radio' name='saveSetupGroup' id='nosaveandrun' onClick='SetButtonLabel();'>Execute measure without saving the new setup<br>
				<br>
				<input type="button" value="Back" onClick="javascript:setVisible('saveSetupPopUp1');EnableSetup();"></input>
				<%
					out.println("<input type='button' id='SetupBtn' value='Next' onClick=CheckSetupChoice('"+session.getAttribute("host_ip")+"');></input>");
				%>
			</td>
		</tr>
	</table>
</div>
<div id="saveSetupPopUp2" align="center">
	<table>
		<tr>
			<td align="center"><label id="popupMsg"></label></td>
		</tr>
		<tr>
			<td>
				Choose name and description for the new setup:<br><br>
				Name: <input type='text' id='newsetupname'/><br>
				Description: <input type='text' id='newsetupdesc'/><br>
				<br>
				<input type="button" value="Back" onClick="javascript:setVisible('saveSetupPopUp2');setVisible('saveSetupPopUp1');"></input>
				<%
					out.println("<input type='button' value='Ok' onClick=SaveSetupAndExecuteMeasure('"+session.getAttribute("host_ip")+"');></input>");
				%>
			</td>
		</tr>
	</table>
</div>
<table width="100%">
	<tr>
		<td align="left" >
		<fieldset id="measurementInfoBox"><legend>Measurement Target</legend>
		<table   width="100%">
			<tr class="label">
				<td align="left">
					<b>Signal:</b>
				</td>
				<td align="left">
					<b>Measurement Type:</b>
				</td>
				<td align="left">
					<b>Setup:</b>
				</td>
				<td align="left">
					<div id="signalLogicalChLbl" style="visibility:hidden"><b>Channel:</b></div>
				</td>
				<td align="left">
					<div id="signalDelayNsLbl" style="visibility:hidden"><b>Delay (ns):</b></div>
				</td>
				<td align="left">
					<div id="signalOffsetNsLbl" style="visibility:hidden"><b>Offset (ns):</b></div>
				</td>
			</tr>
			<tr class="text">
				<td align="left" valign="top">
					<%
						out.println("<select class='custominput' style='width:auto' name='signalSelect' id='signalSelect' onchange='getChannelAndDelay();EnableMeasType();EnableSetup();'>");
						out.println("<option value='' ></option>");
						while(rs.next())
						{
							out.println("<option value='"+rs.getInt("ID")+"'>"+rs.getString("Signal_Name")+" - "+rs.getString("Signal_Description")+"</option>");
						}
						out.println("</select>");
					%>
				</td>
				<td align="left" valign="top">
					<div id="measurementType">
					</div>
				</td>
				<td align="left" valign="top">
					<div id="setupsSelect">
					</div>
					<!--
					<select class='custominput' style="width:auto" name='setupSelect' id='setupSelect' onChange="EnableParams();" disabled="disabled">
						<%
							//out.println("<option value='' ></option>");
							//q = "SELECT * FROM exp_vw_measurement_setups";
							//rs = statement.executeQuery(q);
							//while(rs.next())
							//{
							//	out.println("<option value='"+rs.getInt("ID")+"' >"+rs.getString("Setup_Description")+"</option>");
							//}
						%>
					</select>
					-->
				</td>
				<td>
					<div id ="signalLogicCh">
					</div>
				</td>
				<td>
					<div id ="signalDelayNs">
					</div>
				</td>
				<td>
					<div id ="signalOffsetNs">
					</div>
				</td>
			</tr>
		</table>
		</fieldset>
		</td>
	</tr>
	<tr>
		<td valign="top" width="100%">
			<table>
				<tr>
					<td width="100%">
						<table  >
							<tr>
								<td>
									<div id="setupParams" style="visibility:hidden">
									</div>
								</td>
							</tr>
						</table>
					<td>
					<td valign="bottom" align="left" width="100%">
						<div id="buttonsDiv" style="visibility:hidden">
							<%
							out.println("<input type='button' id='measurebutton' value='Start' onClick=StartStopManualMeasurement('"+session.getAttribute("host_ip")+"'); />");
							%>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<div id="measurementStatusMsg">ecco
			</div>
		</td>
	</tr>
	<tr>
		<td align="center" >
			<div id="StatisticsDiv" style="visibility:hidden">
			</div>
		</td>
	</tr>
	<tr>
		<td valign="top"> <!-- Results -->
			<table width="100%">
				<tr>
					<td valign="top">
						<div id="resultsDiv" style="visibility:hidden">
							<fieldset id="el05"><legend>Execution results</legend>
							<div align="right"><a href="#" onclick="resetTableResults();">Clear Results and Statistics</a></div>
								<table cellpadding="0" cellspacing="0" class="display" id="exectable">
									<%
									out.println("<thead><tr>");
									out.println("<th>Counter</th>");
									out.println("<th>Timetag</th>");
									out.println("<th>Mean</th>");
									out.println("<th>Sigma</th>");
									out.println("<th>Min</th>");
									out.println("<th>Max</th>");
									out.println("</tr><thead>");
									out.println("<tbody>");
									%>
									</tbody>
								</table>
							</fieldset>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>	
<%
	rs.close();
	statement.close();
	//dbconn.close();
%>
<script>

var armingmode = 0;
var source = 0;
var samples = 0;
var gatetime = 0;
var clcksource = 0;
var extclkfreq = 0;
var inacoupling = 0;
var inaterm = 0;
var inatrigslope = 0;
var inatriglevel = 0;
var inatriglevelmin = 0;
var inatriglevelmax = 0;
var inbcoupling = 0;
var inbterm = 0;
var inbtrigslope = 0;
var inbtriglevel = 0;
var inbtriglevelmin = 0;
var inbtriglevelmax = 0;

var arm = 0;
var src = 0;
var smp = 0;
var gatet = 0;
var acoup = 0;
var aterm = 0;
var atrigs = 0;
var gatet = 0;
var acoup = 0;
var aterm = 0;
var atrigs = 0;
var atriglev = 0;
var bcoup = 0;
var bterm = 0;
var btrigs = 0;
var btriglev = 0;
		
var parent = "NULL";
var taskid = 0;
var checkTaskid = 0;
var taskStatus = "";
var semaforo = 1;

var statCount = 0;
var statSum = 0;
var statMin = Number.POSITIVE_INFINITY;
var statMax = Number.NEGATIVE_INFINITY;

var resultsArray;

$('#measurementType').load('MeasurementTypeView.jsp', function(){$('#setupsSelect').load('SetupsView.jsp?meastype=1');});
//$('#setupsList').load('SetupsView.jsp');
</script>

<script>
function checkTaskStatus()
{
	if (taskStatus == "executed")
	{
		clearInterval(taskid);
		clearInterval(checkTaskid);
	}
}
</script>
<script>
function EnableMeasType()
{
	document.getElementById("timetype").disabled = false;
	document.getElementById("freqtype").disabled = false;
	document.getElementById("timetype").checked = true;
	
}
</script>

<script>
function EnableSetup()
{
	document.getElementById("setupSelect").disabled = false;
	document.getElementById("setupSelect").selectedIndex = 1;	
	if (true)
	{
		EnableParams();
	}
	num = 0;
}
</script>
<script>
function EnableStatistics()
{
	if (document.getElementById("StatisticsDiv").style.visibility == 'hidden') {
		$('#StatisticsDiv').load('StatisticsView.jsp');
		document.getElementById("StatisticsDiv").style.visibility = 'visible';	
	}
}
</script>
<script>
function EnableResults()
{
	document.getElementById("resultsDiv").style.visibility = 'visible';
	//document.getElementById("buttonsDiv").style.visibility = 'visible';
}
</script>
<script>
function SaveParameters()
{
	//ARMING MODE
	if (document.getElementById("timearm").checked)
	{
		armingmode = document.getElementById("timearm").value;
	}
	else
	{
		armingmode = document.getElementById("freqarm").value;
	}
	//SOURCE
	if (document.getElementById("absource").checked)
	{
		source = document.getElementById("absource").value;
	}
	else
	{
		source = document.getElementById("basource").value;
	}
	//SAMPLES
	samples = document.getElementById("samplesParam").value;
	//GATE TIME
	gatetime = document.getElementById("gateTimeParam").value
	
	// INPUT A
	// COUPLING
	if (document.getElementById("inputadccouplig").checked)
	{
		inacoupling = document.getElementById("inputadccouplig").value;
	}
	else
	{
		inacoupling = document.getElementById("inputaaccouplig").value;
	}
	// TERMINATION
	if (document.getElementById("inputa50qterm").checked)
	{
		inaterm = document.getElementById("inputa50qterm").value;
	}
	else
	{
		inaterm = document.getElementById("inputa1mqterm").value;
	}
	// TRIGGER SLOPE
	if (document.getElementById("inputarisingtrigger").checked)
	{
		inatrigslope = document.getElementById("inputarisingtrigger").value;
	}
	else
	{
		inatrigslope = document.getElementById("inputafallingtrigger").value;
	}
	// TRIGGER LEVEL
	inatriglevel = document.getElementById("inputatriggerLevel").value;
	//inatriglevelmin = 1.0;
	inatriglevelmin = document.getElementById("inputatriggerLevel").min;
	//inatriglevelmax = 5.0;
	inatriglevelmax = document.getElementById("inputatriggerLevel").max;
	// INPUT B
	// COUPLING
	if (document.getElementById("inputbdccouplig").checked)
	{
		inbcoupling = document.getElementById("inputbdccouplig").value;
	}
	else
	{
		inbcoupling = document.getElementById("inputbaccouplig").value;
	}
	// TERMINATION
	if (document.getElementById("inputb50qterm").checked)
	{
		inbterm = document.getElementById("inputb50qterm").value;
	}
	else
	{
		inbterm = document.getElementById("inputb1mqterm").value;
	}
	// TRIGGER SLOPE
	if (document.getElementById("inputbrisingtrigger").checked)
	{
		inbtrigslope = document.getElementById("inputbrisingtrigger").value;
	}
	else
	{
		inbtrigslope = document.getElementById("inputbfallingtrigger").value;
	}
	// TRIGGER LEVEL
	inbtriglevel = document.getElementById("inputbtriggerLevel").value;
	//inbtriglevelmin = 1.0;
	inbtriglevelmin = document.getElementById("inputbtriggerLevel").min;
	//inbtriglevelmax = 5.0;
	inbtriglevelmax = document.getElementById("inputbtriggerLevel").max;
}
</script>
<script>
function EnableParams()
{
	var setupid = document.getElementById("setupSelect").value;
	//var measuretype = document.getElementById("measTypeGroup").value;
	var measuretype = "";
	var measuretypeGroup = document.getElementsByName("measTypeGroup");

	for(var i = 0; i < measuretypeGroup.length; i++) {
		if(measuretypeGroup[i].checked == true) {
		   measuretype = measuretypeGroup[i].value;
		}
	}
	$('#setupParams').load('SetupParamsView.jsp?setupid='+setupid+'&meastype='+measuretype, function(){SaveParameters();});
	document.getElementById("setupParams").style.visibility = 'visible';
	document.getElementById("buttonsDiv").style.visibility = 'visible';

	// if (document.getElementById("timetype").checked)
	// {
		// document.getElementById("gateTimeParam").style.visibility = 'hidden';
		// document.getElementById("gateTimeLbl").style.visibility = 'hidden';
	// }
	//EnableStatistics();
	//EnableResults();
}
</script>

<script>
function getChannelAndDelay(signalid)
{
	var signalid = document.getElementById("signalSelect").value;

	document.getElementById("signalLogicalChLbl").style.visibility = 'visible';
	document.getElementById("signalDelayNsLbl").style.visibility = 'visible';
	document.getElementById("signalOffsetNsLbl").style.visibility = 'visible';
	
	$('#signalLogicCh').load('SignalLogicChannel.jsp?signalid='+signalid);
	$('#signalDelayNs').load('SignalDelayNs.jsp?signalid='+signalid);
	$('#signalOffsetNs').load('SignalOffsetNs.jsp?signalid='+signalid);
}
</script>
<script>
function ResetPage()
{
	getChannelAndDelay();
	EnableMeasType();
	EnableTemplate();
}
</script>
<script>
function Stop(host_ip)
{
	var signalid = document.getElementById("signalSelect").value;
	var setupid = document.getElementById("setupSelect").value;
	//var i = 0;
	//var resarray;
	//checkTaskid = setInterval(function(){checkTaskStatus()},1000);
	$.get('http://'+host_ip+':8080/dms/StopManualMeasurementServlet?signalid='+signalid+'&setupid='+setupid+'&randvar='+random, 
		function(data)
		{
			// alert(data)
			// comando non riconosciuto
			if (data.toUpperCase().contains("NACK"))
			{
				alert("Ops... Protocol error, sorry [command not defined]");
			}
			// errore in risposta a comando riconosciuto
			else if (data.toUpperCase().contains("ERR"))
			{
				var error_items = data.split(';');
				var msg = "STOP failed!";
				if (error_items.length > 1) {
					msg = msg + " (Error code: " + error_items[1] + ")";
				}
				if (error_items.length > 2) {
					msg = msg + " " + error_items[2];
				}
				alert(msg);
			}
			// comando riconosciuto e correttamente eseguito
			else if (data.toUpperCase() == "ACK")
			{
				alert("Measurement is going to be stopped...");
				clearInterval(taskid);
				//resetTableResults();
				document.getElementById("measurebutton").value = "Start";
				document.getElementById("measurementInfoBox").disabled = false;
				document.getElementById("parametersBox").disabled = false;
			}
			// risposta del comando non riconosciuta
			else
			{
				alert("Ops... Protocol error, sorry [response not defined]");
			}
		}
	);
}
</script>

<script>
function StartStopManualMeasurement(host_ip)
{
	//alert(armingmode+" "+source+" "+samples+" "+gatetime+" "+inacoupling+" "+inaterm+" "+inatrigslope+" "+inatriglevel+" "+inbcoupling+" "+inbterm+" "+inbtrigslope+" "+inbtriglevel);
	ResetSaveSetupPopUp1();
	var setupid = document.getElementById("setupSelect").value;
	if (document.getElementById("measurebutton").value == "Stop")
	{
		Stop(host_ip);		
	}
	else
	{
		var armgroup = document.getElementsByName("armgroup");
		//var arm = 0;
		for(var i = 0; i < armgroup.length; i++) 
		{
			if(armgroup[i].checked == true) 
			{
				arm = armgroup[i].value;
			}
		}
		
		var sourcegroup = document.getElementsByName("sourcegroup");
		//var src = 0;
		for(var i = 0; i < sourcegroup.length; i++) 
		{
			if(sourcegroup[i].checked == true) 
			{
				src = sourcegroup[i].value;
			}
		}
		
		//var smp = 0;
		var samplesParam = document.getElementById("samplesParam");
		smp = samplesParam.options[samplesParam.selectedIndex].value;

		//var gatet = 0;
		var gateTimeParam = document.getElementById("gateTimeParam");
		gatet = gateTimeParam.options[gateTimeParam.selectedIndex].value;
		
		var clocksourcegroup = document.getElementsByName("clocksourcegroup");
		//var clksrc = 0;
		for(var i = 0; i < clocksourcegroup.length; i++) 
		{
			if(clocksourcegroup[i].checked == true) 
			{
				clksrc = clocksourcegroup[i].value;
			}
		}
		
		var extclockgroup = document.getElementsByName("extclockgroup");
		//var extclckf = 0;
		for(var i = 0; i < extclockgroup.length; i++) 
		{
			if(extclockgroup[i].checked == true) 
			{
				extclckf = extclockgroup[i].value;
			}
		}
		
		var inputaCouplingGroup = document.getElementsByName("inputaCouplingGroup");
		//var acoup = 0;
		for(var i = 0; i < inputaCouplingGroup.length; i++) 
		{
			if(inputaCouplingGroup[i].checked == true) 
			{
				acoup = inputaCouplingGroup[i].value;
			}
		}
		
		var inputaTermGroup = document.getElementsByName("inputaTermGroup");
		//var aterm = 0;
		for(var i = 0; i < inputaTermGroup.length; i++) 
		{
			if(inputaTermGroup[i].checked == true) 
			{
				aterm = inputaTermGroup[i].value;
			}
		}
		
		var inputaTriggerGroup = document.getElementsByName("inputaTriggerGroup");
		//var atrigs = 0;
		for(var i = 0; i < inputaTriggerGroup.length; i++) 
		{
			if(inputaTriggerGroup[i].checked == true) 
			{
				atrigs = inputaTriggerGroup[i].value;
			}
		}
		
		atriglev = document.getElementById("inputatriggerLevel").value;
		
		var inputbCouplingGroup = document.getElementsByName("inputbCouplingGroup");
		//var bcoup = 0;
		for(var i = 0; i < inputbCouplingGroup.length; i++) 
		{
			if(inputbCouplingGroup[i].checked == true) 
			{
				bcoup = inputbCouplingGroup[i].value;
			}
		}
		
		var inputbTermGroup = document.getElementsByName("inputbTermGroup");
		//var bterm = 0;
		for(var i = 0; i < inputbTermGroup.length; i++) 
		{
			if(inputbTermGroup[i].checked == true) 
			{
				bterm = inputbTermGroup[i].value;
			}
		}
		
		var inputbTriggerGroup = document.getElementsByName("inputbTriggerGroup");
		//var btrigs = 0;
		for(var i = 0; i < inputbTriggerGroup.length; i++) 
		{
			if(inputbTriggerGroup[i].checked == true) 
			{
				btrigs = inputbTriggerGroup[i].value;
			}
		}

		btriglev = document.getElementById("inputbtriggerLevel").value;
		
		if ((atriglev < inatriglevelmin) || (atriglev > inatriglevelmax) || (btriglev < inbtriglevelmin) || (btriglev > inbtriglevelmax))
		{
			var output = "";
			if ((atriglev < inatriglevelmin) || (atriglev > inatriglevelmax))
			{
				output = "Input A Trigger level value should be in "+inatriglevelmin+" - "+inatriglevelmax+" interval\n";
			}
			if ((btriglev < inbtriglevelmin) || (btriglev > inbtriglevelmax))
			{
				output += "Input B Trigger level value should be in "+inbtriglevelmin+" - "+inbtriglevelmax+" interval";
			}
			alert(output);
		}
		else
		{
			if ((arm!=armingmode) || (src!=source) || (smp!=samples) || (gatet!=gatetime) ||
			   (acoup!=inacoupling) || (aterm!=inaterm) || (atrigs!=inatrigslope) || (atriglev!=inatriglevel) ||
			   (bcoup!=inbcoupling) || (bterm!=inbterm) || (btrigs!=inbtrigslope) || (btriglev!=inbtriglevel))
			{
				//POP-UP Salvataggio Setup
				document.getElementById("saveSetupPopUp1").style.visibility = 'visible';
			}
			else
			{
				ExecuteMeasure(host_ip);
			}
		}
	}
}
</script>
<script>
function ResetSaveSetupPopUp1()
{
	document.getElementById("SetupBtn").value = "Next";
	document.getElementById("saveandrun").checked = true;
}
</script>
<script>
function CheckSetupChoice(host_ip)
{
	if (document.getElementById("saveandrun").checked)
	{
		SetSetupNameDesc()
	}
	else
	{
		setVisible('saveSetupPopUp1');
		ExecuteMeasure(host_ip);
	}
}
</script>
<script>
function SetButtonLabel()
{
	if (document.getElementById("SetupBtn").value == "Next")
	{
		document.getElementById("SetupBtn").value = "Ok";
	}
	else
	{
		document.getElementById("SetupBtn").value = "Next";
	}
}
</script>
<script>
function SetSetupNameDesc()
{
	setVisible('saveSetupPopUp1');
	ResetNewSetupNameDesc();
	setVisible('saveSetupPopUp2');
}
</script>
<script>
function ResetNewSetupNameDesc()
{
	document.getElementById("newsetupname").value = "";
	document.getElementById("newsetupdesc").value = "";
}
</script>
<script>
function SaveSetupAndExecuteMeasure(host_ip)
{
	setVisible('saveSetupPopUp2');
	var setupid = document.getElementById("setupSelect").value;
	$.get('http://'+host_ip+':8080/dms/CreateSetupServlet?setupid='+setupid+'&randvar='+random, 
		function(data)
		{
			alert("creato setup con setupid= "+data);
			setupid = data;
			alert("ora setupid= "+setupid);
		}
	);
	if (arm!=armingmode)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=5&value='+arm+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (src!=source)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=4&value='+src+'&randvar='+random, 
			function(data)
			{
				alert(data);
			}
		);
	}
	if (smp!=samples)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=7&value='+smp+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (gatet!=gatetime)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=&value='+gatet+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (acoup!=inacoupling)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=8&value='+acoup+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (aterm!=inaterm)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=10&value='+aterm+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (atrigs!=inatrigslope)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=14&value='+atrigs+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (atriglev!=inatriglevel)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=12&value='+atriglev+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (bcoup!=inbcoupling)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=9&value='+bcoup+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (bterm!=inbterm)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=11&value='+bterm+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (btrigs!=inbtrigslope)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=15&value='+btrigs+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	if (btriglev!=inbtriglevel)
	{
		$.get('http://'+host_ip+':8080/dms/SaveSetupServlet?setupid='+setupid+'&param=13&value='+btriglev+'&randvar='+random, 
			function(data)
			{
			}
		);
	}
	ExecuteMeasure(host_ip);
	
	// Rifaccio select sulla lista dei setup
	//$('#setupsSelect').load('SetupsView.jsp?meastype=1');
	//EnableSetup();
}
</script>
<script>
function ExecuteMeasure(host_ip)
{
	var setupid = document.getElementById("setupSelect").value;
	var signalid = document.getElementById("signalSelect").value;
	alert("sto per chiamare la servlet...");
	$.get('http://'+host_ip+':8080/dms/StartManualMeasurementServlet?signalid='+signalid+'&setupid='+setupid+'&parent='+parent+'&randvar='+random, 
		function(data)
		{
			alert(data);
			// comando non riconosciuto
			if (data.toUpperCase().contains("NACK"))
			{
				alert("Ops... Protocol error, sorry [command not defined]");
			}
			// errore in risposta a comando riconosciuto
			else if (data.toUpperCase().contains("ERR"))
			{
				var error_items = data.split(';');
				var msg = "START failed!";
				if (error_items.length > 1) 
				{
					msg = msg + " (Error code: " + error_items[1] + ")";
				}
				if (error_items.length > 2) 
				{
					msg = msg + " " + error_items[2];
				}
				alert(msg);
			}
			// comando riconosciuto e correttamente eseguito
			else if (data.toUpperCase() == "ACK")
			{
				alert("Measurement is going to be started...");
				EnableStatistics();
				EnableResults();
				taskid = setInterval(function(){getResults(host_ip)},1000);
				document.getElementById("measurebutton").value = "Stop";
				var stmsg = "Measurement in progress...";
				stmsg = stmsg.replace(/\s/g,'&nbsp;');
				alert(stmsg);
				$('#measurementStatusMsg').load('UpdateMeasurementStatusMessage.jsp?message='+stmsg);
				document.getElementById("measurementInfoBox").disabled = true;
				document.getElementById("parametersBox").disabled = true;
			}
			// risposta del comando non riconosciuta
			else
			{
				alert("Ops... Protocol error, sorry [response not defined]");
			}
		}
	);
}
</script>

<script>
function getResults(host_ip)
{
	var resarray;
	if (semaforo == 1)
	{
		semaforo = 0;
		$.get('http://'+host_ip+':8080/dms/GetMeasurementResultsServlet?randvar='+random, 
			function(data)
			{
				//alert(data);
				// comando non riconosciuto
				if (data.toUpperCase().contains("NACK"))
				{
					alert("Ops... Protocol error, sorry [command not defined]");
					semaforo = 1;
				}
				// errore in risposta a comando riconosciuto
				else if (data.toUpperCase().contains("ERR"))
				{
					var error_items = data.split(';');
					var msg = "Getting results failed!";
					if (error_items.length > 1) {
						msg = msg + " (Error code: " + error_items[1] + ")";
					}
					if (error_items.length > 2) {
						msg = msg + " " + error_items[2];
					}
					//alert(msg);
					semaforo = 1;
				}
				else
				{
					semaforo = 1;
					resarray = data.split(";");
					// resarray[0] è il timetag con formato dd-mm-yyyy hh:mm:ss
					fnClickAddRow(resarray[0],resarray[1].replace(" ", ""),resarray[2].replace(" ", ""),resarray[3].replace(" ", ""),resarray[4].replace(" ", ""));
					// fnClickAddRow(resarray[0].replace(" ", ""),resarray[1].replace(" ", ""),resarray[2].replace(" ", ""),resarray[3].replace(" ", ""));
					
					UpdateStatistics(resarray[1].replace(" ", ""));
				}
			}
		);
	}
}
</script>
<script>
function ResetStatistics()
{
	statCount = 0;
	statSum = 0;
	statMin = Number.POSITIVE_INFINITY;
	statMax = Number.NEGATIVE_INFINITY;
	$('#meanStat').load('UpdateStatisticsView.jsp?statval=');
	$('#minStat').load('UpdateStatisticsView.jsp?statval=');
	$('#maxStat').load('UpdateStatisticsView.jsp?statval=');
}
</script>
<script>
function UpdateStatistics(newSample)
{
	newSample = parseFloat(newSample.replace(",", "."));
	if (isNaN(newSample)) {
	}
	else
	{
		statSum = statSum + newSample;
		statCount++;
		$('#meanStat').load('UpdateStatisticsView.jsp?statval='+(statSum/statCount));
		if (newSample > statMax) {
			statMax = newSample;
			$('#maxStat').load('UpdateStatisticsView.jsp?statval='+statMax);
		}
		if (newSample < statMin) {
			statMin = newSample;
			$('#minStat').load('UpdateStatisticsView.jsp?statval='+statMin);
		}
	}
}
</script>
<script>
function DMSSocketConnection(ip_host)
{
	/*
	var num = document.getElementById("cmdnum").value;
	if (num != "")
	{
		jQuery.ajax({
			url: 'http://'+ip_host+':8080/dms/DMSSocketConnectionServlet?num='+num,
			success:function(data) {
						alert("DMS response: "+'\n'+data)
					},
			async: false
		});
	}
	else
	{
		alert("insert an input for the command");
	}
	*/
}
</script>
<script type="text/javascript">
	function fnFeaturesInit ()
	{
		/* Not particularly modular this - but does nicely :-) */
		$('ul.limit_length>li').each( function(i) {
			if ( i > 10 ) {
				this.style.display = 'none';
			}
		} );
		
		$('ul.limit_length').append( '<li class="css_link">Show more<\/li>' );
		$('ul.limit_length li.css_link').click( function () {
			$('ul.limit_length li').each( function(i) {
				if ( i > 5 ) {
					this.style.display = 'list-item';
				}
			} );
			$('ul.limit_length li.css_link').css( 'display', 'none' );
		} );
	}
	$(document).ready( function() {
		fnFeaturesInit();
		var oTable = 
		$('#exectable').dataTable( {
			"bJQueryUI": true,
			"bFilter": false,
			"bStateSave": true,
			"bRetrieve": true,
			"sPaginationType": "full_numbers",
			"bProcessing": true,
			"bPaginate": true,
			"bAutoWidth": false,
			//"aoColumns": [{"bSearchable": true, "bVisible":false}, null, null],
			//"oColVis": {"aiExclude": [ 0 ]},
			"bSort": true
		} );
		oTable.fnSort( [ [0,'desc'] ] );  
	} );
	var giCount = 1;
	function fnClickAddRow(param1,param2,param3,param4,param5) {
	$('#exectable').dataTable().fnAddData( [
		giCount, 
		param1,
		param2,
		param3,
		param4,
		param5 ] );
	giCount++;
	}
	function fnResetCounter() {
	
	giCount = 1;
	}
</script>
<script type="text/javascript">
(function(){
  var bsa = document.createElement('script');
     bsa.type = 'text/javascript';
     bsa.async = true;
     bsa.src = '//s3.buysellads.com/ac/bsa.js';
  (document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(bsa);
})();
</script>
<script>
function resetTableResults()
{
	$('#exectable').dataTable().fnClearTable(0);
	$('#exectable').dataTable().fnDraw();
	fnResetCounter();
	ResetStatistics();
}
</script>
