<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if user is logged in

    if (session.getAttribute("userId") != null) {

        // User is logged in, redirect to dashboard

        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/dashboard");
    } else {

        // User is not logged in, show welcome page
        
        request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
    }
%>

