<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- STYLE -->
<style type="text/css" media="screen">
	@import "/media/css/site.ccss";
	
	table.KeyTable {
		 border-collapse: separate;
	}
	table.KeyTable td {
		border: 3px solid transparent;
		padding: 0px 5px;
	}
	table.KeyTable td.focus {
		border: 3px solid #3366FF;
	}
</style>
<style>
	#layer2 {
		visibility: hidden;
		width: 450px;
		height: 70px;
		background-color: #ccc;
		border: 1px solid #000;
		padding: 10px 20px;
		z-index:1;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-left: -225px;
		margin-top: -35px;
	}

	#close {
		float: right;
	}
</style>

<!-- HTML -->
			<table cellpadding="0" cellspacing="0" border="0" class="display" id="channel">
				<thead>
					<tr>
						<th></th>
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
				Statement statement2 = dbconn.createStatement();
				String q = "SELECT distinct channel FROM switching_path";
				ResultSet rs = statement.executeQuery(q);
				ResultSet rs1 = null;
				String nome;
				String relays = "";
				int firstChannel = 0;
				if (rs.next())
				{
					out.println("<tr><script>$('#plugins').load('ChannelViewPlugins.jsp?chid="+rs.getInt("channel")+"&mode=view');</script>");
						out.println("<td OnMouseOver=this.style.cursor='pointer'>");
						out.println("Channel "+rs.getInt("channel"));
						firstChannel = rs.getInt("channel");
						out.println("</td>");
						out.println("<td>");
						out.println("<a href='#' OnClick=modificaCanale('"+rs.getInt("channel")+"');>Edit</a>");
						out.println("</td>");
						out.println("<td>");
						rs1 = statement2.executeQuery("Select relay from switching_path where channel = "+rs.getInt("channel"));
						while (rs1.next())
						{
							relays = relays + rs1.getInt("relay") + "|";
						}
						relays = relays.substring(0,relays.length()-1);
						out.println("<a href='#' OnClick=eliminaCanale('"+rs.getInt("channel")+"','"+ip_host+"');>Delete</a>");
						out.println("</td>");
					out.println("</tr>");
				}
				while (rs.next())
				{
					out.println("<tr>");
						out.println("<td OnMouseOver=this.style.cursor='pointer'>");
						out.println("Channel "+rs.getInt("channel"));
						out.println("</td>");
						out.println("<td>");
						out.println("<a href='#' OnClick=modificaCanale('"+rs.getInt("channel")+"');>Edit</a>");
						out.println("</td>");
						out.println("<td>");
						rs1 = statement2.executeQuery("Select relay from switching_path where channel = "+rs.getInt("channel"));
						while (rs1.next())
						{
							relays = relays + rs1.getInt("relay") + "|";
						}
						relays = relays.substring(0,relays.length()-1);
						out.println("<a href='#' OnClick=eliminaCanale('"+rs.getInt("channel")+"','"+ip_host+"');>Delete</a>");
						out.println("</td>");
					out.println("</tr>");
				}
				rs.close();
				rs1.close();
				statement.close();
				statement2.close();
				dbconn.close();
				%>
				</tbody>
			</table>

<!-- SCRIPT -->

<script type="text/javascript">
	function fnFeaturesInit ()
	{
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
		$('#channel').dataTable( {
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"bFilter": false,
			"bStateSave": true,
			"bInfo": false,
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
		var oTable;
		oTable = $('#channel').dataTable()
		var giRedraw = false;
		
		$(document).ready(function() {
			/* Add a click handler to the rows - this could be used as a callback */
			/*
			$("#channel tbody").click(function(event) {
				$(oTable.fnSettings().aoData).each(function (){
					$(this.nTr).removeClass('row_selected');
				});
				$(event.target.parentNode).addClass('row_selected');
			});
			*/
			
			/* Add a click handler for the delete row */
			/*
			$('#channel tr').click( function() {
				var anSelected = fnGetSelected(this);
				//oTable.fnDeleteRow( anSelected[0] );
				//alert(oTable.fnGetData(anSelected[0]));
			} );
			*/
			
			var keys = new KeyTable( {
				"table": document.getElementById('channel'),
				"datatable": oTable
			} );
			
			keys.event.focus( null, null, function( nNode, x, y ) {
				if (x == 0)
				{
					var aPos = oTable.fnGetPosition(nNode);
					var aData = oTable.fnGetData( aPos[0] );
					//alert(aData[0]);
					var channel = aData[0].substring(8, aData[0].length);
					LoadPlugins(channel);
				}
			} );

		} );
		
		/* Get the rows which are currently selected */
		function fnGetSelected( oTableLocal )
		{
			var aReturn = new Array();
			var aTrs = oTableLocal.fnGetNodes();
			
			for ( var i=0 ; i<aTrs.length ; i++ )
			{
				if ( $(aTrs[i]).hasClass('row_selected') )
				{
					aReturn.push( aTrs[i] );
				}
			}
			return aReturn;
		}
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
