package com.pharmacy.api;

import com.pharmacy.model.Medication;
import com.pharmacy.service.MedicationService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 * RESTful API servlet for Medication entity.
 * Supports CRUD operations via HTTP methods:
 * - GET: Retrieve medications
 * - POST: Create a new medication
 * - PUT: Update an existing medication
 * - DELETE: Delete a medication
 */
public class MedicationApiServlet extends BaseApiServlet {
    private final MedicationService medicationService = new MedicationService();

    /**
     * Handles GET requests to retrieve medications.
     * - GET /api/medications: Returns all medications
     * - GET /api/medications/{id}: Returns a specific medication
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all medications
            List<Medication> medications = medicationService.findAll();
            
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < medications.size(); i++) {
                Medication medication = medications.get(i);
                json.append("{")
                    .append("\"id\":").append(medication.getId()).append(",")
                    .append("\"name\":\"").append(medication.getName()).append("\",")
                    .append("\"code\":\"").append(medication.getCode()).append("\",")
                    .append("\"description\":\"").append(medication.getDescription() != null ? medication.getDescription() : "").append("\",")
                    .append("\"type\":\"").append(medication.getType() != null ? medication.getType() : "").append("\",")
                    .append("\"dosage\":\"").append(medication.getDosage() != null ? medication.getDosage() : "").append("\",")
                    .append("\"price\":").append(medication.getPrice()).append(",")
                    .append("\"stock\":").append(medication.getStock()).append(",")
                    .append("\"alertThreshold\":").append(medication.getAlertThreshold()).append(",")
                    .append("\"expirationDate\":\"").append(medication.getExpirationDate()).append("\",")
                    .append("\"supplierId\":").append(medication.getSupplierId()).append(",")
                    .append("\"createdAt\":\"").append(medication.getCreatedAt()).append("\",")
                    .append("\"updatedAt\":\"").append(medication.getUpdatedAt()).append("\"")
                    .append("}");
                if (i < medications.size() - 1) json.append(",");
            }
            json.append("]");
            
            writeJsonResponse(response, json.toString());
        } else {
            try {
                // Get medication by ID
                Long id = Long.parseLong(pathInfo.substring(1));
                Medication medication = medicationService.findById(id);
                
                if (medication != null) {
                    StringBuilder json = new StringBuilder();
                    json.append("{")
                        .append("\"id\":").append(medication.getId()).append(",")
                        .append("\"name\":\"").append(medication.getName()).append("\",")
                        .append("\"code\":\"").append(medication.getCode()).append("\",")
                        .append("\"description\":\"").append(medication.getDescription() != null ? medication.getDescription() : "").append("\",")
                        .append("\"type\":\"").append(medication.getType() != null ? medication.getType() : "").append("\",")
                        .append("\"dosage\":\"").append(medication.getDosage() != null ? medication.getDosage() : "").append("\",")
                        .append("\"price\":").append(medication.getPrice()).append(",")
                        .append("\"stock\":").append(medication.getStock()).append(",")
                        .append("\"alertThreshold\":").append(medication.getAlertThreshold()).append(",")
                        .append("\"expirationDate\":\"").append(medication.getExpirationDate()).append("\",")
                        .append("\"supplierId\":").append(medication.getSupplierId()).append(",")
                        .append("\"createdAt\":\"").append(medication.getCreatedAt()).append("\",")
                        .append("\"updatedAt\":\"").append(medication.getUpdatedAt()).append("\"")
                        .append("}");
                    
                    writeJsonResponse(response, json.toString());
                } else {
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "Medication not found");
                }
            } catch (NumberFormatException e) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid medication ID");
            }
        }
    }

    /**
     * Handles POST requests to create a new medication.
     * - POST /api/medications: Creates a new medication
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        try {
            String requestBody = readRequestBody(request);
            
            // Parse JSON request body to extract medication data
            Medication medication = parseMedicationJson(requestBody);
            
            // Save the medication
            medicationService.save(medication);
            
            // Return the created medication with its ID
            StringBuilder json = new StringBuilder();
            json.append("{")
                .append("\"id\":").append(medication.getId()).append(",")
                .append("\"name\":\"").append(medication.getName()).append("\",")
                .append("\"message\":\"Medication created successfully\"")
                .append("}");
            
            response.setStatus(HttpServletResponse.SC_CREATED);
            writeJsonResponse(response, json.toString());
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid medication data: " + e.getMessage());
        }
    }

    /**
     * Handles PUT requests to update an existing medication.
     * - PUT /api/medications/{id}: Updates a specific medication
     */
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Medication ID is required");
            return;
        }
        
        try {
            Long id = Long.parseLong(pathInfo.substring(1));
            Medication existingMedication = medicationService.findById(id);
            
            if (existingMedication == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Medication not found");
                return;
            }
            
            String requestBody = readRequestBody(request);
            Medication updatedMedication = parseMedicationJson(requestBody);
            updatedMedication.setId(id);
            
            // Update the medication
            medicationService.update(updatedMedication);
            
            // Return success message
            String json = "{\"message\":\"Medication updated successfully\"}";
            writeJsonResponse(response, json);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid medication ID");
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid medication data: " + e.getMessage());
        }
    }

    /**
     * Handles DELETE requests to delete a medication.
     * - DELETE /api/medications/{id}: Deletes a specific medication
     */
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Medication ID is required");
            return;
        }
        
        try {
            Long id = Long.parseLong(pathInfo.substring(1));
            Medication existingMedication = medicationService.findById(id);
            
            if (existingMedication == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Medication not found");
                return;
            }
            
            // Delete the medication
            medicationService.delete(id);
            
            // Return success message
            String json = "{\"message\":\"Medication deleted successfully\"}";
            writeJsonResponse(response, json);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid medication ID");
        }
    }

    /**
     * Parses a JSON string into a Medication object.
     * This is a simple implementation; in a production environment,
     * you would use a proper JSON library.
     * 
     * @param json The JSON string to parse
     * @return The parsed Medication object
     */
    private Medication parseMedicationJson(String json) {
        // This is a very simplified JSON parsing approach
        // In a real application, use a proper JSON library like Jackson or Gson
        Medication medication = new Medication();
        
        // Extract name
        String namePattern = "\"name\"\\s*:\\s*\"([^\"]+)\"";
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile(namePattern);
        java.util.regex.Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            medication.setName(matcher.group(1));
        }
        
        // Extract code
        String codePattern = "\"code\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(codePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            medication.setCode(matcher.group(1));
        }
        
        // Extract description
        String descriptionPattern = "\"description\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(descriptionPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            medication.setDescription(matcher.group(1));
        }
        
        // Extract type
        String typePattern = "\"type\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(typePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            medication.setType(matcher.group(1));
        }
        
        // Extract dosage
        String dosagePattern = "\"dosage\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(dosagePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            medication.setDosage(matcher.group(1));
        }
        
        // Extract price
        String pricePattern = "\"price\"\\s*:\\s*([\\d.]+)";
        pattern = java.util.regex.Pattern.compile(pricePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            medication.setPrice(new BigDecimal(matcher.group(1)));
        }
        
        // Extract stock
        String stockPattern = "\"stock\"\\s*:\\s*(\\d+)";
        pattern = java.util.regex.Pattern.compile(stockPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            medication.setStock(Integer.parseInt(matcher.group(1)));
        }
        
        // Extract alertThreshold
        String alertThresholdPattern = "\"alertThreshold\"\\s*:\\s*(\\d+)";
        pattern = java.util.regex.Pattern.compile(alertThresholdPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            medication.setAlertThreshold(Integer.parseInt(matcher.group(1)));
        }
        
        // Extract expirationDate
        String expirationDatePattern = "\"expirationDate\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(expirationDatePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            try {
                medication.setExpirationDate(Date.valueOf(matcher.group(1)));
            } catch (IllegalArgumentException e) {
                // Handle date format error
                throw new IllegalArgumentException("Invalid expiration date format. Use YYYY-MM-DD.");
            }
        }
        
        // Extract supplierId
        String supplierIdPattern = "\"supplierId\"\\s*:\\s*(\\d+)";
        pattern = java.util.regex.Pattern.compile(supplierIdPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            medication.setSupplierId(Long.parseLong(matcher.group(1)));
        }
        
        return medication;
    }
}