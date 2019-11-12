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
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script>
function readURL(input) {
	var fr = new FileReader;
	fr.onload = function() {
		var img = new Image;
		img.src = fr.result;
		$('#picture')
			.attr('src', fr.result)
			.width(200)
			.height(150);
		
		img.onload = function() {		
            var imageWidth = img.width;
			var imageHeight = img.height;
			document.getElementById('signHeight').innerHTML = 'Image Height::'+imageHeight+'px';
			document.getElementById('signWidth').innerHTML = 'Image Width::'+imageWidth+'px';
			if (imageWidth > 200 || imageHeight > 150){			
				document.getElementById('imageErrorMsg').innerHTML = 'Image dimension is not correct!!! <br/>It should not be more than 200px (width) and 150px (Height)';
				document.getElementById('uploadbtn').disabled="disabled"
			
			}else{
				document.getElementById('imageErrorMsg').innerHTML = '';
				document.getElementById('uploadbtn').disabled=false;
			}
			verifySignatureCode();	
        };	
		

	};
	fr.readAsDataURL(input.files[0]);
}

function verifySignatureCode(){
	var url = document.getElementById('SIGNATURE').value;
	var signatureCode = document.getElementById('CATEGORY_NUM').value;
	if(url != null || url != ''){
		if(url.indexOf("\\") > 0){
			urlSignatureCode = url.substring(url.lastIndexOf("\\")+1,url.lastIndexOf('.'));
		}else{
			urlSignatureCode = url.substring(0,url.lastIndexOf('.'));
		}
	}if(signatureCode == null || signatureCode == ''){
		alert('Signature Code Value is Empty');
		document.getElementById('CATEGORY_NUM').focus();
		document.getElementById('SIGNATURE').value = '';
		document.getElementById('signHeight').innerHTML = '';
		document.getElementById('signWidth').innerHTML = '';
		document.getElementById('imageErrorMsg').innerHTML = '';
		document.getElementById('uploadbtn').disabled=false;
	}else{
		 if(urlSignatureCode != signatureCode){
			alert('Signature Code: '+signatureCode+' is not the same as filename code selected: '+urlSignatureCode);
			document.getElementById('uploadbtn').disabled=false;
		 }
	}
}

function doSubmit(form){
	form.action ="processSignatureUpload.jsp";
	form.method = "post"
	form.encoding = "multipart/form-data"
	form.submit();
	form.NEXT.disabled = true;
}

</script>
<%
ArrayList resultConStmt = new ArrayList();
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs = null;

String CATEGORY_NUM = request.getParameter("CATEGORY_NUM");
if (CATEGORY_NUM==null) CATEGORY_NUM="";

String html_signature_no ="";
String FIRST_NAME="", MIDDLE_NAME="", LAST_NAME="";
String DESIGNATION="", CATEGORY_CODE="", SERIAL_NUM="";
String SIGNATORY_ID="";

try{
	html_signature_no = "<option value=''>«»«»Select A Signature Number«»«»</option>";
	html_signature_no += util.getHtmlOptionSignatureNumber(CATEGORY_NUM, USER_ID);

	resultConStmt = util.listBulkBankSignatory(CATEGORY_NUM, USER_ID);
	rs= (ResultSet)resultConStmt.get(0);
	pstmt= (PreparedStatement)resultConStmt.get(1);
	con= (Connection)resultConStmt.get(2);
	
	if(rs.next()){
		FIRST_NAME = rs.getString("FIRST_NAME");
		MIDDLE_NAME = rs.getString("MIDDLE_NAME");
		LAST_NAME = rs.getString("LAST_NAME");
		DESIGNATION = rs.getString("DESIGNATION");
		CATEGORY_CODE = rs.getString("CATEGORY_CODE");
		SERIAL_NUM = rs.getString("SERIAL_NO");
		SIGNATORY_ID = rs.getString("SIGNATORY_ID");
	}
}catch(Exception e){
	System.out.println("Error occured while listing in createSignatoryBulk:::");
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
		System.out.println("Error in closing connections in createSignatoryBulk::"+e.toString());
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
<p class="subInfo underlay">Create Bank Signatory &raquo;&raquo; &nbsp;</p>
<form method="post" >
<input type="hidden" name="SIGNATORY_ID" id="SIGNATORY_ID" value="<%=SIGNATORY_ID%>"/>
<table width="80%" align="center">
	<tr>
		<td>
			<table class="bordered_table" cellpadding="0" cellspacing="1" width="90%">
				<tr>
					<td class="title-bkg" colspan="2"> Signatory Information</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">First Name:</td>
					<td class="norm_login_text_cell">
					<input type="text" name="FIRST_NAME" id="FIRST_NAME" value="<%=FIRST_NAME%>" class="norm_login_text" required size="40" readonly="true"/></td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Middle Name:</td>
					<td class="norm_login_text_cell">
					<input type="text" name="MIDDLE_NAME" id="MIDDLE_NAME" value="<%=MIDDLE_NAME%>" class="norm_login_text" size="40"  readonly="true" /></td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Last Name:</td>
					<td class="norm_login_text_cell">
					<input type="text" name="LAST_NAME" id="LAST_NAME" value="<%=LAST_NAME%>" class="norm_login_text" required size="40"  readonly="true" /></td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Designation:</td>
					<td class="norm_login_text_cell">
					<input type="text" name="DESIGNATION" id="DESIGNATION" value="<%=DESIGNATION%>" class="norm_login_text" required size="40"  readonly="true" />
					
					</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Category:</td>
					<td class="norm_login_text_cell">
					<input type="text" name="CATEGORY_CODE" id="CATEGORY_CODE" value="<%=CATEGORY_CODE%>" class="norm_login_text" required size="40"  readonly="true" />
					</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Signature Code:</td>
					<td class="norm_login_text_cell">
					<select name="CATEGORY_NUM" id="CATEGORY_NUM" class="norm_login_text" onchange="this.form.submit()">
						  <%=html_signature_no%>
					</select>
					</td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Staff ID:</td>
					<td class="norm_login_text_cell">
					<input type="text" name="SERIAL_NUM" id="SERIAL_NUM" value="<%=SERIAL_NUM%>" class="norm_login_text" required size="40" readonly="true" /></td>
				</tr>
				<tr class="white_bg">
					<td class="norm_login_text_cell_bold" height="40">Signature:</td>
					<td class="norm_login_text_cell"><input type="file" name="SIGNATURE" id="SIGNATURE" class="norm_login_text" required onchange="readURL(this);"/>
						
					</td>
				</tr>
				<tr class="white_bg">
					<td colspan="2" height="40" class="norm_text"><span style="color:#FF0000">**Note: Signature format is: .jpeg, .gif and .png. Also, it should be 200px (width) and 150px (Height)</span></td>
				</tr>
				<tr class="white_bg">
					<td colspan="2" height="40" align="center"><input type="button" id="uploadbtn" name="NEXT" value="Submit &raquo;&raquo;" onclick="doSubmit(this.form)"/></td>
				</tr>
			</table>
		</td>
		<td valign="top" align="center">
		
			<table width="84%"  class="bordered_table" cellpadding="0" cellspacing="1" >
				<tr class="white_bg">
					<td align="center"><img id="picture" src="#"/></td>
				</tr>
			</table>
			<br />
			<label  id="signHeight" class="norm_text"></label><br />
			<label  id="signWidth" class="norm_text"></label><br />
			<label  id="imageErrorMsg" class="norm_text" style="color:#FF0000"></label><br />
		</td>
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
