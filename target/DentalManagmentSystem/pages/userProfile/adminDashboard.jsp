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
    <title>Patient Management — Dental Clinic</title>

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
        }

        .add-patient-form {
            flex: 1;
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            border: 1px solid #e5e7eb;
        }

        .add-patient-form h2 {
            color: var(--dark-blue);
            margin-bottom: 20px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .add-patient-form h2 i {
            color: var(--dark-blue);
            font-size: 1.8rem;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
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

        .btn-add {
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

        .btn-add:hover {
            background: #00006b;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 139, 0.4);
        }

        .patient-list {
            flex: 2;
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            border: 1px solid #e5e7eb;
        }

        .patient-list h3 {
            color: var(--dark-blue);
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .patient-list h3 i {
            font-size: 1.3rem;
        }

        .table thead th {
            background-color: var(--dark-blue);
            color: white;
            border: none;
            font-weight: 600;
        }

        .table tbody tr:hover {
            background-color: #f0f5ff;
        }

        .table td, .table th {
            vertical-align: middle;
            padding: 15px;
        }

        .badge-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .badge-active {
            background-color: #d1fae5;
            color: #047857;
        }

        .badge-inactive {
            background-color: #fee2e2;
            color: #b91c1c;
        }

        .action-btn {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin: 0 3px;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }

        .action-btn.edit {
            background-color: #dbeafe;
            color: #1d4ed8;
        }

        .action-btn.delete {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .action-btn:hover {
            transform: scale(1.1);
        }

        @media (max-width: 992px) {
            .main-container {
                flex-direction: column;
            }
            .add-patient-form,
            .patient-list {
                width: 100%;
                max-width: none;
            }
        }

        @media (max-width: 768px) {
            .add-patient-form,
            .patient-list {
                padding: 25px;
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
        <!-- Add Patient Form (Left Side) -->
        <div class="add-patient-form">
            <h2><i class="fas fa-user-plus"></i> Add New Patient</h2>
            <form action="${pageContext.request.contextPath}/patients?action=new" method="post">
                <div class="mb-3">
                    <label class="form-label">Full Name:</label>
                    <input type="text" name="fullName" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Email:</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Phone:</label>
                    <input type="tel" name="phone" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Address:</label>
                    <input type="text" name="address" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-add">
                    <i class="fas fa-save me-2"></i> Save Patient
                </button>
            </form>
        </div>

        <!-- Patient List (Right Side) -->
        <div class="patient-list">
            <h3><i class="fas fa-list"></i> All Patients</h3>

            <table class="table table-hover align-middle">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>#1001</td>
                    <td>Emily Johnson</td>
                    <td>emily@example.com</td>
                    <td>+94 71 234 5678</td>
                    <td><span class="badge-status badge-active">Active</span></td>
                    <td>
                        <a href="#" class="action-btn edit" title="Edit"><i class="fas fa-edit"></i></a>
                        <a href="#" class="action-btn delete" title="Delete"><i class="fas fa-trash"></i></a>
                    </td>
                </tr>
                <tr>
                    <td>#1002</td>
                    <td>Michael Silva</td>
                    <td>michael@example.com</td>
                    <td>+94 77 987 6543</td>
                    <td><span class="badge-status badge-active">Active</span></td>
                    <td>
                        <a href="#" class="action-btn edit" title="Edit"><i class="fas fa-edit"></i></a>
                        <a href="#" class="action-btn delete" title="Delete"><i class="fas fa-trash"></i></a>
                    </td>
                </tr>
                <tr>
                    <td>#1003</td>
                    <td>Sarah Fernando</td>
                    <td>sarah@example.com</td>
                    <td>+94 76 123 4567</td>
                    <td><span class="badge-status badge-inactive">Inactive</span></td>
                    <td>
                        <a href="#" class="action-btn edit" title="Edit"><i class="fas fa-edit"></i></a>
                        <a href="#" class="action-btn delete" title="Delete"><i class="fas fa-trash"></i></a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>