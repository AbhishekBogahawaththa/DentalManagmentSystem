package com.dental.servlet;

import com.dental.dao.MedicalRecordDAO;
import com.dental.dao.PatientDAO;
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

        // Get session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Please login first");
            return;
        }

        // Get patientId from session
        Integer patientId = (Integer) session.getAttribute("patientId");
        if (patientId == null) {
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/login.jsp?error=Patient ID not found. Please login again.");
            return;
        }

        try {
            // ✅ FIXED: Use MedicalRecordDAO to fetch records
            MedicalRecordDAO recordDAO = new MedicalRecordDAO();
            List<MedicalRecord> records = recordDAO.getMedicalRecordsByPatientId(patientId);

            // Optional: Get patient's full name for display
            String patientName = (String) session.getAttribute("patientFullName");
            if (patientName == null) {
                // Fallback: use username or fetch from DB
                patientName = (String) session.getAttribute("username");
                // Optional: fetch from PatientDAO if needed
                // PatientDAO patientDAO = new PatientDAO();
                // Patient p = patientDAO.getPatientById(patientId);
                // patientName = p.getFirstName() + " " + p.getLastName();
            }

            request.setAttribute("medicalRecords", records);
            request.setAttribute("patientName", patientName);

            request.getRequestDispatcher("/pages/userProfile/patientMedicalHistory.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/userProfile/patientDashboard.jsp?error=Failed to load medical history.");
        }
    }
}