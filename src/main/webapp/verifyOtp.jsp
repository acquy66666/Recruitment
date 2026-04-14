<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác minh OTP | MyJob</title>
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
            max-width: 550px;
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
            padding: 0 35px 30px;
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
        @media (max-width: 768px) {
            .auth-container {
                max-width: 100%;
            }
            .footer-container {
                flex-direction: column;
                gap: 10px;
            }
        }
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
        .success-message {
            background-color: rgba(40, 167, 69, 0.1);
            color: var(--success-color);
            padding: 12px 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }
        .success-message i {
            margin-right: 10px;
            font-size: 16px;
        }
        .form-control.is-invalid {
            border-color: var(--error-color);
        }
        .invalid-feedback {
            display: none;
            width: 100%;
            margin-top: 5px;
            font-size: 12px;
            color: var(--error-color);
        }
        .form-control.is-invalid ~ .invalid-feedback {
            display: block;
        }
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        .modal.show {
            display: flex;
        }
        .modal-content {
            background-color: white;
            border-radius: 8px;
            box-shadow: var(--box-shadow);
            max-width: 400px;
            width: 100%;
            padding: 20px;
            text-align: center;
        }
        .modal-header {
            font-size: 18px;
            font-weight: 500;
            color: var(--secondary-color);
            margin-bottom: 15px;
        }
        .modal-body {
            font-size: 14px;
            color: var(--dark-gray);
            margin-bottom: 20px;
        }
        .modal-footer {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .modal-success .modal-header {
            color: var(--success-color);
        }
        .modal-error .modal-header {
            color: var(--error-color);
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
                                CVCenter
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
                    <h1>Xác Minh OTP</h1>
                    <p>Mã OTP đã được gửi tới <c:out value="${sessionScope.email}" />. Vui lòng nhập mã để xác nhận.</p>
                </div>
                
                <div class="auth-body">
                    <!-- Display success message using JSTL if present in request scope -->
                    <c:if test="${not empty requestScope.successMessage}">
                        <div class="success-message">
                            <i class="fas fa-check-circle"></i> <c:out value="${requestScope.successMessage}" />
                        </div>
                    </c:if>
                    
                    <!-- Display error message using JSTL if present in request scope -->
                    <c:if test="${not empty requestScope.errorMessage}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i> <c:out value="${requestScope.errorMessage}" />
                        </div>
                    </c:if>
                    
                    <form action="verifyOtp" method="post" id="otpForm">
                        <div class="form-group">
                            <label for="otp">Mã OTP</label>
                            <input type="text" class="form-control" id="otp" name="otp" placeholder="Nhập mã OTP 6 số" required pattern="[0-9]{6}" value="">
                            <div class="invalid-feedback">Mã OTP phải là 6 số</div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Xác Nhận</button>
                    </form>
                    
                    <div class="auth-footer">
                        <p>Đã có tài khoản? <a href="login">Đăng nhập</a></p>
                    </div>
                </div>
            </div>
        </main>
        
        <!-- Footer -->
        <footer>
            <div class="footer-container">
                <div class="copyright">
                    © 2024 MyJob. Tất cả quyền được bảo lưu.
                </div>
                <div class="footer-links">
                    <a href="#">Thỏa Thuận Sử Dụng</a>
                    <a href="#">Quy Định Bảo Mật</a>
                </div>
            </div>
        </footer>
        
        <!-- Custom Modal for Alerts -->
        <div class="modal" id="alertModal">
            <div class="modal-content">
                <div class="modal-header" id="alertModalTitle">Thông báo</div>
                <div class="modal-body" id="alertModalBody"></div>
                <div class="modal-footer">
                    <button class="btn btn-primary" id="alertModalOkButton">OK</button>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Form validation
            const otpForm = document.getElementById('otpForm');
            const otpInput = document.getElementById('otp');
            
            otpForm.addEventListener('submit', function(e) {
                const otpPattern = /^[0-9]{6}$/;
                if (!otpPattern.test(otpInput.value)) {
                    otpInput.classList.add('is-invalid');
                    e.preventDefault();
                } else {
                    otpInput.classList.remove('is-invalid');
                }
            });
            
            // Custom modal handling
            function showModal(message, isSuccess, redirectUrl) {
                const modal = document.getElementById('alertModal');
                const modalContent = modal.querySelector('.modal-content');
                const modalTitle = document.getElementById('alertModalTitle');
                const modalBody = document.getElementById('alertModalBody');
                const okButton = document.getElementById('alertModalOkButton');
                
                // Set modal content
                modalBody.textContent = message;
                
                // Apply success or error styling
                if (isSuccess) {
                    modalContent.classList.add('modal-success');
                    modalContent.classList.remove('modal-error');
                    modalTitle.textContent = 'Thành công';
                } else {
                    modalContent.classList.add('modal-error');
                    modalContent.classList.remove('modal-success');
                    modalTitle.textContent = 'Lỗi';
                }
                
                // Show modal
                modal.classList.add('show');
                
                // Handle OK button click
                okButton.onclick = function() {
                    modal.classList.remove('show');
                    if (redirectUrl) {
                        window.location.href = redirectUrl;
                    } else {
                        // Clear OTP input for retry
                        otpInput.value = '';
                        otpInput.focus();
                    }
                };
                
                // Handle click outside modal to close
                modal.onclick = function(e) {
                    if (e.target === modal) {
                        modal.classList.remove('show');
                        if (redirectUrl) {
                            window.location.href = redirectUrl;
                        } else {
                            // Clear OTP input for retry
                            otpInput.value = '';
                            otpInput.focus();
                        }
                    }
                };
            }
            
            // Handle success message - redirect to login page
            <c:if test="${not empty requestScope.successMessage}">
                showModal('<c:out value="${requestScope.successMessage}" />', true, '<c:out value="${requestScope.redirectUrl}" />');
            </c:if>
            
            // Handle error message - redirect if specified (e.g., for expired OTP), otherwise stay for retry
            <c:if test="${not empty requestScope.errorMessage}">
                showModal('<c:out value="${requestScope.errorMessage}" />', false, '<c:out value="${requestScope.redirectUrl != null ? requestScope.redirectUrl : ''}" />');
            </c:if>
            
            // Debugging: Log to console
            console.log('SuccessMessage: <c:out value="${requestScope.successMessage != null ? requestScope.successMessage : 'null'}" />');
            console.log('ErrorMessage: <c:out value="${requestScope.errorMessage != null ? requestScope.errorMessage : 'null'}" />');
            console.log('RedirectUrl: <c:out value="${requestScope.redirectUrl != null ? requestScope.redirectUrl : 'null'}" />');
        });
    </script>
</body>
</html>