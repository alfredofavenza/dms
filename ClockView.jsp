<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- HMTL -->
<div id ="elemento2">
<div align="right">
<!--<input type="button" value="New" onclick="nuovoClock();"/>-->
<a href="#" onclick="nuovoClock();">New</a>
</div>
<table cellpadding="0" cellspacing="0" border="0" class="display" id="clock">
	<thead>
		<tr>
			<th>Clock_Name</th>
			<th>Clock_Serial_Number</th>
			<th>Clock_Class</th>
			<th>Associated_Physical_Signal</th>
			<th>Is_Master_Clock</th>
			<th>Is_Enabled</th>
			<th></th>
			<th></th>
		</tr>
	</thead>
	<tbody>
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
	
	//Query estrazione dati
	Statement statement = dbconn.createStatement();
	//String q = "SELECT * FROM clock";
	String q = "SELECT * FROM vw_exposed_clock_info";
	ResultSet rs = statement.executeQuery(q);
	String nome;
	while (rs.next())
	{
		out.println("<tr>");

			out.println("<td>");
			out.println(rs.getString("Clock_Name"));
			out.println("</td>");
			out.println("<td>");	
			out.println(rs.getString("Clock_Serial_Number"));
			out.println("</td>");
			out.println("<td>");
			out.println(rs.getString("Clock_Class"));			
			out.println("</td>");
			out.println("<td>");	
			out.println(rs.getInt("Associated_Physical_Signal"));			
			out.println("</td>");
			out.println("<td>");
			if (rs.getInt("Is_Master_Clock") == 1)
			{
				out.println("<a href='#'><img src='immagini/check.png' style='border-style:none;width:15px;height:15px;'/></a>");
				
			}
			else
			{
				//out.println("<input type='checkbox' checked='no'>");
			}
			out.println("</td>");
			out.println("<td>");
			if (rs.getInt("Is_Enabled") == 1)
			{
				out.println("<a href='#'><img src='immagini/check.png' style='border-style:none;width:15px;height:15px;'/></a>");
				
			}
			else
			{
				//out.println("<input type='checkbox' checked='no'>");
			}			
			out.println("</td>");
			out.println("<td>");
			out.println("<a href='#' OnClick=modificaClock('"+rs.getInt("ID")+"');>Edit</a>");
			out.println("</td>");		
			out.println("<td>");
			out.println("<a href='#' OnClick=eliminaClock('"+rs.getInt("ID")+"','"+rs.getInt("Is_Master_Clock")+"','"+ip_host+"');>Delete</a>");
			out.println("</td>");
		out.println("</tr>");
	}
	rs.close();
	statement.close();
	dbconn.close();
	%>
	</tbody>
</table>
<br>
<!--<input type="button" value="New Clock" onclick="nuovoClock();"/>-->
</div>

<!-- SCRIPT -->
<script type="text/javascript" charset="utf-8">
	function nuovoClock(){
		var random = new Date().getTime();
		$('#elemento2').load('CreateClock.jsp', "randvar="+random);
		if ((document.getElementById("querytext")) != null)
		{
			var query = document.getElementById("querytext").value;
			$('#container1').load('Visualize.jsp?param='+query+'&view_id=2', "randvar="+random);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function modificaClock(id){
		var random = new Date().getTime();
		$('#elemento2').load('EditClock.jsp?param='+id, "randvar="+random);
		if ((document.getElementById("querytext")) != null)
		{
			var query = document.getElementById("querytext").value;
			$('#container1').load('Visualize.jsp?param='+query+'&view_id=2', "randvar="+random);
		}
	}
</script>
<script type="text/javascript" charset="utf-8">
	function eliminaClock(id, master, ip_host){
		var random = new Date().getTime();
		var query;
		if (master == 0)
		{
			if (confirm("Delete this clock?") == true)
			{
				$.get('http://'+ip_host+':8080/dms/DeleteClockServlet?id='+id+'&newmasterid=&randvar='+random, 
					function()
					{
						$('#tabs-2').load('ClockView.jsp', "randvar="+random);
						if ((document.getElementById("querytext")) != null)
						{
							query = document.getElementById("querytext").value;
							$('#container1').load('Visualize.jsp?param='+query+'&view_id=2', "randvar="+random);
						}
					}
				);
				alert("Clock deleted");
			}
			else
			{
				$('#tabs-2').load('ClockView.jsp', "randvar="+random);
			}
		}
		else
		{
			if (confirm("Are you sure?") == true)
			{
				$('#tabs-2').load('ClockView.jsp', "randvar="+random);
			}
			else
			{
				$('#tabs-2').load('ClockView.jsp', "randvar="+random);
			}
		}
		if ((document.getElementById("querytext")) != null)
		{
			query = document.getElementById("querytext").value;
			$('#container1').load('Visualize.jsp?param='+query+'&view_id=2', "randvar="+random);
		}
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
		$('#clock').dataTable( {
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
			//"sScrollY": "400px"
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
});
</script>

