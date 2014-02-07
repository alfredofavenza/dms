<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- STYLE -->
 
<!-- HTML -->
<table cellpadding="0" cellspacing="0" border="0" class="display" id="eventlog">
	<%
	String q = "";
	String eventType = request.getParameter("evType");
	String eventDataId = request.getParameter("evDataId");
	q = "select evtTable from event_type where id ="+eventType;
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
	ResultSet rs;
	Statement statement = dbconn.createStatement();
	rs = statement.executeQuery(q);
	rs.next();
	String tableName = rs.getString(1);
	q = "select * from "+tableName+" where id ="+eventDataId;
	rs = statement.executeQuery(q);
	ResultSetMetaData rsmd = rs.getMetaData();
	int noOfColumns = rsmd.getColumnCount();
	int i;
	%>
	<thead>
		<tr>
		<%
		for (i = 1; i <= noOfColumns; i++)
		{
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		}
		out.println("<th></th>");
		%>
		</tr>
	</thead>
	<tbody>
		<%
		while (rs.next())
		{
			out.println("<tr>");
			for (i = 1; i <= noOfColumns; i++)
			{
				out.println("<td>");
				if (i == 2)
				{
					String data = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(rs.getTimestamp(rsmd.getColumnName(i)));
					out.println(data);
				}
				else out.println(rs.getObject(rsmd.getColumnName(i)));
				out.println("</td>");
			}
			out.println("<td>");
			out.println("<a href='#' onClick='backToEventLogTable()'>Back</a>");
			out.println("</td>");
			out.println("</tr>");
		}
		rs.close();
		statement.close();
		dbconn.close();
		%>
	</tbody>
	<tfoot>
	<tr>
	</tr>
	</tfoot>
</table>
<!-- SCRIPT -->
<script>
	function backToEventLogTable() {
		var random = new Date().getTime();
		filterEventLog();
		document.getElementById("firstTab").innerHTML = "<a href='#eventLogTable'>Event Log Viewer</a>"
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
			$('ul.limit_length li.css_link').css('display','none');
		} );
	}
	$(document).ready( function() {
		fnFeaturesInit();
		var oTable = $('#eventlog').dataTable( {
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"bFilter": false,
			"bAutoWidth": false,
			"bSort": false
		} );
	} );
</script>