<%@ page import="java.sql.*, org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>

<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

int donorId = Integer.parseInt(request.getParameter("donor_id"));
String action = request.getParameter("action");
String donatedDate = request.getParameter("donation_date");

try {
    PreparedStatement ps;
    if (donatedDate != null && donatedDate.trim().length() > 0) {
        ps = conn.prepareStatement(
            "INSERT INTO donation_history (donor_id, action, status, donation_date) VALUES (?, ?, ?, ?)"
        );
        ps.setInt(1, donorId);
        ps.setString(2, action);
        ps.setString(3, "approved");
        ps.setDate(4, java.sql.Date.valueOf(donatedDate));
    } else {
        ps = conn.prepareStatement(
            "INSERT INTO donation_history (donor_id, action, status) VALUES (?, ?, ?)"
        );
        ps.setInt(1, donorId);
        ps.setString(2, action);
        ps.setString(3, "approved");
    }

    int result = ps.executeUpdate();
    ps.close();

    if (result > 0) {
        json.put("success", true);
        json.put("message", "Donation record added successfully");
    } else {
        json.put("success", false);
        json.put("message", "Failed to add donation record");
    }
} catch (Exception e) {
    e.printStackTrace();
    json.put("success", false);
    json.put("error", e.getMessage());
    json.put("message", "Error occurred while adding record");
} 

conn.close();

out.print(json.toString());
%>