<%@ page import="java.sql.*, org.json.JSONObject, org.json.JSONArray, java.util.*"%>
<%@ include file="../server/DBConnection.jsp"%>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

try {
    PreparedStatement ps = conn.prepareStatement(
        "SELECT user_id, username, email, phone, whatsapp, gender, blood_group, birth_date, district, role, availability FROM users"
    );
    ResultSet rs = ps.executeQuery();
    
    List<JSONObject> results = new ArrayList<>();
    while (rs.next()) {
        JSONObject user = new JSONObject();
        user.put("user_id", rs.getInt("user_id"));
        user.put("username", rs.getString("username"));
        user.put("email", rs.getString("email"));
        user.put("phone", rs.getString("phone"));
        user.put("whatsapp", rs.getString("whatsapp"));
        user.put("gender", rs.getString("gender"));
        user.put("blood_group", rs.getString("blood_group"));
        user.put("birth_date", rs.getDate("birth_date"));
        user.put("district", rs.getString("district"));
        user.put("role", rs.getString("role"));
        user.put("availability", rs.getString("availability"));
        results.add(user);
    }
    json.put("success", true);
    json.put("results", results);
} catch (Exception e) {
    json.put("success", false);
    json.put("error", e.getMessage());
}

out.print(json.toString());
%>