<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.clinic.dentalmanagementsystem.model.Appointment" %>
<%@ page import="lk.clinic.dentalmanagementsystem.model.User" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - Dental Clinic</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1)),
                        url('https://images.unsplash.com/photo-1551601651-2a8555f1a136?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center/cover;
            min-height: 100vh;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            z-index: -1;
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
            z-index: 10;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="medical" patternUnits="userSpaceOnUse" width="25" height="25"><circle cx="12.5" cy="12.5" r="2" fill="rgba(255,255,255,0.1)"/><path d="M10 12.5h5M12.5 10v5" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100" height="100" fill="url(%23medical)"/></svg>') repeat;
            opacity: 0.3;
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

        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid white;
            padding: 12px 24px;
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s ease;
            z-index: 1;
            position: relative;
            font-weight: 600;
            backdrop-filter: blur(10px);
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }

        .date-selector {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .date-selector::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #ff6b6b, #4ecdc4);
        }

        .date-selector form {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .date-selector input[type="date"] {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn {
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 25px rgba(102, 126, 234, 0.4);
        }

        .section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
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

        .medical-hero {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9)),
                        url('https://images.unsplash.com/photo-1559757148-5c350d0d3c56?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2069&q=80') center/cover;
            height: 250px;
            border-radius: 20px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .medical-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="stethoscope" patternUnits="userSpaceOnUse" width="40" height="40"><circle cx="20" cy="20" r="4" fill="rgba(255,255,255,0.1)"/><path d="M16 20h8M20 16v8" stroke="rgba(255,255,255,0.1)" stroke-width="2"/></pattern></defs><rect width="100" height="100" fill="url(%23stethoscope)"/></svg>') repeat;
            opacity: 0.2;
        }

        .medical-hero-content {
            text-align: center;
            color: white;
            z-index: 1;
            position: relative;
        }

        .medical-hero h3 {
            font-size: 36px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .medical-hero p {
            font-size: 18px;
            opacity: 0.9;
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

        .action-buttons {
            display: flex;
            gap: 5px;
        }

        .action-btn {
            padding: 6px 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .approve-btn {
            background: #28a745;
            color: white;
        }

        .reject-btn {
            background: #dc3545;
            color: white;
        }

        .progress-btn {
            background: #17a2b8;
            color: white;
        }

        .complete-btn {
            background: #6c757d;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        .welcome {
            margin-bottom: 20px;
            color: #666;
        }

        .view-toggle {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .view-toggle::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #ff6b6b, #4ecdc4);
        }

        .toggle-buttons {
            display: flex;
            gap: 10px;
        }

        .toggle-btn {
            padding: 8px 20px;
            border: 2px solid #667eea;
            border-radius: 5px;
            background: white;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }

        .toggle-btn.active {
            background: #667eea;
            color: white;
        }

        .toggle-btn:hover {
            background: #667eea;
            color: white;
        }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null || !"DOCTOR".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Appointment> dailyAppointments = (List<Appointment>) request.getAttribute("dailyAppointments");
        List<Appointment> pendingAppointments = (List<Appointment>) request.getAttribute("pendingAppointments");
        java.sql.Date selectedDate = (java.sql.Date) request.getAttribute("selectedDate");
        String currentView = (String) request.getAttribute("currentView");
        if (currentView == null) currentView = "my";
    %>

    <div class="header">
        <h1>🦷 Doctor Dashboard</h1>
        <div class="header-user">
            <a href="${pageContext.request.contextPath}/doctor/all-appointments" class="logout-btn">🏥 All Appointments</a>
            <span style="margin-right: 20px;">Welcome, Dr. <%= user.getFullName() %></span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="medical-hero">
            <div class="medical-hero-content">
                <h3>👨‍⚕️ Professional Medical Dashboard</h3>
                <p>Manage appointments and provide exceptional dental care to your patients</p>
            </div>
        </div>

        <div class="view-toggle">
            <h3>📋 Appointment View</h3>
            <div class="toggle-buttons">
                <a href="${pageContext.request.contextPath}/doctor/dashboard?view=my&date=<%= selectedDate %>"
                   class="toggle-btn <%= "my".equals(currentView) ? "active" : "" %>">
                    👨‍⚕️ My Appointments
                </a>
                <a href="${pageContext.request.contextPath}/doctor/dashboard?view=all&date=<%= selectedDate %>"
                   class="toggle-btn <%= "all".equals(currentView) ? "active" : "" %>">
                    🏥 All Appointments
                </a>
            </div>
        </div>

        <div class="date-selector">
            <form action="${pageContext.request.contextPath}/doctor/dashboard" method="get">
                <input type="hidden" name="view" value="<%= currentView %>">
                <label for="date">Select Date:</label>
                <input type="date" id="date" name="date" value="<%= selectedDate %>" required>
                <button type="submit" class="btn">View Appointments</button>
                <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/doctor/dashboard?view=<%= currentView %>'">Today</button>
            </form>
        </div>

        <% if(request.getParameter("success") != null) { %>
            <div style="background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 20px; text-align: center;">
                ✅ Appointment updated successfully!
            </div>
        <% } else if(request.getParameter("error") != null) { %>
            <div style="background: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 20px; text-align: center;">
                ❌ Failed to update appointment. Please try again.
            </div>
        <% } %>

        <div class="section">
            <h2>📅 <%= "all".equals(currentView) ? "All Daily Appointments" : "My Daily Appointments" %> - <%= selectedDate %></h2>
            <% if (dailyAppointments != null && !dailyAppointments.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Time</th>
                            <th>Patient</th>
                            <% if ("all".equals(currentView)) { %>
                                <th>Doctor</th>
                            <% } %>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Notes</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Appointment apt : dailyAppointments) { %>
                            <tr>
                                <td><%= apt.getAppointmentTime() %></td>
                                <td><%= apt.getPatientName() %></td>
                                <% if ("all".equals(currentView)) { %>
                                    <td><%= apt.getDoctorName() != null ? apt.getDoctorName() : "Not Assigned" %></td>
                                <% } %>
                                <td><%= apt.getReason() %></td>
                                <td>
                                    <span class="status-badge status-<%= apt.getStatus().toLowerCase().replace("_", "-") %>">
                                        <%= apt.getStatus() %>
                                    </span>
                                </td>
                                <td><%= apt.getNotes() != null ? apt.getNotes() : "-" %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/appointment/update" method="post" style="display: inline;">
                                        <input type="hidden" name="appointmentId" value="<%= apt.getAppointmentId() %>">
                                        <input type="hidden" name="view" value="<%= currentView %>">
                                        <input type="hidden" name="date" value="<%= selectedDate %>">
                                        <div class="action-buttons">
                                            <% if ("APPROVED".equals(apt.getStatus())) { %>
                                                <button type="submit" name="action" value="inProgress" class="action-btn progress-btn">In Progress</button>
                                                <button type="submit" name="action" value="complete" class="action-btn complete-btn">Complete</button>
                                            <% } else if ("IN_PROGRESS".equals(apt.getStatus())) { %>
                                                <button type="submit" name="action" value="complete" class="action-btn complete-btn">Complete</button>
                                            <% } %>
                                        </div>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">
                    <p>No appointments scheduled for this date</p>
                </div>
            <% } %>
        </div>

        <div class="section">
            <h2>⏳ Pending Appointment Requests</h2>
            <% if (pendingAppointments != null && !pendingAppointments.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Patient</th>
                            <th>Requested Doctor</th>
                            <th>Reason</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Appointment apt : pendingAppointments) { %>
                            <tr>
                                <td><%= apt.getAppointmentDate() %></td>
                                <td><%= apt.getAppointmentTime() %></td>
                                <td><%= apt.getPatientName() %></td>
                                <td><%= apt.getDoctorName() != null ? apt.getDoctorName() : "Any Doctor" %></td>
                                <td><%= apt.getReason() %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/appointment/update" method="post" style="display: inline;">
                                        <input type="hidden" name="appointmentId" value="<%= apt.getAppointmentId() %>">
                                        <input type="hidden" name="view" value="<%= currentView %>">
                                        <input type="hidden" name="date" value="<%= selectedDate %>">
                                        <div class="action-buttons">
                                            <button type="submit" name="action" value="approve" class="action-btn approve-btn">Approve</button>
                                            <button type="submit" name="action" value="reject" class="action-btn reject-btn">Reject</button>
                                        </div>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">
                    <p>No pending appointment requests</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>