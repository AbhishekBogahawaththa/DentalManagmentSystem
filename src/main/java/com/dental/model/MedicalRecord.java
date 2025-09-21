package com.dental.model;

public class MedicalRecord {
    private int id;
    private int patientId;          // ← Foreign key to patient.id
    private String date;            // "yyyy-MM-dd" format
    private String procedureName;
    private String dentist;
    private String status;          // e.g., "Completed", "Scheduled", "Cancelled"

    // Default constructor
    public MedicalRecord() {}

    // Getters & Setters

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getProcedureName() { return procedureName; }
    public void setProcedureName(String procedureName) { this.procedureName = procedureName; }

    public String getDentist() { return dentist; }
    public void setDentist(String dentist) { this.dentist = dentist; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "MedicalRecord{" +
                "id=" + id +
                ", patientId=" + patientId +
                ", date='" + date + '\'' +
                ", procedureName='" + procedureName + '\'' +
                ", dentist='" + dentist + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}