package controller;

import dao.DentistDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/logindoctor")
public class LoginServlet extends HttpServlet {

    private DentistDao dentistDao;

    @Override
    public void init() throws ServletException {
        dentistDao = new DentistDao();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/logindoctor":
                System.out.println("Login Clicked " + action);
                checkLogin(request, response);
                break;
        }
    }

    private void checkLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("Username: " + username);
        System.out.println("Password: " + password);

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            if (authenticateDoctor(username, password)) {
                // Login successful
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("userType", "doctor");

                // Redirect to doctor dashboard
                response.sendRedirect("doctordashboard.jsp");
            } else {
                // Login failed
                out.println("<html><body>");
                out.println("<script>alert('Invalid username or password!'); window.location='login.jsp';</script>");
                out.println("</body></html>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<html><body>");
            out.println("<script>alert('Database error occurred!'); window.location='login.jsp';</script>");
            out.println("</body></html>");
        }
    }

    private boolean authenticateDoctor(String username, String password) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = dentistDao.dbConnection();
            String sql = "SELECT * FROM doctors WHERE username = ? AND password = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            resultSet = preparedStatement.executeQuery();

            return resultSet.next(); // Returns true if a record is found

        } finally {
            if (resultSet != null) resultSet.close();
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        }
    }
}