<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<%@ page import="java.net.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head></head><!-- InstanceBegin template="/Templates/user_home_template.dwt.jsp" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/disableClick.js"></script>

<!-- InstanceBeginEditable name="doctitle" -->
<title>.::Welcome to NIBSS ASV Portal::.</title>
<!-- InstanceEndEditable -->

</head>
<%
com.nibss.asvportal.UtilityClass util = new com.nibss.asvportal.UtilityClass();
com.nibss.asvportal.SecuredData sc =  new com.nibss.asvportal.SecuredData();
java.text.SimpleDateFormat tformat = new java.text.SimpleDateFormat("yyyy");
java.util.Date tdate = new java.util.Date();


String EMAIL = (String) session.getAttribute("EMAIL");
String USER_ID = (String) session.getAttribute("USER_ID");
if(USER_ID==null)USER_ID="";
if(USER_ID.equals(""))response.sendRedirect("session_expired.jsp");

ArrayList resultConStmtMainMenu = new ArrayList();
Connection conMainMenu=null;
PreparedStatement pstmtMainMenu=null;
ResultSet rsMainMenu = null;

ArrayList resultConStmtSubMenu = new ArrayList();
Connection conSubMenu=null;
PreparedStatement pstmtSubMenu=null;
ResultSet rsSubMenu = null;
%>
<!-- InstanceBeginEditable name="SNIPPET" -->
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/jquery.livepreview.js"></script>

<script type="text/javascript">
function previewSalutation(form){
	document.getElementById('greeting').innerHTML = form.SALUTATION.value+',';
}

function previewComplimentaryClose(form){
	document.getElementById('complimentary_close').innerHTML = form.COMPLIMENTARY_CLOSE.value+',';
}
function previewAuthorizedSignatory1(form){
	document.getElementById('authorized_signatory_1').innerHTML = form.AUTHORIZED_SIGNATORY_1.value;
}

function previewAuthorizedSignatory2(form){
	document.getElementById('authorized_signatory_2').innerHTML = form.AUTHORIZED_SIGNATORY_2.value;
}

$(function() {
	$('#MESSAGE').livePreview({
		previewElement: $('div.message_body'),
		allowedTags: ['p', 'strong', 'br', 'em', 'strike'],
		interval: 20
	});
});
</script>
<%
ArrayList resultConStmt = new ArrayList();
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs = null;

boolean editable = false;

String html_salutation="",html_comp_close="",auth_signatory="";  
String allowed_signatory ="", message_body="", MANDATE_ID="";

String SALUTATION = request.getParameter("SALUTATION");
if (SALUTATION==null) SALUTATION="";

String COMPLIMENTARY_CLOSE = request.getParameter("COMPLIMENTARY_CLOSE");
if (COMPLIMENTARY_CLOSE==null) COMPLIMENTARY_CLOSE="";

String AUTHORIZED_SIGNATORY = request.getParameter("AUTHORIZED_SIGNATORY");
if (AUTHORIZED_SIGNATORY==null) AUTHORIZED_SIGNATORY="";


try{
	editable = util.isSignatureMandateEditable(USER_ID);
	if (editable){
		resultConStmt = util.listSignatureMandateEditableUSER_ID(USER_ID);
		rs= (ResultSet)resultConStmt.get(0);
		pstmt= (PreparedStatement)resultConStmt.get(1);
		con= (Connection)resultConStmt.get(2);
		URLDecoder dec = new URLDecoder();
		if(rs.next())
		{	
			SALUTATION = rs.getString("SALUTATION");
			COMPLIMENTARY_CLOSE = rs.getString("COMPLIMENTARY_CLOSE");
			message_body = dec.decode(rs.getString("MANDATE_BODY"), "UTF-8");
			MANDATE_ID = rs.getString("MANDATE_ID");
		}
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
	try{
		if(rs != null){
			rs.close();
		}
		if(pstmt !=null){
			pstmt.close();
		}
		if(con !=null){
			con.close();
		}
	}catch(Exception e){
		e.printStackTrace();
	}
}

html_salutation = "<option value=''>«»«»Select Salutation«»«»</option>";
html_salutation += util.getHtmlOptionSalutation(SALUTATION);

html_comp_close = "<option value=''>«»«»Select Complimentary«»«»</option>";
html_comp_close += util.getHtmlOptionComplimentary(COMPLIMENTARY_CLOSE);

auth_signatory = "<option value=''>«»«»Select A Signatory«»«»</option>";
auth_signatory += util.getHtmlOptionAuthorizedSignatory(USER_ID, AUTHORIZED_SIGNATORY);




%>

<!-- InstanceEndEditable -->
<body oncopy="return false" oncut="return false" onpaste="return false">
<table align="center" width="90%">
	<tr>
	  <td class="title_header"><img src="images/logo2.png" height="50" width="100"/>&nbsp;&nbsp;BANKING INDUSTRY AUTHORIZED SIGNATURE PORTAL</td>
	  <td  align="right" class="norm_text_white" valign="bottom"><b>Welcome: </b><%=EMAIL%> !!!&nbsp;&nbsp;&nbsp;&nbsp;| <a href="modifyAccount.jsp" class="norm_text_white"><b>Change Password</b></a> | <a href="index.jsp" class="norm_text_white"><b>Logout</b></a> </td>
	</tr>
</table>
<table align="center">
	<tr>
		<td colspan="2">
			<div id="placemainmenu">
				<ul id="mainmenu">
					<li><a href="welcome.jsp">Home</a></li> 
<%
					try{
						resultConStmtMainMenu = util.listTemplateMainMenu(USER_ID);
						rsMainMenu = (ResultSet)resultConStmtMainMenu.get(0);
						pstmtMainMenu= (PreparedStatement)resultConStmtMainMenu.get(1);
						conMainMenu= (Connection)resultConStmtMainMenu.get(2);
						while(rsMainMenu.next()){
							resultConStmtSubMenu = util.listTemplateSubMenu(rsMainMenu.getString("MAIN_MENU_ID"), USER_ID);
							rsSubMenu = (ResultSet)resultConStmtSubMenu.get(0);
							pstmtSubMenu= (PreparedStatement)resultConStmtSubMenu.get(1);
							conSubMenu= (Connection)resultConStmtSubMenu.get(2);
							
%>
					<li><a href="<%=rsMainMenu.getString("MAIN_MENU_URL")%>"><%=rsMainMenu.getString("MAIN_MENU_NAME")%></a>
						<div class="dropdown1">
							<div class="dropdowntop"></div>
							<div class="dropdownbottom">
								<ul class="menudrop1">
<%
							try{
								while(rsSubMenu.next()){
%>
										<li><a href="<%=rsSubMenu.getString("SUB_MENU_URL")%>"><%=rsSubMenu.getString("SUB_MENU_NAME")%></a></li>
<%
								}
							}catch(Exception ex){
								ex.printStackTrace();
							}finally{
								try{
									if(rsSubMenu != null)rsSubMenu.close();
									if(pstmtSubMenu !=null)pstmtSubMenu.close();
									if(conSubMenu !=null)conSubMenu.close();
								}catch(Exception e){
									System.out.println("Error in closing connections in Menu in Template::"+e.toString());
								}
							}
%>	
									
								</ul>
								<div class="clear"></div>
							</div>
						</div>
					</li>
					
<%
				}
%>
				<li><a href="contactNIBSSAdmin.jsp">Contact Us</a></li>
<%
			}catch(Exception e){
				System.out.println("Error occured while listing in Menu in Template:::"+e.toString());
				e.printStackTrace();
			}finally{
				try{
					if(rsMainMenu != null)rsMainMenu.close();
					if(pstmtMainMenu !=null)pstmtMainMenu.close();
					if(conMainMenu !=null)conMainMenu.close();
				}catch(Exception e){
					System.out.println("Error in closing connections in Menu in Template::"+e.toString());
				}
			}
%>

				</ul>
			</div>
		</td>
	</tr>
</table>
<br /><br />
<table align="center">
	<tr>
		<td>
			<div id="maincontent">
				<div id="ruler">
					<!--h1>E-Lusion Menu Design No2</h1-->
                  <!-- InstanceBeginEditable name="BODY CONTENT" -->
<p class="subInfo underlay">Edit Bank Signature Mandate &raquo;&raquo; &nbsp;</p>
<% if(editable){%>	
<form method="post" action="processEditSignatureMandate.jsp" >
<input name="MANDATE_ID" type="hidden" value="<%=MANDATE_ID%>" />
<table align="center">
	<tr>
		<td>
			<table class="bordered_table" cellpadding="0" cellspacing="1">
				<tr>
					<td class="title-bkg" colspan="2"> Signatory Mandate Information</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Salutation:</td>
					<td class="norm_login_text_cell">
						<select name="SALUTATION" id="SALUTATION" size="1" class="norm_text" onchange="previewSalutation(this.form)" required>
							  <%=html_salutation%>
						</select>	
					</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Message Body:</td>
					<td class="norm_login_text_cell"><textarea type="text" name="MESSAGE" id="MESSAGE" class="norm_login_text" required cols="60" rows="10"><%=message_body%></textarea></td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Complimentary close:</td>
					<td class="norm_login_text_cell">
					<select name="COMPLIMENTARY_CLOSE" id="COMPLIMENTARY_CLOSE" size="1" class="norm_text" onchange="previewComplimentaryClose(this.form)" required>
						  <%=html_comp_close%>
					</select>
					</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Number of Signatories:</td>
					<td class="norm_login_text_cell">
					<select name="NO_SIGNATORY" class="norm_text" onChange="
						var a = this.form.getElementsByTagName('option');
						var tarElement = document.getElementById('NO_SIGNATORYTbl');
						for (var i=0; i<a.length; ++i) {
							if (a[i].selected == true && a[i].value == '2') {			
								// show them
								tarElement.style.display = 'block';
								break;
							} else {				
								// hide them again
								tarElement.style.display = 'none';
							}
						}"
					>
				<option value="1">Single</option>
				<option value="2">Double</option>
			</select>
					</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Authorised Signatory:</td>
					<td class="norm_login_text_cell">
					<select name="AUTHORIZED_SIGNATORY_1" id="AUTHORIZED_SIGNATORY_1" size="1" class="norm_text" onchange="previewAuthorizedSignatory1(this.form)" required>
						  <%=auth_signatory%>
					</select>
					</td>
				</tr>
				<tr class="white_bg">
					<td colspan="2" >
						<table cellpadding="0" cellspacing="1" class="bordered_table" id="NO_SIGNATORYTbl" style="display:none" width="100%">
							<tr class="white_bg">
								<td width="29%" height="40" class="norm_login_text_cell_bold">Authorised Signatory:</td>
								<td width="71%" class="norm_login_text_cell">
									<select name="AUTHORIZED_SIGNATORY_2" id="AUTHORIZED_SIGNATORY_2" size="1" class="norm_text" onchange="previewAuthorizedSignatory2(this.form)">
										  <%=auth_signatory%>
									</select>			  
							  </td>
							</tr>
						</table>		
					</td>
				</tr>
				<tr class="white_bg">
					<td colspan="2" height="40" align="center"><input type="submit" id="submit" value="Submit" /></td>
				</tr>
			</table>
		</td>
		<td valign="top">
			<table>
				<tr class="white_bg">
					<td colspan="2" height="40" class="norm_text">
						<div class="preview"> 
							<label  id="greeting"></label><br/>
							<div class="message_body"></div>
							<br/>
							<br/>
							<label  id="complimentary_close"></label><br/>
							<label  id="authorized_signatory_1"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<label  id="authorized_signatory_2"></label><br/>
						</div>
					</td>
				</tr>
			</table>
		</td>
		
	</tr>
	
</table>		  
</form>	
<%}else{%>
<table class="bordered_table" cellpadding="0" cellspacing="1" align="center" width="80%">
	<tr>
		<td class="title-bkg" colspan="2"> Signature Mandate Letter</td>
	</tr>
	<tr class="white_bg">
		<td class="norm_letter_text">	
			<br />
			<h2>Mandate is awaiting authorization</h2>
		</td>
	</tr>
</table>
<%}%>			  
				  <!-- InstanceEndEditable -->				
<br /><br /><br />				  
			  </div>
			</div>
		</td>
	</tr>
</table>
<div class="footer_user" align="center">
<span class="norm_text">&copy; <%out.println(tformat.format(tdate)+" ");%>&nbsp; Nigeria Inter-Bank Settlement System Plc, All Rights Reserved &nbsp;|&nbsp; Terms &amp; Conditions</span>
</div>
</body>
<!-- InstanceEnd --></html>
