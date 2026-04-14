<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyJob - Xác minh OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        .header {
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .logo {
            color: white;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
        }
        
        .logo i {
            margin-right: 8px;
        }
        
        .main-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 80px);
            padding: 20px;
        }
        
        .form-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            border: none;
        }
        
        .form-title {
            color: #1f2937;
            font-size: 28px;
            font-weight: 600;
            text-align: center;
            margin-bottom: 8px;
        }
        
        .form-subtitle {
            color: #6b7280;
            text-align: center;
            margin-bottom: 30px;
            font-size: 14px;
            line-height: 1.5;
        }
        
        .email-highlight {
            color: #3b82f6;
            font-weight: 600;
        }
        
        .form-label {
            color: #374151;
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .form-control {
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #fafafa;
        }
        
        .form-control:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            background-color: white;
        }
        
        .otp-input {
            text-align: center;
            font-size: 20px;
            font-weight: 600;
            letter-spacing: 4px;
        }
        
        .btn-verify {
            background: linear-gradient(135deg, #f97316 0%, #ea580c 100%);
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            font-size: 16px;
            padding: 14px;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 20px;
        }
        
        .btn-verify:hover {
            background: linear-gradient(135deg, #ea580c 0%, #dc2626 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.4);
        }
        
        .alert {
            border-radius: 8px;
            border: none;
            padding: 12px 16px;
            margin-bottom: 20px;
        }
        
        .alert-danger {
            background-color: #fef2f2;
            color: #dc2626;
            border-left: 4px solid #dc2626;
        }
        
        .resend-section {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }
        
        .resend-text {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .resend-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
        }
        
        .resend-link:hover {
            color: #1d4ed8;
            text-decoration: underline;
        }
        
        .invalid-feedback {
            color: #dc2626;
            font-size: 12px;
            margin-top: 4px;
        }
        
        @media (max-width: 576px) {
            .form-container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .form-title {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="container">
            <a href="#" class="logo">
                <i class="fas fa-briefcase"></i>MyJob
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-container">
        <div class="form-container">
            <h2 class="form-title">Xác minh OTP</h2>
            
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                String email = (String) session.getAttribute("email");
                if (email == null) {
                    response.sendRedirect("registerCandidate");
                    return;
                }
            %>
            
            <p class="form-subtitle">
                Mã OTP đã được gửi tới <span class="email-highlight"><%= email %></span><br>
                Vui lòng nhập mã 6 số để xác nhận tài khoản của bạn.
            </p>
            
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i><%= errorMessage %>
                </div>
            <% } %>
            
            <form action="verifyOtpCandidate" method="post" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label for="otp" class="form-label">Mã OTP</label>
                    <input type="text" 
                           class="form-control otp-input" 
                           id="otp" 
                           name="otp" 
                           required 
                           pattern="[0-9]{6}"
                           maxlength="6"
                           placeholder="000000">
                    <div class="invalid-feedback">
                        Vui lòng nhập mã OTP gồm 6 chữ số.
                    </div>
                </div>
                
                <button type="submit" class="btn btn-verify">
                    <i class="fas fa-check-circle me-2"></i>Xác Nhận
                </button>
            </form>
            
            <div class="resend-section">
                <p class="resend-text">Không nhận được mã?</p>
                <a href="#" class="resend-link" onclick="resendOTP()">
                    <i class="fas fa-redo me-1"></i>Gửi lại mã OTP
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
        
        // Auto-format OTP input
        document.getElementById('otp').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 6) {
                value = value.slice(0, 6);
            }
            e.target.value = value;
        });
        
        // Auto-submit when 6 digits are entered
        document.getElementById('otp').addEventListener('input', function(e) {
            if (e.target.value.length === 6) {
                // Optional: Auto-submit the form
                // e.target.closest('form').submit();
            }
        });
        
        // Resend OTP function
        function resendOTP() {
            // Add your resend OTP logic here
            alert('Mã OTP mới đã được gửi!');
        }
        
        // Focus on OTP input when page loads
        window.addEventListener('load', function() {
            document.getElementById('otp').focus();
        });
    </script>
</body>
</html>