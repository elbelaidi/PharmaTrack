package com.pharmacy.web;

import com.pharmacy.model.Medication;
import com.pharmacy.service.MedicationService;
import com.pharmacy.service.SupplierService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

public class MedicationServlet extends BaseServlet {
    private final MedicationService medicationService;
    private final SupplierService supplierService;

    public MedicationServlet() {
        this.medicationService = new MedicationService();
        this.supplierService = new SupplierService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        requireAuthentication(request, response);

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all medications
            List<Medication> medications = medicationService.findAll();
            request.setAttribute("medications", medications);
            // Add today's date for JSP usage
            request.setAttribute("today", new java.util.Date());
            forwardToJsp(request, response, "medications/list.jsp");
        } else if (pathInfo.equals("/new")) {
            // Show new medication form
            request.setAttribute("suppliers", supplierService.findActive());
            forwardToJsp(request, response, "medications/form.jsp");
        } else if (pathInfo.equals("/edit")) {
            // Show edit medication form
            Long id = Long.parseLong(request.getParameter("id"));
            Medication medication = medicationService.findById(id);
            if (medication != null && medication.getType() != null) {
                String type = medication.getType().trim();
                if (!type.isEmpty()) {
                    // Map plural or variant type values to singular form used in JSP options
                    switch (type.toLowerCase()) {
                        case "capsules":
                            type = "Capsule";
                            break;
                        case "tablets":
                            type = "Tablet";
                            break;
                        case "syrups":
                            type = "Syrup";
                            break;
                        case "injections":
                            type = "Injection";
                            break;
                        case "ointments":
                            type = "Ointment";
                            break;
                        default:
                            // Capitalize first letter, lowercase the rest
                            type = type.substring(0, 1).toUpperCase() + type.substring(1).toLowerCase();
                            break;
                    }
                    medication.setType(type);
                }
            }
            request.setAttribute("medication", medication);
            request.setAttribute("suppliers", supplierService.findActive());
            forwardToJsp(request, response, "medications/form.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Removed requireAuthentication to allow unrestricted access

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // Create or update medication
            Medication medication = new Medication();
            medication.setName(request.getParameter("name"));
            medication.setCode(request.getParameter("code"));
            medication.setDescription(request.getParameter("description"));
            medication.setType(request.getParameter("type"));
            medication.setDosage(request.getParameter("dosage"));
            medication.setPrice(new BigDecimal(request.getParameter("price")));
            medication.setStock(Integer.parseInt(request.getParameter("stock")));
            medication.setAlertThreshold(Integer.parseInt(request.getParameter("alertThreshold")));
            medication.setExpirationDate(Date.valueOf(request.getParameter("expirationDate")));
            medication.setSupplierId(Long.parseLong(request.getParameter("supplierId")));

            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                medicationService.save(medication);
            } else {
                medication.setId(Long.parseLong(id));
                medicationService.update(medication);
            }

            redirect(response, request.getContextPath() + "/medications");
        } else if (pathInfo.equals("/delete")) {
            // Delete medication
            Long id = Long.parseLong(request.getParameter("id"));
            medicationService.delete(id);
            redirect(response, request.getContextPath() + "/medications");
        }
    }
} 