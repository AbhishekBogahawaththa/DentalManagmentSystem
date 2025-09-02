# Dental Management System

## 📂 Project Structure

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
