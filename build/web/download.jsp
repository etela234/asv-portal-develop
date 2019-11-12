<%@page contentType="application/octet-stream"%>
<%@page pageEncoding="UTF-8"%>
<%@ page language="java" import="java.io.*,java.net.*,java.util.*,javax.servlet.* "%>
<%@ page import="java.io.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Downloading...</title>
</head>
<body>
<%
String fName = request.getParameter("fName");
if(fName==null) fName="";



BufferedInputStream filein = null;
BufferedOutputStream outputs = null;
String sql="";


try {
	
	
	String path = "C:\\SignatureAppUploads\\Exceptions\\"+fName;
	//String absoluteDiskPath = getServletContext().getRealPath(path);
	File file = new File(path);
	byte b[] = new byte[2048];
	int len = 0;
	try{
		filein = new BufferedInputStream(new FileInputStream(file));
		outputs = new BufferedOutputStream(response.getOutputStream());
	}catch(Exception e){
		e.printStackTrace();
	}
	response.setHeader("Content-Length", ""+file.length());
	response.setContentType("application/force-download");
	response.setHeader("Content-Disposition","attachment;filename="+fName);
	response.setHeader("Content-Transfer-Encoding", "binary");
	while ((len = filein.read(b)) > 0) {
		outputs.write(b, 0, len);
		outputs.flush();
	}
}catch(Exception e){
	System.out.println("Error occurred while downloading file:::"+e.toString());
}
%>
</body>
</html>

