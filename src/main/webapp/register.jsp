<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | CV Center</title>

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
            padding: 0 35px 35px;
        }
        
        .user-type {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }
        
        .user-type-option {
            flex: 1;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            padding: 25px 15px;
            text-align: center;
            cursor: pointer;
            transition: all var(--transition-speed);
        }
        
        .user-type-option:hover {
            border-color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .user-type-option i {
            font-size: 32px;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .user-type-option h3 {
            font-size: 18px;
            margin-bottom: 8px;
            color: var(--secondary-color);
        }
        
        .user-type-option p {
            font-size: 14px;
            color: var(--dark-gray);
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
            margin-top: 15px;
            text-decoration: none;
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
        
        /* Responsive styles */
        @media (max-width: 768px) {
            .auth-container {
                max-width: 100%;
            }
            
            .footer-container {
                flex-direction: column;
                gap: 10px;
            }
            
            .user-type {
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
                <div class="logo">
                    <!-- CV Center Logo -->
                    <a href="HomePage">
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
                    <h1>Đăng ký tài khoản</h1>
                    <p>Tạo tài khoản để bắt đầu hành trình sự nghiệp của bạn</p>
                </div>
                
                <div class="auth-body">
                    <!-- User Type Selection -->
                    <div class="user-type">
                        <div class="user-type-option" id="jobSeekerOption">
                            <i class="fas fa-user"></i>
                            <h3>Người tìm việc</h3>
                            <p>Tôi muốn tìm công việc phù hợp</p>
                            <form action="registerCandidate" method="get">
                                <button type="submit" class="btn btn-primary">Đăng ký ngay</button>
                            </form>
                        </div>
                        <div class="user-type-option" id="employerOption">
                            <i class="fas fa-building"></i>
                            <h3>Nhà tuyển dụng</h3>
                            <p>Tôi muốn tìm kiếm ứng viên phù hợp</p>
                            <form action="registerRecruiter" method="get">
                                <button type="submit" class="btn btn-primary">Đăng ký ngay</button>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="auth-footer">
                    <p>Đã có tài khoản? <a href="login">Login</a></p>
                </div>
            </div>
        </main>
        
        <!-- Footer -->
        <footer>
            <div class="footer-container">
                <div class="copyright">
                    &copy; 2025 CV Center. All rights reserved.
                </div>
                <div class="footer-links">
                    <a href="#">Terms of Service</a>
                    <a href="#">Privacy Policy</a>
                </div>
            </div>
        </footer>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Hover effect for user type options
            const jobSeekerOption = document.getElementById('jobSeekerOption');
            const employerOption = document.getElementById('employerOption');
            
            jobSeekerOption.addEventListener('mouseenter', function() {
                this.style.borderColor = 'var(--primary-color)';
            });
            
            jobSeekerOption.addEventListener('mouseleave', function() {
                this.style.borderColor = 'var(--border-color)';
            });
            
            employerOption.addEventListener('mouseenter', function() {
                this.style.borderColor = 'var(--primary-color)';
            });
            
            employerOption.addEventListener('mouseleave', function() {
                this.style.borderColor = 'var(--border-color)';
            });
        });
    </script>
</body>
</html>