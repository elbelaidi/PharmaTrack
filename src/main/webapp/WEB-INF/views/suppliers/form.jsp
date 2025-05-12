<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="${empty supplier ? 'New Supplier' : 'Edit Supplier'}" />

<div class="main-content" style="margin-left: 250px; margin-top: 80px;">
    <div class="container-fluid px-4">
        <div class="card shadow-sm rounded-3">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">${pageTitle}</h5>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/suppliers" method="post">
                    <input type="hidden" name="id" value="${supplier.id}">

                    <!-- Code & Name -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="code" class="form-label">Code <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="code" name="code" value="${supplier.code}" required>
                        </div>
                        <div class="col-md-6">
                            <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" value="${supplier.name}" required>
                        </div>
                    </div>

                    <!-- Contact Person & Phone -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="contactPerson" class="form-label">Contact Person <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="contactPerson" name="contactPerson" value="${supplier.contactPerson}" required>
                        </div>
                        <div class="col-md-6">
                            <label for="phoneNumber" class="form-label">Phone Number <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="${supplier.phoneNumber}" required>
                        </div>
                    </div>

                    <!-- Email & Address -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" value="${supplier.email}" required>
                        </div>
                        <div class="col-md-6">
                            <label for="address" class="form-label">Address <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="address" name="address" value="${supplier.address}" required>
                        </div>
                    </div>

                    <!-- Notes -->
                    <div class="mb-3">
                        <label for="notes" class="form-label">Notes</label>
                        <textarea class="form-control" id="notes" name="notes" rows="3">${supplier.notes}</textarea>
                    </div>

                    <!-- Buttons -->
                    <div class="d-flex justify-content-end">
                        <a href="${pageContext.request.contextPath}/suppliers" class="btn btn-outline-secondary me-2">
                            <i class="bi bi-arrow-left"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save"></i> Save
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
