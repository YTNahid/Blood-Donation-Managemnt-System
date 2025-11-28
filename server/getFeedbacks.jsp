<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject, java.util.*" %>
<%@ include file="DBConnection.jsp" %>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

try {
    String sql = "SELECT f.message_id, f.message, f.subject, f.submitted_at, u.username, u.email FROM contact_form f JOIN users u ON f.contacted_by = u.user_id ORDER BY f.submitted_at DESC";
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
    
    List<JSONObject> results = new ArrayList<>();
    
    while (rs.next()) {
        JSONObject feedback = new JSONObject();
        feedback.put("message_id", rs.getInt("message_id"));
        feedback.put("message", rs.getString("message"));
        feedback.put("subject", rs.getString("subject"));
        feedback.put("submitted_at", rs.getTimestamp("submitted_at"));
        feedback.put("username", rs.getString("username"));
        feedback.put("email", rs.getString("email"));
        results.add(feedback);
    }
    rs.close();
    ps.close();
    
    json.put("results", results);
    json.put("success", true);
    out.print(json.toString());
} catch (Exception e) {
    JSONObject error = new JSONObject();
    error.put("success", false);
    error.put("error", e.getMessage());
    out.print(error.toString());
} 

conn.close();
%>