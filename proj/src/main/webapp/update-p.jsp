<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
String id = request.getParameter("id");
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String uid = request.getParameter("uid");
String pwd = request.getParameter("pwd");
String number = request.getParameter("number");
String gender = request.getParameter("gender");
String nationality = request.getParameter("Nationality");
String date = request.getParameter("date");
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/project","root","root");
String sql1="update user set fname=?,lname=?,email=?,uid=?,pwd=?,number=?,gender=?,nationality=?,date=? where id=?";
PreparedStatement ps=con.prepareStatement(sql1);
ps.setString(1,fname);
ps.setString(2,lname);
ps.setString(3,email);
ps.setString(4,uid);
ps.setString(5,pwd);
ps.setString(6,number);
ps.setString(7,gender);
ps.setString(8,nationality);
ps.setString(9,date);
ps.setString(10,id);
int ru=ps.executeUpdate();




if (ru > 0) {
    
   response.sendRedirect("profile.jsp");

} else {
    
}
%>
