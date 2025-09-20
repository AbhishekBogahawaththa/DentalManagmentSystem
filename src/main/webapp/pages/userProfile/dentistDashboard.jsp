<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Please login first");
        return;
    }

    // Enforce role: only dentists allowed
    String role = (String) session.getAttribute("role");
    if (!"dentist".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Access denied. Dentists only.");
        return;
    }

    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dentist Dashboard — Dental Clinic</title>

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

        /* Dashboard Action Cards */
        .dashboard-card {
            flex: 1;
            min-width: 300px;
            background: white;
            padding: 50px 30px;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            border: 1px solid #e5e7eb;
            text-align: center;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .dashboard-icon {
            font-size: 5rem;
            color: var(--dark-blue);
            margin-bottom: 25px;
            background: rgba(0, 0, 139, 0.05);
            width: 120px;
            height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            box-shadow: 0 5px 15px rgba(0, 0, 139, 0.1);
        }

        .dashboard-card h3 {
            color: var(--dark-blue);
            font-weight: 700;
            margin-bottom: 15px;
            font-size: 1.5rem;
        }

        .dashboard-card p {
            color: #555;
            font-size: 1rem;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .btn-action {
            background: var(--dark-blue);
            color: white;
            border: none;
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 139, 0.3);
            font-size: 1.1rem;
            text-decoration: none;
            display: inline-block;
        }

        .btn-action:hover {
            background: #00006b;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 139, 0.4);
        }

        @media (max-width: 992px) {
            .main-container {
                flex-direction: column;
            }
            .dashboard-card {
                width: 100%;
                max-width: none;
            }
        }

        @media (max-width: 768px) {
            .dashboard-card {
                padding: 40px 20px;
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
                Logged in as: <strong><%= username %></strong>
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

        <!-- View Patient Records Card -->
        <div class="dashboard-card">
            <div class="dashboard-icon">
                <i class="fas fa-notes-medical"></i>
            </div>
            <h3>View Patient Records</h3>
            <p>Access and review detailed medical records, treatment history, and upcoming appointments for your patients.</p>
            <a href="${pageContext.request.contextPath}/jsp/listpatients.jsp" class="btn-action">
                <i class="fas fa-eye me-2"></i> View Records
            </a>
        </div>

        <!-- Optional: Add More Cards Later (e.g., Schedule, Notifications, etc.) -->
        <!--
        <div class="dashboard-card">
            <div class="dashboard-icon">
                <i class="fas fa-calendar-check"></i>
            </div>
            <h3>View Appointments</h3>
            <p>Check your daily or weekly schedule of patient appointments and procedures.</p>
            <a href="#" class="btn-action">
                <i class="fas fa-calendar-alt me-2"></i> My Schedule
            </a>
        </div>
        -->

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>