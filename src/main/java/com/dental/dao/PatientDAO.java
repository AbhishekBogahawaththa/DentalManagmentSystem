package com.dental.dao;

import com.dental.model.Patient;
import com.dental.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    // Insert new patient

    // Get all patients
    public List<Patient> getAllPatients() throws Exception {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM Patients ORDER BY id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Patient p = new Patient();
                p.setPatientId((rs.getInt("id")));
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
                // created_at and updated_at if you want
                list.add(p);
            }
        }
        return list;
    }




    // Delete patient
    public void deletePatient(int id) throws Exception {
        String sql = "DELETE FROM Patients WHERE id=?";  // changed
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // Update patient
    public void updatePatient(Patient p) throws Exception {
        String sql = "UPDATE Patients SET FirstName=?, LastName=?, Email=?, Phone=?, Address=?, DateOfBirth=?, MedicalHistory=?, Allergies=?, UpdatedAt=SYSUTCDATETIME() WHERE id=?"; // changed
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getFirstName());
            ps.setString(2, p.getLastName());
            ps.setString(3, p.getEmail());
            ps.setString(4, p.getPhone());
            ps.setString(5, p.getAddress());
            if (p.getDateOfBirth() != null) {
                ps.setDate(6, Date.valueOf(p.getDateOfBirth()));
            } else {
                ps.setNull(6, Types.DATE);
            }
            ps.setString(7, p.getMedicalHistory());
            ps.setString(8, p.getAllergies());
            ps.setInt(9, p.getid());  // changed getid() -> getId()
            ps.executeUpdate();
        }
    }

    // Get patient by ID
    public Patient getPatientById(int id) throws Exception {
        String sql = "SELECT * FROM Patients WHERE id=?";  // changed
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Patient p = new Patient();
                    p.setPatientId(rs.getInt("id"));   // changed
                    p.setFirstName(rs.getString("FirstName"));
                    p.setLastName(rs.getString("LastName"));
                    p.setEmail(rs.getString("Email"));
                    p.setPhone(rs.getString("Phone"));
                    p.setAddress(rs.getString("Address"));
                    Date dob = rs.getDate("DateOfBirth");
                    if (dob != null) {
                        p.setDateOfBirth(dob.toLocalDate());
                    }
                    p.setMedicalHistory(rs.getString("MedicalHistory"));
                    p.setAllergies(rs.getString("Allergies"));
                    return p;
                } else {
                    return null;
                }
            }
        }
    }

    public void addPatient(Patient p) {
    }
}
