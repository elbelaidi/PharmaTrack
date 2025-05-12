package com.pharmacy.dao;

import com.pharmacy.model.Medicine;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * DAO interface for Medicine entity.
 */
public interface MedicineDAO extends GenericDAO<Medicine, Long> {
    
    /**
     * Find medicines by name (partial match).
     *
     * @param name The name to search for
     * @return A list of medicines with names containing the search term
     */
    List<Medicine> findByNameContaining(String name);
    
    /**
     * Find medicines by category.
     *
     * @param category The category to search for
     * @return A list of medicines in the specified category
     */
    List<Medicine> findByCategory(String category);
    
    /**
     * Find medicines by manufacturer.
     *
     * @param manufacturer The manufacturer to search for
     * @return A list of medicines from the specified manufacturer
     */
    List<Medicine> findByManufacturer(String manufacturer);
    
    /**
     * Find medicines that require a prescription.
     *
     * @return A list of medicines that require a prescription
     */
    List<Medicine> findByRequiresPrescription(boolean requiresPrescription);
    
    /**
     * Find medicines with quantity below the reorder level.
     *
     * @return A list of medicines with quantity below the reorder level
     */
    List<Medicine> findLowStock();
    
    /**
     * Find medicines that will expire before a given date.
     *
     * @param date The date to check against
     * @return A list of medicines that will expire before the given date
     */
    List<Medicine> findExpiringBefore(Date date);
    
    /**
     * Find medicines by dosage form.
     *
     * @param dosageForm The dosage form to search for
     * @return A list of medicines with the specified dosage form
     */
    List<Medicine> findByDosageForm(String dosageForm);
    
    /**
     * Update the quantity of a medicine.
     *
     * @param id The ID of the medicine
     * @param quantity The new quantity
     * @return true if the quantity was updated, false otherwise
     */
    boolean updateQuantity(Long id, int quantity);
}