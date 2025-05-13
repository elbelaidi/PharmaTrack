package com.pharmacy.dao;

import com.pharmacy.config.DatabaseConfig;
import com.pharmacy.model.Sale;
import com.pharmacy.model.SaleItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SaleDAO implements BaseDAO<Sale> {
    @Override
    public Sale findById(Long id) {
        String sql = "SELECT * FROM sales WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Sale sale = mapResultSetToSale(rs);
                sale.setItems(findSaleItems(sale.getId()));
                return sale;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Sale> findAll() {
        List<Sale> sales = new ArrayList<>();
        String sql = "SELECT * FROM sales";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Sale sale = mapResultSetToSale(rs);
                sale.setItems(findSaleItems(sale.getId()));
                sales.add(sale);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sales;
    }

    @Override
    public Sale save(Sale sale) {
        // Check if sale with same invoice_number exists
        Sale existingSale = findByInvoiceNumber(sale.getInvoiceNumber());
        if (existingSale != null) {
            // Sale exists, throw exception or handle update
            throw new IllegalStateException("Sale with invoice number " + sale.getInvoiceNumber() + " already exists.");
        }

        String sql = "INSERT INTO sales (invoice_number, customer_name, customer_phone, " +
                    "total_amount, user_id, sale_date) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            setSaleParameters(stmt, sale);
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating sale failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    sale.setId(generatedKeys.getLong(1));
                    saveSaleItems(sale);
                } else {
                    throw new SQLException("Creating sale failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sale;
    }

    public Sale findByInvoiceNumber(String invoiceNumber) {
        String sql = "SELECT * FROM sales WHERE invoice_number = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, invoiceNumber);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Sale sale = mapResultSetToSale(rs);
                sale.setItems(findSaleItems(sale.getId()));
                return sale;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    
    @Override
    public Sale update(Sale sale) {
        String sql = "UPDATE sales SET invoice_number = ?, customer_name = ?, customer_phone = ?, " +
                    "total_amount = ?, user_id = ?, sale_date = ? WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            setSaleParameters(stmt, sale);
            stmt.setLong(7, sale.getId());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                System.out.println("No rows updated. The sale might not exist.");
            } else {
                updateSaleItems(sale);
            }
        } catch (SQLException e) {
            System.err.println("Error executing update: " + e.getMessage());
            e.printStackTrace();
        }
        return sale;
    }


    @Override
    public void delete(Long id) {
        String sql = "DELETE FROM sales WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                System.err.println("No sale found with id " + id + " to delete.");
            } else {
                System.out.println("Sale with id " + id + " deleted successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void setSaleParameters(PreparedStatement stmt, Sale sale) throws SQLException {
        stmt.setString(1, sale.getInvoiceNumber());
        stmt.setString(2, sale.getCustomerName());
        stmt.setString(3, sale.getCustomerPhone());
        stmt.setBigDecimal(4, sale.getTotalAmount());
        stmt.setLong(5, sale.getUserId());
        stmt.setTimestamp(6, sale.getSaleDate());
    }

    private Sale mapResultSetToSale(ResultSet rs) throws SQLException {
        Sale sale = new Sale();
        sale.setId(rs.getLong("id"));
        sale.setInvoiceNumber(rs.getString("invoice_number"));
        sale.setCustomerName(rs.getString("customer_name"));
        sale.setCustomerPhone(rs.getString("customer_phone"));
        sale.setTotalAmount(rs.getBigDecimal("total_amount"));
        sale.setUserId(rs.getLong("user_id"));
        sale.setSaleDate(rs.getTimestamp("sale_date"));
        return sale;
    }

    private List<SaleItem> findSaleItems(Long saleId) {
        List<SaleItem> items = new ArrayList<>();
        String sql = "SELECT * FROM sale_items WHERE sale_id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, saleId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                items.add(mapResultSetToSaleItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    private void saveSaleItems(Sale sale) {
        String sql = "INSERT INTO sale_items (sale_id, medication_id, quantity, unit_price, total_price) " +
                    "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (SaleItem item : sale.getItems()) {
                stmt.setLong(1, sale.getId());
                stmt.setLong(2, item.getMedicationId());
                stmt.setInt(3, item.getQuantity());
                stmt.setBigDecimal(4, item.getUnitPrice());
                stmt.setBigDecimal(5, item.getTotalPrice());
                stmt.addBatch();
            }
            stmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void updateSaleItems(Sale sale) {
        // First delete existing items
        String deleteSql = "DELETE FROM sale_items WHERE sale_id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(deleteSql)) {
            stmt.setLong(1, sale.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Then save new items
        saveSaleItems(sale);
    }

    private SaleItem mapResultSetToSaleItem(ResultSet rs) throws SQLException {
        SaleItem item = new SaleItem();
        item.setId(rs.getLong("id"));
        item.setSaleId(rs.getLong("sale_id"));
        item.setMedicationId(rs.getLong("medication_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setUnitPrice(rs.getBigDecimal("unit_price"));
        item.setTotalPrice(rs.getBigDecimal("total_price"));
        return item;
    }

    public List<SalesByDate> findTotalSalesGroupedByDate(Timestamp startDate, Timestamp endDate) {
        List<SalesByDate> salesByDateList = new ArrayList<>();
        String sql = "SELECT DATE(sale_date) as sale_day, SUM(total_amount) as total_sales " +
                     "FROM sales WHERE sale_date BETWEEN ? AND ? GROUP BY sale_day ORDER BY sale_day ASC";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTimestamp(1, startDate);
            stmt.setTimestamp(2, endDate);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                SalesByDate salesByDate = new SalesByDate();
                salesByDate.setDate(rs.getDate("sale_day"));
                salesByDate.setTotalSales(rs.getBigDecimal("total_sales"));
                salesByDateList.add(salesByDate);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return salesByDateList;
    }

    public static class SalesByDate {
        private java.sql.Date date;
        private java.math.BigDecimal totalSales;

        public java.sql.Date getDate() {
            return date;
        }

        public void setDate(java.sql.Date date) {
            this.date = date;
        }

        public java.math.BigDecimal getTotalSales() {
            return totalSales;
        }

        public void setTotalSales(java.math.BigDecimal totalSales) {
            this.totalSales = totalSales;
        }
    }
}
