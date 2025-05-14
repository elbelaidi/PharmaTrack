<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="${user != null ? 'Edit User' : 'New User'}"/>
<c:set var="formAction" value="${user != null ? '/users' : '/users'}"/>

<style scoped>
    .main-content {
        margin-left: 250px;
        margin-top: 70px;
        padding: 20px;
    }
        .pharmacy-logo {
        display: flex;
        align-items: center;
        margin-bottom: 1.5rem;
    }
</style>

<div class="main-content">
    <div class="container-fluid px-4">
        <div class="card shadow-sm rounded-3">
            <div class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
                <h5 class="mb-0">${pageTitle}</h5>
                <a href="${pageContext.request.contextPath}/users" class="btn btn-light text-primary fw-semibold">
                    <i class="bi bi-arrow-left me-1"></i> Back to List
                </a>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}${formAction}" method="post" novalidate>
                    <c:if test="${user != null}">
                        <input type="hidden" name="id" value="${user.id}" />
                    </c:if>
                    <c:if test="${user == null}">
                        <input type="hidden" name="id" value="" />
                    </c:if>

                    <!-- Username -->
                    <div class="mb-3">
                        <label for="username" class="form-label">Username <span class="text-danger">*</span></label>
                        <input type="text" id="username" name="username" class="form-control" required
                               value="${user != null ? user.username : ''}" placeholder="Enter username" />
                    </div>

                    <!-- Full Name -->
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name <span class="text-danger">*</span></label>
                        <input type="text" id="fullName" name="fullName" class="form-control" required
                               value="${user != null ? user.fullName : ''}" placeholder="Enter full name" />
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                        <input type="email" id="email" name="email" class="form-control" required
                               value="${user != null ? user.email : ''}" placeholder="Enter email" />
                    </div>

                    <!-- Role -->
                    <div class="mb-3">
                        <label for="role" class="form-label">Role <span class="text-danger">*</span></label>
                        <select id="role" name="role" class="form-select" required>
                            <option value="">Select Role</option>
                            <option value="ADMIN" <c:if test="${user != null && user.role == 'ADMIN'}">selected</c:if>>Admin</option>
                            <option value="USER" <c:if test="${user != null && user.role == 'USER'}">selected</c:if>>User</option>
                        </select>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/users" class="btn btn-outline-secondary">
                            <i class="bi bi-x-circle"></i> Cancel
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
