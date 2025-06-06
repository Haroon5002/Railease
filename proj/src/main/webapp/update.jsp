<%@ page import="java.sql.*" %>
<%
String id=request.getParameter("id");
	try {
    	Class.forName("com.mysql.jdbc.Driver");
    	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/login","root","root");
    	String sql = "select * from users where id='"+ id +"'";
    	PreparedStatement stmt= con.prepareStatement(sql);
    	ResultSet rs = stmt.executeQuery();
    	if (rs.next()) {
%>
<html>
<head>
    <title>Update</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
   
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
</head>
<body>
    <div class="container">
        <img src="images/vb.png" class="bgimage"><br><br>
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
        <div id="register">
            <form id="rs_form" action="update-p.jsp">
                <center>
                    <h1 style="color: #303090;">UPDATE ACCOUNT</h1><br>
                    <input type="hidden" name="id" value="<%=rs.getString("id") %>"/>
                    
                    <input type="text" placeholder="First name" class="name1" name="fname" value="<%=rs.getString("fname") %>" required>
                    <input type="text" placeholder="Last name" class="ip" name="lname" value="<%=rs.getString("lname") %>" required>
                    
                   
                    <br><br>
                    <input type="password" placeholder="Password" class="name2" name="pwd" value="<%=rs.getString("pwd")%>"onblur="no()">
                    <input type="password" placeholder="Confirm password" class="ip" onblur="no()">
                    <br>
                    <br>
                    <input type="text" placeholder="Enter Prefered Username" name="uid" value="<%=rs.getString("uid")%>" class="name1" required>
                    <input type="text"  id="dateInput" class="ip" placeholder="Date of birth">
                    <br><br>
                    <input type="email" class="name2" placeholder="Email" name="email" value="<%=rs.getString("email")%>" required>
                    <input type="tel" class="name3" value="+91" disabled>
                    <input type="number" class="ip" placeholder="Number">
                    <br><br>
                    <select name="Nationality" class="gp">
                        <option>INDIAN</option>
                        <option>AMERICAN</option>
                        <option>EUROPIAN</option>
                        <option>CHINEESE</option>
                        <option>JAPANEESE</option>
                       
                    </select>
                    <div class="d3">
                        <h3>Gender : <input type="radio">Male
                                 <input type="radio">Female</h3>
                    </div>
                    <br>
                    <div class="pass">
                        
                        Already have an account? <a href="login.html" class="lf">Login</a><br>
                    </div>
                    <hr><br><br>
                    <button class="b7" type="submit">Update</button><br>
                   
                </div>
                </center>
            </form>
        </div>
    </div>
</body>
</html>
<%
    	}
    	con.close();
	} catch (Exception e) {
    	e.printStackTrace();
	}
%>
