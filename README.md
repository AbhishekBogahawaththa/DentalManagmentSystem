# Dental Management System
# 🦷 Dental Management System

## 📌 Overview
The **Dental Management System** is a web-based application developed to streamline clinic operations, covering patient management, appointment scheduling, payments, and reporting.  
It is built using **Java Servlets, JSP, and Maven/Gradle**, and follows the **MVC architecture** with clear separation between models, services, controllers, and views.

This project demonstrates:
- **Object-Oriented Programming (OOP)** principles
- **Servlet & JSP-based web development**
- **Database connectivity (JDBC)**
- **Role-based access control**
- **Report generation & audit tracking**

📄 For details on system design, see `docs/Architecture.md`  
🔧 For setup instructions, see `docs/SetupGuide.md`

---

## 🚀 Key Features

### 👩‍⚕️ Role-Based Access
- **Patients**: Register, log in, view dashboard, book appointments, view history.  
- **Dentists**: Access dashboard, view daily appointments, update medical records.  
- **Receptionists**: Manage patient appointments, assist with scheduling.  
- **Admins**: Manage doctors, patients, generate reports, handle user accounts.  

### 📅 Appointment Management
- Schedule, update, and cancel appointments.  
- Doctors and patients view real-time availability.  

### 💳 Payment & Billing
- Generate invoices and process payments.  
- Maintain financial transaction records.  

### 📊 Reports & Audit
- Admin can generate reports (appointments, financials, patient history).  
- Audit logs ensure accountability.  

---

## 🎯 Project Objectives
- Apply **Encapsulation, Inheritance, Abstraction, and Polymorphism** in system design.  
- Implement **role-based authentication and authorization**.  
- Integrate **database-driven storage** for scalability.  
- Provide **dynamic dashboards** for patients, dentists, admins, and receptionists.  
- Enhance clinic efficiency with automated **reporting and billing**.  

---

## 🛠️ Technologies

- **Backend**: Java (Servlets, JSP)  
- **Frontend**: JSP, HTML, CSS, JavaScript  
- **Build Tool**: Maven / Gradle  
- **Server**: Apache Tomcat 10.1+  
- **Database**: MySQL (via JDBC)  
- **Libraries**:
  - Jakarta Servlet API  
  - JSTL (Jakarta Standard Tag Library)  
  - Gson (JSON handling)  
  - JUnit (testing)  

---

## 📂 Project Structure

```bash
DentalManagementSystem/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── com/dental/
│   │   │   │   ├── model/
│   │   │   │   │   ├── Patient.java
│   │   │   │   │   ├── Appointment.java
│   │   │   │   │   ├── Dentist.java
│   │   │   │   │   ├── Invoice.java
│   │   │   │   │   ├── Payment.java
│   │   │   │   │   ├── MedicalRecord.java
│   │   │   │   │   └── User.java
│   │   │   │   ├── dao/
│   │   │   │   │   ├── PatientDAO.java
│   │   │   │   │   ├── AppointmentDAO.java
│   │   │   │   │   ├── DentistDAO.java
│   │   │   │   │   ├── PaymentDAO.java
│   │   │   │   │   ├── MedicalRecordDAO.java
│   │   │   │   │   └── UserDAO.java
│   │   │   │   ├── controller/
│   │   │   │   │   ├── AppointmentServlet.java
│   │   │   │   │   ├── PatientServlet.java
│   │   │   │   │   ├── LoginServlet.java
│   │   │   │   │   ├── RegistrationServlet.java
│   │   │   │   │   ├── PaymentServlet.java
│   │   │   │   │   ├── ReportServlet.java
│   │   │   │   │   └── DentistDashboardServlet.java
│   │   │   │   ├── service/
│   │   │   │   │   ├── AppointmentService.java
│   │   │   │   │   ├── PatientService.java
│   │   │   │   │   ├── PaymentService.java
│   │   │   │   │   ├── EmailService.java
│   │   │   │   │   └── ReportService.java
│   │   │   │   └── util/
│   │   │   │       ├── DBConnection.java
│   │   │   │       ├── PasswordUtil.java
│   │   │   │       └── ValidationUtil.java
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── web.xml
│   │       │   └── lib/
│   │       ├── views/
│   │       │   ├── patient/
│   │       │   │   ├── registration.jsp
│   │       │   │   ├── dashboard.jsp
│   │       │   │   ├── bookAppointment.jsp
│   │       │   │   └── viewHistory.jsp
│   │       │   ├── dentist/
│   │       │   │   ├── dashboard.jsp
│   │       │   │   ├── dailyAppointments.jsp
│   │       │   │   └── updateRecords.jsp
│   │       │   ├── admin/
│   │       │   │   ├── dashboard.jsp
│   │       │   │   ├── reports.jsp
│   │       │   │   └── manageUsers.jsp
│   │       │   ├── receptionist/
│   │       │   │   └── dashboard.jsp
│   │       │   └── common/
│   │       │       ├── login.jsp
│   │       │       ├── header.jsp
│   │       │       └── footer.jsp
│   │       ├── css/
│   │       ├── js/
│   │       └── images/
└── pom.xml / build.gradle
