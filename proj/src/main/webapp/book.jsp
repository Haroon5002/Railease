<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<html>
<script>
function valid() {
    var phoneNumber = document.getElementById('phoneNumber').value;
    
    if (phoneNumber.length !== 10) {
			alert("Phone Number Must Be 10-digits");
    } 
}
 
</script>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/project", "root", "root");
    String id = request.getParameter("inputid");
    String train_id = request.getParameter("train_id");
    String classs = request.getParameter("class");
    String price = request.getParameter("price");
    String seatno = request.getParameter("seatno");
    String seats = request.getParameter("seats");
    String main=request.getParameter("main");
    
    String sql1 = "SELECT * FROM user_input WHERE id=?";
    PreparedStatement stmt = con.prepareStatement(sql1);
    stmt.setString(1, id);
    ResultSet rp = stmt.executeQuery();

    if (rp.next()) {
        String source = rp.getString("source");
        String destination = rp.getString("destination");
        String date = rp.getString("date");

        String sql2 = "SELECT * FROM train WHERE source=? AND destination=? AND train_id=?";
        PreparedStatement p = con.prepareStatement(sql2);
        p.setString(1, source);
        p.setString(2, destination);
        p.setString(3, train_id);
        ResultSet rs = p.executeQuery();
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
        <div id="registershow">
            <form id="rs_form" action="bookticket.jsp" method="post">
                <div class="train_header">
                    <input type="button" class="b30" value="BOOKING DETAILS">
                </div>
                <br>
                <center>
                    <div id="ticketDetails" class="train_details">
                        <div class="train1">
                            <table border="1">
                                <tr>
                                    <th><% 
                                    		String s="select * from trains where train_id=?";
                                    		PreparedStatement pp=con.prepareStatement(s);
                                    		pp.setString(1,train_id);
                                    		ResultSet ra=pp.executeQuery();
                                    		if(ra.next()){
                                    	%>
                                        <input type="text" style=" width:320px; border: none; font-size:16pt; font-weight:bold; margin-left:-13px;" value="<%= ra.getString("train_name") %>" name="trainname">
                                        <% } %>
                                    </th>
                                </tr>
                                <tr>
                                    <td>
                                        <%
                                        while (rs.next()) {
                                        %>
                                        <div class="train_left">
                                            <input type="time" value="<%= rs.getString("depart_time") %>" name="depart_time" readonly class="time">
                                            <label for="train_left" class="line">|</label>
                                            <input type="text" value="<%= rs.getString("source") %>" name="source" readonly class="station">
                                            <input type="text" value="<%= date %>" readonly name="date" class="dates">
                                        </div>
                                        <div class="train_middle">
                                            <h3><input type="text" name="journey_time"  value="-----<%= rs.getString("journey_time") %>-----"></h3>
                                        </div>
                                        <div class="train_right">
                                            <input type="time" value="<%= rs.getString("arrive_time") %>" name="arrive_time" readonly>
                                            <label for="train_right" class="line">|</label>
                                            <input type="text" value="<%= rs.getString("destination") %>" readonly name="destination" class="station2">
                                            <input type="text" value="<%= date %>" readonly class="dates">
                                        </div>
                                        <%
                                        }
                                        }
                                        %>
                                    </td>
                                </tr>
                                <tr><td>
                                	<input readonly type="text" value="CLASS :         <%=classs %>" name="class" style="width:275px; border:none ; outline:none ; font-size:14pt; font-weight:bold; opacity:140%; ">
                                	<input readonly type="text" value="AVAILABLE-<%=seats %>" name="ticket"  style="margin-left:-35px; color:green; width:auto; border:none ; outline:none ; font-size:14pt; font-weight:bold; opacity:90%;">
                                	</td>
                                </tr>
                                <tr>
                                	<td>
                                	<input type="text" value="PRICE : <%=price %>" name="price"  readonly style="width:auto; border:none ; outline:none ; font-size:14pt; font-weight:bold; opacity:100%;">
                                	<input type="hidden" value="<%=seatno %>" name="seatno"> 
                                	<input type="hidden" name="main" value="<%=main %>">   
                                	</td>
                                </tr>
                                <tr>
                                	<td>
                                	<input disabled type="text" value="ENTER PASSENGER DETAILS : " name="req" style="color:#050591 ;width:295px; border:none ; outline:none ; font-size:14pt; font-weight:bold; opacity:140%; ">
                                	</td>
                                </tr>
                                <tr><td>
                                	<input type="text" name="passenger_name" placeholder="Enter passenger name" style="margin-left:30px" required>
                                </td></tr>
                                <tr>
                                	<td>
                                		<br><input type="text" name="passenger_mobileno" id="phoneNumber" onblur="valid()" placeholder="Enter 10-Digit passenger Mobileno" style="margin-left:30px" required>
                                	</td>
                                </tr>
                                <tr>
                                	<td>
                                		<br><input type="text" name="passenger_age" placeholder="Enter passenger Age" style="margin-left:30px" required>
                                	</td>
                                </tr>
                                <tr>
                                	<td>
                                		<br>
                                		<button style="margin-left:110px; margin-up:10px;" type="submit" value="BOOK TICKET" class="b4">BOOK TICKET</button>
                                	</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </center>
            </form>
        </div>
    </div>
    
</body>
</html>
<%
}
catch (Exception e) {
    out.println(e);
}
%>
