<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Dental Clinic - Patient Form</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Inter Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-dark: #0a0f2c;
            --secondary-dark: #121a3b;
            --accent-blue: #2a52be;
            --light-blue: #60a5fa;
            --glow-blue: #4d7cff;
            --text-light: #f0f4f8;
            --card-bg: rgba(25, 35, 65, 0.9);
            --card-border: rgba(70, 90, 150, 0.3);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, var(--primary-dark), var(--secondary-dark));
            margin: 0;
            padding: 40px 20px;
            color: var(--text-light);
            min-height: 100vh;
        }

        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .form-header i {
            color: var(--light-blue);
            font-size: 2.5rem;
            margin-bottom: 15px;
            text-shadow: 0 0 10px var(--glow-blue);
        }

        .form-header h1 {
            color: var(--light-blue);
            font-weight: 700;
            margin: 0;
            font-size: 2rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .form-header p {
            color: var(--text-muted);
            font-size: 1.1rem;
            margin: 10px 0 0;
        }

        .form-container {
            background: var(--card-bg);
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            border: 1px solid var(--card-border);
            max-width: 800px;
            margin: 0 auto;
            backdrop-filter: blur(10px);
        }

        .form-title {
            color: var(--light-blue);
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .form-label {
            font-weight: 600;
            color: var(--text-light);
            margin-bottom: 8px;
            display: block;
        }

        .form-control,
        .form-select {
            width: 100%;
            padding: 12px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            font-size: 1rem;
            background: rgba(0, 0, 0, 0.2);
            color: white;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: var(--light-blue);
            box-shadow: 0 0 0 3px rgba(77, 124, 255, 0.3);
            outline: none;
            background: rgba(0, 0, 0, 0.3);
        }

        .btn-submit {
            background: var(--accent-blue);
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(42, 82, 190, 0.4);
            font-size: 1.1rem;
            margin-bottom: 15px;
        }

        .btn-submit:hover {
            background: #1e3c72;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(42, 82, 190, 0.6);
        }

        .btn-back {
            background: rgba(100, 116, 139, 0.4);
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
            background: rgba(74, 85, 99, 0.6);
            transform: translateY(-2px);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .alert {
            border: none;
            border-radius: 12px;
            backdrop-filter: blur(5px);
            font-weight: 500;
        }

        .alert-success {
            background: rgba(34, 197, 94, 0.2);
            color: #a7f3d0;
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.2);
            color: #fecaca;
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

        <c:if test="${not empty param.message}">
            <div class="alert alert-${param.messageType} alert-dismissible fade show" role="alert">
                <i class="fas fa-${param.messageType == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
                    ${param.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <h2 class="form-title">
            <i class="fas fa-user-edit"></i>
            <c:choose>
                <c:when test="${patient != null}">Edit Patient</c:when>
                <c:otherwise>Add New Patient</c:otherwise>
            </c:choose>
        </h2>

        <form action="${pageContext.request.contextPath}/PatientServlet" method="post">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="id" value="${patient.id}" />

            <div class="mb-3">
                <label for="nic" class="form-label">NIC</label>
                <input type="text" name="nic" id="nic" class="form-control" value="${patient.nic}">
            </div>

            <div class="mb-3">
                <label for="firstName">First Name *</label>
                <input type="text" name="firstName" id="firstName" class="form-control" required value="${patient.firstName}">
            </div>

            <div class="mb-3">
                <label for="lastName">Last Name *</label>
                <input type="text" name="lastName" id="lastName" class="form-control" required value="${patient.lastName}">
            </div>

            <div class="mb-3">
                <label for="email">Email *</label>
                <input type="email" name="email" id="email" class="form-control" required value="${patient.email}">
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <input type="text" name="phone" id="phone" class="form-control" value="${patient.phone}">
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" name="address" id="address" class="form-control" value="${patient.address}">
            </div>

            <div class="mb-3">
                <label for="dob" class="form-label">Date of Birth</label>
                <input type="date" name="dob" id="dob" class="form-control" value="${patient.dob}">
            </div>

            <div class="mb-3">
                <label for="gender" class="form-label">Gender</label>
                <select name="gender" id="gender" class="form-select">
                    <option value="">Select Gender</option>
                    <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                    <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                    <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="medicalHistory" class="form-label">Medical History</label>
                <textarea name="medicalHistory" id="medicalHistory" class="form-control" rows="4"
                          placeholder="Allergies, conditions, medications...">${patient.medicalHistory}</textarea>
            </div>

            <button type="submit" class="btn btn-submit w-100 mb-3">
                <i class="fas fa-save me-2"></i> Save Patient
            </button>

            <a href="${pageContext.request.contextPath}/jsp/listpatients.jsp" class="btn btn-back w-100">
                <i class="fas fa-arrow-left me-2"></i> Back to Patient List
            </a>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>