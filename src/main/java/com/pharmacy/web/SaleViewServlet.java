package com.pharmacy.web;

import com.pharmacy.model.Sale;
import com.pharmacy.service.SaleService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SaleViewServlet", urlPatterns = {"/sales/view"})
public class SaleViewServlet extends HttpServlet {
    private final SaleService saleService = new SaleService();

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
            request.getRequestDispatcher("/WEB-INF/views/sales/view.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid sale ID");
        }
    }
}
