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

        /* Big Cute Add Patient Icon Card */
        .add-patient-card {
            flex: 1;
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

        .add-patient-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .add-patient-icon {
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

        .add-patient-card h3 {
            color: var(--dark-blue);
            font-weight: 700;
            margin-bottom: 15px;
            font-size: 1.5rem;
        }

        .add-patient-card p {
            color: #555;
            font-size: 1rem;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .btn-add-patient {
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

        .btn-add-patient:hover {
            background: #00006b;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 139, 0.4);
        }

        /* Patient List Section */
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
            white-space: nowrap;
        }

        .table tbody tr:hover {
            background-color: #f0f5ff;
        }

        .table td, .table th {
            vertical-align: middle;
            padding: 15px;
            white-space: nowrap;
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
            .add-patient-card,
            .patient-list {
                width: 100%;
                max-width: none;
            }
        }

        @media (max-width: 768px) {
            .add-patient-card {
                padding: 40px 20px;
            }
            .patient-list {
                padding: 25px;
            }
            .table td, .table th {
                padding: 10px;
                font-size: 0.9rem;
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
        <!-- Big Cute Add Patient Icon Card -->
        <div class="add-patient-card">
            <div class="add-patient-icon">
                <i class="fas fa-user-plus"></i>
            </div>
            <h3>Add New Patient</h3>
            <p>Click below to register a new patient with full details including medical history and contact info.</p>
            <a href="${pageContext.request.contextPath}/patients?action=new" class="btn-add-patient">
                <i class="fas fa-plus-circle me-2"></i> Add Patient
            </a>
        </div>

        <!-- Patient List -->
        <div class="patient-list">
            <h3><i class="fas fa-list"></i> All Patients</h3>

            <table class="table table-hover align-middle">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>NIC</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>DOB</th>
                    <th>Medical History</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>#1001</td>
                    <td>E123</td>
                    <td>Emily</td>
                    <td>Johnson</td>
                    <td>emily@example.com</td>
                    <td>+94 71 234 5678</td>
                    <td>Colombo, Sri Lanka</td>
                    <td>1990-05-15</td>
                    <td>Toothache</td>
                    <td>
                        <a href="#" class="action-btn edit" title="Edit"><i class="fas fa-edit"></i></a>
                        <a href="#" class="action-btn delete" title="Delete"><i class="fas fa-trash"></i></a>
                    </td>
                </tr>
                <tr>
                    <td>#1002</td>
                    <td>M345</td>
                    <td>Michael</td>
                    <td>Silva</td>
                    <td>michael@example.com</td>
                    <td>+94 77 987 6543</td>
                    <td>Galle, Sri Lanka</td>
                    <td>1985-11-22</td>
                    <td>Nervefilling</td>
                    <td>
                        <a href="#" class="action-btn edit" title="Edit"><i class="fas fa-edit"></i></a>
                        <a href="#" class="action-btn delete" title="Delete"><i class="fas fa-trash"></i></a>
                    </td>
                </tr>
                <tr>
                    <td>#1003</td>
                    <td>S567</td>
                    <td>Sarah</td>
                    <td>Fernando</td>
                    <td>sarah@example.com</td>
                    <td>+94 76 123 4567</td>
                    <td>Kandy, Sri Lanka</td>
                    <td>1995-03-08</td>
                    <td> tooth surgery</td>
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