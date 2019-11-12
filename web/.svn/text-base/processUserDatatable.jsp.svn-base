<%-- 
    Document   : processDatatable
    Created on : Mar 20, 2013, 1:17:55 PM
    Author     : hakintoye
--%>

<%@page import="org.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<%
com.nibss.asvportal.DatatableUser dda = new com.nibss.asvportal.DatatableUser();
JSONObject result = new JSONObject();
String sStart = request.getParameter("iDisplayStart");
String sAmount = request.getParameter("iDisplayLength");
String sCol = request.getParameter("iSortCol_0");
String sdir = request.getParameter("sSortDir_0");
String SEARCH_TERM = request.getParameter("sSearch");

try{
    result = dda.getTableInfo(sStart, sAmount,sCol,sdir,SEARCH_TERM);
    response.setContentType("application/json");
    response.setHeader("Cache-Control", "no-store");
    
    out.print(result);
}catch(Exception e){
    e.printStackTrace();
}
%>