<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<%
HttpSession ss = request.getSession(false);
if (ss != null) {
    String uid = (String) ss.getAttribute("uid");
    String pwd = (String) ss.getAttribute("pwd");
    if (uid != null && pwd != null) {
    	 try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/project", "root", "root");
            String sql = "select * from user where uid=? and pwd=?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, uid);
            st.setString(2,pwd);
            ResultSet rs = st.executeQuery();
            while(rs.next()) {
        
%>
<head>
	<input type="hidden" value="<%=rs.getInt("id")%>" name="id">
    <title>BOOKINGS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="style.css">
    <style>
        .table-container {
            width: 100%;
            max-height: 80vh;
            overflow-y: auto;
            padding: 10px 30px;
            font-size: 16pt;
            font-family: Arial, Helvetica, sans-serif;
            margin-top: 20px; /* Adjust the margin as needed */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: none;
            boder:none;
            outline:none;
        }

        th, td {
            border: 1.5px solid black;
            padding: 16px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            color: #050591;
            font-size: 18pt;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        td {
            font-size: 16pt;
            font-weight: bold;
        }

        .header-links a {
            margin-right: 20px;
        }

        .container {
            margin-top: 20px; /* Adjust the margin as needed */
        }
    </style>
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
        <div id="reserve" style="margin-top: 20px;"class="table-container">
            <form id="rs_form" action="updateprofile.jsp">
                <center>
                <input type="hidden" value="<%=rs.getInt("id")%>" name="id">
                    <h1 style="color: #303090;">PROFILE</h1><br>
                    <table>
                        <tr>
                            <td>NAME : </th>
                            <td><%=rs.getString("fname") %> <%=rs.getString("lname") %></th>
                            
                        </tr>
                        
                        <tr>
                            <td>USERNAME : </td>
                            <td><%= rs.getString("uid") %></td>
                            
                        </tr>
                        <tr>
                            <td>EMAIL : </td>
                            <td><%= rs.getString("email") %></td>
                            
                        </tr>
                        <tr>
                            <td>MOBILE : </td>
                            <td><%= rs.getString("number") %></td>
                            
                        </tr>
                        <tr>
                            <td>DOB : </td>
                            <td><%= rs.getString("date") %></td>
                            
                        </tr>
                        <tr>
                            <td>NATIONALITY : </td>
                            <td><%= rs.getString("nationality") %></td>
                            
                        </tr>
                        <tr>
                            <td>GENDER : </td>
                            <td><%= rs.getString("gender") %></td>
                            
                        </tr>
                        <tr>
                        <td colspan="2" style="border:none; outline:none;">
                        <input type="hidden" value="<%=rs.getString("fname") %>" name="fname">
                        <button style="margin-left:150px; font-size:16pt;" type="submit" class="b4" value="Update Profile">Update Profile</button>
                        </td>
                        </tr>
                        
                        <% }
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } %>
                    </table>
                </center>
            </form>
        </div>
    </div>
</body>
 <%
    } else {
        response.sendRedirect("loginnn.html");
    }
} else {
    response.sendRedirect("loginnn.html");
}
  %>
</html>
