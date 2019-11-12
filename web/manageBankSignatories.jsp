<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*" errorPage="" %>
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
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/formValidation.js"></script>
<%
String ID = request.getParameter("ID");
if(ID == null) ID = "";
String newID = "";
String html_action = "";
boolean isDecline=false;
ArrayList resultConStmt = new ArrayList();
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs = null;

try{
	sc.setKey();
	newID = sc.decrypt(ID);
	
	html_action = "<option value=''>«»«»Select An Action«»«»</option>";
	html_action += util.getHtmlOptionManageAction();
	
	isDecline = util.isSignatoryDeclined(newID, USER_ID);
	
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
<p class="subInfo underlay">Manage Signatory &raquo;&raquo; &nbsp;</p>
<form method="post" id="MANAGE_SIGNATORY" >
	<input type="hidden" name="SIGNATURE_ID" id="SIGNATURE_ID" value="<%=ID%>"  />
	<input type="hidden" name="USER_ID" id="USER_ID" value="<%=USER_ID%>"  />


<table align="center">
	<tr>
		<td> <div id='msg_manage_signatory'></div></td>
	</tr>
	<tr>
		<td>
			<table class="bordered_table" cellpadding="0" cellspacing="1">
				<tr>
					<td class="title-bkg" colspan="2"> Select Action for Signatory</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Action Type:</td>
					<td class="norm_login_text_cell">
						<select name="ACTION" id="ACTION" size="1" class="norm_text" required  <% if(isDecline){ out.print("disabled=\"disabled\"");}%>>
							  <%=html_action%>
						</select>	
					</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Reason:</td>
					<td class="norm_login_text_cell"><textarea type="text" name="REASON" id="REASON" class="norm_login_text" cols="50" rows="7"></textarea></td>
				</tr>
				
				<tr class="white_bg">
					<td colspan="2" height="40" align="center"><input type="submit" id="submit" value="Submit" /></td>
				</tr>
			</table>
		</td>
		<td width="60px">&nbsp;</td>

<% 
if(!ID.equals("")){
	try{
		resultConStmt = util.getSignatoryDetails(newID, USER_ID);
		rs= (ResultSet)resultConStmt.get(0);
		pstmt= (PreparedStatement)resultConStmt.get(1);
		con= (Connection)resultConStmt.get(2);
		
		if (rs.next()){
%>
		<td width="400px" valign="top">
			<table cellpadding="0" cellspacing="1" width="100%">
				<tr>
					<td colspan="2" class="norm_login_text"><a href="editBankSignatories.jsp?ID=<%=ID%>">Edit Details</a></td>
				</tr>
			</table>
			<table class="bordered_table" cellpadding="0" cellspacing="1" width="100%">
				<tr>
					<td class="title-bkg" colspan="2"> Signatory Preview</td>
				</tr>
				<tr class="white_bg">
					<td width="38%" height="40" class="norm_login_text_cell_bold">First Name:</td>
					<td width="62%" class="norm_login_text_cell"><%=rs.getString("FIRST_NAME")%></td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Middle Name:</td>
					<td class="norm_login_text_cell"><%=rs.getString("MIDDLE_NAME")%></td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Last Name:</td>
					<td class="norm_login_text_cell"><%=rs.getString("LAST_NAME")%></td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Category Code:</td>
					<td class="norm_login_text_cell"><%=rs.getString("CATEGORY_CODE")%></td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Signature No:</td>
					<td class="norm_login_text_cell"><%=rs.getString("CATEGORY_NO")%></td>
				</tr>
				<% if (rs.getString("DECLINE_REASON") !=null){%>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Decline Reason:</td>
					<td class="norm_login_text_cell"><%=URLDecoder.decode(rs.getString("DECLINE_REASON"))%></td>
				</tr>
				<%}%>
			</table>
		</td>
<%
		}
	}catch(Exception e){
		System.out.println("Error occured while listing in manageBankSignatories.jsp:::");
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
			System.out.println("Error in closing connections in manageBankSignatories.jsp::"+e.toString());
		}
	
	}
}
%>

	</tr>
</table>
</form>		  					  
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
