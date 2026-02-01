<%@ page import="java.sql.*" %>
<%
    String DB_HOST = System.getenv("DB_HOST");
    String DB_PORT = System.getenv("DB_PORT");
    String DB_NAME = System.getenv("DB_NAME");
    String DB_USER = System.getenv("DB_USER");
    String DB_PASS = System.getenv("DB_PASS");

    String url = "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME + "?ssl-mode=REQUIRED";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, DB_USER, DB_PASS);
%>

