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
#AddEnvlayer {
	
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
		
	int loggerid = -1;
	int pollingTaskId = -1;
	String poolid = request.getParameter("poolid").toString();
	String poolname = request.getParameter("poolname");
	String addenvactive = request.getParameter("addenvactive");
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);

	Statement statement = null;
	Statement statement2 = null;
	Statement statement3 = null;
	ResultSet rs = null;
	ResultSet rs3 = null;

	statement = dbconn.createStatement();
	statement2 = dbconn.createStatement();
	statement3 = dbconn.createStatement();
	
	String q = "Select distinct(Polling_Task) as Polling_Task, Data_Logger_ID, Data_Logger_Name from exp_vw_env_monitoring_polling_pools_info where ID="+poolid;
	rs = statement.executeQuery(q);
	while(rs.next())
	{
		loggerid = rs.getInt("Data_Logger_ID");
		pollingTaskId = rs.getInt("Polling_Task");
	}
	rs = statement.executeQuery(q);
	String q3 = "SELECT * FROM exp_vw_env_monitoring_polling_pools where ID="+poolid;
	rs3 = statement3.executeQuery(q3);
	if (rs3.next())
	{
		poolname = rs3.getString("Polling Description");
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

<table width="100%">
	<tr>
		<%
			out.println("<td align=left'>Polling task: <b>"+poolname+"</b> | Configuration</td>");
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

<form id="envsParamsForm" name="envsParamsForm" action="submitEnvParams.jsp" method="POST">
<table>
<tr>
	<td>
		<i>Data logger</i>
		<div id="envsDivHeader" style="border:solid 2px #000000; padding:4px; width:500px; height:25px; overflow:auto;">
		</div>
		
		<div id="envsDiv" style="border:solid 2px #000000; padding:4px; width:500px; height:300px; overflow:auto;">
			<table id='envsTab' width="100%">
			<%
				int i = 0;
				// Ciclo sui parametri ambientali
				while((rs!=null) && (rs.next()))
				{
					out.println("<tr>");
					if (i == 0)
					{
						out.println("<td style='text-align:left;cursor:pointer;' id='env_"+rs.getInt("Polling_Task")+"' bgColor='ddddff' onClick=checkEnvRow('env_"+rs.getInt("Polling_Task")+"','"+poolid+"','"+rs.getInt("Polling_Task")+"');>"+rs.getString("Data_Logger_Name"));
					}
					else
					{
						out.println("<td style='text-align:left;cursor:pointer;' id='env_"+rs.getInt("Polling_Task")+"' onClick=checkEnvRow('env_"+rs.getInt("Polling_Task")+"','"+poolid+"','"+rs.getInt("Polling_Task")+"');>"+rs.getString("Data_Logger_Name"));
					}
					//out.println("<input id='"+rs.getInt("Polling_Task")+"' name='"+rs.getString("Data_Logger_Name")+"' type='radio' >"+rs.getString("Data_Logger_Name")+"</input>");		
					
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
		out.println("<td align='left'><input id='selAllParams' type='checkbox' onChange=selectAllParams('envParams_"+pollingTaskId+"'); disabled>Select All</td>");
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
			<!--<table id='envsTab' width="100%">-->
			<%
				i = 0;
				if (rs != null) rs.first();
				String visible = "";
				String q2 = "";
				ResultSet rs2 = null;
				if ((loggerid != -1) && (rs != null))
				{
					do
					{
						loggerid = rs.getInt("Data_Logger_ID");
						pollingTaskId = rs.getInt("Polling_Task");
						if (i == 0) visible = "";
						else visible = "style='display:none'";
						q2 = "Select Parameter_Name, Parameter_ID, Is_Enabled from exp_vw_env_monitoring_polling_pools_info where ID='"+poolid+"' and Data_Logger_ID='"+rs.getInt("Data_Logger_ID")+"'";
						rs2 = statement2.executeQuery(q2);
						out.println("<div id='envParams_"+pollingTaskId+"' "+visible+">");	
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
	</td>
	<td>
		<table>
			<tr>
				<td>
				</td>
				<td>
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
		$('#elemento5').load('EnvParamsView.jsp', "randvar="+random);
	}
</script>
<script>
	function OpenAddEnvPopUp()
	{
		document.getElementById("AddEnvlayer").style.display = 'block';
	}
</script>
<script>
	function CloseAddEnvPopUp()
	{
		document.getElementById("AddEnvlayer").style.display = 'none';
	}
</script>
<script>
	function DeleteEnv(poolid, ip_host)
	{
		var elems = document.getElementById("envsDiv").getElementsByTagName("input");
		var counter = 0;
		for (var i = 0; i < elems.length; i++)
		{
			if (elems[i].checked == true) counter++;
		}
		if (counter == 0)
		{
			alert("No data logger selected! Please select the data logger(s) to be removed using check box.");
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
				    			$('#elemento5').load('ViewTaskPool.jsp?poolid='+poolid+"&addclockactive=none", "randvar="+random);
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
						if (confirm("Removing this data logger the pool will be also removed. Continue?") == true)
						{
							$.get("http://"+ip_host+":8080/dms/DeletePollingTaskServlet?poolid="+poolid+"&clockid="+elems[i].id,
					   			function()
								{
									var random = new Date().getTime();
									$('#elemento5').load('ViewEnvParams.jsp', "rand ="+random);
								}
							);
						} 
					}
					else if (confirm("Delete the data logger "+elems[i].name+"?") == true)
					{
						$.get("http://"+ip_host+":8080/dms/DeletePollingTaskServlet?poolid="+poolid+"&clockid="+elems[i].id,
				   			function()
							{
				    			$('#elemento5').load('ViewEnvParamsTaskPool.jsp?poolid='+poolid+"&addclockactive=none", "randvar="+random);
							}
						);
					} 	
				}
			}
	    }
	}
</script>
<script>
	function ConfirmAddEnv(poolid, ip_host, addclockact)
	{
		var clocklist = document.getElementById("addEnvSelect");
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
						$('#elemento5').load('ViewEnvParamsTaskPool.jsp?poolid='+poolid+'&addclockactive=none&randvar='+random,
							function()
							{
								//document.getElementById(elem).focus();
								//'clock_"+rs.getInt("Polling_Task")+"'
								var table = document.getElementById("envsTab");
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
								document.getElementById("envParams_"+clock).style.display = "block";
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
							$('#elemento5').load('ViewEnvParamsTaskPool.jsp?poolid='+poolid+'&addclockactive=none&randvar='+random,
								function()
								{
									//document.getElementById(elem).focus();
									//'clock_"+rs.getInt("Polling_Task")+"'
									var table = document.getElementById("envsTab");
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
									clock = clock.substr(4);
									for (var i = 0; i < elems.length; i++) { 
										if (elems[i].id != "paramsDivHeader_"+clock)
											elems[i].style.display = 'none';
									}
									document.getElementById("envParams_"+clock).style.display = "block";
								}
							);
						}
					);	
				}
			}
		}
		document.getElementById("AddEnvlayer").style.display = 'none';
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
		$('#elemento5').load('EnvParamsView.jsp', "rand ="+random);
	}
</script>
<script>
	function UpdateParams(ip_host)
	{
		var elems = document.getElementById("envsTab").getElementsByTagName("td");
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
		
		var elems2 = document.getElementById("envParams_"+clockId).getElementsByTagName("input");
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

		$.post("http://"+ip_host+":8080/dms/UpdatePollingTaskEnvParametersServlet?taskid="+clockId+"&paramsnum="+paramsnum+"&paramslist="+paramslist+"&paramsetting="+paramsval,
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
		var formData = $("#envsParamsForm").serialize();
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
	function selectAllEnvs()
	{
		var elems = document.getElementById("envsTab").getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) { 
			elems[i].checked = true;
		}
	}
</script>
<script>
	function selectAllParams(clockdiv)
	{		
		var elems = document.getElementById("envsTab").getElementsByTagName("td");
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
		var elems = document.getElementById("envParams_"+clockId).getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) 
		{ 
			elems[i].checked = document.getElementById("selAllParams").checked;
		}
	}
</script>
<script>
	function selectAllEnvParams(clock)
	{
		alert("selectAllClockParams");
		var elems = document.getElementById("envParams_"+clock).getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) 
		{
			elems[i].checked = document.getElementById(clock).checked;
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function visualizzaTaskPoolSchedule(poolid){
		var random = new Date().getTime();
		$('#elemento5').load('ViewEnvParamsTaskPoolSchedule.jsp?param1='+poolid, "randvar="+random);
	}
</script>
<script>
	function visualizzaParams(task, clock, index)
	{
		document.getElementById("paramsDiv").style.display = 'none'; 
	}
</script>
<script>
	function checkEnvRow(elem, task, clock)
	{
		document.getElementById(elem).focus();
		var table = document.getElementById("envsTab");
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
		document.getElementById("envParams_"+clock).style.display = "block";
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
		var elems = document.getElementById("envsTab").getElementsByTagName("td");
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
		//var elems = document.getElementById("envParams_"+pollingTaskId).getElementsByTagName("input");
		var elems = document.getElementById("envParams_"+clockId).getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) { 
			elems[i].disabled = false;
		}
	}
</script>
<script>
	function deleteEnv()
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
		var elems = document.getElementById("envsTab").getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) { 
			elems[i].disabled = true;
		}
		document.getElementById("selAllParams").disabled = true;
		elems = document.getElementById("paramsDiv").getElementsByTagName("input");
		for (var i = 0; i < elems.length; i++) { 
			elems[i].disabled = true;
		}
		$('#elemento5').load('ViewEnvParamsTaskPool.jsp?poolid='+poolid+'&addclockactive=none', "randvar="+random);
	}
</script>
<script>
	function editEnvs()
	{
		if (document.getElementById("editClocksButton").value == "Edit")
		{
			document.getElementById("selAllEnvs").disabled = false;
			var elems = document.getElementById("envsTab").getElementsByTagName("input");
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