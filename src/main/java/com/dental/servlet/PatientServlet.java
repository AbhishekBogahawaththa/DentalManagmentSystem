package com.dental.servlet;

import com.dental.dao.PatientDAO;
import com.dental.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {
    private PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("new".equals(action)) {
                request.getRequestDispatcher("/jsp/patientForm.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Patient patient = patientDAO.getPatientById(id);
                request.setAttribute("patient", patient);
                request.getRequestDispatcher("/jsp/patientForm.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                patientDAO.deletePatient(id);
                response.sendRedirect(request.getContextPath() + "/jsp/listpatients.jsp?message=Patient deleted successfully.&messageType=success");
            } else {
                // Default: list all patients
                List<Patient> patients = patientDAO.getAllPatients();
                System.out.println("✅ Retrieved " + patients.size() + " patients from DB");
                request.setAttribute("patients", patients);
                request.getRequestDispatcher("/jsp/listpatients.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/jsp/listpatients.jsp?message=An error occurred.&messageType=danger");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("save".equals(action)) {
                int id = 0;
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.trim().isEmpty()) {
                    id = Integer.parseInt(idParam);
                }

                Patient patient = new Patient();

                // ✅ FIXED: Use setId(int), not setPatientId(...)
                patient.setId(id); // ← 0 for new, actual ID for update

                patient.setNic(request.getParameter("nic"));
                patient.setFirstName(request.getParameter("firstName"));
                patient.setLastName(request.getParameter("lastName"));
                patient.setEmail(request.getParameter("email"));
                patient.setPhone(request.getParameter("phone"));
                patient.setAddress(request.getParameter("address"));

                // Handle DOB safely
                String dobParam = request.getParameter("dob");
                if (dobParam != null && !dobParam.trim().isEmpty()) {
                    try {
                        LocalDate date = LocalDate.parse(dobParam); // Validate + normalize
                        patient.setDateOfBirth(date.toString());    // Store as "yyyy-MM-dd"
                    } catch (DateTimeParseException e) {
                        patient.setDateOfBirth(null);
                    }
                } else {
                    patient.setDateOfBirth(null);
                }

                patient.setGender(request.getParameter("gender"));
                patient.setMedicalHistory(request.getParameter("medicalHistory"));

                if (id == 0) {
                    patientDAO.addPatient(patient);
                    response.sendRedirect(request.getContextPath() + "/jsp/listpatients.jsp?message=Patient added successfully.&messageType=success");
                } else {
                    patientDAO.updatePatient(patient);
                    response.sendRedirect(request.getContextPath() + "/jsp/listpatients.jsp?message=Patient updated successfully.&messageType=success");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/jsp/listpatients.jsp?message=Failed to save patient.&messageType=danger");
        }
    }
}