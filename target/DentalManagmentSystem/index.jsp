<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 9/17/2025
  Time: 2:23 AM
  To change this template use File | Settings | File Templates.
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Redirect user to /patients when opening the root URL
    response.sendRedirect(request.getContextPath() + "/patients");
%>
