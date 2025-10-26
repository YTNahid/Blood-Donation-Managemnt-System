<%@ page import="java.io.*, java.sql.*, java.util.*, org.json.JSONObject" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ include file="DBConnection.jsp" %>

<%
response.setContentType("application/json");
JSONObject json = new JSONObject();

try {
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (!isMultipart) {
        json.put("success", false);
        json.put("message", "Request must be multipart/form-data");
        out.print(json.toString());
        return;
    }

    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    List<FileItem> items = upload.parseRequest(request);

    String userId = null;
    byte[] photoBytes = null;

    for (FileItem item : items) {
        if (item.isFormField()) {
            if ("user_id".equals(item.getFieldName())) {
                userId = item.getString();
            }
        } else {
            if ("photo".equals(item.getFieldName()) && item.getSize() > 0) {
                InputStream input = item.getInputStream();
                photoBytes = input.readAllBytes();
            }
        }
    }

    if (userId == null || photoBytes == null) {
        json.put("success", false);
        json.put("message", "Missing user_id or photo file");
        out.print(json.toString());
        return;
    }

    PreparedStatement ps = conn.prepareStatement("UPDATE users SET photo=? WHERE user_id=?");
    ps.setBytes(1, photoBytes);
    ps.setString(2, userId);
    int updated = ps.executeUpdate();
    ps.close();

    if (updated > 0) {
        json.put("success", true);
        json.put("message", "Photo updated successfully");
    } else {
        json.put("success", false);
        json.put("message", "User not found or update failed");
    }

} catch (Exception e) {
    e.printStackTrace();
    json.put("success", false);
    json.put("message", "Error updating photo");
    json.put("error", e.getMessage());
}

out.print(json.toString());
%>
