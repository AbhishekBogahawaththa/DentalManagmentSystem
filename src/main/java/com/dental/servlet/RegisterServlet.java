package com.dental.servlet;

import com.dental.dao.UserDAO;
import com.dental.dao.PatientDAO;
import com.dental.model.User;
import com.dental.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // <-- Changed from fullName to role

        // Validate role (security: prevent invalid roles)
        if (!"admin".equals(role) && !"dentist".equals(role) && !"patient".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/register.jsp?error=Invalid role selected.");
            return;
        }

        UserDAO userDAO = new UserDAO();

        try {
            // 1. Create User
            User user = new User();
            user.setUsername(username);
            user.setPassword(password); // ⚠️ Remember to hash this in production!
            user.setRole(role); // <-- Use selected role

            // Save user → DAO must set user.id
            userDAO.addUser(user);

            // 2. Only create Patient record if role is "patient"
            if ("patient".equals(role)) {
                PatientDAO patientDAO = new PatientDAO();
                Patient patient = new Patient();
                patient.setUserId(user.getId());
                // You may want to collect firstName/lastName separately later
                // For now, we can leave them empty or derive from username if needed
                patient.setFirstName(""); // or prompt user in future
                patient.setLastName("");
                patient.setEmail(username); // assuming username is email

                patientDAO.addPatient(patient);
            }

            // 3. Redirect to login
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?message=Registration successful! Please login.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/register.jsp?error=Registration failed. Try again.");
        }
    }
}