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
    <!-- AOS Animation -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        :root {
            --primary-dark: #0a0f2c;
            --secondary-dark: #121a3b;
            --accent-blue: #2a52be;
            --light-blue: #60a5fa;
            --glow-blue: #4d7cff;
            --text-light: #f0f4f8;
            --card-bg: rgba(25, 35, 65, 0.85);
            --card-border: rgba(70, 90, 150, 0.3);
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            --hover-glow: 0 0 20px rgba(77, 124, 255, 0.4);
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background: url('https://cdn.pixabay.com/photo/2024/04/30/07/18/dentist-8729627_1280.jpg') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-light);
            min-height: 100vh;
            position: relative;
            filter: brightness(1.05) saturate(1.1);
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(10, 15, 44, 0.4) 0%, rgba(18, 26, 59, 0.5) 100%);
            z-index: 1;
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

        .nav-link {
            color: var(--text-light);
            font-weight: 500;
            transition: all 0.3s ease;
            text-shadow: 0 1px 2px rgba(0,0,0,0.3);
        }

        .nav-link:hover {
            color: var(--light-blue);
            text-decoration: underline;
        }

        .hero {
            height: 80vh;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 5%;
            color: white;
            overflow: hidden;
        }

        .hero > * {
            position: relative;
            z-index: 2;
        }

        .hero-content {
            max-width: 600px;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
            line-height: 1.2;
            font-weight: 700;
            color: var(--text-light);
            text-shadow: 0 2px 6px rgba(0, 0, 0, 0.4);
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            color: var(--text-muted);
        }

        .btn-contact {
            background: rgba(255, 255, 255, 0.1);
            color: var(--light-blue);
            border: 1px solid var(--light-blue);
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 30px;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .btn-contact:hover {
            background: var(--accent-blue);
            color: white;
            transform: scale(1.05);
            box-shadow: var(--hover-glow);
            border-color: transparent;
        }

        .contact-info {
            margin-top: 1rem;
            font-size: 1.1rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            color: var(--text-muted);
        }

        .contact-info strong {
            color: var(--light-blue);
        }

        .login-card {
            width: 100%;
            max-width: 360px;
            padding: 30px;
            border-radius: 16px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            box-shadow: var(--shadow);
            z-index: 3;
            backdrop-filter: blur(10px);
            color: var(--text-light);
        }

        .login-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .login-header i {
            color: var(--light-blue);
            font-size: 1.8rem;
            margin-right: 10px;
            text-shadow: 0 0 8px var(--glow-blue);
        }

        .login-header h4 {
            color: var(--light-blue);
            font-weight: 600;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .input-group-text {
            background: rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--light-blue);
            border-radius: 8px 0 0 8px;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 0 8px 8px 0;
            font-size: 1rem;
            background: rgba(0, 0, 0, 0.2);
            color: white;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-control:focus {
            border-color: var(--light-blue);
            box-shadow: 0 0 10px rgba(77, 124, 255, 0.3);
            outline: none;
            background: rgba(0, 0, 0, 0.3);
        }

        .form-select {
            background: rgba(0, 0, 0, 0.2);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 12px;
            border-radius: 8px;
        }

        .form-select:focus {
            border-color: var(--light-blue);
            box-shadow: 0 0 10px rgba(77, 124, 255, 0.3);
            background: rgba(0, 0, 0, 0.3);
        }

        .btn-login {
            background: var(--accent-blue);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(42, 82, 190, 0.4);
            font-size: 1.1rem;
        }

        .btn-login:hover {
            background: #1e3c72;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(42, 82, 190, 0.6);
        }

        .register-link {
            margin-top: 20px;
            text-align: center;
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .register-link a {
            color: var(--light-blue);
            font-weight: 600;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        /* Toast Styling */
        .toast {
            background: rgba(239, 68, 68, 0.9);
            color: white;
            border: none;
            backdrop-filter: blur(5px);
        }

        @media (max-width: 768px) {
            .hero {
                flex-direction: column;
                height: auto;
                padding: 20px;
                text-align: center;
            }
            .hero-content {
                margin-bottom: 20px;
            }
            .hero h1 {
                font-size: 2.5rem;
            }
            .login-card {
                max-width: 100%;
                margin: 0 auto;
            }
            .contact-info {
                align-items: center;
            }
        }
    </style>
</head>
<body>

<%
    String error = request.getParameter("error");
    if(error != null && !error.trim().isEmpty()) {
%>
<div class="toast align-items-center text-bg-danger border-0 position-fixed top-0 end-0 m-3" role="alert" id="errorToast">
    <div class="d-flex">
        <div class="toast-body">
            <i class="fas fa-exclamation-triangle me-2"></i> <%= error %>
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
</div>
<% } %>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#"><i class="fas fa-tooth"></i> Dental Clinic Management System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link " href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Services</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="hero">
    <div class="hero-content" data-aos="fade-right">
        <h1>Your Brightest Smile Starts Here</h1>
        <p>Experience compassionate, expert dental care in a modern, welcoming environment.</p>
        <a href="#" class="btn btn-contact"><i class="fas fa-phone me-2"></i> Contact Us</a>
        <div class="contact-info">
            <strong>+94 717292777</strong>
            <span>Book a Consultation</span>
        </div>
    </div>

    <div class="login-card" data-aos="fade-left">
        <div class="login-header">
            <i class="fas fa-user-circle"></i>
            <h4>Login</h4>
        </div>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <div class="input-group mb-3">
                <span class="input-group-text"><i class="fas fa-user"></i></span>
                <input type="text" name="username" class="form-control" placeholder="Username" required>
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Role:</label>
                <select name="role" class="form-select" required>
                    <option value="admin">Admin</option>
                    <option value="dentist">Dentist</option>
                    <option value="patient">Patient</option>
                </select>
            </div>
            <button type="submit" class="btn btn-login"><i class="fas fa-sign-in-alt me-2"></i> Login</button>
        </form>

        <p class="register-link">
            <i class="fas fa-user-plus me-1"></i> New patient?
            <a href="${pageContext.request.contextPath}/pages/userProfile/register.jsp">Register Here</a>
        </p>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({ duration: 1000 });
    <% if(error != null && !error.trim().isEmpty()){ %>
    var toastEl = document.getElementById('errorToast');
    var toast = new bootstrap.Toast(toastEl);
    toast.show();
    <% } %>
</script>

</body>
</html>