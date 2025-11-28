<%@ page import="java.sql.*,org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>
<%
JSONObject json = new JSONObject();
response.setContentType("application/json");

String id = request.getParameter("id");
String table = request.getParameter("tableName");
String column = request.getParameter("columnName");

System.out.println("Parameters received - id: " + id + ", table: " + table + ", column: " + column);

String error = null;
String message = null;

if (id != null && table != null && column != null) {
    try {
        String sql = "DELETE FROM " + table + " WHERE " + column + " = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, id);
        int deleted = ps.executeUpdate();
        ps.close();
        if (deleted > 0) {
            message = "Deleted successfully.";
        } else {
            error = "Could not be deleted.";
            message = "Could not be deleted.";
        }
    } catch (Exception e) {
        error = "Error deleting record: " + e.getMessage();
    } 
} else {
    error = "Invalid parameters.";
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