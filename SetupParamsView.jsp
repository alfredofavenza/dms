<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="dbmanager.DBConnectionManager"%> 


<!-- HTML -->
<html>
<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />
<head>
</head>
<body>
<%
	Connection dbconn = null;
	
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
	String meastype = request.getParameter("meastype");
		
	dbconn = ((DBConnectionManager)(session.getAttribute("sess_dbconn"))).getDBConnection();
	
	//Query estrazione dati
	Statement statement = dbconn.createStatement();
	if (!setupid.equals(""))
	{
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
		rs.close();
	}
	statement.close();
//	dbconn.close();	
%>

<fieldset id="parametersBox"><legend>Setup Parameters</legend>
<div align="right"><a href="#" onClick="ResetPage()";>Reset Parameters</a></div>
<table>
	<tr>
		<td valign="top">
			<fieldset id="el05"><legend>General Information</legend>
			<table>
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
						<b>Gate Time:</b>
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
						
						<%
							String enabled = "disabled";
							if (meastype.equals("2"))
							{
								enabled = "enabled";
							}
							out.println("<select class='custominput' name='gateTimeParam' id='gateTimeParam' "+enabled+">");
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
				<!--
				<tr class="label">
					<td>
						<b>Clock Source:</font></b>
					</td>
					<td>
						<b>External Clock<br>Frequency:</font></b>
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
				-->
			</table>
			</fieldset>
		</td>
		<td>
			<fieldset id="el05"><legend>Input A</legend>
			<table>
				<tr class="label">
					<td>
						<b>Coupling:</b>
					</td>
					<td>
						<b>Termination:</b>
					</td>
				</tr>
				<tr class="text">
					<td align="left" valign="top">
						<%
							if (inacoupling == 0) checked = "checked";
							out.println("<input type='radio' name='inputaCouplingGroup' id='inputadccouplig' value='0' "+checked+" />DC<br>");
							checked = "";
							if (inacoupling == 1) checked = "checked";
							out.println("<input type='radio' name='inputaCouplingGroup' id='inputaaccoupling' value='1' "+checked+"/>AC");
							checked = "";
						%>
					</td>
					<td align="left" valign="top">
						<%
							if (inaterm == 0) checked = "checked";
							out.println("<input type='radio' name='inputaTermGroup' id='inputa50qterm' value='0' "+checked+" />50 ohm<br>");
							checked = "";
							if (inaterm == 1) checked = "checked";
							out.println("<input type='radio' name='inputaTermGroup' id='inputa1mqterm' value='1' "+checked+"/>1 Mohm");
							checked = "";
						%>
					</td>
				</tr>
				<tr class="label">
					<td>
						<b>Trigger Slope:</b>
					</td>
					<td>
						<b>Trigger Level:</b>
					</td>
				</tr>
				<tr class="text">
					<td align="left" valign="top">
						<%
							if (inatrigslope == 0) checked = "checked";
							out.println("<input type='radio' name='inputaTriggerGroup' id='inputarisingtrigger' value='0' "+checked+" />Rising<br>");
							checked = "";
							if (inatrigslope == 1) checked = "checked";
							out.println("<input type='radio' name='inputaTriggerGroup' id='inputafallingtrigger' value='1' "+checked+"/>Falling");
							checked = "";
						%> 
					</td>
					<td>
						<!--<input type="number" id="inputatriggerLevel" min="1.00" max="5.00" step="0.01" value="1.00" >-->
						<%
							out.println("<input type='number' id='inputatriggerLevel' min="+inatriglevellowlimit+" max="+inatrigleveluplimit+" step='0.01' value="+inatriglevel+" >");
						%>
					</td>
				</tr>
			</table>
			</fieldset>
		</td>
		<td>
			<fieldset id="el05"><legend>Input B</legend>
			<table>
				<tr class="label">
					<td>
						<b>Coupling:</b>
					</td>
					<td>
						<b>Termination:</b>
					</td>
				</tr>
				<tr class="text">
					<td align="left" valign="top">
						<%
							if (inbcoupling == 0) checked = "checked";
							out.println("<input type='radio' name='inputbCouplingGroup' id='inputbdccouplig' value='0' "+checked+" />DC<br>");
							checked = "";
							if (inbcoupling == 1) checked = "checked";
							out.println("<input type='radio' name='inputbCouplingGroup' id='inputbaccoupling' value='1' "+checked+"/>AC");
							checked = "";
						%>
					</td>
					<td>
						<%
							if (inbterm == 0) checked = "checked";
							out.println("<input type='radio' name='inputbTermGroup' id='inputb50qterm' value='0' "+checked+" />50 ohm<br>");
							checked = "";
							if (inbterm == 1) checked = "checked";
							out.println("<input type='radio' name='inputbTermGroup' id='inputb1mqterm' value='1' "+checked+"/>1 Mohm");
							checked = "";
						%>
					</td>
				</tr>
				<tr class="label">
					<td>
						<b>Trigger Slope:</b>
					</td>
					<td>
						<b>Trigger Level:</b>
					</td>
				</tr>
				<tr class="text">
					<td>
						<%
							if (inbtrigslope == 0) checked = "checked";
							out.println("<input type='radio' name='inputbTriggerGroup' id='inputbrisingtrigger' value='0' "+checked+" />Rising<br>");
							checked = "";
							if (inbtrigslope == 1) checked = "checked";
							out.println("<input type='radio' name='inputbTriggerGroup' id='inputbfallingtrigger' value='1' "+checked+"/>Falling");
							checked = "";
						%> 
					</td>
					<td>
						<!--<input type="number" id="inputbtriggerLevel" min="1.00" max="5.00" step="0.01" value="1.00" >-->
						<%
							out.println("<input type='number' id='inputbtriggerLevel' min="+inbtriglevellowlimit+" max="+inbtrigleveluplimit+" step='0.01' value="+inbtriglevel+" >");
						%>
					</td>
				</tr>
			</table>
			</fieldset>
		</td>
	</tr>
</table>
</fieldset>

</body>
</html>


