<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;chars1et=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- STYLE -->

<!-- HTML -->
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
	String channelid = request.getParameter("chid");
	String path1 = "";
	String path2=  "";
%>
<div align='center'>
	Select a Channel
	<%
	//Query estrazione dati
	CallableStatement callst = dbconn.prepareCall("{call get_undefined_channels()}");
	ResultSet callrs;
	boolean results = callst.execute(); 
	out.println("<select class='custominput' name='createChannelName' id='createChannelName'>");
	while (results)
	{
		callrs = callst.getResultSet();
		while (callrs.next())
		{
			out.println(callrs.getInt("channel"));
			out.println("<option value='"+callrs.getInt("channel")+"'>"+callrs.getInt("channel")+"</option>");
		}
		callrs.close();
		results = callst.getMoreResults();
	}
	out.println("</select>");
	callst.close();
	dbconn.close();
	%>
</div>
<br>
<table style="width:100%">
	<tr>
		<td align="center">
		Plugin1
		</td>
		<td align="center">
		Plugin2
		</td>
	</tr>
	<tr>
<!-- PLUGIN 1 -->	
		<td>
			<table align="center">
			<tr align="center" style="background:#f1f1f1">
				<td></td>
				<td>0</td>
				<td>1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<%		
				Boolean relayFound = false;
				String editable = "";
				String relayStatus = "";
			%>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">0</td>
				<%
					out.println("<td><input type='radio' name='plug1group0' id='plug1group0' value='0' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group0' id='plug1group0' value='1' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group0' id='plug1group0' value='2' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group0' id='plug1group0' value='3' "+relayStatus+" "+editable+"></td>");
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">1</td>
				<%
					out.println("<td><input type='radio' name='plug1group1' id='plug1group1' value='10' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group1' id='plug1group1' value='11' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group1' id='plug1group1' value='12' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group1' id='plug1group1' value='13' "+relayStatus+" "+editable+"></td>");
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">2</td>
				<%
					out.println("<td><input type='radio' name='plug1group2' id='plug1group2' value='20' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group2' id='plug1group2' value='21' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group2' id='plug1group2' value='22' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group2' id='plug1group2' value='23' "+relayStatus+" "+editable+"></td>");
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">3</td>
				<%
					out.println("<td><input type='radio' name='plug1group3' id='plug1group3' value='30' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group3' id='plug1group3' value='31' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group3' id='plug1group3' value='32' "+relayStatus+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug1group3' id='plug1group3' value='33' "+relayStatus+" "+editable+"></td>");
				%>		
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">4</td>
				<%
					out.println("<td><input type='radio' name='plug1group4' id='plug1group4' value='40' "+relayStatus+" "+editable+"></td>");
				%>		
				<%
					out.println("<td><input type='radio' name='plug1group4' id='plug1group4' value='41' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group4' id='plug1group4' value='42' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group4' id='plug1group4' value='43' "+relayStatus+" "+editable+"></td>");
				%>				
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">5</td>
				<%
					out.println("<td><input type='radio' name='plug1group5' id='plug1group5' value='50' "+relayStatus+" "+editable+"></td>");
				%>		
				<%
					out.println("<td><input type='radio' name='plug1group5' id='plug1group5' value='51' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group5' id='plug1group5' value='52' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group5' id='plug1group5' value='53' "+relayStatus+" "+editable+"></td>");
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">6</td>
				<%
					out.println("<td><input type='radio' name='plug1group6' id='plug1group6' value='60' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group6' id='plug1group6' value='61' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group6' id='plug1group6' value='62' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group6' id='plug1group6' value='63' "+relayStatus+" "+editable+"></td>");
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">7</td>
				<%
					out.println("<td><input type='radio' name='plug1group7' id='plug1group7' value='70' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group7' id='plug1group7' value='71' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group7' id='plug1group7' value='72' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group7' id='plug1group7' value='73' "+relayStatus+" "+editable+"></td>");
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">8</td>
				<%
					out.println("<td><input type='radio' name='plug1group8' id='plug1group8' value='80' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group8' id='plug1group8' value='81' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group8' id='plug1group8' value='82' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group8' id='plug1group8' value='83' "+relayStatus+" "+editable+"></td>");
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">9</td>
				<%
					out.println("<td><input type='radio' name='plug1group9' id='plug1group9' value='90' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group9' id='plug1group9' value='91' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group9' id='plug1group9' value='92' "+relayStatus+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug1group9' id='plug1group9' value='93' "+relayStatus+" "+editable+"></td>");
				%>	
			</tr>
			</table>
		</td>
<!-- PLUGIN 2 -->		
		<td>
			<table align="center">
			<tr align="center" style="background:#f1f1f1">
				<td></td>
				<td>0</td>
				<td>1</td>
				<td>2</td>
				<td>3</td>
			</tr>
			<%		
				Boolean relayFound2 = false;
				String relayStatus2 = "";
			%>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">0</td>
				<%
					out.println("<td><input type='radio' name='plug2group0' id='plug2group0' value='0' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group0' id='plug2group0' value='1' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group0' id='plug2group0' value='2' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group0' id='plug2group0' value='3' "+relayStatus2+" "+editable+"></td>");
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">1</td>
				<%
					out.println("<td><input type='radio' name='plug2group1' id='plug2group1' value='10' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group1' id='plug2group1' value='11' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group1' id='plug2group1' value='12' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group1' id='plug2group1' value='13' "+relayStatus2+" "+editable+"></td>");
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">2</td>
				<%
					out.println("<td><input type='radio' name='plug2group2' id='plug2group2' value='20' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group2' id='plug2group2' value='21' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group2' id='plug2group2' value='22' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group2' id='plug2group2' value='23' "+relayStatus2+" "+editable+"></td>");
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">3</td>
				<%
					out.println("<td><input type='radio' name='plug2group3' id='plug2group3' value='30' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group3' id='plug2group3' value='31' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group3' id='plug2group3' value='32' "+relayStatus2+" "+editable+"></td>");
				%>
				<%
					out.println("<td><input type='radio' name='plug2group3' id='plug2group3' value='33' "+relayStatus2+" "+editable+"></td>");
				%>		
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">4</td>
				<%
					out.println("<td><input type='radio' name='plug2group4' id='plug2group4' value='40' "+relayStatus2+" "+editable+"></td>");
				%>		
				<%
					out.println("<td><input type='radio' name='plug2group4' id='plug2group4' value='41' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group4' id='plug2group4' value='42' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group4' id='plug2group4' value='43' "+relayStatus2+" "+editable+"></td>");
				%>				
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">5</td>
				<%
					out.println("<td><input type='radio' name='plug2group5' id='plug2group5' value='50' "+relayStatus2+" "+editable+"></td>");
				%>		
				<%
					out.println("<td><input type='radio' name='plug2group5' id='plug2group5' value='51' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group5' id='plug2group5' value='52' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group5' id='plug2group5' value='53' "+relayStatus2+" "+editable+"></td>");
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">6</td>
				<%
					out.println("<td><input type='radio' name='plug2group6' id='plug2group6' value='60' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group6' id='plug2group6' value='61' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group6' id='plug2group6' value='62' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group6' id='plug2group6' value='63' "+relayStatus2+" "+editable+"></td>");
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">7</td>
				<%
					out.println("<td><input type='radio' name='plug2group7' id='plug2group7' value='70' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group7' id='plug2group7' value='71' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group7' id='plug2group7' value='72' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group7' id='plug2group7' value='73' "+relayStatus2+" "+editable+"></td>");
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">8</td>
				<%
					out.println("<td><input type='radio' name='plug2group8' id='plug2group8' value='80' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group8' id='plug2group8' value='81' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group8' id='plug2group8' value='82' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group8' id='plug2group8' value='83' "+relayStatus2+" "+editable+"></td>");
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">9</td>
				<%
					out.println("<td><input type='radio' name='plug2group9' id='plug2group9' value='90' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group9' id='plug2group9' value='91' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group9' id='plug2group9' value='92' "+relayStatus2+" "+editable+"></td>");
				%>	
				<%
					out.println("<td><input type='radio' name='plug2group9' id='plug2group9' value='93' "+relayStatus2+" "+editable+"></td>");
				%>	
			</tr>
			</table>
		</td>
	</tr>
	<tr>
	<td align="center">
		<div id="path1">
			<%
				out.println(path1);
			%>
		</div>
	</td>
	<td align="center">
		<div id="path2">
			<%
				out.println(path2);
			%>
		</div>
	</td>
	</tr>
</table>
<div align="center">

    
<%
out.println("<input type='button' value='Ok' style='font-family:Verdana,Arial,sans-serif;font-size:0.9em;' onclick=ApplyChannelCrate('"+ip_host+"');></input>");
%>
<input type="button" value="Cancel" style='font-family:Verdana,Arial,sans-serif;font-size:0.9em;' onclick="CancelCreateChannel();"/>
</div>
<!-- SCRIPT -->

<script>
	function ApplyChannelCrate(ip_host)
	{
		document.getElementById("divNew").innerHTML = "<a href='#' onclick='nuovoCanale();' >New</a>";
		var ch = document.getElementById("createChannelName").value;
		var random = new Date().getTime();
		var i;
		var j;
		var relay;
		var rbgroup;
		//plugin 1
		var existsrelay = false;
		for (i = 0; i <= 9; i++)
		{
			rbgroup = document.getElementsByName("plug1group"+i);
			for (j = 0; j < 4; j++)
			{
				if (rbgroup[j].checked == true)
				{
					existsrelay = true;
					relay = rbgroup[j].value;
					jQuery.ajax({
						url: 'http://'+ip_host+':8080/dms/EditChannelServlet?channel='+ch+'&plugin=1&relay='+relay,
						success: function(data) {},
						async: false
					});
				}
			}
		}
		//plugin 2
		for (i = 0; i <= 9; i++)
		{
			rbgroup = document.getElementsByName("plug2group"+i);
			for (j = 0; j < 4; j++)
			{
				if (rbgroup[j].checked == true)
				{
					existsrelay = true;
					relay = rbgroup[j].value;
					//alert(relay);
					jQuery.ajax({
						url: 'http://'+ip_host+':8080/dms/EditChannelServlet?channel='+ch+'&plugin=2&relay='+relay,
						success: function(data) {},
						async: false
					});
				}
			}
		}
		if (existsrelay == true)
		{
			$('#channelTable').load('ChannelTableView.jsp', "randvar="+random);
			alert("New Channel created.");
			LoadPlugins(ch);
		}
		else
		{
			alert("Please, select at least one relay to create the channel.");
		}
	}
</script>
<script>
	function CancelCreateChannel()
	{
		var random = new Date().getTime();
		document.getElementById("divNew").innerHTML = "<a href='#' onclick='nuovoCanale();' >New</a>";
		$('#channelTable').load('ChannelTableView.jsp', "randvar="+random);
	}
</script>

