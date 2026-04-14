<%-- 
    Document   : SuccessApplicationPage
    Created on : Jun 9, 2025, 10:41:19 PM
    Author     : GBCenter
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ứng tuyển thành công - Cảm ơn bạn đã ứng tuyển</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            line-height: 1.6;
        }

        .success-container {
            width: 100%;
            max-width: 480px;
            animation: slideUp 0.6s ease-out;
        }

        .success-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            padding: 3rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .success-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #10b981, #059669);
        }

        .success-icon {
            width: 80px;
            height: 80px;
            color: #10b981;
            margin: 0 auto 1.5rem;
            animation: checkmark 0.8s ease-out 0.3s both;
        }

        .success-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: #111827;
            margin-bottom: 1rem;
            animation: fadeInUp 0.6s ease-out 0.4s both;
        }

        .success-text {
            color: #6b7280;
            font-size: 1.1rem;
            margin-bottom: 2rem;
            animation: fadeInUp 0.6s ease-out 0.5s both;
        }

        .success-subtext {
            font-size: 0.9rem;
            color: #9ca3af;
            margin-bottom: 2rem;
            padding: 1rem;
            background: #f9fafb;
            border-radius: 8px;
            border-left: 4px solid #10b981;
            animation: fadeInUp 0.6s ease-out 0.6s both;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            animation: fadeInUp 0.6s ease-out 0.7s both;
        }

        .button {
            padding: 0.875rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
            cursor: pointer;
            border: none;
        }

        .button-primary {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
        }

        .button-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 15px -3px rgba(16, 185, 129, 0.3);
        }

        .button-outline {
            background: transparent;
            color: #6b7280;
            border: 2px solid #e5e7eb;
        }

        .button-outline:hover {
            border-color: #10b981;
            color: #10b981;
            transform: translateY(-1px);
        }

        .decorative-elements {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            pointer-events: none;
            overflow: hidden;
        }

        .decorative-circle {
            position: absolute;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(5, 150, 105, 0.05));
        }

        .circle-1 {
            width: 100px;
            height: 100px;
            top: -50px;
            right: -50px;
            animation: float 6s ease-in-out infinite;
        }

        .circle-2 {
            width: 60px;
            height: 60px;
            bottom: -30px;
            left: -30px;
            animation: float 8s ease-in-out infinite reverse;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes checkmark {
            0% {
                opacity: 0;
                transform: scale(0.5) rotate(-45deg);
            }
            50% {
                opacity: 1;
                transform: scale(1.1) rotate(0deg);
            }
            100% {
                opacity: 1;
                transform: scale(1) rotate(0deg);
            }
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        @media (max-width: 640px) {
            .success-card {
                padding: 2rem 1.5rem;
            }

            .success-title {
                font-size: 1.5rem;
            }

            .success-text {
                font-size: 1rem;
            }

            .button-group {
                flex-direction: column;
            }
        }

        @media (min-width: 640px) {
            .button-group {
                flex-direction: row;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-card">
            <div class="decorative-elements">
                <div class="decorative-circle circle-1"></div>
                <div class="decorative-circle circle-2"></div>
            </div>
            
            <svg class="success-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            
            <h1 class="success-title">Đơn ứng tuyển đã được nộp thành công!</h1>
            
            <p class="success-text">
                Cảm ơn bạn đã ứng tuyển vào vị trí này. Chúng tôi đã nhận được hồ sơ của bạn và sẽ xem xét trong thời gian sớm nhất.
            </p>
            
            <div class="success-subtext">
                <strong>Bước tiếp theo:</strong> Nhà tuyển dụng sẽ liên hệ với bạn qua email hoặc điện thoại trong vòng 3-5 ngày làm việc.
            </div>
            
            <div class="button-group">
                <a href="HomePage" class="button button-primary">
                    <svg width="16" height="16" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/>
                    </svg>
                    Về trang chủ
                </a>
                <a href="AdvancedJobSearch" class="button button-outline">
                    <svg width="16" height="16" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                    </svg>
                    Về trang tìm việc
                </a>
            </div>
        </div>
    </div>

    <script>
        // Add some interactive feedback
        document.addEventListener('DOMContentLoaded', function() {
            // Add click feedback to buttons
            const buttons = document.querySelectorAll('.button');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    // Create ripple effect
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.cssText = `
                        position: absolute;
                        width: ${size}px;
                        height: ${size}px;
                        left: ${x}px;
                        top: ${y}px;
                        background: rgba(255, 255, 255, 0.3);
                        border-radius: 50%;
                        transform: scale(0);
                        animation: ripple 0.6s linear;
                        pointer-events: none;
                    `;
                    
                    this.style.position = 'relative';
                    this.style.overflow = 'hidden';
                    this.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
        });

        // Add ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
