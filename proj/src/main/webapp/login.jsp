<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
<%@ include file="WEB-INF/db.jsp" %>

<%@page import="java.sql.*, java.util.*, jakarta.servlet.http.HttpSession"%>

<%
String uid = request.getParameter("uid");
String pwd = request.getParameter("pwd");

if (uid != null && pwd != null) {
   
    // Use a prepared statement with parameterized query to prevent SQL injection
    PreparedStatement stmt = con.prepareStatement("SELECT * FROM user WHERE uid=? AND pwd=?");
    stmt.setString(1, uid);
    stmt.setString(2, pwd);
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        // User is authenticated, set session attributes
        HttpSession s = request.getSession(); // Explicitly get the session object
        s.setAttribute("uid", uid);
        s.setAttribute("pwd", pwd);
        response.sendRedirect("home.html");
    } else {
        // User is not authenticated
        response.sendRedirect("loginerr.html");
    }

    rs.close();
    stmt.close();
} else {
    // Show the login form if uid or pwd is not provided
%>
    
<%
}
%>

</body>
</html>
