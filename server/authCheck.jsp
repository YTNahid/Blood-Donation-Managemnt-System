
<%
    String currentPage = request.getRequestURI();
    Integer user_Id = (Integer) session.getAttribute("userId");

    // Check if user is logged in
    if (user_Id == null && !currentPage.endsWith("login.jsp")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
	
    // If logged in and on login page, redirect to dashboard
    if (user_Id != null && currentPage.endsWith("login.jsp")) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
