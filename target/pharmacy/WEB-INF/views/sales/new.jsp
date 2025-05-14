<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<c:set var="pageTitle" value="Nouvelle Vente"/>
<c:set var="formAction" value="/sales/new"/>

<style scoped>
    .main-content {
        margin-left: 250px;
        margin-top: 70px;
        padding: 20px;
    }
    
    .card {
        border: none;
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        border-radius: 0.75rem;
    }
    
    .card-header {
        background-color: #4ECDC4;
        border-radius: 0.75rem 0.75rem 0 0 !important;
        padding: 1rem 1.5rem;
    }
    
    .card-body {
        padding: 1.5rem;
    }
    
    .form-control, .form-select {
        border-radius: 0.5rem;
        padding: 0.6rem 1rem;
        border: 1px solid #e2e8f0;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    }
    
    .form-control:focus, .form-select:focus {
        border-color: #4ECDC4;
        box-shadow: 0 0 0 0.25rem rgba(78, 205, 196, 0.25);
    }
    
    .input-group-text {
        border-radius: 0.5rem;
    }
    
    label {
        font-weight: 500;
        color: #1A3A5F;
        margin-bottom: 0.5rem;
    }
    
    .table {
        border-radius: 0.5rem;
        overflow: hidden;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .table thead th {
        background-color: #319790;
        color: white;
        font-weight: 500;
        border: none;
        padding: 0.75rem 1rem;
    }
    
    .btn-primary {
        background-color: #4ECDC4;
        border-color: #4ECDC4;
        color: white;
        font-weight: 600;
        border-radius: 0.5rem;
        padding: 0.5rem 1.5rem;
        transition: all 0.2s ease;
    }
    
    .btn-primary:hover, .btn-primary:focus {
        background-color: #3dbbb3;
        border-color: #3dbbb3;
        box-shadow: 0 0.5rem 1rem rgba(78, 205, 196, 0.15);
    }
    
    .btn-outline-secondary {
        color: #319790;
        font-weight: 600;
        border-radius: 0.5rem;
        transition: all 0.2s ease;
    }
    
    .btn-danger {
        background-color: #FF6B6B;
        border: none;
        border-radius: 0.5rem;
    }
    
    .btn-danger:hover {
        background-color: #ff5252;
    }
    
    .back-button {
        background-color: white;
        color: #4ECDC4;
        border: none;
        font-weight: 600;
        border-radius: 0.5rem;
        transition: all 0.2s ease;
    }
    
    .back-button:hover {
        background-color: #f8f9fa;
        color: #3dbbb3;
    }
    
    .page-title {
        color: white;
        font-weight: 600;
        margin: 0;
        font-size: 1.25rem;
    }
    
    .total-amount-container {
        background-color: #f8f9fa;
        border-radius: 0.5rem;
        padding: 1rem;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .total-label {
        background-color: #319790;
        color: white;
        font-weight: 600;
        border-radius: 0.5rem 0 0 0.5rem;
    }
    
    .total-currency {
        background-color: #319790;
        color: white;
        border-radius: 0 0.5rem 0.5rem 0;
    }
    
    .section-header {
        display: flex;
        align-items: center;
        margin-bottom: 1rem;
        color: #319790;
        font-weight: 600;
    }
    
    .section-header i {
        margin-right: 0.5rem;
        color: #4ECDC4;
    }
    
    .pharmacy-logo {
        display: flex;
        align-items: center;
        margin-bottom: 1.5rem;
    }
    
    .brand-icon {
        width: 32px;
        height: 32px;
        color: #4ECDC4;
        margin-right: 0.5rem;
    }
</style>

<div class="main-content">
    <div class="container-fluid px-4">
        <div class="pharmacy-logo">
            <svg class="brand-icon" viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
                <rect x="30" y="30" width="60" height="60" rx="10" stroke="currentColor" stroke-width="6"/>
                <path d="M45 60H75" stroke="currentColor" stroke-width="6" stroke-linecap="round"/>
                <path d="M60 45L60 75" stroke="currentColor" stroke-width="6" stroke-linecap="round"/>
            </svg>
            <span style="font-size: 1.5rem; font-weight: 700; color: #1A3A5F;">PharmaTrack</span>
        </div>
        
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="page-title">
                    <i class="bi bi-receipt me-2"></i>${pageTitle}
                </h5>
                <a href="${pageContext.request.contextPath}/sales" class="btn back-button">
                    <i class="bi bi-arrow-left me-1"></i> Retour à la liste
                </a>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}${formAction}" method="post" novalidate>
                    <div class="row g-3 mb-4">
                        <!-- Invoice Number -->
                        <div class="col-md-4">
                            <label for="invoiceNumber" class="form-label">Numéro de Facture <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-hash"></i></span>
                                <input type="text" id="invoiceNumber" name="invoiceNumber" class="form-control" required placeholder="Entrez le numéro de facture" />
                            </div>
                        </div>
                        
                        <!-- Customer Name -->
                        <div class="col-md-4">
                            <label for="customerName" class="form-label">Nom du Client <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" id="customerName" name="customerName" class="form-control" required placeholder="Entrez le nom du client" />
                            </div>
                        </div>
                        
                        <!-- Customer Phone -->
                        <div class="col-md-4">
                            <label for="customerPhone" class="form-label">Téléphone du Client</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                <input type="text" id="customerPhone" name="customerPhone" class="form-control" placeholder="Entrez le téléphone du client" />
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sale Items -->
                    <div class="mb-4">
                        <div class="section-header">
                            <i class="bi bi-cart3"></i> Articles de Vente
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered" id="saleItemsTable">
                                <thead>
                                    <tr>
                                        <th style="width: 40%">Médicament</th>
                                        <th style="width: 15%">Quantité</th>
                                        <th style="width: 15%">Prix Unitaire</th>
                                        <th style="width: 20%">Prix Total</th>
                                        <th style="width: 10%">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <select name="medicationId[]" class="form-select medicationSelect" required>
                                                <option value="">Sélectionner un médicament</option>
                                                <c:forEach var="med" items="${medications}">
                                                    <option value="${med.id}" data-price="${med.price}">${med.name} (${med.price}$)</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td><input type="number" name="quantity[]" class="form-control quantity" min="1" value="1" required /></td>
                                        <td><input type="number" name="unitPrice[]" class="form-control unitPrice" min="0" step="0.01" value="0.00" readonly /></td>
                                        <td><input type="number" name="totalPrice" class="form-control totalPrice" readonly value="0.00" /></td>
                                        <td class="text-center"><button type="button" class="btn btn-danger btn-sm removeRow"><i class="bi bi-trash"></i></button></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <button type="button" class="btn btn-outline-secondary btn-sm mt-2" id="addItemBtn">
                            <i class="bi bi-plus-circle"></i> Ajouter un Article
                        </button>
                    </div>
                    
                    <!-- Total Amount -->
                    <div class="row mb-4">
                        <div class="col-md-7"></div>
                        <div class="col-md-5">
                            <div class="total-amount-container">
                                <div class="input-group">
                                    <span class="input-group-text total-label">Montant Total</span>
                                    <input type="number" class="form-control" id="totalAmount" name="totalAmount" readonly value="0.00" style="font-weight: bold; font-size: 1.1rem; text-align: right;" />
                                    <span class="input-group-text total-currency">$</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-between pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/sales" class="btn btn-outline-secondary">
                            <i class="bi bi-x-circle me-1"></i> Annuler
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save me-1"></i> Enregistrer la Vente
                        </button>
                    </div>
                </form>
            </div>
        </div>
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