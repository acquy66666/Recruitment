<%-- 
    Document   : AppliedListPage
    Created on : May 25, 2025, 11:49:43 PM
    Author     : GBCenter
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Việc làm đã ứng tuyển - JobHub</title>
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

            .auth-buttons {
                display: flex;
                gap: 0.75rem;
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
            }

            .btn-primary {
                background-color: #1a56db;
                color: white;
                border: none;
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

            .btn-ghost {
                background-color: transparent;
                color: white;
                border: none;
            }

            .btn-ghost:hover {
                background-color: rgba(255, 255, 255, 0.1);
            }

            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
            }

            .btn-icon {
                padding: 0.5rem;
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

            /* Search input and container */
            .search-container {
                position: relative;
                flex-grow: 1;
                min-width: 200px;
            }

            .search-input {
                padding: 0.5rem 2.5rem 0.5rem 0.75rem;
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

            .search-icon {
                position: absolute;
                right: 0.75rem;
                top: 50%;
                transform: translateY(-50%);
                color: #6b7280;
                pointer-events: none;
            }

            .search-clear {
                position: absolute;
                right: 0.75rem;
                top: 50%;
                transform: translateY(-50%);
                color: #6b7280;
                background: none;
                border: none;
                cursor: pointer;
                padding: 0.25rem;
                display: none;
            }

            .search-clear:hover {
                color: #1f2937;
            }

            .search-clear.visible {
                display: block;
            }

            /* Results counter */
            .results-counter {
                font-size: 20px;
                color: #6b7280;
                margin-top: 0.5rem;
                margin-bottom: 1rem;
                margin-left: 40px;
                display: none;
            }

            .results-counter.visible {
                display: block;
            }

            /* Job list */
            .job-list {
                margin-top: 1.5rem;
            }

            .job-item {
                display: flex;
                flex-direction: column;
                padding: 1.5rem;
                border-bottom: 1px solid #e5e7eb;
            }

            @media (min-width: 768px) {
                .job-item {
                    flex-direction: row;
                    align-items: center;
                }
            }

            .job-item:last-child {
                border-bottom: none;
            }

            .job-logo {
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
                .job-logo {
                    margin-bottom: 0;
                    margin-right: 1.5rem;
                }
            }

            .job-info {
                flex-grow: 1;
                margin-bottom: 1rem;
            }

            @media (min-width: 768px) {
                .job-info {
                    margin-bottom: 0;
                    margin-right: 1.5rem;
                }
            }

            .job-title {
                font-weight: 600;
                font-size: 1.125rem;
                margin-bottom: 0.25rem;
            }

            .job-company {
                color: #1a56db;
                font-size: 0.875rem;
                margin-bottom: 0.5rem;
            }

            .job-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
                font-size: 0.875rem;
                color: #6b7280;
            }

            .job-meta-item {
                display: flex;
                align-items: center;
            }

            .job-meta-item svg {
                margin-right: 0.25rem;
                color: #6b7280;
            }

            .job-status {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                margin-bottom: 1rem;
            }

            @media (min-width: 768px) {
                .job-status {
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
            }

            .status-badge-Pending {
                background-color: #fef3c7;
                color: #92400e;
            }

            .status-badge-Testing {
                background-color: #e0f2fe;
                color: #0369a1;
            }

            .status-badge-Interview {
                background-color: #fff9db;
                color: #7a5f00;
            }

            .status-badge-Accepted {
                background-color: #dcfce7;
                color: #166534;
            }

            .status-badge-Rejected {
                background-color: #fee2e2;
                color: #b91c1c;
            }

            .status-badge-Canceled {
                background-color: #fee2e2;
                color: #b91c1c;
            }

            .status-date {
                font-size: 0.75rem;
                color: #6b7280;
                margin-top: 0.25rem;
            }

            .job-actions {
                display: flex;
                gap: 0.5rem;
            }

            /* Pagination */
            .pagination {
                display: flex;
                margin-top: 2rem;
                margin-bottom: 2rem;
                gap: 0.25rem;
                justify-content: center;
            }

            .pagination-item {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 2.25rem;
                height: 2.25rem;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                color: #4b5563;
                border: 1px solid #d1d5db;
            }

            .pagination-item:hover {
                background-color: #f3f4f6;
            }

            .pagination-item.active {
                background-color: #1a56db;
                color: white;
                border-color: #1a56db;
            }

            .pagination-item.disabled {
                color: #d1d5db;
                pointer-events: none;
            }

            /* Empty state */
            .empty-state {
                text-align: center;
                padding: 3rem 1.5rem;
                display: none;
            }

            .empty-state.visible {
                display: block;
            }

            .empty-state-icon {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 4rem;
                height: 4rem;
                border-radius: 9999px;
                background-color: #f3f4f6;
                color: #6b7280;
                margin-bottom: 1.5rem;
            }

            .empty-state-title {
                font-size: 1.25rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
            }

            .empty-state-description {
                color: #6b7280;
                max-width: 24rem;
                margin: 0 auto 1.5rem;
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
                stroke-width: 0;
                stroke: currentColor;
                fill: currentColor;
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

            /* Highlight search results */
            .highlight {
                background-color: #fef3c7;
                padding: 0 0.125rem;
                border-radius: 0.125rem;
            }

            .search-button {
                background-color: #1a56db;
                border: none;
                padding: 0.5rem;
                border-radius: 0.375rem;
                cursor: pointer;
                transition: background-color 0.2s ease;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                color: white;
            }

            .search-button:hover {
                background-color: #1e429f;
            }

            .search-icon {
                width: 20px;
                height: 20px;
                stroke: white;
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
                            <a href="/news">Tin tức</a>
                            <a href="/services">Dịch vụ ▼</a>
                        </nav>
                    </div>
                </div>
            </header>

            <div class="bg-gradient-to-br">
                <div class="container page-header">
                    <h1 class="page-title">Việc làm đã ứng tuyển</h1>
                    <p class="page-description">Theo dõi trạng thái ứng tuyển và quản lý hồ sơ của bạn</p>
                </div>
            </div>

            <main class="container main-content">
                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">Danh sách ứng tuyển</h2>
                        <div id="total-counter">
                            <span>Tổng số: <span id="total-count">${data.size()}</span> việc làm</span>
                        </div>
                    </div>
                    <div class="card-content">
                        <form action="AppliedListPage" method="post" class="search-filter-form">
                            <div class="filters" style="align-items: center; flex-wrap: wrap; gap: 1rem;">
                                <!-- Status Filter -->
                                <select class="filter-select" name="status">
                                    <option value="All" ${status == 'All' ? 'selected' : ''}>Tất cả trạng thái</option>
                                    <option value="Pending" ${status == 'Pending' ? 'selected' : ''}>Đang chờ</option>
                                    <option value="Reviewing" ${status == 'Reviewing' ? 'selected' : ''}>Đang xem xét</option>
                                    <option value="Interview" ${status == 'Interview' ? 'selected' : ''}>Phỏng vấn</option>
                                    <option value="Rejected" ${status == 'Rejected' ? 'selected' : ''}>Từ chối</option>
                                    <option value="Accepted" ${status == 'Accepted' ? 'selected' : ''}>Chấp nhận</option>
                                </select>

                                <!-- Time Filter -->
                                <select class="filter-select" name="time">
                                    <option value="All" ${time == 'All' ? 'selected' : ''}>Tất cả thời gian</option>
                                    <option value="7" ${time == '7' ? 'selected' : ''}>7 ngày qua</option>
                                    <option value="30" ${time == '30' ? 'selected' : ''}>30 ngày qua</option>
                                    <option value="90" ${time == '90' ? 'selected' : ''}>90 ngày qua</option>
                                </select>

                                <!-- Search Field -->
                                <div class="search-container" style="position: relative; max-width: 750px;">
                                    <input type="text" class="search-input" name="keyword" value="${keyword}" placeholder="Tìm kiếm theo công việc, công ty hoặc địa điểm">
                                </div>
                                <button type="submit" class="search-button" title="Tìm kiếm">
                                    Tìm kiếm
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="results-counter ${result >= 0 ? 'visible' : ''}" id="resuFlts-counter">
                        Hiển thị <span id="results-count">${result}</span> kết quả tìm kiếm
                    </div>
                    <c:forEach var="data" items="${data}">
                        <div class="job-list" id="job-list">

                            <div class="job-item" data-title="${data.title}" data-company="${data.company}" data-location="${data.location}" data-status="${data.status}">
                                <div class="job-logo">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-lg">
                                    <rect x="4" y="2" width="16" height="20" rx="2" ry="2"></rect>
                                    <path d="M9 22v-4h6v4"></path>
                                    <path d="M8 6h.01"></path>
                                    <path d="M16 6h.01"></path>
                                    <path d="M12 6h.01"></path>
                                    <path d="M12 10h.01"></path>
                                    <path d="M12 14h.01"></path>
                                    <path d="M16 10h.01"></path>
                                    <path d="M16 14h.01"></path>
                                    <path d="M8 10h.01"></path>
                                    <path d="M8 14h.01"></path>
                                    </svg>
                                </div>
                                <div class="job-info">
                                    <h3 class="job-title">${data.title}</h3>
                                    <div class="job-company">${data.company}</div>
                                    <div class="job-meta">
                                        <div class="job-meta-item">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm">
                                            <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"></path>
                                            <circle cx="12" cy="10" r="3"></circle>
                                            </svg>
                                            <span>${data.location}</span>
                                        </div>
                                        <div class="job-meta-item">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm">
                                            <circle cx="12" cy="12" r="10"></circle>
                                            <path d="m16 12-4 4-4-4"></path>
                                            <path d="M12 8v8"></path>
                                            </svg>
                                            <span><fmt:formatNumber value="${data.minSalary}" type="number" groupingUsed="true"/> - <fmt:formatNumber value="${data.maxSalary}" type="number" groupingUsed="true"/> VNĐ</span>
                                        </div>
                                        <div class="job-meta-item">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm">
                                            <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                            <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                            </svg>
                                            <span>${data.jobType}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="job-status">
                                    <span class="status-badge status-badge-${data.status}"><c:choose>
                                            <c:when test="${data.status=='Pending'}">Đang chờ</c:when>
                                            <c:when test="${data.status=='Interview'}">Phỏng vấn</c:when>
                                            <c:when test="${data.status=='Testing'}">Kiểm tra đánh giá</c:when>
                                            <c:when test="${data.status=='Rejected'}">Từ chối</c:when>
                                            <c:when test="${data.status=='Accepted'}">Chấp nhận</c:when>
                                        </c:choose></span>
                                </div>
                                <div class="job-actions">
                                    <a href="CandidateJobDetail?jobID=${data.jobID}" class="btn btn-outline btn-sm">Xem chi tiết</a>
                                    <c:if test="${data.status == 'Pending'}">
                                        <a href="CancelApplication?jobID=${data.jobID}" 
                                           class="btn btn-outline btn-sm"
                                           onclick="return confirm('Bạn có chắc chắn muốn hủy ứng tuyển công việc này không?');">
                                            Hủy ứng tuyển
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="pagination">
                            <!-- Prev Button -->
                            <form method="post" action="AppliedJobList" style="display:inline;">
                                <input type="hidden" name="status" value="${status}" />
                                <input type="hidden" name="time" value="${time}" />
                                <input type="hidden" name="keyword" value="${keyword}" />
                                <input type="hidden" name="top" value="${top}" />
                                <input type="hidden" name="page" value="${page - 1}" />
                                <button class="pagination-item ${page == 1 ? 'disabled' : ''}" ${page == 1 ? 'disabled' : ''}>←</button>
                            </form>

                            <!-- Page Numbers ±2 -->
                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <c:if test="${p >= page - 2 && p <= page + 2}">
                                    <form method="post" action="AppliedJobList" style="display:inline;">
                                        <input type="hidden" name="status" value="${status}" />
                                        <input type="hidden" name="time" value="${time}" />
                                        <input type="hidden" name="keyword" value="${keyword}" />
                                        <input type="hidden" name="top" value="${top}" />
                                        <input type="hidden" name="page" value="${p}" />
                                        <button class="pagination-item ${p == page ? 'active' : ''}">${p}</button>
                                    </form>
                                </c:if>
                            </c:forEach>

                            <!-- Next Button -->
                            <form method="post" action="AppliedJobList" style="display:inline;">
                                <input type="hidden" name="status" value="${status}" />
                                <input type="hidden" name="time" value="${time}" />
                                <input type="hidden" name="keyword" value="${keyword}" />
                                <input type="hidden" name="top" value="${top}" />
                                <input type="hidden" name="page" value="${page + 1}" />
                                <button class="pagination-item ${page == totalPages ? 'disabled' : ''}" ${page == totalPages ? 'disabled' : ''}>→</button>
                            </form>
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

