<%@ page import="java.sql.*, java.util.*, org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>
<%
JSONObject json = new JSONObject();
response.setContentType("application/json");

String name = request.getParameter("name");
String email = request.getParameter("email");
String subject = request.getParameter("subject");
String message = request.getParameter("message");

// Get userId if logged in, otherwise set null
Object userObj = session.getAttribute("userId");
Integer userId = (userObj != null) ? (Integer) userObj : null;

try {
    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO contact_form (contacted_by, subject, message, name, email, submitted_at) " +
        "VALUES (?, ?, ?, ?, ?, SYSDATE)"
    );

    if (userId == null) {
        ps.setNull(1, java.sql.Types.INTEGER); // contacted_by = NULL for guest
    } else {
        ps.setInt(1, userId); // logged-in user
    }

    ps.setString(2, subject);
    ps.setString(3, message);
    ps.setString(4, name);  // always save submitted name
    ps.setString(5, email); // always save submitted email

    int result = ps.executeUpdate();
    ps.close();

    if (result > 0) {
        json.put("success", true);
        json.put("message", "Message Submitted");
    } else {
        json.put("success", false);
        json.put("message", "Message submission failed.");
    }
} catch (Exception e) {
    e.printStackTrace();
    json.put("success", false);
    json.put("message", "An error occurred.");
    json.put("error", e.getMessage());
}

// Always close DB connection
try { conn.close(); } catch (Exception ignore) {}

out.print(json.toString());
%>
