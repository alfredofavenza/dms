<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>

<!-- HTML -->
<html>
<head>
</head>
<body>

<fieldset id="el05"><legend>Statistics</legend>
<table width="100%">
	<tr class="label">
		<td align="left" id="meanStatLbl"><b>Mean (ns):</b></td>
		<td align="left" id="minStatLbl"><b>Min (ns):</b></td>
		<td align="left" id="maxStatLbl"><b>Max (ns):</b></td>
	</tr>
	<tr class="text">
		<td align="left" valign="center" id="meanStat"></td>
		<td align="left" valign="center" id="minStat"></td>
		<td align="left" valign="center" id="maxStat"></td>
	</tr>
</table>

</fieldset>

</body>
</html>


