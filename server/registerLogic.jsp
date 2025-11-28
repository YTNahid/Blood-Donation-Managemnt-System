<%@ page import="java.sql.*,java.security.MessageDigest,org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>
<%
JSONObject json = new JSONObject();
response.setContentType("application/json");

// Collect form data from registration form
String fullname = request.getParameter("fullname");
String email = request.getParameter("email");
String password = request.getParameter("password");
String phone = request.getParameter("phone");
String whatsapp = request.getParameter("whatsapp");
String gender = request.getParameter("gender");
String bloodGroup = request.getParameter("blood_group");
String birthDate = request.getParameter("birth_date");
String district = request.getParameter("district");
String availability = request.getParameter("availability");

String error = null;
String message = null;

// Check if email already exists
try {
    String sql = "SELECT EMAIL FROM users WHERE EMAIL = ?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
    	error = "Email already exists.";
        message = "Email already exists";
    }
    rs.close();
    ps.close();
} catch (Exception e) {
    error = "Database error: " + e.getMessage();
}

// Hash Password
String hashedPassword = null;

if (error == null) {
    try {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : hash) {
            sb.append(String.format("%02x", b));
        }
        hashedPassword = sb.toString();
    } catch (Exception e) {
        error = "Something went wrong";
        System.out.println(e.getMessage());
    }
}

// Register User
if (error == null) {
    try {
        String sql = "INSERT INTO users (USERNAME, EMAIL, PASSWORD, PHONE, WHATSAPP, GENDER, BLOOD_GROUP, BIRTH_DATE, DISTRICT, AVAILABILITY, ROLE) VALUES (?, ?, ?, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, fullname);
        ps.setString(2, email);
        ps.setString(3, hashedPassword);
        ps.setString(4, phone);
        ps.setString(5, whatsapp);
        ps.setString(6, gender);
        ps.setString(7, bloodGroup);
        ps.setString(8, birthDate);
        ps.setString(9, district);
        ps.setString(10, availability);
        ps.setString(11, "user");
        int result = ps.executeUpdate();
        ps.close();
        if (result > 0) {
            message = "Registration successful";
        } else {
        	error = "Registration failed";
            message = "Registration failed";
        }
    } catch (Exception e) {
        error = "Database error: " + e.getMessage();
    }
}



if (error == null) {
    json.put("success", true);
    json.put("message", message);
} else {
    json.put("success", false);
    json.put("message", message);
    json.put("error", error);
}

conn.close();

out.print(json.toString());
%>