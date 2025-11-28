
<%
    String user_role = (String) session.getAttribute("role");

    if (!"admin".equals(user_role)) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
