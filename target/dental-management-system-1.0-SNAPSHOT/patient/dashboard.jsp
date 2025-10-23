<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.clinic.dentalmanagementsystem.model.Appointment" %>
<%@ page import="lk.clinic.dentalmanagementsystem.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard - Dental Clinic</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="teeth" patternUnits="userSpaceOnUse" width="20" height="20"><circle cx="10" cy="10" r="2" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23teeth)"/></svg>') repeat;
            opacity: 0.1;
        }

        .header h1 {
            font-size: 28px;
            z-index: 1;
            position: relative;
            font-weight: 700;
        }

        .header-user {
            z-index: 1;
            position: relative;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(45deg, #ff6b6b, #4ecdc4);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            font-weight: bold;
            color: white;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
        }

        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid white;
            padding: 8px 20px;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }

        .action-bar {
            margin-bottom: 30px;
            text-align: center;
        }

        .btn-primary {
            padding: 18px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-size: 18px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
        }

        .btn-icon {
            width: 24px;
            height: 24px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        .section {
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #ff6b6b, #4ecdc4);
        }

        .section h2 {
            color: #333;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            font-size: 24px;
            font-weight: 700;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }

        th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tr {
            transition: all 0.3s ease;
        }

        tr:hover {
            background: linear-gradient(135deg, #f8f9ff, #fff5f8);
            transform: scale(1.01);
        }

        tbody tr {
            border-left: 4px solid transparent;
        }

        tbody tr:hover {
            border-left: 4px solid #667eea;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-approved {
            background: #d4edda;
            color: #155724;
        }

        .status-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        .status-in-progress {
            background: #cce5ff;
            color: #004085;
        }

        .status-completed {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-cancelled {
            background: #e2e3e5;
            color: #383d41;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #ff6b6b, #4ecdc4);
        }

        .stat-card-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin: 0 auto 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
            background: linear-gradient(135deg, #667eea, #764ba2);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .stat-card.card-1 .stat-card-icon {
            background: linear-gradient(135deg, #667eea, #764ba2);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .stat-card.card-2 .stat-card-icon {
            background: linear-gradient(135deg, #4ecdc4, #44a08d);
            box-shadow: 0 5px 15px rgba(78, 205, 196, 0.4);
        }

        .stat-card.card-3 .stat-card-icon {
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }

        .stat-card h3 {
            color: #333;
            font-size: 36px;
            margin-bottom: 8px;
            font-weight: 700;
        }

        .stat-card p {
            color: #666;
            font-size: 15px;
            font-weight: 500;
        }

        .cancel-btn {
            padding: 4px 10px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
            transition: opacity 0.3s;
        }

        .cancel-btn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null || !"PATIENT".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");

        int totalAppointments = appointments != null ? appointments.size() : 0;
        int upcomingAppointments = 0;
        int completedAppointments = 0;

        if (appointments != null) {
            java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
            for (Appointment apt : appointments) {
                if ("COMPLETED".equals(apt.getStatus())) {
                    completedAppointments++;
                } else if (apt.getAppointmentDate().after(today) ||
                          (apt.getAppointmentDate().equals(today) &&
                           ("APPROVED".equals(apt.getStatus()) || "PENDING".equals(apt.getStatus())))) {
                    upcomingAppointments++;
                }
            }
        }
    %>

    <div class="header">
        <h1>🦷 Patient Dashboard</h1>
        <div class="header-user">
            <div class="user-avatar">
                <%= user.getFullName().charAt(0) %>
            </div>
            <span>Welcome, <%= user.getFullName() %></span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="stats-grid">
            <div class="stat-card card-1">
                <div class="stat-card-icon">📊</div>
                <h3><%= totalAppointments %></h3>
                <p>Total Appointments</p>
            </div>
            <div class="stat-card card-2">
                <div class="stat-card-icon">📅</div>
                <h3><%= upcomingAppointments %></h3>
                <p>Upcoming Appointments</p>
            </div>
            <div class="stat-card card-3">
                <div class="stat-card-icon">✅</div>
                <h3><%= completedAppointments %></h3>
                <p>Completed Appointments</p>
            </div>
        </div>

        <div class="action-bar">
            <a href="${pageContext.request.contextPath}/patient/request-appointment" class="btn-primary">
                <div class="btn-icon">+</div>
                Request New Appointment
            </a>
        </div>

        <div class="section">
            <h2>📋 My Appointments</h2>
            <% if (appointments != null && !appointments.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Doctor</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Notes</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Appointment apt : appointments) { %>
                            <tr>
                                <td><%= apt.getAppointmentDate() %></td>
                                <td><%= apt.getAppointmentTime() %></td>
                                <td><%= apt.getDoctorName() != null ? apt.getDoctorName() : "Not Assigned" %></td>
                                <td><%= apt.getReason() %></td>
                                <td>
                                    <span class="status-badge status-<%= apt.getStatus().toLowerCase().replace("_", "-") %>">
                                        <%= apt.getStatus() %>
                                    </span>
                                </td>
                                <td><%= apt.getNotes() != null ? apt.getNotes() : "-" %></td>
                                <td>
                                    <% if ("PENDING".equals(apt.getStatus()) || "APPROVED".equals(apt.getStatus())) { %>
                                        <form action="${pageContext.request.contextPath}/patient/cancel-appointment" method="post" style="display: inline;"
                                              onsubmit="return confirm('Are you sure you want to cancel this appointment?');">
                                            <input type="hidden" name="appointmentId" value="<%= apt.getAppointmentId() %>">
                                            <button type="submit" class="cancel-btn">Cancel</button>
                                        </form>
                                    <% } else { %>
                                        -
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">
                    <p>You have no appointments yet</p>
                    <p style="margin-top: 10px;">
                        <a href="${pageContext.request.contextPath}/patient/request-appointment" style="color: #667eea;">
                            Request your first appointment
                        </a>
                    </p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>