<%@ page import="java.sql.*,java.security.MessageDigest,org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>
<%
JSONObject json = new JSONObject();
response.setContentType("application/json");

String email = request.getParameter("email");
String password = request.getParameter("password");

String error = null;

boolean loginSuccess = false;
if (email != null && password != null) {
    String hashedPassword = null;
    try {
        // Hash the password for secure comparison
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : hash) {
            sb.append(String.format("%02x", b));
        }
        hashedPassword = sb.toString();
    
    } catch (Exception e) {
        error = "Error hashing password.";
    }
    if (error == null) {
        try {
            // Prepare and execute SQL query to check credentials
            String sql = "SELECT USER_ID, USERNAME, EMAIL, ROLE FROM users WHERE EMAIL = ? AND PASSWORD = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Set session attributes for logged-in user
                session.setAttribute("userId", rs.getInt("USER_ID"));
                session.setAttribute("username", rs.getString("USERNAME"));
                session.setAttribute("email", rs.getString("EMAIL"));
                session.setAttribute("role", rs.getString("ROLE"));
                loginSuccess = true;
                json.put("user_id", rs.getInt("USER_ID"));
                json.put("username", rs.getString("USERNAME"));
                json.put("email", rs.getString("EMAIL"));
                json.put("role", rs.getString("ROLE"));
            } else {
                error = "Invalid email or password.";
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            error = "Database error: " + e.getMessage();
        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                error = "Error closing connection: " + e.getMessage();
            }
        }
    }
}

if (loginSuccess) {
    json.put("success", true);
} else {
    json.put("success", false);
    json.put("error", error);
}
out.print(json.toString());
%>