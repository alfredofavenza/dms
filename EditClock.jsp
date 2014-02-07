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
Edit Clock
<br>
<br>
<%
	String id = request.getParameter("param");
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
	String q = "SELECT * FROM clock where id="+id;
	ResultSet rs = statement.executeQuery(q);
	String name = "";
	String serialNumber = "";
	int clockClassId = 0;
	int signalId = 0;
	int master = 0;
	int enabled = 0;
	while (rs.next())
	{
		name = rs.getString("name");
		serialNumber = rs.getString("serial_number");
		clockClassId = rs.getInt("clock_class_id");
		signalId = rs.getInt("signal_id");
		master = rs.getInt("master");
		enabled = rs.getInt("enabled");
	}
%>
<table id="editClockRecord">
	<tr class="label">
		<td id="editClockNameLbl">
			Name:
		</td>
		<td>
			Serial Number (4 digits):
		</td>
		<td>
			Class:
		</td>
	</tr>
	<tr class="text">
		<td>
			<%
				out.println("<input id='editclockname' type='text' class='custominput' size='25' value='"+name+"' onclick=ResetEditLbl('editClockNameLbl'); />");
			%>
		</td>
		<td>
			<%
				out.println("<input id='editclockserial' type='text' class='custominput' size='25' value='"+serialNumber+"' maxlength='4' disabled/>");
			%>
		</td>
		<td>
			<select name="editclockclasse" id="editclockclasse" class="custominput" disabled>
			<%
				rs = statement.executeQuery("Select id, name from clock_class");
				while (rs.next())
				{
					if (rs.getInt("id") == clockClassId)
					{
						out.println("<option value='"+rs.getInt("id")+"' selected>"+rs.getString("name")+"</option>");
					}
					else
					{
						out.println("<option value='"+rs.getInt("id")+"'>"+rs.getString("name")+"</option>");
					}
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
	</tr>
	<tr class="text">
		<td>
			<select name="editclocksignal" id="editclocksignal" class="custominput" >
			<%
				rs = statement.executeQuery("SELECT id, name FROM phy_signal");
				while (rs.next())
				{
					if (rs.getInt("id") == signalId)
					{
						out.println("<option value='"+rs.getInt("id")+"' selected>"+rs.getString("name")+"</option>");
					}
					else
					{
						out.println("<option value='"+rs.getInt("id")+"'>"+rs.getString("name")+"</option>");
					}
				}
			%>
			</select>
		</td>
		<td>
			<%
				if (master == 1) out.println("<input id='editclockmaster' type='checkbox' checked onclick='ChangeMaster();'/>");
				else out.println("<input id='editclockmaster' type='checkbox' onclick='ChangeMaster();'/>");
			%>
		</td>
		<td>
			<%
				if (master == 1)
				{
					if (enabled == 1) out.println("<input id='editclockenabled' type='checkbox' checked disabled>");
					else out.println("<input id='editclockenabled' type='checkbox' disabled>");
				}
				else
				{
					if (enabled == 1) out.println("<input id='editclockenabled' type='checkbox' checked>");
					else out.println("<input id='editclockenabled' type='checkbox'>");
				}
			%>
		</td>
		<td>
			<div style="visibility:hidden">
			<%
				if (master == 1) out.println("<input id='editclockmasterori' type='checkbox' checked>");
				else out.println("<input id='editclockmasterori' type='checkbox'>");
			%>
			</div>
		</td>
	</tr>
	<tr id="newMasterRow" class="text">
		<td>
		</td>
		<td>
			<div id="selectNewMaster" style="visibility:hidden">
			Choose a new master clock:<br>
			<select id="newmasterselect" class="custominput">
				<option></option>
				<%
				//q = "SELECT id, name FROM clock where ";
				q = "SELECT ID, Clock_Name FROM vw_exposed_clock_info where Is_Enabled = 1";
				rs = statement.executeQuery(q);
				while (rs.next())
				{
					//out.println("<option value="+rs.getInt("id")+">"+rs.getString("name")+"</option>");
					out.println("<option value="+rs.getInt("ID")+">"+rs.getString("Clock_Name")+"</option>");
				}
				rs.close();
				statement.close();
				dbconn.close();
				%>
			</select>
			</div>
		</td>
		<td>
		</td>
		<td>
		</td>
	</tr>
</table>
<br>
<%
out.println("<input type='button' value='Apply' onclick=ValidateClockEdit("+id+",'"+ip_host+"');></input>");
%>
<input type="button" value="Cancel" onclick="CancelEditClock();"/>
</body>


<!-- SCRIPT -->
<script>
	function ResetEditLbl(element)
	{
		if (element == "editClockNameLbl") document.getElementById(element).innerHTML = "Name:";
	}
</script>
<script type="text/javascript" charset="utf-8">
	function ValidateClockEdit(id, ip_host){
		var res = true;
		if (document.getElementById('editclockname').value == "")
		{
			if ((document.getElementById('editClockNameLbl').innerHTML).indexOf("Mandatory") == -1)
				document.getElementById('editClockNameLbl').innerHTML = document.getElementById('editClockNameLbl').innerHTML + " <font color=red size=2><i>Mandatory</i></font>";
			res = false;
		}
		if (res == true)
		{
			OkEditClock(id, ip_host);
		}
	}
</script>
<script>
	function ChangeMaster() {
		var master_ori = document.getElementById("editclockmasterori").checked;
		var master_set = document.getElementById("editclockmaster").checked;
		var enabled = document.getElementById("editclockenabled").checked;
		if (enabled == true)
		{
			if ((master_ori == true) && (master_set == false)) 
			{
				document.getElementById("selectNewMaster").style.visibility = 'visible';
				document.getElementById("editclockenabled").disabled = false;
			}
			else if ((master_ori == true) && (master_set == true)) 
			{
				document.getElementById("selectNewMaster").style.visibility = 'hidden';
			}
			//else if ((master_ori == false) && (master_set == true)) 
			//{
			//	alert("New master clock set");
			//}
		}
		else
		{
			alert("The clock must be enabled.");
			document.getElementById("editclockmaster").checked = false;
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function OkEditClock(id, ip_host){
		var random = new Date().getTime();
		var name = document.getElementById("editclockname").value;
		var serial = document.getElementById("editclockserial").value;
		var clockclass = document.getElementById("editclockclasse").value;
		var signal = document.getElementById("editclocksignal").value;
		var master_ori = document.getElementById("editclockmasterori").checked;
		var master_set = document.getElementById("editclockmaster").checked;
		var master;
		if (document.getElementById("editclockmaster").checked) master = true;
		else master = false;
		var enabled;
		if (document.getElementById("editclockenabled").checked) enabled = true;
		else enabled = false;
		var newmasterid = document.getElementById("newmasterselect").value;
		if ((document.getElementById("selectNewMaster").style.visibility == 'visible') && (newmasterid == ""))
		{
			alert("A new master clock must be selected.");
			return;
		}
		if (master_set == master_ori)
		{
			$.get("http://"+ip_host+":8080/dms/UpdateClockServlet?id="+id+"&name='"+name+"'&serial='"+serial+"'&clockclass="+clockclass+"&signal="+signal+"&master="+master+"&enabled="+enabled+"&newmasterid="+newmasterid+"&randvar="+random);
			alert("Clock succesfully updated.");
			$('#elemento2').load('ClockView.jsp', "randvar="+random);
		}
		else
		{
			if (confirm("A new master clock has been selected. Confirm?") == true)
			{
				$.get("http://"+ip_host+":8080/dms/UpdateClockServlet?id="+id+"&name='"+name+"'&serial='"+serial+"'&clockclass="+clockclass+"&signal="+signal+"&master="+master+"&enabled="+enabled+"&newmasterid="+newmasterid+"&randvar="+random);
				alert("Clock succesfully updated.");
				$('#elemento2').load('ClockView.jsp', "randvar="+random);
			}
			else
			{
				return;
			}
		}
		if ((document.getElementById("querytext")) != null)
		{
			var query = document.getElementById("querytext").value;
			random = new Date().getTime();
			$('#container1').load('Visualize.jsp?param='+query+'&view_id=2', "randvar="+random);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function CancelEditClock(){
		var random = new Date().getTime();
		$('#elemento2').load('ClockView.jsp', "randvar="+random);
	}
</script>

</html>