package com.pharmacy.api;

import com.pharmacy.model.Supplier;
import com.pharmacy.service.SupplierService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * RESTful API servlet for Supplier entity.
 * Supports CRUD operations via HTTP methods:
 * - GET: Retrieve suppliers
 * - POST: Create a new supplier
 * - PUT: Update an existing supplier
 * - DELETE: Delete a supplier
 */
public class SupplierApiServlet extends BaseApiServlet {
    private final SupplierService supplierService = new SupplierService();

    /**
     * Handles GET requests to retrieve suppliers.
     * - GET /api/suppliers: Returns all suppliers
     * - GET /api/suppliers/{id}: Returns a specific supplier
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all suppliers
            List<Supplier> suppliers = supplierService.findAll();
            
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < suppliers.size(); i++) {
                Supplier supplier = suppliers.get(i);
                json.append("{")
                    .append("\"id\":").append(supplier.getId()).append(",")
                    .append("\"name\":\"").append(supplier.getName()).append("\",")
                    .append("\"code\":\"").append(supplier.getCode()).append("\",")
                    .append("\"contactPerson\":\"").append(supplier.getContactPerson() != null ? supplier.getContactPerson() : "").append("\",")
                    .append("\"phoneNumber\":\"").append(supplier.getPhoneNumber() != null ? supplier.getPhoneNumber() : "").append("\",")
                    .append("\"email\":\"").append(supplier.getEmail() != null ? supplier.getEmail() : "").append("\",")
                    .append("\"address\":\"").append(supplier.getAddress() != null ? supplier.getAddress() : "").append("\",")
                    .append("\"notes\":\"").append(supplier.getNotes() != null ? supplier.getNotes() : "").append("\",")
                    .append("\"active\":").append(supplier.isActive()).append(",")
                    .append("\"createdAt\":\"").append(supplier.getCreatedAt()).append("\",")
                    .append("\"updatedAt\":\"").append(supplier.getUpdatedAt()).append("\"")
                    .append("}");
                if (i < suppliers.size() - 1) json.append(",");
            }
            json.append("]");
            
            writeJsonResponse(response, json.toString());
        } else {
            try {
                // Get supplier by ID
                Long id = Long.parseLong(pathInfo.substring(1));
                Supplier supplier = supplierService.findById(id);
                
                if (supplier != null) {
                    StringBuilder json = new StringBuilder();
                    json.append("{")
                        .append("\"id\":").append(supplier.getId()).append(",")
                        .append("\"name\":\"").append(supplier.getName()).append("\",")
                        .append("\"code\":\"").append(supplier.getCode()).append("\",")
                        .append("\"contactPerson\":\"").append(supplier.getContactPerson() != null ? supplier.getContactPerson() : "").append("\",")
                        .append("\"phoneNumber\":\"").append(supplier.getPhoneNumber() != null ? supplier.getPhoneNumber() : "").append("\",")
                        .append("\"email\":\"").append(supplier.getEmail() != null ? supplier.getEmail() : "").append("\",")
                        .append("\"address\":\"").append(supplier.getAddress() != null ? supplier.getAddress() : "").append("\",")
                        .append("\"notes\":\"").append(supplier.getNotes() != null ? supplier.getNotes() : "").append("\",")
                        .append("\"active\":").append(supplier.isActive()).append(",")
                        .append("\"createdAt\":\"").append(supplier.getCreatedAt()).append("\",")
                        .append("\"updatedAt\":\"").append(supplier.getUpdatedAt()).append("\"")
                        .append("}");
                    
                    writeJsonResponse(response, json.toString());
                } else {
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "Supplier not found");
                }
            } catch (NumberFormatException e) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid supplier ID");
            }
        }
    }

    /**
     * Handles POST requests to create a new supplier.
     * - POST /api/suppliers: Creates a new supplier
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        try {
            String requestBody = readRequestBody(request);
            
            // Parse JSON request body to extract supplier data
            Supplier supplier = parseSupplierJson(requestBody);
            
            // Save the supplier
            supplierService.save(supplier);
            
            // Return the created supplier with its ID
            StringBuilder json = new StringBuilder();
            json.append("{")
                .append("\"id\":").append(supplier.getId()).append(",")
                .append("\"name\":\"").append(supplier.getName()).append("\",")
                .append("\"message\":\"Supplier created successfully\"")
                .append("}");
            
            response.setStatus(HttpServletResponse.SC_CREATED);
            writeJsonResponse(response, json.toString());
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid supplier data: " + e.getMessage());
        }
    }

    /**
     * Handles PUT requests to update an existing supplier.
     * - PUT /api/suppliers/{id}: Updates a specific supplier
     */
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Supplier ID is required");
            return;
        }
        
        try {
            Long id = Long.parseLong(pathInfo.substring(1));
            Supplier existingSupplier = supplierService.findById(id);
            
            if (existingSupplier == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Supplier not found");
                return;
            }
            
            String requestBody = readRequestBody(request);
            Supplier updatedSupplier = parseSupplierJson(requestBody);
            updatedSupplier.setId(id);
            
            // Update the supplier
            supplierService.update(updatedSupplier);
            
            // Return success message
            String json = "{\"message\":\"Supplier updated successfully\"}";
            writeJsonResponse(response, json);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid supplier ID");
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid supplier data: " + e.getMessage());
        }
    }

    /**
     * Handles DELETE requests to delete a supplier.
     * - DELETE /api/suppliers/{id}: Deletes a specific supplier
     */
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Supplier ID is required");
            return;
        }
        
        try {
            Long id = Long.parseLong(pathInfo.substring(1));
            Supplier existingSupplier = supplierService.findById(id);
            
            if (existingSupplier == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Supplier not found");
                return;
            }
            
            // Delete the supplier
            supplierService.delete(id);
            
            // Return success message
            String json = "{\"message\":\"Supplier deleted successfully\"}";
            writeJsonResponse(response, json);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid supplier ID");
        }
    }

    /**
     * Parses a JSON string into a Supplier object.
     * This is a simple implementation; in a production environment,
     * you would use a proper JSON library.
     * 
     * @param json The JSON string to parse
     * @return The parsed Supplier object
     */
    private Supplier parseSupplierJson(String json) {
        // This is a very simplified JSON parsing approach
        // In a real application, use a proper JSON library like Jackson or Gson
        Supplier supplier = new Supplier();
        
        // Extract name
        String namePattern = "\"name\"\\s*:\\s*\"([^\"]+)\"";
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile(namePattern);
        java.util.regex.Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            supplier.setName(matcher.group(1));
        }
        
        // Extract code
        String codePattern = "\"code\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(codePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            supplier.setCode(matcher.group(1));
        }
        
        // Extract contactPerson
        String contactPersonPattern = "\"contactPerson\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(contactPersonPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            supplier.setContactPerson(matcher.group(1));
        }
        
        // Extract phoneNumber
        String phoneNumberPattern = "\"phoneNumber\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(phoneNumberPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            supplier.setPhoneNumber(matcher.group(1));
        }
        
        // Extract email
        String emailPattern = "\"email\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(emailPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            supplier.setEmail(matcher.group(1));
        }
        
        // Extract address
        String addressPattern = "\"address\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(addressPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            supplier.setAddress(matcher.group(1));
        }
        
        // Extract notes
        String notesPattern = "\"notes\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(notesPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            supplier.setNotes(matcher.group(1));
        }
        
        // Extract active
        String activePattern = "\"active\"\\s*:\\s*(true|false)";
        pattern = java.util.regex.Pattern.compile(activePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            supplier.setActive(Boolean.parseBoolean(matcher.group(1)));
        } else {
            // Default to active if not specified
            supplier.setActive(true);
        }
        
        return supplier;
    }
}