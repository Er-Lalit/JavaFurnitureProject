<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="connection.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    
<%
try{
	Connection connection = DbConnection.getConnection();
	String sql="select * from states where country='"+request.getParameter("country")+"'";
	Statement ps=connection.createStatement();
	ResultSet rs=ps.executeQuery(sql);
	while(rs.next()){
		%>
		<option value='<=%rs.getString("states")%>'><%=rs.getString("states")%></option>
	<%}
	
}
catch(Exception e){
	System.out.println(e.getMessage());
	
}
%>