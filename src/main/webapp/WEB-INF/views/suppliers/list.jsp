<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="Suppliers" />
<c:set var="pageActions">
    <c:url value="/suppliers/new" var="newUrl" />
    <c:set var="action" value="${newUrl}" />
    <c:set var="icon" value="bi-plus-circle" />
    <c:set var="label" value="New Supplier" />
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
    
    .status-inactive {
        background-color: #e63757;
    }
</style>

<div class="main-content">
    <div class="container-fluid">
        <div class="row mb-4">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <!-- Breadcrumb can be added here if needed -->
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
                        <input type="text" class="form-control border-0" id="searchSupplier" 
                               placeholder="Search suppliers by name, code or contact person...">
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
                    <i class="bi bi-people me-2"></i>${pageTitle}
                </h5>
                <span class="badge bg-light text-primary">Total: <span id="supplierCount">${suppliers.size()}</span></span>
            </div>
            <div class="card-body p-0">
                <div class="table-container">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>Code</th>
                                <th>Name</th>
                                <th>Contact Person</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th style="width: 160px;" class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${suppliers}" var="supplier">
                                <tr>
                                    <td><span class="text-highlight">${supplier.code}</span></td>
                                    <td>${supplier.name}</td>
                                    <td>${supplier.contactPerson}</td>
                                    <td>${supplier.phoneNumber}</td>
                                    <td>${supplier.email}</td>
                                    <td>
                                        <span class="badge ${supplier.active ? 'bg-success' : 'bg-danger'}">
                                            <i class="bi ${supplier.active ? 'bi-check-circle' : 'bi-x-circle'} me-1"></i>
                                            ${supplier.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/suppliers/edit?id=${supplier.id}"
                                               class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                                                <i class="bi bi-pencil action-icon"></i>
                                            </a>

                                            <c:choose>
                                                <c:when test="${supplier.active}">
                                                    <form action="${pageContext.request.contextPath}/suppliers/deactivate" method="post" class="d-inline">
                                                        <input type="hidden" name="id" value="${supplier.id}" />
                                                        <button type="submit" class="btn btn-sm btn-outline-warning" data-bs-toggle="tooltip" title="Deactivate">
                                                            <i class="bi bi-x-circle action-icon"></i>
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="${pageContext.request.contextPath}/suppliers/activate" method="post" class="d-inline">
                                                        <input type="hidden" name="id" value="${supplier.id}" />
                                                        <button type="submit" class="btn btn-sm btn-outline-success" data-bs-toggle="tooltip" title="Activate">
                                                            <i class="bi bi-check-circle action-icon"></i>
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>

                                            <form action="${pageContext.request.contextPath}/suppliers/delete" method="post" class="d-inline">
                                                <input type="hidden" name="id" value="${supplier.id}" />
                                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                                    <i class="bi bi-trash action-icon"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty suppliers}">
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <div class="py-4">
                                            <i class="bi bi-people text-secondary" style="font-size: 3rem;"></i>
                                            <p class="text-muted mt-3 mb-0">No suppliers found.</p>
                                            <a href="${newUrl}" class="btn btn-sm btn-primary mt-3">
                                                <i class="bi bi-plus-circle me-1"></i> Add Your First Supplier
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
        document.getElementById('searchSupplier').addEventListener('keyup', function() {
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
            
            document.getElementById('supplierCount').textContent = count;
        });
    });
</script>

<%@ include file="../layout/footer.jsp" %>