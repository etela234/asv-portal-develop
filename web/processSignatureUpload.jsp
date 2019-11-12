<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import ="java.net.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/user_home_template.dwt.jsp" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/disableClick.js"></script>

<!-- InstanceBeginEditable name="doctitle" -->
<title>.::Welcome to NIBSS Report Engine::.</title>
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
<%

System.out.println("Inside Process Signature Upload::::::");

String FIRST_NAME="";
String MIDDLE_NAME="";
String LAST_NAME="";
String CATEGORY_CODE="";
String CATEGORY_NUM="";
String SERIAL_NUM="";
String DESIGNATION="";
String SIGNATORY_ID="";

long fileSize=0;
int uploadStatus=0;
int result = 0;

String absoluteDiskPath="";
String itemName = ""; 
String strFileName = ""; 
String ipAddress = request.getRemoteAddr();
String newFile = "";

try{
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (!isMultipart) {

 } else {
 	   FileItemFactory factory = new DiskFileItemFactory();
	   ServletFileUpload upload = new ServletFileUpload(factory);
	   List items = null;
	   try {
	   		items = upload.parseRequest(request);
	   } catch (FileUploadException e) {
	   		e.printStackTrace();
	   }
	   Iterator itr = items.iterator();
	   while (itr.hasNext()) 
	   {
		   System.out.println("Inside While Loop::::::");
		   FileItem item = (FileItem) itr.next();
		   if (item.isFormField())
		   {
				String name = item.getFieldName();
				String value = item.getString();
				if(name.equals("FIRST_NAME"))
				{
				  FIRST_NAME=value;	
				  if(FIRST_NAME==null)
				  	FIRST_NAME="";				   
				}
				if(name.equals("MIDDLE_NAME"))
				{
				  MIDDLE_NAME=value;
				  if(MIDDLE_NAME==null)
				  	MIDDLE_NAME="";					   
				}
				if(name.equals("LAST_NAME"))
				{
				  LAST_NAME=value;	
				  if(LAST_NAME==null)
				  	LAST_NAME="";				   
				}
				if(name.equals("CATEGORY_CODE"))
				{
				  CATEGORY_CODE=value;
				  if(CATEGORY_CODE==null)
				  	CATEGORY_CODE="";					   
				}
				if(name.equals("CATEGORY_NUM"))
				{
				  CATEGORY_NUM=value;	
				  if(CATEGORY_NUM==null)
				  	CATEGORY_NUM="";				   
				}
				if(name.equals("SERIAL_NUM"))
				{
				  SERIAL_NUM=value;
				  if(SERIAL_NUM==null)
				  	SERIAL_NUM="";					   
				}
				if(name.equals("DESIGNATION"))
				{
				  DESIGNATION=value;
				  if(DESIGNATION==null)
				  	DESIGNATION="";					   
				}
				if(name.equals("SIGNATORY_ID"))
				{
				  SIGNATORY_ID=value;
				  if(SIGNATORY_ID==null)
				  	SIGNATORY_ID="";					   
				}
		   } else
		   {
				try {
					System.out.println("Inside fileupload Loop::::::");
					String fullPath="", path="";
					itemName = item.getName();
					
					if (!itemName.equals("")){ // no file uploaded
						fileSize = item.getSize();
						System.out.println("File Size is : "+fileSize);
						strFileName = CATEGORY_CODE+CATEGORY_NUM+SERIAL_NUM+"_"+itemName;
						newFile = itemName.substring(0,itemName.lastIndexOf("."));
						path = "/Uploads/Signatures/"+strFileName;
						absoluteDiskPath = getServletContext().getRealPath(path);
						
						File file = new File(absoluteDiskPath);
						item.write(file);
						uploadStatus = 1;
						System.out.println(EMAIL+":::FILE DUMPED IN : "+absoluteDiskPath);
					}
					
			   } catch (Exception e) {
			   		e.printStackTrace();
					
			   }
		   }
	   }
	   	if (newFile.equals(CATEGORY_NUM.trim())){
	   		result = util.insertSignatureUpload(USER_ID,strFileName,FIRST_NAME,MIDDLE_NAME,LAST_NAME, CATEGORY_CODE,CATEGORY_NUM, SERIAL_NUM, DESIGNATION, SIGNATORY_ID, request);
		}else{
			result = -1;
		}
   }// end of if else (Multipath)
}catch(Exception e){	
	System.out.println("Error occurred during upload of file ::::"+e.toString());
	e.printStackTrace();
}

if(result > 0){
%>
<div align="center">
<img src="images/successful_upload.png"/>
</div>
<%
}else if(result == -1){
%>
<div align="center">
<img src="images/mismatch_signature_upload.png"/>
</div>
<%
}else if (result == -2){
%>
<div align="center">
<img src="images/duplicate_signature_upload.png" />
</div>
<%
}else{
%>
<div align="center">
<img src="images/unsuccessful_upload.png" />
</div>
<%
}
%>					  <!-- InstanceEndEditable -->				
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
