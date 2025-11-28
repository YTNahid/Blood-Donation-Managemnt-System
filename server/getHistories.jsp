<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject, java.util.*" %>
<%@ include file="DBConnection.jsp" %>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

try {
    String sql = "SELECT DH.DONATION_ID, DH.REQUEST_ID, DH.DONATION_DATE, DH.STATUS, DH.ACTION, U.USERNAME, U.EMAIL, U.PHONE  FROM DONATION_HISTORY DH JOIN USERS U ON DH.DONOR_ID = U.USER_ID ORDER BY DH.DONATION_DATE DESC";
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
    
    List<JSONObject> results = new ArrayList<>();
    
    while (rs.next()) {
        JSONObject history = new JSONObject();
        history.put("donation_id", rs.getInt("donation_id"));
        history.put("request_id", rs.getInt("request_id"));
        history.put("donation_date", rs.getDate("donation_date").toString());
        history.put("status", rs.getString("status"));
        history.put("action", rs.getString("action"));
        history.put("username", rs.getString("username"));
        history.put("email", rs.getString("email"));
        history.put("phone", rs.getString("phone"));
        results.add(history);
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
} finally {
    try {
        conn.close();
    } catch (Exception e) {
        json.put("error", e.getMessage());
    }
}
%>