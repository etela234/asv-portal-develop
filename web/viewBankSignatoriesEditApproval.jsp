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
<!-- Add jQuery library -->
<script type="text/javascript" src="js/jquery-1.9.0.min.js"></script>

<!-- Add jQuery UI library -->
<script type="text/javascript" src="js/jquery-ui-1.9.0.min.js"></script>

<!-- Add mousewheel plugin (this is optional) -->
<script type="text/javascript" src="js/jquery.mousewheel-3.0.6.pack.js"></script>

<!-- Add fancyBox main JS and CSS files -->
<script type="text/javascript" src="js/jquery.fancybox.js?v=2.1.4"></script>
<link rel="stylesheet" type="text/css" href="css/jquery.fancybox.css?v=2.1.4" media="screen" />

<script>
function goPrev(form)
{
	if (parseInt(form.pageNo.value) > 1) {
	form.pageNo.value = parseInt(form.pageNo.value)-1;
	form.submit();
	}
}
function goNext(form)
{
	var npages = form.rowCount.value/form.MAXPAGE.value;
	if((form.rowCount.value/form.MAXPAGE.value)*form.MAXPAGE.value != form.rowCount.value){
	 npages = npages+1;
	}
	
	if (parseInt(form.pageNo.value) < (npages)){
	form.pageNo.value = parseInt(form.pageNo.value)+1;
	form.submit();
	}	
}

function doSearch(form)
{
	form.SEARCH.value = '1';
	form.pageNo.value = '1';
	form.submit();
}

function doApprove(form)
{
	if (!checkSelected(form)) return false;
	form.sel.value = '1'
	form.submit();
}
function doDecline(form)
{
	if (!checkSelected(form)) return false;
	form.sel.value = '2'
	form.submit();
}
function checkSelected(form){
	//var form = document.forms[0];
	var parString = "";
	var delcount = 0;
	for(var i = 0; i < form.elements.length; ++i){
		if(form.elements[i].type == "checkbox" & form.elements[i].name == 'C2')
		if(form.elements[i].checked == true){
			delcount++;
			parString =  parString + "-" + form.elements[i].value+"-* ";
		}
	}
	if(parString == "") {
		window.alert("Select record(s) to continue...");
		return (false);
	}
	else {
		//delcount = delcount - 1;
		ans=window.confirm("You have selected " + delcount + " record(s), Are your sure ?")
		if (ans == 1)
			return true; 
		else return false; 
	}
}

function doClickAll(form) {
	for (var i = 0; i < form.elements.length; i++) {
		if ( form.elements[i].type == "checkbox" ) {
			if ( ! form.elements[i].checked ) { 
				form.elements[i].click();
			}
		}
	}
	return true;
}

function doUnClickAll(form) {
	for (var i = 0; i < form.elements.length; i++) {
		if ( form.elements[i].type == "checkbox" ) {
			if (  form.elements[i].checked ) { 
				form.elements[i].checked = false;
			}
		}
	}
	return true;
}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.fancybox').fancybox();

		// Change title type, overlay closing speed
		$(".fancybox-effects-a").fancybox({
			helpers: {
				title : {
					type : 'outside'
				},
				overlay : {
					speedOut : 0
				}
			}
		});
	});
</script>
<%
String pageMax = request.getParameter("MAXPAGE");
if (pageMax == null) pageMax = "10";
String pageNo = request.getParameter("pageNo");
if (pageNo == null) pageNo = "1";
String search = request.getParameter("SEARCH");
if (search == null) search = "0";
String BANK_NAME = request.getParameter("BANK_NAME");
if (BANK_NAME==null) BANK_NAME="";

String searchBy = request.getParameter("SEARCHBY");
if (searchBy == null) searchBy = "";
String searchFor = request.getParameter("SEARCHFOR");
if (searchFor == null) searchFor = "";
String sel = request.getParameter("sel");
if (sel == null) sel = "0";


int rowcount =0;
ArrayList resultConStmt = new ArrayList();
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs = null;

if (sel.equals("1")){
	int approveResult=0;
	try{
		String[] menuItemValues = request.getParameterValues("C2");
		for (int i=0; i<menuItemValues.length; i++){
			approveResult += util.approvalManagedBankSignature(menuItemValues[i],USER_ID,request);
		}
		if ((approveResult>0)){
			out.println("<script language='javascript'>");
			out.println("alert('"+approveResult+" item(s) have been approved for deletion');");
			out.println("</script>");  
		}else{
			out.println("<script language='javascript'>");
			out.println("alert('The item(s) Could not be delete approved for deletion');");
			out.println("</script>");  
		}
	}catch(Exception e){
		System.out.println("Error occurred while error approving record::::"+e.toString());
		e.printStackTrace();
	}
}else if (sel.equals("2")){
	int approveResult=0;
	try{
		String[] menuItemValues = request.getParameterValues("C2");
		for (int i=0; i<menuItemValues.length; i++){
			approveResult += util.declineManagedBankSignature(menuItemValues[i],USER_ID,request);
		}
		if ((approveResult>0)){
			out.println("<script language='javascript'>");
			out.println("alert('"+approveResult+" item(s) declined successfully');");
			out.println("</script>");  
		}else{
			out.println("<script language='javascript'>");
			out.println("alert('Decline was not successful');");
			out.println("</script>");  
		}
	}catch(Exception e){
		System.out.println("Error occurred while error declining record::::"+e.toString());
		e.printStackTrace();
	}
}


try{
	rowcount = util.getRecordBankSignatoriesEditApproval(USER_ID,searchBy, searchFor);
}catch(Exception e){
	e.printStackTrace();
}

sel="0";
int skip = 0;
int npages = 0;
int maxPage = Integer.parseInt(pageMax);

npages = rowcount/maxPage;

if (npages!=0){
	if(((rowcount/maxPage)* maxPage) != rowcount){
		npages = npages+1;
	}
}else{
	npages = 1;
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
<p class="subInfo underlay">Signatories awaiting authorization &raquo;&raquo; &nbsp;</p>
<form method="post">
<input type = hidden name = 'pageNo' value = "<%=pageNo%>">
<input type = hidden name = 'rowCount' value = "<%=rowcount%>">
<input type = hidden name = 'skipper' value = "<%=skip%>">
<input type = hidden name = 'pageEnd' value = "<%=npages%>">
<input type = hidden name = 'SEARCH' value="<%=search%>">
<input type = hidden name = sel value = "0">
<table cellpadding="0" cellspacing="1" align="center" width="90%">
	<tr>
		<td class="norm_login_text">| <input type="image" src="images/tick.png" width="18" height="18" border="0" onclick="doApprove(this.form)"/>&nbsp; Approve | <input type="image" src="images/cancel.png" width="18" height="18" border="0" onclick="doDecline(this.form)"/>&nbsp;Decline|</td>
		<td class="norm_text" align="right">Record Limit:</td>
		<td align="left">
			<select name="MAXPAGE" size="1" class="norm_text" onchange='javascript: this.form.submit();'>
			  <option value="10" <%=pageMax.equals("10") ? "selected":""%> >10 Results</option>
			  <option value="20" <%=pageMax.equals("20") ? "selected":""%> >20 Results</option>
			  <option value="50" <%=pageMax.equals("50") ? "selected":""%> >50 Results</option>
			  <option value="70" <%=pageMax.equals("70") ? "selected":""%> >70 Results</option>
			  <option value="100" <%=pageMax.equals("100") ? "selected":""%> >100 Results</option>
			  <option value="200" <%=pageMax.equals("200") ? "selected":""%> >200 Results</option>
			  <option value="500" <%=pageMax.equals("500") ? "selected":""%> >500 Results</option>
		  </select>
		</td>
		
		<td class="norm_text" align="center"> Page: 
			<input type="text" name="fpage" size="3" value="<%=pageNo%>" readonly class="norm_text" />
			&nbsp;of&nbsp;
			<input type="text" name="tpages" size="3" value="<%=npages%>" readonly class="norm_text" />		
		</td>
		<td class="norm_text" align="center" colspan="2">
			<input name="prev" type="button" class="norm_text" onclick="javascript:goPrev(this.form)" value="|&lt;" />&nbsp;&nbsp;
			<input name="next" type="button" class="norm_text" onclick="javascript:goNext(this.form)" value="&gt;|" />
		</td>
	</tr>
</table>

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
		<td class="norm_text_header"><input name="CheckAll" type="checkbox" class="norm_text" onClick="if (this.checked) {doClickAll(this.form)} else {doUnClickAll(this.form)}" value="ON">&nbsp;<input type="image" src="images/tick.png" width="18" height="18" border="0" onclick="javascript:doApprove(this.form)" alt="Approve Record(s)"/>
		Approve</td>
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
		resultConStmt = util.listBankSignatoriesEditApproval(USER_ID,searchBy, searchFor);
		if(!resultConStmt.isEmpty()){
			rs= (ResultSet)resultConStmt.get(0);
			pstmt= (PreparedStatement)resultConStmt.get(1);
			con= (Connection)resultConStmt.get(2);
			URLDecoder dec = new URLDecoder();
			while(rs.next())
			{	
	%>		
			<tr class="white_bg">
				<td class="norm_text" height="30"><input name="C2" type="checkbox" value="<%=rs.getString("SIGNATORY_ID")+"_"+rs.getString("ACTION_ID")%>"/> 
				<a class="fancybox" href="#<%=rs.getString("MANAGE_ID")%>" title="Reason for Modification">View Reason</a>
				<div id="<%=rs.getString("MANAGE_ID")%>" style="width:400px;display: none;">
					<h3><%=util.getActionName(rs.getString("ACTION_ID"))%></h3>
					<p><%=dec.decode(rs.getString("CREATED_REASON").replace("%0D", "<br/>"), "UTF-8")%></p>
				</div>
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
		System.out.println("Error occured while listing in viewBankSignatoriesEditApproval.jsp:::");
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
			System.out.println("Error in closing connections in viewBankSignatoriesEditApproval.jsp::"+e.toString());
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
