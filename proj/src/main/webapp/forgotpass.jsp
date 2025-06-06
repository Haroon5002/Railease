<!DOCTYPE html>
<html>
<head>
    <title>LOGIN</title>
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
             <a href="logo.jsp" class="b2">Logout</a>
            <button class="b3"></button>
        </form>
        <div id="login">
            <form id="rs_form" action="fpp.jsp">
                <center>
                    <h1 style="color: #303090;">FORGOT PASSWORD?</h1><br>
                    <input type="text" placeholder="Enter your username" name="uid" class="name1" required>
                    
                    <br>
                    
                    <br>
                    <input type="email" placeholder="Enter your registered email" class="name2" name="email" required>
                    <br><br><br>
                    
                    <hr><br>
                    <button class="b7" type="submit">Reset Password</button><br>

                </div>
                </center>
            </form>
        </div>
    </div>
</body>
</html>
