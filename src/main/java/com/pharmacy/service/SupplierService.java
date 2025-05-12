package com.pharmacy.service;

import com.pharmacy.dao.SupplierDAO;
import com.pharmacy.model.Supplier;

import java.util.List;

public class SupplierService implements BaseService<Supplier> {
    private final SupplierDAO supplierDAO;

    public SupplierService() {
        this.supplierDAO = new SupplierDAO();
    }

    @Override
    public Supplier findById(Long id) {
        return supplierDAO.findById(id);
    }

    @Override
    public List<Supplier> findAll() {
        return supplierDAO.findAll();
    }

    @Override
    public Supplier save(Supplier supplier) {
        return supplierDAO.save(supplier);
    }

    @Override
    public Supplier update(Supplier supplier) {
        return supplierDAO.update(supplier);
    }

    @Override
    public void delete(Long id) {
        supplierDAO.delete(id);
    }

    public List<Supplier> findActive() {
        return supplierDAO.findActive();
    }

    public void deactivate(Long id) {
        Supplier supplier = findById(id);
        if (supplier != null) {
            supplier.setActive(false);
            update(supplier);
        }
    }

    public void activate(Long id) {
        Supplier supplier = findById(id);
        if (supplier != null) {
            supplier.setActive(true);
            update(supplier);
        }
    }
} 