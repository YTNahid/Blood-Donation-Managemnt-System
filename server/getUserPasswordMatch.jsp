<%@ page import="java.sql.*, java.security.MessageDigest" %>
<%@ page import="org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>
<%
String user_id = request.getParameter("user_id");
String inputPassword = request.getParameter("password");

JSONObject json = new JSONObject();
response.setContentType("application/json");

String hashedInputPassword = null;

// Hash the input password
MessageDigest md = MessageDigest.getInstance("SHA-256");
byte[] hash = md.digest(inputPassword.getBytes());
StringBuilder sb = new StringBuilder();
for (byte b : hash) {
    sb.append(String.format("%02x", b));
}
hashedInputPassword = sb.toString();


if (user_id != null) {
    try {
        int userId = Integer.parseInt(user_id);
        PreparedStatement ps = conn.prepareStatement("SELECT password FROM users WHERE user_id = ?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            String hashedPassword = rs.getString("password");
            if(hashedPassword.equals(hashedInputPassword)) {
                json.put("success", true);
                json.put("match", true);
            } else {
                json.put("success", true);
                json.put("match", false);
            }
        } else {
            json.put("success", false);
            json.put("error", "User not found");
        }
        rs.close();
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