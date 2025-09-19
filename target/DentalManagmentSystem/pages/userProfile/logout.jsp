<!-- webapp/pages/userProfile/logout.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  session.invalidate();
  response.sendRedirect("login.jsp?message=Logged out successfully.");
%>