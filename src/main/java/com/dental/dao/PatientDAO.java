package com.dental.dao;

import com.dental.model.Patient;
import com.dental.util.DBUtil;

import java.sql.*;


import java.util.List;
import java.util.ArrayList;


public class PatientDAO {

    // Insert new patient
    public void addPatient(Patient patient) {
        String sql = "INSERT INTO Patients (nic, first_name, last_name, dob, gender, phone, email, address, medical_history) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, patient.getNic());
            stmt.setString(2, patient.getFirstName());
            stmt.setString(3, patient.getLastName());
            stmt.setDate(4, patient.getDateOfBirth() != null ? java.sql.Date.valueOf(patient.getDateOfBirth()) : null);


            if (patient.getDateOfBirth() != null) {
                stmt.setDate(4, Date.valueOf(patient.getDateOfBirth()));
            } else {
                stmt.setNull(4, Types.DATE);
            }

            stmt.setString(5, patient.getGender());
            stmt.setString(6, patient.getPhone());
            stmt.setString(7, patient.getEmail());
            stmt.setString(8, patient.getAddress());
            stmt.setString(9, patient.getMedicalHistory());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // Get all patients
    public List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM Patients ORDER BY id DESC";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setNic(rs.getString("nic"));
                p.setFirstName(rs.getString("first_name"));
                p.setLastName(rs.getString("last_name"));

                Date dob = rs.getDate("dob");
                if (dob != null) {
                    p.setDateOfBirth(dob.toLocalDate());
                }

                p.setGender(rs.getString("gender"));
                p.setPhone(rs.getString("phone"));
                p.setEmail(rs.getString("email"));
                p.setAddress(rs.getString("address"));
                p.setMedicalHistory(rs.getString("medical_history"));

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Find patient by ID
    public Patient getPatientById(int id) {
        String sql = "SELECT * FROM Patients WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Patient p = new Patient();
                    p.setId(rs.getInt("id"));
                    p.setNic(rs.getString("nic"));
                    p.setFirstName(rs.getString("first_name"));
                    p.setLastName(rs.getString("last_name"));

                    Date dob = rs.getDate("dob");
                    if (dob != null) {
                        p.setDateOfBirth(dob.toLocalDate());
                    }

                    p.setGender(rs.getString("gender"));
                    p.setPhone(rs.getString("phone"));
                    p.setEmail(rs.getString("email"));
                    p.setAddress(rs.getString("address"));
                    p.setMedicalHistory(rs.getString("medical_history"));
                    return p;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Update existing patient
    public void updatePatient(Patient patient) {
        String sql = "UPDATE Patients SET nic=?, first_name=?, last_name=?, dob=?, gender=?, phone=?, email=?, address=?, medical_history=?, updated_at=SYSUTCDATETIME() " +
                "WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, patient.getNic());
            stmt.setString(2, patient.getFirstName());
            stmt.setString(3, patient.getLastName());

            if (patient.getDateOfBirth() != null) {
                stmt.setDate(4, Date.valueOf(patient.getDateOfBirth()));
            } else {
                stmt.setNull(4, Types.DATE);
            }

            stmt.setString(5, patient.getGender());
            stmt.setString(6, patient.getPhone());
            stmt.setString(7, patient.getEmail());
            stmt.setString(8, patient.getAddress());
            stmt.setString(9, patient.getMedicalHistory());
            stmt.setInt(10, patient.getId());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ Delete patient
    public void deletePatient(int id) {
        String sql = "DELETE FROM Patients WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
