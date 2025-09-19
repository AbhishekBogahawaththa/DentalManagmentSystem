<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 9/16/2025
  Time: 10:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patients</title>
</head>
<body>
<h1>Patients</h1>
<a href="${pageContext.request.contextPath}/patients?action=new">Add New Patient</a>
<table border="1" cellpadding="6" cellspacing="0">
    <tr>
        <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Actions</th>
    </tr>
    <c:forEach var="p" items="${patients}">
        <tr>
            <td>${p.patientId}</td>
            <td>${p.firstName} ${p.lastName}</td>
            <td>${p.email}</td>
            <td>${p.phone}</td>
            <td>
                <a href="${pageContext.request.contextPath}/patients?action=edit&id=${p.patientId}">Edit</a>
                |
                <a href="${pageContext.request.contextPath}/patients?action=delete&id=${p.patientId}"
                   onclick="return confirm('Delete this patient?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<h2>Hello, JSP is working!</h2>

</body>
</html>

