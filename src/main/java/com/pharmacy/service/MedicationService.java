package com.pharmacy.service;

import com.pharmacy.dao.MedicationDAO;
import com.pharmacy.model.Medication;

import java.util.List;

public class MedicationService implements BaseService<Medication> {
    private final MedicationDAO medicationDAO;

    public MedicationService() {
        this.medicationDAO = new MedicationDAO();
    }

    @Override
    public Medication findById(Long id) {
        return medicationDAO.findById(id);
    }

    @Override
    public List<Medication> findAll() {
        return medicationDAO.findAll();
    }

    @Override
    public Medication save(Medication medication) {
        return medicationDAO.save(medication);
    }

    @Override
    public Medication update(Medication medication) {
        return medicationDAO.update(medication);
    }

    @Override
    public void delete(Long id) {
        medicationDAO.delete(id);
    }

    public List<Medication> findLowStock() {
        return medicationDAO.findLowStock();
    }

    public List<Medication> findExpired() {
        return medicationDAO.findExpired();
    }

    public void updateStock(Long medicationId, int quantity) {
        Medication medication = findById(medicationId);
        if (medication != null) {
            medication.setStock(medication.getStock() + quantity);
            update(medication);
        }
    }

    public boolean isStockAvailable(Long medicationId, int quantity) {
        Medication medication = findById(medicationId);
        return medication != null && medication.getStock() >= quantity;
    }

    public java.util.Map<String, Integer> getMedicationTypeCounts() {
        return medicationDAO.getMedicationTypeCounts();
    }
}
