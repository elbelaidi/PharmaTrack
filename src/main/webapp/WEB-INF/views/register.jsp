<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container" style="max-width: 500px; margin-top: 50px;">
    <h2>Create New User</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <form method="post" action="${pageContext.request.contextPath}/register">
        <div class="mb-3">
            <label for="username" class="form-label">Username:</label>
            <input type="text" id="username" name="username" class="form-control" required />
        </div>
        <div class="mb-3">
            <label for="fullName" class="form-label">Full Name:</label>
            <input type="text" id="fullName" name="fullName" class="form-control" required />
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="email" id="email" name="email" class="form-control" required />
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Role:</label>
            <select id="role" name="role" class="form-select" required>
                <option value="USER" selected>User</option>
                <option value="ADMIN">Admin</option>
                <option value="PHARMACIST">Pharmacist</option>
                <option value="ASSISTANT">Assistant</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password:</label>
            <input type="password" id="password" name="password" class="form-control" required />
        </div>
        <div class="mb-3">
            <label for="confirmPassword" class="form-label">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required />
        </div>
        <button type="submit" class="btn btn-primary w-100">Register</button>
    </form>
    <p class="mt-3">
        <a href="${pageContext.request.contextPath}/logout">Back to Login</a>
        <a href="${pageContext.request.contextPath}/dashboard" style="margin-left: 20px;">Go to Dashboard</a>
    </p>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
