<%--
  Created by IntelliJ IDEA.
  User: Abhishek
  Date: 02-09-2025
  Time: 09:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dental Clinic - Register</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
            z-index: 0;
        }

        .register-container {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            width: 360px;
            z-index: 2;
            border: 1px solid #e5e7eb;
            animation: fadeIn 0.8s ease-out;
            position: relative;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .register-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .register-header i {
            color: var(--dark-blue);
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .register-header h4 {
            color: var(--dark-blue);
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

        .btn-register {
            background: var(--dark-blue);
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

        .btn-register:hover {
            background: #00006b;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 139, 0.4);
        }

        .login-link {
            margin-top: 20px;
            text-align: center;
            color: #6b7280;
            font-size: 0.95rem;
        }

        .login-link a {
            color: var(--dark-blue);
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* Optional decorative progress bar (matches login theme colors) */
        .progress {
            height: 5px;
            margin-bottom: 20px;
            background-color: #e5e7eb;
            border-radius: 5px;
            overflow: hidden;
        }

        .progress-bar {
            background-color: var(--dark-blue);
            height: 100%;
            transition: width 0.3s ease;
        }

        @media (max-width: 768px) {
            .register-container {
                width: 90%;
                max-width: 360px;
                margin: 20px;
            }
        }
    </style>
</head>
<body>

<div class="register-container">
    <div class="register-header">
        <i class="fas fa-user-plus"></i>
        <h4>Register</h4>
    </div>

    <!-- Decorative progress bar -->
    <div class="progress">
        <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
    </div>

    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
        <div class="mb-3">
            <label class="form-label">Username:</label>
            <input type="text" name="username" class="form-control" required placeholder="Choose a username">
        </div>
        <div class="mb-3">
            <label class="form-label">Password:</label>
            <input type="password" name="password" class="form-control" required placeholder="Create a password">
        </div>
        <div class="mb-3">
            <label class="form-label">Role:</label>
            <select name="role" class="form-control" required>
                <option value="">-- Select Role --</option>
                <option value="admin">Admin</option>
                <option value="dentist">Dentist</option>
                <option value="patient">Patient</option>
            </select>
        </div>
        <button type="submit" class="btn btn-register">
            <i class="fas fa-user-plus me-2"></i> Register
        </button>
    </form>

    <p class="login-link">
        <i class="fas fa-sign-in-alt me-1" style="color: var(--dark-blue);"></i>
        Already have an account?
        <a href="${pageContext.request.contextPath}/pages/userProfile/login.jsp">Login Here</a>
    </p>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Progress bar animation script -->
<script>
    const formInputs = document.querySelectorAll('.form-control');
    const progressBar = document.querySelector('.progress-bar');

    formInputs.forEach(input => {
        input.addEventListener('input', updateProgress);
    });

    function updateProgress() {
        const totalInputs = formInputs.length;
        let filledInputs = 0;
        formInputs.forEach(input => {
            if (input.value.trim() !== '') filledInputs++;
        });
        const progress = (filledInputs / totalInputs) * 100;
        progressBar.style.width = `${progress}%`;
        progressBar.setAttribute('aria-valuenow', progress);
    }
</script>

</body>
</html>