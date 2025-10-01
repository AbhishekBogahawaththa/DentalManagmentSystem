package com.dental.dao;

import com.dental.model.MedicalRecord;
import com.dental.model.Patient;
import com.dental.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    // Get all patients
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM patient"; // ← Assumes table name is "patient"

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setUserId(rs.getObject("user_id") != null ? rs.getInt("user_id") : null);
                p.setNic(rs.getString("nic")); // ✅ Was missing!
                p.setFirstName(rs.getString("first_name"));
                p.setLastName(rs.getString("last_name"));
                p.setEmail(rs.getString("email"));
                p.setPhone(rs.getString("phone"));
                p.setAddress(rs.getString("address"));
                p.setDateOfBirth(rs.getString("dob"));
                p.setGender(rs.getString("gender"));
                p.setMedicalHistory(rs.getString("medical_history"));
                patients.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return patients;
    }

    // Get patient by ID (for edit/delete)
    public Patient getPatientById(int id) {
        String sql = "SELECT * FROM patient WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Patient patient = new Patient();
                patient.setId(rs.getInt("id"));
                patient.setUserId(rs.getObject("user_id") != null ? rs.getInt("user_id") : null);
                patient.setNic(rs.getString("nic")); // ✅ Was missing!
                patient.setFirstName(rs.getString("first_name"));
                patient.setLastName(rs.getString("last_name"));
                patient.setEmail(rs.getString("email"));
                patient.setPhone(rs.getString("phone"));
                patient.setAddress(rs.getString("address"));
                patient.setDateOfBirth(rs.getString("dob"));
                patient.setGender(rs.getString("gender"));
                patient.setMedicalHistory(rs.getString("medical_history"));
                return patient;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get patient by User ID (for login or profile linking)
    public Patient getPatientByUserId(int userId) {
        String sql = "SELECT * FROM patient WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Patient patient = new Patient();
                patient.setId(rs.getInt("id")); // ✅ Was setting userId into id — WRONG!
                patient.setUserId(rs.getInt("user_id")); // ✅ Correctly set userId
                patient.setNic(rs.getString("nic"));
                patient.setFirstName(rs.getString("first_name"));
                patient.setLastName(rs.getString("last_name"));
                patient.setEmail(rs.getString("email"));
                patient.setPhone(rs.getString("phone"));
                patient.setAddress(rs.getString("address"));
                patient.setDateOfBirth(rs.getString("dob"));
                patient.setGender(rs.getString("gender"));
                patient.setMedicalHistory(rs.getString("medical_history"));
                return patient;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addPatient(Patient patient) {
        String sql = "INSERT INTO patient (user_id, nic, first_name, last_name, email, phone, address, dob, gender, medical_history) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setObject(1, patient.getUserId());
            stmt.setString(2, patient.getNic());
            stmt.setString(3, patient.getFirstName());
            stmt.setString(4, patient.getLastName());
            stmt.setString(5, patient.getEmail());
            stmt.setString(6, patient.getPhone());
            stmt.setString(7, patient.getAddress());
            stmt.setString(8, patient.getDob());
            stmt.setString(9, patient.getGender());
            stmt.setString(10, patient.getMedicalHistory());

            int affectedRows = stmt.executeUpdate();
            System.out.println("✅ INSERT affected " + affectedRows + " row(s)");

            if (affectedRows == 0) {
                throw new SQLException("Creating patient failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    patient.setId(generatedKeys.getInt(1));
                    System.out.println("🆕 New patient ID assigned: " + patient.getId());
                } else {
                    throw new SQLException("Creating patient failed, no ID obtained.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Insert failed: " + e.getMessage(), e); // 🔥 TEMP
        }
    }

    // In PatientDAO.java
    public void updatePatient(Patient patient) {
        String sql = "UPDATE patient SET user_id=?, nic=?, first_name=?, last_name=?, email=?, phone=?, address=?, dob=?, gender=?, medical_history=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setObject(1, patient.getUserId());
            stmt.setString(2, patient.getNic());
            stmt.setString(3, patient.getFirstName());
            stmt.setString(4, patient.getLastName());
            stmt.setString(5, patient.getEmail());
            stmt.setString(6, patient.getPhone());
            stmt.setString(7, patient.getAddress());
            stmt.setString(8, patient.getDob());
            stmt.setString(9, patient.getGender());
            stmt.setString(10, patient.getMedicalHistory());
            stmt.setInt(11, patient.getId());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("✅ UPDATE affected " + rowsAffected + " row(s) for ID: " + patient.getId());

            if (rowsAffected == 0) {
                System.err.println("❌ WARNING: No patient found with ID " + patient.getId() + ". Check if record exists.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // 🔥 TEMP: Throw to see error in browser during testing
            throw new RuntimeException("Update failed: " + e.getMessage(), e);
        }
    }

    // Delete patient
    public void deletePatient(int id) {
        String sql = "DELETE FROM patient WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Stub method - implement later if needed
    public List<MedicalRecord> getMedicalRecordsByPatientId(Integer patientId) {
        return new ArrayList<>(); // Better than List.of() for future mutability
    }
}