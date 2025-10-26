<%@ page import="java.sql.*"%>
<%@ page import="org.json.JSONObject"%>
<%@ include file="DBConnection.jsp"%>
<%
JSONObject json = new JSONObject();
response.setContentType("application/json");

String userIdStr = request.getParameter("user_id");
String username = request.getParameter("username");
String phone = request.getParameter("phone");
String whatsapp = request.getParameter("whatsapp");
String gender = request.getParameter("gender");
String bloodGroup = request.getParameter("blood_group");
String birthDate = request.getParameter("birth_date");
String district = request.getParameter("district");

if (userIdStr != null) {
	PreparedStatement ps = null;
	try {
		int userId = Integer.parseInt(userIdStr);
		
		String sql = "UPDATE users SET username = ?, phone = ?, whatsapp = ?, gender = ?, blood_group = ?, birth_date = TO_DATE(?, 'YYYY-MM-DD'), district = ? WHERE user_id = ?";

		ps = conn.prepareStatement(sql);
		ps.setString(1, username);
		ps.setString(2, phone);
		ps.setString(3, whatsapp);
		ps.setString(4, gender);
		ps.setString(5, bloodGroup);
		ps.setString(6, birthDate);
		ps.setString(7, district);
		ps.setInt(8, userId);

		int updated = ps.executeUpdate();
		if (updated > 0) {
			json.put("success", true);
			json.put("message", "Profile updated successfully.");
		} else {
			json.put("success", false);
			json.put("error", "User not found or no changes made.");
		}
		
		ps.close();
	} catch (Exception e) {
		json.put("success", false);
		json.put("error", e.getMessage());
	}
} else {
	json.put("success", false);
	json.put("error", "Missing user_id");
}

out.print(json.toString());
%>
