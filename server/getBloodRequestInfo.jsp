<%@ page import="java.sql.*, java.util.*"%>
<%@ page import="org.json.JSONObject"%>
<%@ include file="DBConnection.jsp"%>

<%
JSONObject json = new JSONObject();
response.setContentType("application/json");

try {
    Integer userId = (Integer) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("role");
    String latStr = request.getParameter("latitude");
    String longStr = request.getParameter("longitude");
    String own = request.getParameter("own");
    String nearby = request.getParameter("nearby");
    String urgent = request.getParameter("urgent");
    String bloodGroup = request.getParameter("blood_group");
    Integer searchRequestId = null;
    String searchRequestIdStr = request.getParameter("searchRequestId");
    if (searchRequestIdStr != null && !searchRequestIdStr.isEmpty()) {
        searchRequestId = Integer.parseInt(searchRequestIdStr);
    }

    Double userLat = null;
    Double userLon = null;

    try {
        userLat = latStr != null ? Double.parseDouble(latStr) : null;
        userLon = longStr != null ? Double.parseDouble(longStr) : null;
    } catch (Exception e) {
        json.put("error", "Invalid latitude or longitude");
        out.print(json.toString());
        return;
    }

    // Build SQL with JOIN to donation_history
    StringBuilder sql = new StringBuilder(
        "SELECT br.request_id, br.requester_id, u.username, br.blood_group, br.location, br.contact_info, " +
        "br.reason, br.district, br.latitude, br.longitude, br.request_date, br.due_date, br.urgent, " +
        "dh.status " +
        "FROM blood_requests br " +
        "JOIN users u ON br.requester_id = u.user_id " +
        "LEFT JOIN donation_history dh ON br.request_id = dh.request_id " +
        "WHERE 1=1 "
    );

    List<Object> params = new ArrayList<>();

    if (bloodGroup != null && !bloodGroup.isEmpty()) {
        sql.append("AND br.blood_group = ? ");
        params.add(bloodGroup);
    }

    if ("true".equals(urgent)) {
        sql.append("AND br.urgent = 1 ");
    }

    if ("true".equals(own) && userId != null) {
        sql.append("AND br.requester_id = ? ");
        params.add(userId);
    }

    if (searchRequestId != null) {
        sql.append("AND br.request_id = ? ");
        params.add(searchRequestId);
    }

    // Order: no donation history first, then pending, approved, rejected
    sql.append("ORDER BY CASE " +
               "WHEN dh.status IS NULL THEN 0 " +
               "WHEN dh.status = 'pending' THEN 1 " +
               "WHEN dh.status = 'approved' THEN 2 " +
               "WHEN dh.status = 'rejected' THEN 3 " +
               "ELSE 4 END, br.due_date ASC");

    PreparedStatement ps = conn.prepareStatement(sql.toString());
    for (int i = 0; i < params.size(); i++) {
        ps.setObject(i + 1, params.get(i));
    }
    ResultSet rs = ps.executeQuery();

    List<JSONObject> results = new ArrayList<>();

    double R = 6371.0; // Earth radius in km
    while (rs.next()) {
        Double reqLat = rs.getObject("latitude") != null ? rs.getDouble("latitude") : null;
        Double reqLon = rs.getObject("longitude") != null ? rs.getDouble("longitude") : null;

        Double distance = null;
        if (reqLat != null && reqLon != null && userLat != null && userLon != null) {
            double dLat = Math.toRadians(reqLat - userLat);
            double dLon = Math.toRadians(reqLon - userLon);
            double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                       Math.cos(Math.toRadians(userLat)) * Math.cos(Math.toRadians(reqLat)) *
                       Math.sin(dLon / 2) * Math.sin(dLon / 2);
            double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            distance = R * c;
        }

        JSONObject row = new JSONObject();
        row.put("current_user_id", userId);
        row.put("current_user_role", userRole);
        row.put("request_id", rs.getInt("request_id"));
        row.put("requester_id", rs.getInt("requester_id"));
        row.put("requester_username", rs.getString("username"));
        row.put("blood_group", rs.getString("blood_group"));
        row.put("location", rs.getString("location"));
        row.put("contact_info", rs.getString("contact_info"));
        row.put("reason", rs.getString("reason"));
        row.put("district", rs.getString("district"));
        row.put("latitude", reqLat);
        row.put("longitude", reqLon);
        row.put("request_date", rs.getTimestamp("request_date"));
        row.put("due_date", rs.getTimestamp("due_date"));
        row.put("urgent", rs.getInt("urgent"));
        row.put("distance", distance);
        row.put("status", rs.getString("status")); // from donation_history
        results.add(row);
    }

    rs.close();
    ps.close();

    if ("true".equals(nearby)) {
        results.sort((a, b) -> {
            Double d1 = a.optDouble("distance", Double.MAX_VALUE);
            Double d2 = b.optDouble("distance", Double.MAX_VALUE);
            return Double.compare(d1, d2);
        });
    }

    json.put("results", results);
    json.put("success", true);
    out.print(json.toString());
} catch (SQLException e) {
    json.put("error", "Database error: " + e.getMessage());
    json.put("success", false);
    out.print(json.toString());
} finally {
    try {
        conn.close();
    } catch (Exception e) {
        json.put("error", "Error closing connection: " + e.getMessage());
    }
}
%>
