<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="dmsmanager.DmsMng"%> 

<!-- HTML -->

<link rel="stylesheet" href="datatables/css/picker/jquery-ui.css" type="text/css" media="all" />
<link rel="stylesheet" type="text/css" href="TableTools/media/css/TableTools.css" />
<link rel="stylesheet" type="text/css" href="datatables/css/tabs.css"/>

<style type="text/css" media="screen">
	#el01 {padding:0} /* Remove padding */
	#el02 { /* Text and background colour, blue on light gray */
		color:#00f;
		background-color:#ddd
	}
	#el03 {background:url(/i/icon-info.gif) no-repeat 100% 50%} /* Background image */
	#el04 {border-width:6px} /* Border width */
	#el05 {border:2px dotted #00f} /* Border width, style and colour */
	#el06 {border:none} /* No border */
	#el07 {font-family:"Courier New",Courier} /* Different font */
	#el08 {font-size:2em} /* Bigger text */
	#el09 {font-size:0.5em} /* Smaller text */
	#el10 {font-weight:bold} /* Bold text */
	#el11 {padding:2em} /* Increase padding */
	#el12 {text-align:right} /* Change text alignment */
	fieldset p {margin:0} /* Remove margins from p elements inside fieldsets */
</style>
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

<%
	Connection dbconn = null;
	String user_db = DmsMng.dbuser;
	String pwd_db = DmsMng.dbpwd;
	String ip_db = DmsMng.dbHostIp;
	String ip_host = DmsMng.webHostIp;
	String name_db = DmsMng.dbName;
		
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round", user_db, pwd_db);

	
	//Query estrazione dati
	Statement statement = dbconn.createStatement();
	String q = "SELECT * FROM vw_exposed_signal_info order by ID asc";
	ResultSet rs = statement.executeQuery(q);
%>
<table width="100%">
	<tr>
		<td valign="top"  width="50%">	
			<fieldset id="el04"><legend>General Information</legend>
			<table>
				<tr class="label">
					<td align="left">
						<b>Signal:</b>
					</td>
					<td align="left">
						<b>Measurement Type:</b>
					</td>
					<td align="left">
						<div id="signalLogicalChLbl" style="visibility:hidden"><b>Channel:</b></div>
					</td>
				</tr>
				<tr class="text">
					<td align="left" valign="top">
						<%
							out.println("<select class='custominput' style='width:200px' name='signalSelect' id='signalSelect' onchange='getChannelAndDelay();EnableMeasType();EnableTemplate();'>");
							out.println("<option value='' ></option>");
							while(rs.next())
							{
								out.println("<option value='"+rs.getInt("ID")+"'>"+rs.getString("Signal_Name")+"</option>");
							}
						%>
						</select>
					</td>
					<td align="left" valign="top">
						<div id="measurementType">
						<!--<input type="radio" id="timetype" name="typegroup" value="1" checked />time
						<input type="radio" id="freqtype" name="typegroup" value="2"/>freq
						<input type="checkbox" id="timetype" name="typegroup" onclick="SetType()" value="1" checked />time
						<input type="checkbox" id="freqtype" name="typegroup" onclick="SetType()" value="2"/>freq-->
						</div>
					</td>
					<td>
						<div id ="signalLogicCh">
						</div>
					</td>
				</tr>
				<tr class="label">	
					<td align="left">
						<b>Setup:</b>
					</td>
					<td>
					</td>
					<td align="left">
							<div id="signalDelayNsLbl" style="visibility:hidden"><b>Delay (ns):</b></div>
					</td>					
				</tr>
				<tr class="text">
					<td align="left" valign="top">
						<select class='custominput' style="width:200px" name='setupSelect' id='setupSelect' onChange="EnableParams();" disabled="disabled">
							<%
								out.println("<option value='' ></option>");
								q = "SELECT * FROM exp_vw_measurement_setups";
								rs = statement.executeQuery(q);
								while(rs.next())
								{
									out.println("<option value='"+rs.getInt("ID")+"' >"+rs.getString("Setup_Description")+"</option>");
								}
							%>
						</select>
					</td>
				    <td>
					</td>
					<td>
						<div id ="signalDelayNs">
						</div>
					</td>
					
				</tr>
			</table>
			</fieldset>
		</td>
		<td valign="top" width="50%">
			<div>
			<table>
				<tr>
					<td>
						<%
						//out.println("<input type='button' value='Start' onClick='AvviaMisuraManuale("+armingmode+","+source+","+samples+","+gatetime+","+clcksource+","+extclkfreq+","+inacoupling+","+inaterm+","+inatrigslope+","+inatriglevel+","+inatriglevellowlimit+","+inatrigleveluplimit+","+inbcoupling+","+inbterm+","+inbtrigslope+","+inbtriglevel+","+inbtriglevellowlimit+","+inbtrigleveluplimit+")'/></input>");
						%>
						<input type="button" value="Reset" onClick="ResetPage()" />
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" value="Vai" onClick="Vai()" />
						<input type="button" value="Ferma" onClick="Ferma()" />
					</td>
				</tr>
			</table>
			<br>
			<table width="100%">
				<tr>
					<td>
						<%
							out.println("<input type='button' value='Execute command' onClick=DMSSocketConnection('"+ip_host+"')></input>");
						%>
						SCHDL;EXEC; <input type='text' id='cmdnum' size='2'>
					</td>
				</tr>
			</table>
		</div>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<div id="setupParams" style="visibility:hidden">
			</div>
		</td>
		<td valign="top">
			<div id="resultsDiv" style="visibility:hidden">
			<fieldset id="el04"><legend>Execution results</legend>
			<table cellpadding="0" cellspacing="0" border="0" class="display" id="exectable">
				<%
				out.println("<thead><tr>");
				out.println("<th>Description</th>");
				out.println("<th>Schedule</th>");
				out.println("<th>Status</th>");
				out.println("</tr><thead>");
				out.println("<tbody>");
				%>
				</tbody>
			</table>
			</fieldset>
			</div>
		</td>
	</tr>
</table>

<script>
var num = 0;
$('#measurementType').load('MeasurementTypeView.jsp');
</script>
<script>
function Vai()
{
	num = setInterval(function(){alert("Ciao")}, 3000);
}
</script>
<script>
function Ferma()
{
	clearInterval(num);
}
</script>
<script>
function EnableMeasType()
{
	document.getElementById("timetype").disabled = false;
	document.getElementById("freqtype").disabled = false;
	document.getElementById("timetype").checked = true;
}
</script>

<script>
function EnableTemplate()
{
	document.getElementById("setupSelect").disabled = false;
	/*
	if (document.getElementById("timetype").checked)
	{
		document.getElementById("gateTimeParam").style.visibility = 'hidden';
		document.getElementById("gateTimeLbl").style.visibility = 'hidden';
		document.getElementById("armgroup").selectedIndex = 0;		
	}
	else
	{
		document.getElementById("gateTimeParam").style.visibility = 'visible';
		document.getElementById("gateTimeLbl").style.visibility = 'visible';
		document.getElementById("armgroup").selectedIndex = 1;	
	}
	*/
	document.getElementById("setupSelect").selectedIndex = 1;	
	EnableParams();
}
</script>
<script>
function EnableResults()
{
	document.getElementById("resultsDiv").style.visibility = 'visible';
}
</script>
<script>
function EnableParams()
{
	var setupid = document.getElementById("setupSelect").value;
	$('#setupParams').load('SetupParamsView.jsp?setupid='+setupid);
	document.getElementById("setupParams").style.visibility = 'visible';
	// if (document.getElementById("timetype").checked)
	// {
		// document.getElementById("gateTimeParam").style.visibility = 'hidden';
		// document.getElementById("gateTimeLbl").style.visibility = 'hidden';
	// }
	EnableResults();
}
</script>

<script>
function getChannelAndDelay(signalid)
{
	var signalid = document.getElementById("signalSelect").value;
	document.getElementById("signalLogicalChLbl").style.visibility = 'visible';
	document.getElementById("signalDelayNsLbl").style.visibility = 'visible';
	$('#signalLogicCh').load('SignalLogicChannel.jsp?signalid='+signalid);
	$('#signalDelayNs').load('SignalDelayNs.jsp?signalid='+signalid);
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
		$('#exectable').dataTable( {
			"bJQueryUI": true,
			"bFilter": false,
			"bStateSave": true,
			"bRetrieve": true,
			"sPaginationType": "full_numbers",
			"bProcessing": true,
			"bPaginate": false,
			"bAutoWidth": false,
			"bSort": false
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

