// src/main/java/com/dental/servlet/LoginServlet.java
package com.dental.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        boolean isValid = false;

        // DEMO: Replace with real DB check later
        if ("admin".equals(role) && "Admin".equals(username) && "admin123".equals(password)) {
            isValid = true;
        } else if ("dentist".equals(role) && "dentist1".equals(username) && "dentpass".equals(password)) {
            isValid = true;
        } else if ("patient".equals(role) && "patient1".equals(username) && "patpass".equals(password)) {
            isValid = true;
        }
        String contextPath = request.getContextPath();
        if (isValid) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);

            // Redirect to correct dashboard
            switch (role) {
                case "admin":
                    response.sendRedirect("pages/userProfile/adminDashboard.jsp");
                    break;
                case "dentist":
                    response.sendRedirect("pages/userProfile/dentistDashboard.jsp");
                    break;
                case "patient":
                    response.sendRedirect("pages/userProfile/patientDashboard.jsp");
                    break;
            }
        } else {
            response.sendRedirect("pages/userProfile/login.jsp?error=Invalid credentials");
        }
    }
}