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
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/formValidation.js"></script>


<%
String ID = request.getParameter("ID");
if(ID == null) ID = "";
String newID = "";

ArrayList resultConStmt = new ArrayList();
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs = null;

String USER_EMAIL="", FIRST_NAME="", LAST_NAME="";
String GENDER="", PHONE_NO="", ADDRESS="";
String COMPANY_CODE="";

String html_userType = "<option value=''>«»«»Select User Type«»«»</option>";

String html_company = "<option value=''>«»«»Select Bank Name«»«»</option>";


try{
	sc.setKey();
	newID = sc.decrypt(ID);
	html_userType += util.getHtmlOptionUserTypeAllbyUserID(newID);
	
	resultConStmt = util.listUsers(newID);
	rs= (ResultSet)resultConStmt.get(0);
	pstmt= (PreparedStatement)resultConStmt.get(1);
	con= (Connection)resultConStmt.get(2);
	
	if(rs.next()){
		USER_EMAIL = rs.getString("EMAIL");
		FIRST_NAME = rs.getString("FIRST_NAME");
		LAST_NAME = rs.getString("LAST_NAME");
		GENDER = rs.getString("GENDER");
		PHONE_NO = rs.getString("PHONE_NUM");
		COMPANY_CODE = rs.getString("COMPANY_CODE");
		ADDRESS = URLDecoder.decode(rs.getString("ADDRESS"));
	}
	html_company += util.getHtmlOptionBanks(COMPANY_CODE);
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
<p class="subInfo underlay">Create Portal Users &raquo;&raquo; &nbsp;</p>
<form id="NIBSS_EDIT_USER" method="post">
<input type="hidden" name="ITEM_ID" id="ITEM_ID" value="<%=ID%>"/>
<input type="hidden" name="USER_ID" id="USER_ID" value="<%=USER_ID%>"/>
<div id='create_user_message' align="center"></div>
<table class="bordered_table" cellpadding="0" cellspacing="1" width="70%" align="center">
	<tr>
		<td class="title-bkg" colspan="2"> User Login Information</td>
	</tr>
	<tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">Email:</td>
		<td class="norm_login_text_cell"><input type="text" name="EMAIL" id="EMAIL" value="<%=USER_EMAIL%>" class="norm_login_text" required size="40" maxlength="100" /></td>
	</tr>
	<!--tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">Password:</td>
		<td class="norm_login_text_cell"><input type="password" name="PASSWORD" id="PASSWORD" class="norm_login_text" required  size="40" maxlength="50"/> <br /><span class="norm_text">**Password must be alpha-numeric, contain special characters and must not be lesser that 8 characters long</span></td>
	</tr>
	<tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">Confirm Password:</td>
		<td class="norm_login_text_cell"><input type="password" name="C_PASSWORD" id="C_PASSWORD" class="norm_login_text" required  size="40" maxlength="50"/></td>
	</tr-->
	<tr class="white_bg">
		<td height="40" class="norm_login_text_cell_bold">User Type Name:</td>
		<td class="norm_login_text_cell"><span class="error"></span>
			<select name="USER_TYPE_NAME" id="USER_TYPE_NAME" size="1" class="norm_text" required>
			  <%=html_userType%>
			</select>
		</td>
	</tr>	
	<tr>
		<td class="title-bkg" colspan="2"> Personal Information</td>
	</tr>
	<tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">First Name:</td>
		<td class="norm_login_text_cell"><input type="text" name="FIRST_NAME" id="FIRST_NAME" value="<%=FIRST_NAME%>" class="norm_login_text" required size="40" maxlength="50" /></td>
	</tr>
	<tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">Last Name:</td>
		<td class="norm_login_text_cell"><input type="text" name="LAST_NAME" id="LAST_NAME" value="<%=LAST_NAME%>" class="norm_login_text" required size="40" maxlength="50" /></td>
	</tr>
	<tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">Gender:</td>
		<td class="norm_login_text_cell">
		<!--input type="radio" value="M" name="GENDER" id="GENDER" checked="checked" />&nbsp;Male&nbsp;&nbsp;&nbsp;
		<input type="radio" value="F" name="GENDER" id="GENDER"  /-->
		<select name="GENDER" id="GENDER" class="norm_login_text">
			<option value="M" <%=GENDER.equals("M") ? "selected":""%>>Male</option>
			<option value="F" <%=GENDER.equals("F") ? "selected":""%>>Female</option>
		</select>
		</td>
	</tr>
	<tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">Phone Number:</td>
		<td class="norm_login_text_cell"><input type="text" name="PHONE_NUM" id="PHONE_NUM" value="<%=PHONE_NO%>" class="norm_login_text" required size="40" maxlength="20" /></td>
	</tr>
	<tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">Company Name:</td>
		<td class="norm_login_text_cell">
		<select name="COMPANY_NAME" id="COMPANY_NAME" size="1" class="norm_text" required>
			  <%=html_company%>
		</select>
		</td>
	</tr>
	<tr class="white_bg">
		<td class="norm_login_text_cell_bold" height="40">Address:</td>
		<td class="norm_login_text_cell"><textarea name="COMPANY_ADDRESS" id="COMPANY_ADDRESS" class="norm_login_text" required cols="30" rows="5"><%=ADDRESS%></textarea></td>
	</tr>
	
	
	<tr class="white_bg">
		<td colspan="2" height="40">&nbsp;</td>
	</tr>
	<tr class="white_bg">
		<td colspan="2" height="40" align="center"><input type="submit" id="submit" value="Edit User" /></td>
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
