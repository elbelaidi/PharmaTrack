<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="${empty supplier ? 'New Supplier' : 'Edit Supplier'}" />

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
    }

    .card-header {
        background: linear-gradient(135deg, #4ECDC4 0%, #4ECDC4 100%);
        padding: 1.2rem;
    }

    .form-section {
        background-color: #f8f9ff;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
        border-left: 4px solid #4ECDC4;
    }

    .form-label {
        font-weight: 500;
        color: #495057;
    }

    .btn-primary {
        background: linear-gradient(135deg, #4ECDC4 0%, #4ECDC4 100%);
        border: none;
        padding: 0.6rem 1.5rem;
        border-radius: 6px;
        font-weight: 500;
    }

    .btn-outline-secondary {
        border-radius: 6px;
        padding: 0.6rem 1.5rem;
        font-weight: 500;
    }
</style>

<div class="main-content">
    
    <div class="container-fluid">
        <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center text-white">
                <h5 class="mb-0"><i class="bi bi-person-lines-fill me-2"></i>${pageTitle}</h5>
                <a href="${pageContext.request.contextPath}/suppliers" class="btn btn-light text-primary fw-semibold">
                    <i class="bi bi-arrow-left me-1"></i> Back to Suppliers List
                </a>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/suppliers" method="post">
                    <input type="hidden" name="id" value="${supplier.id}">

                    <div class="form-section">
                        <h6><i class="bi bi-person-badge form-icon"></i>Supplier Information</h6>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="code" class="form-label">Code <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="code" name="code" value="${supplier.code}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="name" name="name" value="${supplier.name}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="contactPerson" class="form-label">Contact Person <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="contactPerson" name="contactPerson" value="${supplier.contactPerson}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="phoneNumber" class="form-label">Phone Number <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="${supplier.phoneNumber}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" value="${supplier.email}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="address" class="form-label">Address <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="address" name="address" value="${supplier.address}" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h6><i class="bi bi-journal-text form-icon"></i>Notes</h6>
                        <textarea class="form-control" id="notes" name="notes" rows="3">${supplier.notes}</textarea>
                    </div>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/suppliers" class="btn btn-outline-secondary">
                            <i class="bi bi-x-circle me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save me-1"></i> Save Supplier
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
