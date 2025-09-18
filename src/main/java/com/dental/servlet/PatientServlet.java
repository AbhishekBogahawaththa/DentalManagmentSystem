package com.dental.servlet;

import com.dental.dao.PatientDAO;
import com.dental.model.Patient;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/patients")
public class PatientServlet extends HttpServlet {
    private PatientDAO dao = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    showForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deletePatient(req, resp);
                    break;
               default:
                    listPatients(req, resp);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }

    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/patientForm.jsp");
        rd.forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        Patient p = dao.getPatientById(id);
        req.setAttribute("patient", p);
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/patientForm.jsp");
        rd.forward(req, resp);
    }

    private void listPatients(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        List<Patient> list = dao.getAllPatients();
        req.setAttribute("patients", list);
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/listPatients.jsp");
        rd.forward(req, resp);
    }

    private void deletePatient(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        dao.deletePatient(id);
        resp.sendRedirect(req.getContextPath() + "/patients");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            String idStr = req.getParameter("patientId");

            Patient p = new Patient();
            if (idStr != null && !idStr.isEmpty()) {
                p.setPatientId(Integer.parseInt(idStr));
            }

            p.setFirstName(req.getParameter("firstName"));
            p.setLastName(req.getParameter("lastName"));
            p.setEmail(req.getParameter("email"));
            p.setPhone(req.getParameter("phone"));
            p.setAddress(req.getParameter("address"));
            String dob = req.getParameter("dateOfBirth");
            if (dob != null && !dob.isEmpty()) {
                p.setDateOfBirth(LocalDate.parse(dob));
            }
            p.setMedicalHistory(req.getParameter("medicalHistory"));
            p.setAllergies(req.getParameter("allergies"));

            if (p.getid() > 0) {
                dao.updatePatient(p);
            } else {
               dao.addPatient(p);
            }

            resp.sendRedirect(req.getContextPath() + "/patients");
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
}

