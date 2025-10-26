<%@ page import="java.sql.*, org.json.JSONObject" %>
<%@ include file="../server/DBConnection.jsp" %>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

String user_id = request.getParameter("user_id");

try {
    PreparedStatement ps = conn.prepareStatement(
        "SELECT user_id, username, profile_photo, email, phone, whatsapp, gender, blood_group, birth_date, district, role, availability " +
        "FROM users WHERE user_id = ?"
    );
    ps.setString(1, user_id);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        json.put("success", true);
        json.put("user_id", rs.getInt("user_id"));
        json.put("username", rs.getString("username"));
        json.put("profile_photo", rs.getString("profile_photo"));
        json.put("email", rs.getString("email"));
        json.put("phone", rs.getString("phone"));
        json.put("whatsapp", rs.getString("whatsapp"));
        json.put("gender", rs.getString("gender"));
        json.put("blood_group", rs.getString("blood_group"));
        
        java.sql.Date birthDate = rs.getDate("birth_date");
        json.put("birth_date", birthDate != null ? birthDate.toString() : null);

        json.put("district", rs.getString("district"));
        json.put("role", rs.getString("role"));
        json.put("availability", rs.getString("availability"));
    } else {
        json.put("success", false);
        json.put("message", "User not found");
    }

    rs.close();
    ps.close();

} catch (Exception e) {
    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    json.put("success", false);
    json.put("error", e.getMessage());
}

out.print(json.toString());
%>
