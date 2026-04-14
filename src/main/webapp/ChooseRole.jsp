<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn loại tài khoản | CVCenter</title>
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

        .choose-login-container {
            width: 100%;
            max-width: 600px;
            background-color: white;
            border-radius: 8px;
            box-shadow: var(--box-shadow);
            overflow: hidden;
            transform: translateY(0);
            transition: transform 0.4s ease-out;
            animation: fadeIn 0.5s ease-out;
            padding: 40px;
            text-align: center;
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

        .choose-login-container:hover {
            transform: translateY(-5px);
        }

        .choose-login-container h1 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--primary-dark);
        }

        .choose-login-container p {
            font-size: 18px;
            color: var(--dark-gray);
            margin-bottom: 40px;
        }

        .login-options {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .login-option-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 18px 25px;
            border-radius: 8px;
            font-size: 20px;
            font-weight: 600;
            text-decoration: none;
            transition: all var(--transition-speed);
            border: 2px solid var(--border-color);
            color: var(--secondary-color);
            background-color: white;
        }

        .login-option-btn i {
            margin-right: 15px;
            font-size: 24px;
            color: var(--primary-color);
        }

        .login-option-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
            border-color: var(--primary-color);
            color: var(--primary-color);
        }

        .login-option-btn:hover i {
            color: var(--primary-color);
        }

        /* New: Register link styling */
        .register-link {
            margin-top: 30px; /* Space above the link */
            font-size: 16px;
            color: var(--dark-gray);
        }

        .register-link a {
            color: var(--link-color);
            text-decoration: none;
            font-weight: 500;
            transition: color var(--transition-speed);
        }

        .register-link a:hover {
            text-decoration: underline;
            color: var(--primary-color);
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
            .choose-login-container {
                max-width: 100%;
                padding: 30px 20px;
            }

            .choose-login-container h1 {
                font-size: 28px;
            }

            .choose-login-container p {
                font-size: 16px;
            }

            .login-option-btn {
                font-size: 18px;
                padding: 15px 20px;
            }

            .login-option-btn i {
                font-size: 20px;
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
                        <!-- CVCenter Logo (White version for dark background) -->
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
            <div class="choose-login-container">
                <h1>Chọn vai trò để đăng nhập</h1>
                <p>Vui lòng chọn loại tài khoản của bạn để tiếp tục đăng nhập.</p>
                <div class="login-options">
                    <a href="login" class="login-option-btn">
                        <i class="fas fa-user"></i> Ứng viên
                    </a>
                    <a href="RecruiterLogin.jsp" class="login-option-btn">
                        <i class="fas fa-building"></i> Nhà tuyển dụng
                    </a>
                </div>
                <div class="register-link">
                    <p>Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay!</a></p>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer>
            <div class="footer-container">
                <div class="copyright">
                    © 2025 CVCenter. All rights are preserved.
                </div>
                <div class="footer-links">
                    <a href="#">Thỏa Thuận Sử Dụng</a>
                    <a href="#">Quy Định Bảo Mật</a>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>
