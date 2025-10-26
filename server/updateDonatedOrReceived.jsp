<%@ page import="java.sql.*, org.json.JSONObject" %>
<%@ include file="../server/DBConnection.jsp" %>
<%@ include file="authCheckAdmin.jsp"%>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

try {
    String donationIdParam = request.getParameter("donation_id");
    String decision = request.getParameter("decision");

    if (donationIdParam == null || decision == null) {
        json.put("success", false);
        json.put("error", "Missing parameters");
    } else {
        int donationId = Integer.parseInt(donationIdParam);

        // Step 1: find the request_id for this donation_id
        String reqSql = "SELECT request_id FROM donation_history WHERE donation_id = ?";
        PreparedStatement reqPs = conn.prepareStatement(reqSql);
        reqPs.setInt(1, donationId);
        ResultSet rs = reqPs.executeQuery();
        Integer requestId = null;
        if (rs.next()) {
            requestId = rs.getInt("request_id");
        }
        rs.close();
        reqPs.close();

        if (requestId == null) {
            json.put("success", false);
            json.put("error", "Donation record not found");
        } else {
            // Step 2: if decision is approved, check if another approved already exists
            if ("approved".equalsIgnoreCase(decision)) {
                String checkSql = "SELECT COUNT(*) FROM donation_history " +
                                  "WHERE request_id = ? AND status = 'approved' AND donation_id <> ?";
                PreparedStatement checkPs = conn.prepareStatement(checkSql);
                checkPs.setInt(1, requestId);
                checkPs.setInt(2, donationId);
                ResultSet checkRs = checkPs.executeQuery();
                checkRs.next();
                int count = checkRs.getInt(1);
                checkRs.close();
                checkPs.close();

                if (count > 0) {
                    json.put("success", false);
                    json.put("error", "This request already has an approved record.");
                    out.print(json.toString());
                    return;
                }
            }

            // Step 3: perform the update
            String sql = "UPDATE donation_history SET status = ? WHERE donation_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, decision);
            ps.setInt(2, donationId);

            int updated = ps.executeUpdate();
            ps.close();

            if (updated > 0) {
                json.put("success", true);
                json.put("message", "Successfully Updated");
            } else {
                json.put("success", false);
                json.put("error", "No record updated");
            }
        }
    }
} catch (Exception e) {
    json.put("success", false);
    json.put("error", e.getMessage());
}

out.print(json.toString());
%>
