<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<html>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/project", "root", "root");
    String id = request.getParameter("booking_id");
    String sql = "select * from booking where booking_id=?";
    PreparedStatement stmt = con.prepareStatement(sql);
    stmt.setString(1, id);
    ResultSet rs = stmt.executeQuery();
%>
<head>
    <title>SHOW TICKET</title>
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

            function downloadTicket() {
                const { jsPDF } = window.jspdf;
                const doc = new jsPDF();

              
                doc.setFontSize(16);
                doc.text("E-Ticket", 80, 10);

                const startX = 10; 
                const startY = 30; 
                const lineSpacing = 10; 

                let currentY = startY;

              
                doc.setFontSize(14);
                doc.setFont("helvetica", "bold");
                doc.text( document.getElementById('trainname').value, startX, currentY);
                doc.setFont("helvetica", "normal");
                currentY += lineSpacing;
              
                
                doc.setFont("helvetica", "bold");
                doc.setFontSize(12);
                doc.text( document.getElementById('depart_time').value, startX, currentY);
                
                doc.text( "|", startX+17, currentY);
                doc.setFont("helvetica", "normal");
                doc.text( document.getElementById('source').value, startX+18, currentY);
            
                doc.text(document.getElementById('journey_time').value, startX+75, currentY);
                doc.setFont("helvetica", "bold");
                
                doc.text(document.getElementById('arrive_time').value, startX +130, currentY);
                doc.text( "|", startX+147, currentY);
                doc.setFont("helvetica", "normal");
                doc.text(document.getElementById('destination').value, startX+148, currentY);
                currentY += lineSpacing;
                doc.text("Date of Journey : "+ document.getElementById('date').value, startX, currentY);
                currentY += lineSpacing;
                doc.text("Passenger : " + document.getElementById('passenger_name').value, startX, currentY);
                doc.text( document.getElementById('passenger_age').value, startX + 50, currentY);
                currentY += lineSpacing;
                doc.text("Boarding : " + document.getElementById('boarding').value, startX, currentY);
                currentY += lineSpacing;
                doc.text( document.getElementById('class').value, startX, currentY);
                currentY += lineSpacing;
                doc.text("Seat No : " + document.getElementById('seatno').value, startX, currentY);
                currentY += lineSpacing;
                currentY += lineSpacing;
                doc.setFontSize(15);
                doc.setFont("helvetica", "bold");
                doc.text("For any queries contact 139", startX, currentY);
                
                doc.save("ticket.pdf");
            }


        </script>
        <div id="registershow">
            <form id="rs_form" action="bookticket.jsp" method="post">
                <div class="train_header">
                    <input type="button" class="b30" value="YOUR TICKET">
                </div>
                <br>
                <center>
                    <div id="ticketDetails" class="train_details">
                        <div class="train1">
                            <table border="1">
                                <% while(rs.next()){ %>
                                <tr>
                                    <th>
                                        <input id="trainname" type="text" style="width:320px; border: none; font-size:16pt; font-weight:bold; margin-left:-13px;" value="<%= rs.getString("train_name") %>" name="trainname" readonly>
                                    </th>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="train_left">
                                            <input id="depart_time" type="time" value="<%= rs.getString("depart_time") %>" name="depart_time" readonly class="time">
                                            <label for="train_left" class="line">|</label>
                                            <input id="source" type="text" value="<%= rs.getString("source") %>" name="source" readonly class="station">
                                            <input id="date" type="text" value="<%= rs.getString("date") %>" readonly name="date" class="dates">
                                        </div>
                                        <div class="train_middle">
                                            <h3><input id="journey_time" type="text" name="journey_time" value="-----<%= rs.getString("journey_time") %>-----" readonly></h3>
                                        </div>
                                        <div class="train_right">
                                            <input id="arrive_time" type="time" value="<%= rs.getString("arrive_time") %>" name="arrive_time" readonly>
                                            <label for="train_right" class="line">|</label>
                                            <input id="destination" type="text" value="<%= rs.getString("destination") %>" readonly name="destination" class="station2">
                                            <input id="date2" type="text" value="<%= rs.getString("date") %>" readonly class="dates">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input readonly type="text" value="PASSENGER : " name="req" style="width:135px; border:none; outline:none; font-size:15pt; font-weight:bold; opacity:100%;">&nbsp;
                                        <input id="passenger_name" type="text" name="passenger_name" value="<%= rs.getString("passenger_name") %>" style="margin-left:-11px; width:390px; border:none; outline:none; font-size:17pt; font-weight:bold; opacity:100%;" readonly>
                                        &nbsp;&nbsp;
                                        <input id="passenger_age" type="text" name="passenger_age" value="<%= rs.getString("passenger_age") %> M" style="margin-left:-270px; width:auto; border:none; outline:none; font-size:19pt; font-weight:bold; opacity:100%;" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input readonly type="text" value="BOARDING : " name="req" style="width:135px; border:none; outline:none; font-size:15pt; font-weight:bold; opacity:100%;">&nbsp;
                                        <input id="boarding" type="text" name="boarding" value="<%= rs.getString("source") %>" style="margin-left:-17px; width:auto; border:none; outline:none; font-size:17pt; font-weight:bold; opacity:100%;" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input readonly type="hidden" value="CLASS : " name="req" style="width:175px; border:none; outline:none; font-size:15pt; font-weight:bold; opacity:100%;">&nbsp;
                                        <input id="class" type="text" name="class" value="<%= rs.getString("class") %>" style="width:800px;margin-left:-9px; width:auto; border:none; outline:none; font-size:17pt; font-weight:bold; opacity:100%;" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input readonly type="text" value="SEAT NO : " name="req" style="width:135px; border:none; outline:none; font-size:15pt; font-weight:bold; opacity:100%;">&nbsp;
                                        <input id="seatno" type="text" name="seatno" value="<%= rs.getString("seatno") %>" style="margin-left:-17px; width:auto; border:none; outline:none; font-size:17pt; font-weight:bold; opacity:100%;" readonly>
                                    </td>
                                </tr>
                                <% } %>
                                <tr>
                                    <td>
                                        <br><div class="train_header">
                                            <button type="button" class="b2" onclick="downloadTicket()" style="margin-top:-17px; padding: 10px 20px; background-color:#F53E2F">DOWNLOAD TICKET</button>
                                            <br>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <br>
                                </tr>
                            </table>
                        </div>
                    </div>
                </center>
            </form>
        </div>
    </div>
</body>
<%
} catch (Exception e) {
    e.printStackTrace();
}
%>
</html>
