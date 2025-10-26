<%@ page import="java.io.*, java.sql.*" %>
<%@ include file="DBConnection.jsp" %>

<%
String userId = request.getParameter("user_id");
if (userId == null) return;

PreparedStatement ps = conn.prepareStatement("SELECT photo FROM users WHERE user_id=?");
ps.setString(1, userId);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
    byte[] photo = rs.getBytes("photo");
    if (photo != null) {
        response.setContentType("image/jpeg");
        OutputStream outStream = response.getOutputStream();
        outStream.write(photo);
        outStream.flush();
        outStream.close();
    }
}
rs.close();
ps.close();
conn.close();
%>
