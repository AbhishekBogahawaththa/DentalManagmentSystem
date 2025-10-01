package com.dental.servlet;

import com.dental.dao.MedicalRecordDAO;
import com.dental.model.MedicalRecord;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewMedicalRecords")
public class ViewMedicalRecordsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("pages/userProfile/login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"patient".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        Integer patientId = (Integer) session.getAttribute("patientId");
        if (patientId == null) {
            request.setAttribute("error", "No patient profile found.");
            request.getRequestDispatcher("/pages/userProfile/patientDashboard.jsp").forward(request, response);
            return;
        }

        // ✅ Fetch medical records
        MedicalRecordDAO dao = new MedicalRecordDAO();
        List<MedicalRecord> records = dao.getMedicalRecordsByPatientId(patientId);

        // ✅ Pass to JSP
        request.setAttribute("medicalRecords", records);
        request.setAttribute("patientName", session.getAttribute("username")); // or fetch real name

        request.getRequestDispatcher("/pages/userProfile/medicalRecords.jsp").forward(request, response);
    }
}