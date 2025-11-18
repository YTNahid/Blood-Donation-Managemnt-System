<%@ page import="java.sql.*, org.json.JSONObject"%>
<%@ include file="DBConnection.jsp" %>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

try {
    String sql = "SELECT 1 FROM donation_history WHERE status = 'pending'";
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    JSONObject resultObj = new JSONObject();
    if (rs.next()) {
        resultObj.put("pending", true);
    } else {
        resultObj.put("pending", false);
    }

    rs.close();
    ps.close();

    json.put("result", resultObj);
    json.put("success", true);
    out.print(json.toString());
} catch (Exception e) {
    JSONObject error = new JSONObject();
    error.put("success", false);
    error.put("error", e.getMessage());
    out.print(error.toString());
}
%>
