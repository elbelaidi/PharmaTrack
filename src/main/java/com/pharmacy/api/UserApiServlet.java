package com.pharmacy.api;

import com.pharmacy.model.User;
import com.pharmacy.service.UserService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * RESTful API servlet for User entity.
 * Supports CRUD operations via HTTP methods:
 * - GET: Retrieve users
 * - POST: Create a new user
 * - PUT: Update an existing user
 * - DELETE: Delete a user
 */
public class UserApiServlet extends BaseApiServlet {
    private final UserService userService = new UserService();

    /**
     * Handles GET requests to retrieve users.
     * - GET /api/users: Returns all users
     * - GET /api/users/{id}: Returns a specific user
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all users
            List<User> users = userService.findAll();
            
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < users.size(); i++) {
                User user = users.get(i);
                json.append("{")
                    .append("\"id\":").append(user.getId()).append(",")
                    .append("\"username\":\"").append(user.getUsername()).append("\",")
                    .append("\"fullName\":\"").append(user.getFullName()).append("\",")
                    .append("\"email\":\"").append(user.getEmail()).append("\",")
                    .append("\"phoneNumber\":\"").append(user.getPhoneNumber()).append("\",")
                    .append("\"role\":\"").append(user.getRole()).append("\",")
                    .append("\"active\":").append(user.isActive()).append(",")
                    .append("\"createdAt\":\"").append(user.getCreatedAt()).append("\",")
                    .append("\"lastLogin\":\"").append(user.getLastLogin()).append("\"")
                    .append("}");
                if (i < users.size() - 1) json.append(",");
            }
            json.append("]");
            
            writeJsonResponse(response, json.toString());
        } else {
            try {
                // Get user by ID
                Long id = Long.parseLong(pathInfo.substring(1));
                User user = userService.findById(id);
                
                if (user != null) {
                    StringBuilder json = new StringBuilder();
                    json.append("{")
                        .append("\"id\":").append(user.getId()).append(",")
                        .append("\"username\":\"").append(user.getUsername()).append("\",")
                        .append("\"fullName\":\"").append(user.getFullName()).append("\",")
                        .append("\"email\":\"").append(user.getEmail()).append("\",")
                        .append("\"phoneNumber\":\"").append(user.getPhoneNumber()).append("\",")
                        .append("\"role\":\"").append(user.getRole()).append("\",")
                        .append("\"active\":").append(user.isActive()).append(",")
                        .append("\"createdAt\":\"").append(user.getCreatedAt()).append("\",")
                        .append("\"lastLogin\":\"").append(user.getLastLogin()).append("\"")
                        .append("}");
                    
                    writeJsonResponse(response, json.toString());
                } else {
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "User not found");
                }
            } catch (NumberFormatException e) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            }
        }
    }

    /**
     * Handles POST requests to create a new user.
     * - POST /api/users: Creates a new user
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        try {
            String requestBody = readRequestBody(request);
            
            // Parse JSON request body to extract user data
            // This is a simple parsing approach; in a production environment, 
            // you would use a proper JSON library like Jackson or Gson
            User user = parseUserJson(requestBody);
            
            // Save the user
            userService.save(user);
            
            // Return the created user with its ID
            StringBuilder json = new StringBuilder();
            json.append("{")
                .append("\"id\":").append(user.getId()).append(",")
                .append("\"username\":\"").append(user.getUsername()).append("\",")
                .append("\"message\":\"User created successfully\"")
                .append("}");
            
            response.setStatus(HttpServletResponse.SC_CREATED);
            writeJsonResponse(response, json.toString());
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid user data: " + e.getMessage());
        }
    }

    /**
     * Handles PUT requests to update an existing user.
     * - PUT /api/users/{id}: Updates a specific user
     */
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
            return;
        }
        
        try {
            Long id = Long.parseLong(pathInfo.substring(1));
            User existingUser = userService.findById(id);
            
            if (existingUser == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "User not found");
                return;
            }
            
            String requestBody = readRequestBody(request);
            User updatedUser = parseUserJson(requestBody);
            updatedUser.setId(id);
            
            // Update the user
            userService.update(updatedUser);
            
            // Return success message
            String json = "{\"message\":\"User updated successfully\"}";
            writeJsonResponse(response, json);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid user data: " + e.getMessage());
        }
    }

    /**
     * Handles DELETE requests to delete a user.
     * - DELETE /api/users/{id}: Deletes a specific user
     */
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        setupResponse(response);
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "User ID is required");
            return;
        }
        
        try {
            Long id = Long.parseLong(pathInfo.substring(1));
            User existingUser = userService.findById(id);
            
            if (existingUser == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "User not found");
                return;
            }
            
            // Delete the user
            userService.delete(id);
            
            // Return success message
            String json = "{\"message\":\"User deleted successfully\"}";
            writeJsonResponse(response, json);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
        }
    }

    /**
     * Parses a JSON string into a User object.
     * This is a simple implementation; in a production environment,
     * you would use a proper JSON library.
     * 
     * @param json The JSON string to parse
     * @return The parsed User object
     */
    private User parseUserJson(String json) {
        // This is a very simplified JSON parsing approach
        // In a real application, use a proper JSON library like Jackson or Gson
        User user = new User();
        
        // Extract username
        String usernamePattern = "\"username\"\\s*:\\s*\"([^\"]+)\"";
        java.util.regex.Pattern pattern = java.util.regex.Pattern.compile(usernamePattern);
        java.util.regex.Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            user.setUsername(matcher.group(1));
        }
        
        // Extract password
        String passwordPattern = "\"password\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(passwordPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            user.setPassword(matcher.group(1));
        }
        
        // Extract fullName
        String fullNamePattern = "\"fullName\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(fullNamePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            user.setFullName(matcher.group(1));
        }
        
        // Extract email
        String emailPattern = "\"email\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(emailPattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            user.setEmail(matcher.group(1));
        }
        
        // Extract phoneNumber
        String phonePattern = "\"phoneNumber\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(phonePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            user.setPhoneNumber(matcher.group(1));
        }
        
        // Extract role
        String rolePattern = "\"role\"\\s*:\\s*\"([^\"]+)\"";
        pattern = java.util.regex.Pattern.compile(rolePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            user.setRole(matcher.group(1));
        }
        
        // Extract active
        String activePattern = "\"active\"\\s*:\\s*(true|false)";
        pattern = java.util.regex.Pattern.compile(activePattern);
        matcher = pattern.matcher(json);
        if (matcher.find()) {
            user.setActive(Boolean.parseBoolean(matcher.group(1)));
        }
        
        return user;
    }
}