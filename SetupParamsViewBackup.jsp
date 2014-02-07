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
	
	int armingmode = 0;
	int source = 0;
	int samples = 10;
	int gatetime = 10;
	int clcksource = 1;
	int extclkfreq = 0;
	int inacoupling = 0;
	int inaterm = 0;
	int inatrigslope = 0;
	double inatriglevel = 0;
	double inatriglevellowlimit = 0;
	double inatrigleveluplimit = 0;
	int inbcoupling = 0;
	int inbterm = 0;
	int inbtrigslope = 0;
	double inbtriglevel = 0;
	double inbtriglevellowlimit = 0;
	double inbtrigleveluplimit = 0;
	String checked="";
	
	String setupid = request.getParameter("setupid");
		
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
	
	//Query estrazione dati
	Statement statement = dbconn.createStatement();
	String q = "SELECT * FROM exp_vw_measurement_setups_info where ID ="+setupid;
	ResultSet rs = statement.executeQuery(q);
	while(rs.next())
	{
		if (rs.getString("Parameter_Coded_Name").equals("ARMM"))
		{
			armingmode = rs.getInt("Parameter_Value");
		}
		else if (rs.getString("Parameter_Coded_Name").equals("SIZE"))
		{
			samples = rs.getInt("Parameter_Value");
		}
		else if (rs.getString("Parameter_Coded_Name").equals("TCPL"))
		{
			if (rs.getInt("Parameter_Coded_ID") == 1)
			{
				inacoupling = rs.getInt("Parameter_Value");
			}
			else if (rs.getInt("Parameter_Coded_ID") == 2)
			{
				inbcoupling = rs.getInt("Parameter_Value");
			}
		}
		else if (rs.getString("Parameter_Coded_Name").equals("TERM"))
		{
			if (rs.getInt("Parameter_Coded_ID") == 1)
			{
				inaterm = rs.getInt("Parameter_Value");
			}
			else if (rs.getInt("Parameter_Coded_ID") == 2)
			{
				inbterm = rs.getInt("Parameter_Value");
			}
		}
		else if (rs.getString("Parameter_Coded_Name").equals("LEVL"))
		{
			if (rs.getInt("Parameter_Coded_ID") == 1)
			{
				inatriglevel = rs.getInt("Parameter_Value");
				inatriglevellowlimit = rs.getInt("Parameter_Lower_Limit");
				inatrigleveluplimit = rs.getInt("Parameter_Upper_Limit");
			}
			else if (rs.getInt("Parameter_Coded_ID") == 2)
			{
				inbtriglevel = rs.getInt("Parameter_Value");
				inbtriglevellowlimit = rs.getInt("Parameter_Lower_Limit");
				inbtrigleveluplimit = rs.getInt("Parameter_Upper_Limit");
			}
		}
		else if (rs.getString("Parameter_Coded_Name").equals("TSLP"))
		{
			if (rs.getInt("Parameter_Coded_ID") == 1)
			{
				inatrigslope = rs.getInt("Parameter_Value");
			}
			else if (rs.getInt("Parameter_Coded_ID") == 2)
			{
				inbtrigslope = rs.getInt("Parameter_Value");
			}
		}
		else if (rs.getString("Parameter_Coded_Name").equals("CLCK"))
		{
			clcksource = rs.getInt("Parameter_Value");
		}
		else if (rs.getString("Parameter_Coded_Name").equals("CLKF"))
		{
			extclkfreq = rs.getInt("Parameter_Value");
		}
		else if (rs.getString("Parameter_Coded_Name").equals("SRCE"))
		{
			source = rs.getInt("Parameter_Value");
		}
	}
%>


<table>
	<tr>
		<td>
			<fieldset id="el04"><legend>General Information</legend>
			<table>
				<tr class="label">
					<td>
						<b>Arming Mode:</b>
					</td>
					<td>
						<b>Source:</b>
					</td>
				</tr>
				<tr class="text">
					<td align="left" valign="top">
						<%
							if (armingmode == 1) checked = "checked";
							out.println("<input type='radio' name='armgroup' id='timearm' value='1' "+checked+"/>+time<br>");
							checked = "";
							if (armingmode == 5) checked = "checked";
							out.println("<input type='radio' name='armgroup' id='freqarm' value='5' "+checked+"/>1.0s gate");
							checked = "";
						%>				
					</td>
					<td align="left" valign="top">
						<%
							if (source == 0) checked = "checked";
							out.println("<input type='radio' name='sourcegroup' id='absource' value='0' "+checked+"/>Input A<br>");
							checked = "";
							if (source == 1) checked = "checked";
							out.println("<input type='radio' name='sourcegroup' id='basource' value='1' "+checked+"/>Input B");
							checked = "";
						%>
					</td>
				</tr>
				<tr class="label">
					<td>
						<b>Samples:</b>
					</td>
					<td>
						<b>Gate Time:</b>
					</td>
				</tr>
				<tr class="text">
					<td>
						<select class='custominput' name='samplesParam' id='samplesParam'>
						<%
							if (samples == 1) checked = "selected";
							out.println("<option value='1' "+checked+">1</option>");
							checked = "";
							if (samples == 2) checked = "selected";
							out.println("<option value='2' "+checked+">2</option>");
							checked = "";
							if (samples == 5) checked = "selected";
							out.println("<option value='5' "+checked+">5</option>");
							checked = "";
							if (samples == 10) checked = "selected";
							out.println("<option value='10' "+checked+">10</option>");
							checked = "";
							if (samples == 20) checked = "selected";
							out.println("<option value='20' "+checked+">20</option>");
							checked = "";
							if (samples == 50) checked = "selected";
							out.println("<option value='50' "+checked+">50</option>");
							checked = "";
							if (samples == 100) checked = "selected";
							out.println("<option value='100' "+checked+">100</option>");
							checked = "";
						%>				
						</select>
					</td>
					<td>
						<select class='custominput' name='gateTimeParam' id='gateTimeParam'>
						<%
							if (gatetime == 1) checked = "selected";
							out.println("<option value='1' "+checked+">1</option>");
							checked = "";
							if (gatetime == 2) checked = "selected";
							out.println("<option value='2' "+checked+">2</option>");
							checked = "";
							if (gatetime == 5) checked = "selected";
							out.println("<option value='5' "+checked+">5</option>");
							checked = "";
							if (gatetime == 10) checked = "selected";
							out.println("<option value='10' "+checked+">10</option>");
							checked = "";
							if (gatetime == 20) checked = "selected";
							out.println("<option value='20' "+checked+">20</option>");
							checked = "";
							if (gatetime == 50) checked = "selected";
							out.println("<option value='50' "+checked+">50</option>");
							checked = "";
							if (gatetime == 100) checked = "selected";
							out.println("<option value='100' "+checked+">100</option>");
							checked = "";
							if (gatetime == 500) checked = "selected";
							out.println("<option value='100' "+checked+">100</option>");
							checked = "";
						%>
						</select>
					</td>
				</tr>
				<tr class="label">
					<td>
						<b><font color="grey">Clock Source:</font></b>
					</td>
					<td>
						<b><font color="grey">External Clock<br>Frequency:</font></b>
					</td>
				</tr>
				<tr class="text">
					<td align="left" valign="top">
						<%
							if (clcksource == 0) checked = "checked";
							out.println("<input type='radio' name='clocksourcegroup' id='intclock' value='0' disabled "+checked+"/>Internal<br>");
							checked = "";
							if (clcksource == 1) checked = "checked";
							out.println("<input type='radio' name='clocksourcegroup' id='extclock' value='1' disabled "+checked+" />External");
							checked = "";
						%>	
					</td>
					<td align="left" valign="top">
						<%
							if (extclkfreq == 0) checked = "checked";
							out.println("<input type='radio' name='extclockgroup' id='extclockfreq10mhz' value='0' disabled "+checked+" />10 MHz<br>");
							checked = "";
							if (extclkfreq == 1) checked = "checked";
							out.println("<input type='radio' name='extclockgroup' id='extclockfreq5mhz' value='1' disabled "+checked+"/>5 MHz");
							checked = "";
						%>
					</td>
				</tr>
			</table>
			</fieldset>
		</td>
		<td>
			<table>
				<tr class="label">
					<td>
					</td>
				</tr>
				<tr class="text">
					<td>
					</td>
				</tr>
				<tr class="label">
					<td>
					</td>
				</tr>
				<tr class="text">
					<td>
					</td>
				</tr>
				<tr class="label">
					<td>
					</td>
				</tr>
				<tr class="text">
					<td>
					</td>
				</tr>
				<tr class="label">
					<td>
					</td>
				</tr>
				<tr class="text">
					<td>
					</td>
				</tr>
			</table>
		</td>
		<td>
			<table>
				<tr>
					<td>
					</td>
				</tr>
				<tr>
					<td>
					</td>
				</tr>
				<tr>
					<td>
					</td>
				</tr>
				<tr>
					<td>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="label">
		<td>
			<b>Arming Mode:</b>
		</td>
		<td>
			<b>Source:</b>
		</td>
		<td>
			<b>Samples:</b>
		</td>
		<td>
			<div id="gateTimeLbl"><b>Gate Time:</b></div>
		</td>
		<td>
			<b><font color="grey">Clock Source:</font></b>
		</td>
		<td>
			<b><font color="grey">External Clock Frequency:</font></b>
		</td>
	</tr>
	<tr class="text">
		<td align="left" valign="top">
			<%
				if (armingmode == 1) checked = "checked";
				out.println("<input type='radio' name='armgroup' id='timearm' value='1' "+checked+"/>+time<br>");
				checked = "";
				if (armingmode == 5) checked = "checked";
				out.println("<input type='radio' name='armgroup' id='freqarm' value='5' "+checked+"/>1.0s gate");
				checked = "";
			%>				
		</td>
		<td align="left" valign="top">
			<%
				if (source == 0) checked = "checked";
				out.println("<input type='radio' name='sourcegroup' id='absource' value='0' "+checked+"/>Input A<br>");
				checked = "";
				if (source == 1) checked = "checked";
				out.println("<input type='radio' name='sourcegroup' id='basource' value='1' "+checked+"/>Input B");
				checked = "";
			%>
		</td>
		<td align="left" valign="top">
			<select class='custominput' name='samplesParam' id='samplesParam'>
			<%
				if (samples == 1) checked = "selected";
				out.println("<option value='1' "+checked+">1</option>");
				checked = "";
				if (samples == 2) checked = "selected";
				out.println("<option value='2' "+checked+">2</option>");
				checked = "";
				if (samples == 5) checked = "selected";
				out.println("<option value='5' "+checked+">5</option>");
				checked = "";
				if (samples == 10) checked = "selected";
				out.println("<option value='10' "+checked+">10</option>");
				checked = "";
				if (samples == 20) checked = "selected";
				out.println("<option value='20' "+checked+">20</option>");
				checked = "";
				if (samples == 50) checked = "selected";
				out.println("<option value='50' "+checked+">50</option>");
				checked = "";
				if (samples == 100) checked = "selected";
				out.println("<option value='100' "+checked+">100</option>");
				checked = "";
			%>				
			</select>
		</td>
		<td align="left" valign="top">
			<select class='custominput' name='gateTimeParam' id='gateTimeParam'>
			<%
				if (gatetime == 1) checked = "selected";
				out.println("<option value='1' "+checked+">1</option>");
				checked = "";
				if (gatetime == 2) checked = "selected";
				out.println("<option value='2' "+checked+">2</option>");
				checked = "";
				if (gatetime == 5) checked = "selected";
				out.println("<option value='5' "+checked+">5</option>");
				checked = "";
				if (gatetime == 10) checked = "selected";
				out.println("<option value='10' "+checked+">10</option>");
				checked = "";
				if (gatetime == 20) checked = "selected";
				out.println("<option value='20' "+checked+">20</option>");
				checked = "";
				if (gatetime == 50) checked = "selected";
				out.println("<option value='50' "+checked+">50</option>");
				checked = "";
				if (gatetime == 100) checked = "selected";
				out.println("<option value='100' "+checked+">100</option>");
				checked = "";
				if (gatetime == 500) checked = "selected";
				out.println("<option value='100' "+checked+">100</option>");
				checked = "";
			%>
			</select>
		</td>
		<td align="left" valign="top">
			<%
				if (clcksource == 0) checked = "checked";
				out.println("<input type='radio' name='clocksourcegroup' id='intclock' value='0' disabled "+checked+"/>Internal<br>");
				checked = "";
				if (clcksource == 1) checked = "checked";
				out.println("<input type='radio' name='clocksourcegroup' id='extclock' value='1' disabled "+checked+" />External");
				checked = "";
			%>	
		</td>
		<td align="left" valign="top">
			<%
				if (extclkfreq == 0) checked = "checked";
				out.println("<input type='radio' name='extclockgroup' id='extclockfreq10mhz' value='0' disabled "+checked+" />10 MHz<br>");
				checked = "";
				if (extclkfreq == 1) checked = "checked";
				out.println("<input type='radio' name='extclockgroup' id='extclockfreq5mhz' value='1' disabled "+checked+"/>5 MHz");
				checked = "";
			%>
		</td>
	</tr>
</table>
<br>
<b>INPUT A</b>
<table>
	<tr class="label">
		<td>
			Coupling:
		</td>
		<td>
			Termination:
		</td>
		<td>
			Trigger Slope:
		</td>
		<td>
			Trigger Level:
		</td>
	</tr>
	<tr class="text">			
		<td align="left" valign="top">
			<%
				if (inacoupling == 0) checked = "checked";
				out.println("<input type='radio' name='inputaCouplingGroup' id='dccouplig' value='0' "+checked+" />DC<br>");
				checked = "";
				if (inacoupling == 1) checked = "checked";
				out.println("<input type='radio' name='inputaCouplingGroup' id='accoupling' value='1' "+checked+"/>AC");
				checked = "";
			%>
		</td>
		<td align="left" valign="top">
			<%
				if (inaterm == 0) checked = "checked";
				out.println("<input type='radio' name='inputaTermGroup' id='50qterm' value='0' "+checked+" />50 ohm<br>");
				checked = "";
				if (inaterm == 1) checked = "checked";
				out.println("<input type='radio' name='inputaTermGroup' id='1mqterm' value='1' "+checked+"/>1 Mohm");
				checked = "";
			%>
		</td>
		<td align="left" valign="top">
			<%
				if (inatrigslope == 0) checked = "checked";
				out.println("<input type='radio' name='inputaTriggerGroup' id='risingtrigger' value='0' "+checked+" />Rising<br>");
				checked = "";
				if (inatrigslope == 1) checked = "checked";
				out.println("<input type='radio' name='inputaTriggerGroup' id='fallingtrigger' value='1' "+checked+"/>Falling");
				checked = "";
			%> 
		</td>
		<td>
			<input type="number" id="inputatriggerLevel" min="1.00" max="5.00" step="0.01" value="1.00" >
			<!--<select class='custominput' name='inputatriggerLevel' id='inputatriggerLevel'>-->
			<%
				/*
				if (inatriglevel == 0) checked = "selected";
				out.println("<option value='0' "+checked+">0.0</option>");
				checked = "";
				if (inatriglevel == 1) checked = "selected";
				out.println("<option value='1' "+checked+">1.0</option>");
				checked = "";
				if (inatriglevel == 2) checked = "selected";
				out.println("<option value='2' "+checked+">2.0</option>");
				checked = "";
				if (inatriglevel == 3) checked = "selected";
				out.println("<option value='3' "+checked+">3.0</option>");
				checked = "";
				if (inatriglevel == 4) checked = "selected";
				out.println("<option value='4' "+checked+">4.0</option>");
				checked = "";
				if (inatriglevel == 5) checked = "selected";
				out.println("<option value='5' "+checked+">5.0</option>");
				checked = "";
				*/
			%>
			<!--</select>-->
		</td>
	</tr>
</table>
<br>
<b>INPUT B</b>
<table>
	<tr class="label">
		<td>
			Coupling:
		</td>
		<td>
			Termination:
		</td>
		<td>
			Trigger Slope:
		</td>
		<td>
			Trigger Level:
		</td>
	</tr>
	<tr class="text">
		<td align="left" valign="top">
			<%
				if (inbcoupling == 0) checked = "checked";
				out.println("<input type='radio' name='inputbCouplingGroup' id='dccouplig' value='0' "+checked+" />DC<br>");
				checked = "";
				if (inbcoupling == 1) checked = "checked";
				out.println("<input type='radio' name='inputbCouplingGroup' id='accoupling' value='1' "+checked+"/>AC");
				checked = "";
			%>
		</td>
		<td align="left" valign="top">
			<%
				if (inbterm == 0) checked = "checked";
				out.println("<input type='radio' name='inputbTermGroup' id='50qterm' value='0' "+checked+" />50 ohm<br>");
				checked = "";
				if (inbterm == 1) checked = "checked";
				out.println("<input type='radio' name='inputbTermGroup' id='1mqterm' value='1' "+checked+"/>1 Mohm");
				checked = "";
			%>
		</td>
		<td align="left" valign="top">
			<%
				if (inbtrigslope == 0) checked = "checked";
				out.println("<input type='radio' name='inputbTriggerGroup' id='risingtrigger' value='0' "+checked+" />Rising<br>");
				checked = "";
				if (inbtrigslope == 1) checked = "checked";
				out.println("<input type='radio' name='inputbTriggerGroup' id='fallingtrigger' value='1' "+checked+"/>Falling");
				checked = "";
			%> 
		</td>
		<td>
			<input type="number" id="inputbtriggerLevel" min="1.00" max="5.00" step="0.01" value="1.00" >
			<!--<select class='custominput' name='inputbtriggerLevel' id='inputbtriggerLevel'>-->
			<%
				/*
				if (inbtriglevel == 0) checked = "selected";
				out.println("<option value='0' "+checked+">0.0</option>");
				checked = "";
				if (inbtriglevel == 1) checked = "selected";
				out.println("<option value='1' "+checked+">1.0</option>");
				checked = "";
				if (inbtriglevel == 2) checked = "selected";
				out.println("<option value='2' "+checked+">2.0</option>");
				checked = "";
				if (inbtriglevel == 3) checked = "selected";
				out.println("<option value='3' "+checked+">3.0</option>");
				checked = "";
				if (inbtriglevel == 4) checked = "selected";
				out.println("<option value='4' "+checked+">4.0</option>");
				checked = "";
				if (inbtriglevel == 5) checked = "selected";
				out.println("<option value='5' "+checked+">5.0</option>");
				checked = "";
				*/
			%>
			<!--</select>-->
		</td>
	</tr>
</table>
<div>
	<table>
		<tr>
			<td>
				<%
				out.println("<input type='button' value='Start' onClick='AvviaMisuraManuale("+armingmode+","+source+","+samples+","+gatetime+","+clcksource+","+extclkfreq+","+inacoupling+","+inaterm+","+inatrigslope+","+inatriglevel+","+inatriglevellowlimit+","+inatrigleveluplimit+","+inbcoupling+","+inbterm+","+inbtrigslope+","+inbtriglevel+","+inbtriglevellowlimit+","+inbtrigleveluplimit+")'/></input>");
				%>
				<input type="button" value="Reset" onClick="ResetPage()" />
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="Vai" onClick="Vai()" />
				<input type="button" value="Ferma" onClick="Ferma()" />
			</td>
		</tr>
	</table>
	<br>
	<table width="100%">
		<tr>
			<td>
			Execution results:
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td>
				<textarea rows="4" cols="50">
				</textarea>
			</td>
			<td align="right">
				<%
					out.println("<input type='button' value='Execute command' onClick=DMSSocketConnection('"+ip_host+"')></input>");
				%>
				SCHDL;EXEC; <input type='text' id='cmdnum' size='2'>
			</td>
		</tr>
	</table>
</div>

</body>
</html>

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
<script>
function ResetPage()
{
	document.getElementById("measParams").style.visibility = 'hidden';
	document.getElementById("signalSelect").selectedIndex = 0;
	document.getElementById("timetype").disabled = true;
	document.getElementById("timetype").checked = false;
	
	document.getElementById("freqtype").disabled = true;
	document.getElementById("freqtype").checked = false;
	
	document.getElementById("templateSelect").disabled = true;	
	document.getElementById("templateSelect").selectedIndex = 0;
}
</script>
<script>
function AvviaMisuraManuale(armingmode,source,samples,gatetime,clcksource,extclkfreq,inacoupling,inaterm,inatrigslope,inatriglevel,inatriglevelmin,inatriglevelmax,inbcoupling,inbterm,inbtrigslope,inbtriglevel,inbtriglevelmin,inbtriglevelmax)
{
	//alert(armingmode+" "+source+" "+samples+" "+gatetime+" "+clcksource+" "+extclkfreq+" "+inacoupling+" "+inaterm+" "+inatrigslope+" "+inatriglevel+" "+inbcoupling+" "+inbterm+" "+inbtrigslope+" "+inbtriglevel);
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
		if ((arm!=armingmode) || (src!=source) || (smp!=samples) || (gatet!=gatetime) || (clksrc!=clcksource) || (extclckf!=extclkfreq) ||
		   (acoup!=inacoupling) || (aterm!=inaterm) || (atrigs!=inatrigslope) || (atriglev!=inatriglevel) ||
		   (bcoup!=inbcoupling) || (bterm!=inbterm) || (btrigs!=inbtrigslope) || (btriglev!=inbtriglevel))
		{
			var r=confirm("The template has been modified. Save the new template?")
			if (r==true)
			{
				alert("New template saved"+'\n'+"Manual measurement started.");
			}
			/*
			alert(arm+","+armingmode);
			alert(src+","+source);
			alert(smp+","+samples);
			alert(gatet+","+gatetime);
			alert(clksrc+","+clcksource);
			alert(extclckf+","+extclkfreq);
			alert(acoup+","+inacoupling);
			alert(aterm+","+inaterm);
			alert(atrigs+","+inatrigslope);
			alert(atriglev+","+inatriglevel);
			alert(bcoup+","+inbcoupling);
			alert(bterm+","+inbterm);
			alert(btrigs+","+inbtrigslope);
			alert(btriglev+","+inbtriglevel);
			*/
		}
		else
		{
			alert("Manual measurement started.");
		}
	}
}
</script>


