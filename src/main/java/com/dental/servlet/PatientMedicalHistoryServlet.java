package com.dental.servlet;

import com.dental.dao.MedicalRecordDAO;
import com.dental.model.MedicalRecord;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/PatientMedicalHistoryServlet")
public class PatientMedicalHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Session expired. Please login again.");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"patient".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Access denied. Patients only.");
            return;
        }

        // ✅ Get patientId from session (guaranteed to exist after LoginServlet fix)
        Integer patientId = (Integer) session.getAttribute("patientId");
        if (patientId == null) {
            System.err.println("❌ CRITICAL: patientId is null for patient user!");
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Account misconfiguration. Contact admin.");
            return;
        }

        try {
            MedicalRecordDAO recordDAO = new MedicalRecordDAO();
            List<MedicalRecord> records = recordDAO.getMedicalRecordsByPatientId(patientId);

            // Get patient name for display
            String patientName = (String) session.getAttribute("username"); // Fallback to username

            request.setAttribute("medicalRecords", records);
            request.setAttribute("patientName", patientName);

            request.getRequestDispatcher("/pages/userProfile/patientMedicalHistory.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/patientDashboard.jsp?error=Failed to load medical records. Please try again.");
        }
    }
}