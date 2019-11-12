<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*" errorPage="" %>
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
<script>
function doSearch(form)
{
	form.submit();
}
</script>

<%
java.text.SimpleDateFormat dfmt = new java.text.SimpleDateFormat ("EEE, d MMM yyyy");

String searchBy = request.getParameter("SEARCHBY");
if (searchBy == null) searchBy = "";
String searchFor = request.getParameter("SEARCHFOR");
if (searchFor == null) searchFor = "";


int rowcount =0;
ArrayList resultConStmt = new ArrayList();
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs = null;



try{
	rowcount = util.getRecordBankSignatoriesArchived(USER_ID, searchBy, searchFor);
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
<p class="subInfo underlay">Search Archived Bank Signatories &raquo;&raquo; &nbsp;</p>
<form method="post">
<table width="90%" align="center" class="bordered_table">
	<tr class="white_bg">
		<td colspan="10">
			<table width="100%">
				<tr>
					<td class="norm_login_text_cell" align="right" height="30">Search by:</td>
					<td class="norm_login_text_cell">
						<select name="SEARCHBY" size="1" class="norm_text">
						  <option value="FIRST_NAME" <%=searchBy.equals("FIRST_NAME") ? "selected":""%>>First Name</option>
						  <option value="LAST_NAME" <%=searchBy.equals("LAST_NAME") ? "selected":""%>>Last Name</option>
						  <option value="MIDDLE_NAME" <%=searchBy.equals("MIDDLE_NAME") ? "selected":""%>>Middle Name</option>
						  <option value="CATEGORY_NO" <%=searchBy.equals("CATEGORY_NO") ? "selected":""%>>Signature Code</option>
						</select>
					</td>
					<td class="norm_login_text_cell_bold" align="right">&nbsp;</td>
					<td class="norm_login_text_cell">For: <input name="SEARCHFOR" type="text" class="norm_text"  value="<%=searchFor%>" size="30" /></td>
					<td align="right"><input type="button" id="button" value="Search" onclick="doSearch(this.form)"/></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="white_bg">
		<td class="norm_login_text_header" height="30">Status</td>
		<td class="norm_login_text_header" height="30">First Name</td>
		<td class="norm_login_text_header">Middle Name</td>
		<td class="norm_login_text_header">Last Name</td>
		<td class="norm_login_text_header">Category Code</td>
		<td class="norm_login_text_header">Signature Number</td>
		<td class="norm_login_text_header">Staff ID</td>
		<td class="norm_login_text_header">Designation</td>
		<td class="norm_login_text_header">Bank Name</td>
		<td class="norm_login_text_header">Signature</td>
	</tr>
<%
	try{
		resultConStmt = util.listBankSignatoriesArchivedAdmin(USER_ID, searchBy, searchFor);
		if(!resultConStmt.isEmpty()){
			rs= (ResultSet)resultConStmt.get(0);
			pstmt= (PreparedStatement)resultConStmt.get(1);
			con= (Connection)resultConStmt.get(2);
			
			while(rs.next())
			{	
				util.storeViewedSignature(rs.getString("SIGNATORY_ID"),USER_ID, request);		
	%>		
			<tr class="white_bg">
				<td class="norm_login_text_cell" height="30">
				<%
					if(rs.getString("DELETE_STATUS").equals("2")){
				%>
					<span style="color:#FF0000">
				<%
						out.println("Deleted on:<br>"+util.getSignatoryDeletedDate(rs.getString("SIGNATORY_ID")));
				%>
					</span>
				<%
					}
				%>			
				</td>
				<td class="norm_login_text_cell" height="30"><%=rs.getString("FIRST_NAME")%></td>
				<td class="norm_login_text_cell"><%=rs.getString("MIDDLE_NAME")%></td>
				<td class="norm_login_text_cell"><%=rs.getString("LAST_NAME")%></td>
				<td class="norm_login_text_cell"><%=rs.getString("CATEGORY_CODE")%></td>
				<td class="norm_login_text_cell"><%=rs.getString("CATEGORY_NO")%></td>
				<td class="norm_login_text_cell"><%=rs.getString("SERIAL_NO")%></td>
				<td class="norm_login_text_cell"><%=rs.getString("DESIGNATION")%></td>
				<td class="norm_login_text_cell"><%=util.getCompanyName(rs.getString("COMPANY_CODE"))%></td>
				<td class="norm_login_text_cell" align="center" valign="middle"><a class="p1" href="#v"><img id="picture" src="Uploads/Signatures/<%=rs.getString("SIGNATURE_URL")%>" width="50px" height="50px"/><b><img class="large" src="Uploads/Signatures/<%=rs.getString("SIGNATURE_URL")%>" alt=""></b></a></td>
			</tr>
	<%
			}
		}//end of if(!resultConStmt.isEmpty()){
	}catch(Exception e){
		System.out.println("Error occured while listing in viewBankSignatoriesArchived.jsp:::");
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
			System.out.println("Error in closing connections in viewBankSignatoriesArchived.jsp::"+e.toString());
		}
	
	}
%>
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
