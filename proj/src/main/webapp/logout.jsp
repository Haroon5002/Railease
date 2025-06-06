<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.sql.*, java.util.*, jakarta.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% HttpSession ss = request.getSession(false);
if(ss!=null){
	ss.invalidate();
}
response.sendRedirect("login.html");
 %>
</body>
</html>