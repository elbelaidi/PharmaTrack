<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="Sale Details"/>

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
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
        margin-bottom: 20px;
    }

    .card-header {
        background-color: #4ECDC4;
        color: #fff;
        padding: 1rem 1.25rem;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
    }

    .card-title {
        margin: 0;
        font-weight: 500;
    }

    th {
        width: 180px;
        font-weight: 500;
        color: #333;
    }

    .btn-secondary {
        border-radius: 6px;
    }
</style>

<div class="main-content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title"><i class="bi bi-receipt me-2"></i>${pageTitle}</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <h6 class="fw-semibold text-primary">Invoice Information</h6>
                        <table class="table table-sm">
                            <tr>
                                <th>Invoice Number:</th>
                                <td>${sale.invoiceNumber}</td>
                            </tr>
                            <tr>
                                <th>Date:</th>
                                <td><fmt:formatDate value="${sale.saleDate}" pattern="MM/dd/yyyy HH:mm"/></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-6 mb-3">
                        <h6 class="fw-semibold text-primary">Customer Information</h6>
                        <table class="table table-sm">
                            <tr>
                                <th>Name:</th>
                                <td>${sale.customerName}</td>
                            </tr>
                            <tr>
                                <th>Phone:</th>
                                <td>${sale.customerPhone}</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h5 class="card-title"><i class="bi bi-bag-check me-2"></i>Sale Items</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Medication</th>
                                <th>Quantity</th>
                                <th>Unit Price</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sale.items}" var="item">
                                <tr>
                                    <td>${item.medication.name}</td>
                                    <td>${item.quantity}</td>
                                    <td>$<fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol=""/></td>
                                    <td>$<fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol=""/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="3" class="text-end">Total Amount:</th>
                                <th>$<fmt:formatNumber value="${sale.totalAmount}" type="currency" currencySymbol=""/></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-end mt-4">
            <a href="${pageContext.request.contextPath}/sales" class="btn btn-secondary">
                <i class="bi bi-arrow-left me-1"></i> Back to List
            </a>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
