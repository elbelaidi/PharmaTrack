<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="Users" />
<c:set var="pageActions">
    <c:url value="/users/new" var="newUserUrl" />
    <c:set var="action" value="${newUserUrl}" />
    <c:set var="icon" value="bi-plus-circle" />
    <c:set var="label" value="New User" />
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
                <!-- Removed New User button -->
                <!--
                <a href="${newUserUrl}" class="btn btn-light text-primary fw-semibold">
                    <i class="${icon} me-1"></i> ${label}
                </a>
                -->
                <form class="d-flex" method="get" action="${pageContext.request.contextPath}/users" id="searchForm">
                    <input class="form-control form-control-sm me-2" type="search" name="q" placeholder="Search users" aria-label="Search" value="${param.q}" autocomplete="off" />
                </form>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Created At</th>
                                <th style="width: 160px;" class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${users}" var="user">
                                <tr>
                                    <td>${user.username}</td>
                                    <td>${user.email}</td>
                                    <td>${user.role}</td>
                                    <td><fmt:formatDate value="${user.createdAt}" pattern="MM/dd/yyyy HH:mm" /></td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
<a href="${pageContext.request.contextPath}/users/edit?id=${user.id}"
   class="btn btn-sm btn-outline-primary" title="Edit">
    <i class="bi bi-eye"></i>
</a>
                                            <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal"
                                                    data-bs-target="#deleteModal${user.id}" title="Delete">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>

                                        <!-- Delete Modal -->
                                        <div class="modal fade" id="deleteModal${user.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header bg-danger text-white">
                                                        <h5 class="modal-title">Confirm Delete</h5>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to delete user <strong>${user.username}</strong>?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <form action="${pageContext.request.contextPath}/users/delete" method="post" class="d-inline">
                                                            <input type="hidden" name="id" value="${user.id}" />
                                                            <button type="submit" class="btn btn-danger">Delete</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty users}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted">No users found.</td>
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
    document.getElementById('searchForm').querySelector('input[name="q"]').addEventListener('keydown', function(event) {
        if (event.key === 'Enter' || event.keyCode === 13) {
            this.form.submit();
        }
    });
</script>

<%@ include file="../layout/footer.jsp" %>
