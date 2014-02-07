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
	out.println("<div id='chName' align='center'><b>Channel "+channelid+"</b></div>");
	String path1 = "";
	String path2 = "";
	String mode = request.getParameter("mode");
%>
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
				//Query estrazione dati
				Statement statement1 = dbconn.createStatement();
				String q = "SELECT relay FROM switching_path where plugin = 1 and channel = "+channelid;
				ResultSet rs1 = statement1.executeQuery(q);
				Boolean relayFound = false;
				String editable = "";
				if (mode.equals("view")) editable = "disabled";
				else if (mode.equals("edit")) editable = "";
				String relayStatus = "";
			%>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">0</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 0)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "00 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group0' id='plug1group0' value='0' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 1)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "01 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group0' id='plug1group0' value='1' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 2)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "02 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group0' id='plug1group0' value='2' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 3)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "03 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group0' id='plug1group0' value='3' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">1</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 10)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "10 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group1' id='plug1group1' value='10' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 11)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "11 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group1' id='plug1group1' value='11' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 12)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "12 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group1' id='plug1group1' value='12' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 13)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "13 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group1' id='plug1group1' value='13' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">2</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 20)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "20 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group2' id='plug1group2' value='20' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 21)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "21 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group2' id='plug1group2' value='21' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 22)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "22 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group2' id='plug1group2' value='22' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 23)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "23 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group2' id='plug1group2' value='23' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">3</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 30)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "30 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group3' id='plug1group3' value='30' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 31)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "31 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group3' id='plug1group3' value='31' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 32)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "32 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group3' id='plug1group3' value='32' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 33)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "33 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group3' id='plug1group3' value='33' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>		
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">4</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 40)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "40 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group4' id='plug1group4' value='40' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>		
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 41)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "41 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group4' id='plug1group4' value='41' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 42)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "42 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group4' id='plug1group4' value='42' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 43)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "43 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group4' id='plug1group4' value='43' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>				
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">5</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 50)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "50 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group5' id='plug1group5' value='50' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>		
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 51)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "51 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group5' id='plug1group5' value='51' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 52)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "52 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group5' id='plug1group5' value='52' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 53)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "53 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group5' id='plug1group5' value='53' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">6</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 60)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "60 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group6' id='plug1group6' value='60' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 61)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "61 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group6' id='plug1group6' value='61' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 62)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "62 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group6' id='plug1group6' value='62' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 63)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "63 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group6' id='plug1group6' value='63' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">7</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 70)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "70 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group7' id='plug1group7' value='70' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 71)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "71 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group7' id='plug1group7' value='71' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 72)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "72 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group7' id='plug1group7' value='72' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 73)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "73 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group7' id='plug1group7' value='73' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">8</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 80)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "80 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group8' id='plug1group8' value='80' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 81)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "81 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group8' id='plug1group8' value='81' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 82)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "82 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group8' id='plug1group8' value='82' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 83)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "83 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group8' id='plug1group8' value='83' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">9</td>
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 90)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "90 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group9' id='plug1group9' value='90' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 91)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "91 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group9' id='plug1group9' value='91' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 92)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "92 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group9' id='plug1group9' value='92' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
				%>	
				<%
					if (rs1.first())
					{
						rs1.first();
						do
						{
							if (rs1.getInt("relay") == 93)
							{
								relayFound = true;
								relayStatus = "checked";
								path1 = path1 + "93 ";
							}
						}
						while (rs1.next() && !relayFound);
					}
					out.println("<td><input type='radio' name='plug1group9' id='plug1group9' value='93' "+relayStatus+" "+editable+"></td>");
					relayFound = false;
					relayStatus = "";
					rs1.first();
					rs1.close();
					statement1.close();
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
				//Query estrazione dati
				Statement statement2 = dbconn.createStatement();
				String q2 = "SELECT relay FROM switching_path where plugin = 2 and channel = "+channelid;
				ResultSet rs2 = statement2.executeQuery(q2);
				Boolean relayFound2 = false;
				String relayStatus2 = "";
			%>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">0</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 0)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "00 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group0' id='plug2group0' value='0' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 1)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "01 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group0' id='plug2group0' value='1' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 2)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "02 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group0' id='plug2group0' value='2' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 3)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "03 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group0' id='plug2group0' value='3' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">1</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 10)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "10 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group1' id='plug2group1' value='10' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 11)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "11 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group1' id='plug2group1' value='11' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 12)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "12 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group1' id='plug2group1' value='12' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 13)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "13 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group1' id='plug2group1' value='13' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">2</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 20)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "20 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group2' id='plug2group2' value='20' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 21)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "21 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group2' id='plug2group2' value='21' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 22)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "22 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group2' id='plug2group2' value='22' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 23)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "23 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group2' id='plug2group2' value='23' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">3</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 30)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "30 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group3' id='plug2group3' value='30' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 31)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "31 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group3' id='plug2group3' value='31' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 32)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "32 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group3' id='plug2group3' value='32' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 33)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "33 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group3' id='plug2group3' value='33' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>		
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">4</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 40)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "40 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group4' id='plug2group4' value='40' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>		
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 41)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "41 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group4' id='plug2group4' value='41' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 42)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "42 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group4' id='plug2group4' value='42' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 43)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "43 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group4' id='plug2group4' value='43' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>				
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">5</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 50)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "50 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group5' id='plug2group5' value='50' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>		
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 51)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "51 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group5' id='plug2group5' value='51' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 52)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "52 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group5' id='plug2group5' value='52' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 53)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "53 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group5' id='plug2group5' value='53' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">6</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 60)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "60 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group6' id='plug2group6' value='60' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 61)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "61 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group6' id='plug2group6' value='61' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 62)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "62 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group6' id='plug2group6' value='62' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 63)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "63 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group6' id='plug2group6' value='63' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">7</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 70)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "70 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group7' id='plug2group7' value='70' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 71)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "71 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group7' id='plug2group7' value='71' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 72)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "72 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group7' id='plug2group7' value='72' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 73)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "73 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group7' id='plug2group7' value='73' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">8</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 80)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "80 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group8' id='plug2group8' value='80' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 81)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "81 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group8' id='plug2group8' value='81' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 82)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "82 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group8' id='plug2group8' value='82' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 83)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "83 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group8' id='plug2group8' value='83' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
			</tr>
			<tr>
				<td style="background:#f1f1f1;padding:0 8 0 8">9</td>
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 90)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "90 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group9' id='plug2group9' value='90' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 91)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "91 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group9' id='plug2group9' value='91' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 92)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "92 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group9' id='plug2group9' value='92' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
				%>	
				<%
					if (rs2.first())
					{
						rs2.first();
						do
						{
							if (rs2.getInt("relay") == 93)
							{
								relayFound2 = true;
								relayStatus2 = "checked";
								path2 = path2 + "93 ";
							}
						}
						while (rs2.next() && !relayFound2);
					}
					out.println("<td><input type='radio' name='plug2group9' id='plug2group9' value='93' "+relayStatus2+" "+editable+"></td>");
					relayFound2 = false;
					relayStatus2 = "";
					rs2.first();
					rs2.close();
					statement2.close();
					dbconn.close();
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

<%
if (mode.equals("view")) out.println("<div align='center' style='visibility:hidden'>");
else if (mode.equals("edit")) out.println("<div align='center'>");
out.println("<input type='button' value='Apply' onclick=ApplyEditChannel("+channelid+",'"+ip_host+"');></input>");
out.println("<input type='button' value='Cancel' onclick='CancelEditChannel("+channelid+");'/>");
out.println("</div>");
%>
<!-- SCRIPT -->
<script type="text/javascript" charset="utf-8">
	var check;
	$('input[type="radio"]').hover(function() {
		check = $(this).is(':checked');
	});

	$('input[type="radio"]').click(function() {
		check = !check;
		$(this).attr("checked", check);
	});
</script>
<script>
	function ApplyEditChannel(ch, ip_host)
	{
		var random = new Date().getTime();
		document.getElementById("divNew").innerHTML = "<a href='#' onclick='nuovoCanale();' >New</a>";
		$.get("http://"+ip_host+":8080/dms/DeleteChannelServlet?channel="+ch+"&safemode=false&rand="+random, 
			function(data) 
			{
				var i;
				var j;
				var relay;
				var rbgroup;
				//plugin 1
				for (i = 0; i <= 9; i++)
				{
					rbgroup = document.getElementsByName("plug1group"+i);
					for (j = 0; j < 4; j++)
					{
						if (rbgroup[j].checked == true)
						{
							relay = rbgroup[j].value;
							jQuery.ajax({
								url: 'http://'+ip_host+':8080/dms/EditChannelServlet?channel='+ch+'&plugin=1&relay='+relay,
								success: function(data1) {
											if (data1 != NULL) {
												alert(data1);
												return;
											}
										},
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
							relay = rbgroup[j].value;
							jQuery.ajax({
								url: 'http://'+ip_host+':8080/dms/EditChannelServlet?channel='+ch+'&plugin=2&relay='+relay,
								success: function(data) {
											if (data != NULL){
												alert(data);
												return;
											}
										},
								async: false
							});
						}
					}
				}
				LoadPlugins(ch);
				alert("Channel succesfully updated.");
			}
		);	
		
	}
</script>
<script>
	function CancelEditChannel(ch)
	{
		document.getElementById("divNew").innerHTML = "<a href='#' onclick='nuovoCanale();' >New</a>";
		LoadPlugins(ch);
	}
</script>
