<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="View Sale" />

<div class="main-content">
    <div class="container-fluid px-4">
        <h2>${pageTitle}</h2>
        <div id="saleDetails">
            <p>Loading sale details...</p>
        </div>
        <a href="${pageContext.request.contextPath}/sales" class="btn btn-secondary">Back to Sales List</a>
    </div>
</div>

<script>
    function getQueryParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }

    function formatCurrency(value) {
        return '$' + parseFloat(value).toFixed(2);
    }

    async function fetchSaleDetails(saleId) {
        try {
            const response = await fetch(`${window.location.origin}/api/sales/${saleId}`);
            if (!response.ok) {
                throw new Error('Sale not found or error fetching sale');
            }
            const sale = await response.json();
            renderSaleDetails(sale);
        } catch (error) {
            document.getElementById('saleDetails').innerHTML = `<p class="text-danger">${error.message}</p>`;
        }
    }

    function renderSaleDetails(sale) {
        let html = `
            <div class="mb-3">
                <label class="form-label">Invoice Number:</label>
                <span>${sale.invoiceNumber}</span>
            </div>
            <div class="mb-3">
                <label class="form-label">Customer Name:</label>
                <span>${sale.customerName}</span>
            </div>
            <div class="mb-3">
                <label class="form-label">Customer Phone:</label>
                <span>${sale.customerPhone}</span>
            </div>
            <div class="mb-3">
                <label class="form-label">Sale Date:</label>
                <span>${new Date(sale.saleDate).toLocaleString()}</span>
            </div>
            <div class="mb-3">
                <label class="form-label">Sale Items:</label>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Medication ID</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Total Price</th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        sale.items.forEach(item => {
            html += `
                <tr>
                    <td>${item.medicationId}</td>
                    <td>${item.quantity}</td>
                    <td>${formatCurrency(item.unitPrice)}</td>
                    <td>${formatCurrency(item.totalPrice)}</td>
                </tr>
            `;
        });

        html += `
                    </tbody>
                </table>
            </div>
            <div class="mb-3">
                <label class="form-label">Total Amount:</label>
                <span>${formatCurrency(sale.totalAmount)}</span>
            </div>
        `;

        document.getElementById('saleDetails').innerHTML = html;
    }

    document.addEventListener('DOMContentLoaded', () => {
        const saleId = getQueryParam('id');
        if (saleId) {
            fetchSaleDetails(saleId);
        } else {
            document.getElementById('saleDetails').innerHTML = '<p class="text-danger">Sale ID is missing in the URL.</p>';
        }
    });
</script>

<%@ include file="../layout/footer.jsp" %>
