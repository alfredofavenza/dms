<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- STYLE -->
<link rel="stylesheet" type="text/css" href="TableTools/media/css/TableTools.css" />
<!-- HTML -->
<div id = "elemento">
<div align="right">
<!--<input type="button" value="New" onclick="nuovoSegnale();"/>-->
<a href="#" onclick="nuovoSegnale();">New</a>
</div>
<table cellpadding="0" cellspacing="0" border="0" class="display" id="signal">
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
	String q = "SELECT * FROM vw_exposed_signal_info order by ID asc";
	ResultSet rs = statement.executeQuery(q);
	ResultSetMetaData rsmd = rs.getMetaData();
	int noOfColumns = rsmd.getColumnCount();
	String nome;
	int i;
	
	out.println("<thead><tr>");
	for (i = 1; i <= noOfColumns; i++)
	{
		if (!rsmd.getColumnName(i).equals("ID"))
		{
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		}
	}	
	out.println("<th></th>");
	out.println("<th></th>");
	out.println("</tr><thead>");
	out.println("<tbody>");
	while (rs.next())
	{
		out.println("<tr>");;
			out.println("<td>");	
			out.println(rs.getString("Signal_Name"));
			out.println("</td>");
			out.println("<td>");	
			out.println(rs.getString("Signal_Description"));
			out.println("</td>");
			out.println("<td>");
			out.println(rs.getString("Signal_Class"));			
			out.println("</td>");
			out.println("<td>");	
			out.println(rs.getInt("Logical_Channel"));			
			out.println("</td>");
			out.println("<td>");
			out.println(rs.getDouble("Delay_ns"));
			out.println("</td>");
			out.println("<td>");
			out.println(rs.getDouble("Offset_ns"));
			out.println("</td>");
			out.println("<td>");
			if (rs.getInt("Is_Enabled") == 1)
			{
				out.println("<img src='immagini/check.png' style='border-style:none;width:15px;height:15px;'/>");
			}
			else
			{
				//out.println("<input type='checkbox' checked='no'>");
			}
			out.println("<td>");
			out.println("<a href='#' OnClick=modificaSegnale('"+rs.getInt("id")+"');>Edit</a>");
			out.println("</td>");
			out.println("<td>");
			out.println("<a href='#' OnClick=eliminaSegnale('"+rs.getInt("id")+"','"+ip_host+"');>Delete</a>");
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
<!--
<br>
<input type="button" value="New Signal" onclick="nuovoSegnale();"/>

-->
<!-- SCRIPT -->
<script type="text/javascript" charset="utf-8">
	function nuovoSegnale(){
		var random = new Date().getTime();
		$('#elemento').load('CreateSignal.jsp', "randvar="+random);
	}
</script>
<script type="text/javascript" charset="utf-8">
	function modificaSegnale(id){
		var random = new Date().getTime();
		$('#elemento').load('EditSignal.jsp?param='+id, "randvar="+random);
	}
</script>
<script type="text/javascript" charset="utf-8">
	function eliminaSegnale(id, host_ip){
		var random = new Date().getTime();
		if (confirm("Delete this Signal?") == true)
		{
			$.get('http://'+host_ip+':8080/dms/DeleteSignalServlet?id='+id+'&randvar='+random, 
				function()
				{
					$('#elemento').load('SignalView.jsp', "randvar="+random);
					if ((document.getElementById("querytext")) != null)
					{
						var query = document.getElementById("querytext").value;
						$('#container1').load('Visualize.jsp?param='+query+'&view_id=1', "randvar="+random);
					}
				}
			);		
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
		var oTable = 
		$('#signal').dataTable( {
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
        //oTable.fnAdjustColumnSizing();
		//SyntaxHighlighter.config.clipboardSwf = 'media/javascript/syntax/clipboard.swf';
		//SyntaxHighlighter.all();
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

