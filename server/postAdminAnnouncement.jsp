<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ include file="DBConnection.jsp" %>

<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

String title = request.getParameter("title");
String message = request.getParameter("message");
int postedBy = Integer.parseInt(request.getParameter("user_id"));

System.out.println("Title: " + title + ", Message: " + message + ", Posted By: " + postedBy);

try {
    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO announcements (title, message, posted_by) VALUES (?, ?, ?)"
    );
    ps.setString(1, title);
    ps.setString(2, message);
    ps.setInt(3, postedBy);

    int result = ps.executeUpdate();
    

    if (result > 0) {
        json.put("success", true);
        json.put("message", "Successfully posted announcement");
    } else {
        json.put("success", false);
        json.put("message", "Something went wrong");
    }
    
    ps.close();
} catch (Exception e) {
    e.printStackTrace();
    json.put("success", false);
    json.put("error", e.getMessage());
    json.put("message", "Failed to post announcement");
}
out.print(json.toString());
%>