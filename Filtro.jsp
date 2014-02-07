<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- HTML -->
<br>
<br>
<div align="center">
	<table class="display" style="width:400">
	<thead>
		<th>Parameters</th>
		<th>Filter</th>
	</thead>
	<%
		Connection dbconn = null;
		Class.forName("com.mysql.jdbc.Driver");
		String user_db = DmsMng.dbuser;
		String pwd_db = DmsMng.dbpwd;
		String ip_db = DmsMng.dbHostIp;
		String name_db = DmsMng.dbName;
		
		//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
		//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
		
		dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
		Statement statement = dbconn.createStatement();
		String id = request.getParameter("id");
		
		// Seleziono il nome della tabella
		ResultSet rs = statement.executeQuery("Select table_name from exposed_data where id = "+id);
		rs.next();
		String table = rs.getString("table_name");
		
		// Seleziono i tipi della tabella
		rs = statement.executeQuery("Select * from "+table+" limit 0");
		ResultSetMetaData rsmd = rs.getMetaData();
		
		// Seleziono le colonne della tabella
		String colType;
		String fieldName;
		String rangeFrom;
		String rangeTo;
		int noOfColumns = 0;
		int j;
		int i = 0;
		int fieldIndex;
		int data_id;
		String value;
		
		CallableStatement cstmt;
		cstmt = dbconn.prepareCall("{call get_exposed_data_details ("+id+")}");
		rs = cstmt.executeQuery();
		while (rs.next())
		{
			i++;
			fieldName = rs.getString("fname");
			colType = rs.getString("fdatatype");
			data_id = Integer.parseInt(id);
			rangeFrom = rs.getString("ffrom");
			rangeTo = rs.getString("fto");	
			
			out.println("<tr>");
				out.println("<td>");
				out.println(fieldName);
				out.println("</td>");
				out.println("<td>");
					if ((rangeFrom != null) && (rangeTo != null))
					{
						if ((colType.equals("TIMESTAMP")) || (colType.equals("datetime")))
						{
							i--;
							out.println("<table>");
								out.println("<tr>");
									out.println("<td style='padding: 0px 0px 0px 0px;'>");
										out.println("<label for='visualFilterdateFrom'>From:</label><br>");
									out.println("</td>");
									out.println("<td style='padding: 0px 20px 0px 0px;'>");
										out.println("<div class='demo'>");
											rangeFrom = rangeFrom.substring(0,10);
											out.println("<input class='custominput' id='visualFilterDatepickerFrom' name='"+fieldName+"' type='text' value='"+rangeFrom+"'>");
										out.println("</div>");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterHourFrom' id='visualFilterHourFrom'>");
											out.println("<option value=''></option>");
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
											//int j = 0;
											for (j = 10; j < 24; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
									out.println("<td>");
									out.println(":");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterMinFrom' id='visualFilterMinFrom'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 60; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
									out.println("<td>");
									out.println(":");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterSecFrom' id='visualFilterSecFrom'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 60; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
								out.println("</tr>");
								out.println("<tr>");
									out.println("<td style='padding: 0px 0px 0px 0px;'>");
										out.println("<label for='dateFrom'>To:</label><br>");
									out.println("</td>");
									out.println("<td style='padding: 0px 20px 0px 0px;'>");
										out.println("<div class='demo'>");
											rangeTo = rangeTo.substring(0,10);
											out.println("<input class='custominput' id='visualFilterDatepickerTo' name='"+fieldName+"' type='text' value='"+rangeTo+"'>");
										out.println("</div>");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterHourTo' id='visualFilterHourTo'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 24; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
									out.println("<td>");
									out.println(":");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterMinTo' id='visualFilterMinTo'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 60; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
									out.println("<td>");
									out.println(":");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterSecTo' id='visualFilterSecTo'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 60; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
								out.println("</tr>");
							out.println("</table>");
						}			
						else if ( (colType == "SMALLINT") || (colType == "INTEGER") || (colType == "BIGINT") ||
							 (colType == "TINYINT") || (colType == "DECIMAL") || (colType == "NUMERIC") || 
							 (colType == "FLOAT") || (colType == "DOUBLE") || (colType == "REAL") || (colType == "DOUBLE") || (colType == "VARCHAR"))
						{
							int rfrom = Integer.parseInt(rs.getString("ffrom"));
							int rto = Integer.parseInt(rs.getString("fto"));
							out.println("</select>");
							out.println("<input type='text' class='custominput' name='"+fieldName+"' id='colSelect"+i+"' onChange=checkField('"+colType+"')>");
						}
					}	
					else
					{
						if ((colType == "TIMESTAMP") || (colType == "DATETIME"))
						{
							i--;
							out.println("<table>");
								out.println("<tr>");
									out.println("<td style='padding: 0px 0px 0px 0px;'>");
										out.println("<label for='visualFilterdateFrom'>From:</label><br>");
									out.println("</td>");
									out.println("<td style='padding: 0px 20px 0px 0px;'>");
										out.println("<div class='demo'>");
											out.println("<input class='custominput' id='visualFilterDatepickerFrom' name='"+fieldName+"' type='text'>");
										out.println("</div>");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterHourFrom' id='visualFilterHourFrom'>");
											out.println("<option value=''></option>");
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
											//int j = 0;
											for (j = 10; j < 24; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
									out.println("<td>");
									out.println(":");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterMinFrom' id='visualFilterMinFrom'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 60; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
									out.println("<td>");
									out.println(":");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterSecFrom' id='visualFilterSecFrom'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 60; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
								out.println("</tr>");
								out.println("<tr>");
									out.println("<td style='padding: 0px 0px 0px 0px;'>");
										out.println("<label for='dateFrom'>To:</label><br>");
									out.println("</td>");
									out.println("<td style='padding: 0px 20px 0px 0px;'>");
										out.println("<div class='demo'>");
											out.println("<input class='custominput' id='visualFilterDatepickerTo' name='"+fieldName+"' type='text'>");
										out.println("</div>");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterHourTo' id='visualFilterHourTo'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 24; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
									out.println("<td>");
									out.println(":");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterMinTo' id='visualFilterMinTo'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 60; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
									out.println("<td>");
									out.println(":");
									out.println("</td>");
									out.println("<td>");
										out.println("<select class='custominput' name='visualFilterSecTo' id='visualFilterSecTo'>");
											out.println("<option value=''></option>");
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
											for (j = 10; j < 60; j++)
											{
												out.println("<option value='"+j+"'>"+j+"</option>");
											}
										out.println("</select>");
									out.println("</td>");
								out.println("</tr>");
							out.println("</table>");
						}
						else
						{
							out.println("<select class='custominput' name='"+fieldName+"' id='colSelect"+i+"' onChange=''>");
							out.println("<option value='' onClick=enableOkButton();></option>");
							Statement st1 = dbconn.createStatement();
							ResultSet rs1 = st1.executeQuery("Select table_name from exposed_data where id = "+data_id);
							rs1.next();
							Statement st2 = dbconn.createStatement();
							ResultSet rs2 = st2.executeQuery("Select distinct "+fieldName+" from "+rs1.getString("table_name"));
							while(rs2.next())
							{
								value = rs2.getString(fieldName);
								out.println("<option value='"+value+"'>"+value+"</option>");
							}
							out.println("</select>");
							rs1.close();
							st1.close();
							rs2.close();
							st2.close();
						}
					}
				out.println("</td>");	
			out.println("</tr>");
		}
	%>
	</table>
	<br>	
	<br>
	<%
		out.println("<input type='button' id ='okBtn' value='Open Table' onClick=openTable('"+table+"','"+i+"','"+id+"','"+rsmd.getColumnName(1)+"');></input>");
		rs.close();
		statement.close();
		dbconn.close();
	%>
</div>

<!-- SCRIPT -->
<script>
	function checkField(colType)
	{
		//alert(colType);
		//if (colType == Type.VARCHAR) alert("VARCHAR");
		//else alert("BOH");
	}
</script>
<script type="text/javascript" charset="utf-8">
	function openTable(val1, val2, id, orderField){
		var random = new Date().getTime();
		var query = "select|*";
		var i = 1;
		query = query + "|from|" + val1;
		var flag = 0;
		var fieldVal = "";
		for (i = 1; i <= val2; i++)
		{
			if (document.getElementById("colSelect"+i).value != "")
			{
				if (flag == 0)
				{
					query = query + "|where|";
					flag = 1;
				}
				fieldVal = document.getElementById("colSelect"+i).value;
				fieldVal = fieldVal.replace(" ","|");
				//query = query + document.getElementById("colSelect"+i).name + "='" + document.getElementById("colSelect"+i).value + "'|and|";
				query = query + document.getElementById("colSelect"+i).name + "='" + fieldVal + "'|and|";
			}
		}
		if ((document.getElementById("visualFilterDatepickerFrom") != null) && (document.getElementById("visualFilterDatepickerTo") != null))
		{
			if ((document.getElementById("visualFilterDatepickerFrom").value != "") && (document.getElementById("visualFilterDatepickerTo").value != ""))
			{
				var dateFrom = document.getElementById("visualFilterDatepickerFrom").value;
				var arr1 = dateFrom.split("-");
				var dateF = new Date(arr1[0],arr1[1],arr1[2]);
				var dF = dateF.getTime();
				var hourFrom = document.getElementById("visualFilterHourFrom").value;
				var minFrom = document.getElementById("visualFilterMinFrom").value;
				var secFrom = document.getElementById("visualFilterSecFrom").value;
				
				var dateTo = document.getElementById("visualFilterDatepickerTo").value;
				var arr2 = dateTo.split("-");
				var dateT = new Date(arr2[0],arr2[1],arr2[2]);
				var dT = dateT.getTime();
				var hourTo = document.getElementById("visualFilterHourTo").value;
				var minTo = document.getElementById("visualFilterMinTo").value;
				var secTo = document.getElementById("visualFilterSecTo").value;
				
				if (dF > dT)
				{
					alert("The Start date must occur before the end date");
					return;
				}
				else if (dF === dT)
				{
					if (hourFrom > hourTo)
					{
						alert("The Start hour must occur before the end hour");
						return;
					}
					else if ((hourFrom === hourTo) && (minFrom > minTo))
					{
						alert("The Start minute must occur before the end minute");
						return;
					}
					else if ((hourFrom === hourTo) && (minFrom === minTo) && (secFrom > secTo))
					{
						alert("The Start second must occur before the end second");
						return;
					}
					else
					{
						if (flag == 0) query = query + "|where|";
						flag = 2;				
						if (hourFrom == "") hourFrom = "00";
						if (minFrom == "") minFrom = "00";
						if (secFrom == "") secFrom = "00";
						dateFrom = dateFrom+"|"+hourFrom+":"+minFrom+":"+secFrom; 
						query = query + document.getElementById("visualFilterDatepickerFrom").name +">='"+dateFrom+"'|and|";
						if (hourTo == "") hourTo = "23";
						if (minTo == "") minTo = "59";
						if (secTo == "") secTo = "59";
						dateTo = dateTo+"|"+hourTo+":"+minTo+":"+secTo; 
						query = query + document.getElementById("visualFilterDatepickerTo").name +"<='"+dateTo+"'|and|";
					}
				}
				else
				{
					if (flag == 0) query = query + "|where|";
					flag = 2;
					//var hourFrom = document.getElementById("visualFilterHourFrom").value;
					//var minFrom = document.getElementById("visualFilterMinFrom").value;
					//var secFrom = document.getElementById("visualFilterSecFrom").value;
					if (hourFrom == "") hourFrom = "00";
					if (minFrom == "") minFrom = "00";
					if (secFrom == "") secFrom = "00";
					dateFrom = dateFrom+"|"+hourFrom+":"+minFrom+":"+secFrom; 
					query = query + document.getElementById("visualFilterDatepickerFrom").name +">='"+dateFrom+"'|and|";
					
					//var hourTo = document.getElementById("visualFilterHourTo").value;
					//var minTo = document.getElementById("visualFilterMinTo").value;
					//var secTo = document.getElementById("visualFilterSecTo").value;
					if (hourTo == "") hourTo = "23";
					if (minTo == "") minTo = "59";
					if (secTo == "") secTo = "59";
					dateTo = dateTo+"|"+hourTo+":"+minTo+":"+secTo; 
					query = query + document.getElementById("visualFilterDatepickerTo").name +"<='"+dateTo+"'|and|";
				}	
			}
			else if ((document.getElementById("visualFilterDatepickerFrom").value != "") && (document.getElementById("visualFilterDatepickerTo").value == ""))
			{
				if (flag == 0) query = query + "|where|";
				flag = 2;
				var dateFrom = document.getElementById("visualFilterDatepickerFrom").value;
				var arr1 = dateFrom.split("-");
				var dateF = new Date(arr1[0],arr1[1],arr1[2]);
				var dF = dateF.getTime();
				var hourFrom = document.getElementById("visualFilterHourFrom").value;
				var minFrom = document.getElementById("visualFilterMinFrom").value;
				var secFrom = document.getElementById("visualFilterSecFrom").value;
				if (hourFrom == "") hourFrom = "00";
				if (minFrom == "") minFrom = "00";
				if (secFrom == "") secFrom = "00";
				dateFrom = dateFrom+"|"+hourFrom+":"+minFrom+":"+secFrom; 
				query = query + document.getElementById("visualFilterDatepickerFrom").name +">='"+dateFrom+"'|and|";
			}
			else if ((document.getElementById("visualFilterDatepickerFrom").value == "") && (document.getElementById("visualFilterDatepickerTo").value != ""))
			{
				if (flag == 0) query = query + "|where|";
				flag = 2;
				var dateTo = document.getElementById("visualFilterDatepickerTo").value;
				var arr2 = dateTo.split("-");
				var dateT = new Date(arr2[0],arr2[1],arr2[2]);
				var dT = dateT.getTime();
				var hourTo = document.getElementById("visualFilterHourTo").value;
				var minTo = document.getElementById("visualFilterMinTo").value;
				var secTo = document.getElementById("visualFilterSecTo").value;
				if (hourTo == "") hourTo = "23";
				if (minTo == "") minTo = "59";
				if (secTo == "") secTo = "59";
				dateTo = dateTo+"|"+hourTo+":"+minTo+":"+secTo; 
				query = query + document.getElementById("visualFilterDatepickerTo").name +"<='"+dateTo+"'|and|";
			}
		}
		if (flag == 1)
		{
			query = query.substring(0, query.length-5);
		}
		else if (flag == 2)
		{
			query = query.substring(0, query.length-5);
		}
		//query = query + "|order|by|"+orderField+"|ASC";
		document.getElementById("container1").innerHTML = "<p align=center><b>Loading data, please wait...</b></p><p align=center><img src='immagini/loading.gif' height='30' width='30'></img></p>";
		//alert(query);
		$('#container1').load('Visualize.jsp?param='+query+'&view_id='+id+'&randvar='+random);
		//$('#container1').load('Visualize.jsp?param='+query+'&view_id='+id, "randvar:"+random);
		//$('#container1').load('DataAccess.jsp?param='+query+'&view_id='+id);
	}
</script>
<script>
	$(function() {
		$("#visualFilterDatepickerFrom").datepicker({dateFormat: 'yy-mm-dd'});
		$("#visualFilterDatepickerTo").datepicker({dateFormat: 'yy-mm-dd'});
	});
</script>
