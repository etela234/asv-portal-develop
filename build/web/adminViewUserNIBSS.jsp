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
	//form.action = "userViewUserListing.jsp";
	form.SEARCH.value = '1';
	form.pageNo.value = '1';
	form.submit();
}

function doDelete(form)
{
	if (!checkSelected(form)) return false;
	form.sel.value = '1'
	form.submit();
}
function doUnlock(form)
{
	if (!checkSelectedUnlock(form)) return false;
	form.sel.value = '2'
	form.submit();
}

function doPwrdReset(form)
{
	if (!checkSelected(form)) return false;
	//form.action = "adminViewUserExt.nibss"
	form.sel.value = '3'
	form.submit();
}
function checkSelected(form){
	//var form = document.forms[0];
	var parString = "";
	var delcount = 0;
	for(var i = 0; i < form.elements.length; ++i)
		if(form.elements[i].type == "checkbox" & form.elements[i].name == 'C2')
	if(form.elements[i].checked == true){
		delcount++;
		parString =  parString + "-" + form.elements[i].value+"-* ";
	}
	
	if(parString == "") {
		window.alert("Select record(s) to continue...");
		return (false);
	}
	else {
		ans=window.confirm("You have selected " + delcount + " record(s), Are your sure ?")
		if (ans == 1)
			return true; 
		else 
			return false; 
	}
}
  
function checkSelectedUnlock(form){
	var parString = "";
	var delcount = 0;
	for(var i = 0; i < form.elements.length; ++i)
		if(form.elements[i].type == "checkbox" & form.elements[i].name == 'C3')
	if(form.elements[i].checked == true){
		delcount++;
		parString =  parString + "-" + form.elements[i].value+"-* ";
	}
	
	if(parString == "") {
		window.alert("Select record(s) to continue...");
		return (false);
	}
	else {
	
		ans=window.confirm("You have selected " + delcount + " record(s), Are your sure ?")
		if (ans == 1)
			return true; 
		else return false; 
	}
}
function doClickAll(form) {
	for (var i = 0; i < form.elements.length; i++) {
		if ( form.elements[i].type == "checkbox" ) {
			if ( ! form.elements[i].checked ) { form.elements[i].click();
			}
		}
	}
	return true;
}
	
function doUnClickAll(form) {
	for (var i = 0; i < form.elements.length; i++) {
		if ( form.elements[i].type == "checkbox" ) {
			if (  form.elements[i].checked ) { form.elements[i].checked = false;
			}	
		}
	}
	return true;
}
</script>
<%
java.text.SimpleDateFormat dfmt = new java.text.SimpleDateFormat ("EEE, d MMM yyyy");

String pageMax = request.getParameter("MAXPAGE");
if (pageMax == null) pageMax = "10";
String pageNo = request.getParameter("pageNo");
if (pageNo == null) pageNo = "1";
String searchBy = request.getParameter("SEARCHBY");
if (searchBy == null) searchBy = "";
String searchFor = request.getParameter("SEARCHFOR");
if (searchFor == null) searchFor = "";
String search = request.getParameter("SEARCH");
if (search == null) search = "0";
String orderBy = request.getParameter("ORDERBY");
if (orderBy == null) orderBy = "USER_ID ";
String orderBFlag = request.getParameter("R1");
if (orderBFlag == null) orderBFlag = "DESC";



String sel = request.getParameter("sel");
if (sel == null) sel = "0";

String ipAddress = request.getRemoteAddr();
String filter="",  orderByStr = "", sqlListing="", rowCountSql ="";

int rowcount =0;
ArrayList resultConStmt = new ArrayList();
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs = null;


if (sel.equals("1")){
	int deleteDoc=0, deleteResult=0;
	try{
		String[] menuItemValues = request.getParameterValues("C2");
		
		for (int i=0; i<menuItemValues.length; i++){
			deleteResult += util.lockUser(menuItemValues[i],USER_ID,request);
		}
		if ((deleteResult>0)){
			out.println("<script language='javascript'>");
			out.println("alert(' "+deleteResult+" user(s) has been Locked successfully');");
			out.println("</script>");  
		}else{
			out.println("<script language='javascript'>");
			out.println("alert('The user(s) could not be deleted successfully');");
			out.println("</script>");  
		}
	}catch(Exception e){
		System.out.println("Error occurred while error deleting record::::"+e.toString());
		e.printStackTrace();
	}
}else if (sel.equals("2")){
	int deleteDoc=0, unlockResult=0;
	try{
		String[] menuItemValues = request.getParameterValues("C3");
		
		for (int i=0; i<menuItemValues.length; i++){
			unlockResult += util.unlockUser(menuItemValues[i],USER_ID,request);
		}
		
		if ((unlockResult>0)){
			out.println("<script language='javascript'>");
			out.println("alert('User has been unlocked successfully');");
			out.println("</script>");  
		}else{
			out.println("<script language='javascript'>");
			out.println("alert('User could not be unlocked');");
			out.println("</script>");  
		}
	}catch(Exception e){
		System.out.println("Error occurred while error unlocking record::::"+e.toString());
	}
}else if (sel.equals("3")){
	int resetResult=0;
	try{
		String[] menuItemValues = request.getParameterValues("C2");
		
		resetResult = util.adminResetPassword(menuItemValues, USER_ID,request);
		
		if (resetResult>0){
			out.println("<script language='javascript'>");
			out.println("alert('User password has been reset successfully');");
			out.println("</script>");  
		}else{
			out.println("<script language='javascript'>");
			out.println("alert('User password could not be reset');");
			out.println("</script>");  
		}
	}catch(Exception e){
		System.out.println("Error occurred while error unlocking record::::"+e.toString());
	}
 }
 
 try{
	rowcount = util.getRecordListUsers(searchBy, searchFor);
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
<p class="subInfo underlay">Portal User Listing &raquo;&raquo;</p>
<form method="post">
<input type = hidden name = 'pageNo' value = "<%=pageNo%>">
<input type = hidden name = 'rowCount' value = "<%=rowcount%>">
<input type = hidden name = 'skipper' value = "<%=skip%>">
<input type = hidden name = 'pageEnd' value = "<%=npages%>">
<input type = hidden name = 'SEARCH' value="<%=search%>">
<input type = hidden name = sel value = "0">
<!--table width="960" align="center">
	<tr>
		<td valign="top">| <a href="adminCreateUser.jsp" class="norm_login_text">Create User Login</a> |</td>  
	</tr>
</table-->
<table width="960" align="center" class="bordered_table" cellpadding="0" cellspacing="1">
	<tr  class="white_bg">
		<td class="norm_text" align="center">Records: <%=rowcount%></td>
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
			<input name="prev" type="button" class="norm_text" onclick="javascript:goPrev(this.form)" value="|&lt;" />
			<input name="next" type="button" class="norm_text" onclick="javascript:goNext(this.form)" value="&gt;|" />
		</td>
	</tr>
</table>
<table width="960" align="center" class="bordered_table" cellpadding="0" cellspacing="1">
	<tr>
		<td colspan="11">
			<table width="100%" class="white_bg" height="40px">
				<tr >
					<td width="44%" class="norm_text">Filter By:
						<select name="SEARCHBY" size="1" class="norm_text">
						  <option value="" <%=searchBy.equals("") ? "selected":""%>>ALL</option>
						  <option value="FIRST_NAME" <%=searchBy.equals("FIRST_NAME") ? "selected":""%>>First Name</option>
						  <option value="LAST_NAME" <%=searchBy.equals("LAST_NAME") ? "selected":""%>>Last Name</option>
						  <option value="EMAIL" <%=searchBy.equals("EMAIL") ? "selected":""%>>Email</option>
						</select>
				  </td>
					<td width="38%" class="norm_text">For: 
				  <input name="SEARCHFOR" type="text" class="norm_text"  value="<%=searchFor%>" size="30" /> </td>
					<td width="18%" colspan="6"><input class="norm_text" type="button" value="Search" onclick="javascript:doSearch(this.form)"/></td>
					
				</tr>
			</table>	
		</td>
	</tr>
	
	<tr>
		<td class="norm_login_text_header">S/N</td>
		<td class="norm_login_text_header">First Name</td>
		<td class="norm_login_text_header">Last Name</td>
		<td class="norm_login_text_header">Email </td>
		<td class="norm_login_text_header">User Type </td>
		<td class="norm_login_text_header">Gender </td>
		<td class="norm_login_text_header">Company </td>
		<td class="norm_login_text_header">Approval<br />Status</td>
		<td class="norm_login_text_header">Date Created</td>
		<td class="norm_text_header"><input name="CheckAll" type="checkbox" class="norm_text" onClick="if (this.checked) {doClickAll(this.form)} else {doUnClickAll(this.form)}" value="ON">&nbsp;<input type="image" src="images/cancel.png" width="18" height="18" border="0" onclick="javascript:doDelete(this.form)" alt="Remove Record(s)"/>
		Lock<br /><input type="image" src="images/analyze.png" width="18" height="18" border="0" onclick="javascript:doPwrdReset(this.form)"/>Pwrd Reset</td>	
		<td class="norm_text_header"><input type="image" src="images/cancel.png" width="18" height="18" border="0" onclick="javascript:doUnlock(this.form)" alt="UnLock User(s)"/>Unlock</td>	
	</tr>
	
	<%
	try{
		resultConStmt = util.listUsers(searchBy, searchFor);
		if(!resultConStmt.isEmpty()){
			rs= (ResultSet)resultConStmt.get(0);
			pstmt= (PreparedStatement)resultConStmt.get(1);
			con= (Connection)resultConStmt.get(2);
			
			skip = maxPage * (Integer.parseInt(pageNo)-1);
			while(skip-- > 0) rs.next();
			
			
			int counter = 0, sno=0;
			
			while(rs.next() && (counter++ < maxPage))
			{			
				++sno;
				sc.setKey();
				String encryptedS = sc.encrypt(rs.getString("USER_ID"));
			
	%>
	<tr class="white_bg_row">
		<td class="norm_text"><%=counter%></td>
		<td class="norm_text" height="30"><a href="adminEditUserNIBSS.jsp?ID=<%=encryptedS%>"><%=rs.getString("FIRST_NAME")%></a></td>
		<td class="norm_text"><%=rs.getString("LAST_NAME")%></td>
		<td class="norm_text"><%=rs.getString("EMAIL")%></td>
		<td class="norm_text"><%=util.getUserType(rs.getString("USER_TYPE"))%></td>
		<td class="norm_text"><%=rs.getString("GENDER")%></td>
		<td class="norm_text"><%=util.getCompanyName(rs.getString("COMPANY_CODE"))%></td>
		<td class="norm_text"><%=util.getAuthStatusName(rs.getString("AUTH_STATUS"))%></td>
		<td class="norm_text"><%=dfmt.format(rs.getTimestamp("DATE_CREATED"))%></td>
		<td valign="middle" nowrap class="norm_text" ><% if (rs.getString("LOCKED").equals("0")){%><input name="C2" type="checkbox" value="<%=rs.getString("USER_ID")%>"/><%}%></td>
		<td class="norm_text"><% if (rs.getString("LOCKED").equals("1")){%><input name="C3" type="checkbox" value="<%=rs.getString("USER_ID")%>"/><%}%></td>
	
	</tr>
	<%	
			}
		}//end of if(!resultConStmt.isEmpty()){
	}catch(Exception e){
		System.out.println("Error occured while listing in View User Listing:::"+e.toString());
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
			System.out.println("Error in closing connections in View User Listing"+e.toString());
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
