<%@ page import="java.sql.*,jakarta.servlet.http.HttpSession" %>
<%
	String uid=request.getParameter("uid");
	String email=request.getParameter("email");
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/project","root","root");
	String sql="Select * from user where uid=? and email=?";
	PreparedStatement st=con.prepareStatement(sql);
	st.setString(1,uid);
	st.setString(2,email);
	ResultSet rs=st.executeQuery();
	if(rs.next()){
%>
<!DOCTYPE html>
<html>
<head>
    <title>LOGIN</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="style.css">
  
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script>
    function no() {
        var x = document.getElementsByClassName("name1")[0];
        var y = document.getElementsByClassName("name2")[0];
        if(x.value != y.value) {
            alert("Enter password correctly!");
            y.value = "";
        }
    }
    </script>
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
            <form id="rs_form" action="updateps.jsp">
                <center>
                    <h1 style="color: #303090;">RESET PASSWORD</h1><br>
                    <input type="password" placeholder="Enter new password" name="pwd1" class="name1" required>
                    <input type="hidden" name="uid" value="<%=uid %>" class="name1">
                     <input type="hidden" name="email" value="<%=email %>" class="name1">

                    <br>
                    
                    <br>
                    <input type="password" placeholder="confirm your password" class="name2" name="pwd2"  onblur="no()" required>
                    <br><br><br>
                    
                    <hr><br>
                    <button class="b7" type="submit">RESET</button><br>
				<marquee><h4 style="font-size:10.5pt;">*On Successful Reset you will be redirected to Login page.</h4></marquee>
					
                </div>
                </center>
            </form>
        </div>
    </div>
</body>
</html>
<% } else{
	response.sendRedirect("ivalid.jsp");

}
	%>