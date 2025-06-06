<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking Cancellation</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="style.css">
</head>
<body>
<%
try {
    String id = request.getParameter("booking_id");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/project", "root", "root");
    
    String sql1 = "delete from booking where booking_id=?";
    PreparedStatement p = con.prepareStatement(sql1);
    p.setString(1, id);
    int rowsDeleted = p.executeUpdate();
    
    if (rowsDeleted > 0) {
    	  String sqlMaxId = "SELECT MAX(booking_id) AS max_id FROM booking";
          PreparedStatement psMax = con.prepareStatement(sqlMaxId);
          ResultSet rsMax = psMax.executeQuery();
          
          int maxId = 0;
          if (rsMax.next()) {
              maxId = rsMax.getInt("max_id");
          }
          
          // Set the AUTO_INCREMENT to max_id + 1
          String sql2 = "ALTER TABLE booking AUTO_INCREMENT = ?";
          PreparedStatement ps = con.prepareStatement(sql2);
          ps.setInt(1, maxId + 1);
          ps.executeUpdate();
    } else {
        out.println("<h2>Failed to delete the booking.</h2>");
    }
%>
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
       
        <div id="bookshow">
            <form id="rs_form">
                <br>
                <center>  
                    <h2>Your Ticket has been Cancelled Successfully </h2>
                    <span style='font-size:40px;'>&#9989;</span><br>
                    <h2> Thank You </h2>
                </center>
                <a href="bookings.jsp" style="text-align:center; font-size:15pt; margin-bottom:-3px; margin-left:270px;width:170px; height:30px; margin-top:20px; padding:10px 10px; text-decoration:none; font-family: Arial, Helvetica, sans-serif;" class="b4">BOOKINGS</a>
                
            </form>
        </div>
    </div>
<%
} catch (Exception e) {
    out.println("<h2>An error occurred while cancelling the booking. Please try again.</h2>");
    e.printStackTrace();
}
%>
</body>
</html>
