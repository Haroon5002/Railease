<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="WEB-INF/db.jsp" %>

<html>
<%
try {

    String train_name = request.getParameter("trainname");
    String depart_time = request.getParameter("depart_time");
    String source = request.getParameter("source");
    String date = request.getParameter("date");
    String journey_time = request.getParameter("journey_time");
    String arrive_time = request.getParameter("arrive_time");
    String destination = request.getParameter("destination");
    String classs = request.getParameter("class");  
    String ticket = request.getParameter("ticket");
    String price = request.getParameter("price");
    String seatno = request.getParameter("seatno");
    String main = request.getParameter("main");
    String passenger_name = request.getParameter("passenger_name");
    String passenger_age = request.getParameter("passenger_age");


    String sql = "INSERT INTO booking(train_name, depart_time, source, date, journey_time, arrive_time, destination, class, ticket, price, seatno, passenger_name, passenger_age) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, train_name);
    ps.setString(2, depart_time);
    ps.setString(3, source);
    ps.setString(4, date);
    ps.setString(5, journey_time);
    ps.setString(6, arrive_time);
    ps.setString(7, destination);
    ps.setString(8, classs);
    ps.setString(9, ticket);
    ps.setString(10, price);
    ps.setString(11, seatno);
    ps.setString(12, passenger_name);
    ps.setString(13, passenger_age);

    int r = ps.executeUpdate();

    if (r > 0) {
        String clas = "";
        if (main.equals("sl")) {
            clas = "sleeper_capacity";
        } else if (main.equals("3a")) {
            clas = "3a_capacity";
        } else if (main.equals("2a")) {
            clas = "2a_capacity";
        } else if (main.equals("1a")) {
            clas = "1a_capacity";
        } else if (main.equals("2s")) {
            clas = "2s_capacity";
        } else {
            clas = "cc_capacity";
        }

        String sqll = "UPDATE train SET " + clas + " = " + clas + " - 1 WHERE source=? AND destination=? AND arrive_time=? AND depart_time=?";
        PreparedStatement sp = con.prepareStatement(sqll);
        sp.setString(1, source);
        sp.setString(2, destination);
        sp.setString(3, arrive_time);
        sp.setString(4, depart_time);
        sp.executeUpdate();
    }

    String sql2 = "SELECT booking_id FROM booking WHERE source=? AND destination=? AND date=? AND passenger_name=? AND passenger_age=? AND class=?";
    PreparedStatement stmt = con.prepareStatement(sql2);
    stmt.setString(1, source);
    stmt.setString(2, destination);
    stmt.setString(3, date);
    stmt.setString(4, passenger_name);
    stmt.setString(5, passenger_age);
    stmt.setString(6, classs);
    ResultSet rs = stmt.executeQuery();
%>
<head>
    <title>BOOK TICKET</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
</head>
<body>
    <div class="container">
        <img src="images/save.jpg" class="bgimage"><br><br>
        <form class="header">
            <img src="images/ti.webp" class="trainimage">
            <a href="home.html">
                <i class="fa fa-home" style="font-size:33px"></i>
            </a>
            <a href="login.html" class="b4">Login</a>
            <a href="register.html" class="b2">Register</a>
            <a href="bookings.jsp" class="b2">Bookings</a>
            <a href="contact.html" class="b2">Contact Us</a> 
            <a href="profile.jsp" class="b2">My Profile</a>
             <a href="logo.jsp" class="b2">Logout</a>
            <button class="b3"></button>
        </form>
        <script>
            $(document).ready(function() {
                $('#dateInput').flatpickr({
                    dateFormat: "d-m-Y", // Set the date format
                });
            });
        </script>
        <div id="bookshow">
            <form id="rs_form" action="showticket.jsp" method="post">
                <br>
                <center>
                <% while (rs.next()) { %>
                    <input type="hidden" value="<%= rs.getInt("booking_id") %>" name="booking_id">
                <% } %>
                <h2>Your Ticket has been Booked Successfully </h2>
                <span style='font-size:40px;'>&#9989;</span><br>
                <h2>Wishing you a happy and safe journey! </h2>
                </center>
                <input type="submit" style="width:170px; height:40px; margin-bottom:-10px; margin-top:30px; margin-left:-5px;" value="SHOW TICKET" class="b4"> 
                <a href="home.html" style="font-size: 12pt; width:170px; height:40px; margin-left:510px; margin-top:-30px; text-decoration:none; font-family: Arial, Helvetica, sans-serif;" class="b1">HOME</a>
            </form>
        </div>
    </div>
</body>
</html>
<%
} catch (Exception e) {
    out.println(e);
}
%>
