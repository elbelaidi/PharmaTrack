<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="layout/header_temp_v2.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0/dist/chartjs-plugin-datalabels.min.js"></script>

<style>
    .card {
        border-radius: 16px;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        transition: transform 0.2s ease;
    }

    .card:hover {
        transform: translateY(-3px);
    }

    .card-header {
        background-color: #f8f9fa;
        border-bottom: 1px solid #dee2e6;
        border-top-left-radius: 16px;
        border-top-right-radius: 16px;
    }

    .card-title {
        font-size: 1.25rem;
        font-weight: 600;
        color: #333;
    }

    .main-content {
        padding: 30px;
        background-color: #f0f2f5;
        min-height: 100vh;
    }

    .alert {
        border-radius: 12px;
        font-size: 0.95rem;
    }

    table th, table td {
        vertical-align: middle;
    }

    .table-striped tbody tr:nth-of-type(odd) {
        background-color: #f9f9f9;
    }

    .btn-outline-primary {
        border-radius: 8px;
    }
    
    /* Chart container styles */
    .chart-container {
        position: relative;
        height: 300px;
        width: 100%;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
        .chart-container {
            height: 250px;
        }
    }
</style>

<div class="main-content">
    <div class="row">
        <!-- Alerts Section -->
        <div class="col-md-6 mb-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Alerts</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty lowStockMedications}">
                        <div class="alert alert-warning">
                            <h6 class="alert-heading">Low Stock Medications</h6>
                            <ul class="mb-0">
                                <c:forEach items="${lowStockMedications}" var="medication">
                                    <li>${medication.name} - ${medication.stock} units remaining</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    <c:if test="${not empty expiredMedications}">
                        <div class="alert alert-danger">
                            <h6 class="alert-heading">Expired Medications</h6>
                            <ul class="mb-0">
                                <c:forEach items="${expiredMedications}" var="medication">
                                    <li>${medication.name} - Expired on <fmt:formatDate value="${medication.expirationDate}" pattern="MM/dd/yyyy"/></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Today's Sales -->
        <div class="col-md-6 mb-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Today's Sales</h5>
                </div>
                <div class="card-body">
                    <h2 class="text-success">$<fmt:formatNumber value="${todaySales}" type="currency" currencySymbol=""/></h2>
                    <p class="text-muted">Total sales for today</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Medicine Types Pie Chart -->
        <div class="col-md-6 mb-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Medicine Types Overview</h5>
                </div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="medicineTypesChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sales Chart -->
        <div class="col-md-6 mb-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Sales Overview</h5>
                </div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="salesChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Sales -->
    <div class="card mb-4">
        <div class="card-header">
            <h5 class="card-title mb-0">Recent Sales</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <th>Invoice #</th>
                            <th>Customer</th>
                            <th>Date</th>
                            <th>Amount</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty recentSales}">
                            <c:forEach items="${recentSales}" var="sale">
                                <tr>
                                    <td>${sale.invoiceNumber}</td>
                                    <td>${sale.customerName}</td>
                                    <td><fmt:formatDate value="${sale.saleDate}" pattern="MM/dd/yyyy HH:mm"/></td>
                                    <td>$<fmt:formatNumber value="${sale.totalAmount}" type="currency" currencySymbol=""/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/sales/view?id=${sale.id}" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center">No recent sales found.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // Sales Chart
    const ctx = document.getElementById('salesChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
            datasets: [{
                label: 'Sales',
                data: [60, 40, 30, 50, 20, 70, 90],
                borderColor: '#007bff',
                backgroundColor: 'rgba(0, 123, 255, 0.2)',
                fill: true,
                tension: 0.4,
                pointRadius: 5,
                pointHoverRadius: 7,
                pointBackgroundColor: '#007bff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                title: {
                    display: true,
                    text: 'Weekly Sales Overview',
                    font: {
                        size: 16,
                        weight: 'bold'
                    }
                },
                legend: {
                    display: false
                }
            },
            scales: {
                x: {
                    ticks: { color: '#333' },
                    grid: { display: false }
                },
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 20,
                        color: '#333'
                    }
                }
            }
        }
    });

    // Medicine Types Pie Chart
    const medicineTypesCtx = document.getElementById('medicineTypesChart').getContext('2d');
    const medicineTypesData = JSON.parse('${medicationTypesJson}');
    const medicineCountsData = JSON.parse('${medicationCountsJson}');

    new Chart(medicineTypesCtx, {
        type: 'pie',
        data: {
            labels: medicineTypesData,
            datasets: [{
                label: 'Medicine Types',
                data: medicineCountsData,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.6)',
                    'rgba(54, 162, 235, 0.6)',
                    'rgba(255, 206, 86, 0.6)',
                    'rgba(75, 192, 192, 0.6)',
                    'rgba(153, 102, 255, 0.6)',
                    'rgba(255, 159, 64, 0.6)'
                ],
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'right',
                    labels: {
                        font: { size: 12 }
                    }
                },
                title: {
                    display: true,
                    text: 'Medicine Types Distribution',
                    font: {
                        size: 16,
                        weight: 'bold'
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.label || '';
                            let value = context.parsed || 0;
                            let total = context.dataset.data.reduce((a, b) => a + b, 0);
                            let percentage = total ? (value / total * 100).toFixed(2) : 0;
                            return label + ': ' + value + ' (' + percentage + '%)';
                        }
                    }
                },
                datalabels: {
                    formatter: (value, ctx) => {
                        let sum = ctx.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                        let percentage = (value * 100 / sum).toFixed(1) + "%";
                        return percentage;
                    },
                    color: '#fff',
                    font: {
                        weight: 'bold',
                        size: 12
                    }
                }
            }
        },
        plugins: [ChartDataLabels]
    });
</script>

<%@ include file="layout/footer.jsp" %>