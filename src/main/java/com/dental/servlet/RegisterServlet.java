// src/main/java/com/dental/servlet/RegisterServlet.java
package com.dental.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");

        // TODO: Save to database (e.g., create user table)
        System.out.println("New patient registered: " + fullName);

        response.sendRedirect("pages/userProfile/login.jsp?message=Registration successful!");
    }
}