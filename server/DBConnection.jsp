<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.SQLException" %>
<%
    String DB_URL = "jdbc:oracle:thin:@localhost:1521/XEPDB1";
    String DB_USER = "innovation_lab";
    String DB_PASSWORD = "admin";
    Connection conn = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    } catch (Exception e) {
        throw new RuntimeException("Database connection error: " + e.getMessage());
    }
%>