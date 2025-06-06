<%@ page import="java.sql.*,jakarta.servlet.http.HttpSession" %>
<% 
	String pwd=request.getParameter("pwd2");
String uid=request.getParameter("uid");
String email=request.getParameter("email");
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/project","root","root");
String sql="update user set pwd=? where uid=? and email=?";
PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1,pwd);
ps.setString(2,uid);
ps.setString(3,email);
int i=ps.executeUpdate();
if(i>0){
	response.sendRedirect("login.html");
}
%>