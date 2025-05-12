package com.pharmacy.web;

import com.pharmacy.service.MedicationService;
import com.pharmacy.service.SaleService;
import com.pharmacy.dao.SaleDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.pharmacy.model.Medication;
import com.pharmacy.model.Sale;

import com.fasterxml.jackson.databind.ObjectMapper;

public class DashboardServlet extends HttpServlet {

    private final MedicationService medicationService = new MedicationService();
    private final SaleService saleService = new SaleService();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch medication type counts
        Map<String, Integer> medicationTypeCounts = medicationService.getMedicationTypeCounts();
        request.setAttribute("medicationTypeCounts", medicationTypeCounts);

        // Convert medication type counts to JSON strings for chart
        String medicationTypesJson = objectMapper.writeValueAsString(medicationTypeCounts.keySet());
        String medicationCountsJson = objectMapper.writeValueAsString(medicationTypeCounts.values());
        request.setAttribute("medicationTypesJson", medicationTypesJson);
        request.setAttribute("medicationCountsJson", medicationCountsJson);

        // Fetch low stock and expired medications as alerts
        List<Medication> lowStockMedications = medicationService.findLowStock();
        List<Medication> expiredMedications = medicationService.findExpired();
        request.setAttribute("lowStockMedications", lowStockMedications);
        request.setAttribute("expiredMedications", expiredMedications);

        // Fetch recent sales (last 5 sales)
        List<Sale> allSales = saleService.findAll();
        List<Sale> recentSales = allSales.stream()
                .sorted((s1, s2) -> s2.getSaleDate().compareTo(s1.getSaleDate()))
                .limit(5)
                .collect(Collectors.toList());
        request.setAttribute("recentSales", recentSales);

        // Calculate today's sales total
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        Timestamp todayStart = new Timestamp(calendar.getTimeInMillis());
        calendar.add(Calendar.DAY_OF_MONTH, 1);
        Timestamp todayEnd = new Timestamp(calendar.getTimeInMillis());
        List<Sale> todaySalesList = saleService.findByDateRange(todayStart, todayEnd);
        double todaySalesTotal = todaySalesList.stream()
                .mapToDouble(sale -> sale.getTotalAmount().doubleValue())
                .sum();
        request.setAttribute("todaySales", todaySalesTotal);

        // Prepare sales histogram data for last 7 days
        calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, -6);
        Timestamp histogramStartDate = new Timestamp(calendar.getTimeInMillis());
        Timestamp histogramEndDate = new Timestamp(System.currentTimeMillis());
        List<SaleDAO.SalesByDate> salesByDate = saleService.getSalesGroupedByDate(histogramStartDate, histogramEndDate);

        // Prepare labels and data for histogram
        List<String> histogramLabels = new java.util.ArrayList<>();
        List<Double> histogramData = new java.util.ArrayList<>();

        java.time.LocalDate startDate = histogramStartDate.toLocalDateTime().toLocalDate();
        java.time.LocalDate endDate = histogramEndDate.toLocalDateTime().toLocalDate();

        java.time.LocalDate currentDate = startDate;
        while (!currentDate.isAfter(endDate)) {
            histogramLabels.add(currentDate.toString());
            histogramData.add(0.0);
            currentDate = currentDate.plusDays(1);
        }

        for (SaleDAO.SalesByDate sbd : salesByDate) {
            java.sql.Date sqlDate = sbd.getDate();
            java.time.LocalDate localDate = sqlDate.toLocalDate();
            String dateStr = localDate.toString();
            int index = histogramLabels.indexOf(dateStr);
            if (index >= 0) {
                histogramData.set(index, sbd.getTotalSales().doubleValue());
            }
        }

        com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
        String histogramLabelsJson = mapper.writeValueAsString(histogramLabels);
        String histogramDataJson = mapper.writeValueAsString(histogramData);

        request.setAttribute("histogramLabelsJson", histogramLabelsJson);
        request.setAttribute("histogramDataJson", histogramDataJson);

        // Forward to dashboard.jsp
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }
}
