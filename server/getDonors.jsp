<%@ page import="java.sql.*, java.util.*"%>
<%@ page import="org.json.JSONObject"%>
<%@ include file="DBConnection.jsp" %>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

String bloodGroup = request.getParameter("blood_group");
String district = request.getParameter("district");


StringBuilder sql = new StringBuilder("SELECT username, blood_group, phone, district, email, whatsapp FROM users WHERE availability = 'yes'");

if (bloodGroup != null && !bloodGroup.isEmpty()) {
    sql.append(" AND blood_group = ?");
}
if (district != null && !district.isEmpty()) {
    sql.append(" AND district = ?");
}

try {
    PreparedStatement ps = conn.prepareStatement(sql.toString());
    
    int idx = 1;
    if (bloodGroup != null && !bloodGroup.isEmpty()) {
        ps.setString(idx++, bloodGroup);
    }
    if (district != null && !district.isEmpty()) {
        ps.setString(idx++, district);
    }
    
    ResultSet rs = ps.executeQuery();
    
    List<JSONObject> results = new ArrayList<>();
    
    while (rs.next()) {
        JSONObject donor = new JSONObject();
        donor.put("username", rs.getString("username"));
        donor.put("blood_group", rs.getString("blood_group"));
        donor.put("phone", rs.getString("phone"));
        donor.put("district", rs.getString("district"));
        donor.put("email", rs.getString("email"));
        donor.put("whatsapp", rs.getString("whatsapp"));
        results.add(donor);
    }
    
    rs.close();
    ps.close();
    
    json.put("success", true);
    json.put("results", results);
    out.print(json.toString());
} catch (Exception e) {
	json.put("success", false);
    json.put("error", e.getMessage());
    out.print(json.toString());
} finally {
    try {
        conn.close();
    } catch (Exception e) {
        json.put("error", e.getMessage());
    }
}
%>