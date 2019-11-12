<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/disableClick.js"></script>

<!-- TemplateBeginEditable name="doctitle" -->
<title>.::Welcome to NIBSS ASV Portal::.</title>
<!-- TemplateEndEditable -->

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
<!-- TemplateBeginEditable name="SNIPPET" -->

<!-- TemplateEndEditable -->
<body oncopy="return false" oncut="return false" onpaste="return false">
<table align="center" width="90%">
	<tr>
	  <td class="title_header"><img src="../images/logo2.png" height="50" width="100"/>&nbsp;&nbsp;BANKING INDUSTRY AUTHORIZED SIGNATURE PORTAL</td>
	  <td  align="right" class="norm_text_white" valign="bottom"><b>Welcome: </b><%=EMAIL%> !!!&nbsp;&nbsp;&nbsp;&nbsp;| <a href="../modifyAccount.jsp" class="norm_text_white"><b>Change Password</b></a> | <a href="../index.jsp" class="norm_text_white"><b>Logout</b></a> </td>
	</tr>
</table>
<table align="center">
	<tr>
		<td colspan="2">
			<div id="placemainmenu">
				<ul id="mainmenu">
					<li><a href="../welcome.jsp">Home</a></li> 
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
				<li><a href="../contactNIBSSAdmin.jsp">Contact Us</a></li>
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
                  <!-- TemplateBeginEditable name="BODY CONTENT" -->
				  
				  <!-- TemplateEndEditable -->				
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
</html>
