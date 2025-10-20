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
    <title>My Medical History — Dental Clinic</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-dark: #0a0f2c;
            --secondary-dark: #121a3b;
            --accent-blue: #2a52be;
            --light-blue: #60a5fa;
            --glow-blue: #4d7cff;
            --text-light: #f0f4f8;
            --text-muted: #b0c4de;
            --card-bg: rgba(25, 35, 65, 0.85);
            --card-border: rgba(70, 90, 150, 0.3);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            --hover-glow: 0 0 20px rgba(77, 124, 255, 0.4);
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background: url('https://images.pexels.com/photos/7803060/pexels-photo-7803060.jpeg?auto=compress&cs=tinysrgb&w=1920') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-light);
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
            background: linear-gradient(135deg, rgba(10, 15, 44, 0.7) 0%, rgba(18, 26, 59, 0.8) 100%);
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
            box-shadow: var(--hover-glow);
            border-color: transparent;
        }

        .main-container {
            display: flex;
            flex-direction: column;
            gap: 30px;
            padding: 60px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .history-card {
            background: var(--card-bg);
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            border: 1px solid var(--card-border);
            backdrop-filter: blur(10px);
        }

        .history-card h3 {
            color: var(--light-blue);
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .table {
            color: var(--text-light);
        }

        .table thead th {
            background-color: rgba(42, 82, 190, 0.6);
            color: white;
            border: none;
            font-weight: 600;
            backdrop-filter: blur(5px);
        }

        .table tbody tr {
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .table tbody tr:hover {
            background-color: rgba(77, 124, 255, 0.15);
        }

        .badge-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .badge-completed {
            background-color: rgba(34, 197, 94, 0.2);
            color: #a7f3d0;
            border: 1px solid rgba(34, 197, 94, 0.4);
        }

        .badge-pending {
            background-color: rgba(234, 179, 8, 0.2);
            color: #fde047;
            border: 1px solid rgba(234, 179, 8, 0.4);
        }

        .btn-back {
            background: var(--accent-blue);
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 30px;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
            box-shadow: 0 4px 10px rgba(42, 82, 190, 0.3);
        }

        .btn-back:hover {
            background: #1e3c72;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(42, 82, 190, 0.5);
        }

        .alert-info {
            background: rgba(30, 60, 114, 0.6);
            border: 1px solid var(--card-border);
            color: var(--text-muted);
            border-radius: 12px;
            padding: 1.25rem;
            text-align: center;
        }

        @media (max-width: 768px) {
            .history-card {
                padding: 25px;
            }
            .table td, .table th {
                font-size: 0.9rem;
                padding: 10px;
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

        <!-- Medical History Card -->
        <div class="history-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3>
                    <i class="fas fa-file-medical me-2"></i>
                    Medical History for: <%= session.getAttribute("username") %>
                </h3>
                <a href="javascript:history.back()" class="btn-back">
                    <i class="fas fa-arrow-left me-1"></i> Back
                </a>
            </div>

            <c:choose>
                <c:when test="${empty medicalRecords}">
                    <div class="alert alert-info">
                        No medical records found.
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Date</th>
                            <th>Procedure</th>
                            <th>Dentist</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="record" items="${medicalRecords}">
                            <tr>
                                <td>${record.date}</td>
                                <td>${record.procedureName}</td>
                                <td>${record.dentist}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${record.status == 'Completed'}">
                                            <span class="badge badge-completed">Completed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-pending">${record.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>