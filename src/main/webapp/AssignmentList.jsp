<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bài tập cần hoàn thành - JobHub</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
        <style>
            /* Reset and base styles */
            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            body {
                font-family: 'Inter', sans-serif;
                line-height: 1.5;
                color: #333;
                background-color: #f5f5f5;
            }
            a {
                color: inherit;
                text-decoration: none;
            }
            /* Layout */
            .container {
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 1rem;
            }
            .min-h-screen {
                min-height: 100vh;
            }
            .bg-gradient-to-br {
                background: linear-gradient(to bottom right, #1a56db, #38bdf8);
            }
            /* Header */
            header {
                background-color: white;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }
            .header-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 1rem;
            }
            .logo-nav {
                display: flex;
                align-items: center;
                gap: 2rem;
            }
            .logo {
                color: #1a56db;
                font-size: 1.5rem;
                font-weight: 700;
            }
            nav {
                display: none;
            }
            @media (min-width: 768px) {
                nav {
                    display: flex;
                    gap: 1.5rem;
                }
            }
            nav a {
                color: #4b5563;
            }
            nav a:hover {
                color: #1a56db;
            }
            nav a.active {
                color: #1a56db;
                font-weight: 500;
            }
            /* Buttons */
            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 0.375rem;
                font-weight: 500;
                padding: 0.5rem 1rem;
                cursor: pointer;
                transition: all 0.2s;
                border: none;
                text-decoration: none;
            }
            .btn-primary {
                background-color: #1a56db;
                color: white;
            }
            .btn-primary:hover {
                background-color: #1e429f;
            }
            .btn-outline {
                background-color: transparent;
                color: #1a56db;
                border: 1px solid #d1d5db;
            }
            .btn-outline:hover {
                background-color: #f3f4f6;
            }
            .btn-success {
                background-color: #10b981;
                color: white;
            }
            .btn-success:hover {
                background-color: #059669;
            }
            .btn-warning {
                background-color: #f59e0b;
                color: white;
            }
            .btn-warning:hover {
                background-color: #d97706;
            }
            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
            }
            /* Page header */
            .page-header {
                padding: 2rem 0;
                color: white;
            }
            .page-title {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }
            .page-description {
                font-size: 1.125rem;
                opacity: 0.9;
            }
            /* Main content */
            .main-content {
                padding: 2rem 0;
            }
            /* Cards */
            .card {
                background-color: white;
                border-radius: 0.5rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                margin-bottom: 1.5rem;
            }
            .card-header {
                padding: 1.25rem 1.5rem;
                border-bottom: 1px solid #e5e7eb;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .card-title {
                font-size: 1.25rem;
                font-weight: 600;
            }
            .card-content {
                padding: 1.5rem;
            }
            /* Filters */
            .filters {
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
                margin-bottom: 1.5rem;
                align-items: center;
            }
            .filter-select {
                padding: 0.5rem 2rem 0.5rem 0.75rem;
                border-radius: 0.375rem;
                border: 1px solid #d1d5db;
                background-color: white;
                font-size: 0.875rem;
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%236b7280'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 0.5rem center;
                background-size: 1rem;
            }
            /* Search input */
            .search-container {
                position: relative;
                flex-grow: 1;
                min-width: 200px;
                max-width: 400px;
            }
            .search-input {
                padding: 0.5rem 0.75rem;
                border-radius: 0.375rem;
                border: 1px solid #d1d5db;
                font-size: 0.875rem;
                width: 100%;
                transition: border-color 0.2s;
            }
            .search-input:focus {
                outline: none;
                border-color: #1a56db;
                box-shadow: 0 0 0 2px rgba(26, 86, 219, 0.1);
            }
            .search-button {
                background-color: #1a56db;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 0.375rem;
                cursor: pointer;
                transition: background-color 0.2s ease;
                color: white;
                font-size: 0.875rem;
            }
            .search-button:hover {
                background-color: #1e429f;
            }
            /* Results counter */
            .results-counter {
                font-size: 0.875rem;
                color: #6b7280;
                margin-bottom: 1rem;
                padding-left: 1.5rem;
            }
            /* Assignment list */
            .assignment-list {
                margin-top: 1.5rem;
            }
            .assignment-item {
                display: flex;
                flex-direction: column;
                padding: 1.5rem;
                border-bottom: 1px solid #e5e7eb;
                position: relative;
            }
            @media (min-width: 768px) {
                .assignment-item {
                    flex-direction: row;
                    align-items: center;
                }
            }
            .assignment-item:last-child {
                border-bottom: none;
            }
            .assignment-icon {
                width: 3.5rem;
                height: 3.5rem;
                background-color: #f3f4f6;
                border-radius: 0.375rem;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 1rem;
                flex-shrink: 0;
            }
            @media (min-width: 768px) {
                .assignment-icon {
                    margin-bottom: 0;
                    margin-right: 1.5rem;
                }
            }
            .assignment-info {
                flex-grow: 1;
                margin-bottom: 1rem;
            }
            @media (min-width: 768px) {
                .assignment-info {
                    margin-bottom: 0;
                    margin-right: 1.5rem;
                }
            }
            .assignment-title {
                font-weight: 600;
                font-size: 1.125rem;
                margin-bottom: 0.25rem;
            }
            .assignment-company {
                color: #1a56db;
                font-size: 0.875rem;
                margin-bottom: 0.5rem;
            }
            .assignment-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
                font-size: 0.875rem;
                color: #6b7280;
            }
            .assignment-meta-item {
                display: flex;
                align-items: center;
            }
            .assignment-meta-item svg {
                margin-right: 0.25rem;
                color: #6b7280;
            }
            .assignment-status {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                margin-bottom: 1rem;
            }
            @media (min-width: 768px) {
                .assignment-status {
                    align-items: center;
                    margin-bottom: 0;
                    margin-right: 1.5rem;
                }
            }
            .status-badge {
                padding: 0.25rem 0.75rem;
                border-radius: 9999px;
                font-size: 0.75rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                margin-bottom: 0.25rem;
            }
            .status-badge-pending {
                background-color: #fef3c7;
                color: #92400e;
            }
            .status-badge-in-progress {
                background-color: #e0f2fe;
                color: #0369a1;
            }
            .status-badge-completed {
                background-color: #dcfce7;
                color: #166534;
            }
            .status-badge-overdue {
                background-color: #fee2e2;
                color: #b91c1c;
            }
            .priority-badge {
                padding: 0.125rem 0.5rem;
                border-radius: 0.25rem;
                font-size: 0.75rem;
                font-weight: 500;
            }
            .priority-high {
                background-color: #fee2e2;
                color: #b91c1c;
            }
            .priority-medium {
                background-color: #fef3c7;
                color: #92400e;
            }
            .priority-low {
                background-color: #dcfce7;
                color: #166534;
            }
            .due-date {
                font-size: 0.75rem;
                color: #6b7280;
            }
            .assignment-actions {
                display: flex;
                gap: 0.5rem;
                flex-wrap: wrap;
            }
            /* Progress bar */
            .progress-container {
                width: 100%;
                background-color: #e5e7eb;
                border-radius: 0.25rem;
                height: 0.5rem;
                margin-top: 0.5rem;
            }
            .progress-bar {
                height: 100%;
                border-radius: 0.25rem;
                transition: width 0.3s ease;
            }
            .progress-bar-pending {
                background-color: #f59e0b;
                width: 0%;
            }
            .progress-bar-in-progress {
                background-color: #3b82f6;
                width: 50%;
            }
            .progress-bar-completed {
                background-color: #10b981;
                width: 100%;
            }
            .progress-bar-overdue {
                background-color: #ef4444;
                width: 25%;
            }
            /* Footer */
            footer {
                background-color: #1f2937;
                color: white;
                padding: 2rem 0;
                margin-top: 3rem;
            }
            .footer-grid {
                display: grid;
                grid-template-columns: 1fr;
                gap: 2rem;
            }
            @media (min-width: 768px) {
                .footer-grid {
                    grid-template-columns: repeat(4, 1fr);
                }
            }
            .footer-heading {
                font-size: 1.25rem;
                font-weight: 700;
                margin-bottom: 1rem;
            }
            .footer-text {
                color: #d1d5db;
            }
            .footer-links {
                list-style: none;
                padding: 0;
            }
            .footer-links li {
                margin-bottom: 0.5rem;
            }
            .footer-links a {
                color: #d1d5db;
            }
            .footer-links a:hover {
                color: white;
            }
            .footer-contact {
                list-style: none;
                padding: 0;
            }
            .footer-contact li {
                color: #d1d5db;
                margin-bottom: 0.5rem;
            }
            .footer-bottom {
                border-top: 1px solid #374151;
                margin-top: 2rem;
                padding-top: 1.5rem;
                text-align: center;
                color: #9ca3af;
            }
            /* Icons */
            .icon {
                display: inline-block;
                width: 1.25rem;
                height: 1.25rem;
                stroke-width: 2;
                stroke: currentColor;
                fill: none;
                vertical-align: middle;
            }
            .icon-sm {
                width: 1rem;
                height: 1rem;
            }
            .icon-lg {
                width: 2rem;
                height: 2rem;
            }
        </style>
    </head>
    <body>
        <div class="min-h-screen">
            <header>
                <div class="container header-container">
                    <div class="logo-nav">
                        <a href="/" class="logo">JobHub</a>
                        <nav>
                            <a href="/">Trang chủ</a>
                            <a href="/jobs">Tìm việc làm</a>
                            <a href="/companies">Công ty</a>
                            <a href="/assignments" class="active">Bài tập</a>
                            <a href="/news">Tin tức</a>
                            <a href="/services">Dịch vụ ▼</a>
                        </nav>
                    </div>
                </div>
            </header>

            <div class="bg-gradient-to-br">
                <div class="container page-header">
                    <h1 class="page-title">Bài thi cần hoàn thành</h1>
                    <p class="page-description">Quản lý và theo dõi các bài thi từ nhà tuyển dụng</p>
                </div>
            </div>

            <main class="container main-content">
                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">Danh sách bài thi</h2>
                        <div>
                            <a href="TestHistory" class="btn btn-outline btn-sm">Lịch sử bài làm</a>
                        </div>
                    </div>
                    <div class="card-content">


                        <div class="results-counter">
                            Hiển thị <span id="results-count">${count}</span> kết quả
                        </div>
                        <div class="assignment-list" id="assignment-list">
                            <c:forEach var="item" items="${list}">
                                <div class="assignment-item" data-status="pending" data-priority="high" data-type="coding">
                                    <div class="assignment-icon">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-lg">
                                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                        <polyline points="14,2 14,8 20,8"></polyline>
                                        <line x1="16" y1="13" x2="8" y2="13"></line>
                                        <line x1="16" y1="17" x2="8" y2="17"></line>
                                        <polyline points="10,9 9,9 8,9"></polyline>
                                        </svg>
                                    </div>
                                    <div class="assignment-info">
                                        <h3 class="assignment-title">${item.title}</h3>
                                        <div class="assignment-company">${item.description}</div>
                                        <div class="assignment-meta">
                                            <div class="assignment-meta-item">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm">
                                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                                <line x1="3" y1="10" x2="21" y2="10"></line>
                                                </svg>
                                                <span>Hạn: ${item.dueDate}</span>
                                            </div>
                                            <div class="assignment-meta-item">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm">
                                                <circle cx="12" cy="12" r="10"></circle>
                                                <polyline points="12,6 12,12 16,14"></polyline>
                                                </svg>
                                                <span>Thời gian: 3 ngày</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="assignment-actions">
                                        <form action="TakingTest" method="GET">
                                            <input hidden value="${item.assignmentId}" name="assignmentId">
                                            <button type="submit" class="btn btn-primary btn-lg">Bắt đầu làm</button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </div>
                </div>
            </main>

            <footer>
                <div class="container">
                    <div class="footer-grid">
                        <div>
                            <h3 class="footer-heading">JobHub</h3>
                            <p class="footer-text">
                                Kết nối với hơn 50,000+ cơ hội việc làm từ các công ty hàng đầu tại Việt Nam.
                            </p>
                        </div>
                        <div>
                            <h4 class="font-semibold mb-4">Dành cho ứng viên</h4>
                            <ul class="footer-links">
                                <li><a href="#">Tìm việc làm</a></li>
                                <li><a href="#">Tạo CV</a></li>
                                <li><a href="#">Cẩm nang nghề nghiệp</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-semibold mb-4">Dành cho nhà tuyển dụng</h4>
                            <ul class="footer-links">
                                <li><a href="#">Đăng tin tuyển dụng</a></li>
                                <li><a href="#">Tìm hồ sơ ứng viên</a></li>
                                <li><a href="#">Giải pháp tuyển dụng</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-semibold mb-4">Liên hệ</h4>
                            <ul class="footer-contact">
                                <li>Email: contact@jobhub.vn</li>
                                <li>Hotline: 1900 1234</li>
                                <li>Địa chỉ: Quận 1, TP. Hồ Chí Minh</li>
                            </ul>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>© 2025 JobHub. Tất cả quyền được bảo lưu.</p>
                    </div>
                </div>
            </footer>
        </div>

        <script>

        </script>
    </body>
</html>
