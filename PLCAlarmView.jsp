<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- STYLE -->
<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />

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
	Statement statement = dbconn.createStatement();
	ResultSet rs;
%>
<% 
	String alerts[] = new String[50];
	alerts[0] = "F700";
	alerts[1] = "F701";
	alerts[2] = "F702";
	alerts[3] = "F703";
	alerts[4] = "F704";
	alerts[5] = "F705";
	alerts[6] = "F706";
	alerts[7] = "F707";
	alerts[8] = "F708";
	alerts[9] = "F709";
	alerts[10] = "F710";
	alerts[11] = "F711";
	alerts[12] = "F712";
	alerts[13] = "F713";
	alerts[14] = "F714";
	alerts[15] = "F715";
	alerts[16] = "F716";
	alerts[17] = "F717";
	alerts[18] = "F718";
	alerts[19] = "F719";
	alerts[20] = "F720";
	alerts[21] = "F721";
	alerts[22] = "F722";
	alerts[23] = "F723";
	alerts[24] = "F724";
	alerts[25] = "F725";
	alerts[26] = "F726";
	alerts[27] = "F727";
	alerts[28] = "F728";
	alerts[29] = "F729";
	alerts[30] = "F730";
	alerts[31] = "F731";
	alerts[32] = "F732";
	alerts[33] = "F733";
	alerts[34] = "F734";
	alerts[35] = "F735";
	alerts[36] = "F736";
	alerts[37] = "F737";
	alerts[38] = "F738";
	alerts[39] = "F739";
	alerts[40] = "F740";
	alerts[41] = "F741";
	alerts[42] = "F742";
	alerts[43] = "F743";
	alerts[44] = "F744";
	alerts[45] = "F745";
	alerts[46] = "F746";
	alerts[47] = "F747";
	alerts[48] = "F748";
	alerts[49] = "F749";
%>
<br><br>
<div id="plcAlarmView" align="center">
<!--  
		<table>
			<tr>
			<td>
				<select>
					<option>
					</option>
					<%
						//for (int i = 0; i <= 49; i++)
						//{
						//	if (i == 0) out.println("<option selected>"+alerts[i]+"</option>");
						//	out.println("<option>"+alerts[i]+"</option>");
						//}
					%>
				</select>
			</td>
			<td id="alarmValue">
				
			</td>
			</tr>
		</table>
-->
		<div id="alertViewTable" style="width:600px;height:400px;overflow:auto;" align="center">
			<table cellpadding="0" cellspacing="0" border="0" class="display" id="alertTable" width="200px">
				<thead>
					<tr>
						<th>Alarm</th>
						<th>Address</th>
						<th>State</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i <= 49; i++)
						{
							out.println("<tr>");
							out.println("<td>Alarm "+(i+1)+" CGI</td>");
							out.println("<td>"+alerts[i]+"</td>");
							out.println("<td id='"+alerts[i]+"' onclick=CallSendCGI('"+alerts[i]+"') title='Click to activate/deactivate'></td>");
							out.println("</tr>");
						}
					%>
				</tbody>
				</table>
		</div>

</div>
<!-- SCRIPT -->
<script src="datatables/css/picker/jquery-ui.min.js" type="text/javascript"></script>
<script src="datatables/css/picker/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>

<script type="text/javascript" language="javascript" src="datatables/js/jquery-ui-tabs.js"></script>
<script type="text/javascript" charset="utf-8" src="TableTools/media/js/ZeroClipboard.js"></script>
<script type="text/javascript" charset="utf-8" src="TableTools/media/js/TableTools.js"></script>

<script>
	function CallReadCGI(ident)
	{
		$.get("http://10.10.3.210/cgi-bin/readVal.exe?PDP,,"+ident+",b", function(b){
			if (b == 0)
			{
				document.getElementById(ident).innerHTML = "<a href='#'><img src='immagini/red-led-off.png' width='20' height='20'/></a>";
			}
			else
			{
				document.getElementById(ident).innerHTML = "<a href='#'><img src='immagini/red-led-on.png' width='20' height='20'/></a>";
			}
		});
	}
</script>
<script>
	var allarmi = new Array();
	allarmi[0] = "F700";
	allarmi[1] = "F701";
	allarmi[2] = "F702";
	allarmi[3] = "F703";
	allarmi[4] = "F704";
	allarmi[5] = "F705";
	allarmi[6] = "F706";
	allarmi[7] = "F707";
	allarmi[8] = "F708";
	allarmi[9] = "F709";
	allarmi[10] = "F710";
	allarmi[11] = "F711";
	allarmi[12] = "F712";
	allarmi[13] = "F713";
	allarmi[14] = "F714";
	allarmi[15] = "F715";
	allarmi[16] = "F716";
	allarmi[17] = "F717";
	allarmi[18] = "F718";
	allarmi[19] = "F719";
	allarmi[20] = "F720";
	allarmi[21] = "F721";
	allarmi[22] = "F722";
	allarmi[23] = "F723";
	allarmi[24] = "F724";
	allarmi[25] = "F725";
	allarmi[26] = "F726";
	allarmi[27] = "F727";
	allarmi[28] = "F728";
	allarmi[29] = "F729";
	allarmi[30] = "F730";
	allarmi[31] = "F731";
	allarmi[32] = "F732";
	allarmi[33] = "F733";
	allarmi[34] = "F734";
	allarmi[35] = "F735";
	allarmi[36] = "F736";
	allarmi[37] = "F737";
	allarmi[38] = "F738";
	allarmi[39] = "F739";
	allarmi[40] = "F740";
	allarmi[41] = "F741";
	allarmi[42] = "F742";
	allarmi[43] = "F743";
	allarmi[44] = "F744";
	allarmi[45] = "F745";
	allarmi[46] = "F746";
	allarmi[47] = "F747";
	allarmi[48] = "F748";
	allarmi[49] = "F749";
	for (var i = 0; i <= 49; i++)
	{
		CallReadCGI(allarmi[i]);
	}
</script>
<script>
	function CallSendCGI(ident)
	{
		$.get("http://10.10.3.210/cgi-bin/readVal.exe?PDP,,"+ident+",b", function(b){
			if (b == 0) b = 1;
			else b = 0;
			$.get("http://10.10.3.210/cgi-bin/writeVal.exe?PDP,,"+ident+",b+"+b, function(){
				$.get("http://10.10.3.210/cgi-bin/readVal.exe?PDP,,"+ident+",b", function(b){
					if (b == 0)
					{
						document.getElementById(ident).innerHTML = "<a href='#'><img src='immagini/red-led-off.png' width='20' height='20'/></a>";
					}
					else
					{
						document.getElementById(ident).innerHTML = "<a href='#'><img src='immagini/red-led-on.png' width='20' height='20'/></a>";
					}
				});
			});
		});
	}
</script>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$("#alertTable").tabs( {
			"show": function(event, ui) {
				var oTable = $('div.dataTables_scrollBody>table.display', ui.panel).dataTable();
				if ( oTable.length > 0 ) {
					oTable.fnAdjustColumnSizing();
				}
			}
		} );
	} );
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
		var oTable = $('#alertTable').dataTable( {
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"bStateSave": false,
			"bFilter": false,
			"bAutoWidth": false,
			"bSort" : false,
			"bPaginate": false,
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
		oTable.fnAdjustColumnSizing();

	} );
</script>
