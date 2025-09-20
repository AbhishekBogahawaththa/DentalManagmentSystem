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
    <title>Patient Records — Dental Clinic</title>

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
            margin: 0;
            padding: 0;
            background: url('https://images.pexels.com/photos/7803060/pexels-photo-7803060.jpeg?auto=compress&cs=tinysrgb&w=1920') no-repeat center center fixed;
            background-size: cover;
            color: white;
            min-height: 100vh;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        .container-fluid {
            position: relative;
            z-index: 2;
            padding: 0;
        }

        .navbar {
            background-color: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 1rem 0;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--dark-blue) !important;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-brand i {
            color: var(--dark-blue);
            font-size: 1.8rem;
        }

        .navbar-text {
            color: #333;
            font-weight: 500;
        }

        .btn-logout {
            background-color: white;
            color: var(--dark-blue);
            border: 2px solid var(--dark-blue);
            padding: 6px 16px;
            font-weight: 600;
            border-radius: 30px;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .btn-logout:hover {
            background-color: var(--dark-blue);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,139,0.2);
        }

        .main-container {
            display: flex;
            gap: 30px;
            padding: 40px 20px;
            max-width: 1400px;
            margin: 0 auto;
            flex-wrap: wrap;
        }

        /* Patient List Section */
        .patient-list {
            flex: 1;
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            border: 1px solid #e5e7eb;
        }

        .patient-list h3 {
            color: var(--dark-blue);
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .patient-list h3 i {
            font-size: 1.3rem;
        }

        .table thead th {
            background-color: var(--dark-blue);
            color: white;
            border: none;
            font-weight: 600;
            white-space: nowrap;
        }

        .table tbody tr:hover {
            background-color: #f0f5ff;
        }

        .table td, .table th {
            vertical-align: middle;
            padding: 15px;
            white-space: nowrap;
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
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
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

<!-- Main Container -->
<div class="container-fluid">
    <div class="main-container">

        <!-- Patient List -->
        <div class="patient-list">
            <h3><i class="fas fa-list"></i> All Patients</h3>

            <table class="table table-hover align-middle">
                <thead>
                <tr>
                    <th>NIC</th>
                    <th>ID</th>
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
                        <td>${p.nic != null ? p.nic : '—'}</td>
                        <td>${p.id}</td>
                        <td>${p.firstName}</td>
                        <td>${p.lastName}</td>
                        <td><a href="mailto:${p.email}" class="text-decoration-none">${p.email}</a></td>
                        <td>${p.phone}</td>
                        <td class="text-muted">${p.address != null && !p.address.isEmpty() ? p.address : '—'}</td>
                        <td class="text-center">${p.dob != null ? p.dob : '—'}</td>
                        <td>${p.gender != null ? p.gender : '—'}</td>
                        <td class="text-muted">${p.medicalHistory != null && !p.medicalHistory.isEmpty() ? p.medicalHistory : '—'}</td>
                        <td class="text-center">
                            <a href="${pageContext.request.contextPath}/patients?action=edit&id=${p.id}"
                               class="btn btn-sm btn-outline-primary me-2 px-3 py-1"
                               style="border-radius: 8px; font-weight: 500;">
                                <i class="fas fa-edit me-1"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/patients?action=delete&id=${p.id}"
                               class="btn btn-sm btn-outline-danger px-3 py-1"
                               style="border-radius: 8px; font-weight: 500;"
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>