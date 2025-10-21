package controller;
import java.io.IOException;
import controller.Patient;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.DmsDAO;

@WebServlet("/")
public class DMSController extends HttpServlet {
	
	DmsDAO dao = new DmsDAO();
	
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException {
		String act=req.getServletPath();
		
		switch(act) {
			case "/loginDoctor":
				System.out.println("Login clicked "+ act);
				checkLogin(req,res);
				break;
			case"/admindashboard":
				showDashboard(req,res);
				break;
			case"/insertPatient":
				insertPatient(req,res);
				break;
			case"/update":
				showUpdateForm(req,res);
				break;
			case"/updatePatient":
				updatePatient(req,res);
				break;
			case"/delete":
				deletePatient(req,res);
				break;
			case"/logout":
				logoutdoctor(req,res);
				break;
			default:
				showDashboard(req, res);
				break;
		}
	}

	private void logoutdoctor(HttpServletRequest req, HttpServletResponse res) throws IOException {
		HttpSession s=req.getSession();
		s.removeAttribute("doctor");
		s.invalidate();
		
		res.sendRedirect("index.jsp");
	}

	private void deletePatient(HttpServletRequest req, HttpServletResponse res) throws IOException {
		int id=Integer.parseInt(req.getParameter("id"));
		
		dao.deletePatient(id);
		
		System.out.println("User deleted");
		res.sendRedirect("dashboard");
		
	}

	private void updatePatient(HttpServletRequest req, HttpServletResponse res) throws IOException {
		int id=Integer.parseInt(req.getParameter("userid"));
		String name = req.getParameter("username");
		String email=req.getParameter("useremail");
		int age = Integer.parseInt(req.getParameter("userage"));
		String city = req.getParameter("usercity");
		String gender = req.getParameter("usergender");
		
		Patient updatedPatient = new Patient(id,name,email,gender,city,age);
		
		boolean check=dao.updateOldPatient(updatedPatient);
		
		if(check) {
			res.sendRedirect("dashboard");
		}else {
			System.out.println("Failed to update");
		}
	}

	private void showUpdateForm(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int id=Integer.parseInt(req.getParameter("id"));
		
		Patient oldPatient = dao.selectOldPatient(id);
		
		RequestDispatcher rd=req.getRequestDispatcher("update.jsp");
		req.setAttribute("pt", oldPatient);
		rd.forward(req, res);
		
	}

	private void insertPatient(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String name = req.getParameter("username");
		String email = req.getParameter("useremail");
		int age =Integer.parseInt(req.getParameter("userage"));
		String city = req.getParameter("usercity");
		String gender = req.getParameter("usergender");
		
		Patient pt = new Patient(name,email,gender,city,age);
		
		dao.addNewPatient(pt);
		
		System.out.println("Patient added to system");
		res.sendRedirect("dashboard");
		
	}

	private void showDashboard(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		List<Patient> ptList = new ArrayList<>();
		
		ptList = dao.getAllPatients();
		req.setAttribute("pts" , ptList);
		RequestDispatcher rd=req.getRequestDispatcher("dashboard.jsp");
		rd.forward(req, res);
		
	}

	private void checkLogin(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String un=req.getParameter("Username");
		String up=req.getParameter("Password");
		
		System.out.println(un);
		
		
		if(dao.doctorCheck(un,up)) {
			//session
			HttpSession session=req.getSession();
			session.setAttribute("doctor" , un);
			
			System.out.println("Login Success");
			res.sendRedirect("dashboard");
		}else {
			System.out.println("Wrong credentials");
			res.sendRedirect("login.jsp");
		}
	
		
	}

}
