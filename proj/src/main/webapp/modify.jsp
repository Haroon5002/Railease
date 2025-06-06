<!DOCTYPE html>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>HOME</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="style.css">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script>
        $(function() {
            const stations = [
                "VIJAYAWADA JN - (BZA)",
                "RAJAHMUNDRY - (RJY)",
                "VISHAKAPATNAM JN - (VSKP)",
                "TADEPALLIGUDEM - (TDD)",
                "ELURU - (EE)",
            ];
            $(".name1").autocomplete({
                source: stations,
                minLength: 1
            });
            $(".name2").autocomplete({
                source: stations,
                minLength: 1 
            });
        });
        
        function swap() {
            var x = document.getElementsByClassName("name1")[0];
            var y = document.getElementsByClassName("name2")[0];
            var temp = x.value;
            x.value = y.value;
            y.value = temp;
        }
        
        function no() {
            var x = document.getElementsByClassName("name1")[0];
            var y = document.getElementsByClassName("name2")[0];
            if(x.value == y.value) {
                alert("Source and destination cannot be same");
                y.value = "";
            }
        }

        function valid(event) {
            var x = document.getElementsByClassName("name1")[0].value;
            var y = document.getElementsByClassName("name2")[0].value;
            var validStations = [
                "VIJAYAWADA JN - (BZA)",
                "RAJAHMUNDRY - (RJY)",
                "VISHAKAPATNAM JN - (VSKP)",
                "TADEPALLIGUDEM - (TDD)",
                "ELURU - (EE)"
            ];

            if (!validStations.includes(x) || !validStations.includes(y)) {
                alert("Select Valid Station Name....");
                event.preventDefault();
            }
        }
    </script>
</head>
<% try{
	String id=request.getParameter("id");
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/project","root","root");
	String sql="select * from user_input where id=?";
	PreparedStatement ps=con.prepareStatement(sql);
	ps.setString(1,id);
	ResultSet rs=ps.executeQuery();
%>
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
        <div id="reserve">
        
            <form id="rs_form" action="verify.jsp" onsubmit="valid(event)">
            
                <center>
                    <h1 style="color: #303090;">MODIFY SEARCH</h1><br>
                    <% while(rs.next()){ %>
                    <input type="text" placeholder="From" class="name1" name="source" value="<%=rs.getString("source")%>" required> 
                    <input type="date" placeholder="Date of journey" value="<%=rs.getString("date")%>" class="ip" name="doj" required>
                    <br>
                    <img src="images/change.png" class="swap" onclick="swap()">
                    <br>
                    <input type="text" placeholder="To" class="name2" value="<%=rs.getString("destination")%>" name="destination" onblur="no()" required>
                    <select name="classes" class="ip">
                        <option value="All Classes">All Classes</option>
                        <option value="AC 1 Tier (1A)">AC 1 Tier (1A)</option>
                        <option value="AC 2 Tier (2A)">AC 2 Tier (2A)</option>
                        <option value="AC 3 Tier (3A)">AC 3 Tier (3A)</option>
                        <option value="AC Chair Car (CC)">AC Chair Car (CC)</option>
                        <option value="Sleeper (SL)">Sleeper (SL)</option>
                        <option value="Second Sitting (2S)">Second Sitting (2S)</option>
                    </select>
                    <br><br><br>
                    <select name="cla" class="gn">
                        <option>GENERAL</option>
                        <option>LADIES</option>
                        <option>LOWER BERTH/SR.CITIZEN</option>
                        <option>PERSON WITH DISABILITY</option>
                        <option>TATKAL</option>
                        <option>PREMIUM TATKAL</option>
                    </select>
                    <br><br>
                    <div class="check">
                        <div class="check-item">
                            <input type="checkbox">Person With Disability Concession
                        </div>
                        <div class="check-item">
                            <input type="checkbox">Train With Available Berth
                        </div>
                    </div><hr><br><br>
                    <button class="b1" type="submit">Search</button>
                </center>
            </form>
        </div>
    </div>
    <% } %>
    <% } catch(Exception e){
    	e.printStackTrace();
    } %>
</body>
</html>
