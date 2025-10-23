package lk.clinic.dentalmanagementsystem.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lk.clinic.dentalmanagementsystem.dao.AppointmentDAO;
import lk.clinic.dentalmanagementsystem.model.Appointment;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/patient/dashboard")
public class PatientDashboardServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

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
            Integer patientId = (Integer) session.getAttribute("userId");
            List<Appointment> appointments = appointmentDAO.getPatientAppointments(patientId);

            request.setAttribute("appointments", appointments);
            request.getRequestDispatcher("/patient/dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}