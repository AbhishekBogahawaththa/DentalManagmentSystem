package lk.clinic.dentalmanagementsystem.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import lk.clinic.dentalmanagementsystem.dao.AppointmentDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/appointment/update")
public class UpdateAppointmentServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (!"DOCTOR".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        String view = request.getParameter("view");
        String date = request.getParameter("date");
        String returnUrl = request.getParameter("returnUrl");

        try {
            boolean success = false;

            switch (action) {
                case "approve":
                    success = appointmentDAO.updateAppointmentStatus(appointmentId, "APPROVED");
                    break;
                case "reject":
                    success = appointmentDAO.updateAppointmentStatus(appointmentId, "REJECTED");
                    break;
                case "inProgress":
                    success = appointmentDAO.updateAppointmentStatus(appointmentId, "IN_PROGRESS");
                    break;
                case "complete":
                    success = appointmentDAO.updateAppointmentStatus(appointmentId, "COMPLETED");
                    break;
                case "updateNotes":
                    String notes = request.getParameter("notes");
                    success = appointmentDAO.updateAppointmentNotes(appointmentId, notes);
                    break;
            }

            StringBuilder redirectUrlBuilder = new StringBuilder(request.getContextPath());

            if ("all-appointments".equals(returnUrl)) {
                redirectUrlBuilder.append("/doctor/all-appointments");
            } else {
                redirectUrlBuilder.append("/doctor/dashboard");
            }

            redirectUrlBuilder.append("?");

            if (view != null && !view.isEmpty() && !"all-appointments".equals(returnUrl)) {
                redirectUrlBuilder.append("view=").append(view).append("&");
            }

            if (date != null && !date.isEmpty() && !"all-appointments".equals(returnUrl)) {
                redirectUrlBuilder.append("date=").append(date).append("&");
            }

            if (success) {
                redirectUrlBuilder.append("success=true");
            } else {
                redirectUrlBuilder.append("error=true");
            }

            response.sendRedirect(redirectUrlBuilder.toString());

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}