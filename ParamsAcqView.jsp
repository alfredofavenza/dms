<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- STYLE -->
<link rel="stylesheet" type="text/css" href="TableTools/media/css/TableTools.css" />
<link rel="stylesheet" type="text/css" href="datatables/css/tabs.css"/>
<style type="text/css" media="screen">
    @import "datatables/css/demo_table_jui.css";
	@import "datatables/css/demo_table.css";
	@import "datatables/css/demo_page.css";
    @import "datatables/css/inrim.css";
	@import "datatables/css/site_jui.ccss";
	@import "datatables/css/jquery-ui-1.7.2.custom.css";
	@import "datatables/css/tabs.css"
	@import "TableTools/media/css/TableTools.css";
	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes example in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#example_wrapper .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
</style> 
<!-- HTML -->
<!--
<div id="layerLoading">
	<table>
		<tr>
			<td>Loading</td>
		</tr>
		<tr>
			<td><input type="text" name="exportFileName" id="exportFileName"></input></td>
		</tr>
		<tr>
			<td>
				<input type="button" value="Cancel" onClick="javascript:setVisible('layer1')";></input>
			</td>
		</tr>
	</table>
</div>
-->
<div id="elemento4">
	<table width="100%">
		<tr>
			<td align="left"><b>List of scheduled polling tasks</b></td>
			<td align="right"><a href="#" onclick="CreateNewPool();">New</a></td>
		</tr>
	</table>

	<table cellpadding="0" cellspacing="0" border="0" class="display" id="paramacq">
		<%
		Connection dbconn = null;
		String user_db = DmsMng.dbuser;
		String pwd_db = DmsMng.dbpwd;
		String ip_db = DmsMng.dbHostIp;
		String ip_host = DmsMng.webHostIp;
		String name_db = DmsMng.dbName;
		
		//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
		//if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
	
		int poolId;
		String name;
		Integer pollingSchedule = null;
		Class.forName("com.mysql.jdbc.Driver");
		dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);
		
		//Query estrazione dati
		Statement statement = dbconn.createStatement();
		String q = "SELECT * FROM exp_vw_clock_status_polling_pools group by(ID) order by ID asc";
		ResultSet rs = statement.executeQuery(q);
		ResultSetMetaData rsmd = rs.getMetaData();
		int noOfColumns = rsmd.getColumnCount();
		String nome;
		int i;
		
		out.println("<thead><tr>");
		out.println("<th>Description</th>");
		out.println("<th>Schedule</th>");
		out.println("<th>Status</th>");
		out.println("<th></th>");
		out.println("</tr><thead>");
		out.println("<tbody>");
		while (rs.next())
		{
			out.println("<tr>");	
				poolId = rs.getInt("ID");
				pollingSchedule = rs.getInt("Polling Schedule");	
				name = "";
				out.println("<td>");	
				out.println("<a href='#' onClick=visualizzaTaskPool('"+poolId+"',escape('"+name+"'),'"+pollingSchedule+"','"+ip_host+"');>"+rs.getString("Polling Description")+"</a>");
				out.println("</td>");
				out.println("<td>");						
				out.println("<a href='#' OnClick=visualizzaTaskPoolSchedule('"+poolId+"','"+pollingSchedule+"');>View</a>");
				out.println("</td>");
				out.println("<td>");
				if (rs.getInt("Is Active") == 1)
				{
					out.println("<a href='#' title='Double click to disable'><img src='immagini/check.png' style='border-style:none;width:15px;height:15px;' /*onDblClick=ChangePoolStatus('"+poolId+"','"+ip_host+"',0);*/></a>");
				}
				else
				{
					out.println("<a href='#' title='Double click to enable'><img src='immagini/DeleteRed.png' style='border-style:none;width:15px;height:15px;' /*onDblClick=ChangePoolStatus('"+poolId+"','"+ip_host+"',1);*/></a>");
				}
				out.println("</td>");
				out.println("<td>");
				out.println("<a href='#' onClick=eliminaTaskPool('"+poolId+"','"+ip_host+"');>Delete</a>");
				out.println("</td>");
			out.println("</tr>");
		}
		rs.close();
		statement.close();
		dbconn.close();
		%>
		</tbody>
	</table>
</div>

<!-- SCRIPT -->
<script type="text/javascript">
	function load_content (id) {
		var random = new Date().getTime();
		var node = document.getElementById( id );
		node.innerHTML = load('ViewPollingTask_Backup.jsp?taskId=22', "rand ="+random);
	}
</script>
<script type="text/javascript">
	function ChangePoolStatus(poolid, host_ip, status) {
		var random = new Date().getTime();
		alert("Activate/Deactivate");
		$.get('http://'+host_ip+':8080/dms/ChangeTaskPoolStatusServlet?poolid='+poolid+'&status='+status+'&randvar='+random, 
			function()
			{
				$('#elemento4').load('ParamsAcqView.jsp', "randvar="+random);
			}
		);	
	}
</script>
<script>
	function OpenTaskDetailsTable(task) {
		var random = new Date().getTime();
		$('#paramacq').load('TaskTableDetails.jsp?taskId='+task, "rand ="+random);
	}
</script>
<script type="text/javascript" charset="utf-8">
	function CreateNewPool(){
		var random = new Date().getTime();
		$('#elemento4').load('CreateTaskPool.jsp', "randvar="+random);
	}
</script>
<script type="text/javascript" charset="utf-8">
	function eliminaTaskPool(poolid, host_ip){
		var random = new Date().getTime();
		if (confirm("Delete this task pool?") == true)
		{
			$.get('http://'+host_ip+':8080/dms/DeleteTaskPoolServlet?poolid='+poolid+'&randvar='+random, 
				function()
				{
					$('#elemento4').load('ParamsAcqView.jsp', "randvar="+random);
				}
			);		
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function visualizzaTaskPool(poolid, poolname, jobid, ip_host){
		var random = new Date().getTime();
		document.getElementById("elemento4").innerHTML = "<p align=center><b>Loading data, please wait...</b></p><p align=center><img src='immagini/loading.gif' height='30' width='30'></img></p>";
		$('#elemento4').load('ViewTaskPool.jsp?poolid='+poolid+'&poolname='+poolname+'&addclockactive=none', "randvar="+random);
		if ((document.getElementById("querytext")) != null)
		{
			var query = document.getElementById("querytext").value;
			$('#container1').load('Visualize.jsp?param='+query+'&view_id=2', "randvar="+random);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function visualizzaTaskPoolSchedule(poolid){
		var random = new Date().getTime();
		$('#elemento4').load('ViewTaskPoolSchedule.jsp?param1='+poolid, "randvar="+random);
	}
</script>
<script type="text/javascript">
	function fnFeaturesInit ()
	{
		/* Not particularly modular this - but does nicely :-) */
		$('ul.limit_length>li').each( function(i) {
			if ( i > 10 ) {
				this.style.display = 'none';
			}
		} );
		
		$('ul.limit_length').append( '<li class="css_link">Show more<\/li>' );
		$('ul.limit_length li.css_link').click( function () {
			$('ul.limit_length li').each( function(i) {
				if ( i > 5 ) {
					this.style.display = 'list-item';
				}
			} );
			$('ul.limit_length li.css_link').css( 'display', 'none' );
		} );
	}
	$(document).ready( function() {
		fnFeaturesInit();
		var oTable = 
		$('#paramacq').dataTable( {
			"bJQueryUI": true,
			"bFilter": false,
			"bStateSave": true,
			"sPaginationType": "full_numbers",
			"bProcessing": true,
			"bPaginate": true,
			"bAutoWidth": false,
			"bSort": false,
			"oLanguage": {
				 "sLengthMenu": 'Display <select>'+
				   '<option value="10">10</option>'+
				   '<option value="25" selected>25</option>'+
				   '<option value="50">50</option>'+
				   '<option value="100">100</option>'+
				   '<option value="-1">All</option>'+
				   '</select> records'
			   },
			"iDisplayLength": 25
		} );
	} );
</script>
<script type="text/javascript">
(function(){
  var bsa = document.createElement('script');
     bsa.type = 'text/javascript';
     bsa.async = true;
     bsa.src = '//s3.buysellads.com/ac/bsa.js';
  (document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(bsa);
})();
</script>

