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

@WebServlet("/doctor/all-appointments")
public class AllAppointmentsServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (!"DOCTOR".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Appointment> allAppointments = appointmentDAO.getAllAppointments();
            List<Appointment> pendingAppointments = appointmentDAO.getPendingAppointments();

            request.setAttribute("allAppointments", allAppointments);
            request.setAttribute("pendingAppointments", pendingAppointments);
            request.getRequestDispatcher("/doctor/all-appointments.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}