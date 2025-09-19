package com.dental.model;

import java.time.LocalDate;

public class Patient {
    private int id;
    private String nic;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String address;
    private LocalDate dob;
    private String gender;
    private String medicalHistory;

    // Empty constructor
    public Patient() {}

    // Full constructor
    public Patient(int id, String nic, String firstName, String lastName,
                   LocalDate dob, String gender, String phone, String email,
                   String address, String medicalHistory) {
        this.id = id;
        this.nic = nic;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dob = dob;
        this.gender = gender;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.medicalHistory = medicalHistory;
    }

    // ✅ Getters & Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNic() {
        return nic;
    }
    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    public LocalDate getDateOfBirth() {
        return dob;
    }
    public void setDateOfBirth(LocalDate dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getMedicalHistory() {
        return medicalHistory;
    }
    public void setMedicalHistory(String medicalHistory) {
        this.medicalHistory = medicalHistory;
    }

    public void setPatientId(int i) {
    }

    public int getPatientId() {

        return 0;
    }
}
