<%@ page import="java.sql.*" %>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");

    String url =
      "jdbc:mysql://mysql-383060b1-railease.k.aivencloud.com:17165/defaultdb" +
      "?useSSL=true&requireSSL=true&verifyServerCertificate=false";

    String user = "avnadmin";
    String pass = "AVNS_CGbdpGltzQ1ywZ6zrtN";

    Connection con = DriverManager.getConnection(url, user, pass);
%>
