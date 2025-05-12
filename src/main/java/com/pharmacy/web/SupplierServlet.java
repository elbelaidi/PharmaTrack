package com.pharmacy.web;

import com.pharmacy.model.Supplier;
import com.pharmacy.service.SupplierService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class SupplierServlet extends BaseServlet {
    private final SupplierService supplierService;

    public SupplierServlet() {
        this.supplierService = new SupplierService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        requireAuthentication(request, response);

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all suppliers
            List<Supplier> suppliers = supplierService.findAll();
            request.setAttribute("suppliers", suppliers);
            forwardToJsp(request, response, "suppliers/list.jsp");
        } else if (pathInfo.equals("/new")) {
            // Show new supplier form
            forwardToJsp(request, response, "suppliers/form.jsp");
        } else if (pathInfo.equals("/edit")) {
            // Show edit supplier form
            Long id = Long.parseLong(request.getParameter("id"));
            Supplier supplier = supplierService.findById(id);
            request.setAttribute("supplier", supplier);
            forwardToJsp(request, response, "suppliers/form.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Removed requireAuthentication to allow unrestricted access

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // Create or update supplier
            Supplier supplier = new Supplier();
            supplier.setName(request.getParameter("name"));
            supplier.setCode(request.getParameter("code"));
            supplier.setContactPerson(request.getParameter("contactPerson"));
            supplier.setPhoneNumber(request.getParameter("phoneNumber"));
            supplier.setEmail(request.getParameter("email"));
            supplier.setAddress(request.getParameter("address"));
            supplier.setNotes(request.getParameter("notes"));
            supplier.setActive(true);

            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                supplierService.save(supplier);
            } else {
                supplier.setId(Long.parseLong(id));
                supplierService.update(supplier);
            }

            redirect(response, request.getContextPath() + "/suppliers");
        } else if (pathInfo.equals("/delete")) {
            // Delete supplier
            Long id = Long.parseLong(request.getParameter("id"));
            supplierService.delete(id);
            redirect(response, request.getContextPath() + "/suppliers");
        } else if (pathInfo.equals("/activate")) {
            // Activate supplier
            Long id = Long.parseLong(request.getParameter("id"));
            supplierService.activate(id);
            redirect(response, request.getContextPath() + "/suppliers");
        } else if (pathInfo.equals("/deactivate")) {
            // Deactivate supplier
            Long id = Long.parseLong(request.getParameter("id"));
            supplierService.deactivate(id);
            redirect(response, request.getContextPath() + "/suppliers");
        }
    }
} 