<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="layout/header_temp_v2.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0/dist/chartjs-plugin-datalabels.min.js"></script>

<div class="main-content">

    <div class="row">
        <!-- Debug Info Section -->
            
    </div>

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
                    <h2 class="text-primary">$<fmt:formatNumber value="${todaySales}" type="currency" currencySymbol=""/></h2>
                    <p class="text-muted">Total sales for today</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Medicine Types Pie Chart -->
        <div class="col-md-6 mb-4">
            <div class="card" style="height: 350px; border: 1px solid #dee2e6;">
                <div class="card-header">
                    <h5 class="card-title mb-0">Medicine Types Overview</h5>
                </div>
                <div class="card-body" style="padding: 10px;">
                    <canvas id="medicineTypesChart" width="300" height="200" style="display: block; margin: 0 auto;"></canvas>
                </div>
            </div>
        </div>

        <!-- Sales Chart -->
        <div class="col-md-6 mb-4">
            <div class="card" style="height: 350px;">
                <div class="card-header">
                    <h5 class="card-title mb-0">Sales Overview</h5>
                </div>
                <div class="card-body" style="padding: 10px;">
                    <canvas id="salesChart" style="width: 100%; height: 250px;"></canvas>
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

</div> <!-- End main-content -->

<script>
    console.log('medicationTypesJson:', '${medicationTypesJson}');
    console.log('medicationCountsJson:', '${medicationCountsJson}');

    const ctx = document.getElementById('salesChart').getContext('2d');
    const labels = JSON.parse('${histogramLabelsJson}');
    const data = JSON.parse('${histogramDataJson}');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Sales',
                data: data,
                backgroundColor: 'rgba(54, 162, 235, 0.7)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 10
                    }
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: 'Sales Histogram (Last 7 Days)',
                    font: {
                        size: 18,
                        weight: 'bold'
                    },
                    color: 'blue'
                },
                legend: {
                    display: false
                }
            }
        }
    });
</script>

<script>
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
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'right',
                    labels: {
                        font: {
                            size: 14
                        }
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
                            let total = context.chart._metasets[context.datasetIndex].total;
                            let percentage = total ? (value / total * 100).toFixed(2) : 0;
                            return label + ': ' + value + ' (' + percentage + '%)';
                        }
                    }
                }
            },
            datalabels: {
                formatter: (value, ctx) => {
                    let sum = 0;
                    let dataArr = ctx.chart.data.datasets[0].data;
                    dataArr.map(data => {
                        sum += data;
                    });
                    let percentage = (value*100 / sum).toFixed(2)+"%";
                    return percentage;
                },
                color: '#fff',
                anchor: 'center',
                align: 'center',
                font: {
                    weight: 'bold',
                    size: 14
                }
            }
        },
        plugins: [ChartDataLabels]
    });
</script>

<%@ include file="layout/footer.jsp" %>
