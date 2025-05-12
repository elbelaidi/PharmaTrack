package com.pharmacy.dao;

import com.pharmacy.config.DatabaseConfig;
import com.pharmacy.model.Medication;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicationDAO implements BaseDAO<Medication> {
    @Override
    public Medication findById(Long id) {
        String sql = "SELECT * FROM medications WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToMedication(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Medication> findAll() {
        List<Medication> medications = new ArrayList<>();
        String sql = "SELECT * FROM medications";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                medications.add(mapResultSetToMedication(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return medications;
    }

    @Override
    public Medication save(Medication medication) {
        String sql = "INSERT INTO medications (name, code, description, type, dosage, price, " +
                    "stock, alert_threshold, expiration_date, supplier_id, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            setMedicationParameters(stmt, medication);
            stmt.setTimestamp(11, new Timestamp(System.currentTimeMillis()));
            stmt.setTimestamp(12, new Timestamp(System.currentTimeMillis()));
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating medication failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    medication.setId(generatedKeys.getLong(1));
                } else {
                    throw new SQLException("Creating medication failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return medication;
    }

    @Override
    public Medication update(Medication medication) {
        String sql = "UPDATE medications SET name = ?, code = ?, description = ?, type = ?, " +
                    "dosage = ?, price = ?, stock = ?, alert_threshold = ?, expiration_date = ?, " +
                    "supplier_id = ?, updated_at = ? WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            setMedicationParameters(stmt, medication);
            stmt.setTimestamp(11, new Timestamp(System.currentTimeMillis()));
            stmt.setLong(12, medication.getId());
            
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return medication;
    }

    @Override
    public void delete(Long id) {
        String sql = "DELETE FROM medications WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Medication> findLowStock() {
        List<Medication> medications = new ArrayList<>();
        String sql = "SELECT * FROM medications WHERE stock <= alert_threshold";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                medications.add(mapResultSetToMedication(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return medications;
    }

    public List<Medication> findExpired() {
        List<Medication> medications = new ArrayList<>();
        String sql = "SELECT * FROM medications WHERE expiration_date <= CURRENT_DATE";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                medications.add(mapResultSetToMedication(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return medications;
    }

    private void setMedicationParameters(PreparedStatement stmt, Medication medication) throws SQLException {
        stmt.setString(1, medication.getName());
        stmt.setString(2, medication.getCode());
        stmt.setString(3, medication.getDescription());
        stmt.setString(4, medication.getType());
        stmt.setString(5, medication.getDosage());
        stmt.setBigDecimal(6, medication.getPrice());
        stmt.setInt(7, medication.getStock());
        stmt.setInt(8, medication.getAlertThreshold());
        stmt.setDate(9, medication.getExpirationDate());
        stmt.setLong(10, medication.getSupplierId());
    }

    private Medication mapResultSetToMedication(ResultSet rs) throws SQLException {
        Medication medication = new Medication();
        medication.setId(rs.getLong("id"));
        medication.setName(rs.getString("name"));
        medication.setCode(rs.getString("code"));
        medication.setDescription(rs.getString("description"));
        medication.setType(rs.getString("type"));
        medication.setDosage(rs.getString("dosage"));
        medication.setPrice(rs.getBigDecimal("price"));
        medication.setStock(rs.getInt("stock"));
        medication.setAlertThreshold(rs.getInt("alert_threshold"));
        medication.setExpirationDate(rs.getDate("expiration_date"));
        medication.setSupplierId(rs.getLong("supplier_id"));
        medication.setCreatedAt(rs.getTimestamp("created_at"));
        medication.setUpdatedAt(rs.getTimestamp("updated_at"));
        return medication;
    }

    public java.util.Map<String, Integer> getMedicationTypeCounts() {
        java.util.Map<String, Integer> typeCounts = new java.util.HashMap<>();
        String sql = "SELECT type, COUNT(*) as count FROM medications GROUP BY type";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                String type = rs.getString("type");
                int count = rs.getInt("count");
                typeCounts.put(type, count);
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return typeCounts;
    }
} 