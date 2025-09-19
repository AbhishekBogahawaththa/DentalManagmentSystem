<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 9/18/2025
  Time: 8:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Dental Clinic - Patient Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }
        .dental-header {
            background: linear-gradient(135deg, #ffffff 0%, #bbdefb 100%);
            padding: 30px 20px;
            text-align: center;
            border-bottom: 4px solid #2196f3;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .dental-header h1 {
            color: #1976d2;
            font-weight: 700;
            margin: 0;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
            font-size: 2.5rem;
        }
        .dental-header p {
            color: #546e7a;
            font-size: 1.1rem;
            margin: 5px 0 0;
        }
        .tooth-icon {
            font-size: 3rem;
            color: #42a5f5;
            margin-right: 15px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .form-container {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            margin-bottom: 30px;
            border: 1px solid #e0e7ff;
        }
        .form-title {
            color: #1976d2;
            font-weight: 600;
            text-align: center;
            margin-bottom: 30px;
            font-size: 1.8rem;
        }
        .form-label {
            font-weight: 600;
            color: #1976d2;
            margin-bottom: 8px;
            display: block;
        }
        .input-custom, .textarea-custom {
            border: 2px solid #bbdefb;
            border-radius: 8px;
            padding: 12px;
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .input-custom:focus, .textarea-custom:focus {
            border-color: #2196f3;
            box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.25);
            outline: none;
        }
        .btn-submit {
            background: linear-gradient(135deg, #2196f3 0%, #1976d2 100%);
            border: none;
            width: 100%;
            padding: 15px;
            font-size: 1.2em;
            font-weight: 600;
            border-radius: 8px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            margin-bottom: 10px;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(33, 150, 243, 0.3);
            color: white;
        }
        .btn-back {
            background: linear-gradient(135deg, #757575 0%, #616161 100%);
            border: none;
            width: 100%;
            padding: 15px;
            font-size: 1.2em;
            font-weight: 600;
            border-radius: 8px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(117, 117, 117, 0.3);
            color: white;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .icon-prefix {
            position: relative;
        }
        .icon-prefix i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #2196f3;
            z-index: 10;
        }
        .icon-prefix input {
            padding-left: 45px;
        }
        .row > div {
            margin-bottom: 20px;
        }
        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
                margin: 10px;
            }
            .dental-header h1 {
                font-size: 2rem;
            }
            .tooth-icon {
                font-size: 2rem;
                margin-right: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="dental-header">
        <h1><i class="fas fa-tooth tooth-icon"></i>Dental Clinic Patient Management</h1>
        <p class="lead">Managing smiles, one patient at a time</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="form-container">
                <h2 class="form-title">
                    <i class="fas fa-user-edit"></i>
                    <c:choose>
                        <c:when test="${patient != null}">Edit Patient</c:when>
                        <c:otherwise>Add New Patient</c:otherwise>
                    </c:choose>
                </h2>

                <form action="${pageContext.request.contextPath}/patients" method="post">
                    <!-- Hidden field if editing -->
                    <c:if test="${patient != null}">
                        <input type="hidden" name="patientId" value="${patient.patientId}"/>
                    </c:if>

                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-user me-2"></i>NIC:</label>
                        <input type="text" class="form-control input-custom" name="nic" value="${patient.nic}" required>
                    </div>


                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-user me-2"></i>First Name:</label>
                        <input type="text" class="form-control input-custom" name="firstName" value="${patient.firstName}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-user me-2"></i>Last Name:</label>
                        <input type="text" class="form-control input-custom" name="lastName" value="${patient.lastName}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-birthday-cake me-2"></i>Date of Birth:</label>
                        <input type="date" class="form-control input-custom" name="dateOfBirth" value="${patient.dateOfBirth}">
                    </div>

                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-envelope me-2"></i>Gender:</label>
                        <input type="text" class="form-control input-custom" name="gender" value="${patient.gender}">
                    </div>

                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-phone me-2"></i>Phone:</label>
                        <input type="text" class="form-control input-custom" name="phone" value="${patient.phone}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-envelope me-2"></i>Email:</label>
                        <input type="email" class="form-control input-custom" name="email" value="${patient.email}">
                    </div>

                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-map-marker-alt me-2"></i>Address:</label>
                        <input type="text" class="form-control input-custom" name="address" value="${patient.address}">
                    </div>

                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-notes-medical me-2"></i>Medical History:</label>
                        <textarea class="form-control textarea-custom" name="medicalHistory" rows="5">${patient.medicalHistory}</textarea>
                    </div>

                    <button type="submit" class="btn btn-primary btn-submit">
                        <i class="fas fa-save me-2"></i>
                        <c:choose>
                            <c:when test='${patient != null}'>Update Patient</c:when>
                            <c:otherwise>Save Patient</c:otherwise>
                        </c:choose>
                    </button>
                </form>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-8">
                    <a href="${pageContext.request.contextPath}/patients" class="btn btn-secondary btn-back">
                        <i class="fas fa-arrow-left me-2"></i>Back to Patient List
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>