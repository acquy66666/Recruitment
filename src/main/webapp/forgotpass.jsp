<%-- 
    Document   : forgotpass
    Created on : May 19, 2025, 4:35:17 PM
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quên mật khẩu | MyJob</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            :root {
                --primary-dark: #001a57;
                --primary-color: #0046b8;
                --primary-light: #0066ff;
                --secondary-color: #2c3e50;
                --accent-color: #ff7f50;
                --accent-hover: #ff6a3c;
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

            .language-selector {
                position: relative;
            }

            .language-selector select {
                appearance: none;
                padding: 8px 30px 8px 12px;
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 4px;
                background-color: rgba(255, 255, 255, 0.1);
                font-size: 14px;
                color: white;
                cursor: pointer;
                transition: all var(--transition-speed);
            }

            .language-selector::after {
                content: '\f078';
                font-family: 'Font Awesome 5 Free';
                font-weight: 900;
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                pointer-events: none;
                font-size: 12px;
                color: white;
            }

            .language-selector select:hover {
                background-color: rgba(255, 255, 255, 0.2);
            }

            .language-selector select:focus {
                outline: none;
                box-shadow: 0 0 0 2px rgba(255, 255, 255, 0.5);
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

            .info-box {
                background-color: rgba(0, 70, 184, 0.1);
                border-left: 4px solid var(--primary-color);
                padding: 15px;
                margin-bottom: 25px;
                border-radius: 4px;
                display: flex;
                align-items: flex-start;
            }

            .info-box i {
                color: var(--primary-color);
                font-size: 18px;
                margin-right: 15px;
                margin-top: 2px;
            }

            .info-box p {
                font-size: 14px;
                color: var(--primary-color);
                margin: 0;
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

            .btn-outline {
                background-color: transparent;
                border: 1px solid var(--primary-color);
                color: var(--primary-color);
                margin-top: 15px;
            }

            .btn-outline:hover {
                background-color: rgba(0, 70, 184, 0.05);
                transform: translateY(-2px);
            }

            .btn-outline:active {
                transform: translateY(0);
            }

            .success-message {
                display: none; /* Hidden by default, shown after form submission */
                text-align: center;
                padding: 20px;
                animation: fadeIn 0.5s ease-out;
            }

            .success-icon {
                width: 70px;
                height: 70px;
                border-radius: 50%;
                background-color: var(--success-color);
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                position: relative;
            }

            .success-icon i {
                font-size: 35px;
                color: white;
            }

            .success-message h2 {
                font-size: 22px;
                margin-bottom: 15px;
                color: var(--secondary-color);
            }

            .success-message p {
                font-size: 15px;
                color: var(--dark-gray);
                margin-bottom: 25px;
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
        </style>
    </head>
    <body>
        <div class="page-container">
            <!-- Header -->
            <header>
                <div class="header-container">
                    <div class="logo">
                        <!-- MyJob Logo (White version for dark background) -->
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
                        MyJob
                        </text>
                        </svg>
                    </div>
                </div>
            </header>

            <!-- Main Content -->
            <main>
                <div class="auth-container">
                    <div class="auth-header">
                        <h1>Quên mật khẩu</h1>
                        <p>Khôi phục mật khẩu tài khoản của bạn</p>
                    </div>

                    <div class="auth-body">
                        <!-- Form Section (visible by default) -->
                        <div id="resetForm">
                            <div class="info-box">
                                <i class="fas fa-info-circle"></i>
                                <p>Vui lòng nhập địa chỉ email đã đăng ký. Chúng tôi sẽ gửi một liên kết để đặt lại mật khẩu của bạn.</p>
                            </div>

                            <form id="forgotPasswordForm" action="processForgotPassword.jsp" method="post">
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" placeholder="Nhập địa chỉ email của bạn" required>
                                </div>

                                <button type="submit" class="btn btn-primary" id="submitBtn">
                                    Gửi liên kết đặt lại mật khẩu
                                </button>
                                <a href="login.jsp" class="btn btn-outline">Quay lại đăng nhập</a>
                            </form>
                        </div>

                        <!-- Success Message (hidden by default, shown after form submission) -->
                        <div id="successMessage" class="success-message">
                            <div class="success-icon">
                                <i class="fas fa-check"></i>
                            </div>
                            <h2>Kiểm tra email của bạn</h2>
                            <p>Chúng tôi đã gửi một email với liên kết đặt lại mật khẩu đến địa chỉ email của bạn. Vui lòng kiểm tra hộp thư đến và thư rác.</p>
                            <p>Liên kết sẽ hết hạn sau 24 giờ.</p>
                            <a href="login.jsp" class="btn btn-primary">Quay lại đăng nhập</a>
                        </div>
                    </div>

                    <div class="auth-footer">
                        <p>Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a></p>
                    </div>
                </div>
            </main>

            <!-- Footer -->
            <footer>
                <div class="footer-container">
                    <div class="copyright">
                        &copy; 2025 MyJob. Tất cả quyền được bảo lưu.
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
                // Form submission handling
                const form = document.getElementById('forgotPasswordForm');
                const resetForm = document.getElementById('resetForm');
                const successMessage = document.getElementById('successMessage');
                const submitBtn = document.getElementById('submitBtn');

                form.addEventListener('submit', function (e) {
                    e.preventDefault(); // Prevent actual form submission for demo

                    // Show loading state on button
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang gửi...';
                    submitBtn.disabled = true;

                    // Simulate server request
                    setTimeout(function () {
                        // Hide the form and show success message
                        resetForm.style.display = 'none';
                        successMessage.style.display = 'block';

                        // Reset button state (not needed as form is hidden)
                        submitBtn.innerHTML = originalText;
                        submitBtn.disabled = false;
                    }, 1500);

                    // In a real application, you would submit the form to the server here
                    // and show the success message only after successful submission
                });
            });
        </script>
    </body>
</html>