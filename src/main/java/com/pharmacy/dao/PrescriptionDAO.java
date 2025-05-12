package com.pharmacy.dao;

import com.pharmacy.model.Prescription;
import com.pharmacy.model.User;
import java.util.Date;
import java.util.List;

/**
 * DAO interface for Prescription entity.
 */
public interface PrescriptionDAO extends GenericDAO<Prescription, Long> {
    
    /**
     * Find prescriptions by patient.
     *
     * @param patient The patient to search for
     * @return A list of prescriptions for the specified patient
     */
    List<Prescription> findByPatient(User patient);
    
    /**
     * Find prescriptions by patient ID.
     *
     * @param patientId The ID of the patient to search for
     * @return A list of prescriptions for the specified patient
     */
    List<Prescription> findByPatientId(Long patientId);
    
    /**
     * Find prescriptions by doctor name.
     *
     * @param doctorName The name of the doctor to search for
     * @return A list of prescriptions from the specified doctor
     */
    List<Prescription> findByDoctorName(String doctorName);
    
    /**
     * Find prescriptions by status.
     *
     * @param status The status to search for
     * @return A list of prescriptions with the specified status
     */
    List<Prescription> findByStatus(Prescription.PrescriptionStatus status);
    
    /**
     * Find prescriptions created between two dates.
     *
     * @param startDate The start date
     * @param endDate The end date
     * @return A list of prescriptions created between the specified dates
     */
    List<Prescription> findByPrescriptionDateBetween(Date startDate, Date endDate);
    
    /**
     * Find prescriptions that will expire before a given date.
     *
     * @param date The date to check against
     * @return A list of prescriptions that will expire before the given date
     */
    List<Prescription> findExpiringBefore(Date date);
    
    /**
     * Find prescriptions containing a specific medicine.
     *
     * @param medicineId The ID of the medicine to search for
     * @return A list of prescriptions containing the specified medicine
     */
    List<Prescription> findByMedicineId(Long medicineId);
    
    /**
     * Update the status of a prescription.
     *
     * @param id The ID of the prescription
     * @param status The new status
     * @return true if the status was updated, false otherwise
     */
    boolean updateStatus(Long id, Prescription.PrescriptionStatus status);
}