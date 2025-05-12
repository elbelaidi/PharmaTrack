package com.pharmacy.web;

import com.pharmacy.model.Sale;
import com.pharmacy.model.SaleItem;
import com.pharmacy.service.SaleService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet to handle web form for adding new sales at /sales/new
 */
import javax.servlet.annotation.WebServlet;

public class SaleServlet extends HttpServlet {
    private final SaleService saleService = new SaleService();
    private final com.pharmacy.service.MedicationService medicationService = new com.pharmacy.service.MedicationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            // Redirect to sales list page or handle list
            response.sendRedirect(request.getContextPath() + "/sales");
            return;
        } else if (pathInfo.equals("/new")) {
            // Fetch medications list for dropdown
            request.setAttribute("medications", medicationService.findAll());
            // Forward to JSP form page to add new sale
            request.getRequestDispatcher("/WEB-INF/views/sales/new.jsp").forward(request, response);
            return;
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Parse form parameters
            String invoiceNumber = request.getParameter("invoiceNumber");
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");
            // Get userId from session attribute instead of request parameter
            Long userId = null;
            Object userObj = request.getSession().getAttribute("user");
            if (userObj != null) {
                try {
                    // Assuming user object has getId() method
                    userId = (Long) userObj.getClass().getMethod("getId").invoke(userObj);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // Parse sale items from form parameters (assuming multiple items)
            String[] medicationIds = request.getParameterValues("medicationId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] unitPrices = request.getParameterValues("unitPrice[]");

            List<SaleItem> items = new ArrayList<>();
            if (medicationIds != null) {
                for (int i = 0; i < medicationIds.length; i++) {
                    SaleItem item = new SaleItem();
                    item.setMedicationId(Long.parseLong(medicationIds[i]));
                    item.setQuantity(Integer.parseInt(quantities[i]));
                    item.setUnitPrice(new BigDecimal(unitPrices[i]));
                    item.setTotalPrice(item.getUnitPrice().multiply(new BigDecimal(item.getQuantity())));
                    items.add(item);
                }
            }

            // Create Sale object
            Sale sale = new Sale();
            sale.setInvoiceNumber(invoiceNumber);
            sale.setCustomerName(customerName);
            sale.setCustomerPhone(customerPhone);
            sale.setUserId(userId);
            sale.setSaleDate(new Timestamp(System.currentTimeMillis()));
            sale.setItems(items);

            // Calculate total amount
            BigDecimal totalAmount = items.stream()
                    .map(SaleItem::getTotalPrice)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            sale.setTotalAmount(totalAmount);

            // Save sale
            try {
                saleService.save(sale);
                // Redirect to sales list or success page
                response.sendRedirect(request.getContextPath() + "/sales");
            } catch (IllegalStateException ise) {
                request.setAttribute("errorMessage", ise.getMessage());
                request.setAttribute("medications", new com.pharmacy.service.MedicationService().findAll());
                request.getRequestDispatcher("/WEB-INF/views/sales/new.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding sale: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/sales/new.jsp").forward(request, response);
        }
    }
}
