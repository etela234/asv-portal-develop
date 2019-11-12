<%-- 
    Document   : processDatatable
    Created on : Mar 20, 2013, 1:17:55 PM
    Author     : hakintoye
--%>

<%@page import="org.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<%
String ROLE = (String) session.getAttribute("ROLE");
if(ROLE==null)ROLE="";
String USER_ID = (String) session.getAttribute("USER_ID");
if(USER_ID==null)USER_ID="";

System.out.println("USER ROLE ACCESSING AUDIT::"+ROLE+",:::USER_ID::"+USER_ID);

com.nibss.asvportal.DatatableAudit dda = new com.nibss.asvportal.DatatableAudit();
JSONObject result = new JSONObject();
String sStart = request.getParameter("iDisplayStart");
String sAmount = request.getParameter("iDisplayLength");
String sCol = request.getParameter("iSortCol_0");
String sdir = request.getParameter("sSortDir_0");
String SEARCH_TERM = request.getParameter("sSearch");

String start_date = request.getParameter("start_date");
String end_date = request.getParameter("end_date");

System.out.println("start_date::::"+start_date);
System.out.println("end_date::::"+end_date);

try{
    result = dda.getTableInfo(sStart, sAmount,sCol,sdir,SEARCH_TERM, USER_ID, ROLE, start_date, end_date);
    response.setContentType("application/json");
    response.setHeader("Cache-Control", "no-store");
    
    out.print(result);
}catch(Exception e){
    e.printStackTrace();
}
%>