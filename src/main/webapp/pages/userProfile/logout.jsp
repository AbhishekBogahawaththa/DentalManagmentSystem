<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // Invalidate the session
  session.invalidate();

  // Redirect to login page with success message
  String contextPath = request.getContextPath();
  response.sendRedirect(contextPath + "/pages/userProfile/login.jsp?message=Logged out successfully.");
%>