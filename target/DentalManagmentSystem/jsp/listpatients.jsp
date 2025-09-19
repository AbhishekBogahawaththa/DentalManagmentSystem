<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Security check
    if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Management — Dental Clinic</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --dental-primary: #1a73e8;
            --dental-primary-light: #e8f0fe;
            --dental-secondary: #00bfa5;
            --dental-danger: #f44336;
            --dental-bg: #f8fafc;
        }

        body {
            font-family: 'Quicksand', sans-serif;
            background-color: var(--dental-bg);
            color: #333;
            padding-bottom: 80px;
        }

        .navbar {
            background: linear-gradient(135deg, var(--dental-primary), #0d47a1);
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
        }

        .navbar-brand i {
            margin-right: 10px;
            color: #ffd700;
        }

        .container-dashboard {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .page-header {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            border-left: 5px solid var(--dental-primary);
        }

        .page-header h1 {
            font-weight: 700;
            color: var(--dental-primary);
            margin-bottom: 5px;
        }

        .page-header p.lead {
            color: #666;
            font-weight: 500;
        }

        .btn-dental-primary {
            background: linear-gradient(135deg, var(--dental-primary), #0d47a1);
            border: none;
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            box-shadow: 0 3px 8px rgba(26, 115, 232, 0.3);
            transition: all 0.3s ease;
        }

        .btn-dental-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(26, 115, 232, 0.4);
        }

        .btn-dental-secondary {
            background: white;
            border: 2px solid var(--dental-primary);
            color: var(--dental-primary);
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-dental-secondary:hover {
            background: var(--dental-primary);
            color: white;
        }

        .table thead th {
            background: var(--dental-primary-light);
            color: var(--dental-primary);
            font-weight: 600;
            border-top: none;
            vertical-align: middle;
        }

        .table td {
            vertical-align: middle;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f5f9;
            transform: scale(1.005);
            transition: all 0.2s ease;
        }

        .action-btn {
            padding: 6px 12px;
            font-size: 0.875rem;
            border-radius: 8px;
            margin-right: 5px;
        }

        .action-btn i {
            margin-right: 4px;
        }

        .alert {
            border-radius: 12px;
            padding: 16px 20px;
            font-weight: 500;
            border: none;
            box-shadow: 0 3px 8px rgba(0,0,0,0.08);
        }

        .alert-success {
            background: linear-gradient(135deg, #e8f5e9, #c8e6c9);
            color: #2e7d32;
        }

        .alert-danger {
            background: linear-gradient(135deg, #ffebee, #ffcdd2);
            color: #c62828;
        }

        @media (max-width: 768px) {
            .container-dashboard {
                margin: 20px;
                padding: 0;
            }
            .page-header {
                padding: 20px;
            }
            .btn {
                width: 100%;
                margin-bottom: 10px;
            }
            .table td, .table th {
                font-size: 0.875rem;
                padding: 8px;
            }
        }
    </style>
</head>
<body>

<!-- Top Navbar -->
<nav class="navbar">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-tooth"></i> DentalCare Admin
        </a>
        <span class="text-white">
                Logged in as: <strong><%= session.getAttribute("username") %></strong>
            </span>
    </div>
</nav>

<!-- Main Container -->
<div class="container-dashboard">

    <!-- Header Section -->
    <div class="page-header">
        <h1><i class="fas fa-users"></i> Patient Management</h1>
        <p class="lead">Managing smiles, one patient at a time</p>
    </div>

    <!-- Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-${messageType} alert-dismissible fade show d-flex align-items-center" role="alert">
            <i class="fas ${messageType == 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle'} me-3"></i>
            <span>${message}</span>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Add Button -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/patients?action=new" class="btn btn-dental-primary">
            <i class="fas fa-plus me-2"></i> Add New Patient
        </a>
        <a href="${pageContext.request.contextPath}/pages/userProfile/adminDashboard.jsp" class="btn btn-dental-secondary">
            <i class="fas fa-arrow-left me-2"></i> Back to Dashboard
        </a>
    </div>

    <!-- Patient Table -->
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                    <tr>
                        <th class="text-center" style="width: 5%">ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th class="text-center" style="width: 10%">DOB</th>
                        <th>Medical History</th>
                        <th class="text-center" style="width: 15%">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${patients}">
                        <tr>
                            <td class="text-center fw-bold">${p.patientId}</td>
                            <td>${p.firstName}</td>
                            <td>${p.lastName}</td>
                            <td><a href="mailto:${p.email}" class="text-decoration-none">${p.email}</a></td>
                            <td>${p.phone}</td>
                            <td class="text-muted">${p.address}</td>
                            <td class="text-center">${p.dateOfBirth}</td>
                            <td class="text-muted">${p.medicalHistory}</td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/patients?action=edit&id=${p.patientId}"
                                   class="btn btn-sm action-btn btn-outline-primary">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/patients?action=delete&id=${p.patientId}"
                                   class="btn btn-sm action-btn btn-outline-danger"
                                   onclick="return confirm('Are you sure you want to delete patient #${p.patientId} - ${p.firstName} ${p.lastName}?')">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>