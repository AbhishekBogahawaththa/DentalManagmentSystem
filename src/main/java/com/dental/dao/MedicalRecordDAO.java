package com.dental.dao;

import com.dental.model.MedicalRecord;
import com.dental.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicalRecordDAO {

    // Get all medical records for a specific patient
    public List<MedicalRecord> getMedicalRecordsByPatientId(int patientId) {
        List<MedicalRecord> records = new ArrayList<>();
        String sql = "SELECT * FROM medical_record WHERE patient_id = ? ORDER BY date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, patientId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                MedicalRecord record = new MedicalRecord();
                record.setId(rs.getInt("id"));
                record.setPatientId(rs.getInt("patient_id")); // ✅ Important — set patient_id too
                record.setDate(rs.getString("date"));           // e.g., "2025-06-15"
                record.setProcedureName(rs.getString("procedure_name"));
                record.setDentist(rs.getString("dentist"));
                record.setStatus(rs.getString("status"));
                records.add(record);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return records;
    }

    // Add new medical record
    public void addMedicalRecord(MedicalRecord record) {
        // ✅ Assumes record already has patientId set!
        String sql = "INSERT INTO medical_record (patient_id, date, procedure_name, dentist, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, record.getPatientId());     // ✅ Must be set in the object before calling this
            stmt.setString(2, record.getDate());
            stmt.setString(3, record.getProcedureName());
            stmt.setString(4, record.getDentist());
            stmt.setString(5, record.getStatus());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating medical record failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    record.setId(generatedKeys.getInt(1)); // ✅ Set generated ID back into object
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Update existing medical record
    public void updateMedicalRecord(MedicalRecord record) {
        String sql = "UPDATE medical_record SET patient_id=?, date=?, procedure_name=?, dentist=?, status=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, record.getPatientId());      // ✅ Include patient_id in update (for data integrity)
            stmt.setString(2, record.getDate());
            stmt.setString(3, record.getProcedureName());
            stmt.setString(4, record.getDentist());
            stmt.setString(5, record.getStatus());
            stmt.setInt(6, record.getId());             // ✅ WHERE clause — critical!

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated == 0) {
                throw new SQLException("Updating medical record failed, no rows affected.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Delete medical record by ID
    public void deleteMedicalRecord(int recordId) {
        String sql = "DELETE FROM medical_record WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, recordId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}