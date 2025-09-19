<!-- webapp/pages/userProfile/dentistDashboard.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Please login first");
        return;
    }

    // Enforce role: only dentists allowed
    String role = (String) session.getAttribute("role");
    if (!"dentist".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Access denied. Dentists only.");
        return;
    }

    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dentist Dashboard</title>
</head>
<body>
<h1>Welcome, Dentist!</h1>
<p>You are logged in as: <%= session.getAttribute("username") %></p>

<h2>Actions</h2>
<ul>
    <li><a href="PatientServlet?action=list">View Patient Records</a></li>
    <li><a href="logout.jsp">Logout</a></li>
</ul>
</body>
</html>