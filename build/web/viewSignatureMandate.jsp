<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/user_home_template.dwt.jsp" codeOutsideHTMLIsLocked="false" -->
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
<%
ArrayList resultConStmt = new ArrayList();
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs = null;
String html_company="";

String COMPANY_NAME = request.getParameter("COMPANY_NAME");
if (COMPANY_NAME==null) COMPANY_NAME=util.getCompanyCode(USER_ID);

String key = request.getParameter("key");
if (key==null) key="";

try{
	if(!key.equals("")){
		COMPANY_NAME = sc.decrypt(key);
	}
	html_company = "<option value=''>«»«»Select Bank Name«»«»</option>";
	html_company += util.getHtmlOptionBanks(COMPANY_NAME);

}catch(Exception e){
	e.printStackTrace();
}
	
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
<p class="subInfo underlay">Bank Signature Mandate &raquo;&raquo; &nbsp;</p>
<!--form method="post">
<table align="center">
	<tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">Company Name:</td>
		<td class="norm_login_text_cell">
		<select name="COMPANY_NAME" id="COMPANY_NAME" size="1" class="norm_text" required onchange="this.form.submit()">
			  <%=html_company%>
		</select>
		</td>
	</tr>
</table>
</form-->
<table class="bordered_table" cellpadding="0" cellspacing="1" align="center" width="70%">
	<tr>
		<td class="title-bkg" colspan="2"> Signatory Mandate Letter for <b><%=util.getCompanyName(COMPANY_NAME)%></b></td>
	</tr>
	
<%
	try{
		resultConStmt = util.listSignatureMandate(COMPANY_NAME);
		rs= (ResultSet)resultConStmt.get(0);
		pstmt= (PreparedStatement)resultConStmt.get(1);
		con= (Connection)resultConStmt.get(2);
		URLDecoder dec = new URLDecoder();
		if(rs.next())
		{	
			String allowed_signatory = rs.getString("ALLOWED_SIGNATORY");
			util.storeViewedMandate(rs.getString("MANDATE_ID"),USER_ID, request);	
%>	
	<tr class="white_bg">
		<td class="norm_letter_text">	
			<label  id="greeting" class="norm_letter_text"><%=rs.getString("SALUTATION")%>,</label><br/><br/>
			<div class="message_body" class="norm_letter_text"><%=dec.decode(rs.getString("MANDATE_BODY").replace("%0D", "<br/>"), "UTF-8")%></div>
			<br/>
			<br/>
			<label  id="complimentary_close" class="norm_letter_text"><%=rs.getString("COMPLIMENTARY_CLOSE")%>,</label><br/><br/>
			<table>
				<tr>
					<td align="center">
						<label  id="authorized_signatory" class="norm_letter_text"><img id="picture" src="Uploads/Signatures/<%=util.getMandateSignatureBank(rs.getString("SIGNATORY"), COMPANY_NAME)%>" width="100px" height="100px"/></label>
					</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					
			<%if(allowed_signatory.equals("2")){%>
					<td  align="center">
						<label  id="authorized_signatory" class="norm_letter_text"><img id="picture" src="Uploads/Signatures/<%=util.getMandateSignatureBank(rs.getString("SIGNATORY_2"), COMPANY_NAME)%>" width="100px" height="100px"/></label>
					</td>
			<%}%>
				</tr>
				<tr>
					<td>	
						<label  id="authorized_signatory" class="norm_letter_text"><b><%=rs.getString("SIGNATORY")%></b></label> 
					</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td align="center">&nbsp;</td>
			<%if(allowed_signatory.equals("2")){%>
					<td>
						<label  id="authorized_signatory" class="norm_letter_text"><b><%=rs.getString("SIGNATORY_2")%></b></label>
					</td>
			<%}%>
				</tr>
			</table>		
		</td>
	</tr>
<%
	}else{
%>		
	<tr class="white_bg">
		<td class="norm_letter_text">	
			<br />
			<h2>No Mandate Created Yet!!!</h2>
		</td>
	</tr>
<%	
		}
	}catch(Exception e){
		System.out.println("Error occured while listing in viewSignatureMandate.jsp:::");
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
			System.out.println("Error in closing connections in viewSignatureMandate.jsp::"+e.toString());
		}
	
	}
%>

</table>			  
				  
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
