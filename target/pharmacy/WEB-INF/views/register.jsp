<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>PharmaTrack - Inscription</title>
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
            width: 50%;
            height: 100vh;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        
        .pharmacy-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .register-section {
            width: 50%;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            overflow-y: auto;
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
        
        .register-form-container {
            width: 100%;
            max-width: 400px;
        }
        
        .register-title {
            color: #1A3A5F;
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
            border: 1px solid #ced4da;
        }
        
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        
        .btn-register {
            background-color: #758dd0;
            border: none;
            border-radius: 8px;
            padding: 0.75rem;
            font-weight: 600;
            width: 100%;
            color: white;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }
        
        .btn-register:hover {
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
        
        .back-to-login {
            text-align: center;
            margin-top: 1.5rem;
        }
        
        .back-to-login a {
            color: #1A3A5F;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-to-login a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Left side - Pharmacy Image -->
        <div class="pharmacy-image">
                <img src="${pageContext.request.contextPath}/resources/img/AA.jpg" alt="Pharmacy Image" style="width: 100%; height: 100%; object-fit: cover;" />
            </div>
        
        <!-- Right side - Registration Form -->
        <div class="register-section">
            <div class="register-form-container">
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
                
               
                
                <form method="post" action="${pageContext.request.contextPath}/register">
                    <div class="mb-3">
                        <label for="username" class="form-label">Nom d'utilisateur</label>
                        <input type="text" id="username" name="username" class="form-control" required />
                    </div>
                    
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Nom complet</label>
                        <input type="text" id="fullName" name="fullName" class="form-control" required />
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" class="form-control" required />
                    </div>
                    
                    <div class="mb-3">
                        <label for="role" class="form-label">Rôle</label>
                        <select id="role" name="role" class="form-select" required>
                            <option value="USER" selected>Utilisateur</option>
                            <option value="ADMIN">Administrateur</option>
                            <option value="PHARMACIST">Pharmacien</option>
                            <option value="ASSISTANT">Assistant</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">Mot de passe</label>
                        <input type="password" id="password" name="password" class="form-control" required />
                    </div>
                    
                   
                    
                    <button type="submit" class="btn-register">S'inscrire</button>
                </form>
                
                <div class="back-to-login">
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>