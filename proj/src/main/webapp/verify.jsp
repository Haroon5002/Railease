<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection,jakarta.servlet.http.HttpSession"%>
<html>
<% 
HttpSession ss = request.getSession(false);
if (ss != null) {
    String uid = (String) ss.getAttribute("uid");
    String pwd = (String) ss.getAttribute("pwd");
    if (uid != null && pwd != null) {
try{
	
	Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/project", "root", "root");    
    String source = request.getParameter("source");
    String dest = request.getParameter("destination");
    String date = request.getParameter("doj");
	String classes=request.getParameter("classes");
	String sql="insert into user_input(source,destination,date,classes) values(?,?,?,?)";
	PreparedStatement s=con.prepareStatement(sql);
	s.setString(1,source);
	s.setString(2,dest);
	s.setString(3,date);
	s.setString(4,classes);
	s.executeUpdate();
	String sql3="select id from user_input where source=? and destination=? and date=?";
	PreparedStatement ps=con.prepareStatement(sql3);
	ps.setString(1,source);
	ps.setString(2,dest);
	ps.setString(3,date);
	ResultSet r=ps.executeQuery();
	if(r.next()){
		int inputId = r.getInt("id");
		
	
%>
<head>
    <title>SHOW TRAIN</title>
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
            <form id="rs_form" action="book.jsp" method="post">
                <input type="hidden" value="<%= inputId %>" name="inputid">
                <div class="train_header">
                    <a href="" class="b2">TRAINS</a>
                    <a href="modify.jsp?id=<%=inputId %>" class="b4">MODIFY SEARCH</a>
                </div>
                <br><center>
                <div class="train_details">
                    <div class="train1">
                        <table border="1">
                            <tr>
                                <th>
                                    COROMANDEL SF EXP (12841)   
                                    <input type="hidden" value="1" name="train_id1">
                                </th>
                            </tr>
                            <tr>
                                <td>
                                <% 
                                int id1=1;
                                String sql1 = "select * from train where source=? and destination=? and train_id=?";
                                PreparedStatement stmt = con.prepareStatement(sql1);
                                stmt.setString(1, source);
                                stmt.setString(2, dest);
                                stmt.setInt(3, id1);
                                ResultSet rs = stmt.executeQuery();
                                while(rs.next()){ 
                                %>
                                    <div class="train_left">
                                        <input type="time" value="<%=rs.getString("depart_time")%>" disabled class="time"> <label for="train_left" class="line">|</label> 
                                        <input type="text" value="<%=rs.getString("source")%>" disabled class="station">
                                        <input type="text" value="<%=date%>" disabled class="dates">
                                    </div>
                                    <div class="train_middle">
                                        <h3><input type="text" value="-----<%=rs.getString("journey_time")%>-----"></h3>
                                    </div>
                                    <div class="train_right">
                                        <input type="time" value="<%=rs.getString("arrive_time")%>" disabled> <label for="train_right" class="line">|</label> 
                                        <input type="text" value="<%=rs.getString("destination")%>" disabled class="station2">
                                        <input type="text" value="<%=date%>" disabled class="dates">
                                    </div>
                                    
                                </td>
                            </tr>
                            <td>
                                <div class="td2">
                                <h3>
                                <% if(classes.equals("All Classes")){ %>
                                <form action="book.jsp" method="post" class="sl_form">
                                    <div class="train_sleeper">
                                        <input type="hidden" value="<%= inputId %>" name="inputid">
                                        
                                        <h3>Sleeper    (SL)</h3><br>
                                        <input type="hidden" value="1" name="train_id">
                                        <input type="hidden" name="class" value="Sleeper (SL)">
                                        <input type="hidden" name="main" value="sl">
                                     	<input type="hidden" name="price" value="<%=rs.getString("sl_price")%>">
                                     	<input type="hidden" name="seatno" value="S5-57 SL" >
                                        <label for="train_sleeper" class="avl">Available - <input type="tel" name="seats" value="<%=rs.getInt("sleeper_capacity")%>"></label>
                                        <br>
                                        <button type="submit" class="b20" value="Book">Book</button>
                                    </div>
                                </form>
                                <form action="book.jsp" method="post" class="form_3a">
                                    <div class="train_sleeper">
                                    <input type="hidden" value="<%= inputId %>" name="inputid">
                                    
                                    	<h3>AC 3 Tier (3A)</h3><br>
                                        <input type="hidden" value="1" name="train_id">
                                        <input type="hidden" name="main" value="3a">
                                        <input type="hidden" name="class" value="AC 3 Tier (3A)">
                                        <input type="hidden" name="price" value="<%=rs.getString("3a_price")%>">
                                       	<input type="hidden" name="seatno" value="B4-33 U">
                                        <label for="train_sleeper" class="avl">Available - <input type="tel" name="seats" value="<%=rs.getInt("3a_capacity")%>"></label>
                                        <br>
                                        <button type="submit" class="b20" value="Book">Book</button>
                                    </div>
                                </form>
                                <form action="book.jsp" method="post" class="form_2a">
                                <input type="hidden" value="<%= inputId %>" name="inputid">
                                
                                    <div class="train_sleeper">
                                        <input type="hidden" value="1" name="train_id">
                                        <h3>AC 2 Tier (2A)</h3><br>
                                        <input type="hidden" name="class" value="AC 2 Tier (2A)">
                                        <input type="hidden" name="main" value="2a">
                                        <input type="hidden" name="price" value="<%=rs.getString("2a_price")%>">
                                        <input type="hidden" name="seatno" value="A2-15 SL">
                                        <label for="train_sleeper" class="avl">Available - <input type="tel" name="seats" value="<%=rs.getInt("2a_capacity")%>"></label>
                                        <br>
                                        <button type="submit" class="b20" value="Book">Book</button>
                                    </div>
                                </form>   
                                <form action="book.jsp" method="post" class="form_1a">
                                <input type="hidden" value="<%= inputId %>" name="inputid">
                                
                                    <div class="train_sleeper">
                                        <input type="hidden" value="1" name="train_id">
                                        <h3>AC 1 Tier (1A)</h3><br>
                                        <input type="hidden" name="class" value="AC 1 Tier (1A)">
                                        <input type="hidden" name="main" value="1a">
                                        <input type="hidden" name="price" value="<%=rs.getString("1a_price")%>">
                                        <input type="hidden" name="seatno" value="H1-27 L" >
                                        <label for="train_sleeper" class="avl">Available - <input type="tel" name="seats" value="<%=rs.getInt("1a_capacity")%>"></label>
                                        <br>
                                        <button type="submit" class="b20" value="Book">Book</button>
                                    </div>
                                </form>
                                <% } else if(classes.equals("Sleeper (SL)")) { %>
                                <form action="book.jsp" method="post" class="sl_form">
                                    <div class="train_sleeper">
                                        <input type="hidden" value="<%= inputId %>" name="inputid">
                                        
                                        <h3>Sleeper    (SL)</h3><br>
                                        <input type="hidden" value="1" name="train_id">
                                        <input type="hidden" name="class" value="Sleeper (SL)">
                                        <input type="hidden" name="main" value="sl">
                                        <input type="hidden" name="seatno" value="S5-57 SL" >
                                     	<input type="hidden" name="price" value="<%=rs.getString("sl_price")%>">
                                        <label for="train_sleeper" class="avl">Available - <input type="tel" name="seats" value="<%=rs.getInt("sleeper_capacity")%>"></label>
                                        <br>
                                        <button type="submit" class="b20" value="Book">Book</button>
                                    </div>
                                </form>
                                <% } else if(classes.equals("AC 3 Tier (3A)")) {%> 
                                <form action="book.jsp" method="post" class="form_3a">
                                    <div class="train_sleeper">
                                    <input type="hidden" value="<%= inputId %>" name="inputid">
                                    
                                    	<h3>AC 3 Tier (3A)</h3><br>
                                        <input type="hidden" value="1" name="train_id">
                                        <input type="hidden" name="class" value="AC 3 Tier (3A)">
                                        <input type="hidden" name="main" value="3a">
                                        <input type="hidden" name="seatno" value="B3-27 L" >
                                        <input type="hidden" name="price" value="<%=rs.getString("3a_price")%>">
                                        <label for="train_sleeper" class="avl">Available - <input type="tel" name="seats" value="<%=rs.getInt("3a_capacity")%>"></label>
                                        <br>
                                        <button type="submit" class="b20" value="Book">Book</button>
                                    </div>
                                </form>
                                <% } else if(classes.equals("AC 2 Tier (2A)")) {%>
                                <form action="book.jsp" method="post" class="form_2a">
                                
                                
                                    <div class="train_sleeper">
                                    <input type="hidden" value="<%= inputId %>" name="inputid">
                                        <input type="hidden" value="1" name="train_id">
                                        <h3>AC 2 Tier (2A)</h3><br>
                                        <input type="hidden" name="class" value="AC 2 Tier (2A)">
                                        <input type="hidden" name="main" value="2a">
                                        <input type="hidden" name="price" value="<%=rs.getString("2a_price")%>">
                                        <input type="hidden" name="seatno" value="A1-80 U" >
                                        <label for="train_sleeper" class="avl" >Available - <input type="tel" name="seats" value="<%=rs.getInt("2a_capacity")%>"></label>
                                        <br>
                                        <button type="submit" class="b20" value="Book">Book</button>
                                    </div>
                                </form>   
                                <% } else if(classes.equals("AC 1 Tier (1A)")) { %>
                                <form action="book.jsp" method="post" class="form_1a">
                                    <div class="train_sleeper">
                                    <input type="hidden" value="<%= inputId %>" name="inputid">
                                        <input type="hidden" value="1" name="train_id">
                                        <h3>AC 1 Tier (1A)</h3><br>
                                        <input type="hidden" name="class" value="AC 1 Tier (1A)">
                                        <input type="hidden" name="main" value="1a">
                                        <input type="hidden" name="price" value="<%=rs.getString("1a_price")%>">
                                        <input type="hidden" name="seatno" value="H1-20 L" >
                                        <label for="train_sleeper" class="avl">Available - <input type="tel" name="seats" value="<%=rs.getInt("1a_capacity")%>"></label>
                                        <br>
                                        <button type="submit" class="b20" value="Book">Book</button>
                                    </div>
                                </form>
                                <% } else { %>
                                <div class="train_man">   
                                <h3 id="blink">SELECTED CLASS NOT AVAILABLE FOR THIS TRAIN</h3><br>
                                </div>
                                <% } %>     
                            </h3>
                        </div>
                        <% } %>
                            </td>
                        </table>
                    </div>
                </div>
                
                <div class="train1">
                    <table border="1">
                        <tr>
                            <th>
                                RATNACHAL SF EXP (12717)   
                                <input type="hidden" value="2" name="train_id">
                            </th>
                        </tr>
                        <tr>
                            <td>
                            	<% 
                            	int id2=2;
                                String sql2 = "select * from train where source=? and destination=? and train_id=?";
                                PreparedStatement st = con.prepareStatement(sql2);
                                st.setString(1, source);
                                st.setString(2, dest);
                                st.setInt(3,id2);
                                ResultSet rp = st.executeQuery();
                                while(rp.next()){ 
                                %>
                                <div class="train_left">
                                    <input type="time" value="<%=rp.getString("depart_time")%>" disabled class="time"> <label for="train_left" class="line">|</label> 
                                    <input type="text" value="<%=rp.getString("source")%>" disabled class="station">
                                    <input type="text" value="<%=date%>" disabled class="dates">
                                </div>
                                <div class="train_middle">
                                    <h3><input type="text" value="-----<%=rp.getString("journey_time")%>-----"></h3>
                                </div>
                                <div class="train_right">
                                    <input type="time" value="<%=rp.getString("arrive_time")%>" disabled> <label for="train_right" class="line">|</label> 
                                    <input type="text" value="<%=rp.getString("destination")%>" disabled class="station2">
                                    <input type="text" value="<%=date%>" disabled class="dates">
                                </div>
                            </td>
                        </tr>
                        <td>
                            <div class="td2">
                            <h3>
                            <% if(classes.equals("All Classes")) { %>
                            <form action="book.jsp" method="post" class="form_2s">
                                <div class="train_2s">
                                    <input type="hidden" value="2" name="train_id">
                                    <input type="hidden" name="main" value="2s">
                                    <input type="hidden" value="<%= inputId %>" name="inputid">
                                    <h3>Second Sitting (2s)</h3><br>
                                    <input type="hidden" name="class" value="Second Sitting (2S)">
                                    <input type="hidden" name="price" value="<%=rp.getString("2s_price")%>">
                                    <input type="hidden" name="seatno" value="D11-57 WS" >
                                    <label for="train_2s" class="avl">Available - <input type="tel" name="seats" value="<%=rp.getInt("2s_capacity")%>"></label>
                                    <br>
                                    <button type="submit" class="b21" value="Book">Book</button>
                                </div>
                            </form>
                            <form action="book.jsp" method="post" class="form_cc">
                                <div class="train_2s">
                                    <input type="hidden" value="2" name="train_id">
                                    <input type="hidden" name="main" value="cc">
                                    <input type="hidden" value="<%= inputId %>" name="inputid">
                                    <h3>AC Chair Car (CC)</h3><br>
                                    <input type="hidden" name="class" value="AC Chair Car (CC)">
                                    <input type="hidden" name="price" value="<%=rp.getString("cc_price")%>">
                                    <input type="hidden" name="seatno" value="C1-57 WS" >
                                    <label for="train_2s" class="avl">Available - <input type="tel" name="seats" value="<%=rp.getInt("cc_capacity")%>"></label>
                                    <br>
                                    <button type="submit" class="b21" value="Book">Book</button>
                                </div>
                            </form>
                            <% } else if(classes.equals("Second Sitting (2S)")) { %>
                            <form action="book.jsp" method="post" class="form_2s">
                                <div class="train_2s">
                                    <input type="hidden" value="2" name="train_id">
                                    <input type="hidden" name="main" value="2s">
                                    <h3>Second Sitting (2s)</h3><br>
                                    <input type="hidden" value="<%= inputId %>" name="inputid">
                                    <input type="hidden" name="class" value="Second Sitting (2S)">
                                    <input type="hidden" name="price" value="<%=rp.getString("2s_price")%>">
                                    <input type="hidden" name="seatno" value="D5-76 WS" >
                                    <label for="train_2s" class="avl">Available - <input type="tel" name="seats" value="<%=rp.getInt("2s_capacity")%>"></label>
                                    <br>
                                    <button type="submit" class="b21" value="Book">Book</button>
                                </div>
                            </form>
                            <% } else if(classes.equals("AC Chair Car (CC)")){ %>
                            <form action="book.jsp" method="post" class="form_cc">
                                <div class="train_2s">
                                    <input type="hidden" value="2" name="train_id">
                                    <input type="hidden" name="main" value="cc">
                                    <h3>AC Chair Car (CC)</h3><br>
                                    <input type="hidden" value="<%= inputId %>" name="inputid">
                                    <input type="hidden" name="class" value="AC Chair Car (CC)">
                                    <input type="hidden" name="price" value="<%=rp.getString("cc_price")%>">
                                    <input type="hidden" name="seatno" value="C1-27 WS" >
                                    <label for="train_2s" class="avl">Available - <input type="tel" name="seats" value="<%=rp.getInt("cc_capacity")%>"></label>
                                    <br>
                                    <button type="submit" class="b21" value="Book">Book</button>
                                </div>
                            </form>
                            <% } else { %>
                            <div class="train_man">   
                                <h3 id="blink">SELECTED CLASS NOT AVAILABLE FOR THIS TRAIN</h3><br>
                                </div>
                            <% } %>
                        </h3>
                    </div>
                     <% } %>
                        </td>
                    </table>
                </div>
            </div>
            <% } %>
            
                </center>
            </form>
        </div>
    </div>
</body>
 <% 
    } catch(Exception e) { 
        out.println("Error: " + e.getMessage());
    } 
  %>
  <%
    } else {
        response.sendRedirect("loginnn.html");
    }
} else {
    response.sendRedirect("loginnn.html");
}
  %>
</html>

