<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="Suppliers" />
<c:set var="pageActions">
    <c:url value="/suppliers/new" var="newUrl" />
    <c:set var="action" value="${newUrl}" />
    <c:set var="icon" value="bi-plus-circle" />
    <c:set var="label" value="New Supplier" />
</c:set>

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
                <a href="${newUrl}" class="btn btn-light text-primary fw-semibold">
                    <i class="${icon} me-1"></i> ${label}
                </a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Code</th>
                                <th>Name</th>
                                <th>Contact Person</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th style="width: 160px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${suppliers}" var="supplier">
                                <tr>
                                    <td>${supplier.code}</td>
                                    <td>${supplier.name}</td>
                                    <td>${supplier.contactPerson}</td>
                                    <td>${supplier.phoneNumber}</td>
                                    <td>${supplier.email}</td>
                                    <td>
                                        <span class="badge ${supplier.active ? 'bg-success' : 'bg-danger'}">
                                            ${supplier.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/suppliers/edit?id=${supplier.id}"
                                               class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>

                                            <c:choose>
                                                <c:when test="${supplier.active}">
                                                    <form action="${pageContext.request.contextPath}/suppliers/deactivate" method="post" class="d-inline">
                                                        <input type="hidden" name="id" value="${supplier.id}" />
                                                        <button type="submit" class="btn btn-sm btn-outline-warning" data-bs-toggle="tooltip" title="Deactivate">
                                                            <i class="bi bi-x-circle"></i>
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="${pageContext.request.contextPath}/suppliers/activate" method="post" class="d-inline">
                                                        <input type="hidden" name="id" value="${supplier.id}" />
                                                        <button type="submit" class="btn btn-sm btn-outline-success" data-bs-toggle="tooltip" title="Activate">
                                                            <i class="bi bi-check-circle"></i>
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>

                                            <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal${supplier.id}" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>

                                        <!-- Delete Confirmation Modal -->
                                        <div class="modal fade" id="deleteModal${supplier.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title fw-bold">Delete Supplier</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to delete <strong>${supplier.name}</strong>?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <form action="${pageContext.request.contextPath}/suppliers/delete" method="post" class="d-inline">
                                                            <input type="hidden" name="id" value="${supplier.id}" />
                                                            <button type="submit" class="btn btn-danger">Delete</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
