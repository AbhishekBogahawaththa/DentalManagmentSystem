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
    private static final long serialVersionUID = 1L;
    private PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        try {
            if ("new".equals(action)) {
                // Forward to form for new patient (no data)
                request.getRequestDispatcher("/jsp/patientForm.jsp").forward(request, response);
            }
            else if ("edit".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam == null || idParam.trim().isEmpty()) {
                    response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Patient ID is required.&messageType=danger");
                    return;
                }
                try {
                    int id = Integer.parseInt(idParam);
                    Patient patient = patientDAO.getPatientById(id);
                    if (patient == null) {
                        response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Patient not found.&messageType=warning");
                        return;
                    }
                    request.setAttribute("patient", patient);
                    request.getRequestDispatcher("/jsp/patientForm.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Invalid patient ID.&messageType=danger");
                }
            }
            else if ("delete".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.trim().isEmpty()) {
                    try {
                        int id = Integer.parseInt(idParam);
                        patientDAO.deletePatient(id);
                        response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Patient deleted successfully.&messageType=success");
                    } catch (NumberFormatException e) {
                        response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Invalid ID for deletion.&messageType=danger");
                    }
                } else {
                    response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Missing patient ID for deletion.&messageType=danger");
                }
            }
            else {
                // Default: list all patients
                List<Patient> patients = patientDAO.getAllPatients();
                request.setAttribute("patients", patients);
                request.getRequestDispatcher("/jsp/listpatients.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=An unexpected error occurred.&messageType=danger");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        try {
            if ("save".equals(action)) {
                int id = 0;
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.trim().isEmpty()) {
                    try {
                        id = Integer.parseInt(idParam);
                    } catch (NumberFormatException e) {
                        // Treat as new if invalid ID
                        id = 0;
                    }
                }

                Patient patient = new Patient();
                patient.setId(id); // 0 means new

                patient.setNic(request.getParameter("nic"));
                patient.setFirstName(request.getParameter("firstName"));
                patient.setLastName(request.getParameter("lastName"));
                patient.setEmail(request.getParameter("email"));
                patient.setPhone(request.getParameter("phone"));
                patient.setAddress(request.getParameter("address"));

                // Parse and store DOB as "yyyy-MM-dd"
                String dobParam = request.getParameter("dob");
                if (dobParam != null && !dobParam.trim().isEmpty()) {
                    try {
                        LocalDate date = LocalDate.parse(dobParam);
                        patient.setDateOfBirth(date.toString()); // ISO format
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
                    response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Patient added successfully.&messageType=success");
                } else {
                    patientDAO.updatePatient(patient);
                    response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Patient updated successfully.&messageType=success");
                }
            } else {
                response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Unknown action.&messageType=warning");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(contextPath + "/jsp/listpatients.jsp?message=Failed to save patient.&messageType=danger");
        }
    }
}