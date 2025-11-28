<%@ page import="java.sql.*, org.json.JSONObject" contentType="application/json; charset=UTF-8" %>
<%@ include file="DBConnection.jsp" %>

<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

try {
    // Total donors
    String donorSql = "SELECT COUNT(*) FROM users WHERE availability = 'yes'";
    PreparedStatement donorStmt = conn.prepareStatement(donorSql);
    ResultSet donorRs = donorStmt.executeQuery();
    if (donorRs.next()) json.put("totalDonors", donorRs.getInt(1));
    donorRs.close();
    donorStmt.close();

    // Total donations
    String donationSql = "SELECT COUNT(*) FROM donation_history WHERE status = 'approved'";
    PreparedStatement donationStmt = conn.prepareStatement(donationSql);
    ResultSet donationRs = donationStmt.executeQuery();
    if (donationRs.next()) json.put("totalDonations", donationRs.getInt(1));
    donationRs.close();
    donationStmt.close();

    // Total requests
    String requestSql = "SELECT COUNT(*) FROM blood_requests BR left join donation_history DH on BR.request_id = DH.request_id WHERE DH.request_id IS NULL";
    PreparedStatement requestStmt = conn.prepareStatement(requestSql);
    ResultSet requestRs = requestStmt.executeQuery();
    if (requestRs.next()) json.put("totalRequests", requestRs.getInt(1));
    requestRs.close();
    requestStmt.close();

} catch (Exception e) {
    json.put("error", e.getMessage());
} 

conn.close();

out.print(json.toString());
%>
