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
                                    <td>${medication.code}</td>
                                    <td>${medication.name}</td>
                                    <td>${medication.type}</td>
                                    <td>
                                        <span class="badge ${medication.stock <= medication.alertThreshold ? 'bg-warning text-dark' : 'bg-success'}">
                                            ${medication.stock}
                                        </span>
                                    </td>
                                    <td>
                                        $<fmt:formatNumber value="${medication.price}" type="currency" currencySymbol="" />
                                    </td>
                                    <td>
                                        <span class="badge ${medication.expirationDate.before(today) ? 'bg-danger' : 'bg-info'}">
                                            <fmt:formatDate value="${medication.expirationDate}" pattern="MM/dd/yyyy"/>
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/medications/edit?id=${medication.id}"
                                               class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal"
                                                    data-bs-target="#deleteModal${medication.id}" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>

                                        <!-- Delete Modal -->
                                        <div class="modal fade" id="deleteModal${medication.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header bg-danger text-white">
                                                        <h5 class="modal-title">Confirm Delete</h5>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to delete <strong>${medication.name}</strong>?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <form action="${pageContext.request.contextPath}/medications/delete" method="post" class="d-inline">
                                                            <input type="hidden" name="id" value="${medication.id}" />
                                                            <button type="submit" class="btn btn-danger">Delete</button>
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
                                    <td colspan="7" class="text-center text-muted">No medications found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
