package com.pharmacy.model;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;

/**
 * Represents a prescription in the pharmacy system.
 */
public class Prescription {
    private Long id;
    private User patient;
    private String doctorName;
    private String doctorContact;
    private List<PrescriptionItem> prescriptionItems;
    private Date prescriptionDate;
    private Date validUntil;
    private PrescriptionStatus status;
    private String notes;
    private Date createdAt;
    private Date updatedAt;

    // Enum for prescription status
    public enum PrescriptionStatus {
        PENDING,
        FILLED,
        PARTIALLY_FILLED,
        EXPIRED,
        CANCELLED
    }

    // Default constructor
    public Prescription() {
        this.prescriptionItems = new ArrayList<>();
        this.status = PrescriptionStatus.PENDING;
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    // Parameterized constructor
    public Prescription(User patient, String doctorName, String doctorContact, 
                       Date prescriptionDate, Date validUntil, String notes) {
        this.patient = patient;
        this.doctorName = doctorName;
        this.doctorContact = doctorContact;
        this.prescriptionItems = new ArrayList<>();
        this.prescriptionDate = prescriptionDate;
        this.validUntil = validUntil;
        this.status = PrescriptionStatus.PENDING;
        this.notes = notes;
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    // Inner class for prescription items
    public static class PrescriptionItem {
        private Long id;
        private Medicine medicine;
        private String dosage;
        private String frequency;
        private int quantity;
        private String instructions;
        private boolean filled;

        // Default constructor
        public PrescriptionItem() {
            this.filled = false;
        }

        // Parameterized constructor
        public PrescriptionItem(Medicine medicine, String dosage, String frequency, 
                               int quantity, String instructions) {
            this.medicine = medicine;
            this.dosage = dosage;
            this.frequency = frequency;
            this.quantity = quantity;
            this.instructions = instructions;
            this.filled = false;
        }

        // Getters and Setters
        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public Medicine getMedicine() {
            return medicine;
        }

        public void setMedicine(Medicine medicine) {
            this.medicine = medicine;
        }

        public String getDosage() {
            return dosage;
        }

        public void setDosage(String dosage) {
            this.dosage = dosage;
        }

        public String getFrequency() {
            return frequency;
        }

        public void setFrequency(String frequency) {
            this.frequency = frequency;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public String getInstructions() {
            return instructions;
        }

        public void setInstructions(String instructions) {
            this.instructions = instructions;
        }

        public boolean isFilled() {
            return filled;
        }

        public void setFilled(boolean filled) {
            this.filled = filled;
        }

        @Override
        public String toString() {
            return "PrescriptionItem{" +
                    "id=" + id +
                    ", medicine=" + (medicine != null ? medicine.getName() : "null") +
                    ", dosage='" + dosage + '\'' +
                    ", frequency='" + frequency + '\'' +
                    ", quantity=" + quantity +
                    ", instructions='" + instructions + '\'' +
                    ", filled=" + filled +
                    '}';
        }
    }

    // Methods to add and remove prescription items
    public void addPrescriptionItem(PrescriptionItem item) {
        this.prescriptionItems.add(item);
    }

    public void removePrescriptionItem(PrescriptionItem item) {
        this.prescriptionItems.remove(item);
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getPatient() {
        return patient;
    }

    public void setPatient(User patient) {
        this.patient = patient;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getDoctorContact() {
        return doctorContact;
    }

    public void setDoctorContact(String doctorContact) {
        this.doctorContact = doctorContact;
    }

    public List<PrescriptionItem> getPrescriptionItems() {
        return prescriptionItems;
    }

    public void setPrescriptionItems(List<PrescriptionItem> prescriptionItems) {
        this.prescriptionItems = prescriptionItems;
    }

    public Date getPrescriptionDate() {
        return prescriptionDate;
    }

    public void setPrescriptionDate(Date prescriptionDate) {
        this.prescriptionDate = prescriptionDate;
    }

    public Date getValidUntil() {
        return validUntil;
    }

    public void setValidUntil(Date validUntil) {
        this.validUntil = validUntil;
    }

    public PrescriptionStatus getStatus() {
        return status;
    }

    public void setStatus(PrescriptionStatus status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Prescription{" +
                "id=" + id +
                ", patient=" + (patient != null ? patient.getUsername() : "null") +
                ", doctorName='" + doctorName + '\'' +
                ", doctorContact='" + doctorContact + '\'' +
                ", prescriptionItems=" + prescriptionItems +
                ", prescriptionDate=" + prescriptionDate +
                ", validUntil=" + validUntil +
                ", status=" + status +
                ", notes='" + notes + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}