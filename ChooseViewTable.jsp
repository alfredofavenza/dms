<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="dmsmanager.DmsMng"%>  

<!-- STYLE -->
<style type="text/css" >
	@import "datatables/css/inrim.css";
</style>

<!-- HTML -->
<div align="center">
	<label for="selectTableLbl">Data Source: </label>
	<select name="tableviewlist" id="tableviewlist" class='custominput' onChange="selectTableOk(document.getElementById('tableviewlist').value);">
		<%
			String view_id = "";
			view_id = request.getParameter("view_id");
			String user_db = DmsMng.dbuser;
			String pwd_db = DmsMng.dbpwd;
			String ip_db = DmsMng.dbHostIp;
			String name_db = DmsMng.dbName;
			
			//if (session.getAttribute("db_name").toString().substring(0,0) != "#") name_db = session.getAttribute("db_name").toString();
		    //if (session.getAttribute("db_ip").toString().substring(0,0) != "#") ip_db = session.getAttribute("db_ip").toString();
		
			Connection dbconn = null;
			Class.forName("com.mysql.jdbc.Driver");
			dbconn = DriverManager.getConnection("jdbc:mysql://"+ip_db+":3306/"+name_db+"?zeroDateTimeBehavior=round",user_db,pwd_db);
			Statement statement = dbconn.createStatement();
			String q = "SELECT id,caption,summary,table_name FROM exposed_data where visible='1'";
			ResultSet rs = statement.executeQuery(q);
			out.println("<option value=''></option>");
			String table_name;
			String id;
			String caption;
			while (rs.next())
			{
				table_name = rs.getString("table_name");
				id = rs.getString("id");
				caption = rs.getString("caption");
				if (id.equals(view_id))
				{
					out.println("<option value='"+id+"' selected>"+caption+"</option>");
				}
				else
				{
					out.println("<option value='"+id+"' >"+caption+"</option>");
				}
				//out.println("<option value='"+rs.getString("table_name")+"'>"+rs.getString("caption")+"</option>");
			}
			rs.close();
			statement.close();
			dbconn.close();
		%>
	</select>
	<!--<input type="button" id ="selectBtn" value="Select" onclick="selectTableOk();"/>-->
	<!--<input type="button" onClick="readFileHttp();"/>-->
</div>
<div id="filter" style="padding: 0px 0px 10px 45px">
</div>
<br>
<!-- Filtro per valore
<a href="#" onClick="openColumnsFilter()" id="colsFilter">[+]Filtra Valori</a>
<div id="valuesFilterTbl" style="padding: 0px 0px 10px 45px">
	<table>
		<%

		%>
	</table>
</div>
-->

<div id="filtro">
</div>

<div id="container3">
</div>


<!-- SCRIPT -->
<script type="text/javascript" charset="utf-8">
if ( document.getElementById("tableviewlist").value != "" )
{
	document.getElementById("filter").innerHTML = "<p align=center><b>Loading filter, please wait...</b></p><p align=center><img src='immagini/loading.gif' height='30' width='30'></img></p>";
	$('#filter').load('Filtro.jsp?id='+document.getElementById("tableviewlist").value);
}
</script>

<script type="text/javascript" charset="utf-8">
	function selectTableOk(id){
		document.getElementById("filter").innerHTML = "<p align=center><b>Loading filter, please wait...</b></p><p align=center><img src='immagini/loading.gif' height='30' width='30'></img></p>";
		$('#filter').load('Filtro.jsp?id='+id);
	}
</script>