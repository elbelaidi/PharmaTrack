<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="${empty medication ? 'Add Medication' : 'Edit Medication'}" />

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
    
    .form-section {
        background-color: #f8f9ff;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
        border-left: 4px solid #4ECDC4;
    }
    
    .form-section h6 {
        color: #4ECDC4;
        margin-bottom: 15px;
        font-weight: 600;
    }
    
    .form-label {
        font-weight: 500;
        color: #495057;
    }
    
    .form-control, .form-select {
        border-radius: 6px;
        border: 1px solid #dee2e6;
        padding: 0.6rem 0.8rem;
        transition: all 0.2s;
    }
    
    .form-control:focus, .form-select:focus {
        border-color: #2c7be5;
        box-shadow: 0 0 0 0.25rem rgba(44, 123, 229, 0.25);
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
    
    .btn-outline-secondary {
        border-radius: 6px;
        padding: 0.6rem 1.5rem;
        font-weight: 500;
    }
    
    .input-group-text {
        background-color: #e9ecef;
        border-radius: 6px 0 0 6px;
    }
    
    .required-field::after {
        content: "*";
        color: #dc3545;
        margin-left: 4px;
    }

    .form-icon {
        color: #2c7be5;
        margin-right: 8px;
    }
    
    .tooltip-icon {
        color: #6c757d;
        cursor: help;
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
        
        <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0 text-white">
                    <i class="bi bi-capsule me-2"></i>${pageTitle}
                </h5>
                <a href="${pageContext.request.contextPath}/medications" class="btn btn-light text-primary fw-semibold">
                    <i class="bi bi-arrow-left me-1"></i> Back to List
                </a>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/medications" method="post">
                    <input type="hidden" name="id" value="${medication.id}">
                    
                    <!-- Basic Information -->
                    <div class="form-section">
                        <h6><i class="bi bi-info-circle form-icon"></i>Basic Information</h6>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="code" class="form-label required-field">Medication Code</label>
                                <input type="text" class="form-control" id="code" name="code" value="${medication.code}" required placeholder="Enter code">
                            </div>
                            <div class="col-md-6">
                                <label for="name" class="form-label required-field">Medication Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="${medication.name}" required placeholder="Enter name">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Medication Details -->
                    <div class="form-section">
                        <h6><i class="bi bi-clipboard-pulse form-icon"></i>Medication Details</h6>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="type" class="form-label required-field">Type</label>
                                <select class="form-select" id="type" name="type" required>
                                    <option value="">-- Select Type --</option>
                                    <option value="Tablet" <c:if test="${medication.type == 'Tablet'}">selected</c:if>>Tablet</option>
                                    <option value="Capsule" <c:if test="${medication.type == 'Capsule'}">selected</c:if>>Capsule</option>
                                    <option value="Syrup" <c:if test="${medication.type == 'Syrup'}">selected</c:if>>Syrup</option>
                                    <option value="Injection" <c:if test="${medication.type == 'Injection'}">selected</c:if>>Injection</option>
                                    <option value="Ointment" <c:if test="${medication.type == 'Ointment'}">selected</c:if>>Ointment</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="dosage" class="form-label required-field">Dosage</label>
                                <input type="text" class="form-control" id="dosage" name="dosage" value="${medication.dosage}" required placeholder="e.g., 500mg">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Inventory & Pricing -->
                    <div class="form-section">
                        <h6><i class="bi bi-currency-dollar form-icon"></i>Inventory & Pricing</h6>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="price" class="form-label required-field">Price</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" class="form-control" id="price" name="price" value="${medication.price}" step="0.01" required placeholder="0.00">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="stock" class="form-label required-field">Stock Quantity</label>
                                <input type="number" class="form-control" id="stock" name="stock" value="${medication.stock}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="alertThreshold" class="form-label">
                                    Alert Threshold
                                    <i class="bi bi-info-circle tooltip-icon" data-bs-toggle="tooltip" title="Minimum stock before alert"></i>
                                </label>
                                <input type="number" class="form-control" id="alertThreshold" name="alertThreshold" value="${medication.alertThreshold}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="expirationDate" class="form-label required-field">Expiration Date</label>
                                <input type="date" class="form-control" id="expirationDate" name="expirationDate"
                                       value="<fmt:formatDate value='${medication.expirationDate}' pattern='yyyy-MM-dd'/>" required>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Additional Information -->
                    <div class="form-section">
                        <h6><i class="bi bi-card-text form-icon"></i>Additional Information</h6>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="supplierId" class="form-label required-field">Supplier</label>
                                <select class="form-select" id="supplierId" name="supplierId" required>
                                    <option value="">-- Select Supplier --</option>
                                    <c:forEach items="${suppliers}" var="supplier">
                                        <option value="${supplier.id}" ${medication.supplierId == supplier.id ? 'selected' : ''}>${supplier.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" placeholder="Optional details">${medication.description}</textarea>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/medications" class="btn btn-outline-secondary">
                            <i class="bi bi-x-circle me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save me-1"></i> Save Medication
                        </button>
                    </div>
                </form>
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
        })
    });
</script>

<%@ include file="../layout/footer.jsp" %>