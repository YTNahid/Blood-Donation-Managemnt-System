<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();
JSONArray announcements = new JSONArray();

try {
    String sql = "SELECT a.announcement_id, a.title, a.message, a.posted_by, a.post_date, u.username FROM announcements a LEFT JOIN users u ON a.posted_by = u.user_id ORDER BY a.post_date DESC";
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
    while (rs.next()) {
        JSONObject obj = new JSONObject();
        obj.put("announcement_id", rs.getInt("announcement_id"));
        obj.put("title", rs.getString("title"));
        obj.put("message", rs.getString("message"));
        obj.put("post_date", rs.getString("post_date"));
        obj.put("posted_by", rs.getString("username"));
        announcements.put(obj);
    }
    rs.close();
    ps.close();
    json.put("success", true);
    json.put("announcements", announcements);
} catch (Exception e) {
    json.put("success", false);
    json.put("error", e.getMessage());
}
out.print(json.toString());
%>