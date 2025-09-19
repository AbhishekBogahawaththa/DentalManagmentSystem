<!-- webapp/pages/userProfile/adminDashboard.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h1>Welcome, Admin!</h1>
<p>You are logged in as: <%= session.getAttribute("username") %></p>

<h2>Actions</h2>
<ul>
    <li><a href="PatientServlet?action=list">Manage Patient Records</a></li>
    <li><a href="logout.jsp">Logout</a></li>
</ul>
</body>
</html>