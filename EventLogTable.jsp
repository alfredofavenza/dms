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
	String dateFrom = request.getParameter("dateF");
	String dateTo = request.getParameter("dateT");
	String tipo = request.getParameter("type");
	if (tipo != null)
	{
		if (tipo.equals("TimeFrequencySteps")) tipo = "Time Frequency Steps";
	}
	String severity = request.getParameter("severity"); 
	String source = request.getParameter("source");
	String dayFrom, monthFrom, yearFrom, hoursFrom, minutesFrom, secondsFrom;
	String dayTo, monthTo, yearTo, hoursTo, minutesTo, secondsTo;
	StringTokenizer st1;
	StringTokenizer st2;
	if ( ((dateFrom == null) || (dateFrom == "")) && ((dateTo == null) || (dateTo == "")) )
	{
	    //q = "SELECT * FROM event_descriptor";
		q = "SELECT * FROM vw_exposed_event_description";
		if ((tipo != null) || (severity != null) || (source != null))
		{
			q = q + " where ";
			if (tipo != "")
			{
				q = q + "Type = '"+tipo+"'";
				q = q + " and ";
			}
			if (severity != "")
			{
				q = q + "Severity = '"+severity+"'";
				q = q + " and ";
			}
			if (source != "")
			{
				q = q + "Originator = '"+source+"'";
				q = q + " and ";
			}
			String query = q.substring(0,q.length()-5);
			q = query;
		}
	}
	else if ((dateFrom != "") && (dateTo != ""))
	{ 
		st1 = new StringTokenizer(dateFrom,"-");
		yearFrom = st1.nextToken();
		monthFrom = st1.nextToken();
		dayFrom = st1.nextToken();
		hoursFrom = request.getParameter("hourF");
		minutesFrom = request.getParameter("minF");
		secondsFrom = request.getParameter("secF");
		dateFrom = yearFrom+"-"+monthFrom+"-"+dayFrom+" "+hoursFrom+":"+minutesFrom+":"+secondsFrom;

		st2 = new StringTokenizer(dateTo,"-");
		yearTo = st2.nextToken();
		monthTo = st2.nextToken();
		dayTo = st2.nextToken();
		hoursTo = request.getParameter("hourT");
		if (hoursTo == "") hoursTo = "23";
		minutesTo = request.getParameter("minT");
		if (minutesTo == "") hoursTo = "59";
		secondsTo = request.getParameter("secT");
		if (secondsTo == "") hoursTo = "59";
		dateTo = yearTo+"-"+monthTo+"-"+dayTo+" "+hoursTo+":"+minutesTo+":"+secondsTo; 
		q = "SELECT * FROM vw_exposed_event_description where Date_Time >= '"+dateFrom+"' and Date_Time <= '"+dateTo+"'";
		if (tipo != "") q = q + "and Type = '"+tipo+"'";
		if (severity != "") q = q + "and Severity = '"+severity+"'";
		if (source != "") q = q + "and Originator = '"+source+"'";
	}
	else if ((dateFrom != "") && (dateTo == ""))
	{
		st1 = new StringTokenizer(dateFrom,"-");
		yearFrom = st1.nextToken();
		monthFrom = st1.nextToken();
		dayFrom = st1.nextToken();
		hoursFrom = request.getParameter("hourF");
		minutesFrom = request.getParameter("minF");
		secondsFrom = request.getParameter("secF");
		dateFrom = yearFrom+"-"+monthFrom+"-"+dayFrom+" "+hoursFrom+":"+minutesFrom+":"+secondsFrom;
		q = "SELECT * FROM vw_exposed_event_description where Date_Time >= '"+dateFrom+"'";
		if (tipo != "") q = q + "and Type = '"+tipo+"'";
		if (severity != "") q = q + "and Severity = '"+severity+"'";
		if (source != "") q = q + "and Originator = '"+source+"'";
	}
	else if ((dateFrom == "") && (dateTo != ""))
	{
		st2 = new StringTokenizer(dateTo,"-");
		yearTo = st2.nextToken();
		monthTo = st2.nextToken();
		dayTo = st2.nextToken();
		hoursTo = request.getParameter("hourT");
		if (hoursTo == "") hoursTo = "23";
		minutesTo = request.getParameter("minT");
		if (minutesTo == "") hoursTo = "59";
		secondsTo = request.getParameter("secT");
		if (secondsTo == "") hoursTo = "59";
		dateTo = yearTo+"-"+monthTo+"-"+dayTo+" "+hoursTo+":"+minutesTo+":"+secondsTo; 
		q = "SELECT * FROM vw_exposed_event_description where Date_Time <= '"+dateTo+"'";
		if (tipo != "") q = q + "and Type = '"+tipo+"'";
		if (severity != "") q = q + "and Severity = '"+severity+"'";
		if (source != "") q = q + "and Originator = '"+source+"'";
	}
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
	ResultSetMetaData rsmd = rs.getMetaData();
	int noOfColumns = rsmd.getColumnCount();
	int i;
	%>
	<thead>
		<tr>
		<%
		for (i = 1; i <= noOfColumns; i++)
		{
			if (!rsmd.getColumnName(i).equals("ID"))
				out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		}
		%>
		<!--<th></th>-->
		</tr>
	</thead>
	<tbody>
	<%
	String nome;
	int eventType;
	int eventDataId;
	while (rs.next())
	{
		out.println("<tr>");
		eventDataId = rs.getInt(rsmd.getColumnName(1));	
		out.println("<td>");
		String color ="";
		if (rs.getObject(rsmd.getColumnName(2)).equals("Information")) color="green";
		else if (rs.getObject(rsmd.getColumnName(2)).equals("Warning")) color="yellow";
		else if (rs.getObject(rsmd.getColumnName(2)).equals("Error")) color="red";
		out.println("<font color="+color+"><b>"+rs.getObject(rsmd.getColumnName(2))+"</b></font>");
		out.println("</td>");
		out.println("<td>");
		String timetag = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(rs.getTimestamp(rsmd.getColumnName(3)));
		out.println(timetag);
		out.println("</td>");
		out.println("<td>");
		out.println(rs.getObject(rsmd.getColumnName(4)));
		out.println("</td>");
		out.println("<td>");
		out.println(rs.getObject(rsmd.getColumnName(5)));
		out.println("</td>");	
		
		if (rs.getString(rsmd.getColumnName(6)).equals("Message")) eventType = 3;
		else if (rs.getString(rsmd.getColumnName(6)).equals("Steering")) eventType = 1;
		else eventType = 2;
		
		out.println("<td>");
		out.println(rs.getString(rsmd.getColumnName(6)));
		out.println("</td>");	
		out.println("<td>");
		out.println(rs.getObject(rsmd.getColumnName(7)));
		out.println("</td>");
		
		out.println("<td>");
		eventDataId = rs.getInt(rsmd.getColumnName(8));	
		if (eventDataId != 0)
		{
			out.println("<a href='#' onClick='OpenDetailsTable("+eventType+","+eventDataId+");'>View</a>");
		}
		else
		{
			out.println("");
		}
		out.println("</td>");
		out.println("</tr>");
	}
	%>
	</tbody>
	<tfoot>
	<tr>
	<%
		for (i = 2; i <= noOfColumns; i++)
		{
			out.println("<th>");
			out.println("</th>");
		}
		rs.close();
		statement.close();
		dbconn.close();
	%>
	</tr>
	</tfoot>
</table>
<!-- SCRIPT -->
<script>
	function OpenDetailsTable(evType, evDataId) {
		var random = new Date().getTime();
		$('#eventLogTable').load('EventLogTableDetails.jsp?evType='+evType+'&evDataId='+evDataId, "rand ="+random);
		var tipoevento;
		if (evType == 1)
		{
			tipoevento = "Steering ";
		}
		else if (evType == 2)
		{
			tipoevento = "Time Frequency Step ";
		}
		else
		{
			tipoevento = "Generic Message ";
		}
		document.getElementById("firstTab").innerHTML = "<a href='#eventLogTable' onClick='backToEventLogTable();'>Event Log Viewer  ></a><a>"+tipoevento+" Event Details</a>"
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
			"bStateSave": true,
			"bFilter": false,
			"bAutoWidth": false,
			"bSort" : false,
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
		//$("div.fg-toolbar").html('<table style="width:1180"><tr><td><a href="#" onClick="openTimeFilter()" id="timeFilter">[+]Time filter</a></td><td align="right"><input type="button" value="New Event Log" onclick="newEventLog();"/></td></tr></table>');	
		
		//SyntaxHighlighter.config.clipboardSwf = 'media/javascript/syntax/clipboard.swf';
		//SyntaxHighlighter.all();
	} );
</script>