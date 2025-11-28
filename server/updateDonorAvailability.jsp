<%@ page import="java.sql.*"%>
<%@ page import="org.json.JSONObject" %>
<%@ include file="DBConnection.jsp"%>
<%
JSONObject json = new JSONObject();
response.setContentType("application/json");

String user_id = request.getParameter("user_id");

String current = request.getParameter("currentAvailability");
String newAvailability = "yes".equals(current) ? "no" : "yes";

String message = null, error = null;

try {
	String sql = "UPDATE users SET availability = ? WHERE user_id = ?";
	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setString(1, newAvailability);
	ps.setInt(2, Integer.parseInt(user_id));
	int updated = ps.executeUpdate();
	ps.close();
	if (updated > 0) {
		message = "Status updated successfully";
	} else {
		message = "Status update failed";
		error = "No rows affected";
	}
} catch (Exception e) {
	message = "Something went wrong";
	error = e.getMessage();
}

if(error == null) {
	json.put("success", true);
	json.put("message", message);
} else {
	json.put("success", false);
	json.put("message", message);
    json.put("error", error);
}

conn.close();

out.print(json.toString());
%>