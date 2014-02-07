<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- STYLE -->
<link rel="stylesheet" type="text/css" href="TableTools/media/css/TableTools.css" />
<STYLE>
#layer1 {
	visibility: hidden;
	width: 200px;
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


<!-- HTML -->
<%
	String q = request.getParameter("param");
	String view_id = request.getParameter("view_id");
	String query = q.replace("|"," ");
	String query2 = q.replace("'","apice");
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
	ResultSet rs = statement.executeQuery("Select caption from exposed_data where id = "+view_id);
	rs.next();
	String caption = rs.getString("caption");
	statement = dbconn.createStatement();
	rs = statement.executeQuery(query);
	ResultSetMetaData rsmd = rs.getMetaData();
	int noOfColumns = rsmd.getColumnCount();
%>

<div id="layer1">
	<table>
		<!--
		<tr>
			<td>Select export format:</td>
		</tr>
		<tr>
			<td>
				<input type="radio" name="exportRadioGroup" id="exportRadioGroup" value="xls" checked>XLS</input>
				<br>
				<input type="radio" name="exportRadioGroup" id="exportRadioGroup" value="csv" disabled>CSV</input>
			</td>
		</tr>
		-->
		<tr>
			<td>Choose file name:</td>
		</tr>
		<tr>
			<td><input type="text" name="exportFileName" id="exportFileName"></input></td>
		</tr>
		<tr>
			<td>
				<%
					out.println("<input type='button' value='Ok' onClick=DownloadFile("+noOfColumns+",'"+ip_host+"');></input>");
				%>
				<input type="button" value="Cancel" onClick="javascript:setVisible('layer1')"></input>
			</td>
		</tr>
	</table>
</div>
<table style="width:100%">
<tr>
	<td width="33%">
		<a href="#" onClick="openColumnsFilter()" id="colsFilter">[+]Columns filter</a>
	</td>
	<td width="33%" align="center">
		<%
		out.println("<font size='4'>"+caption+"</font>");
		%>
	</td>
	<td width="33%" align="right">
		<%
		//out.println("<input type='button' value='Export Data' onclick=setVisible('layer1');return false; target='_self';></input>");
		%>
		<a href="#" onclick="setVisible('layer1');document.getElementById('exportFileName').focus();return false;">Export </a>|
	</td>
	<td width="33%" align="right">
		<%
		boolean isID = false;
		int col = 0;
		int numc = noOfColumns;
		for (col = 1; col <= noOfColumns; col++)
		{
			if (!(rsmd.getColumnName(col)).equals("ID"))
			{
				isID = true;
			}
		}
		if (isID)
		{
			numc--;
		}
		out.println("<a href='#' onClick=backToMainFilter('"+view_id+"','"+numc+"'); id='colsFilter'>Back</a>");
		%>
	</td>
</tr>
</table>
<div id="colsFilterTbl" style="padding: 0px 0px 10px 45px" align="left">
	<table>
		<%
			int i = 1;
			int j = 0;
			String colname = "";
			while (i <= noOfColumns)
			{
				if (i%6 == 1)
				{
					out.println("<tr>");
				}
				if (!rsmd.getColumnName(i).equals("ID"))
				{
					out.println("<td style='padding: 2px 20px 0px 0px;'>");
					colname = "filtercol"+i;
					//out.println("<input type='checkbox' id='"+colname+"' name='"+rsmd.getColumnName(i)+"' checked='yes' onclick='fnShowHide("+(i-2)+");'>");
					out.println("<input type='checkbox' id='"+colname+"' name='"+rsmd.getColumnName(i)+"' checked='yes' onclick='fnShowHide("+(j)+");'>");
					out.println(rsmd.getColumnName(i)+"");
					out.println("</td>");
					j++;
				}
				else
				{
					//out.println("<input type='checkbox' id='"+colname+"' name='"+rsmd.getColumnName(i)+"' checked='yes' onclick='fnShowHide("+(i-2)+");' style='visibility:hidden'>");
					//out.println(rsmd.getColumnName(i)+"");
				}
				
				if (i%6 == 0)
				{
					out.println("</tr>");
				}
				i++;
			}
			if (noOfColumns%6 != 0)
			{
				out.println("</tr>");
			}
		%>
	</table>
</div>
<!-- Filtro per valore
<a href="#" onClick="openColumnsFilter()" id="colsFilter">[+]Filtra Valori</a>
<div id="valuesFilterTbl" style="padding: 0px 0px 10px 45px">
	<table>
		<%

		%>
	</table>
</div>
-->
<div>
<table cellpadding="0" cellspacing="0" border="0" class="display" id="view">
	<thead>
		<tr>
		   <%
			for (i = 1; i <= noOfColumns; i++)
			{
				if (!(rsmd.getColumnName(i)).equals("ID"))
				{
					out.println("<th>"+rsmd.getColumnName(i)+"</th>");
				}
			}
		   %>
		</tr>
	</thead>
	<tbody>
	<%
		String nome;
		while (rs.next())
		{
			out.println("<tr onDblClick='modificaSegnale();'>");
			for (i = 1; i <= noOfColumns; i++)
			{
				if (!(rsmd.getColumnName(i)).equals("ID"))
				{
					out.println("<td>");
					//out.println(rsmd.getColumnType(i));
					if (rsmd.getColumnType(i) == -7)
					{
						if (rs.getInt(i) == 1)
							out.println("<img src='immagini/check.png' style='border-style:none;width:15px;height:15px;'/>");
					}
					else if (rsmd.getColumnType(i) == 93)
					{
						String timetag = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(rs.getTimestamp(rsmd.getColumnName(i)));
						//out.println(rs.getTimestamp(rsmd.getColumnName(i)));
						out.println(timetag);
					}
					else
					{
						out.println(rs.getObject(rsmd.getColumnName(i)));
					}
					out.println("</td>");
				}
			}
			out.println("</tr>");
		}
	%>
	</tbody>
	<tfoot>
	<tr>
	<%
		for (i = 1; i <= noOfColumns; i++)
		{
			if (!rsmd.getColumnName(i).equals("ID"))
			{
				out.println("<th>");
				out.println("</th>");
			}
		}
		rs.close();
		statement.close();
		dbconn.close();
	%>
	</tr>
	</tfoot>
</table>
</div>
<div style="visibility:hidden;">
<%
	out.println("<input id='querytext' type='text' value='"+query2+"'></input>");
%>
</div>
<!-- SCRIPT -->
<script type="text/javascript" src="popup/popupDiv.js"></script>
<script>
	function sleep(milliseconds) {
	  var start = new Date().getTime();
	  for (var i = 0; i < 1e7; i++) {
		if ((new Date().getTime() - start) > milliseconds){
		  break;
		}
	  }
	}
</script>
<script>
	function DownloadFile(numCols, ip_host)
	{
		var filename = document.getElementById("exportFileName").value;
		if (filename == "") 
		{
			alert("File name not valid");
			return;
		}
		var exportType = "xls";
		var q = document.getElementById("querytext").value;
		var query = q.replace(/apice/g, "'");
		var i = 1;
		var cols = "";
		var colname = "";
		for (i = 1; i <= numCols; i++)
		{
			colname = "filtercol"+i;
			if (document.getElementById(colname))
			{
				if (document.getElementById(colname).checked)
				{
					cols = cols + document.getElementById("filtercol"+i).name;
					cols = cols + ",";
				}
			}
		}
		cols = cols.substr(0, cols.length-1);
		query = query.replace("*",cols);
		if (exportType == "xls")
		{
			$.get("http://"+ip_host+":8080/dms/CreateExcelFile?param="+query+"&filename="+filename, function(){
				var url='http://'+ip_host+':8080/dms/exported/'+filename+'.xls';  
				window.open(url,'Download');
			});
		}
		else
		{
			$.get("http://"+ip_host+":8080/dms/CreateCsvFile?param="+query+"&filename="+filename, function(){
				var url='http://'+ip_host+':8080/dms/exported/'+filename+'.csv';  
				window.open(url,'Download');
			});
		}
		setVisible('layer1');
	}
</script>
<script>
	function ArraySortAscending(a, b)  //Sort array in ascending order
	{	
		return (a-b); 
	}
</script>
<script>
	(function($) {
		$.fn.dataTableExt.oApi.fnGetColumnData = function ( oSettings, iColumn, bUnique, bFiltered, bIgnoreEmpty ) {
		// check that we have a column id
		if ( typeof iColumn == "undefined" ) return new Array();		
		// by default we only wany unique data
		if ( typeof bUnique == "undefined" ) bUnique = true;		
		// by default we do want to only look at filtered data
		if ( typeof bFiltered == "undefined" ) bFiltered = true;		
		// by default we do not wany to include empty values
		if ( typeof bIgnoreEmpty == "undefined" ) bIgnoreEmpty = true;	
		// list of rows which we're going to loop through
		var aiRows;
		// use only filtered rows
		if (bFiltered == true) aiRows = oSettings.aiDisplay; 
		// use all rows
		else aiRows = oSettings.aiDisplayMaster; // all row numbers
		// set up data array	
		var asResultData = new Array();
		for (var i=0,c=aiRows.length; i<c; i++) {
			iRow = aiRows[i];
			var aData = this.fnGetData(iRow);
			var sValue = aData[iColumn];
			// ignore empty values?
			if (bIgnoreEmpty == true && sValue.length == 0) continue;
			// ignore unique values?
			else if (bUnique == true && jQuery.inArray(sValue, asResultData) > -1) continue;
			// else push the value onto the result data array
			else asResultData.push(sValue);
		}
		return asResultData;
	};}(jQuery));
			
	function fnCreateSelect(aData, aName)
	{
		var r='<select name="'+aName+'"><option value=""></option>', i, iLen=aData.length;
		for ( i=0 ; i<iLen ; i++ )
		{
			r += '<option value="'+aData[i]+'">'+aData[i]+'</option>';
		}
		return r+'</select>';
	}
</script>
<script>
	function fnShowHide( iCol )
	{
		/* Get the DataTables object again - this is not a recreation, just a get of the object */
		var oTable = $('#view').dataTable();
		var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
		oTable.fnSetColumnVis( iCol, bVis ? false : true );
	}
</script>
<script>
	document.getElementById("colsFilterTbl").style.visibility = 'hidden';
	document.getElementById("colsFilterTbl").style.display = 'none'; 
	function openColumnsFilter()
	{
		if (document.getElementById("colsFilter").innerHTML == '[+]Columns filter')
		{	
			document.getElementById("colsFilter").innerHTML = '[-]Columns filter';
			document.getElementById("colsFilterTbl").style.visibility = 'visible';
			document.getElementById("colsFilterTbl").style.display = "block"; 
		}
		else
		{
			document.getElementById("colsFilter").innerHTML = '[+]Columns filter';
			document.getElementById("colsFilterTbl").style.visibility = 'hidden';
			document.getElementById("colsFilterTbl").style.display = 'none'; 
		}
	}
</script>
<script>
	function backToMainFilter(view_id, numcols)
	{
		var i = 0;
		var oTable = $('#view').dataTable();
		$('#container1').load('ChooseViewTable.jsp?view_id='+view_id);
		for (i = 0; i <= numcols; i++)
		{
			oTable.fnSetColumnVis(i, true);
		}
	}
</script>
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
		var oTable = $('#view').dataTable( {
			"bJQueryUI": true,
			"sPaginationType": "full_numbers",
			"bProcessing": true,
			"bPaginate": true,
			"bStateSave": true,
			"bAutoWidth": false,
			"bFilter": false,
			"bSort" : true,
			"bFilter": true,
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
			//"sScrollX": "50%"
		} );
	} );
</script>


