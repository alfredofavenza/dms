<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- HTML -->
<html>
<!-- STYLE -->
<link rel="stylesheet" type="text/css" href="datatables/css/jquery.multiselect.css"/>
<link rel="stylesheet" type="text/css" href="datatables/css/jquery.multiselect.filter.css"/>

<STYLE>
#AddClocklayer {
	
	width: 300px;
	height: 100px;
	background-color: #ccc;
	border: 1px solid #000;
	padding: 10px 20px;
	z-index:1;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-left: -100px;
    margin-top: -120px;
}

#close {
	float: right;
}
</STYLE>

<head>
</head>
<%
	Connection dbconn = null;
	
	String user_db = DmsMng.dbuser;
	String pwd_db = DmsMng.dbpwd;
	String ip_db = DmsMng.dbHostIp;
	String ip_host = DmsMng.webHostIp;
	String name_db = DmsMng.dbName;
	
	//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
	//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
	
	int clockid = -1;
	int pollingTaskId = -1;
	String poolid = request.getParameter("poolid").toString();
	String poolname = request.getParameter("poolname");
	String addclockactive = request.getParameter("addclockactive");
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);

	Statement statement = null;
	Statement statement2 = null;
	Statement statement3 = null;
	ResultSet rs = null;
	ResultSet rs3 = null;
	
	if ((addclockactive.equals("block")))
	{
		Statement st = dbconn.createStatement();
		String query = "SELECT max(id) from task";
		ResultSet res = st.executeQuery(query);
		while(res.next())
		{
			poolid = Integer.toString(res.getInt(1));
		}
		res.close();
		st.close();
	}
	else
	{
		statement = dbconn.createStatement();
		statement2 = dbconn.createStatement();
		statement3 = dbconn.createStatement();
		
		String q = "Select distinct(Polling_Task) as Polling_Task, Clock_ID, Clock_Name from exp_vw_clock_status_polling_pools_info where ID="+poolid;
		rs = statement.executeQuery(q);
		while(rs.next())
		{
			clockid = rs.getInt("Clock_ID");
			pollingTaskId = rs.getInt("Polling_Task");
		}
		rs = statement.executeQuery(q);
		
		String q3 = "SELECT * FROM exp_vw_clock_status_polling_pools where ID="+poolid;
		rs3 = statement3.executeQuery(q3);
		if (rs3.next())
		{
			poolname = rs3.getString("Polling Description");
		}
	}
%>
<body>

<!--	CODICE PER UPLOAD/DOWNLOAD FILEs
<fieldset>
        <legend>Upload File</legend>
        <form action="FileUploadDemoServlet" method="post" enctype="multipart/form-data">
            <label for="filename_1">File: </label>
            <input id="filename_1" type="file" name="filename_1" size="50"/><br/>
            <label for="filename_2">File: </label>
            <input id="filename_2" type="file" name="filename_2" size="50"/><br/>
            <br/>
            <input type="submit" value="Upload File"/>
        </form>
 </fieldset>
-->

<!-- INTESTAZIONE + FUNZIONI EXTRA -->
<%
out.println("<div id='AddClocklayer' style='display:"+addclockactive+"'>");
%>
	<table>
		<tr>
			<td>Select clock which status parameters have to be polled:</td>
		</tr>
		<tr>
			<td>
				<%
					Statement statement4 = dbconn.createStatement();
				    String q4 = "";
					if (addclockactive.equals("block"))
					{
						q4 = "Select Clock_ID, Clock_Name from vw_available_clocks_for_polling where Pool_ID IS NULL";						
					}
					else
					{
						q4 = "Select Clock_ID, Clock_Name from vw_available_clocks_for_polling where Pool_ID="+poolid;
					}
					ResultSet rs4 = statement4.executeQuery(q4);
				    out.println("<select class='' name='addClockSelect' id='addClockSelect' onClick='' >");
					out.println("<option value='all'>All</option>");
				    while (rs4.next())
				    {
						out.println("<option value='"+rs4.getString("Clock_ID")+"'>"+rs4.getString("Clock_Name")+"</option>");
				    }
				    out.println("</select>");
				%>
				
			</td>
		</tr>
		<tr>
			<td>
			<table>
				<tr>
					<%
					out.println("<td><input type='button' value='Add' onClick=ConfirmAddClock("+poolid+",'"+ip_host+"','"+addclockactive+"')></input></td>");
					
					if (addclockactive.equals("block"))
					{
						out.println("<td><input type='button' value='Cancel' onClick='CloseAddClockPopUp()' disabled></input></td>");
					}
					else
					{
						out.println("<td><input type='button' value='Cancel' onClick='CloseAddClockPopUp()'></input></td>");
					}
					%>
					<!-- <td><input type="button" value="Cancel" onClick="CloseAddClockPopUp()"></input></td> -->
				</tr>
			</table>
			</td>
		</tr>
	</table>
<%
out.println("</div>");
%>
<table width="100%">
	<tr>
		<%
		if (addclockactive.equals("block"))
		{
			out.println("<td align=left'>Polling task | Creating new... (step 2 of 2)</td>");
		}
		else
		{
			out.println("<td align=left'>Polling task: <b>"+poolname+"</b> | Configuration</td>");
		}
		%>
		<!--
		<td align="left">
			Polling task: <b><%out.println(poolname);%></b> | Configuration
		</td>
		-->
		<td align="right">
			<%
				out.println("<a href='#' onclick='visualizzaTaskPoolSchedule("+poolid+");'>View Schedule</a>");
			%>
			|
			<%
				out.println("<a href='#' onclick='backToPools();'>Back</a>");
			%>
		</td>
	</tr>
</table>
<br>

<form id="clocksParamsForm" name="clocksParamsForm" action="submitClockParams.jsp" method="POST">
<table>
<tr>
	<td>
		<i>Clocks</i>
		<div id="clocksDivHeader" style="border:solid 2px #000000; padding:4px; width:500px; height:25px; overflow:auto;">
			<table width="100%">
				<tr>
					<td align="right">
						<a href='#' onclick='OpenAddClockPopUp();'>Add</a> |
						<%
						out.println("<a href='#' onclick=DeleteClock("+poolid+",'"+ip_host+"')>Remove</a>");
						%>
					</td>
				</tr>
			</table>			
		</div>
		
		<div id="clocksDiv" style="border:solid 2px #000000; padding:4px; width:500px; height:300px; overflow:auto;">
			<table id='clocksTab' width="100%">
			<%
				int i = 0;
				// Ciclo sui clock
				while((rs!=null) && (rs.next()))
				{
					out.println("<tr>");
					if (i == 0)
					{
						out.println("<td style='text-align:left;cursor:pointer;' id='clock_"+rs.getInt("Polling_Task")+"' bgColor='ddddff' onClick=checkClockRow('clock_"+rs.getInt("Polling_Task")+"','"+poolid+"','"+rs.getInt("Polling_Task")+"');>");
					}
					else
					{
						out.println("<td style='text-align:left;cursor:pointer;' id='clock_"+rs.getInt("Polling_Task")+"' onClick=checkClockRow('clock_"+rs.getInt("Polling_Task")+"','"+poolid+"','"+rs.getInt("Polling_Task")+"');>");
					}
					out.println("<input id='"+rs.getInt("Polling_Task")+"' name='"+rs.getString("Clock_Name")+"' type='checkbox' >"+rs.getString("Clock_Name")+"</input>");		
					
					out.println("</td>");
					out.println("</tr>");
					i++;
				}
			%>
			</table>		
		</div>
		<!--</form>-->
	</td>
	<td>
		<i>Parameters</i>
		<%
		out.println("<div id='paramsDivHeader_'"+pollingTaskId+" style='border:solid 2px #000000; padding:4px; width:500px; height:25px; overflow:auto;'>");
		out.println("<table width='100%'>");
		out.println("<tr>");
		out.println("<td align='left'><input id='selAllParams' type='checkbox' onChange=selectAllParams('clockParams_"+pollingTaskId+"'); disabled>Select All</td>");
		out.println("<td align='right'>");
			out.println("<div id='editParamsDiv'>");
			out.println("<a href='#' onclick='modificaPollingTaskParameters("+poolid+","+pollingTaskId+");'>Edit</a>");
			out.println("</div>");
			out.println("<div id='applyCancelEditParamsDiv'>");
		    out.println("<a href='#' onClick=UpdateParams('"+ip_host+"');>Apply</a> |");
			out.println("<a href='#' onClick='cancelModificaPollingTask("+poolid+");'>Cancel</a>");
			out.println("</div>");
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</div>");
		%>	
		<div id="paramsDiv" style="border:solid 2px #000000; padding:4px; width:500px; height:300px; overflow:auto;">
			<!--<table id='paramsTab' width="100%">-->
			<%
				i = 0;
				if (rs != null) rs.first();
				String visible = "";
				String q2 = "";
				ResultSet rs2 = null;
				if ((clockid != -1) && (rs != null))
				{
					do
					{
						clockid = rs.getInt("Clock_ID");
						pollingTaskId = rs.getInt("Polling_Task");
						if (i == 0) visible = "";
						else visible = "style='display:none'";
						//q2 = "Select Parameter_Name, Is_Enabled from exp_vw_clock_status_polling_pools_info where ID='"+poolid+"' and Clock_ID='"+rs.getInt("Clock_ID")+"'";
						q2 = "Select Parameter_Name, Parameter_ID, Is_Enabled from exp_vw_clock_status_polling_pools_info where ID='"+poolid+"' and Polling_Task='"+pollingTaskId+"'";
						rs2 = statement2.executeQuery(q2);
						out.println("<div id='clockParams_"+pollingTaskId+"' "+visible+">");					
						out.println("<table id='paramsTab' width='100%'>");
						while(rs2.next())
						{
							out.println("<tr>");
							out.println("<td style='text-align:left;' id='"+rs2.getString("Parameter_Name")+"'>");
							boolean found = false;
							if (rs2.getInt("Is_Enabled") == 1)
							{
								out.println("<input type='checkbox' id='"+rs2.getString("Parameter_Name")+"^"+pollingTaskId+"' name='"+rs2.getInt("Parameter_ID")+"' disabled checked>"+rs2.getString("Parameter_Name")+"</input>");
							}
							else
							{
								out.println("<input type='checkbox' id='"+rs2.getString("Parameter_Name")+"^"+pollingTaskId+"' name='"+rs2.getInt("Parameter_ID")+"' disabled>"+rs2.getString("Parameter_Name")+"</input>");
							}		
							out.println("</td>");
							out.println("</tr>");
						}
						out.println("</table>");
						out.println("</div>");
						out.println();
						//clockid = rs.getInt("Clock_ID");
						//pollingTaskId = rs.getInt("Polling_Task");
						i++;
					} while (rs.next());
				}
			%>
			<!--</table>-->
		</div>
		<!--</form>-->
	</td>
</tr>
<tr>
	<td>
		<!--
		<table>
			<tr>
				<td>
					<div id="addClockBtnDiv"><input type="button" id="addClockBtn" value="+" onclick="OpenAddClockPopUp();"/></div>
					<%
						//out.println("<div id='backBtnDiv'><input type='button' id='backEditBtn' value='Back' onclick='backToPools();'/></div>");
					%>
				</td>
				<td>
					<%
						//out.println("<div id='removeClockBtnDiv'><input type='button' id='removeClockBtn' value='-' onclick='DeleteClock("+poolid+",'"+ip_host+"');'/></div>");
					%>
				</td>
			</tr>
		</table>
		-->
	</td>
	<td>
		<table>
			<tr>
				<td>
					<!--<div id="applyBtnDiv"><input type="button" id="applyEditBtn" value="Apply" onclick="UpdateParams('"+ip_host+"');"/></div>-->
				</td>
				<td>
					<!--<div id="cancelBtnDiv"><input type="button" id="cancelEditBtn" value="Cancel" onclick="cancelModificaPollingTask();"/></div>-->
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>

</form>
<br>

</body>
<%
	if (statement != null) statement.close();
    if (statement2 != null) statement2.close();
    if (rs != null) rs.close();
    if (rs2 != null) rs2.close();
	dbconn.close();
%>

<!-- SCRIPT -->
<script>
	document.getElementById("applyCancelEditParamsDiv").style.display = 'none';	
</script>
<script type="text/javascript" charset="utf-8">
	function closeEditTask(){
		var random = new Date().getTime();
		$('#elemento4').load('ParamsAcqView.jsp', "randvar="+random);
	}
</script>
<script>
	function OpenAddClockPopUp()
	{
		document.getElementById("AddClocklayer").style.display = 'block';
	}
</script>
<script>
	function CloseAddClockPopUp()
	{
		document.getElementById("AddClocklayer").style.display = 'none';
	}
</script>
<script>
	function DeleteClock(poolid, ip_host)
	{
		var elems = document.getElementById("clocksDiv").getElementsByTagName("input");
		var counter = 0;
		for (var i = 0; i < elems.length; i++)
		{
			if (elems[i].checked == true) counter++;
		}
		if (counter == 0)
		{
			alert("No clock selected! Please select the clock(s) to be removed using check box.");
		}
		/*
		else if (elems.length < 2)
		{
			//alert("Cannot remove this clock.");
			for (var i = 0; i < elems.length; i++) { 
				if (elems[i].checked == true)
				{
					if (confirm("Removing this clock the pool will be also removed. Continue?") == true)
					{
						$.get("http://"+ip_host+":8080/dms/DeletePollingTaskServlet?poolid="+poolid+"&clockid="+elems[i].id,
				   			function()
							{
				    			$('#elemento4').load('ViewTaskPool.jsp?poolid='+poolid+"&addclockactive=none", "randvar="+random);
							}
						);
					} 	
				}
			}
		}
		*/
		else
	    {
		    var countClock = 0;
			for (var i = 0; i < elems.length; i++) { 
				if (elems[i].checked == true)
				{
					countClock++;
					if (countClock == elems.length)
					{
						if (confirm("Removing this clock the pool will be also removed. Continue?") == true)
						{
							$.get("http://"+ip_host+":8080/dms/DeletePollingTaskServlet?poolid="+poolid+"&clockid="+elems[i].id,
					   			function()
								{
					    			//$('#elemento4').load('ViewTaskPool.jsp?poolid='+poolid+"&addclockactive=none", "randvar="+random);
									var random = new Date().getTime();
									$('#elemento4').load('ParamsAcqView.jsp', "rand ="+random);
								}
							);
						} 
					}
					else if (confirm("Delete the clock "+elems[i].name+"?") == true)
					{
						$.get("http://"+ip_host+":8080/dms/DeletePollingTaskServlet?poolid="+poolid+"&clockid="+elems[i].id,
				   			function()
							{
				    			$('#elemento4').load('ViewTaskPool.jsp?poolid='+poolid+"&addclockactive=none", "randvar="+random);
							}
						);
					} 	
				}
			}
	    }
	}
</script>
<script>
	function ConfirmAddClock(poolid, ip_host, addclockact)
	{
		var clocklist = document.getElementById("addClockSelect");
		var clocklistlen = clocklist.length;
		var i;
		if (clocklist.options[0].selected)
		{
			//for(i=clocklistlen-1; i>0; i--)
			for(i=1; i<clocklistlen; i++)
			{
				$.get("http://"+ip_host+":8080/dms/AddClockTaskPoolServlet?poolid="+poolid+"&clockid="+clocklist.options[i].value+"&clockname="+clocklist.options[i].text,
					function()
					{
						//$('#elemento4').load('ViewTaskPool.jsp?poolid='+poolid+'&addclockactive=none', "randvar="+random);
						$('#elemento4').load('ViewTaskPool.jsp?poolid='+poolid+'&addclockactive=none&randvar='+random,
							function()
							{
								//document.getElementById(elem).focus();
								//'clock_"+rs.getInt("Polling_Task")+"'
								var table = document.getElementById("clocksTab");
								var rows = table.getElementsByTagName("tr");
								var i = 0;
								for (i = 0; i < rows.length; i++)
								{	
									var col = rows[i].getElementsByTagName("td");
									col[0].style.backgroundColor = "white";
									col[0].bgColor = "white";
								}	
								col = rows[rows.length-1].getElementsByTagName("td");
								col[0].style.backgroundColor = "ddddff";
								col[0].bgColor = "ddddff";
								var elems = document.getElementById("paramsDiv").getElementsByTagName("div");
								var clock = col[0].id;
								clock = clock.substr(6);
								for (var i = 0; i < elems.length; i++) { 
									if (elems[i].id != "paramsDivHeader_"+clock)
										elems[i].style.display = 'none';
								}
								document.getElementById("clockParams_"+clock).style.display = "block";
							}
						);
					}
				);	
			}
		}
		else
		{
			//for(i=clocklistlen-1; i>0; i--)
			for(i=1; i<clocklistlen; i++)
			{
				if((clocklist.options[i].selected))
				{
					$.get("http://"+ip_host+":8080/dms/AddClockTaskPoolServlet?poolid="+poolid+"&clockid="+clocklist.options[i].value+"&clockname="+clocklist.options[i].text,
						function()
						{
							//$('#elemento4').load('ViewTaskPool.jsp?poolid='+poolid+'&addclockactive=none', "randvar="+random);
							$('#elemento4').load('ViewTaskPool.jsp?poolid='+poolid+'&addclockactive=none&randvar='+random,
								function()
								{
									//document.getElementById(elem).focus();
									//'clock_"+rs.getInt("Polling_Task")+"'
									var table = document.getElementById("clocksTab");
									var rows = table.getElementsByTagName("tr");
									var i = 0;
									for (i = 0; i < rows.length; i++)
									{	
										var col = rows[i].getElementsByTagName("td");
										col[0].style.backgroundColor = "white";
										col[0].bgColor = "white";
									}	
									col = rows[rows.length-1].getElementsByTagName("td");
									col[0].style.backgroundColor = "ddddff";
									col[0].bgColor = "ddddff";
									var elems = document.getElementById("paramsDiv").getElementsByTagName("div");
									var clock = col[0].id;
									clock = clock.substr(6);
									for (var i = 0; i < elems.length; i++) { 
										if (elems[i].id != "paramsDivHeader_"+clock)
											elems[i].style.display = 'none';
									}
									document.getElementById("clockParams_"+clock).style.display = "block";
								}
							);
						}
					);	
				}
			}
		}
		document.getElementById("AddClocklayer").style.display = 'none';
		if (addclockact == "block")
		{
			alert("New task pool successfully created.");
		}
	}
</script>
<script>
	function backToPools()
	{
		var random = new Date().getTime();
		$('#elemento4').load('ParamsAcqView.jsp', "rand ="+random);
	}
</script>
<script>
	function UpdateParams(ip_host)
	{
		var elems = document.getElementById("clocksTab").getElementsByTagName("td");
		var paramslist = "";
		var paramsbinval = new Array();
		var paramsval = 0;
		var found = false;
		var i = 0;
		var clockId = -1;
		while ((!found) && (i<elems.length))
		{
			if (elems[i].bgColor == "ddddff")
			{
				found = true;
				clockId = elems[i].id;
			}
			else i++;
		}
		var arr = clockId.split("_");
		clockId = arr[1];
		
		var elems2 = document.getElementById("clockParams_"+clockId).getElementsByTagName("input");
		var paramsnum = elems2.length;
		for (var i = 0; i < elems2.length; i++) { 
			if (i == 0)
				paramslist = elems2[i].name;
			else
				paramslist = paramslist + "," + elems2[i].name;
			if (elems2[i].checked == true)
			{
				paramsbinval[i] = 1;
			}
			else
			{
				paramsbinval[i] = 0;
			}
		}
		for (i = 0; i < elems2.length; i++) { 
			paramsval = paramsval + paramsbinval[i] * Math.pow(2, i);
		}

		$.post("http://"+ip_host+":8080/dms/UpdatePollingTaskParametersServlet?taskid="+clockId+"&paramsnum="+paramsnum+"&paramslist="+paramslist+"&paramsetting="+paramsval,
			function()
			{
	    		document.getElementById("selAllParams").disabled = true;
	    		document.getElementById("editParamsDiv").style.display = 'block';
	    	    document.getElementById("applyCancelEditParamsDiv").style.display = 'none';
	    		for (i = 0; i < elems2.length; i++) { 
	    			paramsval = paramsval + paramsbinval[i] * Math.pow(2, i);
	    			elems2[i].disabled = true;
	    		}
			}
		);
	}f
</script>
<script>
	function submitData()
	{
		var formData = $("#clocksParamsForm").serialize();
		$('#clocksParamsForm').click(function(){
			$.ajax({
				url: 'UpdatePollingTaskServlet',
				type:'POST',
				data: formData,
				success: 
					function(msg)
					{
						//alert("Success");
					}                   
			});
		});
	}
</script>
<script>
	function selectAllClocks()
	{
		var elems = document.getElementById("clocksTab").getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) { 
			elems[i].checked = true;
		}
	}
</script>
<script>
	function selectAllParams(clockdiv)
	{		
		var elems = document.getElementById("clocksTab").getElementsByTagName("td");
		var found = false;
		var i = 0;
		var clockId = -1;
		while ((!found) && (i<elems.length))
		{
			if (elems[i].bgColor == "ddddff")
			{
				found = true;
				clockId = elems[i].id;
			}
			else i++;
		}
		var arr = clockId.split("_");
		clockId = arr[1];
		var elems = document.getElementById("clockParams_"+clockId).getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) 
		{ 
			elems[i].checked = document.getElementById("selAllParams").checked;
		}
	}
</script>
<script>
	function selectAllClockParams(clock)
	{
		alert("selectAllClockParams");
		var elems = document.getElementById("clockParams_"+clock).getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) 
		{
			elems[i].checked = document.getElementById(clock).checked;
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function visualizzaTaskPoolSchedule(poolid){
		var random = new Date().getTime();
		$('#elemento4').load('ViewTaskPoolSchedule.jsp?param1='+poolid, "randvar="+random);
	}
</script>
<script>
	function visualizzaParams(task, clock, index)
	{
		document.getElementById("paramsDiv").style.display = 'none'; 
	}
</script>
<script>
	function checkClockRow(elem, task, clock)
	{
		document.getElementById(elem).focus();
		var table = document.getElementById("clocksTab");
		var rows = table.getElementsByTagName("tr");
		var i = 0;
		for (i = 0; i < rows.length; i++)
		{	
			var col = rows[i].getElementsByTagName("td");
			col[0].style.backgroundColor = "white";
			col[0].bgColor = "white";
		}	
		document.getElementById(elem).style.backgroundColor = "ddddff";
		document.getElementById(elem).bgColor = "ddddff";
		var elems = document.getElementById("paramsDiv").getElementsByTagName("div");
		for (var i = 0; i < elems.length; i++) { 
			if (elems[i].id != "paramsDivHeader_"+clock)
				elems[i].style.display = 'none';
		}
		document.getElementById("clockParams_"+clock).style.display = "block";
	}
</script>
<script>
	function checkParamRow(elem, task, clock)
	{
		document.getElementById(elem).focus();
		var table = document.getElementById("paramsTab");
		var rows = table.getElementsByTagName("tr");
		var i = 0;
		for (i = 0; i < rows.length-1; i++)
		{	
			var col = rows[i].getElementsByTagName("td");
			col[0].style.backgroundColor = "white";
		}	
		document.getElementById(elem).style.backgroundColor = "ddddff";
	}
</script>
<script>
	function modificaPollingTaskParameters(poolid, pollingTaskId)
	{
		var elems = document.getElementById("clocksTab").getElementsByTagName("td");
		//var paramslist = "";
		//var paramsbinval = new Array();
		//var paramsval = 0;
		var found = false;
		var i = 0;
		var clockId = -1;
		while ((!found) && (i<elems.length))
		{
			if (elems[i].bgColor == "ddddff")
			{
				found = true;
				clockId = elems[i].id;
			}
			else i++;
		}
		var arr = clockId.split("_");
		clockId = arr[1];
		
		document.getElementById("editParamsDiv").style.display = 'none';
	    document.getElementById("applyCancelEditParamsDiv").style.display = 'block';
		document.getElementById("selAllParams").disabled = false;			
		//var elems = document.getElementById("paramsDiv").getElementsByTagName("input");
		//var elems = document.getElementById("clockParams_"+pollingTaskId).getElementsByTagName("input");
		var elems = document.getElementById("clockParams_"+clockId).getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) { 
			elems[i].disabled = false;
		}
	}
</script>
<script>
	function deleteClock()
	{
		var elems = document.getElementById("clocksDiv").getElementsByTagName("<td>");
		for (var i = 0; i < elems.length; i++) { 
			if (elems[i].style.backgroundColor == "ddddff")
			{
				alert("Elimino il ddddff");
			}
		}
	}
</script>
<script>
	function cancelModificaPollingTask(poolid)
	{
		document.getElementById("editParamsDiv").style.display = 'block';
	    document.getElementById("applyCancelEditParamsDiv").style.display = 'none';
		var elems = document.getElementById("clocksTab").getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) { 
			elems[i].disabled = true;
		}
		document.getElementById("selAllParams").disabled = true;
		elems = document.getElementById("paramsDiv").getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) { 
			elems[i].disabled = true;
		}
		$('#elemento4').load('ViewTaskPool.jsp?poolid='+poolid+'&addclockactive=none', "randvar="+random);
	}
</script>
<script>
	function editClocks()
	{
		if (document.getElementById("editClocksButton").value == "Edit")
		{
			document.getElementById("selAllClocks").disabled = false;
			var elems = document.getElementById("clocksTab").getElementsByTagName("input");
			for (var i = 0; i < elems.length; i++) { 
				elems[i].disabled = false;
			}
			document.getElementById("editClocksButton").value = "Save";
		}
		else
		{
			document.clocksForm.submit();
			document.getElementById("editClocksButton").value = "Edit";
		}
	}
</script>

<script language="JavaScript" type="text/javascript">
var NS4 = (navigator.appName == "Netscape" && parseInt(navigator.appVersion) < 5);

function addOption(theSel, theText, theValue)
{
  var newOpt = new Option(theText, theValue);
  var selLength = theSel.length;
  theSel.options[selLength] = newOpt;
}

function deleteOption(theSel, theIndex)
{ 
  var selLength = theSel.length;
  if(selLength>0)
  {
    theSel.options[theIndex] = null;
  }
}

function moveOptions(theSelFrom, theSelTo)
{
  var selLength = theSelFrom.length;
  var selectedText = new Array();
  var selectedValues = new Array();
  var selectedCount = 0;
  
  var i;
  
  // Find the selected Options in reverse order
  // and delete them from the 'from' Select.
  for(i=selLength-1; i>=0; i--)
  {
    if(theSelFrom.options[i].selected)
    {
      selectedText[selectedCount] = theSelFrom.options[i].text;
      selectedValues[selectedCount] = theSelFrom.options[i].value;
      deleteOption(theSelFrom, i);
      selectedCount++;
    }
  }
  
  // Add the selected text/values in reverse order.
  // This will add the Options to the 'to' Select
  // in the same order as they were in the 'from' Select.
  for(i=selectedCount-1; i>=0; i--)
  {
    addOption(theSelTo, selectedText[i], selectedValues[i]);
  }
  
  if(NS4) history.go(0);
}
</script>

</html>