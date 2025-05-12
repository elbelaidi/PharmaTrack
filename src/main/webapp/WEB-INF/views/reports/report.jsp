<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<div class="main-content" style="margin-left: 250px; margin-top: 70px;">
    <h1 class="display-4 text-center mb-5">Pharmacy Management System - Summary Report</h1>

    <div class="row">
        <div class="col-md-3">
            <div class="card text-white bg-primary mb-4 shadow-sm">
                <div class="card-header fw-bold text-center">
                    <i class="fas fa-dollar-sign fa-2x"></i> Total Sales
                </div>
                <div class="card-body">
                    <h5 class="card-title text-center fs-3">${totalSales}</h5>
                    <div class="d-flex justify-content-center align-items-center mt-2">
                        <span class="badge bg-light text-primary fs-6">
                            <i class="fas fa-arrow-up"></i> 12%
                        </span>
                        <span class="ms-2 small">vs last month</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card text-white bg-success mb-4 shadow-sm">
                <div class="card-header fw-bold text-center">
                    <i class="fas fa-capsules fa-2x"></i> Total Medications
                </div>
                <div class="card-body">
                    <h5 class="card-title text-center fs-3">${totalMedications}</h5>
                    <div class="d-flex justify-content-center align-items-center mt-2">
                        <span class="badge bg-light text-success fs-6">
                            <i class="fas fa-arrow-up"></i> 5%
                        </span>
                        <span class="ms-2 small">vs last month</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card text-white bg-warning mb-4 shadow-sm">
                <div class="card-header fw-bold text-center">
                    <i class="fas fa-truck fa-2x"></i> Total Suppliers
                </div>
                <div class="card-body">
                    <h5 class="card-title text-center fs-3">${totalSuppliers}</h5>
                    <div class="d-flex justify-content-center align-items-center mt-2">
                        <span class="badge bg-light text-warning fs-6">
                            <i class="fas fa-arrow-down"></i> -3%
                        </span>
                        <span class="ms-2 small">vs last month</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card text-white bg-info mb-4 shadow-sm">
                <div class="card-header fw-bold text-center">
                    <i class="fas fa-users fa-2x"></i> Total Users
                </div>
                <div class="card-body">
                    <h5 class="card-title text-center fs-3">${totalUsers}</h5>
                    <div class="d-flex justify-content-center align-items-center mt-2">
                        <span class="badge bg-light text-info fs-6">
                            <i class="fas fa-arrow-up"></i> 8%
                        </span>
                        <span class="ms-2 small">vs last month</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>
