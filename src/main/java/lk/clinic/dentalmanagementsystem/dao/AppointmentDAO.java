package lk.clinic.dentalmanagementsystem.dao;

import lk.clinic.dentalmanagementsystem.model.Appointment;
import lk.clinic.dentalmanagementsystem.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public List<Appointment> getDailyAppointments(Date date, Integer doctorId) throws SQLException {
        String sql = """
            SELECT a.*, p.full_name as patient_name, d.full_name as doctor_name
            FROM appointments a
            JOIN users p ON a.patient_id = p.user_id
            LEFT JOIN users d ON a.doctor_id = d.user_id
            WHERE a.appointment_date = ?
            """;

        if (doctorId != null) {
            sql += " AND a.doctor_id = ?";
        }

        sql += " ORDER BY a.appointment_time";

        return getAppointmentsByQuery(sql, date, doctorId);
    }

    public List<Appointment> getAllDailyAppointments(Date date) throws SQLException {
        String sql = """
            SELECT a.*, p.full_name as patient_name, d.full_name as doctor_name
            FROM appointments a
            JOIN users p ON a.patient_id = p.user_id
            LEFT JOIN users d ON a.doctor_id = d.user_id
            WHERE a.appointment_date = ?
            ORDER BY a.appointment_time
            """;

        return getAppointmentsByQuery(sql, date, null);
    }

    private List<Appointment> getAppointmentsByQuery(String sql, Date date, Integer doctorId) throws SQLException {

        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setDate(1, date);
            if (doctorId != null) {
                pstmt.setInt(2, doctorId);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Appointment appointment = extractAppointmentFromResultSet(rs);
                    appointments.add(appointment);
                }
            }
        }

        return appointments;
    }

    public List<Appointment> getPatientAppointments(int patientId) throws SQLException {
        String sql = """
            SELECT a.*, p.full_name as patient_name, d.full_name as doctor_name
            FROM appointments a
            JOIN users p ON a.patient_id = p.user_id
            LEFT JOIN users d ON a.doctor_id = d.user_id
            WHERE a.patient_id = ?
            ORDER BY a.appointment_date DESC, a.appointment_time DESC
            """;

        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, patientId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Appointment appointment = extractAppointmentFromResultSet(rs);
                    appointments.add(appointment);
                }
            }
        }

        return appointments;
    }

    public List<Appointment> getPendingAppointments() throws SQLException {
        String sql = """
            SELECT a.*, p.full_name as patient_name, d.full_name as doctor_name
            FROM appointments a
            JOIN users p ON a.patient_id = p.user_id
            LEFT JOIN users d ON a.doctor_id = d.user_id
            WHERE a.status = 'PENDING'
            ORDER BY a.appointment_date, a.appointment_time
            """;

        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Appointment appointment = extractAppointmentFromResultSet(rs);
                    appointments.add(appointment);
                }
            }
        }

        return appointments;
    }

    public boolean createAppointment(Appointment appointment) throws SQLException {
        String sql = """
            INSERT INTO appointments (patient_id, doctor_id, appointment_date,
                                    appointment_time, reason, status, notes)
            VALUES (?, ?, ?, ?, ?, ?, ?)
            """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, appointment.getPatientId());
            if (appointment.getDoctorId() != null) {
                pstmt.setInt(2, appointment.getDoctorId());
            } else {
                pstmt.setNull(2, Types.INTEGER);
            }
            pstmt.setDate(3, appointment.getAppointmentDate());
            pstmt.setTime(4, appointment.getAppointmentTime());
            pstmt.setString(5, appointment.getReason());
            pstmt.setString(6, appointment.getStatus());
            pstmt.setString(7, appointment.getNotes());

            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean updateAppointmentStatus(int appointmentId, String status) throws SQLException {
        String sql = "UPDATE appointments SET status = ? WHERE appointment_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, appointmentId);

            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean updateAppointmentNotes(int appointmentId, String notes) throws SQLException {
        String sql = "UPDATE appointments SET notes = ? WHERE appointment_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, notes);
            pstmt.setInt(2, appointmentId);

            return pstmt.executeUpdate() > 0;
        }
    }

    private Appointment extractAppointmentFromResultSet(ResultSet rs) throws SQLException {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(rs.getInt("appointment_id"));
        appointment.setPatientId(rs.getInt("patient_id"));
        appointment.setDoctorId(rs.getObject("doctor_id") != null ? rs.getInt("doctor_id") : null);
        appointment.setAppointmentDate(rs.getDate("appointment_date"));
        appointment.setAppointmentTime(rs.getTime("appointment_time"));
        appointment.setReason(rs.getString("reason"));
        appointment.setStatus(rs.getString("status"));
        appointment.setNotes(rs.getString("notes"));
        appointment.setCreatedAt(rs.getTimestamp("created_at"));
        appointment.setUpdatedAt(rs.getTimestamp("updated_at"));
        appointment.setPatientName(rs.getString("patient_name"));
        appointment.setDoctorName(rs.getString("doctor_name"));
        return appointment;
    }

    public List<Appointment> getAllAppointments() throws SQLException {
        String sql = """
            SELECT a.*, p.full_name as patient_name, d.full_name as doctor_name
            FROM appointments a
            JOIN users p ON a.patient_id = p.user_id
            LEFT JOIN users d ON a.doctor_id = d.user_id
            ORDER BY a.appointment_date DESC, a.appointment_time DESC
            """;

        List<Appointment> appointments = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Appointment appointment = extractAppointmentFromResultSet(rs);
                    appointments.add(appointment);
                }
            }
        }

        return appointments;
    }
}