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
<div id="layer2" align="center">
	<table>
		<tr>
			<td align="center"><label id="popupMsg"></label></td>
		</tr>
		<tr>
			<td align="center">
				<br>
				<input type="button" value="Close" onClick="javascript:setVisible('layer2');reload();"></input>
			</td>
		</tr>
	</table>
</div>
<div id ="elemento3">
	<table style="width:95%">
		<tr>
			<td>
				<table style="width:80%">
					<tr>
						<td>
							<div id="divNew" align="right">
								<a href="#" onclick='nuovoCanale();' >New</a>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div id ="channelTable">
							</div>
						</td>
					</tr>
				</table>
			</td>
			<td valign="top">
				<div id="plugins"></div>
			</td>
		</tr>
	</table>
</div>

<!-- SCRIPT -->
<script type="text/javascript" src="/dms/datatables/js/KeyTable.js"></script>
<script type="text/javascript" src="popup/popupDiv.js"></script>
<script>
	$('#channelTable').load('ChannelTableView.jsp', "randvar="+random);
</script>
<script>
	function reload()
	{
		$('#channelTable').load('ChannelTableView.jsp', "randvar="+random);
	}
</script>
<script type="text/javascript" charset="utf-8">
	var check;
	$('input[type="radio"]').hover(function() {
		check = $(this).is(':checked');
	});

	$('input[type="radio"]').click(function() {
		check = !check;
		$(this).attr("checked", check);
	});
</script>
<script type="text/javascript" charset="utf-8">
	function LoadPlugins(ch)
	{
		var random = new Date().getTime();
		$('#plugins').load('ChannelViewPlugins.jsp?chid='+ch+'&mode=view', "randvar="+random);
	}
</script>
<script type="text/javascript" charset="utf-8">
	function nuovoCanale(){
		var random = new Date().getTime();ss
		document.getElementById("divNew").innerHTML = "<font color='grey'>New</font>";
		$('#plugins').load('CreateChannel.jsp', "randvar="+random);
	}
</script>

<script type="text/javascript" charset="utf-8">
	function modificaCanale(id){
		var random = new Date().getTime();
		document.getElementById("divNew").innerHTML = "<font color='grey'>New</font>";
		$('#plugins').load('ChannelViewPlugins.jsp?chid='+id+'&mode=edit&rand='+random, 
			function()
			{
				document.getElementById("path1").style.visibility = 'hidden';
				document.getElementById("path2").style.visibility = 'hidden';
			}
		);		
	}
</script>

<script type="text/javascript" charset="utf-8">
	function eliminaCanale(channel, ip_host)
	{
		var random = new Date().getTime();
		var i;
		if (confirm("Delete this channel?") == true)
		{
			//richiamare la servlet che chiama la delete_switching_path 
			$.get("http://"+ip_host+":8080/dms/DeleteChannelServlet?channel="+channel+"&safemode=true&rand="+random, 
				function(data) {
					var arr1 = data.split("|");
					if (arr1[1] != "") {
						document.getElementById("popupMsg").innerHTML = "<font size='2'>"+arr1[1]+"</font>";
						setVisible('layer2');
						LoadPlugins(ch);
					}
					if (arr1[0] != 1) 
					{

						document.getElementById("popupMsg").innerHTML = "<font size='2'>Channel deleted.</font>";
						setVisible('layer2');
					}
				}
			);
		}
		else
		{
			return;
		}
	}
</script>
