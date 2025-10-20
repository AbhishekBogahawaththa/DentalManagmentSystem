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
            background: linear-gradient(135deg, rgba(10, 15, 44, 0.7) 0%, rgba(18, 26, 59, 0.85) 100%);
            z-index: 0;
        }

        .register-container {
            background: var(--card-bg);
            padding: 30px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            width: 360px;
            z-index: 2;
            border: 1px solid var(--card-border);
            backdrop-filter: blur(10px);
            animation: fadeIn 0.8s ease-out;
            position: relative;
            color: var(--text-light);
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
            color: var(--light-blue);
            font-size: 1.8rem;
            margin-bottom: 10px;
            text-shadow: 0 0 8px var(--glow-blue);
        }

        .register-header h4 {
            color: var(--light-blue);
            font-weight: 600;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .form-label {
            font-weight: 600;
            color: var(--text-light);
            margin-bottom: 8px;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            font-size: 1rem;
            background: rgba(0, 0, 0, 0.2);
            color: white;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-control:focus {
            border-color: var(--light-blue);
            box-shadow: 0 0 0 3px rgba(77, 124, 255, 0.3);
            outline: none;
            background: rgba(0, 0, 0, 0.3);
        }

        .form-select {
            background: rgba(0, 0, 0, 0.2);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .form-select:focus {
            border-color: var(--light-blue);
            box-shadow: 0 0 0 3px rgba(77, 124, 255, 0.3);
            background: rgba(0, 0, 0, 0.3);
        }

        .btn-register {
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

        .btn-register:hover {
            background: #1e3c72;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(42, 82, 190, 0.6);
        }

        .login-link {
            margin-top: 20px;
            text-align: center;
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .login-link a {
            color: var(--light-blue);
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .progress {
            height: 5px;
            margin-bottom: 20px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            overflow: hidden;
        }

        .progress-bar {
            background-color: var(--light-blue);
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
            <select name="role" class="form-select" required>
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
        <i class="fas fa-sign-in-alt me-1"></i>
        Already have an account?
        <a href="${pageContext.request.contextPath}/pages/userProfile/login.jsp">Login Here</a>
    </p>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const formInputs = document.querySelectorAll('.form-control, .form-select');
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