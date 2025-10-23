CREATE DATABASE IF NOT EXISTS dental_clinic;
USE dental_clinic;

CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    role ENUM('DOCTOR', 'PATIENT') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason VARCHAR(255),
    status ENUM('PENDING', 'APPROVED', 'REJECTED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES users(user_id) ON DELETE SET NULL
);

INSERT INTO users (username, password, full_name, email, phone, role) VALUES
('doctor1', 'password123', 'Dr. Silva', 'doctor@clinic.lk', '0771234567', 'DOCTOR'),
('patient1', 'password123', 'John Perera', 'john@gmail.com', '0772345678', 'PATIENT'),
('patient2', 'password123', 'Mary Fernando', 'mary@gmail.com', '0773456789', 'PATIENT');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, reason, status) VALUES
(2, 1, CURDATE(), '10:00:00', 'Regular Checkup', 'APPROVED'),
(3, 1, CURDATE(), '11:00:00', 'Tooth Pain', 'APPROVED'),
(2, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '14:00:00', 'Cleaning', 'PENDING');