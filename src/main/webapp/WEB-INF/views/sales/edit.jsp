<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="Edit Sale" />

<div class="main-content">
    <div class="container-fluid px-4">
        <h2>${pageTitle}</h2>
        <form method="post" action="${pageContext.request.contextPath}/sales/edit">
            <input type="hidden" name="id" value="${sale.id}" />
            <div class="mb-3">
                <label for="invoiceNumber" class="form-label">Invoice Number</label>
                <input type="text" class="form-control" id="invoiceNumber" name="invoiceNumber" required value="${sale.invoiceNumber}" />
            </div>
            <div class="mb-3">
                <label for="customerName" class="form-label">Customer Name</label>
                <input type="text" class="form-control" id="customerName" name="customerName" required value="${sale.customerName}" />
            </div>
            <div class="mb-3">
                <label for="customerPhone" class="form-label">Customer Phone</label>
                <input type="text" class="form-control" id="customerPhone" name="customerPhone" value="${sale.customerPhone}" />
            </div>
            <div class="mb-3">
                <label class="form-label">Sale Items</label>
                <table class="table table-bordered" id="saleItemsTable">
                    <thead>
                        <tr>
                            <th>Medication</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Total Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sale.items}">
                            <tr>
                                <td>
                                    <select name="medicationId[]" class="form-select medicationSelect" required>
                                        <c:forEach var="med" items="${medications}">
                                            <option value="${med.id}" data-price="${med.price}" <c:if test="${med.id == item.medicationId}">selected</c:if>>
                                                ${med.name} (${med.price}$)
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td><input type="number" name="quantity[]" class="form-control quantity" min="1" value="${item.quantity}" required /></td>
                                <td><input type="number" name="unitPrice[]" class="form-control unitPrice" min="0" step="0.01" value="${item.unitPrice}" readonly /></td>
                                <td><input type="number" name="totalPrice" class="form-control totalPrice" readonly value="${item.totalPrice}" /></td>
                                <td><button type="button" class="btn btn-danger btn-sm removeRow">Remove</button></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty sale.items}">
                            <tr>
                                <td>
                                    <select name="medicationId[]" class="form-select medicationSelect" required>
                                        <c:forEach var="med" items="${medications}">
                                            <option value="${med.id}" data-price="${med.price}">${med.name} (${med.price}$)</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td><input type="number" name="quantity[]" class="form-control quantity" min="1" value="1" required /></td>
                                <td><input type="number" name="unitPrice[]" class="form-control unitPrice" min="0" step="0.01" value="0.00" readonly /></td>
                                <td><input type="number" name="totalPrice" class="form-control totalPrice" readonly value="0.00" /></td>
                                <td><button type="button" class="btn btn-danger btn-sm removeRow">Remove</button></td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
                <button type="button" class="btn btn-secondary btn-sm" id="addItemBtn">Add Item</button>
            </div>
            <div class="mb-3">
                <label for="totalAmount" class="form-label">Total Amount</label>
                <input type="number" class="form-control" id="totalAmount" name="totalAmount" readonly value="${sale.totalAmount}" />
            </div>
            <button type="submit" class="btn btn-primary">Update Sale</button>
            <a href="${pageContext.request.contextPath}/sales" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<script>
    // Map medicationId to price for quick lookup
    const medicationPrices = {};
    document.querySelectorAll('.medicationSelect option').forEach(option => {
        medicationPrices[option.value] = parseFloat(option.getAttribute('data-price')) || 0;
    });

    function updateRowTotal(row) {
        const quantity = parseFloat(row.querySelector('.quantity').value) || 0;
        const unitPriceInput = row.querySelector('.unitPrice');
        const medicationSelect = row.querySelector('.medicationSelect');
        const selectedMedId = medicationSelect.value;
        const unitPrice = medicationPrices[selectedMedId] || 0;
        unitPriceInput.value = unitPrice.toFixed(2);
        const totalPrice = quantity * unitPrice;
        row.querySelector('.totalPrice').value = totalPrice.toFixed(2);
        updateTotalAmount();
    }

    function updateTotalAmount() {
        let total = 0;
        document.querySelectorAll('#saleItemsTable tbody tr').forEach(row => {
            const rowTotal = parseFloat(row.querySelector('.totalPrice').value) || 0;
            total += rowTotal;
        });
        document.getElementById('totalAmount').value = total.toFixed(2);
    }

    document.getElementById('addItemBtn').addEventListener('click', () => {
        const tableBody = document.querySelector('#saleItemsTable tbody');
        const newRow = tableBody.rows[0].cloneNode(true);
        newRow.querySelectorAll('input').forEach(input => {
            if (input.type === 'number') {
                input.value = input.classList.contains('quantity') ? '1' : '0.00';
            }
        });
        // Reset medication select to first option
        const medSelect = newRow.querySelector('.medicationSelect');
        medSelect.selectedIndex = 0;
        attachRowEvents(newRow);
        updateRowTotal(newRow);
        tableBody.appendChild(newRow);
    });

    function attachRowEvents(row) {
        row.querySelector('.quantity').addEventListener('input', () => updateRowTotal(row));
        row.querySelector('.medicationSelect').addEventListener('change', () => updateRowTotal(row));
        row.querySelector('.removeRow').addEventListener('click', () => {
            if (document.querySelectorAll('#saleItemsTable tbody tr').length > 1) {
                row.remove();
                updateTotalAmount();
            }
        });
    }

    document.querySelectorAll('#saleItemsTable tbody tr').forEach(row => attachRowEvents(row));
    // Initialize unit price and totals on page load
    document.querySelectorAll('#saleItemsTable tbody tr').forEach(row => updateRowTotal(row));
    updateTotalAmount();
</script>

<%@ include file="../layout/footer.jsp" %>
