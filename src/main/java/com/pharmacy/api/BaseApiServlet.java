package com.pharmacy.api;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.stream.Collectors;

/**
 * Base class for all API servlets providing common functionality
 * for handling JSON requests and responses.
 */
public abstract class BaseApiServlet extends HttpServlet {
    
    /**
     * Sets up the response with JSON content type and CORS headers.
     * 
     * @param response The HTTP response
     */
    protected void setupResponse(HttpServletResponse response) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Add CORS headers
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        response.setHeader("Access-Control-Max-Age", "3600");
    }
    
    /**
     * Writes a JSON response.
     * 
     * @param response The HTTP response
     * @param json The JSON string to write
     * @throws IOException If an I/O error occurs
     */
    protected void writeJsonResponse(HttpServletResponse response, String json) throws IOException {
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
    
    /**
     * Reads the request body as a string.
     * 
     * @param request The HTTP request
     * @return The request body as a string
     * @throws IOException If an I/O error occurs
     */
    protected String readRequestBody(HttpServletRequest request) throws IOException {
        try (BufferedReader reader = request.getReader()) {
            return reader.lines().collect(Collectors.joining());
        }
    }
    
    /**
     * Handles OPTIONS requests for CORS preflight.
     */
    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response) {
        setupResponse(response);
        response.setStatus(HttpServletResponse.SC_OK);
    }
    
    /**
     * Sends an error response with the given status code and message.
     * 
     * @param response The HTTP response
     * @param statusCode The HTTP status code
     * @param message The error message
     * @throws IOException If an I/O error occurs
     */
    protected void sendError(HttpServletResponse response, int statusCode, String message) throws IOException {
        response.setStatus(statusCode);
        String json = "{\"error\": \"" + message + "\"}";
        writeJsonResponse(response, json);
    }
}