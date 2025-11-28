<%@ page import="java.sql.*, java.util.*, org.json.JSONObject" %>
<%@ include file="DBConnection.jsp"%>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

String bloodGroup = request.getParameter("blood_group");
String district = request.getParameter("district");
String location = request.getParameter("location");
String latlng = request.getParameter("latlng");
String contactInfo = request.getParameter("contact_info");
String reason = request.getParameter("reason");
String urgentStr = request.getParameter("urgent"); // null if unchecked, 'on' if checked
String dueDateStr = request.getParameter("due_date"); // yyyy-MM-dd

int requesterId = (int) session.getAttribute("userId");

try {
	PreparedStatement ps = conn.prepareStatement(
	"INSERT INTO blood_requests (requester_id, blood_group, district, location, latitude, longitude, contact_info, reason, urgent, due_date) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

	ps.setInt(1, requesterId);
	ps.setString(2, bloodGroup);
	ps.setString(3, district);
	ps.setString(4, location);

	// Parse latitude and longitude
	Double latitude = null;
	Double longitude = null;
	if (latlng != null && latlng.trim().length() > 0) {
		String[] parts = latlng.split(",");
		if (parts.length == 2) {
			try {
				latitude = Double.parseDouble(parts[0].trim());
				longitude = Double.parseDouble(parts[1].trim());
			} catch (NumberFormatException e) {
				latitude = null;
				longitude = null;
			}
		}
	}
	
	if (latitude != null) {
		ps.setDouble(5, latitude);
	} else {
		ps.setNull(5, java.sql.Types.DOUBLE);
	}
	
	if (longitude != null) {
		ps.setDouble(6, longitude);
	} else {
		ps.setNull(6, java.sql.Types.DOUBLE);
	}

	ps.setString(7, contactInfo);
	ps.setString(8, reason);

	// Handle urgent flag
	int urgent = (urgentStr == null ? 0 : 1);
	ps.setInt(9, urgent);

	// Parse and bind due_date
	java.sql.Date dueDate = null;
	try {
		dueDate = java.sql.Date.valueOf(dueDateStr); // expects "yyyy-MM-dd"
	} catch (IllegalArgumentException e) {
		json.put("success", false);
		json.put("error", e.getMessage());
		json.put("message", "Something Went Wrong. Please try again.");
		out.print(json.toString());
		return;
	}
	ps.setDate(10, dueDate);

	int result = ps.executeUpdate();
	ps.close();

	if (result > 0) {
		json.put("success", true);
		json.put("message", "Successfully posted request");
	} else {
		json.put("success", false);
		json.put("message", "Failed to submit blood request.");
	}
} catch (Exception e) {
	e.printStackTrace();
	json.put("success", false);
	json.put("error", e.getMessage());
	json.put("message", "Something Went Wrong. Please try again.");
}

out.print(json.toString());
%>