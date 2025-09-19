<%--
  Created by IntelliJ IDEA.
  User: Abhishek
  Date: 02-09-2025
  Time: 09:06
  To change this template use File | Settings | File Templates.
--%>
<!-- webapp/pages/userProfile/login.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dental Clinic - Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS for responsive and professional layout -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: url('https://images.pexels.com/photos/7803060/pexels-photo-7803060.jpeg?auto=compress&cs=tinysrgb&w=1920') no-repeat center center fixed; /* Dental tools background image */
            background-size: cover; /* Cover the entire background */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: rgba(0, 123, 255, 0.1); /* Semi-transparent blue tint for blurred effect */
            backdrop-filter: blur(10px); /* Blur the background behind the container */
            border: 1px solid rgba(0, 123, 255, 0.2); /* Subtle blue border for glassmorphism */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            max-width: 400px;
            width: 100%;
            animation: fadeIn 1s ease-in-out; /* Smooth fade-in animation */
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header i {
            font-size: 50px;
            color: #007bff; /* Blue icon for dental theme */
            margin-bottom: 10px;
        }
        .login-header h2 {
            color: #333;
            font-weight: bold;
        }
        .form-label {
            font-weight: 600;
            color: #555;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            transition: border-color 0.3s;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.25);
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 8px;
            padding: 10px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        .register-link a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        /* Removed the overlay and watermark as we now use glassmorphism with blue tint */
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <i class="fas fa-tooth"></i> <!-- Dental icon from Font Awesome -->
        <h2>Dental Clinic Management System</h2>
    </div>
    <form action="LoginServlet" method="post">
        <div class="mb-3">
            <label class="form-label">Username:</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password:</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Role:</label>
            <select name="role" class="form-select form-control" required>
                <option value="admin">Admin</option>
                <option value="dentist">Dentist</option>
                <option value="patient">Patient</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>
    </form>
    <p class="register-link">New patient? <a href="${pageContext.request.contextPath}/pages/userProfile/register.jsp">Register Here</a></p>
</div>

<!-- Bootstrap JS for any interactive elements -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>