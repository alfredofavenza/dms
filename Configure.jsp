<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.TimeZone"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.io.*"%>

<!-- HTML -->		
<html>
<head>
</head>
<body onload="loadTables();">
<!-- the tabs --> 
<div id="demo">
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">Signal</a></li>
			<li><a href="#tabs-2">Clock</a></li>
			<li><a href="#tabs-3">Channel</a></li>
			<li><a href="#tabs-4">Clock Status Parameters</a></li>
			<li><a href="#tabs-5">Environmental Monitoring Parameters</a></li>
		</ul>
		<div id="tabs-1">
		</div>
		<div id="tabs-2">
		</div>
		<div id="tabs-3">
		</div>
		<div id="tabs-4">
		</div>
		<div id="tabs-5">
		</div>
	</div>
</div>
</body>


<!-- SCRIPT -->
<script type="text/javascript" language="javascript" src="datatables/js/jquery-ui-tabs.js"></script>
<script type="text/javascript" charset="utf-8" src="TableTools/media/js/ZeroClipboard.js"></script>
<script type="text/javascript" charset="utf-8" src="TableTools/media/js/TableTools.js"></script>
<script>
function nuovoSegnale(){
	var random = new Date().getTime();
	$('#tabs-1').load('CreateSignal.jsp', "rand ="+random);
}
</script>
<script type="text/javascript" charset="utf-8">
function nuovoClock(){
	var random = new Date().getTime();
	$('#tabs-2').load('CreateClock.jsp', "rand ="+random);
}
</script>
<script type="text/javascript" charset="utf-8">
function nuovoChannel(){
	var random = new Date().getTime();
	$('#tabs-3').load('CreateChannel.jsp', "rand ="+random);
}
</script>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$("#tabs").tabs( {
			"show": function(event, ui) {
				var oTable = $('div.dataTables_scrollBody>table.display', ui.panel).dataTable();
				if ( oTable.length > 0 ) {
					oTable.fnAdjustColumnSizing();
				}
			}
		} );
	} );
</script>
<script type="text/javascript" charset="utf-8">
	var random = new Date().getTime();
	$('#tabs-1').load('SignalView.jsp', "randvar="+random);
	$('#tabs-2').load('ClockView.jsp', "randvar="+random);
	$('#tabs-3').load('ChannelView.jsp', "randvar="+random);
	$('#tabs-4').load('ParamsAcqView.jsp', "randvar="+random);
	$('#tabs-5').load('EnvParamsView.jsp', "randvar="+random);
</script>

</html>