<!-- webapp/pages/userProfile/patientDashboard.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // Check if user is logged in
  if (session.getAttribute("username") == null) {
    response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Please login first");
    return;
  }

  // Enforce role: only patients allowed
  String role = (String) session.getAttribute("role");
  if (!"patient".equals(role)) {
    response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Access denied. Patients only.");
    return;
  }

  String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Patient Dashboard</title>
</head>
<body>
<h1>Welcome, Patient!</h1>
<p>You are logged in as: <%= session.getAttribute("username") %></p>

<h2>My Information</h2>
<ul>
  <li><a href="#">View Medical History</a></li>
  <li><a href="logout.jsp">Logout</a></li>
</ul>
</body>
</html>