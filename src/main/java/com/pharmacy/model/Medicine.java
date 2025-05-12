package com.pharmacy.model;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Represents a medicine in the pharmacy system.
 */
public class Medicine {
    private Long id;
    private String name;
    private String description;
    private String manufacturer;
    private BigDecimal price;
    private int quantity;
    private int reorderLevel;
    private boolean requiresPrescription;
    private String category;
    private String dosageForm; // tablet, capsule, syrup, etc.
    private String strength; // e.g., 500mg, 250ml
    private Date expiryDate;
    private Date createdAt;
    private Date updatedAt;

    // Default constructor
    public Medicine() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    // Parameterized constructor
    public Medicine(String name, String description, String manufacturer, BigDecimal price, 
                   int quantity, int reorderLevel, boolean requiresPrescription, 
                   String category, String dosageForm, String strength, Date expiryDate) {
        this.name = name;
        this.description = description;
        this.manufacturer = manufacturer;
        this.price = price;
        this.quantity = quantity;
        this.reorderLevel = reorderLevel;
        this.requiresPrescription = requiresPrescription;
        this.category = category;
        this.dosageForm = dosageForm;
        this.strength = strength;
        this.expiryDate = expiryDate;
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getReorderLevel() {
        return reorderLevel;
    }

    public void setReorderLevel(int reorderLevel) {
        this.reorderLevel = reorderLevel;
    }

    public boolean isRequiresPrescription() {
        return requiresPrescription;
    }

    public void setRequiresPrescription(boolean requiresPrescription) {
        this.requiresPrescription = requiresPrescription;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDosageForm() {
        return dosageForm;
    }

    public void setDosageForm(String dosageForm) {
        this.dosageForm = dosageForm;
    }

    public String getStrength() {
        return strength;
    }

    public void setStrength(String strength) {
        this.strength = strength;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
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
        return "Medicine{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", manufacturer='" + manufacturer + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", reorderLevel=" + reorderLevel +
                ", requiresPrescription=" + requiresPrescription +
                ", category='" + category + '\'' +
                ", dosageForm='" + dosageForm + '\'' +
                ", strength='" + strength + '\'' +
                ", expiryDate=" + expiryDate +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}