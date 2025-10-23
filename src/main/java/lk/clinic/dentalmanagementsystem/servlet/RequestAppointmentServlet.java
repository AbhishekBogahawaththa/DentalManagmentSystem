package lk.clinic.dentalmanagementsystem.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lk.clinic.dentalmanagementsystem.dao.AppointmentDAO;
import lk.clinic.dentalmanagementsystem.dao.UserDAO;
import lk.clinic.dentalmanagementsystem.model.Appointment;
import lk.clinic.dentalmanagementsystem.model.User;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.util.List;

@WebServlet("/patient/request-appointment")
public class RequestAppointmentServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (!"PATIENT".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<User> doctors = userDAO.getAllDoctors();
            request.setAttribute("doctors", doctors);
            request.getRequestDispatcher("/patient/request-appointment.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load doctors list");
            request.getRequestDispatcher("/patient/request-appointment.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (!"PATIENT".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Integer patientId = (Integer) session.getAttribute("userId");
            String dateStr = request.getParameter("date");
            String timeStr = request.getParameter("time");
            String reason = request.getParameter("reason");
            String doctorIdStr = request.getParameter("doctorId");

            Appointment appointment = new Appointment();
            appointment.setPatientId(patientId);
            appointment.setAppointmentDate(Date.valueOf(dateStr));
            appointment.setAppointmentTime(Time.valueOf(timeStr + ":00"));
            appointment.setReason(reason);
            appointment.setStatus("PENDING");

            if (doctorIdStr != null && !doctorIdStr.isEmpty()) {
                appointment.setDoctorId(Integer.parseInt(doctorIdStr));
            }

            boolean success = appointmentDAO.createAppointment(appointment);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/patient/dashboard?success=true");
            } else {
                List<User> doctors = userDAO.getAllDoctors();
                request.setAttribute("doctors", doctors);
                request.setAttribute("error", "Failed to create appointment request");
                request.getRequestDispatcher("/patient/request-appointment.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                List<User> doctors = userDAO.getAllDoctors();
                request.setAttribute("doctors", doctors);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/patient/request-appointment.jsp").forward(request, response);
        }
    }
}