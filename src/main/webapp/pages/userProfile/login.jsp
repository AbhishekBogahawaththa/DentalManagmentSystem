<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dental Clinic - Login</title>

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
            background-color: var(--bg-gray);
        }

        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 1rem 0;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--dark-blue);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-brand i {
            color: var(--dark-blue);
            font-size: 1.8rem;
        }

        .nav-link {
            color: #333;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--dark-blue);
        }

        .hero {
            background: url('https://images.pexels.com/photos/7803060/pexels-photo-7803060.jpeg?auto=compress&cs=tinysrgb&w=1920') no-repeat center center;
            background-size: cover;
            height: 80vh;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 5%;
            color: white;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 600px;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
            line-height: 1.2;
            font-weight: 700;
            color: ghostwhite;
            text-shadow: none;
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            font-weight: 400;
        }

        .btn-contact {
            background-color: white;
            color: var(--dark-blue); /* ✅ Contact button text in #00008B */
            border: 2px solid var(--dark-blue);
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 30px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .btn-contact:hover {
            background-color: var(--dark-blue);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .contact-info {
            margin-top: 1rem;
            font-size: 1.1rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .contact-info strong {
            color: white;
        }

        .login-card {
            position: absolute;
            top: 50%;
            right: 5%;
            transform: translateY(-50%);
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            width: 360px;
            z-index: 3;
            border: 1px solid #e5e7eb;
        }

        .login-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .login-header i {
            color: var(--dark-blue); /* ✅ Login icon in #00008B */
            font-size: 1.8rem;
            margin-right: 10px;
        }

        .login-header h4 {
            color: var(--dark-blue); /* ✅ Login title in #00008B */
            font-weight: 600;
            margin: 0;
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

        .btn-login {
            background: var(--dark-blue); /* ✅ Button background #00008B */
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 139, 0.3);
            font-size: 1.1rem;
        }

        .btn-login:hover {
            background: #00006b; /* Slightly darker on hover */
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 139, 0.4);
        }

        .register-link {
            margin-top: 20px;
            text-align: center;
            color: #6b7280;
            font-size: 0.95rem;
        }

        .register-link a {
            color: var(--dark-blue); /* ✅ Register link in #00008B */
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .hero {
                flex-direction: column;
                height: auto;
                padding: 20px;
            }
            .hero-content {
                text-align: center;
                margin-bottom: 20px;
            }
            .hero h1 {
                font-size: 2.5rem;
            }
            .login-card {
                position: static;
                transform: none;
                margin-top: 20px;
                width: 100%;
                max-width: 360px;
                margin-left: auto;
                margin-right: auto;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fas fa-tooth"></i> Dental Clinic Management System
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Services</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1>Dental Care Centre</h1>
        <p>Looking for the best dental clinic in your area ? Our expert dental care focused on comfort, precision, and long-term oral health for a bright, healthy smile.</p>
        <a href="#" class="btn btn-contact">
            <i class="fas fa-phone me-2"></i> Contact us
        </a>
        <div class="contact-info">
            <strong>+94 717292777</strong>
            <span>Consultation</span>
        </div>
    </div>

    <!-- Login Card -->
    <div class="login-card">
        <div class="login-header">
            <i class="fas fa-user-circle"></i> <!-- ✅ Icon color #00008B via CSS -->
            <h4>Login</h4> <!-- ✅ Title color #00008B via CSS -->
        </div>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Username:</label>
                <input type="text" name="username" class="form-control" required placeholder="Enter username">
            </div>
            <div class="mb-3">
                <label class="form-label">Password:</label>
                <input type="password" name="password" class="form-control" required placeholder="••••••••">
            </div>
            <div class="mb-3">
                <label class="form-label">Role:</label>
                <select name="role" class="form-control" required>
                    <option value="admin">Admin</option>
                    <option value="dentist">Dentist</option>
                    <option value="patient">Patient</option>
                </select>
            </div>
            <button type="submit" class="btn btn-login">
                <i class="fas fa-sign-in-alt me-2"></i> Login
            </button>
        </form>

        <p class="register-link">
            <i class="fas fa-user-plus me-1" style="color: #00008B;"></i>
            <span style="color: #00008B;">New patient?</span>
            <a href="${pageContext.request.contextPath}/pages/userProfile/register.jsp" style="color: #00008B;">Register Here</a> <!-- ✅ Link color #00008B via CSS -->
        </p>
    </div>
</section>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
<%
    String error = request.getParameter("error");
    if (error != null && !error.trim().isEmpty()) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    <i class="fas fa-exclamation-triangle me-2"></i>
    <%= error %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
    }
%>
</html>