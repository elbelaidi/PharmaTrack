<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="Sales" />
<c:set var="pageActions">
    <c:url value="/sales/new" var="newSaleUrl" />
    <c:set var="action" value="${newSaleUrl}" />
    <c:set var="icon" value="bi-plus-circle" />
    <c:set var="label" value="Add New Sale" />
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
                <a href="${newSaleUrl}" class="btn btn-light text-primary fw-semibold ms-auto">
                    <i class="${icon} me-1"></i> ${label}
                </a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Invoice Number</th>
                                    <th>Customer Name</th>
                                    <th>Customer Phone</th>
                                    <th>Total Amount</th>
                                    <th>Sale Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="sale" items="${sales}">
                                    <tr>
                                        <td><c:out value="${sale.invoiceNumber}" /></td>
                                        <td><c:out value="${sale.customerName}" /></td>
                                        <td><c:out value="${sale.customerPhone}" /></td>
                                        <td><c:out value="${sale.totalAmount}" /></td>
                                        <td><fmt:formatDate value="${sale.saleDate}" pattern="MM/dd/yyyy HH:mm" /></td>
<td>
    <a href="${pageContext.request.contextPath}/sales/view?id=${sale.id}" class="btn btn-primary btn-sm" title="View">
        <i class="bi bi-eye"></i>
    </a>
    <a href="${pageContext.request.contextPath}/sales/edit?id=${sale.id}" class="btn btn-warning btn-sm ms-1" title="Update">
        <i class="bi bi-pencil"></i>
    </a>
    <button type="button" class="btn btn-danger btn-sm ms-1" onclick="deleteSale('${sale.id}')" title="Delete">
        <i class="bi bi-trash"></i>
    </button>
</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty sales}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">No sales found.</td>
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
    function deleteSale(saleId) {
        if (confirm('Are you sure you want to delete this sale?')) {
            fetch(`http://localhost:8081/api/sales/${saleId}`, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    alert('Sale deleted successfully.');
                    window.location.reload();
                } else {
                    alert('Failed to delete sale.');
                }
            })
            .catch(error => {
                alert('Error deleting sale: ' + error);
            });
        }
    }
</script>

<%@ include file="../layout/footer.jsp" %>
