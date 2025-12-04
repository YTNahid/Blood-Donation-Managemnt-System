<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject, java.util.*" %>
<%@ include file="DBConnection.jsp" %>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

try {
    String sql = "SELECT message_id, contacted_by, message, subject, submitted_at, name, email FROM contact_form ORDER BY submitted_at DESC";
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
    
    List<JSONObject> results = new ArrayList<>();
    
    while (rs.next()) {
        JSONObject feedback = new JSONObject();
        feedback.put("message_id", rs.getInt("message_id"));
        feedback.put("contacted_by", rs.getInt("contacted_by"));
        feedback.put("message", rs.getString("message"));
        feedback.put("subject", rs.getString("subject"));
        feedback.put("submitted_at", rs.getTimestamp("submitted_at"));
        feedback.put("name", rs.getString("name"));
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

try { conn.close(); } catch (Exception ignore) {}
%>
