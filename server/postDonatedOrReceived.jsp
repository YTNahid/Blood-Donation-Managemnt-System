<%@ page import="java.sql.*, org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>

<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

int donorId = Integer.parseInt(request.getParameter("donor_id"));
String action = request.getParameter("action");
Integer requestId = null;
String requestIdStr = request.getParameter("requestId");
if (requestIdStr != null && !requestIdStr.isEmpty()) {
    requestId = Integer.parseInt(requestIdStr);
}

try {
    // 🔎 First check if this request_id already has a pending record
    String checkSql = "SELECT COUNT(*) FROM donation_history WHERE request_id = ? AND status = 'pending'";
    PreparedStatement checkPs = conn.prepareStatement(checkSql);
    checkPs.setInt(1, requestId);
    ResultSet rs = checkPs.executeQuery();
    rs.next();
    int count = rs.getInt(1);
    rs.close();
    checkPs.close();

    if (count > 0) {
        // Already has a pending record → throw error
        json.put("success", false);
        json.put("message", "This request already has a pending record.");
    } else {
        // Insert new record with default status = 'pending'
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO donation_history (donor_id, request_id, action, status) VALUES (?, ?, ?, 'pending')"
        );
        ps.setInt(1, donorId);
        ps.setInt(2, requestId);
        ps.setString(3, action);

        int result = ps.executeUpdate();
        ps.close();

        if (result > 0) {
            json.put("success", true);
            json.put("message", "Action has been submitted.");
        } else {
            json.put("success", false);
            json.put("message", "Failed to Submit");
        }
    }
} catch (Exception e) {
    e.printStackTrace();
    json.put("success", false);
    json.put("error", e.getMessage());
    json.put("message", "Error occurred while submitting");
}

out.print(json.toString());
%>
