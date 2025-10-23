package lk.clinic.dentalmanagementsystem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/test")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Test Page</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1>Application is Working!</h1>");
        out.println("<p>If you can see this, the application is deployed correctly.</p>");
        out.println("<a href='" + request.getContextPath() + "/login'>Go to Login Page</a>");
        out.println("</body>");
        out.println("</html>");
    }
}