<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>.::Welcome to NIBSS ASV Portal.::</title>
<link rel="stylesheet" href="css/login.css">
</head>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/formValidation.js"></script>
<script type="text/javascript" src="js/disableClick.js"></script>
<%
java.text.SimpleDateFormat tformat = new java.text.SimpleDateFormat("yyyy");
java.util.Date tdate = new java.util.Date();
session.invalidate();
%>

<body>
<table width="900px" align="center">
	<tr>
		<td class="title_header" align="center"><img src="images/logo.png"  /></td>
	</tr>
</table>

<section class="container">
	<div class="login">
		<h1>Login in to the Signature Portal </h1>
		<form id="loginForm" method="post">
			<p><input type="text" name="EMAIL" id="EMAIL" value="" placeholder="Email" required/></p>
			<p><input type="password" name="PASSWORD" id="PASSWORD" value="" placeholder="Password" required/></p>
			<div id='login_response'></div>
			
			
			<p class="submit"><input type="submit" name="login" id="login" value="Login"></p>
		</form>
	</div>
</section>
<div class="footer_user" align="center">
<span class="norm_text">&copy; <%out.println(tformat.format(tdate)+" ");%>&nbsp; Nigeria Inter-Bank Settlement System Plc, All Rights Reserved &nbsp;|&nbsp; Terms &amp; Conditions</span>
</div>

</body>
</html>
