<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Pharmacy Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            height: 70px;
            background-color: #ffffff;
            border-bottom: 1px solid #e6e6e6;
            z-index: 1030;
            display: flex;
            align-items: center;
            padding: 0 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .pharmacy-logo {
            display: flex;
            align-items: center;
        }
        
        .brand-name {
            color: #1A3A5F;
            font-size: 1.5rem;
            font-weight: 700;
            margin-left: 10px;
        }
        
        .sidebar {
            position: fixed;
            top: 70px; /* height of header */
            left: 0;
            width: 240px;
            height: calc(100% - 70px);
            background-color: #ffffff;
            border-right: 1px solid #e6e6e6;
            padding-top: 1rem;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
            overflow-y: auto;
        }
        
        .main-content {
            margin-top: 70px; /* height of header */
            margin-left: 240px; /* width of sidebar */
            padding: 25px;
            min-height: calc(100vh - 70px);
            background-color: #f8f9fa;
        }
        
        .nav-item {
            margin-bottom: 5px;
        }
        
        .nav-link {
            color: #495057;
            font-weight: 500;
            padding: 12px 20px;
            border-radius: 0;
            transition: all 0.3s;
            display: flex;
            align-items: center;
        }
        
        .nav-link:hover {
            background-color: #f1f4f8;
            color: #1A3A5F;
        }
        
        .nav-link.active {
            background-color: #f1f4f8;
            color: #1A3A5F;
            border-left: 4px solid #4ECDC4;
        }
        
        .nav-link i {
            margin-right: 12px;
            font-size: 1.2rem;
            color: #758dd0;
        }
        
        .logout-container {
            border-top: 1px solid #e6e6e6;
            padding: 15px 20px;
        }
        
        .logout-btn {
            color: #dc3545;
            text-decoration: none;
            display: flex;
            align-items: center;
            font-weight: 500;
        }
        
        .logout-btn i {
            margin-right: 10px;
        }
        
        .alert {
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }
        
        .card {
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            transition: transform 0.3s;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }
        
        .card-header {
            background-color: #ffffff;
            border-bottom: 1px solid #f0f0f0;
            font-weight: 600;
            padding: 15px 20px;
            border-top-left-radius: 10px !important;
            border-top-right-radius: 10px !important;
        }
        
        .card-body {
            padding: 20px;
        }
        
        .status-indicator {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }
        
        .status-active {
            background-color: #28a745;
        }
        
        .status-inactive {
            background-color: #dc3545;
        }
        
        .status-warning {
            background-color: #ffc107;
        }
        
        .btn-primary {
            background-color: #758dd0;
            border: none;
            border-radius: 8px;
            padding: 8px 15px;
            font-weight: 500;
        }
        
        .btn-primary:hover {
            background-color: #6579b8;
        }
        
        .table {
            border-radius: 10px;
            overflow: hidden;
        }
        
        .table thead th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            font-weight: 600;
            color: #495057;
        }
        
        .badge {
            font-weight: 500;
            padding: 5px 10px;
            border-radius: 6px;
        }
        
        .medication-icon {
            color: #6579b8;
            font-size: 20px;
            margin-right: 8px;
        }
        
        /* SVG Medicine Icon */
        .medicine-icon {
            fill: #4ECDC4;
            width: 20px;
            height: 20px;
            margin-right: 8px;
        }
        
        .user-info {
            margin-left: auto;
            display: flex;
            align-items: center;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            color: #6c757d;
            font-weight: 600;
        }
        
        .user-name {
            font-weight: 600;
            color: #495057;
            font-size: 0.9rem;
        }
        
        .user-role {
            font-size: 0.8rem;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="pharmacy-logo">
            <svg width="35" height="35" viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
                <rect x="30" y="30" width="60" height="60" rx="10" stroke="#4ECDC4" stroke-width="6"/>
                <path d="M45 60H75" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                <path d="M60 45L60 75" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                <path d="M30 30L15 15" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                <path d="M90 30L105 15" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                <path d="M30 90L15 105" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                <path d="M90 90L105 105" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
            </svg>
            <span class="brand-name">PharmaTrack</span>
        </div>
         <div class="user-info">
            <div class="user-avatar">
                <i class="bi bi-person"></i>
            </div>
            <div>
                <div class="user-name">${sessionScope.user.fullName}</div>
                <div class="user-role">${sessionScope.user.role}</div>
            </div>
        </div>
    </div>
    </div>
    <div class="sidebar">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                        
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/medications">
                         <svg class="medicine-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                        <path d="M19.73,14.87,12.21,7.35a4,4,0,1,0-5.66,5.66l7.53,7.52a4,4,0,1,0,5.65-5.66ZM7.43,11.71a2,2,0,0,1,0-2.83,2,2,0,0,1,2.83,0l1.56,1.56L9.1,13.16Z"/>
                    </svg>
                        <i class="bi bi-capsule"></i> Medications
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/suppliers">
                        <i class="bi bi-truck"></i> Suppliers
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/sales">
                        <i class="bi bi-cart"></i> Sales
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/reports">
                        <i class="bi bi-graph-up"></i> Reports
                    </a>
                </li>
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/users">
                            <i class="bi bi-people"></i> Users
                        </a>
                    </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/register">
                        <i class="bi bi-person-plus"></i> Register
                    </a>
                </li>
            </c:if>
            
            </ul>
            <div class="logout-container mt-auto p-3" style="position: absolute; bottom: 0; width: 100%; border-top: 1px solid #ddd;">
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </div>
    </div>
</body>
</html>
