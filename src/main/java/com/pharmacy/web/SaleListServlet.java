package com.pharmacy.web;

import com.pharmacy.model.Sale;
import com.pharmacy.service.SaleService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to display list of sales at /sales
 */
@WebServlet("/sales")
public class SaleListServlet extends HttpServlet {
    private final SaleService saleService = new SaleService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Sale> sales = saleService.getAllSales();
        request.setAttribute("sales", sales);
        request.getRequestDispatcher("/WEB-INF/views/sales/list.jsp").forward(request, response);
    }
}
