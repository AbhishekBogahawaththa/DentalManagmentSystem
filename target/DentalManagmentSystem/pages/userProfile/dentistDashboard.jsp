<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Please login first");
        return;
    }
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            z-index: 3;
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
            gap: 30px;
            padding: 40px 20px;
            max-width: 1400px;
            margin: 0 auto;
            flex-wrap: wrap;
            justify-content: center;
        }

        .dashboard-card {
            flex: 1;
            min-width: 300px;
            max-width: 500px;
            background: var(--card-bg);
            padding: 50px 30px;
            border-radius: 20px;
            box-shadow: var(--shadow);
            border: 1px solid var(--card-border);
            text-align: center;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(10px);
        }

        .dashboard-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4), var(--hover-glow);
            border-color: var(--glow-blue);
        }

        .dashboard-icon {
            font-size: 5rem;
            color: var(--light-blue);
            margin-bottom: 25px;
            background: rgba(77, 124, 255, 0.1);
            width: 120px;
            height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            box-shadow: 0 5px 20px rgba(77, 124, 255, 0.2);
            transition: all 0.3s ease;
        }

        .dashboard-card:hover .dashboard-icon {
            transform: scale(1.1);
            box-shadow: 0 8px 30px rgba(77, 124, 255, 0.4);
            color: var(--glow-blue);
        }

        .dashboard-card h3 {
            color: var(--light-blue);
            font-weight: 700;
            margin-bottom: 15px;
            font-size: 1.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .dashboard-card p {
            color: var(--text-muted);
            font-size: 1rem;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .btn-action {
            background: var(--accent-blue);
            color: white;
            border: none;
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(42, 82, 190, 0.4);
            font-size: 1.1rem;
            text-decoration: none;
            display: inline-block;
            position: relative;
            overflow: hidden;
        }

        .btn-action:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: 0.5s;
        }

        .btn-action:hover:before {
            left: 100%;
        }

        .btn-action:hover {
            background: #1e3c72;
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 6px 25px rgba(42, 82, 190, 0.6);
        }

        @media (max-width: 992px) {
            .main-container {
                flex-direction: column;
                align-items: center;
            }
            .dashboard-card {
                width: 100%;
                max-width: 500px;
            }
        }

        @media (max-width: 768px) {
            .dashboard-card {
                padding: 40px 20px;
            }
            .dashboard-card h3 {
                font-size: 1.3rem;
            }
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
                Logged in as: <strong><%= username %></strong>
            </span>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-logout">
                <i class="fas fa-sign-out-alt me-1"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="main-container">

        <div class="dashboard-card">
            <div class="dashboard-icon">
                <i class="fas fa-notes-medical"></i>
            </div>
            <h3>View Patient Records</h3>
            <p>Access and review detailed medical records, treatment history, and upcoming appointments for your patients.</p>
            <a href="${pageContext.request.contextPath}/PatientServlet" class="btn-action">
                <i class="fas fa-eye me-2"></i> View Records
            </a>
        </div>

        <!-- You can uncomment and add more cards as needed -->
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>