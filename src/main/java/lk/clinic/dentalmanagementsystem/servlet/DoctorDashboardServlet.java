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
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/doctor/dashboard")
public class DoctorDashboardServlet extends HttpServlet {
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
            Integer doctorId = (Integer) session.getAttribute("userId");
            String dateParam = request.getParameter("date");
            String viewParam = request.getParameter("view");
            Date selectedDate;

            if (dateParam != null && !dateParam.isEmpty()) {
                selectedDate = Date.valueOf(dateParam);
            } else {
                selectedDate = Date.valueOf(LocalDate.now());
            }

            boolean showAllAppointments = "all".equals(viewParam);

            List<Appointment> dailyAppointments;
            if (showAllAppointments) {
                dailyAppointments = appointmentDAO.getAllDailyAppointments(selectedDate);
            } else {
                dailyAppointments = appointmentDAO.getDailyAppointments(selectedDate, doctorId);
            }

            List<Appointment> pendingAppointments = appointmentDAO.getPendingAppointments();

            request.setAttribute("dailyAppointments", dailyAppointments);
            request.setAttribute("pendingAppointments", pendingAppointments);
            request.setAttribute("selectedDate", selectedDate);
            request.setAttribute("currentView", showAllAppointments ? "all" : "my");
            request.getRequestDispatcher("/doctor/dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}