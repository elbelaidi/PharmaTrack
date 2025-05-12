<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Simple Login - Pharmacy Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: white;
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            width: 360px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #0d6efd;
        }
        .login-header h3 {
            margin: 0;
            font-weight: 700;
        }
        .form-label {
            font-weight: 600;
        }
        .form-control {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
        }
        .btn-login {
            background-color: #0d6efd;
            border: none;
            border-radius: 50px;
            padding: 0.75rem;
            font-weight: 700;
            width: 100%;
            color: white;
            font-size: 1.1rem;
            transition: background-color 0.3s ease;
        }
        .btn-login:hover {
            background-color: #084298;
        }
        .error-message {
            background-color: #f8d7da;
            color: #842029;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
            font-weight: 600;
            text-align: center;
        }
        .register-link {
            text-align: center;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        .register-link a {
            color: #0d6efd;
            text-decoration: none;
            font-weight: 600;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h3>Simple Login</h3>
        </div>
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success" style="border-radius: 8px; padding: 0.75rem 1rem; margin-bottom: 1rem; font-weight: 600; text-align: center;">
                ${success}
            </div>
        </c:if>
        <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control" required autofocus />
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" required />
            </div>
            <button type="submit" class="btn-login">Login</button>
        </form>
        
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
