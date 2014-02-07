<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>

<%@ page import="dmsmanager.DmsMng"%> 


<!-- HTML -->
<html>
<head>
<!-- STYLE -->
<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />
</head>
<body>
<%
	String tableId = request.getParameter("table"); 
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
	ResultSet rs = null;
	java.util.Date date = null;
	String ts = null;
	String[] temp = null;
	int hh, mm, ss;
	String ss1 = null;
	date = new java.util.Date();
	ts = (new Timestamp(date.getTime())).toString();
	ts = ts.substring(11);
	temp = new String[4];
	temp = ts.split(":");
	hh = Integer.parseInt(temp[0]);
	mm = Integer.parseInt(temp[1]);
	ss1 = temp[2];
	ss1 = ss1.substring(0,2);
	ss = Integer.parseInt(ss1);
	int i = 0;
%>
<%
	if (tableId.equals("1"))
	{
		out.println("<table>");
		out.println("<tr class='label'>");
		out.println("<td id='datepickerTimeTagSteeringLbl'>");
		out.println("Applied at time (UTC):");
		out.println("</td>");
		out.println("<td id='timeSteeringLbl'>");
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr class='text'>");
		out.println("<td><div class='demo'><input class='custominput' id='datepickerTimeTagSteering' type='text' readonly='readonly' onClick=clearBox('datepickerTimeTagSteering');> </div></td>");
		out.println("<td>");
		out.println("<select class='custominput' name='hourTimeTagSteering' id='hourTimeTagSteering' onClick=clearBox('hourTimeTagSteering');>");
		out.println("<option value='00'>00</option>");
		out.println("<option value='01'>01</option>");
		out.println("<option value='02'>02</option>");
		out.println("<option value='03'>03</option>");
		out.println("<option value='04'>04</option>");
		out.println("<option value='05'>05</option>");
		out.println("<option value='06'>06</option>");
		out.println("<option value='07'>07</option>");
		out.println("<option value='08'>08</option>");
		out.println("<option value='09'>09</option>");
		for (i = 10; i < 24; i++)
		{
			out.println("<option value='"+i+"'>"+i+"</option>");
		}
		out.println("</select>:");
		out.println("<select class='custominput' name='minTimeTagSteering' id='minTimeTagSteering' onClick=clearBox('minTimeTagSteering');>");
		out.println("<option value='00'>00</option>");
		out.println("<option value='01'>01</option>");
		out.println("<option value='02'>02</option>");
		out.println("<option value='03'>03</option>");
		out.println("<option value='04'>04</option>");
		out.println("<option value='05'>05</option>");
		out.println("<option value='06'>06</option>");
		out.println("<option value='07'>07</option>");
		out.println("<option value='08'>08</option>");
		out.println("<option value='09'>09</option>");
		for (i = 10; i < 60; i++)
		{
			out.println("<option value='"+i+"'>"+i+"</option>");
		}
		out.println("</select>:");
		out.println("<select class='custominput' name='secTimeTagSteering' id='secTimeTagSteering' onClick=clearBox('secTimeTagSteering');>");
		out.println("<option value='00'>00</option>");
		out.println("<option value='01'>01</option>");
		out.println("<option value='02'>02</option>");
		out.println("<option value='03'>03</option>");
		out.println("<option value='04'>04</option>");
		out.println("<option value='05'>05</option>");
		out.println("<option value='06'>06</option>");
		out.println("<option value='07'>07</option>");
		out.println("<option value='08'>08</option>");
		out.println("<option value='09'>09</option>");
		for (i = 10; i < 60; i++)
		{
			out.println("<option value='"+i+"'>"+i+"</option>");
		}
		out.println("</select>");
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("<table>");
		out.println("<tr class='label'>");
		out.println("<td id='clockSteeringLbl'>");
		out.println("Master Clock:");
		out.println("</td>");
		out.println("<td id='freqCorrSteeringLbl'>");
		out.println("Frequency Correction (E-14):");
		out.println("</td>");
		out.println("<td id='driftCorrSteeringLbl'>");
		out.println("Drift Correction (E-15/day):");
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr class='text'>");
		out.println("<td>");
		rs = statement.executeQuery("Select id,name from clock where master=1");
		rs.next();
		out.println("<input class='custominput' type='float' name='clockSteering' id='clockSteering' value="+rs.getString("name")+" disabled>");
		out.println("</td>");
		out.println("<td>");
		out.println("<input class='custominput' type='float' name='freqCorrSteering' id='freqCorrSteering' onClick=clearBox('freqCorrSteering');clearBox('driftCorrSteering')>");
		out.println("</td>");
		out.println("<td>");
		out.println("<input class='custominput' type='float' name='driftCorrSteering' id='driftCorrSteering' onClick=clearBox('driftCorrSteering');clearBox('freqCorrSteering')>");
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr class='label'>");
		out.println("<td id='operatorSteeringLbl'>");
		out.println("Operator:");
		out.println("</td>");
		out.println("<td>");
		out.println("Description:");
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr class='text'>");
		out.println("<td valign='top'>");
		out.println("<input class='custominput' type='text' id='operatorSteering' size='5' maxlength='45' style='width:180' onClick=clearBox('operatorSteering'); />");
		out.println("</td>");
		out.println("<td>");
		//out.println("<input class='custominput' type='text' id='descriptionSteering' size='255' maxlength='255' style='width:200'>");
		out.println("<textarea class='custominput' id='descriptionSteering' cols='30' rows='2' style='resize:none;'></textarea>");
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
	}
	else if (tableId.equals("2"))
	{
		//Clock Step Event
		out.println("<table>");
		out.println("<tr class='label'>");
		out.println("<td id='datepickerTimeTagClockStepLbl'>");
		out.println("Occurred at time (UTC):");
		out.println("</td>");
		out.println("</td>");
		out.println("<td id='timeClockStepLbl'>");
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr class='text'>");
		out.println("<td><div class='demo'><input class='custominput' id='datepickerTimeTagClockStep' type='text' readonly='readonly' onClick=clearBox('datepickerTimeTagClockStep');> </div></td>");
		out.println("<td>");
		out.println("<select class='custominput' name='hourTimeTagClockStep' id='hourTimeTagClockStep' onClick=clearBox('hourTimeTagClockStep');>");
		out.println("<option value='00'>00</option>");
		out.println("<option value='01'>01</option>");
		out.println("<option value='02'>02</option>");
		out.println("<option value='03'>03</option>");
		out.println("<option value='04'>04</option>");
		out.println("<option value='05'>05</option>");
		out.println("<option value='06'>06</option>");
		out.println("<option value='07'>07</option>");
		out.println("<option value='08'>08</option>");
		out.println("<option value='09'>09</option>");
		for (i = 10; i < 24; i++)
		{
			out.println("<option value='"+i+"'>"+i+"</option>");
		}
		out.println("</select>:");
		out.println("<select class='custominput' name='minTimeTagClock' id='minTimeTagClock' onClick=clearBox('minTimeTagClock');>");
		out.println("<option value='00'>00</option>");
		out.println("<option value='01'>01</option>");
		out.println("<option value='02'>02</option>");
		out.println("<option value='03'>03</option>");
		out.println("<option value='04'>04</option>");
		out.println("<option value='05'>05</option>");
		out.println("<option value='06'>06</option>");
		out.println("<option value='07'>07</option>");
		out.println("<option value='08'>08</option>");
		out.println("<option value='09'>09</option>");
		for (i = 10; i < 60; i++)
		{
			out.println("<option value='"+i+"'>"+i+"</option>");
		}
		out.println("</select>:");
		out.println("<select class='custominput' name='secTimeTagClock' id='secTimeTagClock' onClick=clearBox('secTimeTagClock');>");
		out.println("<option value='00'>00</option>");
		out.println("<option value='01'>01</option>");
		out.println("<option value='02'>02</option>");
		out.println("<option value='03'>03</option>");
		out.println("<option value='04'>04</option>");
		out.println("<option value='05'>05</option>");
		out.println("<option value='06'>06</option>");
		out.println("<option value='07'>07</option>");
		out.println("<option value='08'>08</option>");
		out.println("<option value='09'>09</option>");
		for (i = 10; i < 60; i++)
		{
			out.println("<option value='"+i+"'>"+i+"</option>");
		}
		out.println("</select>");
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("<table>");
		out.println("<tr class='label'>");
		out.println("<td id='clockClockStepLbl'>");
		out.println("Affected Clock:");
		out.println("</td>");
		out.println("<td id='timeStepLbl'>");
		out.println("Time Step (ns):");
		out.println("</td>");
		out.println("<td id='freqStepLbl'>");
		out.println("Frequency Step (ns/day):");
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr class='text'>");
		out.println("<td>");
		rs = statement.executeQuery("Select id,name from clock");
		out.println("<select class='custominput' name='clockClockStep' id='clockClockStep' onClick=clearBox('clockClockStep');>");
		out.println("<option value=''></option>");
		int id;
		String name;
		while (rs.next()) {
			id = rs.getInt("id");
			name = rs.getString("name");
			out.println("<option value='"+id+"'>"+name+"</option>");
		}
		rs.close();
		statement.close();
		out.println("</select>");
		out.println("</td>");
		out.println("<td>");
		out.println("<input class='custominput' type='text' name='timeStep' id='timeStep' onClick=clearBox('timeStep');clearBox('freqStep')>");
		out.println("</td>");
		out.println("<td>");
		out.println("<input class='custominput' type='text' name='freqStep' id='freqStep' onClick=clearBox('freqStep');clearBox('timeStep')>");
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr class='label'>");
		out.println("<td id='operatorClockStepLbl'>");
		out.println("Operator:");
		out.println("</td>");
		out.println("<td>");
		out.println("Description:");
		out.println("</td>");
		out.println("</tr>");
		out.println("<tr class='text'>");
		out.println("<td valign='top'>");
		out.println("<input class='custominput' type='text' id='operatorClockStep' maxlength='45' onClick=clearBox('operatorClockStep'); />");
		out.println("</td>");
		out.println("<td>");
		//out.println("<input class='custominput' type='text' id='descriptionClockStep' maxlength='255'>");
		out.println("<textarea class='custominput' id='descriptionClockStep' cols='30' rows='2' style='resize:none;'></textarea>");
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
	}
	else if (tableId.equals("3"))
	{
		//Message Event
	}
	dbconn.close();
%>
<!--</table>-->
</body>


<!-- SCRIPT -->
<script src="datatables/css/picker/jquery-ui.min.js" type="text/javascript"></script>
<script src="datatables/css/picker/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
<script>
	$(function() {
		$( "#datepickerTimeTagSteering" ).datepicker({dateFormat: 'yy/mm/dd', maxDate: '+0'});
		$( "#datepickerTimeTagClockStep" ).datepicker({dateFormat: 'yy/mm/dd', maxDate: '+0'});
	});
</script>

</html>