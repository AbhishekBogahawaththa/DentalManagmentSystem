<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
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
    <title>Patient Records — Dental Clinic</title>

    <!-- ✅ FIXED: Removed extra spaces in CDN URLs -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-dark: #0a0f2c;
            --secondary-dark: #121a3b;
            --accent-blue: #2a52be;
            --light-blue: #60a5fa;
            --glow-blue: #4d7cff;
            --text-light: #f0f4f8;
            --text-muted: #b0c4de;
            --card-bg: rgba(15, 23, 42, 0.85);
            --card-border: rgba(70, 90, 150, 0.3);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            /* ✅ FIXED: Removed extra spaces in URL */
            background: url('https://images.pexels.com/photos/7803060/pexels-photo-7803060.jpeg?auto=compress&cs=tinysrgb&w=1920') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-light);
            min-height: 100vh;
            position: relative;
            text-shadow: 0 1px 2px rgba(0,0,0,0.2);
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(10, 15, 44, 0.6) 0%, rgba(18, 26, 59, 0.75) 100%);
            z-index: 1;
        }

        .container-fluid {
            position: relative;
            z-index: 2;
            padding: 0;
        }

        .navbar {
            background: rgba(18, 26, 59, 0.9);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
            padding: 1rem 0;
            border-bottom: 1px solid var(--card-border);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--light-blue) !important;
            display: flex;
            align-items: center;
            gap: 10px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .navbar-brand i {
            color: var(--light-blue);
            font-size: 1.8rem;
            text-shadow: 0 0 8px var(--glow-blue);
        }

        .navbar-text {
            color: var(--text-light);
            font-weight: 500;
            text-shadow: 0 1px 2px rgba(0,0,0,0.5);
        }

        .btn-logout {
            background: rgba(255, 255, 255, 0.1);
            color: var(--light-blue);
            border: 1px solid var(--light-blue);
            padding: 6px 16px;
            font-weight: 600;
            border-radius: 30px;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            backdrop-filter: blur(5px);
        }

        .btn-logout:hover {
            background: var(--accent-blue);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 0 20px rgba(77, 124, 255, 0.4);
            border-color: transparent;
        }

        .main-container {
            display: flex;
            gap: 30px;
            padding: 40px 20px;
            max-width: 1400px;
            margin: 0 auto;
            flex-wrap: wrap;
        }

        .patient-list {
            flex: 1;
            background: var(--card-bg);
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            border: 1px solid var(--card-border);
            backdrop-filter: blur(10px);
        }

        .patient-list h3 {
            color: var(--light-blue);
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        /* 🔥 DARK TABLE — FULL OVERRIDE */
        .table {
            color: #f8fafc !important;
            background: #0f172a !important;
            border: 1px solid #334155;
            border-radius: 8px;
            overflow: hidden;
        }

        .table thead th {
            background: #1e293b !important;
            color: #e2e8f0 !important;
            font-weight: 600;
            border: none;
            padding: 12px 15px;
            text-align: left;
        }

        .table tbody tr {
            background-color: #0f172a !important;
            color: #f8fafc !important;
            border-bottom: 1px solid #334155;
        }

        .table tbody tr:hover {
            background-color: #1e293b !important;
        }

        .table td,
        .table th {
            color: #f8fafc !important; /* ✅ CRITICAL: forces light text */
            vertical-align: middle;
            padding: 12px 15px;
            white-space: nowrap;
        }

        .table td.text-muted {
            color: #94a3b8 !important;
        }

        /* Action Links */
        .action-link {
            text-decoration: none;
            font-weight: 500;
            padding: 6px 12px;
            border-radius: 6px;
            display: inline-block;
            transition: all 0.2s ease;
        }

        .action-link.edit {
            color: #60a5fa;
            background: rgba(96, 165, 250, 0.1);
        }

        .action-link.edit:hover {
            background: rgba(96, 165, 250, 0.2);
        }

        .action-link.delete {
            color: #ef4444;
            background: rgba(239, 68, 68, 0.1);
        }

        .action-link.delete:hover {
            background: rgba(239, 68, 68, 0.2);
        }

        .btn-outline-primary,
        .btn-outline-secondary {
            border-color: var(--light-blue);
            color: var(--light-blue);
            background: transparent;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background: var(--accent-blue);
            border-color: var(--accent-blue);
            color: white;
            box-shadow: 0 0 20px rgba(77, 124, 255, 0.4);
        }

        .btn-outline-secondary:hover {
            background: rgba(100, 116, 139, 0.3);
            border-color: #64748b;
            color: white;
        }

        @media (max-width: 992px) {
            .main-container {
                flex-direction: column;
            }
            .patient-list {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .patient-list {
                padding: 25px;
            }
            .table td, .table th {
                padding: 10px;
                font-size: 0.875rem;
            }
            .patient-list h3 {
                font-size: 1.3rem;
            }
            .action-link {
                font-size: 0.8rem;
                padding: 4px 8px;
            }
        }
        /* 🔥 CUSTOM DARK TABLE — NO BOOTSTRAP CONFLICTS */
        .custom-table {
            width: 100%;
            border-collapse: collapse;
            color: #f8fafc;
            background: #0f172a;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        .custom-table thead th {
            background: #1e293b;
            color: #e2e8f0;
            font-weight: 600;
            padding: 12px 15px;
            text-align: left;
            border-bottom: 2px solid #334155;
        }

        .custom-table tbody tr {
            background-color: #0f172a;
            color: #f8fafc;
            border-bottom: 1px solid #334155;
        }

        .custom-table tbody tr:hover {
            background-color: #1e293b;
        }

        .custom-table td,
        .custom-table th {
            padding: 12px 15px;
            vertical-align: middle;
            white-space: nowrap;
            color: #f8fafc !important;
        }

        .custom-table td.text-muted {
            color: #94a3b8 !important;
        }

        /* Action Links */
        .custom-table .action-link {
            text-decoration: none;
            font-weight: 500;
            padding: 6px 12px;
            border-radius: 6px;
            display: inline-block;
            transition: all 0.2s ease;
        }

        .custom-table .action-link.edit {
            color: #60a5fa;
            background: rgba(96, 165, 250, 0.1);
        }

        .custom-table .action-link.edit:hover {
            background: rgba(96, 165, 250, 0.2);
        }

        .custom-table .action-link.delete {
            color: #ef4444;
            background: rgba(239, 68, 68, 0.1);
        }

        .custom-table .action-link.delete:hover {
            background: rgba(239, 68, 68, 0.2);
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-tooth"></i> Dental Clinic Management
        </a>
        <div class="d-flex align-items-center">
            <span class="navbar-text me-3">
                Logged in as: <strong><%= session.getAttribute("username") %></strong>
            </span>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-logout">
                <i class="fas fa-sign-out-alt me-1"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="main-container">

        <div class="patient-list">
            <h3><i class="fas fa-list"></i> All Patients</h3>

            <div class="d-flex justify-content-between align-items-center mb-4">
                <a href="${pageContext.request.contextPath}/PatientServlet?action=new" class="btn btn-outline-primary">
                    <i class="fas fa-user-plus me-2"></i> Add New Patient
                </a>
                <a href="${pageContext.request.contextPath}/pages/userProfile/adminDashboard.jsp" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i> Back to Dashboard
                </a>
            </div>

            
            <table class="custom-table">
                <thead>
                <tr>
                    <th>NIC</th>
                    <th>Patient ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>DOB</th>
                    <th>Gender</th>
                    <th>Medical History</th>
                    <th class="text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${patients}">
                    <tr>
                        <td>${p.nic}</td>
                        <td>${p.id}</td>
                        <td>${p.firstName}</td>
                        <td>${p.lastName}</td>
                        <td><a href="mailto:${p.email}" class="text-decoration-none" style="color: var(--light-blue);">${p.email}</a></td>
                        <td>${p.phone}</td>
                        <td class="text-muted">${p.address}</td>
                        <td class="text-center">${p.dob}</td>
                        <td>${p.gender}</td>
                        <td class="text-muted">${p.medicalHistory}</td>
                        <td class="text-center">
                            <a href="${pageContext.request.contextPath}/PatientServlet?action=edit&id=${p.id}" class="action-link edit">
                                <i class="fas fa-edit me-1"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/PatientServlet?action=delete&id=${p.id}" class="action-link delete"
                               onclick="return confirm('Are you sure you want to delete patient #${p.id} - ${p.firstName} ${p.lastName}?')">
                                <i class="fas fa-trash-alt me-1"></i> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</div>

<!-- ✅ FIXED: Removed extra spaces -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>