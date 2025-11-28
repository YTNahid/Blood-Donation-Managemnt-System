<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject" contentType="application/json; charset=UTF-8" %>
<%@ include file="DBConnection.jsp" %>

<%
response.setContentType("application/json");
JSONArray donorsArray = new JSONArray();

try {
    String sql = "SELECT USERNAME, BLOOD_GROUP, PHONE, EMAIL, DISTRICT, WHATSAPP " +
                 "FROM users WHERE availability = 'yes' " +
                 "ORDER BY CREATED_AT DESC FETCH FIRST 10 ROWS ONLY";
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        JSONObject donor = new JSONObject();
        donor.put("name", rs.getString("USERNAME"));
        donor.put("bloodGroup", rs.getString("BLOOD_GROUP"));
        donor.put("phone", rs.getString("PHONE"));
        donor.put("email", rs.getString("EMAIL"));
        donor.put("district", rs.getString("DISTRICT"));
        donor.put("whatsapp", rs.getString("WHATSAPP"));
        donorsArray.put(donor);
    }

    rs.close();
    ps.close();

} catch (Exception e) {
    JSONObject errorObj = new JSONObject();
    errorObj.put("error", e.getMessage());
    donorsArray.put(errorObj);
}

out.print(donorsArray.toString());
%>
