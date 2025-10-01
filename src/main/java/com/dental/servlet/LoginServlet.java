package com.dental.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import com.dental.dao.UserDAO;
import com.dental.dao.PatientDAO;
import com.dental.model.User;
import com.dental.model.Patient;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("========================================");
        System.out.println("LOGIN ATTEMPT STARTED");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        System.out.println("→ Received username: '" + username + "'");
        System.out.println("→ Received password: '" + password + "'");
        System.out.println("→ Received role: '" + role + "'");

        if (username == null || password == null || role == null || role.trim().isEmpty()) {
            System.out.println("→ ❌ Missing parameter");
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=All fields are required");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByUsernameAndPassword(username, password);

        if (user == null) {
            System.out.println("→ ❌ DAO returned NULL for username: " + username);
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Invalid username or password");
            return;
        }

        System.out.println("→ ✅ User found: " + user.getUsername() + " | DB Role: " + user.getRole());

        if (!role.equals(user.getRole())) {
            System.out.println("→ ❌ Role mismatch: Form Role='" + role + "' | DB Role='" + user.getRole() + "'");
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Invalid role for this user");
            return;
        }

        // ✅ Login successful
        System.out.println("→ ✅ LOGIN SUCCESSFUL - Setting session and redirecting");

        HttpSession session = request.getSession();
        session.setAttribute("username", user.getUsername());
        session.setAttribute("role", user.getRole());
        session.setAttribute("userId", user.getId());

        // ✅ FIXED: Set patientId for patients using userId as fallback
        if ("patient".equals(role)) {
            Integer patientId = null;

            // Try to get patient by user_id first (if linked)
            PatientDAO patientDAO = new PatientDAO();
            Patient patient = patientDAO.getPatientByUserId(user.getId());
            if (patient != null) {
                patientId = patient.getId();
            } else {
                // Fallback: assume user.id == patient.id (common in simple systems)
                patientId = user.getId();
                System.out.println("→ ⚠️ No patient record found for user_id=" + user.getId() + ". Using user.id as patientId.");
            }

            session.setAttribute("patientId", patientId);
            System.out.println("→ ✅ Patient ID set: " + patientId);
        }

        String redirectUrl = switch (role) {
            case "admin" -> "/pages/userProfile/adminDashboard.jsp";
            case "dentist" -> "/pages/userProfile/dentistDashboard.jsp";
            case "patient" -> "/pages/userProfile/patientDashboard.jsp";
            default -> "/pages/userProfile/login.jsp?error=Unknown role";
        };

        System.out.println("→ 🚀 REDIRECTING TO: " + redirectUrl);
        response.sendRedirect(request.getContextPath() + redirectUrl);
    }
}