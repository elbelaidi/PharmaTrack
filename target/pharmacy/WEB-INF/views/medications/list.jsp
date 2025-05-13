<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="Medications" />
<c:set var="pageActions">
    <c:url value="/medications/new" var="newUrl" />
    <c:set var="action" value="${newUrl}" />
    <c:set var="icon" value="bi-plus-circle" />
    <c:set var="label" value="Add Medication" />
</c:set>

<style>
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
        overflow: hidden;
    }
    
    .card-header {
        background: linear-gradient(135deg, #4ECDC4 0%, #4ECDC4 100%);
        padding: 1.2rem;
        border-bottom: none;
    }
    
    .btn-primary {
        background: linear-gradient(135deg, #4ECDC4 0%, #4ECDC4 100%);
        border: none;
        padding: 0.6rem 1.5rem;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.3s;
    }
    
    .btn-primary:hover {
        background: linear-gradient(135deg, #4ECDC4 0%, #4ECDC4 100%);
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(26, 104, 209, 0.3);
    }
    
    .btn-light {
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.3s;
    }
    
    .btn-light:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    
    .table {
        border-collapse: separate;
        border-spacing: 0;
    }
    
    .table th {
        background-color: #f2f6fc;
        color: #495057;
        font-weight: 600;
        border-top: none;
        padding: 0.85rem 1rem;
    }
    
    .table td {
        vertical-align: middle;
        padding: 0.85rem 1rem;
        border-top: 1px solid #f1f4f8;
    }
    
    .table-hover tbody tr:hover {
        background-color: #f8f9ff;
    }
    
    .badge {
        padding: 0.55em 0.85em;
        font-weight: 500;
        border-radius: 6px;
    }
    
    .bg-success {
        background-color: #00d97e !important;
    }
    
    .bg-warning {
        background-color: #f6c343 !important;
    }
    
    .bg-danger {
        background-color: #e63757 !important;
    }
    
    .bg-info {
        background-color: #39afd1 !important;
    }
    
    .btn-group .btn {
        border-radius: 6px;
        margin: 0 3px;
    }
    
    .modal-content {
        border: none;
        border-radius: 10px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }
    
    .modal-header {
        border-radius: 10px 10px 0 0;
        padding: 1rem 1.5rem;
    }
    
    .modal-footer {
        border-top: 1px solid #f1f4f8;
        padding: 1rem 1.5rem;
    }
    
    .search-container {
        background-color: #fff;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }
    
    .action-icon {
        font-size: 0.9rem;
    }
    
    .table-container {
        background-color: #fff;
        border-radius: 8px;
        padding: 0;
        overflow: hidden;
    }
    
    .pagination .page-item.active .page-link {
        background-color: #4ECDC4;
        border-color: #4ECDC4;
    }
    
    .pagination .page-link {
        color: #4ECDC4;
    }
    
    .text-highlight {
        color: #000000;
        font-weight: 500;
    }
    
    .status-indicator {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        display: inline-block;
        margin-right: 6px;
    }
    
    .status-active {
        background-color: #00d97e;
    }
    
    .status-expired {
        background-color: #e63757;
    }
</style>

<div class="main-content">
    <div class="container-fluid">
        <div class="row mb-4">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                   
                </nav>
            </div>
        </div>
        
        <!-- Search and Filter Section -->
        <div class="search-container mb-4">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text bg-light border-0">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" class="form-control border-0" id="searchMedication" 
                               placeholder="Search medications by name, code or type...">
                    </div>
                </div>
                <div class="col-md-4 d-flex justify-content-end">
                    <a href="${newUrl}" class="btn btn-primary">
                        <i class="${icon} me-1"></i> ${label}
                    </a>
                </div>
            </div>
        </div>
        
        <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0 text-white">
                    <i class="bi bi-capsule me-2"></i>${pageTitle}
                </h5>
                <span class="badge bg-light text-primary">Total: <span id="medicationCount">${medications.size()}</span></span>
            </div>
            <div class="card-body p-0">
                <div class="table-container">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>Code</th>
                                <th>Name</th>
                                <th>Type</th>
                                <th>Stock</th>
                                <th>Price</th>
                                <th>Expiration Date</th>
                                <th style="width: 160px;" class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${medications}" var="medication">
                                <tr>
                                    <td><span class="text-highlight">${medication.code}</span></td>
                                    <td>${medication.name}</td>
                                    <td>
                                        <span class="badge bg-light text-dark">
                                            ${medication.type}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge ${medication.stock <= medication.alertThreshold ? 'bg-warning text-dark' : 'bg-success text-white'}">
                                            ${medication.stock} units
                                        </span>
                                    </td>
                                    <td>
                                        <strong>$<fmt:formatNumber value="${medication.price}" type="currency" currencySymbol="" /></strong>
                                    </td>
                                    <td>
                                        <span class="badge ${medication.expirationDate.before(today) ? 'bg-danger' : 'bg-info'} text-white">
                                            <i class="bi ${medication.expirationDate.before(today) ? 'bi-exclamation-triangle' : 'bi-calendar3'} me-1"></i>
                                            <fmt:formatDate value="${medication.expirationDate}" pattern="MM/dd/yyyy"/>
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/medications/view?id=${medication.id}"
                                               class="btn btn-sm btn-outline-info" data-bs-toggle="tooltip" title="View Details">
                                                <i class="bi bi-eye action-icon"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/medications/edit?id=${medication.id}"
                                               class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                                                <i class="bi bi-pencil action-icon"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal"
                                                    data-bs-target="#deleteModal${medication.id}" title="Delete">
                                                <i class="bi bi-trash action-icon"></i>
                                            </button>
                                        </div>

                                        <!-- Delete Modal -->
                                        <div class="modal fade" id="deleteModal${medication.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header bg-danger text-white">
                                                        <h5 class="modal-title">
                                                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                                            Confirm Delete
                                                        </h5>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body p-4">
                                                        <p class="mb-1">Are you sure you want to delete this medication?</p>
                                                        <div class="alert alert-warning mt-3">
                                                            <strong>Medication Details:</strong><br>
                                                            <span class="d-block mt-2"><strong>Name:</strong> ${medication.name}</span>
                                                            <span class="d-block"><strong>Code:</strong> ${medication.code}</span>
                                                            <span class="d-block"><strong>Current Stock:</strong> ${medication.stock} units</span>
                                                        </div>
                                                        <p class="text-danger mb-0"><small><i class="bi bi-info-circle me-1"></i> This action cannot be undone.</small></p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                                            <i class="bi bi-x-circle me-1"></i> Cancel
                                                        </button>
                                                        <form action="${pageContext.request.contextPath}/medications/delete" method="post" class="d-inline">
                                                            <input type="hidden" name="id" value="${medication.id}" />
                                                            <button type="submit" class="btn btn-danger">
                                                                <i class="bi bi-trash me-1"></i> Delete
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty medications}">
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <div class="py-4">
                                            <i class="bi bi-inbox-fill text-secondary" style="font-size: 3rem;"></i>
                                            <p class="text-muted mt-3 mb-0">No medications found.</p>
                                            <a href="${newUrl}" class="btn btn-sm btn-primary mt-3">
                                                <i class="bi bi-plus-circle me-1"></i> Add Your First Medication
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white py-3">
                <div class="row">
                    <div class="col-md-6">
                        <select class="form-select form-select-sm w-auto" id="pageSize">
                            <option value="10">10 per page</option>
                            <option value="25">25 per page</option>
                            <option value="50">50 per page</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <nav aria-label="Page navigation" class="float-end">
                            <ul class="pagination pagination-sm mb-0">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Initialize tooltips
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
        
        // Search functionality
        document.getElementById('searchMedication').addEventListener('keyup', function() {
            let input = this.value.toLowerCase();
            let rows = document.querySelectorAll('tbody tr');
            let count = 0;
            
            rows.forEach(row => {
                let text = row.textContent.toLowerCase();
                if(text.includes(input)) {
                    row.style.display = '';
                    count++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            document.getElementById('medicationCount').textContent = count;
        });
    });
</script>

<%@ include file="../layout/footer.jsp" %>