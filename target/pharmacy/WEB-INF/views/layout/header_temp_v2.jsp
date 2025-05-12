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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body, html {
            height: 100%;
            margin: 0;
        }
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            height: 60px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            z-index: 1030;
            display: flex;
            align-items: center;
            padding: 0 20px;
        }
        .sidebar {
            position: fixed;
            top: 60px; /* height of header */
            left: 0;
            width: 220px;
            height: calc(100% - 60px);
            background-color: #f8f9fa;
            overflow-y: auto;
            border-right: 1px solid #dee2e6;
            padding-top: 1rem;
        }
        .main-content {
            margin-top: 60px; /* height of header */
            margin-left: 220px; /* width of sidebar */
            padding: 20px;
        }
        .nav-link {
            color: #333;
        }
        .nav-link:hover {
            background-color: #e9ecef;
        }
        .alert {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="header">
        <h4 class="mb-0">Pharmacy Management System</h4>
        <div style="margin-left:auto; display:flex; align-items:center; gap:1rem;">
            <div>
                Welcome, <c:out value="${sessionScope.user != null ? sessionScope.user.fullName : 'Guest'}"/>
            </div>
            <div id="currentTime"></div>
        </div>
    </div>
    <div class="sidebar">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                        <i class="bi bi-speedometer2 me-2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link d-flex align-items-center" href="${pageContext.request.contextPath}/medications">
                        <i class="bi bi-capsule me-2"></i> Medications
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/suppliers">
                        <i class="bi bi-truck me-2"></i> Suppliers
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/sales">
                        <i class="bi bi-cart me-2"></i> Sales
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/reports">
                        <i class="bi bi-graph-up me-2"></i> Reports
                    </a>
                </li>
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/users">
                            <i class="bi bi-people me-2"></i> Users
                        </a>
                    </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/register">
                        <i class="bi bi-person-plus me-2"></i> Register
                    </a>
                </li>
            </c:if>
            
            </ul>
            <div class="logout-container mt-auto p-3" style="position: absolute; bottom: 0; width: 100%; border-top: 1px solid #ddd;">
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                </a>
            </div>
    </div>
    <script>
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString();
            document.getElementById('currentTime').textContent = timeString;
        }
        setInterval(updateTime, 1000);
        updateTime();
    </script>
</body>
</html>
