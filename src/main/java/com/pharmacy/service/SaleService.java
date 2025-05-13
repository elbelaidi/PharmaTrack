package com.pharmacy.service;

import com.pharmacy.dao.SaleDAO;
import com.pharmacy.model.Medication;
import com.pharmacy.model.Sale;
import com.pharmacy.model.SaleItem;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

public class SaleService implements BaseService<Sale> {
    private final SaleDAO saleDAO;
    private final MedicationService medicationService;

    public SaleService() {
        this.saleDAO = new SaleDAO();
        this.medicationService = new MedicationService();
    }

    @Override
    public Sale findById(Long id) {
        Sale sale = saleDAO.findById(id);
        if (sale != null && sale.getItems() != null) {
            for (SaleItem item : sale.getItems()) {
                Medication medication = medicationService.findById(item.getMedicationId());
                item.setMedication(medication);
            }
        }
        return sale;
    }

    @Override
    public List<Sale> findAll() {
        return saleDAO.findAll();
    }

    public List<Sale> getAllSales() {
        return saleDAO.findAll();
    }

    @Override
    public Sale save(Sale sale) {
        // Validate stock availability
        for (SaleItem item : sale.getItems()) {
            if (!medicationService.isStockAvailable(item.getMedicationId(), item.getQuantity())) {
                throw new IllegalStateException("Insufficient stock for medication ID: " + item.getMedicationId());
            }
        }

        // Calculate total amount
        BigDecimal totalAmount = calculateTotalAmount(sale.getItems());
        sale.setTotalAmount(totalAmount);
        sale.setSaleDate(new Timestamp(System.currentTimeMillis()));

        // Check if sale with same invoice number exists
        Sale existingSale = saleDAO.findByInvoiceNumber(sale.getInvoiceNumber());
        if (existingSale != null) {
            // Update existing sale
            sale.setId(existingSale.getId());
            Sale updatedSale = saleDAO.update(sale);
            // No stock update on update to avoid double decrement
            return updatedSale;
        } else {
            // Save new sale
            Sale savedSale = saleDAO.save(sale);
            // Update stock
            for (SaleItem item : sale.getItems()) {
                medicationService.updateStock(item.getMedicationId(), -item.getQuantity());
            }
            return savedSale;
        }
    }

    @Override
    public Sale update(Sale sale) {
        return saleDAO.update(sale);
    }

    @Override
    public void delete(Long id) {
        System.out.println("SaleService: Deleting sale with ID: " + id);
        saleDAO.delete(id);
        System.out.println("SaleService: Deleted sale with ID: " + id);
    }

    private BigDecimal calculateTotalAmount(List<SaleItem> items) {
        return items.stream()
                .map(SaleItem::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public List<Sale> findByDateRange(Timestamp startDate, Timestamp endDate) {
        return findAll().stream()
                .filter(sale -> !sale.getSaleDate().before(startDate) && !sale.getSaleDate().after(endDate))
                .collect(Collectors.toList());
    }

    public BigDecimal calculateDailySales(Timestamp date) {
        return findAll().stream()
                .filter(sale -> isSameDay(sale.getSaleDate(), date))
                .map(Sale::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public List<SaleDAO.SalesByDate> getSalesGroupedByDate(Timestamp startDate, Timestamp endDate) {
        return saleDAO.findTotalSalesGroupedByDate(startDate, endDate);
    }

    private boolean isSameDay(Timestamp date1, Timestamp date2) {
        return date1.toLocalDateTime().toLocalDate().equals(date2.toLocalDateTime().toLocalDate());
    }
} 