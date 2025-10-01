<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dental Clinic - Login</title>

    <!-- Bootstrap 5 CSS (fixed extra spaces) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 (fixed extra spaces) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- AOS Animation (fixed extra spaces) -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        :root {
            --dark-blue: #00008B;
            --light-blue: #60a5fa;
            --bg-gray: #f9fafb;
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

        .navbar-brand i { color: var(--dark-blue); font-size: 1.8rem; }

        .nav-link { color: #333; font-weight: 500; transition: all 0.3s ease; }
        .nav-link:hover { color: var(--dark-blue); }

        .hero {
            background: url('https://cdn.pixabay.com/photo/2024/04/30/07/18/dentist-8729627_1280.jpg') no-repeat center center;
            background-size: cover;
            background-attachment: fixed;
            height: 80vh;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 5%;
            color: white;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.4);
            z-index: 1;
        }

        /* Ensure all content is above overlay */
        .hero > * {
            position: relative;
            z-index: 2;
        }

        .hero-content {
            max-width: 600px;
            /* Left-aligned text */
        }

        .hero h1 { font-size: 3.5rem; margin-bottom: 1.5rem; line-height: 1.2; font-weight: 700; color: ghostwhite; }
        .hero p { font-size: 1.2rem; margin-bottom: 2rem; }

        .btn-contact {
            background-color: white;
            color: var(--dark-blue);
            border: 2px solid var(--dark-blue);
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 30px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .btn-contact:hover {
            background-color: var(--dark-blue);
            color: white;
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .contact-info { margin-top: 1rem; font-size: 1.1rem; display: flex; flex-direction: column; gap: 0.5rem; }
        .contact-info strong { color: white; }

        .login-card {
            width: 100%;
            max-width: 360px;
            padding: 30px;
            border-radius: 16px;
            background: white;
            border: 1px solid #e5e7eb;
            box-shadow: var(--card-shadow);
            z-index: 3; /* ✅ Critical: ensures interactivity */
        }

        .login-header { text-align: center; margin-bottom: 25px; }
        .login-header i { color: var(--dark-blue); font-size: 1.8rem; margin-right: 10px; }
        .login-header h4 { color: var(--dark-blue); font-weight: 600; margin: 0; }

        .input-group-text { background: #f3f4f6; border-radius: 8px 0 0 8px; border: 1px solid #d1d5db; }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 0 8px 8px 0;
            font-size: 1rem;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-control:focus {
            border-color: var(--dark-blue);
            box-shadow: 0 0 10px rgba(0,0,139,0.3);
            outline: none;
        }

        .btn-login {
            background: var(--dark-blue);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0,0,139,0.3);
            font-size: 1.1rem;
        }

        .btn-login:hover {
            background: #00006b;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0,0,139,0.4);
        }

        .register-link {
            margin-top: 20px;
            text-align: center;
            color: #6b7280;
            font-size: 0.95rem;
        }

        .register-link a { color: var(--dark-blue); font-weight: 600; text-decoration: none; }
        .register-link a:hover { text-decoration: underline; }

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
            .hero h1 { font-size: 2.5rem; }
            .login-card {
                max-width: 100%;
                margin: 0 auto;
            }
            .contact-info { align-items: center; }
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
                <li class="nav-item"><a class="nav-link active" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Services</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="hero">
    <!-- Hero Content on LEFT -->
    <div class="hero-content" data-aos="fade-right">
        <h1>Your Brightest Smile Starts Here</h1>
        <p>Experience compassionate, expert dental care in a modern, welcoming environment.</p>
        <a href="#" class="btn btn-contact"><i class="fas fa-phone me-2"></i> Contact Us</a>
        <div class="contact-info">
            <strong>+94 717292777</strong>
            <span>Book a Consultation</span>
        </div>
    </div>

    <!-- Login Card on RIGHT -->
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
                <select name="role" class="form-control" required>
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