<%@ page import="java.sql.*, java.util.*, org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>
<%
    JSONObject json = new JSONObject();
    response.setContentType("application/json");
    
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");
    int userId = (int) session.getAttribute("userId");

    try {
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO contact_form (contacted_by, subject, message, submitted_at) VALUES (?, ?, ?, SYSDATE)"
        );
        ps.setInt(1, userId);
        ps.setString(2, subject);
        ps.setString(3, message);

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
    out.print(json.toString());
%>
