<%@ page import="java.sql.*" %>
<%@ include file="../server/DBConnection.jsp" %>
<%@ include file="authCheckAdmin.jsp"%>
<%
String userIdParam = request.getParameter("user_id");
String newRole = request.getParameter("new_role");
String message = "";
if (userIdParam != null && newRole != null && ("admin".equals(newRole) || "user".equals(newRole))) {
    try {
        int userId = Integer.parseInt(userIdParam);
        String sql = "UPDATE users SET role = ? WHERE user_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, newRole);
        ps.setInt(2, userId);
        int updated = ps.executeUpdate();
        ps.close();
        if (updated > 0) {
            message = "Role updated successfully.";
        } else {
            message = "User not found or role not changed.";
        }
    } catch (Exception e) {
        message = "Error updating role: " + e.getMessage();
    }
} else {
    message = "Invalid parameters.";
}
response.sendRedirect("../manageUsers.jsp?msg=" + java.net.URLEncoder.encode(message, "UTF-8"));
%>