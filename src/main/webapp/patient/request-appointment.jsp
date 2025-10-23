<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.clinic.dentalmanagementsystem.model.User" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Appointment - Dental Clinic</title>
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

        .back-btn {
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

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
            animation: slideUp 0.8s ease-out;
        }

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #ff6b6b, #4ecdc4);
            border-radius: 20px 20px 0 0;
        }

        h2 {
            color: #333;
            margin-bottom: 40px;
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            position: relative;
            z-index: 1;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .input-container {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #999;
            z-index: 1;
        }

        label {
            display: block;
            margin-bottom: 12px;
            color: #555;
            font-weight: 600;
            font-size: 15px;
        }

        input[type="date"],
        input[type="time"],
        textarea,
        select {
            width: 100%;
            padding: 15px 15px 15px 50px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        select {
            padding-left: 50px;
        }

        textarea {
            padding: 15px;
            resize: vertical;
            min-height: 120px;
        }

        input[type="date"]:focus,
        input[type="time"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.2);
            transform: translateY(-2px);
        }

        input[type="date"]:focus + .input-icon,
        input[type="time"]:focus + .input-icon,
        select:focus + .input-icon {
            color: #667eea;
        }


        .time-slots {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-top: 10px;
        }

        .time-slot {
            padding: 10px;
            text-align: center;
            border: 2px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .time-slot:hover {
            border-color: #667eea;
            background: #f0f4ff;
        }

        .time-slot.selected {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 16px 24px;
            border: none;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
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

        .btn-secondary {
            background: rgba(255, 255, 255, 0.9);
            color: #667eea;
            border: 2px solid #667eea;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.3);
        }

        .error {
            background: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        .info-box {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            color: #1565c0;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            border: 1px solid rgba(102, 126, 234, 0.2);
            position: relative;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .info-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 15px 15px 0 0;
        }

        .medical-hero {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9)),
                        url('https://images.unsplash.com/photo-1576091160550-2173dba999ef?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') center/cover;
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
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="dental" patternUnits="userSpaceOnUse" width="30" height="30"><circle cx="15" cy="15" r="3" fill="rgba(255,255,255,0.1)"/><path d="M12 15h6M15 12v6" stroke="rgba(255,255,255,0.1)" stroke-width="2"/></pattern></defs><rect width="100" height="100" fill="url(%23dental)"/></svg>') repeat;
            opacity: 0.3;
        }

        .medical-hero-content {
            text-align: center;
            color: white;
            z-index: 1;
            position: relative;
        }

        .medical-hero h3 {
            font-size: 28px;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .medical-hero p {
            font-size: 16px;
            opacity: 0.9;
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

        LocalDate tomorrow = LocalDate.now().plusDays(1);
        List<User> doctors = (List<User>) request.getAttribute("doctors");
    %>

    <div class="header">
        <h1>🦷 Request Appointment</h1>
        <a href="${pageContext.request.contextPath}/patient/dashboard" class="back-btn">Back to Dashboard</a>
    </div>

    <div class="container">
        <div class="medical-hero">
            <div class="medical-hero-content">
                <h3>🦷 Professional Dental Care</h3>
                <p>Schedule your appointment with our experienced dental professionals</p>
            </div>
        </div>

        <div class="form-container">
            <h2>📅 New Appointment Request</h2>

            <% if(request.getAttribute("error") != null) { %>
                <div class="error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <div class="info-box">
                ℹ️ Your appointment request will be reviewed by our doctor. You will be notified once it's approved.
            </div>

            <form action="${pageContext.request.contextPath}/patient/request-appointment" method="post">
                <div class="form-group">
                    <label for="doctorId">Select Doctor *</label>
                    <div class="input-container">
                        <select id="doctorId" name="doctorId" required>
                            <option value="">Choose a doctor</option>
                            <% if (doctors != null && !doctors.isEmpty()) { %>
                                <% for (User doctor : doctors) { %>
                                    <option value="<%= doctor.getUserId() %>">
                                        <%= doctor.getFullName() %>
                                        <% if (doctor.getEmail() != null) { %>
                                            - <%= doctor.getEmail() %>
                                        <% } %>
                                    </option>
                                <% } %>
                            <% } else { %>
                                <option value="" disabled>No doctors available</option>
                            <% } %>
                        </select>
                        <span class="input-icon">👨‍⚕️</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="date">Preferred Date *</label>
                    <div class="input-container">
                        <input type="date" id="date" name="date" min="<%= tomorrow %>" required>
                        <span class="input-icon">📅</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="time">Preferred Time *</label>
                    <div class="input-container">
                        <select id="time" name="time" required>
                            <option value="">Select a time slot</option>
                            <option value="09:00">09:00 AM</option>
                            <option value="09:30">09:30 AM</option>
                            <option value="10:00">10:00 AM</option>
                            <option value="10:30">10:30 AM</option>
                            <option value="11:00">11:00 AM</option>
                            <option value="11:30">11:30 AM</option>
                            <option value="14:00">02:00 PM</option>
                            <option value="14:30">02:30 PM</option>
                            <option value="15:00">03:00 PM</option>
                            <option value="15:30">03:30 PM</option>
                            <option value="16:00">04:00 PM</option>
                            <option value="16:30">04:30 PM</option>
                        </select>
                        <span class="input-icon">⏰</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="reason">Reason for Visit *</label>
                    <textarea id="reason" name="reason"
                              placeholder="Please describe your symptoms or reason for the appointment..."
                              required></textarea>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">Submit Request</button>
                    <button type="button" class="btn btn-secondary"
                            onclick="location.href='${pageContext.request.contextPath}/patient/dashboard'">
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>