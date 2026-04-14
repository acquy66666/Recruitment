<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập Nhà tuyển dụng | JobHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-dark: #001a57;
            --primary-color: #0046b8;
            --primary-light: #0066ff;
            --secondary-color: #2c3e50;
            --accent-color: #ff7f50; /* Changed to match JobHub's secondary color */
            --accent-hover: #ff6a3c; /* Darker secondary color for hover */
            --light-gray: #f8f9fa;
            --medium-gray: #e9ecef;
            --dark-gray: #6c757d;
            --border-color: #dee2e6;
            --error-color: #dc3545;
            --success-color: #28a745;
            --link-color: #0066ff;
            --box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            --transition-speed: 0.3s;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }

        body {
            background-color: var(--light-gray);
            color: var(--secondary-color);
            line-height: 1.6;
        }

        .page-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header Styles */
        header {
            background: linear-gradient(90deg, var(--primary-dark) 0%, var(--primary-light) 100%);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo svg {
            height: 40px;
            width: auto;
            transition: transform var(--transition-speed);
        }

        .logo:hover svg {
            transform: scale(1.05);
        }

        /* Main Content Styles */
        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            background: var(--light-gray);
        }

        .auth-container {
            width: 100%;
            max-width: 450px;
            background-color: white;
            border-radius: 8px;
            box-shadow: var(--box-shadow);
            overflow: hidden;
            transform: translateY(0);
            transition: transform 0.4s ease-out;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .auth-container:hover {
            transform: translateY(-5px);
        }

        .auth-header {
            padding: 30px;
            text-align: center;
            position: relative;
        }

        .auth-header h1 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--secondary-color);
        }

        .auth-header p {
            font-size: 15px;
            color: var(--dark-gray);
        }

        .auth-body {
            padding: 0 35px 35px;
        }

        .social-login {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }

        .social-btn {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px;
            border-radius: 4px;
            background-color: white;
            border: 1px solid var(--border-color);
            cursor: pointer;
            transition: all var(--transition-speed);
            font-size: 14px;
            font-weight: 500;
            color: var(--secondary-color);
            text-decoration: none;
        }

        .social-btn i {
            margin-right: 10px;
        }

        .social-btn:hover {
            background-color: var(--light-gray);
            transform: translateY(-2px);
        }

        .social-btn.facebook {
            color: #3b5998;
        }

        .social-btn.google {
            color: #db4437;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
            color: var(--dark-gray);
            font-size: 14px;
        }

        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid var(--border-color);
        }

        .divider span {
            padding: 0 15px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--secondary-color);
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 15px;
            transition: all var(--transition-speed);
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(0, 70, 184, 0.1);
            outline: none;
        }

        .form-control::placeholder {
            color: #adb5bd;
        }

        .password-field {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--dark-gray);
            font-size: 16px;
            z-index: 10;
        }

        .password-field .form-control {
            padding-right: 40px;
        }

        .forgot-password {
            text-align: right;
            margin-bottom: 20px;
        }

        .forgot-password a {
            color: var(--link-color);
            text-decoration: none;
            font-size: 14px;
            transition: color var(--transition-speed);
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: -25px;
        }

        .remember-me input[type="checkbox"] {
            margin-right: 10px;
            cursor: pointer;
        }

        .remember-me label {
            font-size: 14px;
            color: var(--dark-gray);
            cursor: pointer;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            text-align: center;
            transition: all var(--transition-speed);
        }

        .btn-primary {
            background-color: var(--accent-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--accent-hover);
            transform: translateY(-2px);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .auth-footer {
            text-align: center;
            padding: 20px;
            border-top: 1px solid var(--border-color);
            margin-top: 20px;
        }

        .auth-footer p {
            font-size: 14px;
            color: var(--dark-gray);
        }

        .auth-footer a {
            color: var(--link-color);
            text-decoration: none;
            font-weight: 500;
        }

        .auth-footer a:hover {
            text-decoration: underline;
        }

        /* Footer Styles */
        footer {
            background-color: white;
            border-top: 1px solid var(--border-color);
            padding: 20px 0;
            font-size: 14px;
            color: var(--dark-gray);
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer-links {
            display: flex;
            gap: 20px;
        }

        .footer-links a {
            color: var(--dark-gray);
            text-decoration: none;
            transition: color var(--transition-speed);
        }

        .footer-links a:hover {
            color: var(--primary-color);
        }

        /* Error message styling */
        .error-message {
            background-color: rgba(220, 53, 69, 0.1);
            color: var(--error-color);
            padding: 12px 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .error-message i {
            margin-right: 10px;
            font-size: 16px;
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .auth-container {
                max-width: 100%;
            }

            .footer-container {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="page-container">
        <!-- Header -->
        <header>
            <div class="header-container">
                <div class="logo">
                    <a href="HomePage.jsp">
                        <!-- JobHub Logo (White version for dark background) -->
                        <svg viewBox="0 0 300 100" xmlns="http://www.w3.org/2000/svg" width="150">
                        <defs>
                        <linearGradient id="logo-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
                        <stop offset="0%" stop-color="#FFFFFF" />
                        <stop offset="100%" stop-color="#FFFFFF" />
                        </linearGradient>
                        </defs>
                        <circle cx="60" cy="50" r="40" fill="url(#logo-gradient)" />
                        <path d="M40,35 L40,65 M60,25 L60,75 M80,35 L80,65" stroke="#001a57" stroke-width="6" stroke-linecap="round" />
                        <path d="M35,50 L45,50 M55,50 L65,50 M75,50 L85,50" stroke="#001a57" stroke-width="3" stroke-linecap="round" />
                        <text x="110" y="65" font-family="Arial, sans-serif" font-size="45" font-weight="bold" fill="url(#logo-gradient)">
                        JobHub
                        </text>
                        </svg>
                    </a>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main>
            <div class="auth-container">
                <div class="auth-header">
                    <h1>Đăng nhập Nhà tuyển dụng</h1>
                    <p>Chào mừng nhà tuyển dụng quay trở lại với JobHub</p>
                </div>

                <div class="auth-body">
                    <!-- Display error message using JSTL if present in request scope -->
                    <c:if test="${not empty error}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>

     

                    <!-- Login Form -->
                    <form id="recruiterLoginForm" method="post" action="login">
                        <input type="hidden" name="accountType" value="recruiter"> <%-- Added hidden field --%>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="text" value="${loginId != null ? loginId : ''}" maxlength="50" id="email" name="login" class="form-control" placeholder="Nhập email của nhà tuyển dụng" required>
                        </div>

                        <div class="form-group">
                            <label for="password">Mật khẩu</label>
                            <div class="password-field">
                                <input type="password" maxlength="50" value="${password != null ? password : ''}" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                                <span class="password-toggle" id="passwordToggle">
                                    <i class="fas fa-eye"></i>
                                </span>
                            </div>
                        </div>

                        <div class="remember-me">
                            <input type="checkbox"  value="on" id="remember" name="remember">
                            <label for="remember">Ghi nhớ đăng nhập</label>
                        </div>

                        <div class="forgot-password">
                            <a href="forgotpass.jsp">Quên mật khẩu?</a>
                        </div>

                        <button type="submit" class="btn btn-primary">Đăng Nhập</button>
                    </form>

                    <div class="auth-footer">
                        <p>Chưa có tài khoản nhà tuyển dụng? <a href="registerRecruiter">Đăng Ký ngay!</a></p>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer>
            <div class="footer-container">
                <div class="copyright">
                    © 2025 JobHub. All rights are preserved.
                </div>
                <div class="footer-links">
                    <a href="#">Thỏa Thuận Sử Dụng</a>
                    <a href="#">Quy Định Bảo Mật</a>
                </div>
            </div>
        </footer>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Password visibility toggle
            const passwordToggle = document.getElementById('passwordToggle');
            const passwordField = document.getElementById('password');

            passwordToggle.addEventListener('click', function () {
                const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordField.setAttribute('type', type);

                // Toggle eye icon
                const icon = passwordToggle.querySelector('i');
                icon.classList.toggle('fa-eye');
                icon.classList.toggle('fa-eye-slash');
            });

            // Form validation
            const loginForm = document.getElementById('recruiterLoginForm');

            loginForm.addEventListener('submit', function (e) {
                let valid = true;
                const email = document.getElementById('email').value.trim();
                const password = document.getElementById('password').value;

                // Simple validation
                if (!email || !password) {
                    valid = false;
                }

                if (!valid) {
                    e.preventDefault();

                    // Remove existing error messages
                    const existingError = document.querySelector('.error-message');
                    if (existingError) {
                        existingError.remove();
                    }

                    // Create new error message
                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'error-message';
                    errorDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i> Vui lòng nhập đầy đủ và đúng định dạng thông tin đăng nhập.';

                    const form = document.getElementById('recruiterLoginForm');
                    form.parentNode.insertBefore(errorDiv, form);
                }
            });
        });
    </script>
</body>
</html>
