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
<script>
function doSubmitDecline(form)
{
	val= document.getElementById('valReason');
	if(val.value == '' || val.value == null){
		alert('Kindly State a reason for declining mandate or state a modification that needs to be perfomed');
		return false;
	}else{
		var ans=window.confirm("You have chosen to decline this mandate letter, do you still want to proceed ?")
		if (ans == true){
			form.sel.value = '2'
			form.submit();
		}else{
			return false;
		}
	}
}
function doApprove(form)
{
	var ans=window.confirm("You have chosen to approve this mandate letter, do you still want to proceed ?")
	if (ans == true){
		form.sel.value = '1'
		form.submit();
	}else{
		return false;
	}
}
function doShow()
{
	obj = document.getElementById('Reason');
    obj.style.display = 'block';
	return false;
}
function doHide()
{
	obj = document.getElementById('Reason');
    obj.style.display = 'none';
	return false;
}
</script>
<%
String MANDATE_ID = request.getParameter("MANDATE_ID");
if (MANDATE_ID==null) MANDATE_ID="";

String VAL_REASON = request.getParameter("VAL_REASON");
if (VAL_REASON==null) VAL_REASON="";
	
String sel = request.getParameter("sel");
if (sel == null) sel = "0";

String allowed_signatory="";

ArrayList resultConStmt = new ArrayList();
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs = null;
int approveResult=0;

try{
	if(!sel.equals("0")){
	
		approveResult = util.approveSignatureMandate(sel,MANDATE_ID,USER_ID,VAL_REASON,request);
		if ((approveResult>0) && sel.equals("1")){
			out.println("<script language='javascript'>");
			out.println("alert('Mandate Letter is successfully approved');");
			out.println("</script>");  
		}else if ((approveResult>0) && sel.equals("2")){
			out.println("<script language='javascript'>");
			out.println("alert('Mandate Letter is successfully declined');");
			out.println("</script>");  
		}else{
			out.println("<script language='javascript'>");
			out.println("alert('Mandate Letter was not successfully processed');");
			out.println("</script>");  
		}
	}

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
<form method="post">
	<input type="hidden" name="sel" value="0" />
<table cellpadding="0" cellspacing="1" align="center" width="80%">
	<tr>
		<td colspan="2" class="norm_login_text">| <input type="image" src="images/tick.png" width="18" height="18" border="0" onclick="doApprove(this.form)"/>&nbsp; Approve | 
		<img src="images/cancel.png" width="18" height="18" border="0" onclick="doShow()"/>&nbsp;&nbsp;Decline</a></td>
	</tr>
	<br />
	<tr>
		<td colspan="2">
			<table cellpadding="0" cellspacing="1" align="left" width="60%" id="Reason" style="display:none">
				<tr>
					<td class="norm_text"> State Reason OR<br /> Required modifications</td>
					<td class="norm_login_text"><textarea name="VAL_REASON" class="norm_text" rows="3" cols="30" id="valReason"></textarea></td>
				</tr>
				<tr>
					<td class="norm_login_text" colspan="2" align="center">&nbsp;</td>
				</tr>
				<tr>
					<td class="norm_login_text" colspan="2" align="center"><input type="button" id="button" value="Decline" onclick="doSubmitDecline(this.form)"/>&nbsp;&nbsp;<a onclick="doHide()">Hide</a></td>
				</tr>
				<tr>
					<td class="norm_login_text" colspan="2" align="center">&nbsp;</td>
				</tr>
			</table>
			
		</td>
	</tr>
</table>


<table class="bordered_table" cellpadding="0" cellspacing="1" align="center" width="80%">
	<tr>
		<td class="title-bkg" colspan="2">Signature Mandate Letter Pending Approval</td>
	</tr>
	
<%
	try{
		resultConStmt = util.listSignatureMandateApproval(USER_ID);
		rs= (ResultSet)resultConStmt.get(0);
		pstmt= (PreparedStatement)resultConStmt.get(1);
		con= (Connection)resultConStmt.get(2);
		URLDecoder dec = new URLDecoder();
		if(rs.next())
		{	
			allowed_signatory = rs.getString("ALLOWED_SIGNATORY");
%>	
	<input type="hidden" name="MANDATE_ID" value="<%=rs.getString("MANDATE_ID")%>" />
	<tr class="white_bg">
		<td class="norm_letter_text">	
			<br />
			<label  id="greeting" class="norm_letter_text">Dear all,</label>
			<div class="message_body" class="norm_letter_text"><%=dec.decode(rs.getString("MANDATE_BODY").replace("%0D", "<br/>"), "UTF-8")%></div>
			<br/>
			<br/>
			<label  id="complimentary_close" class="norm_letter_text"><%=rs.getString("COMPLIMENTARY_CLOSE")%>,</label><br/><br/>
			<table>
				<tr>
					<td align="center">
						<label  id="authorized_signatory" class="norm_letter_text"><img id="picture" src="Uploads/Signatures/<%=util.getMandateSignature(rs.getString("SIGNATORY"), USER_ID)%>" width="100px" height="100px"/></label>
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
						<label  id="authorized_signatory" class="norm_letter_text"><img id="picture" src="Uploads/Signatures/<%=util.getMandateSignature(rs.getString("SIGNATORY_2"), USER_ID)%>" width="100px" height="100px"/></label>
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
			<br/>	
		</td>
	</tr>
<%
		}
	}catch(Exception e){
		System.out.println("Error occured while listing in welcome.jsp:::");
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
			System.out.println("Error in closing connections in welcome.jsp::"+e.toString());
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
