
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Modern Error Page</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                line-height: 1.6;
                color: #374151;
            }

            .container {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 1rem;
                background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
            }

            .card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                width: 100%;
                max-width: 28rem;
                padding: 2rem;
            }

            .error-content {
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
                gap: 1.5rem;
            }

            .error-icon {
                width: 4rem;
                height: 4rem;
                background-color: #fef2f2;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .error-icon svg {
                width: 2rem;
                height: 2rem;
                color: #dc2626;
            }

            .error-text h1 {
                font-size: 1.5rem;
                font-weight: 700;
                color: #111827;
                margin-bottom: 0.5rem;
            }

            .error-text p {
                color: #6b7280;
                line-height: 1.6;
            }

            .button-group {
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
                width: 100%;
            }

            @media (min-width: 640px) {
                .button-group {
                    flex-direction: row;
                }
            }

            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                padding: 0.625rem 1rem;
                border-radius: 6px;
                font-size: 0.875rem;
                font-weight: 500;
                text-decoration: none;
                border: none;
                cursor: pointer;
                transition: all 0.2s;
                flex: 1;
            }

            .btn-primary {
                background-color: #3b82f6;
                color: white;
            }

            .btn-primary:hover {
                background-color: #2563eb;
            }

            .btn-secondary {
                background-color: white;
                color: #374151;
                border: 1px solid #d1d5db;
            }

            .btn-secondary:hover {
                background-color: #f9fafb;
            }

            .help-text {
                font-size: 0.875rem;
                color: #9ca3af;
            }

            .demo-container {
                background: #f9fafb;
                padding: 2rem;
                border-radius: 12px;
                margin-bottom: 2rem;
            }

            .demo-form {
                display: flex;
                flex-direction: column;
                gap: 1rem;
                max-width: 32rem;
                margin: 0 auto;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .form-label {
                font-weight: 500;
                color: #374151;
            }

            .form-input, .form-textarea {
                padding: 0.625rem;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                font-size: 0.875rem;
            }

            .form-input:focus, .form-textarea:focus {
                outline: none;
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            }

            .checkbox-group {
                display: flex;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .checkbox-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .checkbox-item input[type="checkbox"] {
                width: 1rem;
                height: 1rem;
            }

            .checkbox-item label {
                font-size: 0.875rem;
                color: #374151;
            }

            .hidden {
                display: none;
            }

            .demo-title {
                text-align: center;
                font-size: 1.5rem;
                font-weight: 700;
                color: #111827;
                margin-bottom: 0.5rem;
            }

            .demo-description {
                text-align: center;
                color: #6b7280;
                margin-bottom: 1.5rem;
            }
        </style>
    </head>
    <body>
        <div id="error-section" class="container">
            <div class="card">
                <div class="error-content">
                    <!-- Error Icon -->
                    <div class="error-icon">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                        </svg>
                    </div>

                    <!-- Error Content -->
                    <div class="error-text">
                        <h1 id="display-title">Đã xảy ra lỗi</h1>
                        <p id="display-message">${errorMessage}</p>
                    </div>

                    <!-- Action Buttons -->
                    <div class="button-group">
                        <a href="HomePage" class="btn btn-secondary">
                            
                                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                                </svg>
                                Trở về trang chủ
                        </a>
                    </div>

                </div>
            </div>
        </div>

    </body>
</html>