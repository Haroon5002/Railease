<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession s = request.getSession(false);
if (s != null) {
	 String uid = (String) s.getAttribute("uid");
	    String pwd = (String) s.getAttribute("pwd");
	    if (uid != null && pwd != null) {
%>
<!DOCTYPE html>
<html>
<head>
    <title>LOGOUT</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="style.css">
  
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            <a href="confirmLogout.jsp" class="b2">Logout</a>
            <button class="b3"></button>
        </form>
        <div id="login">
            <form id="rs_form" action="logout.jsp" method="post">
                <center>
                    <h1 style="color: #303090;">LOGOUT</h1><br>
                    <h2 style="font-size:20pt; font-weight:bold; font-family: Arial, Helvetica, sans-serif; margin-top:-3px;">Do you want to Logout?</h2>
                    <hr>
                    <input type="submit" style="width:170px; height:44px; margin-bottom:-10px; margin-top:30px; margin-left:-5px; font-size:16pt;" value="Logout" class="b4"> 
                    <br><br>
                    <marquee><h4 style="font-size:11.5pt;">*On Logout you will be redirected to Login page.</h4></marquee>
                </center>
            </form>
        </div>
    </div>
</body>
</html>
<%    
		
    } else { 
        response.sendRedirect("loginnn.html");
    } }
	    else{
	    }
	    
%>
