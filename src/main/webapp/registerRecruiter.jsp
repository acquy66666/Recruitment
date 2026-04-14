<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký Nhà tuyển dụng | MyJob</title>
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
            padding: 0 35px 0px;
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
        
        .password-strength {
            height: 4px;
            background-color: var(--border-color);
            border-radius: 2px;
            margin-top: 8px;
            overflow: hidden;
        }
        
        .password-strength-meter {
            height: 100%;
            width: 0;
            border-radius: 2px;
            transition: all var(--transition-speed);
        }
        
        .password-strength-text {
            font-size: 12px;
            margin-top: 5px;
            text-align: right;
        }
        
        .weak {
            background-color: var(--error-color);
            width: 25%;
        }
        
        .medium {
            background-color: var(--accent-color);
            width: 50%;
        }
        
        .strong {
            background-color: var(--success-color);
            width: 100%;
        }
        
        .terms {
            margin: 20px 0;
            font-size: 14px;
            color: var(--dark-gray);
            display: flex;
            align-items: flex-start;
        }
        
        .terms input[type="checkbox"] {
            margin-right: 10px;
            margin-top: 3px;
        }
        
        .terms a {
            color: var(--link-color);
            text-decoration: none;
        }
        
        .terms a:hover {
            text-decoration: underline;
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
        
        .employer-link {
            text-align: center;
            margin: 20px 0;
            padding: 1px 0;
            width: 100%;
            color: var(--dark-gray);
            font-size: 15px;
        }
        
        .employer-link a {
            color: var(--link-color);
            font-weight: 500;
            text-decoration: none;
            transition: all var(--transition-speed);
        }
        
        .employer-link a:hover {
            text-decoration: underline;
            color: var(--primary-light);
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
            
            .social-login {
                flex-direction: column;
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
        
        /* Form validation styles */
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
    </style>
</head>
<body>
    <div class="page-container">
        <!-- Header -->
        <header>
            <div class="header-container">
                <div class="logo">
                    <a href="HomePage.jsp">
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
                    <h1>Đăng ký Nhà tuyển dụng</h1>
                    <p>Tạo tài khoản để bắt đầu tìm kiếm ứng viên phù hợp</p>
                </div>
                
                <div class="auth-body">
                    <!-- Display error message using JSTL if present in request scope -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                        </div>
                    </c:if>
                    
                    <form action="registerRecruiter" method="post" id="registerForm">
                        <input type="hidden" name="roleId" value="3" />
                        <input type="hidden" name="walletId" value="0" />
                        <input type="hidden" name="imageUrl" value="default.jpg" />
                        
                        <div class="form-group">
                            <label for="fullName">Họ và tên(*)</label>
                            <input type="text" class="form-control" maxlength="50" id="fullName" name="fullName" 
                                   value="${param.fullName}" placeholder="Nhập họ và tên" 
                                   pattern="^[a-zA-ZÀ-ỹ\s]+$" title="Chỉ nhập chữ cái và khoảng trắng" required>
                            <div class="invalid-feedback">Vui lòng nhập họ và tên hợp lệ</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone">Số điện thoại(*)</label>
                            <input type="tel" class="form-control" maxlength="50" id="phone" name="phone" 
                                   value="${param.phone}" placeholder="Nhập số điện thoại" 
                                   pattern="^0[0-9]{7,}$" title="Số điện thoại phải bắt đầu bằng 0 và có ít nhất 7 chữ số" required>
                            <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email công ty(*)</label>
                            <input type="email" class="form-control" maxlength="50" id="email" name="email" 
                                   value="${param.email}" placeholder="Nhập địa chỉ email công ty" required>
                            <div class="invalid-feedback">Vui lòng nhập email hợp lệ</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="companyName">Tên công ty(*)</label>
                            <input type="text" class="form-control" maxlength="50" id="companyName" name="companyName" 
                                   value="${param.companyName}" placeholder="Nhập tên công ty" 
                                   pattern="^[a-zA-ZÀ-ỹ0-9\s]+$" title="Chỉ nhập chữ cái, số và khoảng trắng" required>
                            <div class="invalid-feedback">Vui lòng nhập tên công ty hợp lệ</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="position">Chức vụ(*)</label>
                            <input type="text" class="form-control" maxlength="50" id="position" name="position" 
                                   value="${param.position}" placeholder="Nhập chức vụ của bạn" 
                                   pattern="^[a-zA-ZÀ-ỹ0-9\s]+$" title="Chỉ nhập chữ cái, số và khoảng trắng" required>
                            <div class="invalid-feedback">Vui lòng nhập chức vụ hợp lệ</div>
                        </div>
                                                                  
                        <div class="form-group">
                            <label for="companyAddress">Mã số thuế công ty(*)</label>
                            <input type="text" class="form-control" maxlength="50" id="taxCode" name="taxCode" 
                                   value="${param.taxCode}" placeholder="Nhập địa chỉ công ty" 
                                   pattern="^[0-9]{8,20}$" title="Mã số thuế chỉ được chứa số độ dài từ 8 đến 20" required>
                            <div class="invalid-feedback">Vui lòng nhập địa mã số hợp lệ</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="password">Mật khẩu(*)</label>
                            <div class="password-field">
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Tạo mật khẩu (ít nhất 8 ký tự)" required>
                                <span class="password-toggle" id="passwordToggle">
                                    <i class="far fa-eye-slash"></i>
                                </span>
                                <div class="invalid-feedback">Mật khẩu phải có ít nhất 8 ký tự, chữ cái, số và chữ in hoa</div>
                            </div>
                            <div class="password-strength">
                                <div class="password-strength-meter" id="passwordStrengthMeter"></div>
                            </div>
                            <div class="password-strength-text" id="passwordStrengthText"></div>
                        </div>
                        
                        <div class="form-group">
                            <label for="confirm">Xác nhận mật khẩu(*)</label>
                            <div class="password-field">
                                <input type="password" maxlength="50" class="form-control" id="confirm" name="confirm" 
                                       placeholder="Nhập lại mật khẩu" required>
                                <span class="password-toggle" id="confirmPasswordToggle">
                                    <i class="far fa-eye-slash"></i>
                                </span>
                                <div class="invalid-feedback">Mật khẩu không khớp</div>
                            </div>
                        </div>
                        
                        <div class="terms">
                            <input type="checkbox" id="terms" name="terms" required ${param.terms == 'on' ? 'checked' : ''}>
                            <label for="terms">
                                Tôi đồng ý với <a href="#">Điều khoản dịch vụ</a> và <a href="#">Chính sách bảo mật</a> của MyJob
                            </label>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Đăng ký</button>
                    </form>
                    
                    <div class="employer-link">
                        Đã có tài khoản? <a href="login">Đăng nhập</a>
                    </div>
                </div>
                
                <div class="auth-footer">
                    <p>Bạn là người tìm việc? <a href="registerCandidate">Đăng ký tài khoản ứng viên</a></p>
                </div>
            </div>
        </main>
        
        <!-- Footer -->
        <footer>
            <div class="footer-container">
                <div class="copyright">
                    © 2025 MyJob. Tất cả quyền được bảo lưu.
                </div>
                <div class="footer-links">
                    <a href="#">Thỏa Thuận Sử Dụng</a>
                    <a href="#">Quy Định Bảo Mật</a>
                </div>
            </div>
        </footer>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Password visibility toggle
            const passwordToggle = document.getElementById('passwordToggle');
            const confirmPasswordToggle = document.getElementById('confirmPasswordToggle');
            const passwordInput = document.getElementById('password');
            const confirmInput = document.getElementById('confirm');
            
            passwordToggle.addEventListener('click', function() {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                const icon = this.querySelector('i');
                icon.classList.toggle('fa-eye');
                icon.classList.toggle('fa-eye-slash');
            });
            
            confirmPasswordToggle.addEventListener('click', function() {
                const type = confirmInput.getAttribute('type') === 'password' ? 'text' : 'password';
                confirmInput.setAttribute('type', type);
                const icon = this.querySelector('i');
                icon.classList.toggle('fa-eye');
                icon.classList.toggle('fa-eye-slash');
            });
            
            // Password strength meter
            const passwordStrengthMeter = document.getElementById('passwordStrengthMeter');
            const passwordStrengthText = document.getElementById('passwordStrengthText');
            
            passwordInput.addEventListener('input', function() {
                const password = this.value;
                let strength = 0;
                
                if (password.length >= 8) strength++;
                if (/[a-zA-Z]/.test(password)) strength++;
                if (/\d/.test(password)) strength++;
                if (/[A-Z]/.test(password)) strength++;
                
                passwordStrengthMeter.classList.remove('weak', 'medium', 'strong');
                if (strength <= 1) {
                    passwordStrengthMeter.classList.add('weak');
                    passwordStrengthText.textContent = 'Yếu';
                    passwordStrengthText.style.color = 'var(--error-color)';
                } else if (strength <= 3) {
                    passwordStrengthMeter.classList.add('medium');
                    passwordStrengthText.textContent = 'Trung bình';
                    passwordStrengthText.style.color = 'var(--accent-color)';
                } else {
                    passwordStrengthMeter.classList.add('strong');
                    passwordStrengthText.textContent = 'Mạnh';
                    passwordStrengthText.style.color = 'var(--success-color)';
                }
            });
            
            // Form validation
            const registerForm = document.getElementById('registerForm');
            const fullNameInput = document.getElementById('fullName');
            const phoneInput = document.getElementById('phone');
            const emailInput = document.getElementById('email');
            const companyNameInput = document.getElementById('companyName');
            const positionInput = document.getElementById('position');
            const companyAddressInput = document.getElementById('companyAddress');
            const termsCheckbox = document.getElementById('terms');
            const taxCodeInput = document.getElementById('taxCode');
            
            registerForm.addEventListener('submit', function(e) {
                let valid = true;
                
                // Validate full name
                if (!/^[a-zA-ZÀ-ỹ\s]+$/.test(fullNameInput.value)) {
                    fullNameInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    fullNameInput.classList.remove('is-invalid');
                }
                
                // Validate phone
                if (!/^0[0-9]{7,}$/.test(phoneInput.value)) {
                    phoneInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    phoneInput.classList.remove('is-invalid');
                }
                
                // Validate email
                if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailInput.value)) {
                    emailInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    emailInput.classList.remove('is-invalid');
                }
                
                // Validate company name
                if (!/^[a-zA-ZÀ-ỹ0-9\s]+$/.test(companyNameInput.value)) {
                    companyNameInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    companyNameInput.classList.remove('is-invalid');
                }
                
                // Validate position
                if (!/^[a-zA-ZÀ-ỹ0-9\s]+$/.test(positionInput.value)) {
                    positionInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    positionInput.classList.remove('is-invalid');
                }
                
                // Validate company taxcode
                if (!/^[0-9{8,20}]$/.test(taxCodeInput.value)) {
                    companyAddressInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    companyAddressInput.classList.remove('is-invalid');
                }
                
                // Validate password length and strength
                const password = passwordInput.value;
                if (password.length < 8 || !/[a-zA-Z]/.test(password) || !/\d/.test(password) || !/[A-Z]/.test(password)) {
                    passwordInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    passwordInput.classList.remove('is-invalid');
                }
                
                // Validate password match
                if (passwordInput.value !== confirmInput.value) {
                    confirmInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    confirmInput.classList.remove('is-invalid');
                }
                
                // Validate terms checkbox
                if (!termsCheckbox.checked) {
                    valid = false;
                    termsCheckbox.classList.add('is-invalid');
                    // Note: No invalid-feedback div for checkbox, consider adding visual cue
                } else {
                    termsCheckbox.classList.remove('is-invalid');
                }
                
                if (!valid) {
                    e.preventDefault();
                }
            });
            
            // Check for success parameter in URL
            const params = new URLSearchParams(window.location.search);
            const success = params.get("success");
            if (success === "true") {
                alert("Đăng ký thành công!");
                window.location.href = "HomePage.jsp";
            }
        });
    </script>
</body>
</html>