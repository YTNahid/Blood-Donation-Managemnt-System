<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%@ page import="org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>
<%
String user_id = request.getParameter("user_id");
String newPassword = request.getParameter("password");
JSONObject json = new JSONObject();
response.setContentType("application/json");

String hashedNewPassword = null;

//Hash the input password
MessageDigest md = MessageDigest.getInstance("SHA-256");
byte[] hash = md.digest(newPassword.getBytes());
StringBuilder sb = new StringBuilder();
for (byte b : hash) {
 sb.append(String.format("%02x", b));
}
hashedNewPassword = sb.toString();

if (user_id != null && newPassword != null) {
    try {
        int userId = Integer.parseInt(user_id);
        PreparedStatement ps = conn.prepareStatement("UPDATE users SET password = ? WHERE user_id = ?");
        ps.setString(1, hashedNewPassword);
        ps.setInt(2, userId);
        int updated = ps.executeUpdate();
        if (updated > 0) {
            json.put("success", true);
            json.put("message", "Password updated successfully.");
        } else {
            json.put("success", false);
            json.put("error", "User not found or password not updated.");
        }
        ps.close();
    } catch (Exception e) {
        json.put("success", false);
        json.put("error", e.getMessage());
    }
} else {
    json.put("success", false);
    json.put("error", "Missing user_id or password parameter");
}
out.print(json.toString());
%>