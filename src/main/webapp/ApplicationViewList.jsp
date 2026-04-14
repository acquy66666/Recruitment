<%-- 
    Document   : ApplicationViewList
    Created on : Jun 9, 2025, 9:59:27 PM
    Author     : GBCenter
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VietnamWork - Quản lý tuyển dụng</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Inter', sans-serif;
            }

            body {
                background-color: #f9fafb;
                color: #1f2937;
                line-height: 1.5;
            }

            .container {
                max-width: 1280px;
                margin: 0 auto;
                padding: 0 1rem;
            }

            header {
                background-color: white;
                border-bottom: 1px solid #e5e7eb;
            }

            .header-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
                height: 64px;
            }

            .logo {
                font-size: 1.5rem;
                font-weight: bold;
                color: #2563eb;
            }

            nav {
                display: flex;
                margin-left: 2.5rem;
            }

            nav a {
                margin-right: 2rem;
                text-decoration: none;
                color: #1f2937;
            }

            nav a:hover {
                color: #2563eb;
            }

            nav a.active {
                color: #2563eb;
                font-weight: 500;
            }

            .account-btn {
                display: flex;
                align-items: center;
                padding: 0.5rem 1rem;
                border: 1px solid #e5e7eb;
                border-radius: 0.375rem;
                background-color: white;
                font-size: 0.875rem;
                cursor: pointer;
            }

            .account-btn:hover {
                background-color: #f9fafb;
            }

            .icon {
                width: 16px;
                height: 16px;
                margin-right: 0.5rem;
            }

            .main-content {
                padding: 2rem 0;
            }

            .card {
                background-color: white;
                border-radius: 0.5rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-bottom: 1.5rem;
            }

            .card-header {
                padding: 1.5rem;
                border-bottom: 1px solid #f3f4f6;
            }

            .card-content {
                padding: 1.5rem;
            }

            .job-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #2563eb;
                margin-bottom: 0.5rem;
            }

            .company-name {
                font-weight: 500;
                margin-bottom: 0.5rem;
            }

            .job-meta {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: 1rem;
                font-size: 0.875rem;
                color: #4b5563;
            }

            .job-meta-item {
                display: flex;
                align-items: center;
            }

            .badge {
                display: inline-flex;
                align-items: center;
                padding: 0.25rem 0.75rem;
                border-radius: 9999px;
                font-size: 0.75rem;
                font-weight: 500;
            }

            .badge-outline {
                border: 1px solid #10b981;
                color: #10b981;
            }

            .badge-blue {
                background-color: #dbeafe;
                color: #1e40af;
            }

            .badge-yellow {
                background-color: #fef3c7;
                color: #92400e;
            }

            .badge-green {
                background-color: #d1fae5;
                color: #065f46;
            }

            .badge-purple {
                background-color: #ede9fe;
                color: #5b21b6;
            }

            .badge-red {
                background-color: #fee2e2;
                color: #b91c1c;
            }

            .badge-gray {
                background-color: #f3f4f6;
                color: #4b5563;
            }

            .job-count {
                text-align: right;
            }

            .job-count-number {
                font-size: 1.5rem;
                font-weight: 700;
                color: #2563eb;
            }

            .job-count-label {
                font-size: 0.875rem;
                color: #6b7280;
            }

            .search-container {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }

            @media (min-width: 768px) {
                .search-container {
                    flex-direction: row;
                }
            }

            .search-box {
                position: relative;
                flex: 1;
            }

            .search-input {
                width: 100%;
                padding: 0.5rem 0.75rem 0.5rem 2.5rem;
                border: 1px solid #d1d5db;
                border-radius: 0.375rem;
                font-size: 0.875rem;
            }

            .search-icon {
                position: absolute;
                left: 0.75rem;
                top: 50%;
                transform: translateY(-50%);
                color: #9ca3af;
            }

            .filter-select {
                width: 100%;
                padding: 0.5rem 0.75rem;
                border: 1px solid #d1d5db;
                border-radius: 0.375rem;
                background-color: white;
                font-size: 0.875rem;
                cursor: pointer;
            }

            @media (min-width: 768px) {
                .filter-select {
                    width: 12rem;
                }
            }

            .tabs {
                display: grid;
                grid-template-columns: repeat(6, 1fr);
                gap: 0.5rem;
                margin-bottom: 1.5rem;
            }

            .tab {
                padding: 0.5rem;
                text-align: center;
                background-color: white;
                border: 1px solid #e5e7eb;
                border-radius: 0.375rem;
                cursor: pointer;
                font-size: 0.875rem;
            }

            .tab.active {
                background-color: #2563eb;
                color: white;
                border-color: #2563eb;
            }

            .application-list {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }

            .application-card {
                padding: 1.5rem;
                transition: box-shadow 0.3s ease;
            }

            .application-card:hover {
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            }

            .application-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 0.5rem;
            }

            .applicant-info {
                display: flex;
                gap: 1rem;
                flex: 1;
            }

            .avatar {
                width: 3rem;
                height: 3rem;
                border-radius: 9999px;
                background-color: #e5e7eb;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                color: #4b5563;
                overflow: hidden;
            }

            .avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .applicant-details {
                flex: 1;
                min-width: 0;
            }

            .applicant-name {
                font-size: 1.125rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .applicant-summary {
                color: #4b5563;
                font-size: 0.875rem;
                margin-bottom: 0.75rem;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .contact-grid {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1rem;
                font-size: 0.875rem;
                color: #4b5563;
                margin-bottom: 1rem;
            }

            @media (min-width: 768px) {
                .contact-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (min-width: 1024px) {
                .contact-grid {
                    grid-template-columns: repeat(4, 1fr);
                }
            }

            .contact-item {
                display: flex;
                align-items: center;
            }

            .skills-container {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                margin-bottom: 1rem;
            }

            .skill-badge {
                background-color: #f3f4f6;
                padding: 0.25rem 0.5rem;
                border-radius: 0.25rem;
                font-size: 0.75rem;
            }

            .details-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
                font-size: 0.875rem;
            }

            @media (min-width: 768px) {
                .details-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
            }

            .detail-label {
                color: #6b7280;
            }

            .detail-value {
                font-weight: 500;
                margin-left: 0.5rem;
            }

            .salary {
                color: #10b981;
            }

            .action-buttons {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
                margin-left: 1rem;
            }

            .btn {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 0.5rem 1rem;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
                cursor: pointer;
                white-space: nowrap;
            }

            .btn-primary {
                background-color: #2563eb;
                color: white;
                border: none;
            }

            .btn-primary:hover {
                background-color: #1d4ed8;
            }

            .btn-outline {
                background-color: white;
                color: #1f2937;
                border: 1px solid #d1d5db;
            }

            .btn-outline:hover {
                background-color: #f9fafb;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 0;
            }

            .empty-icon {
                width: 3rem;
                height: 3rem;
                margin: 0 auto 1rem;
                opacity: 0.5;
            }

            .empty-title {
                font-size: 1.125rem;
                margin-bottom: 0.5rem;
            }

            .empty-message {
                font-size: 0.875rem;
                color: #6b7280;
            }

            .hidden {
                display: none;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header>
            <div class="container">
                <div class="header-content">
                    <div style="display: flex; align-items: center;">
                        <div class="logo">VietnamWork</div>
                        <nav>
                            <a href="#">Trang chủ</a>
                            <a href="#" class="active">Quản lý tuyển dụng</a>
                            <a href="#">Đăng tin</a>
                            <a href="#">Báo cáo</a>
                        </nav>
                    </div>
                    <button class="account-btn">
                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                        Tài khoản
                    </button>
                </div>
            </div>
        </header>

        <main class="main-content">
            <div class="container">
                <!-- Job Info Card -->
                <div class="card">
                    <div class="card-header">
                        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                            <div>
                                <h1 class="job-title">${job.title}</h1>
                                <p class="company-name">${rec.companyName}</p>
                                <div class="job-meta">
                                    <span class="job-meta-item">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                        <circle cx="12" cy="10" r="3"></circle>
                                        </svg>
                                        ${job.location}
                                    </span>
                                    <span class="job-meta-item">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                        <line x1="16" y1="2" x2="16" y2="6"></line>
                                        <line x1="8" y1="2" x2="8" y2="6"></line>
                                        <line x1="3" y1="10" x2="21" y2="10"></line>
                                        </svg>
                                        Đăng: <fmt:parseDate value="${job.createdAt}" pattern="yyyy-MM-dd" var="createdDate"/>
                                        <fmt:formatDate value="${createdDate}" pattern="dd/MM/yyyy"/>
                                    </span>
                                    <span class="badge badge-outline">${job.status}</span>
                                </div>
                            </div>
                            <div class="job-count">
                                <div class="job-count-number">${appList.size()}</div>
                                <div class="job-count-label">Ứng viên</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Filters -->
                <div class="card">
                    <div class="card-content">
                        <div class="search-container">
                            <div class="search-box">
                                <svg class="search-icon icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="11" cy="11" r="8"></circle>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                </svg>
                                <input type="text" id="searchInput" class="search-input" placeholder="Tìm kiếm theo tên, email, kỹ năng...">
                            </div>
                            <select id="statusFilter" class="filter-select">
                                <option value="all">Tất cả trạng thái</option>
                                <option value="new">Mới</option>
                                <option value="reviewed">Đã xem</option>
                                <option value="shortlisted">Lọc sơ bộ</option>
                                <option value="interviewed">Phỏng vấn</option>
                                <option value="rejected">Từ chối</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Applications List -->
                <div class="application-list">
                    <!-- Application -->
                    <c:forEach items="${appList}" var="ap">
                        <div class="card application-card" data-status="new">
                            <div style="display: flex; justify-content: space-between;">
                                <div class="applicant-info">
                                    <div class="avatar">
                                        <img src="${ap.candidate.imageUrl}">
                                    </div>
                                    <div class="applicant-details">
                                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                                            <h3 class="applicant-name">${ap.candidate.fullName}</h3>
                                            <span class="badge badge-blue">
                                                <svg class="icon" style="width: 12px; height: 12px; margin-right: 4px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="10"></circle>
                                                <polyline points="12 6 12 12 16 14"></polyline>
                                                </svg>
                                                ${ap.status}
                                            </span>
                                        </div>
                                        <!-- Dự tính add cái tên cv hoặc nội dung cv-->
                                        <p class="applicant-summary"></p>
                                        <div class="contact-grid">
                                            <div class="contact-item">
                                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                                <polyline points="22,6 12,13 2,6"></polyline>
                                                </svg>
                                                ${ap.candidate.email}
                                            </div>
                                            <div class="contact-item">
                                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                                                </svg>
                                                ${ap.candidate.phone}
                                            </div>
                                            <div class="contact-item">
                                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                                <circle cx="12" cy="10" r="3"></circle>
                                                </svg>
                                                ${ap.candidate.address}
                                            </div>
                                            <div class="contact-item">
                                                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                                <line x1="3" y1="10" x2="21" y2="10"></line>
                                                </svg>
                                                <fmt:parseDate value="${ap.appliedAt}" pattern="yyyy-MM-dd" var="appliedDate"/>
                                                <fmt:formatDate value="${appliedDate}" pattern="dd/MM/yyyy"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="action-buttons">
                                    <button class="btn btn-primary">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                        <circle cx="12" cy="12" r="3"></circle>
                                        </svg>
                                        Xem hồ sơ
                                    </button>
                                    <button class="btn btn-outline">
                                        <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                        <polyline points="7 10 12 15 17 10"></polyline>
                                        <line x1="12" y1="15" x2="12" y2="3"></line>
                                        </svg>
                                        Tải CV
                                    </button>
                                </div>
                            </div>
                        </div>     
                    </c:forEach>

                    <!-- Empty State (hidden by default) -->
                    <div id="emptyState" class="card hidden">
                        <div class="card-content empty-state">
                            <svg class="empty-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                            </svg>
                            <h3 class="empty-title">Không tìm thấy ứng viên nào</h3>
                            <p class="empty-message">Thử thay đổi từ khóa tìm kiếm hoặc bộ lọc</p>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script>
            // Filter functionality
            const searchInput = document.getElementById('searchInput');
            const statusFilter = document.getElementById('statusFilter');
            const applicationCards = document.querySelectorAll('.application-card');
            const emptyState = document.getElementById('emptyState');

            function filterApplications() {
                const searchTerm = searchInput.value.replace(/\s+/g, ' ').trim().toLowerCase();
                const statusValue = statusFilter.value;
                let visibleCount = 0;

                applicationCards.forEach(card => {
                    const cardStatus = card.dataset.status;
                    const cardText = card.textContent.toLowerCase();

                    const matchesSearch = searchTerm === '' || cardText.includes(searchTerm);
                    const matchesStatus = statusValue === 'all' || cardStatus === statusValue;

                    if (matchesSearch && matchesStatus) {
                        card.style.display = 'block';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                // Show empty state if no results
                if (visibleCount === 0) {
                    emptyState.classList.remove('hidden');
                } else {
                    emptyState.classList.add('hidden');
                }
            }

            // Add event listeners
            searchInput.addEventListener('input', filterApplications);
            statusFilter.addEventListener('change', filterApplications);

            // Initialize
            filterApplications();
        </script>
    </body>
</html>