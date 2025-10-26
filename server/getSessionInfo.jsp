<%@ page import="org.json.JSONObject" %>
<%
response.setContentType("application/json");
JSONObject json = new JSONObject();
if (session != null) {
    Object userId = session.getAttribute("userId");
    Object username = session.getAttribute("username");
    Object email = session.getAttribute("email");
    Object role = session.getAttribute("role");
    if (userId != null) json.put("user_id", userId);
    if (username != null) json.put("username", username);
    if (email != null) json.put("email", email);
    if (role != null) json.put("role", role);
    json.put("logged_in", true);
} else {
    json.put("logged_in", false);
}
out.print(json.toString());
%>