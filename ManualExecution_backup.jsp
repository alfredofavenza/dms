<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="dmsmanager.DmsMng"%> 
<%@ page language="java" import="java.sql.Connection"%>
<%@ page language="java" import="java.io.*"%>
<%@ page language="java" import="java.net.*"%>


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
<table width="100%" border>
	<tr>
		<td>
		<fieldset id="el05"><legend>General Information</legend>
		<table>
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
						out.println("<select class='custominput' style='width:200px' name='signalSelect' id='signalSelect' onchange='getChannelAndDelay();EnableMeasType();EnableTemplate();'>");
						out.println("<option value='' ></option>");
						while(rs.next())
						{
							out.println("<option value='"+rs.getInt("ID")+"'>"+rs.getString("Signal_Name")+" - "+rs.getString("Signal_Description")+"</option>");
						}
					%>
					</select>
				</td>
				<td align="left" valign="top">
					<div id="measurementType">
					</div>
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
				<td>
					<div id ="signalLogicCh">
					</div>
				</td>
				<td align="left">
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
</table>	
<table border>			
	<tr>
		<td valign="top"  width="50%">
			<table>
				<tr><!-- Parameters -->
					<td>
						<table>
							<tr>
								<td>
									<div id="setupParams" style="visibility:hidden">
									</div>
								</td>
							</tr>
						</table>
					<td>
				</tr>
			</table>
		</td>
		
		<td valign="top" width="50%"> <!-- Results -->
			<table>
				<tr>
					<td valign="top" width="50%">
						<div id="resultsDiv" style="visibility:hidden">
							<fieldset id="el05"><legend>Execution results</legend>
								<table cellpadding="0" cellspacing="0" border="0" class="display" id="exectable">
									<%
									out.println("<thead><tr>");
									out.println("<th>Counter</th>");
									out.println("<th>Parameter</th>");
									out.println("<th>Value</th>");
									out.println("</tr><thead>");
									out.println("<tbody>");
									%>
									</tbody>
								</table>
							</fieldset>
						</div>
					</td>
				</tr>
				<tr>
					<td valign="top" width="50%">
						<div id="buttonsDiv" style="visibility:hidden">
							<table>
								<tr>
									<td>
										<%
										//out.println("<input type='button' value='Start' onClick='AvviaMisuraManuale("+armingmode+","+source+","+samples+","+gatetime+","+clcksource+","+extclkfreq+","+inacoupling+","+inaterm+","+inatrigslope+","+inatriglevel+","+inatriglevellowlimit+","+inatrigleveluplimit+","+inbcoupling+","+inbterm+","+inbtrigslope+","+inbtriglevel+","+inbtriglevellowlimit+","+inbtrigleveluplimit+")'/></input>");
										out.println("<input type='button' id='measurebutton' value='Start' onClick=StartStopManualMeasurement('"+ip_host+"'); />");
										%>
										<input type="button" value="Reset parameters" onClick="ResetPage()" />
										<input type="button" value="Clear results" onClick="resetTableResults()" />
									</td>
								</tr>			
							</table>
							<!--
							<br>
							<table width="100%">
								<tr>
									<td>
										<%
											out.println("<input type='button' value='Execute command' onClick=DMSSocketConnection('"+ip_host+"')></input>");
										%>
										SCHDL;EXEC; <input type='text' id='cmdnum' size='2'>
									</td>
								</tr>
							</table>
							-->
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

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
var parent = "NULL";
var taskid = 0;
var checkTaskid = 0;
var taskStatus = "";
$('#measurementType').load('MeasurementTypeView.jsp');
</script>

<script>
function Stop(host_ip)
{
	var signalid = document.getElementById("signalSelect").value;
	var setupid = document.getElementById("setupSelect").value;
	var i = 0;
	var resarray;
	clearInterval(taskid);
	//checkTaskid = setInterval(function(){checkTaskStatus()},1000);
	$.get('http://'+host_ip+':8080/dms/StopManualMeasurementServlet?signalid='+signalid+'&setupid='+setupid+'&randvar='+random, 
		function(data)
		{
			
		}
	);
}
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
function EnableTemplate()
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
function EnableResults()
{
	document.getElementById("resultsDiv").style.visibility = 'visible';
	document.getElementById("buttonsDiv").style.visibility = 'visible';
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
	inatriglevelmin = 1.0;
	inatriglevelmax = 5.0;
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
	inbtriglevelmin = 1.0;
	inbtriglevelmax = 5.0;
}
</script>
<script>
function EnableParams()
{
	var setupid = document.getElementById("setupSelect").value;
	$('#setupParams').load('SetupParamsView.jsp?setupid='+setupid, function(){SaveParameters();});
	document.getElementById("setupParams").style.visibility = 'visible';
	// if (document.getElementById("timetype").checked)
	// {
		// document.getElementById("gateTimeParam").style.visibility = 'hidden';
		// document.getElementById("gateTimeLbl").style.visibility = 'hidden';
	// }
	EnableResults();
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
	// document.getElementById("measParams").style.visibility = 'hidden';
	// document.getElementById("signalSelect").selectedIndex = 0;
	// document.getElementById("timetype").disabled = true;
	// document.getElementById("timetype").checked = false;
	
	// document.getElementById("freqtype").disabled = true;
	// document.getElementById("freqtype").checked = false;
	
	// document.getElementById("templateSelect").disabled = true;	
	// document.getElementById("templateSelect").selectedIndex = 0;
}
</script>
<script>
//function AvviaMisuraManuale(armingmode,source,samples,gatetime,clcksource,extclkfreq,inacoupling,inaterm,inatrigslope,inatriglevel,inatriglevelmin,inatriglevelmax,inbcoupling,inbterm,inbtrigslope,inbtriglevel,inbtriglevelmin,inbtriglevelmax)
function StartStopManualMeasurement(host_ip)
{
	//alert(armingmode+" "+source+" "+samples+" "+gatetime+" "+inacoupling+" "+inaterm+" "+inatrigslope+" "+inatriglevel+" "+inbcoupling+" "+inbterm+" "+inbtrigslope+" "+inbtriglevel);
	var setupid = document.getElementById("setupSelect").value;
	if (document.getElementById("measurebutton").value == "Stop")
	{
		Stop(host_ip);		
		resetTableResults();
		document.getElementById("measurebutton").value = "Start";
	}
	else
	{
		var armgroup = document.getElementsByName("armgroup");
		var arm = 0;
		for(var i = 0; i < armgroup.length; i++) 
		{
			if(armgroup[i].checked == true) 
			{
				arm = armgroup[i].value;
			}
		}
		
		var sourcegroup = document.getElementsByName("sourcegroup");
		var src = 0;
		for(var i = 0; i < sourcegroup.length; i++) 
		{
			if(sourcegroup[i].checked == true) 
			{
				src = sourcegroup[i].value;
			}
		}
		
		var smp = 0;
		var samplesParam = document.getElementById("samplesParam");
		var smp = samplesParam.options[samplesParam.selectedIndex].value;

		var gatet = 0;
		var gateTimeParam = document.getElementById("gateTimeParam");
		var gatet = gateTimeParam.options[gateTimeParam.selectedIndex].value;
		
		var clocksourcegroup = document.getElementsByName("clocksourcegroup");
		var clksrc = 0;
		for(var i = 0; i < clocksourcegroup.length; i++) 
		{
			if(clocksourcegroup[i].checked == true) 
			{
				clksrc = clocksourcegroup[i].value;
			}
		}
		
		var extclockgroup = document.getElementsByName("extclockgroup");
		var extclckf = 0;
		for(var i = 0; i < extclockgroup.length; i++) 
		{
			if(extclockgroup[i].checked == true) 
			{
				extclckf = extclockgroup[i].value;
			}
		}
		
		var inputaCouplingGroup = document.getElementsByName("inputaCouplingGroup");
		var acoup = 0;
		for(var i = 0; i < inputaCouplingGroup.length; i++) 
		{
			if(inputaCouplingGroup[i].checked == true) 
			{
				acoup = inputaCouplingGroup[i].value;
			}
		}
		
		var inputaTermGroup = document.getElementsByName("inputaTermGroup");
		var aterm = 0;
		for(var i = 0; i < inputaTermGroup.length; i++) 
		{
			if(inputaTermGroup[i].checked == true) 
			{
				aterm = inputaTermGroup[i].value;
			}
		}
		
		var inputaTriggerGroup = document.getElementsByName("inputaTriggerGroup");
		var atrigs = 0;
		for(var i = 0; i < inputaTriggerGroup.length; i++) 
		{
			if(inputaTriggerGroup[i].checked == true) 
			{
				atrigs = inputaTriggerGroup[i].value;
			}
		}
		
		atriglev = document.getElementById("inputatriggerLevel").value;
		
		var inputbCouplingGroup = document.getElementsByName("inputbCouplingGroup");
		var bcoup = 0;
		for(var i = 0; i < inputbCouplingGroup.length; i++) 
		{
			if(inputbCouplingGroup[i].checked == true) 
			{
				bcoup = inputbCouplingGroup[i].value;
			}
		}
		
		var inputbTermGroup = document.getElementsByName("inputbTermGroup");
		var bterm = 0;
		for(var i = 0; i < inputbTermGroup.length; i++) 
		{
			if(inputbTermGroup[i].checked == true) 
			{
				bterm = inputbTermGroup[i].value;
			}
		}
		
		var inputbTriggerGroup = document.getElementsByName("inputbTriggerGroup");
		var btrigs = 0;
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
				var r=confirm("The template has been modified. Save the new template?")
				if (r==true)
				{
					// Chiamare servlet SaveSetupServlet
					alert("creo setup con setupid= "+setupid);
					$.get('http://'+host_ip+':8080/dms/CreateSetupServlet?setupid='+setupid+'&randvar='+random, 
						function(data)
						{
							alert(data);
						}
					);
					if (arm!=armingmode)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='5'&value='+arm+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (src!=source)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='4'&value='+src+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (smp!=samples)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='7'&value='+smp+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (gatet!=gatetime)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param=''&value='+gatet+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (acoup!=inacoupling)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='8'&value='+acoup+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (aterm!=inaterm)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='10'&value='+aterm+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (atrigs!=inatrigslope)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='14'&value='+atrigs+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (atriglev!=inatriglevel)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='12'&value='+atriglev+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (bcoup!=inbcoupling)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='9'&value='+bcoup+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (bterm!=inbterm)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='11'&value='+bterm+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (btrigs!=inbtrigslope)
					{
						//Chiamare servlet SaveSetupParameterServle
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='15'&value='+btrigs+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					if (btriglev!=inbtriglevel)
					{
						//Chiamare servlet SaveSetupParameterServles
						// $.get('http://'+host_ip+':8080/dms/SaveSetupParameterServle?setupid='+setupid+'&param='13'&value='+btriglev+'&randvar='+random, 
							// function(data)
							// {
							// }
						// );
					}
					alert("New template saved"+'\n'+"Manual measurement started.");
				}
			}
			else
			{
				//alert("Manual measurement started.");
				var signalid = document.getElementById("signalSelect").value;
				var setupid = document.getElementById("setupSelect").value;
				document.getElementById("measurebutton").value = "Stop";
				//alert(signalid+" "+setupid);
				$.get('http://'+host_ip+':8080/dms/StartManualMeasurementServlet?signalid='+signalid+'&setupid='+setupid+'&parent='+parent+'&randvar='+random, 
					function(data)
					{
						alert(data);
						//if (data == "; OK")
						if (data == "")
						{
							taskid = setInterval(function(){getResults(host_ip)},1000);
						}
						else
						{
							//Stop(host_ip);
							document.getElementById("measurebutton").value = "Start";
							alert("SCHDL;EXEC; command failed");
						}
					}
				);
			}
		}
		var signalid = document.getElementById("signalSelect").value;
		var setupid = document.getElementById("setupSelect").value;
		document.getElementById("measurebutton").value = "Stop";
	}
}
</script>
<script>
function getResults(host_ip)
{
	var i = 0;
	var resarray;
	$.get('http://'+host_ip+':8080/dms/GetMeasurementResultsServlet?randvar='+random, 
		function(data)
		{
			//alert(data);
			if ((data != "Non sono disponibili risultati") && (taskStatus != 'executed'))
			{
				resarray = data.split(";");
				while (i < resarray.length-1)
				{
					fnClickAddRow(resarray[i],resarray[i+1]);
					i++;
					i++;
				}
				//taskStatus = resarray[resarray.length];
				//if (taskStatus == 'executed')
				//{
				//	Stop(host_ip);
				//}
				//fnClickAddRow(resarray[0],resarray[1]);
				//fnClickAddRow(resarray[2],resarray[3]);
				//fnClickAddRow(resarray[4],resarray[5]);
				//fnClickAddRow(resarray[6],resarray[7]);
			}
			else
			{
				alert("No results available");
				clearInterval(taskid);
			}
		}
	);
}
</script>
<script>
function DMSSocketConnection(ip_host)
{
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
	function fnClickAddRow(param1,param2,param3,param4) {
	$('#exectable').dataTable().fnAddData( [
		giCount, 
		param1,
		param2,
		param3,
		param4 ] );
	
	giCount++;
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
}
</script>
