package com.pharmacy.web;

import com.pharmacy.model.Sale;
import com.pharmacy.model.SaleItem;
import com.pharmacy.service.MedicationService;
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

@WebServlet(name = "SaleEditServlet", urlPatterns = {"/sales/edit"})
public class SaleEditServlet extends HttpServlet {
    private final SaleService saleService = new SaleService();
    private final MedicationService medicationService = new MedicationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing sale ID");
            return;
        }
        try {
            Long saleId = Long.parseLong(idParam);
            Sale sale = saleService.findById(saleId);
            if (sale == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sale not found");
                return;
            }
            request.setAttribute("sale", sale);
            request.setAttribute("medications", medicationService.findAll());
            request.getRequestDispatcher("/WEB-INF/views/sales/edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid sale ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long saleId = Long.parseLong(request.getParameter("id"));
            String invoiceNumber = request.getParameter("invoiceNumber");
            String customerName = request.getParameter("customerName");
            String customerPhone = request.getParameter("customerPhone");

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

            Sale sale = new Sale();
            sale.setId(saleId);
            sale.setInvoiceNumber(invoiceNumber);
            sale.setCustomerName(customerName);
            sale.setCustomerPhone(customerPhone);
            sale.setItems(items);
            sale.setSaleDate(new Timestamp(System.currentTimeMillis()));

            BigDecimal totalAmount = items.stream()
                    .map(SaleItem::getTotalPrice)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            sale.setTotalAmount(totalAmount);

            saleService.update(sale);

            response.sendRedirect(request.getContextPath() + "/sales");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating sale: " + e.getMessage());
            request.setAttribute("medications", medicationService.findAll());
            request.getRequestDispatcher("/WEB-INF/views/sales/edit.jsp").forward(request, response);
        }
    }
}
