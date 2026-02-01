<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.HttpSession" %>
<%@ include file="/WEB-INF/db.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

<%
String uid = request.getParameter("uid");
String pwd = request.getParameter("pwd");

if (uid != null && pwd != null) {

    PreparedStatement stmt = con.prepareStatement(
        "SELECT * FROM user WHERE uid=? AND pwd=?"
    );
    stmt.setString(1, uid);
    stmt.setString(2, pwd);

    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        HttpSession s = request.getSession();
        s.setAttribute("uid", uid);
        response.sendRedirect("home.html");
    } else {
        response.sendRedirect("loginerr.html");
    }

    rs.close();
    stmt.close();
    con.close();
}
%>

</body>
</html>
