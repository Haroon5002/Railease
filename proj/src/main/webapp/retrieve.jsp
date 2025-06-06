<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String id = request.getParameter("id");
try {
Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
%>
<html>
<body>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<h1><center>Display values</center></h1>
 
<table border="1">
<tr>
<td>ID</td>
<td>First Name</td>
<td>Last Name</td>
<td>Email ID</td>
<td>User ID</td>
<td>Password</td>
<td>Update</td>
<td>Delete</td>
</tr>
 
<%
try{
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/login","root","root");

String sql ="select * from users";
PreparedStatement statement=con.prepareStatement(sql);
ResultSet resultSet = statement.executeQuery();
while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("id") %></td>
<td><%=resultSet.getString("fname") %></td>
<td><%=resultSet.getString("lname") %></td>
<td><%=resultSet.getString("email") %></td>
<td><%=resultSet.getString("uid") %></td>
<td><%=resultSet.getString("pwd") %></td>
<td><a href="update.jsp?id=<%=resultSet.getString("id")%>">Update</a></td>
<td><a href="delete.jsp?id=<%=resultSet.getString("id")%>">Delete</a></td>
</tr>
<%
}
con.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
</body>
</html>
