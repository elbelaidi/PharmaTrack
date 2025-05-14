<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="Sales" />
<c:url value="/sales/new" var="newUrl" />
<c:set var="icon" value="bi-plus-circle" />
<c:set var="label" value="New Sale" />

<style>
    .btn btn-primary{ 
        background-color: #4ECDC4;
    }

.main-content {
        margin-left: 250px;
        margin-top: 70px;
        padding: 30px;
        background-color: #f8f9fa;
        min-height: calc(100vh - 70px);
    }

    .card {
        border: none;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        border-radius: 10px;
    }

    .card-header {
        background: linear-gradient(135deg, #4ECDC4 0%, #4ECDC4 100%);
        padding: 1.2rem;
    }

    .table th {
        color: #495057;
        font-weight: 600;
    }

    .btn-light {
        background-color: #ffffff;
        border: 1px solid #dee2e6;
        font-weight: 500;
        border-radius: 6px;
    }

    .btn-outline-primary {
        border-radius: 6px;
    }

    .table-responsive {
        margin-top: 10px;
    }
    
    /* New search card styles */
    .search-container {
        background-color: #fff;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }
    
    .input-group-text {
        background-color: #f8f9fa;
        border: none;
    }
    
    .form-control {
        border: none;
    }
    
    .form-control:focus {
        box-shadow: none;
    }
</style>

<div class="main-content">
    <div class="container-fluid">
        <!-- Search Card -->
        <div class="search-container mb-4">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" class="form-control" id="searchSale" 
                               placeholder="Search sales by invoice #, customer or date...">
                    </div>
                </div>
                <div class="col-md-4 d-flex justify-content-end">
                    <a href="${newUrl}" class="btn btn-primary">
                        <i class="${icon} me-1"></i> ${label}
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Sales Table Card -->
        <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center text-white">
                <h5 class="mb-0"><i class="bi bi-receipt me-2"></i>${pageTitle}</h5>
                <span class="badge bg-light text-primary">Total: ${sales.size()}</span>
            </div>
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Invoice #</th>
                                <th>Customer</th>
                                <th>Date</th>
                                <th>Items</th>
                                <th>Total Amount</th>
                                <th class="text-center" style="width: 120px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sales}" var="sale">
                                <tr>
                                    <td>${sale.invoiceNumber}</td>
                                    <td>${sale.customerName}</td>
                                    <td><fmt:formatDate value="${sale.saleDate}" pattern="MM/dd/yyyy HH:mm" /></td>
                                    <td>${sale.items.size()}</td>
                                    <td>$<fmt:formatNumber value="${sale.totalAmount}" type="currency" currencySymbol="" /></td>
                                    <td class="text-center">
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/sales/view?id=${sale.id}"
                                               class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="View">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty sales}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted">No sales found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Search functionality
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('searchSale').addEventListener('keyup', function() {
            let input = this.value.toLowerCase();
            let rows = document.querySelectorAll('tbody tr');
            
            rows.forEach(row => {
                let text = row.textContent.toLowerCase();
                if(text.includes(input)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    });
</script>

<%@ include file="../layout/footer.jsp" %>