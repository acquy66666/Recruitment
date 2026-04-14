<%-- 
    Document   : register_candidate
    Created on : May 26, 2025, 4:11:21 PM
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký | MyJob</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Giữ nguyên tất cả CSS của bạn */
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
                --box_shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                --transition-speed: 0.3s;
            }
            input::-ms-reveal {
                display: none;
            }
            input::-ms-clear {
                display: none;
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
                cursor: pointer;
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
                box-shadow: var(--box_shadow);
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
                padding: 0 35px 3px;
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

            .password-strength-text {
                font-size: 12px;
                margin-top: 5px;
                text-align: right;
                font-weight: 500;
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
                padding: 15px 0;
                border-top: 1px dashed var(--border-color);
                width: 100%;
            }

            .employer-link a {
                color: var(--primary-light);
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
                border-left: 4px solid var(--error-color);
            }

            .error-message i {
                margin-right: 10px;
                font-size: 16px;
            }

            /* Form validation styles */
            .form-control.is-invalid {
                border-color: var(--error-color);
                box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
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

            /* Auto-focus animation */
            .form-control.auto-focus {
                animation: focusGlow 1s ease-in-out;
            }

            @keyframes focusGlow {
                0% { box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.4); }
                50% { box-shadow: 0 0 0 5px rgba(220, 53, 69, 0.2); }
                100% { box-shadow: 0 0 0 0 rgba(220, 53, 69, 0); }
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
        </style>
    </head>
    <body>
        <div class="page-container">
            <!-- Header -->
            <header>
                <div class="header-container">
                    <div class="logo" onclick="window.location.href = 'index.jsp'">
                        <!-- MyJob Logo -->
                        <svg viewBox="0 0 300 100" xmlns="http://www.w3.org/2000/svg" width="150" title="MyJob - Trang tuyển dụng hàng đầu">
                        <defs>
                        <linearGradient id="myjob-logo-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
                        <stop offset="0%" stop-color="#FFFFFF" />
                        <stop offset="100%" stop-color="#FFFFFF" />
                        </linearGradient>
                        </defs>
                        <circle cx="60" cy="50" r="40" fill="url(#myjob-logo-gradient)" />
                        <path d="M40,35 L40,65 M60,25 L60,75 M80,35 L80,65" stroke="#001a57" stroke-width="6" stroke-linecap="round" />
                        <path d="M35,50 L45,50 M55,50 L65,50 M75,50 L85,50" stroke="#001a57" stroke-width="3" stroke-linecap="round" />
                        <text x="110" y="65" font-family="Arial, sans-serif" font-size="45" font-weight="bold" fill="url(#myjob-logo-gradient)">
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
                        <h1>Đăng ký tài khoản</h1>
                        <p>Tạo tài khoản để bắt đầu hành trình sự nghiệp của bạn với MyJob</p>
                    </div>

                    <div class="auth-body">
                        <!-- Social Login -->
                        <div class="social-login">
                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/Recruitment/login&response_type=code&client_id=319952140944-f9ro0cpfhoosvihl590tl6iq5are2pve.apps.googleusercontent.com&approval_prompt=force" class="social-btn google">
                                <i class="fab fa-google"></i> Google
                            </a>
                        </div>

                        <div class="divider">
                            <span>hoặc đăng ký bằng email</span>
                        </div>

                        <!-- Error Message -->
                        <div class="error-message" style="${not empty errorMessage ? 'display:flex;' : 'display:none;'}">
                            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                        </div>

                        <form action="registerCandidate" method="post" id="register">
                            <input type="hidden" name="roleId" value="1" /> 
                            <input type="hidden" name="imageUrl" value="default.jpg" />

                            <!-- Họ và tên - Chỉ xóa khi tên sai -->
                            <div class="form-group">
                                <label for="fullname">Họ và tên</label>
                                <input type="text" 
                                       class="form-control ${errorField == 'fullname' ? 'is-invalid' : ''}" 
                                       maxlength="50" 
                                       id="fullname" 
                                       name="fullname" 
                                       value="${errorField == 'fullname' ? '' : param.fullname}"
                                       placeholder="Nhập họ và tên" 
                                       required>
                                <div class="invalid-feedback">Vui lòng nhập họ và tên hợp lệ</div>
                            </div>

                            <!-- Email - Chỉ xóa khi email sai/trùng -->
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" 
                                       class="form-control ${errorField == 'email' ? 'is-invalid' : ''}" 
                                       id="email" 
                                       name="email" 
                                       value="${errorField == 'email' ? '' : param.email}"
                                       placeholder="Nhập địa chỉ email" 
                                       required>
                                <div class="invalid-feedback">Vui lòng nhập email hợp lệ</div>
                            </div>

                            <!-- Phone - Chỉ xóa khi phone sai/trùng -->
                            <div class="form-group">
                                <label for="phone">Số điện thoại</label>
                                <input type="tel" 
                                       class="form-control ${errorField == 'phone' ? 'is-invalid' : ''}" 
                                       id="phone" 
                                       name="phone" 
                                       value="${errorField == 'phone' ? '' : param.phone}"
                                       placeholder="Nhập số điện thoại" 
                                       required>
                                <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ</div>
                            </div>

                            <!-- Password - Giữ nguyên khi có lỗi để user biết đã nhập gì -->
                            <div class="form-group">
                                <label for="password">Mật khẩu</label>
                                <div class="password-field">
                                    <input type="password" 
                                           class="form-control ${errorField == 'password' ? 'is-invalid' : ''}" 
                                           id="password" 
                                           name="password" 
                                           value="${param.password}"
                                           placeholder="Tạo mật khẩu (ít nhất 8 ký tự)" 
                                           required>
                                    <span class="password-toggle" id="passwordToggle">
                                        <i class="far fa-eye-slash"></i>
                                    </span>
                                    <div class="invalid-feedback">Mật khẩu phải có ít nhất 8 ký tự và chứa chữ hoa, số</div>
                                </div>
                                <div class="password-strength-text" id="passwordStrengthText"></div>
                            </div>

                            <!-- Confirm Password - Chỉ xóa khi không khớp -->
                            <div class="form-group">
                                <label for="confirm">Xác nhận mật khẩu</label>
                                <div class="password-field">
                                    <input type="password" 
                                           class="form-control ${errorField == 'confirm' ? 'is-invalid' : ''}" 
                                           id="confirm" 
                                           name="confirm" 
                                           value="${errorField == 'confirm' ? '' : param.confirm}"
                                           placeholder="Nhập lại mật khẩu" 
                                           required>
                                    <span class="password-toggle" id="confirmPasswordToggle">
                                        <i class="far fa-eye-slash"></i>
                                    </span>
                                    <div class="invalid-feedback">Mật khẩu xác nhận không khớp</div>
                                </div>
                            </div>

                            <div class="terms">
                                <input type="checkbox" id="terms" name="terms" required>
                                <label for="terms">
                                    Tôi đồng ý với <a href="#">Điều khoản dịch vụ</a> và <a href="#">Chính sách bảo mật</a> của MyJob
                                </label>
                            </div>

                            <button type="submit" class="btn btn-primary">Đăng ký</button>
                        </form>

                        <!-- Employer Link -->
                        <div class="employer-link">
                            Bạn là một nhà tuyển dụng? <a href="registerRecruiter.jsp">Đăng ký tại đây</a>
                        </div>
                    </div>

                    <div class="auth-footer">
                        <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập</a></p>
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
                // Auto-focus on error field
                const errorField = '${errorField}';
                if (errorField) {
                    const field = document.getElementById(errorField);
                    if (field) {
                        field.focus();
                        field.classList.add('auto-focus');
                        setTimeout(() => {
                            field.classList.remove('auto-focus');
                        }, 1000);
                    }
                }

                // Password visibility toggle
                const passwordToggles = document.querySelectorAll('.password-toggle');

                passwordToggles.forEach(toggle => {
                    toggle.addEventListener('click', function () {
                        const passwordField = this.previousElementSibling;
                        const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
                        passwordField.setAttribute('type', type);

                        const icon = this.querySelector('i');
                        if (type === 'password') {
                            icon.className = 'far fa-eye-slash';
                        } else {
                            icon.className = 'far fa-eye';
                        }
                    });
                });

                // Password strength indicator
                const passwordInput = document.getElementById('password');
                const passwordStrengthText = document.getElementById('passwordStrengthText');

                if (passwordInput && passwordStrengthText) {
                    passwordInput.addEventListener('input', function () {
                        const password = this.value;
                        updatePasswordStrength(password);
                    });

                    function updatePasswordStrength(password) {
                        let strength = 0;
                        let strengthText = '';

                        if (password.length === 0) {
                            passwordStrengthText.textContent = '';
                            passwordStrengthText.style.color = '';
                            return;
                        }

                        if (password.length >= 8) strength += 25;
                        if (password.match(/[A-Z]/)) strength += 25;
                        if (password.match(/[0-9]/)) strength += 25;
                        if (password.match(/[^A-Za-z0-9]/)) strength += 25;

                        if (strength <= 25) {
                            strengthText = 'Yếu';
                            passwordStrengthText.style.color = '#dc3545';
                        } else if (strength <= 50) {
                            strengthText = 'Trung bình';
                            passwordStrengthText.style.color = '#ff7f50';
                        } else if (strength <= 75) {
                            strengthText = 'Khá mạnh';
                            passwordStrengthText.style.color = '#ff7f50';
                        } else {
                            strengthText = 'Mạnh';
                            passwordStrengthText.style.color = '#28a745';
                        }

                        passwordStrengthText.textContent = strengthText;
                    }
                }

                // Form validation
                const registerForm = document.getElementById('register');
                const confirmPasswordInput = document.getElementById('confirm');

                registerForm.addEventListener('submit', function (e) {
                    let valid = true;

                    // Clear previous validation states
                    document.querySelectorAll('.form-control').forEach(field => {
                        field.classList.remove('is-invalid');
                    });

                    // Validate password length and complexity
                    if (passwordInput.value.length < 8) {
                        passwordInput.classList.add('is-invalid');
                        valid = false;
                    }

                    // Validate password match
                    if (passwordInput.value !== confirmPasswordInput.value) {
                        confirmPasswordInput.classList.add('is-invalid');
                        valid = false;
                    }

                    // Validate terms checkbox
                    const termsCheckbox = document.getElementById('terms');
                    if (!termsCheckbox.checked) {
                        valid = false;
                        alert('Vui lòng đồng ý với điều khoản dịch vụ');
                    }

                    if (!valid) {
                        e.preventDefault();
                    }
                });
            });
        </script>
    </body>
</html>