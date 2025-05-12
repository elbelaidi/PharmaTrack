<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="${empty medication ? 'Add Medication' : 'Edit Medication'}" />

<style scoped>
    .main-content {
        margin-left: 250px;
        margin-top: 70px;
        padding: 20px;
    }
</style>

<div class="main-content">
    <div class="container-fluid px-4">
        <div class="card shadow-sm rounded-3">
            <div class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
                <h5 class="mb-0">${pageTitle}</h5>
                <a href="${pageContext.request.contextPath}/medications" class="btn btn-light text-primary fw-semibold">
                    <i class="bi bi-arrow-left me-1"></i> Back to List
                </a>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/medications" method="post">
                    <input type="hidden" name="id" value="${medication.id}">

                    <!-- Code & Name -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="code" class="form-label">Medication Code <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="code" name="code" value="${medication.code}" required placeholder="Enter code">
                        </div>
                        <div class="col-md-6">
                            <label for="name" class="form-label">Medication Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" value="${medication.name}" required placeholder="Enter name">
                        </div>
                    </div>

                    <!-- Type & Dosage -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="type" class="form-label">Type <span class="text-danger">*</span></label>
                            <select class="form-select" id="type" name="type" required>
                                <option value="">-- Select Type --</option>
                                <option value="Tablet" ${medication.type == 'Tablet' ? 'selected' : ''}>Tablet</option>
                                <option value="Capsule" ${medication.type == 'Capsule' ? 'selected' : ''}>Capsule</option>
                                <option value="Syrup" ${medication.type == 'Syrup' ? 'selected' : ''}>Syrup</option>
                                <option value="Injection" ${medication.type == 'Injection' ? 'selected' : ''}>Injection</option>
                                <option value="Ointment" ${medication.type == 'Ointment' ? 'selected' : ''}>Ointment</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="dosage" class="form-label">Dosage <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="dosage" name="dosage" value="${medication.dosage}" required placeholder="e.g., 500mg">
                        </div>
                    </div>

                    <!-- Price & Stock -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="price" class="form-label">Price ($) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="price" name="price" value="${medication.price}" step="0.01" required placeholder="0.00">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="stock" class="form-label">Stock Quantity <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="stock" name="stock" value="${medication.stock}" required>
                        </div>
                    </div>

                    <!-- Alert & Expiration -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="alertThreshold" class="form-label">
                                Alert Threshold
                                <i class="bi bi-info-circle" data-bs-toggle="tooltip" title="Minimum stock before alert"></i>
                            </label>
                            <input type="number" class="form-control" id="alertThreshold" name="alertThreshold" value="${medication.alertThreshold}" required>
                        </div>
                        <div class="col-md-6">
                            <label for="expirationDate" class="form-label">Expiration Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="expirationDate" name="expirationDate"
                                   value="<fmt:formatDate value='${medication.expirationDate}' pattern='yyyy-MM-dd'/>" required>
                        </div>
                    </div>

                    <!-- Supplier & Description -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label for="supplierId" class="form-label">Supplier <span class="text-danger">*</span></label>
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

                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/medications" class="btn btn-outline-secondary">
                            <i class="bi bi-x-circle"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save"></i> Save Medication
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
