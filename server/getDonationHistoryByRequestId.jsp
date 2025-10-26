<%@ page import="java.sql.*, org.json.JSONObject, org.json.JSONArray" %>
<%@ include file="DBConnection.jsp" %>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

try {
    Integer requestId = null;
    String requestIdStr = request.getParameter("requestId");
    if (requestIdStr != null && !requestIdStr.isEmpty()) {
        requestId = Integer.parseInt(requestIdStr);
    }

    if (requestId == null) {
        json.put("success", false);
        json.put("error", "Missing requestId parameter");
        out.print(json.toString());
        return;
    }

    String sql = "SELECT DH.DONATION_ID, DH.DONOR_ID, DH.DONATION_DATE, DH.STATUS, DH.ACTION, " +
                 "U.USERNAME, U.EMAIL, U.PHONE " +
                 "FROM DONATION_HISTORY DH " +
                 "JOIN USERS U ON DH.DONOR_ID = U.USER_ID " +
                 "WHERE DH.REQUEST_ID = ?";

    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setInt(1, requestId);

    ResultSet rs = ps.executeQuery();

    JSONArray results = new JSONArray();
    while (rs.next()) {
        JSONObject history = new JSONObject();
        history.put("donation_id", rs.getInt("donation_id"));
        history.put("donor_id", rs.getInt("donor_id"));
        history.put("donation_date", rs.getDate("donation_date").toString());
        history.put("status", rs.getString("status"));
        history.put("action", rs.getString("action"));
        history.put("username", rs.getString("username"));
        history.put("email", rs.getString("email"));
        history.put("phone", rs.getString("phone"));
        results.put(history);
    }

    if (results.length() > 0) {
        json.put("results", results);
        json.put("success", true);
    } else {
        json.put("success", false);
        json.put("error", "No records found for requestId " + requestId);
    }

    rs.close();
    ps.close();

    out.print(json.toString());

} catch (Exception e) {
    JSONObject error = new JSONObject();
    error.put("success", false);
    error.put("error", e.getMessage());
    out.print(error.toString());
}
%>
