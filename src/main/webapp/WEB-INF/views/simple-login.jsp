<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>PharmaTrack - Système de Gestion de Pharmacie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            height: 100vh;
        }
        
        .main-container {
            display: flex;
            height: 100vh;
            width: 100%;
        }
        
        .pharmacy-image {
            flex: 1;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        
        .login-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }
        
        .logo-container {
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
        }
        
        .logo-icon {
            color: #4ECDC4;
            margin-right: 10px;
            font-size: 2rem;
        }
        
        .brand-name {
            color: #1A3A5F;
            font-size: 2.5rem;
            font-weight: 700;
        }
        
        .login-form-container {
            width: 100%;
            max-width: 400px;
        }
        
        .login-title {
            color: #1A3A5F;
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .form-control {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
            border: 1px solid #ced4da;
        }
        
        .remember-me {
            margin-bottom: 1.5rem;
        }
        
        .btn-login {
            background-color: #4ECDC4;
            border: none;
            border-radius: 8px;
            padding: 0.75rem;
            font-weight: 600;
            width: 100%;
            color: white;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }
        
        .btn-login:hover {
            background-color: #6579b8;
        }
        
        .pharmacy-logo {
            display: flex;
            align-items: center;
        }
        
        .logo-pill {
            color: #4ECDC4;
            font-size: 2rem;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Left side - Pharmacy Image -->
            <div class="pharmacy-image">
                <img src="${pageContext.request.contextPath}/resources/img/AA.jpg" alt="Pharmacy Image" style="width: 100%; height: 100%; object-fit: cover;" />
            </div>
        
        <!-- Right side - Login Form -->
        <div class="login-section">
            <div class="login-form-container">
                <!-- Logo and Brand -->
                <div class="pharmacy-logo mb-4">
                    <svg width="50" height="50" viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="30" y="30" width="60" height="60" rx="10" stroke="#4ECDC4" stroke-width="6"/>
                        <path d="M45 60H75" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                        <path d="M60 45L60 75" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                        <path d="M30 30L15 15" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                        <path d="M90 30L105 15" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                        <path d="M30 90L15 105" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                        <path d="M90 90L105 105" stroke="#4ECDC4" stroke-width="6" stroke-linecap="round"/>
                    </svg>
                    <span class="brand-name ms-3">PharmaTrack</span>
                </div>
                
                <h2 class="login-title">Se connecter</h2>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
                    <div class="mb-3">
                        <input type="text" id="username" name="username" class="form-control" placeholder="username" required autofocus />
                    </div>
                    
                    <div class="mb-3">
                        <input type="password" id="password" name="password" class="form-control" placeholder="Mot de passe" required />
                    </div>
                    
                    <div class="form-check remember-me">
                        <input type="checkbox" id="remember" name="remember" class="form-check-input" />
                        <label for="remember" class="form-check-label">Se rappeler du mot de passe</label>
                    </div>
                    <!-- Hidden field to maintain compatibility with original authentication -->
                    <input type="hidden" name="action" value="login" />
                    
                    <button type="submit" class="btn-login">Se connecter</button>
                </form>
                
               
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>