<%@ page import="java.sql.*,jakarta.servlet.http.HttpSession" %>
<%@ include file="WEB-INF/db.jsp" %>

<% 
	HttpSession ss=request.getSession(false);
	if(ss!=null){
		String uid=(String)ss.getAttribute("uid");
		String pwd=(String)ss.getAttribute("pwd");
		if(uid!=null && pwd!=null){
		

%>
<!DOCTYPE html>
<html>
<head>
    <title>BOOKINGS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="style.css">
    <style>
        .table-container {
            width: 100%;
            max-height: 80vh;
            overflow-y: auto;
            padding: 10px 40px;
            font-size: 16pt;
            font-family: Arial, Helvetica, sans-serif;
            margin-top: 10px; 
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: auto;
        }

        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
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
            font-size: 14pt;
            font-weight: bold;
        }

        .header-links a {
            margin-right: 20px;
        }

        .container {
            margin-top: 10px; 
        }
        .a:hover {
    	background-color: #0056b3;
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
        <div id="reserve" class="table-container">
            <form id="rs_form" action="verify.jsp">
                <center>
                    <h1 style="color: #303090;">YOUR BOOKINGS</h1><br>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>TRAIN</th>
                            <th>DOJ</th>
                            <th>TICKET</th>
                            <th>CANCEL</th>
                        </tr>
                        <% try {
                         
                            String sql = "select * from booking";
                            PreparedStatement statement = con.prepareStatement(sql);
                            ResultSet resultSet = statement.executeQuery();
                            while(resultSet.next()) {
                        %>
                        <tr>
                            <td><%= resultSet.getString("booking_id") %></td>
                            <td><%= resultSet.getString("train_name") %></td>
                            <td><%= resultSet.getString("date") %></td>
                            <td><a href="showticket.jsp?booking_id=<%= resultSet.getString("booking_id") %>" style="padding:4px 8px; font-size:12pt; background-color:#050591; color: white ;text-decoration:none; border-radius:7px; " >SHOW</a></td>
                            <td><a href="cancelticket.jsp?booking_id=<%= resultSet.getString("booking_id") %>" style="padding:4px 9px; font-size:12pt; background-color:#ff0800; color: white ;text-decoration:none; border-radius:7px; " >CANCEL</a></td>
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
</html>
<% 
		} else{
			response.sendRedirect("loginnn.html");
		} }
	else{
		response.sendRedirect("loginnn.html");
	}
%>
