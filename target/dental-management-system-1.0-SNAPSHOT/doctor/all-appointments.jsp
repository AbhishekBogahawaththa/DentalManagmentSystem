<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.clinic.dentalmanagementsystem.model.Appointment" %>
<%@ page import="lk.clinic.dentalmanagementsystem.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Appointments - Dental Clinic</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.31/jspdf.plugin.autotable.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1)),
                        url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center/cover;
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

        .nav-links {
            display: flex;
            gap: 15px;
            align-items: center;
            z-index: 1;
            position: relative;
        }

        .nav-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid white;
            padding: 12px 24px;
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s ease;
            font-weight: 600;
            backdrop-filter: blur(10px);
        }

        .nav-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .container {
            max-width: 1400px;
            margin: 20px auto;
            padding: 0 20px;
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

        .action-buttons {
            display: flex;
            gap: 5px;
        }

        .action-btn {
            padding: 4px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
            transition: opacity 0.3s;
        }

        .action-btn:hover {
            opacity: 0.8;
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
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

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
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

        .filter-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .filter-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #ff6b6b, #4ecdc4);
        }

        .filter-btn {
            padding: 8px 16px;
            border: 2px solid #667eea;
            border-radius: 5px;
            background: white;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            cursor: pointer;
        }

        .filter-btn.active {
            background: #667eea;
            color: white;
        }

        .filter-btn:hover {
            background: #667eea;
            color: white;
        }

        .search-section {
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

        .search-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #ff6b6b, #4ecdc4);
        }

        .search-container {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-input {
            flex: 1;
            min-width: 300px;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .search-btn {
            padding: 12px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }

        .search-btn:hover {
            background: #5a67d8;
        }

        .clear-btn {
            padding: 12px 20px;
            background: #6c757d;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }

        .clear-btn:hover {
            background: #5a6268;
        }

        .search-results {
            margin-top: 10px;
            padding: 10px;
            background: #e3f2fd;
            border-radius: 5px;
            display: none;
        }

        .medical-hero {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9)),
                        url('https://images.unsplash.com/photo-1582750433449-648ed127bb54?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2074&q=80') center/cover;
            height: 200px;
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
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="reports" patternUnits="userSpaceOnUse" width="35" height="35"><circle cx="17.5" cy="17.5" r="3" fill="rgba(255,255,255,0.1)"/><rect x="12" y="12" width="11" height="11" fill="rgba(255,255,255,0.05)" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100" height="100" fill="url(%23reports)"/></svg>') repeat;
            opacity: 0.2;
        }

        .medical-hero-content {
            text-align: center;
            color: white;
            z-index: 1;
            position: relative;
        }

        .medical-hero h3 {
            font-size: 32px;
            margin-bottom: 12px;
            font-weight: 700;
        }

        .medical-hero p {
            font-size: 16px;
            opacity: 0.9;
        }

        .action-bar {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-bottom: 20px;
            align-items: center;
        }

        .pdf-btn {
            padding: 12px 24px;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
            position: relative;
            overflow: hidden;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .pdf-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .pdf-btn:hover::before {
            left: 100%;
        }

        .pdf-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 25px rgba(255, 107, 107, 0.4);
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

        List<Appointment> allAppointments = (List<Appointment>) request.getAttribute("allAppointments");
        List<Appointment> pendingAppointments = (List<Appointment>) request.getAttribute("pendingAppointments");

        // Calculate stats
        int totalAppointments = allAppointments != null ? allAppointments.size() : 0;
        int completedAppointments = 0;
        int todayAppointments = 0;
        int upcomingAppointments = 0;

        if (allAppointments != null) {
            java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
            for (Appointment apt : allAppointments) {
                if ("COMPLETED".equals(apt.getStatus())) {
                    completedAppointments++;
                }
                if (apt.getAppointmentDate().equals(today)) {
                    todayAppointments++;
                }
                if (apt.getAppointmentDate().after(today)) {
                    upcomingAppointments++;
                }
            }
        }
    %>

    <div class="header">
        <h1>🏥 All Appointments</h1>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-btn">📅 Daily View</a>
            <span style="margin-right: 20px;">Welcome, Dr. <%= user.getFullName() %></span>
            <a href="${pageContext.request.contextPath}/logout" class="nav-btn">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="medical-hero">
            <div class="medical-hero-content">
                <h3>📊 Comprehensive Appointment Reports</h3>
                <p>Manage, analyze and export all appointment data with advanced reporting tools</p>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-card-icon">📊</div>
                <h3><%= totalAppointments %></h3>
                <p>Total Appointments</p>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">📅</div>
                <h3><%= todayAppointments %></h3>
                <p>Today's Appointments</p>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">⏭️</div>
                <h3><%= upcomingAppointments %></h3>
                <p>Upcoming Appointments</p>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">✅</div>
                <h3><%= completedAppointments %></h3>
                <p>Completed Appointments</p>
            </div>
            <div class="stat-card">
                <div class="stat-card-icon">⏳</div>
                <h3><%= pendingAppointments != null ? pendingAppointments.size() : 0 %></h3>
                <p>Pending Requests</p>
            </div>
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

        <div class="search-section">
            <h4>🔍 Search Appointments</h4>
            <div class="search-container">
                <input type="text" id="searchInput" class="search-input"
                       placeholder="Search by patient name, doctor name, reason, or status..."
                       onkeyup="searchTable()" autocomplete="off">
                <button class="search-btn" onclick="searchTable()">Search</button>
                <button class="clear-btn" onclick="clearSearch()">Clear</button>
            </div>
            <div id="searchResults" class="search-results"></div>
        </div>

        <div class="filter-section">
            <h4>📋 Quick Filters:</h4>
            <button class="filter-btn active" onclick="filterTable('ALL')">All</button>
            <button class="filter-btn" onclick="filterTable('PENDING')">Pending</button>
            <button class="filter-btn" onclick="filterTable('APPROVED')">Approved</button>
            <button class="filter-btn" onclick="filterTable('IN_PROGRESS')">In Progress</button>
            <button class="filter-btn" onclick="filterTable('COMPLETED')">Completed</button>
        </div>

        <div class="section">
            <div class="action-bar">
                <button class="pdf-btn" onclick="generatePDF()">
                    📄 Generate PDF Report
                </button>
            </div>
            <h2>📋 All Appointments History</h2>
            <% if (allAppointments != null && !allAppointments.isEmpty()) { %>
                <table id="appointmentsTable">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Patient</th>
                            <th>Doctor</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Notes</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Appointment apt : allAppointments) { %>
                            <tr data-status="<%= apt.getStatus() %>">
                                <td><%= apt.getAppointmentDate() %></td>
                                <td><%= apt.getAppointmentTime() %></td>
                                <td><%= apt.getPatientName() %></td>
                                <td><%= apt.getDoctorName() != null ? apt.getDoctorName() : "Not Assigned" %></td>
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
                                        <input type="hidden" name="returnUrl" value="all-appointments">
                                        <div class="action-buttons">
                                            <% if ("PENDING".equals(apt.getStatus())) { %>
                                                <button type="submit" name="action" value="approve" class="action-btn approve-btn">Approve</button>
                                                <button type="submit" name="action" value="reject" class="action-btn reject-btn">Reject</button>
                                            <% } else if ("APPROVED".equals(apt.getStatus())) { %>
                                                <button type="submit" name="action" value="inProgress" class="action-btn progress-btn">In Progress</button>
                                                <button type="submit" name="action" value="complete" class="action-btn complete-btn">Complete</button>
                                            <% } else if ("IN_PROGRESS".equals(apt.getStatus())) { %>
                                                <button type="submit" name="action" value="complete" class="action-btn complete-btn">Complete</button>
                                            <% } else { %>
                                                -
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
                    <p>No appointments found</p>
                </div>
            <% } %>
        </div>
    </div>

    <script>
        let currentFilter = 'ALL';
        let currentSearch = '';

        function filterTable(status) {
            currentFilter = status;
            const buttons = document.querySelectorAll('.filter-btn');

            // Update active button
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');

            applyFilters();
        }

        function searchTable() {
            const searchInput = document.getElementById('searchInput');
            currentSearch = searchInput.value.toLowerCase().trim();

            applyFilters();
            updateSearchResults();
        }

        function clearSearch() {
            const searchInput = document.getElementById('searchInput');
            searchInput.value = '';
            currentSearch = '';

            // Reset to show all with current filter
            applyFilters();
            hideSearchResults();
        }

        function applyFilters() {
            const table = document.getElementById('appointmentsTable');
            if (!table) return;

            const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const rowStatus = row.getAttribute('data-status');

                // Check status filter
                const statusMatch = currentFilter === 'ALL' || rowStatus === currentFilter;

                // Check search filter
                let searchMatch = true;
                if (currentSearch) {
                    const cells = row.getElementsByTagName('td');
                    const searchText = Array.from(cells).slice(0, 6) // First 6 columns (excluding actions)
                        .map(cell => cell.textContent.toLowerCase())
                        .join(' ');
                    searchMatch = searchText.includes(currentSearch);
                }

                // Show row only if both filters match
                if (statusMatch && searchMatch) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }

        function updateSearchResults() {
            const searchResults = document.getElementById('searchResults');
            const table = document.getElementById('appointmentsTable');

            if (!table || !currentSearch) {
                hideSearchResults();
                return;
            }

            const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
            let visibleCount = 0;

            for (let i = 0; i < rows.length; i++) {
                if (rows[i].style.display !== 'none') {
                    visibleCount++;
                }
            }

            let filterText = currentFilter !== 'ALL' ? ' (filtered by ' + currentFilter + ')' : '';
            searchResults.innerHTML =
                '📊 Search Results: <strong>' + visibleCount + '</strong> appointments found for "<em>' +
                currentSearch + '</em>"' + filterText;
            searchResults.style.display = 'block';
        }

        function hideSearchResults() {
            const searchResults = document.getElementById('searchResults');
            searchResults.style.display = 'none';
        }

        // Enable Enter key for search
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchTable();
            }
        });

        // PDF Generation Function
        function generatePDF() {
            const table = document.getElementById('appointmentsTable');
            if (!table) {
                alert('No appointments data to export!');
                return;
            }

            // Get visible rows only (respecting current filters)
            const visibleRows = [];
            const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

            for (let i = 0; i < rows.length; i++) {
                if (rows[i].style.display !== 'none') {
                    const cells = rows[i].getElementsByTagName('td');
                    const rowData = [];
                    // Get first 7 columns (excluding actions column)
                    for (let j = 0; j < 7; j++) {
                        if (cells[j]) {
                            // Clean up the text content (remove extra whitespace)
                            let cellText = cells[j].textContent.trim();
                            // For status column, extract just the status text
                            if (j === 5 && cells[j].querySelector('.status-badge')) {
                                cellText = cells[j].querySelector('.status-badge').textContent.trim();
                            }
                            rowData.push(cellText);
                        }
                    }
                    visibleRows.push(rowData);
                }
            }

            if (visibleRows.length === 0) {
                alert('No appointments match your current filter criteria!');
                return;
            }

            // Create PDF using jsPDF
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF('l', 'mm', 'a4'); // landscape orientation

            // Add header with clinic branding
            doc.setFillColor(102, 126, 234);
            doc.rect(0, 0, 297, 25, 'F');

            // Add clinic title
            doc.setTextColor(255, 255, 255);
            doc.setFontSize(20);
            doc.setFont(undefined, 'bold');
            doc.text('🦷 Dental Clinic Management System', 20, 15);

            // Add report title and date
            doc.setTextColor(0, 0, 0);
            doc.setFontSize(16);
            doc.setFont(undefined, 'bold');
            const now = new Date();
            const dateStr = now.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            let reportTitle = 'Appointments Report - ' + dateStr;
            if (currentFilter !== 'ALL') {
                reportTitle += ' (Status: ' + currentFilter + ')';
            }
            if (currentSearch) {
                reportTitle += ' (Filtered)';
            }

            doc.text(reportTitle, 20, 35);

            // Add summary statistics
            doc.setFontSize(11);
            doc.setFont(undefined, 'normal');
            doc.text('Total Appointments in Report: ' + visibleRows.length, 20, 45);

            // Create table with autoTable plugin
            const headers = ['Date', 'Time', 'Patient', 'Doctor', 'Reason', 'Status', 'Notes'];

            doc.autoTable({
                head: [headers],
                body: visibleRows,
                startY: 55,
                theme: 'striped',
                styles: {
                    fontSize: 9,
                    cellPadding: 3,
                },
                headStyles: {
                    fillColor: [102, 126, 234],
                    textColor: [255, 255, 255],
                    fontStyle: 'bold',
                    fontSize: 10
                },
                alternateRowStyles: {
                    fillColor: [248, 249, 255]
                },
                columnStyles: {
                    0: { cellWidth: 25 }, // Date
                    1: { cellWidth: 20 }, // Time
                    2: { cellWidth: 35 }, // Patient
                    3: { cellWidth: 35 }, // Doctor
                    4: { cellWidth: 60 }, // Reason
                    5: { cellWidth: 25 }, // Status
                    6: { cellWidth: 50 }  // Notes
                },
                margin: { left: 20, right: 20 },
                didParseCell: function(data) {
                    // Color status cells based on status
                    if (data.column.index === 5) { // Status column
                        const status = data.cell.text[0];
                        if (status === 'PENDING') {
                            data.cell.styles.fillColor = [255, 243, 205];
                            data.cell.styles.textColor = [133, 100, 4];
                        } else if (status === 'APPROVED') {
                            data.cell.styles.fillColor = [212, 237, 218];
                            data.cell.styles.textColor = [21, 87, 36];
                        } else if (status === 'IN_PROGRESS') {
                            data.cell.styles.fillColor = [204, 229, 255];
                            data.cell.styles.textColor = [0, 64, 133];
                        } else if (status === 'COMPLETED') {
                            data.cell.styles.fillColor = [209, 236, 241];
                            data.cell.styles.textColor = [12, 84, 96];
                        } else if (status === 'REJECTED') {
                            data.cell.styles.fillColor = [248, 215, 218];
                            data.cell.styles.textColor = [114, 28, 36];
                        }
                    }
                }
            });

            // Add footer
            const pageCount = doc.internal.getNumberOfPages();
            for (let i = 1; i <= pageCount; i++) {
                doc.setPage(i);
                doc.setFontSize(8);
                doc.setTextColor(128, 128, 128);
                doc.text(
                    'Generated on ' + now.toLocaleString() + ' - Page ' + i + ' of ' + pageCount,
                    doc.internal.pageSize.getWidth() - 20,
                    doc.internal.pageSize.getHeight() - 10,
                    { align: 'right' }
                );
            }

            // Generate filename with current date
            const fileDate = now.getFullYear() + '-' +
                           String(now.getMonth() + 1).padStart(2, '0') + '-' +
                           String(now.getDate()).padStart(2, '0');

            let filename = 'Dental_Appointments_Report_' + fileDate;

            // Add filter info to filename if applicable
            if (currentFilter !== 'ALL') {
                filename += '_' + currentFilter;
            }
            if (currentSearch) {
                filename += '_Filtered';
            }

            // Save the PDF
            doc.save(filename + '.pdf');

            // Show success message
            const successMsg = document.createElement('div');
            successMsg.style.cssText = 'position:fixed;top:20px;right:20px;background:#28a745;color:white;padding:15px 20px;border-radius:8px;z-index:10000;font-weight:600;box-shadow:0 5px 15px rgba(0,0,0,0.3);';
            successMsg.innerHTML = '✅ PDF Report downloaded successfully! (' + visibleRows.length + ' appointments)';
            document.body.appendChild(successMsg);

            setTimeout(() => {
                document.body.removeChild(successMsg);
            }, 3000);
        }
    </script>
</body>
</html>