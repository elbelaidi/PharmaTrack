<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layout/header_temp_v2.jsp" %>

<style>
    .main-content {
        margin-left: 250px;
        margin-top: 70px;
        padding: 30px;
        background-color: #f8f9fa;
        min-height: calc(100vh - 70px);
    }
    
    .dashboard-card {
        border: none;
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
        overflow: hidden;
    }
    
    .dashboard-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
    }
    
    .card-header {
        border-bottom: none;
        padding: 1.25rem 1.5rem;
        font-weight: 600;
        letter-spacing: 0.5px;
    }
    
    .card-primary {
        background: linear-gradient(135deg, #4ECDC4 0%, #4ECDC4 100%);
        color: white;
    }
    
    .card-success {
        background: linear-gradient(135deg, #00d97e 0%, #00d97e 100%);
        color: white;
    }
    
    .card-warning {
        background: linear-gradient(135deg, #f6c343 0%, #f6c343 100%);
        color: white;
    }
    
    .card-info {
        background: linear-gradient(135deg, #39afd1 0%, #39afd1 100%);
        color: white;
    }
    
    .card-title {
        font-weight: 700;
        margin-bottom: 0.5rem;
    }
    
    .card-icon {
        font-size: 2rem;
        margin-bottom: 1rem;
    }
    
    .trend-badge {
        border-radius: 20px;
        padding: 0.35em 0.8em;
        font-weight: 500;
    }
    
    .page-title {
        color: #2c3e50;
        font-weight: 700;
        margin-bottom: 2rem;
        position: relative;
        padding-bottom: 0.5rem;
    }
    
    .page-title:after {
        content: '';
        position: absolute;
        left: 50%;
        bottom: 0;
        transform: translateX(-50%);
        width: 80px;
        height: 4px;
        background: linear-gradient(135deg, #4ECDC4 0%, #4ECDC4 100%);
        border-radius: 2px;
    }
    
    .trend-up {
        color: #00d97e;
    }
    
    .trend-down {
        color: #e63757;
    }
</style>

<div class="main-content">
    <div class="container-fluid">
        <h1 class="page-title text-center">Pharmacy Management System - Summary Report</h1>

        <div class="row">
            <!-- Total Sales Card -->
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="dashboard-card card-primary h-100">
                    <div class="card-header d-flex flex-column align-items-center">
                        <i class="bi bi-currency-dollar card-icon"></i>
                        Total Sales
                    </div>
                    <div class="card-body text-center">
                        <h2 class="card-title">${totalSales}</h2>
                        <div class="d-flex justify-content-center align-items-center mt-3">
                            <span class="trend-badge bg-light trend-up">
                                <i class="bi bi-arrow-up"></i> 12%
                            </span>
                            <span class="ms-2 small text-white">vs last month</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Total Medications Card -->
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="dashboard-card card-success h-100">
                    <div class="card-header d-flex flex-column align-items-center">
                        <i class="bi bi-capsule card-icon"></i>
                        Total Medications
                    </div>
                    <div class="card-body text-center">
                        <h2 class="card-title">${totalMedications}</h2>
                        <div class="d-flex justify-content-center align-items-center mt-3">
                            <span class="trend-badge bg-light trend-up">
                                <i class="bi bi-arrow-up"></i> 5%
                            </span>
                            <span class="ms-2 small text-white">vs last month</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Total Suppliers Card -->
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="dashboard-card card-warning h-100">
                    <div class="card-header d-flex flex-column align-items-center">
                        <i class="bi bi-truck card-icon"></i>
                        Total Suppliers
                    </div>
                    <div class="card-body text-center">
                        <h2 class="card-title">${totalSuppliers}</h2>
                        <div class="d-flex justify-content-center align-items-center mt-3">
                            <span class="trend-badge bg-light trend-down">
                                <i class="bi bi-arrow-down"></i> 3%
                            </span>
                            <span class="ms-2 small text-white">vs last month</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Total Users Card -->
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="dashboard-card card-info h-100">
                    <div class="card-header d-flex flex-column align-items-center">
                        <i class="bi bi-people card-icon"></i>
                        Total Users
                    </div>
                    <div class="card-body text-center">
                        <h2 class="card-title">${totalUsers}</h2>
                        <div class="d-flex justify-content-center align-items-center mt-3">
                            <span class="trend-badge bg-light trend-up">
                                <i class="bi bi-arrow-up"></i> 8%
                            </span>
                            <span class="ms-2 small text-white">vs last month</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Additional content can be added here -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Recent Activity</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">Activity logs and statistics can be displayed here.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/footer.jsp" %>