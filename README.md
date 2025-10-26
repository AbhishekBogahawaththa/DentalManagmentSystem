# 🦷 Web-Based Dental Management System (Java Servlets + MySQL)

A **web-based dental management system** developed using **Java Servlets**, **JSP**, and **MySQL Workbench**, designed to digitalize dental clinic operations such as appointment scheduling, patient record management, and payment handling.

---

## 📘 Project Overview

This system provides a streamlined platform for **patients**, **dentists**, and **administrators** to interact efficiently.
It allows patients to book appointments, dentists to manage their schedules, and the admin to oversee system operations including user and payment management.

> **Objective:** Simplify the administrative, clinical, and scheduling processes in a dental clinic using a centralized web-based system.

---

## 👥 System Users and Roles

### 🧑 Patient

* Create account and log in
* Make, view, and edit appointments
* Receive email confirmation for booked appointments
* View payment records and treatment history

### 👨‍⚕️ Dentist

* Log in with credentials assigned by the admin
* View appointments assigned to them
* Cancel appointments if unavailable
* Log out securely

### 🧑‍💼 Admin (Receptionist/Clinic Manager)

* Log in to the system
* Add and manage dentists
* Add or remove patient accounts
* Manage appointments and dentist availability
* Handle payments after treatments (store in patient records)
* View all appointment and payment reports

---

## ⚙️ Key Functionalities

| Feature                 | Description                                                   |
| ----------------------- | ------------------------------------------------------------- |
| **User Authentication** | Secure login system for Admin, Dentist, and Patient roles     |
| **Appointment Booking** | Patients can select dentist and time slot                     |
| **Email Notification**  | Sends confirmation email to patient after appointment booking |
| **Payment Management**  | Admin records payment after treatment                         |
| **Dentist Scheduling**  | Admin can change dentist availability                         |
| **Patient Records**     | Stores diagnosis, treatment, and payment info                 |

---

## 🧰 Technology Stack

| Component         | Technology Used                 |
| ----------------- | ------------------------------- |
| **Frontend**      | HTML5, CSS3, Bootstrap 5        |
| **Backend**       | Java Servlets, JSP              |
| **Database**      | MySQL (Workbench)               |
| **Server**        | Apache Tomcat 9+                |
| **IDE**           | Eclipse IDE for Enterprise Java |
| **Email Service** | JavaMail API                    |

---

## 🗄️ Database Design Overview

### **Main Tables**

1. **roles** – Stores role types (Admin, Dentist, Patient)
2. **users** – Login credentials and role linkage
3. **dentist** – Dentist information and availability
4. **patient** – Patient profile details
5. **appointments** – Appointment scheduling and status
6. **patient_records** – Stores treatment and payment history
7. **payments** – Records treatment payments linked to appointments

### **Relationships**

* `users` → `roles` : many-to-one
* `appointments` → `patients`, `dentists` : many-to-one
* `payments` → `appointments` : one-to-one
* `patient_records` → `patients` : many-to-one

---

## 🧩 SQL Implementation Components

### **Part A – EER → Relational Schema**

All relationships and constraints mapped using PKs, FKs, and data integrity rules.

### **Part B – DDL (Table Creation)**

Includes tables for:

```sql
CREATE TABLE dentist (...);
CREATE TABLE patient (...);
CREATE TABLE appointment (...);
CREATE TABLE payment (...);
CREATE TABLE patient_record (...);
```

### **Part C – Sample Data**

Each table has at least **5 valid records** inserted for demonstration and testing.

### **Part D – SQL Queries**

1. **Simple SELECT:** View all patients
2. **JOIN:** List appointments with patient and dentist names
3. **Aggregation:** Total payments received
4. **GROUP BY / HAVING:** Appointments per dentist
5. **Subquery:** Patients who haven’t paid yet

### **Part E – Stored Procedure**

```sql
CREATE PROCEDURE GetTotalPaidByPatient(IN p_id INT)
BEGIN
  SELECT SUM(amount) FROM payment WHERE patient_id = p_id;
END;
```

✅ Demonstration:

```sql
CALL GetTotalPaidByPatient(7);
```

Shows total amount paid by the selected patient.

### **Part F – Trigger**

```sql
CREATE TRIGGER after_payment_insert
AFTER INSERT ON payment
FOR EACH ROW
BEGIN
  UPDATE appointment
  SET status = 'COMPLETED'
  WHERE id = NEW.appointment_id;
END;
```

✅ Demonstration:
Insert a new payment → appointment automatically updates to `COMPLETED`.

---

## 💻 Web Application Flow

### 1️⃣ Homepage

* Welcome banner with clinic introduction
* Navigation bar with login link
* Background image & responsive Bootstrap design

### 2️⃣ Login Selector

Users choose between **Admin Login** and **Doctor Login**
➡️ `loginSelector.jsp`

### 3️⃣ Role-Based Dashboards

* **Admin Dashboard** – manage users, appointments, and payments
* **Dentist Dashboard** – view and cancel appointments
* **Patient Dashboard** – book and manage appointments

### 4️⃣ Appointment Confirmation Email

Upon successful appointment creation, the system automatically sends an email using **JavaMail API** to the patient’s registered address.

---

## 🧭 Project Structure

```
DMS/
│
├── src/main/java/
│   ├── controller/
│   │   ├── AdminServlet.java
│   │   ├── DoctorServlet.java
│   │   └── PatientServlet.java
│   ├── dao/
│   │   ├── DBConnection.java
│   │   ├── AppointmentDAO.java
│   │   ├── DentistDAO.java
│   │   ├── PatientDAO.java
│   │   └── PaymentDAO.java
│   └── model/
│       ├── Dentist.java
│       ├── Patient.java
│       ├── Appointment.java
│       └── Payment.java
│
├── src/main/webapp/
│   ├── index.jsp
│   ├── loginSelector.jsp
│   ├── adminLogin.jsp
│   ├── doctorLogin.jsp
│   ├── patientLogin.jsp
│   ├── dashboardAdmin.jsp
│   ├── dashboardDentist.jsp
│   ├── dashboardPatient.jsp
│   ├── images/
│   └── css/
│
└── WEB-INF/
    ├── web.xml
```

---

## 🧠 Demonstration Steps

1. Run the SQL scripts to create database and insert data.
2. Deploy project on **Apache Tomcat** using **Eclipse**.
3. Visit:

   ```
   http://localhost:8080/DMS/
   ```
4. Login using:

   * Admin → `admin / admin123`
   * Dentist → `doc1 / doc123`
   * Patient → register or `pat1 / pat123`
5. Create appointment → check email → verify payment update trigger.

---

## 🔒 Security & Validation

* Passwords stored in hashed format (MD5 or BCrypt).
* Server-side form validation for logins and appointments.
* SQL Injection prevention using `PreparedStatement`.

---

## 🚀 Future Enhancements

* Add online payment gateway integration (e.g., PayPal API)
* Generate treatment report as downloadable PDF
* Notification system via SMS
* Role-based analytics dashboard using Chart.js
* Auto email reminders for upcoming appointments

---

## 🧑‍💻 Author

**Abhishek Bogahawaththa**
Faculty of Computing, Department of Information Technology
**Sri Lanka Institute of Information Technology (SLIIT)**
📅 *2025*

---

## 📜 License

This project is developed for **academic purposes**.
Use and modify with proper attribution.
