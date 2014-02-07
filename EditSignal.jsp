<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 


<!-- HTML -->
<html>
<head>
</head>
<body>
Edit Signal
<br>
<br>
<%
	String user_db = DmsMng.dbuser;
	String pwd_db = DmsMng.dbpwd;
	String ip_db = DmsMng.dbHostIp;
	String ip_host = DmsMng.webHostIp;
	String name_db = DmsMng.dbName;
	
	//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
	//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
	
	String id = request.getParameter("param");
	Connection dbconn = null;
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
	Statement statement = dbconn.createStatement();
	String q = "SELECT * FROM phy_signal where id="+id;
	ResultSet rs = statement.executeQuery(q);
	String description = "";
	String name = "";
	int signalClassId = 0;
	int channel = 0;
	int enabled = 0;
	double delay = 0.0;
	double offset = 0.0;
	String historyDesc = "";
	while (rs.next())
	{
		name = rs.getString("name");
		description = rs.getString("description");
		signalClassId = rs.getInt("signal_class_id");
		channel = rs.getInt("channel");
		enabled = rs.getInt("enabled");
		Statement statement1 = dbconn.createStatement();
		String q1 = "SELECT delay, offset, description FROM signal_history where signal_id="+id;
		ResultSet rs1 = statement1.executeQuery(q1);
		while(rs1.next())
		{
			delay = rs1.getDouble("delay");
			offset = rs1.getDouble("offset");
			historyDesc = rs1.getString("description");
		}
		rs1.close();
		statement1.close();
	}
%>
	<table id="editSignalRecord">
	<tr class="label">
		<td id = "nameLbl">
			Name:
		</td>
		<td>
			Description:
		</td>
	</tr>
	<tr class="text">
		<td valign="top">
			<%
				out.println("<input id='editsignalname' type='text' class='custominput' maxlength='45' value='"+name+"' onClick='resetNameLbl();' disabled/>");
			%>
		</td>
		<td>
			<%
				out.println("<textarea class='custominput' id='editsignaldesc' cols='30' rows='2' style='resize:none;'>"+description+"</textarea>");
			%>
		</td>
	<tr class="label">
		<td>
			Class:
		</td>
		<td>
			Associated Channel:
		</td>
	</tr>
	<tr class="text">
		<td>
			<%
				Statement statement2 = dbconn.createStatement();
				String q2 = "SELECT id, name from signal_class";
				ResultSet rs2 = statement2.executeQuery(q2);
				out.println("<select class='custominput' name='editsignalclass' id='editsignalclass' disabled>");
				while(rs2.next())
				{
					if (rs2.getInt("id") == signalClassId) out.println("<option value='"+rs2.getInt("id")+"' selected>"+rs2.getString("name")+"</option>");
					else out.println("<option value='"+rs2.getInt("id")+"'>"+rs2.getString("name")+"</option>");
				}
				out.println("</select>");
			%>
		</td>
		<td>
			<%
				q2 = "SELECT Free_Channel from vw_available_channels";
				rs2 = statement2.executeQuery(q2);
				out.println("<select class='custominput' name='editsignalchannel' id='editsignalchannel'>");
				out.println("<option value='"+channel+"' selected>"+channel+"</option>");
				while(rs2.next())
				{
					//if (rs2.getInt("Free_Channel") == channel) out.println("<option value='"+rs2.getInt("Free_Channel")+"' selected>"+rs2.getInt("Free_Channel")+"</option>");
					out.println("<option value='"+rs2.getInt("Free_Channel")+"'>"+rs2.getInt("Free_Channel")+"</option>");
				}
				out.println("</select>");
				rs.close();
				rs2.close();
				statement.close();
				statement2.close();
				dbconn.close();
			%>
		</td>
	</tr>
	<tr class="label">
		<td>
			Enabled:
		</td>
	</tr>
	<tr class="text">
		<td>
			<%
				if (enabled == 1) out.println("<input class='custominput' id='editsignalenabled' type='checkbox' checked>");
				else out.println("<input class='custominput' id='editsignalenabled' type='checkbox'>");
			%>
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
			<%
				out.println("<input id='editsignaldelay' type='text' class='custominput' size='25' value='"+delay*(1000000000)+"'");
			%>
		</td>
		<td>
			<%
				out.println("<input id='editsignaloffset' type='text' class='custominput' size='25' value='"+offset*(1000000000)+"'");
			%>
		</td>
	</tr>
	<tr class="label">
		<td>
			Change Description:
		</td>
	</tr>
	<tr class="text">
		<td>
			<%
				out.println("<textarea class='custominput' id='editsignalhd' cols='30' rows='2' style='resize:none;'>"+historyDesc+"</textarea>");
			%>
		</td>
	</tr>
</table>
<br>
<%
out.println("<input type='button' value='Apply' onclick=OkEditSignal("+id+",'"+ip_host+"');></input>");
%>
<input type="button" value="Cancel" onclick="CancelEditSignal();"/>
</body>

<!-- SCRIPT -->
<script>
	function resetNameLbl()
	{
		document.getElementById("nameLbl").innerHTML = "Name:";
	}
</script>

<script type="text/javascript" charset="utf-8">
	function OkEditSignal(id, ip_host){
		var random = new Date().getTime();
		var name = document.getElementById("editsignalname").value;
		if (name == "")
		{
			if ((document.getElementById('nameLbl').innerHTML).indexOf("Mandatory") == -1)
				document.getElementById("nameLbl").innerHTML = document.getElementById("nameLbl").innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			return;
		}
		var desc = document.getElementById("editsignaldesc").value;
		var sigclass = document.getElementById("editsignalclass").value;
		var channel = document.getElementById("editsignalchannel").value;
		var enabled;
		if (document.getElementById("editsignalenabled").checked) enabled = true;
		else enabled = false;
		var delay = document.getElementById("editsignaldelay").value*0.000000001;
		var offset = document.getElementById("editsignaloffset").value*0.000000001;
		var hdesc = document.getElementById("editsignalhd").value;
		$.get("http://"+ip_host+":8080/dms/UpdateSignalServlet?id="+id+"&name='"+name+"'&desc='"+desc+"'&sigclass="+sigclass+"&channel="+channel+"&enabled="+enabled+"&delay="+delay+"&offset="+offset+"&hdesc='"+hdesc+"'&randvar="+random);		
		alert("Signal succesfully updated.");
		$('#elemento').load("SignalView.jsp", "randvar="+random);
		if (document.getElementById("querytext") != null)
		{
			var query = document.getElementById("querytext").value;
			$('#container1').load('Visualize.jsp?param='+query+'&view_id=1', "randvar="+random);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function CancelEditSignal(){
		var random = new Date().getTime();
		$('#elemento').load('SignalView.jsp', "randvar="+random);
	}
</script>

</html>