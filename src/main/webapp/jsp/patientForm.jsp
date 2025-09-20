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
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --dark-blue: #00008B;
            --light-blue: #60a5fa;
            --bg-gray: #f9fafb;
            --text-color: #1f2937;
            --card-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--bg-gray);
            margin: 0;
            padding: 40px 20px;
        }

        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .form-header i {
            color: var(--dark-blue);
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .form-header h1 {
            color: var(--dark-blue);
            font-weight: 700;
            margin: 0;
            font-size: 2rem;
        }

        .form-header p {
            color: #555;
            font-size: 1.1rem;
            margin: 10px 0 0;
        }

        .form-container {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            border: 1px solid #e5e7eb;
            max-width: 800px;
            margin: 0 auto;
        }

        .form-title {
            color: var(--dark-blue);
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .form-title i {
            color: var(--dark-blue);
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: var(--dark-blue);
            box-shadow: 0 0 0 3px rgba(0, 0, 139, 0.2);
            outline: none;
        }

        .btn-submit {
            background: var(--dark-blue);
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 139, 0.3);
            font-size: 1.1rem;
            margin-bottom: 15px;
        }

        .btn-submit:hover {
            background: #00006b;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 139, 0.4);
        }

        .btn-back {
            background: #6b7280;
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }

        .btn-back:hover {
            background: #4b5563;
            transform: translateY(-2px);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .row > div {
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            body {
                padding: 20px 15px;
            }
            .form-container {
                padding: 25px;
            }
            .form-header h1 {
                font-size: 1.7rem;
            }
            .form-header i {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="form-header">
        <i class="fas fa-tooth"></i>
        <h1>Dental Clinic Patient Management</h1>
        <p>Managing smiles, one patient at a time</p>
    </div>

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
                <label class="form-label"><i class="fas fa-id-card me-2"></i>NIC:</label>
                <input type="number" class="form-control" name="nic" value="${patient.nic}" required placeholder="Enter 12-digit NIC number">
            </div>

            <div class="form-group">
                <label class="form-label"><i class="fas fa-user me-2"></i>First Name:</label>
                <input type="text" class="form-control" name="firstName" value="${patient.firstName}" required>
            </div>

            <div class="form-group">
                <label class="form-label"><i class="fas fa-user me-2"></i>Last Name:</label>
                <input type="text" class="form-control" name="lastName" value="${patient.lastName}" required>
            </div>

            <div class="form-group">
                <label class="form-label"><i class="fas fa-birthday-cake me-2"></i>Date of Birth:</label>
                <input type="date" class="form-control" name="dateOfBirth" value="${patient.dateOfBirth}">
            </div>

            <div class="form-group">
                <label class="form-label"><i class="fas fa-venus-mars me-2"></i>Gender:</label>
                <select class="form-control" name="gender" required>
                    <option value="">Select Gender</option>
                    <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                    <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                    <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label"><i class="fas fa-phone me-2"></i>Phone:</label>
                <input type="tel" class="form-control" name="phone" value="${patient.phone}" required>
            </div>

            <div class="form-group">
                <label class="form-label"><i class="fas fa-envelope me-2"></i>Email:</label>
                <input type="email" class="form-control" name="email" value="${patient.email}">
            </div>

            <div class="form-group">
                <label class="form-label"><i class="fas fa-map-marker-alt me-2"></i>Address:</label>
                <input type="text" class="form-control" name="address" value="${patient.address}">
            </div>

            <div class="form-group">
                <label class="form-label"><i class="fas fa-notes-medical me-2"></i>Medical History:</label>
                <textarea class="form-control" name="medicalHistory" rows="5" placeholder="Allergies, conditions, medications...">${patient.medicalHistory}</textarea>
            </div>

            <button type="submit" class="btn btn-submit">
                <i class="fas fa-save me-2"></i>
                <c:choose>
                    <c:when test="${patient != null}">Update Patient</c:when>
                    <c:otherwise>Save Patient</c:otherwise>
                </c:choose>
            </button>
        </form>

        <a href="${pageContext.request.contextPath}/patients" class="btn btn-back mt-3">
            <i class="fas fa-arrow-left me-2"></i>Back to Patient List
        </a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>