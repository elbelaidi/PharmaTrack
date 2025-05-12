package com.pharmacy.dao;

import com.pharmacy.config.DatabaseConfig;
import com.pharmacy.model.Supplier;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO implements BaseDAO<Supplier> {
    @Override
    public Supplier findById(Long id) {
        String sql = "SELECT * FROM suppliers WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToSupplier(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Supplier> findAll() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM suppliers";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                suppliers.add(mapResultSetToSupplier(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    @Override
    public Supplier save(Supplier supplier) {
        String sql = "INSERT INTO suppliers (name, code, contact_person, phone_number, email, " +
                    "address, notes, active, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            setSupplierParameters(stmt, supplier);
            stmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
            stmt.setTimestamp(10, new Timestamp(System.currentTimeMillis()));
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating supplier failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    supplier.setId(generatedKeys.getLong(1));
                } else {
                    throw new SQLException("Creating supplier failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return supplier;
    }

    @Override
    public Supplier update(Supplier supplier) {
        String sql = "UPDATE suppliers SET name = ?, code = ?, contact_person = ?, phone_number = ?, " +
                    "email = ?, address = ?, notes = ?, active = ?, updated_at = ? WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            setSupplierParameters(stmt, supplier);
            stmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
            stmt.setLong(10, supplier.getId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return supplier;
    }

    @Override
    public void delete(Long id) {
        String sql = "DELETE FROM suppliers WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Supplier> findActive() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM suppliers WHERE active = true";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                suppliers.add(mapResultSetToSupplier(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    private void setSupplierParameters(PreparedStatement stmt, Supplier supplier) throws SQLException {
        stmt.setString(1, supplier.getName());
        stmt.setString(2, supplier.getCode());
        stmt.setString(3, supplier.getContactPerson());
        stmt.setString(4, supplier.getPhoneNumber());
        stmt.setString(5, supplier.getEmail());
        stmt.setString(6, supplier.getAddress());
        stmt.setString(7, supplier.getNotes());
        stmt.setBoolean(8, supplier.isActive());
    }

    private Supplier mapResultSetToSupplier(ResultSet rs) throws SQLException {
        Supplier supplier = new Supplier();
        supplier.setId(rs.getLong("id"));
        supplier.setName(rs.getString("name"));
        supplier.setCode(rs.getString("code"));
        supplier.setContactPerson(rs.getString("contact_person"));
        supplier.setPhoneNumber(rs.getString("phone_number"));
        supplier.setEmail(rs.getString("email"));
        supplier.setAddress(rs.getString("address"));
        supplier.setNotes(rs.getString("notes"));
        supplier.setActive(rs.getBoolean("active"));
        supplier.setCreatedAt(rs.getTimestamp("created_at"));
        supplier.setUpdatedAt(rs.getTimestamp("updated_at"));
        return supplier;
    }
} 