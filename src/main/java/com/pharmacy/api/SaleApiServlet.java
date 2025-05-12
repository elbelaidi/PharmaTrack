package com.pharmacy.api;

import com.pharmacy.model.Sale;
import com.pharmacy.model.SaleItem;
import com.pharmacy.service.SaleService;
import com.pharmacy.service.MedicationService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * RESTful API servlet for Sale entity.
 * Supports CRUD operations via HTTP methods:
 * - GET: Retrieve sales
 * - POST: Create a new sale
 * - PUT: Update an existing sale
 * - DELETE: Delete a sale
 */
import javax.servlet.annotation.WebServlet;

@WebServlet("/api/sales/*")
public class SaleApiServlet extends BaseApiServlet {
    private final SaleService saleService = new SaleService();
    private final MedicationService medicationService = new MedicationService();

    /**
     * Handles GET requests to retrieve sales.
     * - GET /api/sales: Returns all sales
     * - GET /api/sales/{id}: Returns a specific sale
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all sales
            List<Sale> sales = saleService.findAll();
            
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < sales.size(); i++) {
                Sale sale = sales.get(i);
                json.append("{")
                    .append("\"id\":").append(sale.getId()).append(",")
                    .append("\"invoiceNumber\":\"").append(sale.getInvoiceNumber()).append("\",")
                    .append("\"customerName\":\"").append(sale.getCustomerName() != null ? sale.getCustomerName() : "").append("\",")
                    .append("\"customerPhone\":\"").append(sale.getCustomerPhone() != null ? sale.getCustomerPhone() : "").append("\",")
                    .append("\"totalAmount\":").append(sale.getTotalAmount()).append(",")
                    .append("\"userId\":").append(sale.getUserId()).append(",")
                    .append("\"saleDate\":\"").append(sale.getSaleDate()).append("\"");
                
                // Add items if available
                if (sale.getItems() != null && !sale.getItems().isEmpty()) {
                    json.append(",\"items\":[");
                    for (int j = 0; j < sale.getItems().size(); j++) {
                        SaleItem item = sale.getItems().get(j);
                        json.append("{")
                            .append("\"id\":").append(item.getId()).append(",")
                            .append("\"medicationId\":").append(item.getMedicationId()).append(",")
                            .append("\"quantity\":").append(item.getQuantity()).append(",")
                            .append("\"unitPrice\":").append(item.getUnitPrice()).append(",")
                            .append("\"totalPrice\":").append(item.getTotalPrice())
                            .append("}");
                        if (j < sale.getItems().size() - 1) json.append(",");
                    }
                    json.append("]");
                }
                
                json.append("}");
                if (i < sales.size() - 1) json.append(",");
            }
            json.append("]");
            
            writeJsonResponse(response, json.toString());
        } else {
            try {
                // Get sale by ID
                Long id = Long.parseLong(pathInfo.substring(1));
                Sale sale = saleService.findById(id);
                
                if (sale != null) {
                    StringBuilder json = new StringBuilder();
                    json.append("{")
                        .append("\"id\":").append(sale.getId()).append(",")
                        .append("\"invoiceNumber\":\"").append(sale.getInvoiceNumber()).append("\",")
                        .append("\"customerName\":\"").append(sale.getCustomerName() != null ? sale.getCustomerName() : "").append("\",")
                        .append("\"customerPhone\":\"").append(sale.getCustomerPhone() != null ? sale.getCustomerPhone() : "").append("\",")
                        .append("\"totalAmount\":").append(sale.getTotalAmount()).append(",")
                        .append("\"userId\":").append(sale.getUserId()).append(",")
                        .append("\"saleDate\":\"").append(sale.getSaleDate()).append("\"");
                    
                    // Add items if available
                    if (sale.getItems() != null && !sale.getItems().isEmpty()) {
                        json.append(",\"items\":[");
                        for (int j = 0; j < sale.getItems().size(); j++) {
                            SaleItem item = sale.getItems().get(j);
                            json.append("{")
                                .append("\"id\":").append(item.getId()).append(",")
                                .append("\"medicationId\":").append(item.getMedicationId()).append(",")
                                .append("\"quantity\":").append(item.getQuantity()).append(",")
                                .append("\"unitPrice\":").append(item.getUnitPrice()).append(",")
                                .append("\"totalPrice\":").append(item.getTotalPrice())
                                .append("}");
                            if (j < sale.getItems().size() - 1) json.append(",");
                        }
                        json.append("]");
                    }
                    
                    json.append("}");
                    
                    writeJsonResponse(response, json.toString());
                } else {
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "Sale not found");
                }
            } catch (NumberFormatException e) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid sale ID");
            }
        }
    }

    /**
     * Handles POST requests to create a new sale.
     * - POST /api/sales: Creates a new sale
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        try {
            String requestBody = readRequestBody(request);
            System.out.println("Received sale JSON: " + requestBody);
            
            // Parse JSON request body to extract sale data
            Sale sale = parseSaleJson(requestBody);
            System.out.println("Parsed sale object: " + sale);
            
            // Calculate total amount based on items
            if (sale.getItems() != null && !sale.getItems().isEmpty()) {
                BigDecimal totalAmount = BigDecimal.ZERO;
                for (SaleItem item : sale.getItems()) {
                    // Set the unit price from the medication if not provided
                    if (item.getUnitPrice() == null) {
                        item.setUnitPrice(medicationService.findById(item.getMedicationId()).getPrice());
                    }
                    
                    // Calculate total price for the item
                    item.setTotalPrice(item.getUnitPrice().multiply(new BigDecimal(item.getQuantity())));
                    
                    // Add to sale total
                    totalAmount = totalAmount.add(item.getTotalPrice());
                }
                sale.setTotalAmount(totalAmount);
            }
            
            // Save the sale
            saleService.save(sale);
            System.out.println("Sale saved with ID: " + sale.getId());
            
            // Return the created sale with its ID
            StringBuilder json = new StringBuilder();
            json.append("{")
                .append("\"id\":").append(sale.getId()).append(",")
                .append("\"invoiceNumber\":\"").append(sale.getInvoiceNumber()).append("\",")
                .append("\"message\":\"Sale created successfully\"")
                .append("}");
            
            response.setStatus(HttpServletResponse.SC_CREATED);
            writeJsonResponse(response, json.toString());
        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid sale data: " + e.getMessage());
        }
    }

    /**
     * Handles DELETE requests to delete a sale.
     * - DELETE /api/sales/{id}: Deletes a specific sale
     */
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Sale ID is required");
            return;
        }
        
        try {
            Long id = Long.parseLong(pathInfo.substring(1));
            Sale existingSale = saleService.findById(id);
            
            if (existingSale == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Sale not found");
                return;
            }
            
            // Delete the sale
            saleService.delete(id);
            
            // Return success message
            String json = "{\"message\":\"Sale deleted successfully\"}";
            writeJsonResponse(response, json);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid sale ID");
        }
    }

    /**
     * Parses a JSON string into a Sale object.
     * This is a simple implementation; in a production environment,
     * you would use a proper JSON library.
     * 
     * @param json The JSON string to parse
     * @return The parsed Sale object
     */
    private Sale parseSaleJson(String json) {
        // This is a very simplified JSON parsing approach
        // In a real application, use a proper JSON library like Jackson or Gson
        Sale sale = new Sale();
        
        // Extract invoiceNumber
        String invoiceNumberPattern = "\"invoiceNumber\"\\s*:\\s*\"([^\"]+)\"";
        Pattern pattern = Pattern.compile(invoiceNumberPattern);
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            sale.setInvoiceNumber(matcher.group(1));
        }
        
        // Extract customerName
        String customerNamePattern = "\"customerName\"\\s*:\\s*\"([^\"]+)\"";
        pattern = Pattern.compile(customerNamePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            sale.setCustomerName(matcher.group(1));
        }
        
        // Extract customerPhone
        String customerPhonePattern = "\"customerPhone\"\\s*:\\s*\"([^\"]+)\"";
        pattern = Pattern.compile(customerPhonePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            sale.setCustomerPhone(matcher.group(1));
        }
        
        // Extract userId
        String userIdPattern = "\"userId\"\\s*:\\s*(\\d+)";
        pattern = Pattern.compile(userIdPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            sale.setUserId(Long.parseLong(matcher.group(1)));
        }
        
        // Extract items array
        List<SaleItem> items = new ArrayList<>();
        String itemsPattern = "\"items\"\\s*:\\s*\\[(.*?)\\]";
        pattern = Pattern.compile(itemsPattern, Pattern.DOTALL);
        matcher = pattern.matcher(json);
        
        if (matcher.find()) {
            String itemsJson = matcher.group(1);
            
            // Extract individual items
            String itemPattern = "\\{(.*?)\\}";
            Pattern itemPatternCompiled = Pattern.compile(itemPattern, Pattern.DOTALL);
            Matcher itemMatcher = itemPatternCompiled.matcher(itemsJson);
            
            while (itemMatcher.find()) {
                String itemJson = itemMatcher.group(0);
                SaleItem item = parseSaleItemJson(itemJson);
                items.add(item);
            }
        }
        
        sale.setItems(items);
        
        return sale;
    }
    
    /**
     * Parses a JSON string into a SaleItem object.
     * 
     * @param json The JSON string to parse
     * @return The parsed SaleItem object
     */
    private SaleItem parseSaleItemJson(String json) {
        SaleItem item = new SaleItem();
        
        // Extract medicationId
        String medicationIdPattern = "\"medicationId\"\\s*:\\s*(\\d+)";
        Pattern pattern = Pattern.compile(medicationIdPattern);
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            item.setMedicationId(Long.parseLong(matcher.group(1)));
        }
        
        // Extract quantity
        String quantityPattern = "\"quantity\"\\s*:\\s*(\\d+)";
        pattern = Pattern.compile(quantityPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            item.setQuantity(Integer.parseInt(matcher.group(1)));
        }
        
        // Extract unitPrice (optional)
        String unitPricePattern = "\"unitPrice\"\\s*:\\s*([\\d.]+)";
        pattern = Pattern.compile(unitPricePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            item.setUnitPrice(new BigDecimal(matcher.group(1)));
        }
        
        return item;
    }
}