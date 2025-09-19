<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 9/16/2025
  Time: 10:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Form</title>
</head>
<body>
<h1>
    <c:choose>
        <c:when test="${not empty patient}">Edit Patient</c:when>
        <c:otherwise>New Patient</c:otherwise>
    </c:choose>
</h1>

<form method="post" action="${pageContext.request.contextPath}/patients">
    <input type="hidden" name="patientId" value="${patient.patientId}" />
    First name: <input name="firstName" value="${patient.firstName}" required/><br/>
    Last name: <input name="lastName" value="${patient.lastName}" required/><br/>
    Email: <input name="email" value="${patient.email}" /><br/>
    Phone: <input name="phone" value="${patient.phone}" /><br/>
    Address: <input name="address" value="${patient.address}" /><br/>
    Date of Birth: <input type="date" name="dateOfBirth" value="${patient.dateOfBirth}" /><br/>
    Medical History: <textarea name="medicalHistory">${patient.medicalHistory}</textarea><br/>
    Allergies: <input name="allergies" value="${patient.allergies}" /><br/>
    <button type="submit">Save</button>
</form>

<a href="${pageContext.request.contextPath}/patients">Back to list</a>
</body>
</html>

