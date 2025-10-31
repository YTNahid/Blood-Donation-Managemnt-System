<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="org.json.*" %>
<%@ include file="DBConnection.jsp" %>

<%
response.setContentType("application/json");
JSONObject json = new JSONObject();
JSONArray results = new JSONArray();

String latParam = request.getParameter("latitude");
String lonParam = request.getParameter("longitude");
String radiusParam = request.getParameter("radius"); // in km

if (latParam == null || lonParam == null || radiusParam == null) {
    json.put("success", false);
    json.put("message", "Missing parameters");
    out.print(json.toString());
    return;
}

double latitude = Double.parseDouble(latParam);
double longitude = Double.parseDouble(lonParam);
double radius = Double.parseDouble(radiusParam);

PreparedStatement ps = null;
ResultSet rs = null;

try {
    // SQL only ensures donation_history.status IS NULL
    String sql =
        "SELECT br.request_id, br.requester_id, br.blood_group, br.location, br.contact_info, " +
        "       br.reason, br.district, br.latitude, br.longitude, br.request_date, br.urgent, br.due_date " +
        "FROM blood_requests br " +
        "WHERE NOT EXISTS (SELECT 1 FROM donation_history dh " +
        "                  WHERE dh.request_id = br.request_id " +
        "                  AND dh.status IS NOT NULL)";

    ps = conn.prepareStatement(sql);
    rs = ps.executeQuery();

    double R = 6371.0; // Earth radius in km

    while (rs.next()) {
        Double reqLat = rs.getObject("latitude") != null ? rs.getDouble("latitude") : null;
        Double reqLon = rs.getObject("longitude") != null ? rs.getDouble("longitude") : null;

        Double distance = null;
        if (reqLat != null && reqLon != null) {
            double dLat = Math.toRadians(reqLat - latitude);
            double dLon = Math.toRadians(reqLon - longitude);
            double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                       Math.cos(Math.toRadians(latitude)) * Math.cos(Math.toRadians(reqLat)) *
                       Math.sin(dLon / 2) * Math.sin(dLon / 2);
            double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            distance = R * c;
        }

        System.out.println("Calculated distance: " + distance);

        // Only include if within radius
        if (distance != null && distance <= radius) {
            JSONObject obj = new JSONObject();
            obj.put("request_id", rs.getInt("request_id"));
            obj.put("requester_id", rs.getInt("requester_id"));
            obj.put("blood_group", rs.getString("blood_group"));
            obj.put("location", rs.getString("location"));
            obj.put("contact_info", rs.getString("contact_info"));
            obj.put("reason", rs.getString("reason"));
            obj.put("district", rs.getString("district"));
            obj.put("latitude", reqLat);
            obj.put("longitude", reqLon);
            obj.put("request_date", rs.getDate("request_date"));
            obj.put("urgent", rs.getInt("urgent"));
            obj.put("due_date", rs.getDate("due_date"));
            obj.put("distance", distance);
            results.put(obj);
        }
    }

    json.put("success", true);
    json.put("results", results);

} catch (Exception e) {
    json.put("success", false);
    json.put("error", e.getMessage());
} finally {
    if (rs != null) try { rs.close(); } catch (Exception ignore) {}
    if (ps != null) try { ps.close(); } catch (Exception ignore) {}
    if (conn != null) try { conn.close(); } catch (Exception ignore) {}
}

out.print(json.toString());
%>
