<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="WEB-INF/db.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Process</title>
    <script>
      
    </script>
</head>
<body>
<% 
    String firstName = request.getParameter("fname");
    String lastName = request.getParameter("lname");
    String email = request.getParameter("email");
    String userid = request.getParameter("uid");
    String password = request.getParameter("pwd");
    String dob = request.getParameter("date");
    String num = request.getParameter("number");
    String nationality = request.getParameter("Nationality");
    String gender = request.getParameter("gender");

    try {
        // Set up the database connection

        // Check if the username already exists
        String s1 = "SELECT * FROM user WHERE uid=?";
        PreparedStatement ps = conn.prepareStatement(s1);
        ps.setString(1, userid);
        ResultSet r = ps.executeQuery();
        if (r.next()) {
            // Username already exists, redirect with error message
            response.sendRedirect("register.html?error=Username Already exists");
        } else {
            // Prepare the SQL statement for insertion
            String sql = "INSERT INTO user (fname, lname, pwd, uid, date, email, nationality, gender, number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, password);
            stmt.setString(4, userid);
            stmt.setString(5, dob);
            stmt.setString(6, email);
            stmt.setString(7, nationality);
            stmt.setString(8, gender);
            stmt.setString(9, num);

            // Execute the SQL statement
            stmt.executeUpdate();

            // Redirect to the login page on successful registration
            response.sendRedirect("login.html");
        }
    } catch (Exception e) {
        // Display an error message
        out.println("<h1>Error Occurred</h1>");
    }
%>