<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security check
    if (session.getAttribute("username") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Access denied. Admins only.");
        return;
    }
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — Dental Clinic</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Nunito', sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #e4edf9);
            padding: 0;
            margin: 0;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: #1a73e8 !important;
        }

        .navbar-brand i {
            color: #ff6b9d;
            margin-right: 8px;
        }

        .dashboard-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 40px;
        }

        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: white;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        .card-header {
            background: linear-gradient(135deg, #1a73e8, #0d47a1);
            color: white;
            border-radius: 16px 16px 0 0 !important;
            font-weight: 600;
            padding: 20px;
        }

        .btn-dental {
            background: linear-gradient(135deg, #1a73e8, #0d47a1);
            border: none;
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            width: 100%;
            text-align: center;
        }

        .btn-dental:hover {
            background: linear-gradient(135deg, #0d47a1, #0a3d8a);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(10, 61, 138, 0.3);
        }

        .btn-outline-dental {
            color: #1a73e8;
            border: 2px solid #1a73e8;
            background: transparent;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            width: 100%;
            text-align: center;
        }

        .btn-outline-dental:hover {
            background: #1a73e8;
            color: white;
        }

        .welcome-box {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 30px;
            border-left: 5px solid #1a73e8;
        }

        .welcome-box h2 {
            color: #1a73e8;
            margin-bottom: 10px;
        }

        .welcome-box p {
            color: #555;
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .dashboard-container {
                margin: 20px;
                padding: 20px;
            }
            .btn-dental, .btn-outline-dental {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>

<!-- Simple Navbar -->
<nav class="navbar navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="bi bi-capsule-pill"></i> DentalAdmin
        </a>
        <span class="navbar-text me-3">
                Logged in as: <strong><%= username %></strong>
            </span>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-outline-danger btn-sm">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>
</nav>

<!-- Dashboard Container -->
<div class="dashboard-container">

    <!-- Welcome Section -->
    <div class="welcome-box">
        <h2>Welcome, Admin!</h2>
        <p>Manage your dental clinic with ease. You’re logged in as: <strong><%= username %></strong></p>
    </div>

    <!-- Action Cards -->
    <div class="row g-4">
        <!-- Manage Patients -->
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <i class="bi bi-people me-2"></i> Manage Patients
                </div>
                <div class="card-body text-center">
                    <p class="mb-4">View, add, or edit patient records.</p>
                    <a href="${pageContext.request.contextPath}/patients?action=list">
                        <i class="bi bi-eye me-2"></i> View Patients
                    </a>
                </div>
            </div>
        </div>

        <!-- Logout Card -->
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-danger">
                    <i class="bi bi-shield-lock me-2"></i> Security
                </div>
                <div class="card-body text-center">
                    <p class="mb-4">End your session securely.</p>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-outline-dental">
                        <i class="bi bi-box-arrow-right me-2"></i> Logout Now
                    </a>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Bootstrap JS (optional, for mobile navbar if you expand later) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>