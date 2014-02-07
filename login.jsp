<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page session="true"%>
<%@ page import="java.io.*"%>

<%
	session.setAttribute("sess_auth", null);
	session.setAttribute("sess_user", null);
%>

<!-- HTML -->
<html>
<head>
<!-- STYLE -->
<style>
	body {
	margin:0px 0px; 
	padding:60px;
	text-align:center;
	}
	#body_content {
		width:700px;
		height: 400px;
		margin:0px auto;
	}	
	#image_container { 
		width: 100%; 
		height: 100%; 
		position: relative;
		padding-top: 60px;
	}
	#sfondo{
		width: 300px; 
		height: 150px;
		position: relative;
	}
	#contents { 
		position: relative;
		z-index: 1; 
		border : 0px solid #0e5ba1;
		height: 31%;
	}
	#title_login { 
		position: absolute;
		z-index: 1; 
		left: 19%; 
		top: 11%; 
		font-family:verdana;
		font-size: 36;
	}
	#btn_submit{
		width: 80px; 
		height: 25px; 
	}
	td.button_padding{
		/*top right bottom left*/
		padding: 20px 0px 0px 0px;
	} 
	p.padding{
		/*top right bottom left*/
		padding: 0px 0px 0px 0px;
	} 
	#logos {
		position: relative;
	}
</style>
<title>INRIM Web DMS</title>
<link rel="shortcut icon" href="immagini/faviconINRIM.ico">
</head>

<body>
<%
	//String code = session.getAttribute("sess_login_res");
%>
	<div id="body_content"> 
		<!-- this creates the background image --> 
		<br><br><br><br>
		<div id="image_container"> 
			<img id="sfondo" src="immagini/INRIM_logo.jpg">
			<div id="title_login"> 
			</div>
			<br><br>
			<div id="contents">
				<form action="CheckCredentialsServlet" method="POST">
					<table align="center" style="width:300px;">
						<tr>
							<td valign="middle"> 
								<p class="padding" align="center">
									<font size="2" face="Verdana">
										Username
									</font>
								</p>
							</td>
						<tr>
						<tr>
							<td align="center">
								<input type="text" name="username" id="username" onClick="ResetRes();" autofocus/>
							</td>
						</tr>	
						<tr>
							<td>
								<p class="padding" align="center">
									<font size="2" face="Verdana">
										Password
									</font>
								</p> 
							</td>
						<tr>
							<td align="center">
								<input type="password" name="password" id="password"  onClick="ResetRes()"/>
							</td>
						</tr>
						<tr align="center">
						    <td class="button_padding" aolspan="2" align="center">
								<input type="submit" name="btn_submit" id="btn_submit" value="Login" style="font-size: 13px;"/>
							</td>
						</tr>
					</table>
				</form>
				<div id="Res">
				<%
					if (session.getAttribute("sess_login_res") != null)
					{
						if (session.getAttribute("sess_login_res").equals(-1))
						{
							out.println("<p class='padding' align='center'><font size='2' face='Verdana' color='red'>Bad password</font></p>"); 
							session.setAttribute("sess_login_res",null);
						}
						else if (session.getAttribute("sess_login_res").equals(-2))
						{
							out.println("<p class='padding' align='center'><font size='2' face='Verdana' color='red'>Bad username</font></p>");
							session.setAttribute("sess_login_res",null);
						}
					}
				%>
				</div>
			</div>
		</div> 
	 
	</div>
</body>


<!-- SCRIPT -->
<script>
function gotoIndex()
{
	document.location.href("index.jsp"); 
}
</script>
<script>
function ResetRes()
{
	document.getElementById("Res").innerHTML = "";
}
</script>

</html>