<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="d" var="currentDay" />
<fmt:formatDate value="${now}" pattern="M" var="currentMonth" />
<fmt:formatDate value="${now}" pattern="yyyy" var="currentYear" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - JobHub</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                /* Màu chính giống VietnamWorks */
                --primary-color: #0046aa;
                --secondary-color: #ff6b00;
                --accent-color: #11cdef;
                --dark-color: #001e44;
                --light-color: #f7fafc;
                --danger-color: #f5365c;
                --warning-color: #fb6340;
                --info-color: #11cdef;
                --success-color: #2dce89;
            }

            body {
                font-family: 'Poppins', sans-serif;
                color: #525f7f;
                background-color: #f0f6ff;
            }

            /* Navbar Styles from Home Page */
            .navbar-custom {
                background-color: #f0f6ff;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, 0.35);
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
            }

            .nav-link {
                font-weight: 500;
                padding: 0.5rem 1rem !important;
                transition: all 0.2s;
            }

            .nav-link:hover {
                color: var(--primary-color) !important;
            }

            .btn {
                font-weight: 600;
                padding: 0.625rem 1.25rem;
                border-radius: 0.375rem;
                transition: all 0.15s ease;
                box-shadow: 0 4px 6px rgba(50, 50, 93, .11), 0 1px 3px rgba(0, 0, 0, .08);
            }

            .btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 7px 14px rgba(50, 50, 93, .1), 0 3px 6px rgba(0, 0, 0, .08);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #0051ff, #003ecb);
                transform: translateY(-2px);
            }

            .btn-outline-primary {
                background: white;
                color: #0051ff;
                border: 2px solid #0051ff;
                padding: 12px 24px;
                border-radius: 10px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                background: #e6f0ff;
                transform: translateY(-2px);
                color: #0051ff;
            }

            .btn-danger {
                background-color: var(--danger-color);
                border-color: var(--danger-color);
            }

            /* Dashboard Specific Styles */
            .container {
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 1rem;
            }

            .min-h-screen {
                min-height: 100vh;
            }

            /* Main content */
            .main-content {
                padding: 2rem 0;
            }

            .dashboard-grid {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            @media (min-width: 768px) {
                .dashboard-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (min-width: 1024px) {
                .dashboard-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
            }

            /* Cards */
            .card {
                background-color: white;
                border-radius: 0.5rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .card-header {
                padding: 1.25rem 1.5rem;
                border-bottom: 1px solid #e5e7eb;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .card-title {
                font-size: 1.125rem;
                font-weight: 600;
            }

            .card-content {
                padding: 1.5rem;
            }

            .card-full {
                grid-column: 1 / -1;
            }

            .card-half {
                grid-column: span 2;
            }

            /* Stats cards */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
                margin-bottom: 2rem;
            }

            @media (min-width: 768px) {
                .stats-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
            }

            .stat-card {
                background-color: white;
                border-radius: 0.5rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                padding: 1.5rem;
                text-align: center;
            }

            .stat-icon {
                width: 3rem;
                height: 3rem;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1rem;
            }

            .stat-icon-blue {
                background-color: #dbeafe;
                color: #1d4ed8;
            }

            .stat-icon-green {
                background-color: #dcfce7;
                color: #16a34a;
            }

            .stat-icon-yellow {
                background-color: #fef3c7;
                color: #d97706;
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.25rem;
            }

            .stat-label {
                font-size: 0.875rem;
                color: #6b7280;
            }

            /* Progress bar */
            .progress-container {
                margin-bottom: 1rem;
            }

            .progress-label {
                display: flex;
                justify-content: space-between;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
            }

            .progress-bar-container {
                width: 100%;
                background-color: #e5e7eb;
                border-radius: 0.25rem;
                height: 0.5rem;
            }

            .progress-bar {
                height: 100%;
                border-radius: 0.25rem;
                transition: width 0.3s ease;
            }

            .progress-bar-blue {
                background-color: #3b82f6;
            }

            /* Activity list */
            .activity-list {
                space-y: 1rem;
            }

            .activity-item {
                display: flex;
                align-items: start;
                padding: 1rem 0;
                border-bottom: 1px solid #f3f4f6;
            }

            .activity-item:last-child {
                border-bottom: none;
            }

            .activity-icon {
                width: 2.5rem;
                height: 2.5rem;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 1rem;
                flex-shrink: 0;
            }

            .activity-content {
                flex-grow: 1;
            }

            .activity-title {
                font-weight: 500;
                margin-bottom: 0.25rem;
            }

            .activity-description {
                font-size: 0.875rem;
                color: #6b7280;
                margin-bottom: 0.25rem;
            }

            .activity-time {
                font-size: 0.75rem;
                color: #9ca3af;
            }

            /* Job recommendations */
            .job-item {
                display: flex;
                align-items: center;
                padding: 1rem;
                border: 1px solid #e5e7eb;
                border-radius: 0.5rem;
                margin-bottom: 1rem;
                transition: all 0.2s;
            }

            .job-item:hover {
                border-color: #1a56db;
                box-shadow: 0 2px 8px rgba(26, 86, 219, 0.1);
            }

            .job-logo {
                width: 3rem;
                height: 3rem;
                background-color: #f3f4f6;
                border-radius: 0.375rem;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 1rem;
                flex-shrink: 0;
            }

            .job-info {
                flex-grow: 1;
            }

            .job-title {
                font-weight: 600;
                margin-bottom: 0.25rem;
            }

            .job-company {
                color: #1a56db;
                font-size: 0.875rem;
                margin-bottom: 0.25rem;
            }

            .job-meta {
                font-size: 0.75rem;
                color: #6b7280;
            }

            /* Calendar */
            .calendar-grid {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 0.25rem;
                margin-top: 1rem;
            }

            .calendar-day {
                aspect-ratio: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.875rem;
                border-radius: 0.25rem;
                cursor: pointer;
                transition: all 0.2s;
            }

            .calendar-day:hover {
                background-color: #f3f4f6;
            }

            .calendar-day.today {
                background-color: #1a56db;
                color: white;
            }

            .calendar-day.has-event {
                background-color: #fef3c7;
                color: #92400e;
            }

            .calendar-header {
                display: grid;
                grid-template-columns: repeat(7, 1fr);
                gap: 0.25rem;
                margin-bottom: 0.5rem;
            }

            .calendar-header-day {
                text-align: center;
                font-size: 0.75rem;
                font-weight: 600;
                color: #6b7280;
                padding: 0.5rem 0;
            }

            /* Footer */
            .footer {
                background-color: #003366;
                color: white;
                padding: 5rem 0 2rem;
            }

            .footer-logo {
                font-weight: 700;
                font-size: 1.75rem;
                margin-bottom: 1.5rem;
                display: inline-block;
            }

            .footer-description {
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 2rem;
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

            .footer-title {
                font-weight: 700;
                color: white;
                margin-bottom: 1.5rem;
                font-size: 1.1rem;
            }

            .footer-links {
                list-style: none;
                padding-left: 0;
                margin-bottom: 2rem;
            }

            .footer-link {
                margin-bottom: 0.75rem;
            }

            .footer-link a {
                color: rgba(255, 255, 255, 0.6);
                text-decoration: none;
                transition: all 0.2s;
            }

            .footer-link a:hover {
                color: white;
                padding-left: 5px;
            }

            .footer-divider {
                border-color: rgba(255, 255, 255, 0.1);
                margin: 2rem 0;
            }

            .footer-bottom {
                color: rgba(255, 255, 255, 0.6);
                font-size: 0.875rem;
            }

            .footer-bottom a {
                color: white;
                text-decoration: none;
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

            /* Empty state */
            .empty-state {
                text-align: center;
                padding: 2rem;
                color: #6b7280;
            }

            .btn-sm {
                padding: 0.25rem 0.75rem;
                font-size: 0.875rem;
            }

            .btn-outline {
                background-color: transparent;
                color: #1a56db;
                border: 1px solid #d1d5db;
            }

            .btn-outline:hover {
                background-color: #f3f4f6;
            }
        </style>
    </head>
    <body>
        <%
            boolean isLoggedIn = false;
            String role = null;
            if (session.getAttribute("Recruiter") != null) {
                isLoggedIn = true;
                role = "recruiter";
            } else if (session.getAttribute("Candidate") != null) {
                isLoggedIn = true;
                role = "candidate";
            } else if (session.getAttribute("Admin") != null) {
                isLoggedIn = true;
                role = "admin";
            } else if (session.getAttribute("Moderator") != null) {
                isLoggedIn = true;
                role = "moderator";
            }
        %>

        <!-- Navigation Bar - Updated to match Home Page -->
        <nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
            <div class="container">
                <a class="navbar-brand" href="HomePage">
                    <span style="color: var(--primary-color);">Job</span><span style="color: var(--dark-color);">Hub</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="HomePage">Trang chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="CandidateDashboard">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="AdvancedJobSearch">Tìm việc làm</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="BlogListPage">Trang Blog</a>
                        </li>

                    </ul>
                    <div class="d-flex">
                        <% if (!isLoggedIn) { %>
                        <a href="ChooseRole.jsp" class="btn btn-outline-primary me-2">Đăng nhập</a>
                        <a href="register.jsp" class="btn btn-primary">Đăng ký</a>
                        <% } else { %>
                        <% if ("admin".equals(role)) { %>
                        <a href="adminPage.jsp" class="btn btn-primary me-2">Trang Admin</a>
                        <% } else if ("moderator".equals(role)) { %>
                        <a href="modPage.jsp" class="btn btn-primary me-2">Mod Page</a>
                        <% } else if ("recruiter".equals(role)) { %>
                        <a href="JobPostingPage" class="btn btn-primary me-2">Tạo bài đăng</a>
                        <a href="EditProfileRecruiter" class="btn btn-outline-primary me-2">Quản lí Profile</a>
                        <a href="scheduledInterviews" class="btn btn-outline-primary me-2">Lịch phỏng vấn</a>
                        <% } else if ("candidate".equals(role)) { %>

                        <% } %>
                        <a href="#" class="btn btn-danger" onclick="return confirmLogout()">Đăng xuất</a>
                        <% } %>
                        <script>
                            // Confirmation dialog for logout
                            function confirmLogout() {
                                if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                                    window.location.href = 'logout';
                                    return true;
                                }
                                return false;
                            }
                        </script>
                    </div>
                </div>
            </div>
        </nav>

        <div class="min-h-screen">
            <main class="container main-content">
                <!-- Statistics Overview -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon stat-icon-blue">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                            <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                            <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                            </svg>
                        </div>
                        <div class="stat-number">${applicationCount != null ? applicationCount : 0}</div>
                        <div class="stat-label">Đã ứng tuyển</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon stat-icon-green">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                            <polyline points="22,4 12,14.01 9,11.01"></polyline>
                            </svg>
                        </div>
                        <div class="stat-number">${interviewCount != null ? interviewCount : 0}</div>
                        <div class="stat-label">Phỏng vấn</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon stat-icon-yellow">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14,2 14,8 20,8"></polyline>
                            <line x1="16" y1="13" x2="8" y2="13"></line>
                            <line x1="16" y1="17" x2="8" y2="17"></line>
                            <polyline points="10,9 9,9 8,9"></polyline>
                            </svg>
                        </div>
                        <div class="stat-number">${assCount != null ? assCount : 0}</div>
                        <div class="stat-label">Bài tập</div>
                    </div>
                </div>

                <div class="dashboard-grid">
                    <!-- Profile Completion -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Thông tin cơ bản</h3>
                  
                        </div>
                        <div class="card-content">
                            <div class="progress-container">
                                <span style="font-size: 0.875rem; font-weight: bold">Họ và tên: </span>${candidate.fullName}
                                <hr>
                                <span style="font-size: 0.875rem; font-weight: bold">Email: </span>${candidate.email}
                                <hr>
                                <span style="font-size: 0.875rem; font-weight: bold">Số điện thoại: </span>${candidate.phone}
                                <hr>
                            </div>
                            <a href="CandidateProfile" class="btn btn-primary btn-sm">Cập nhật hồ sơ</a>
                        </div>
                    </div>

                    <!-- Recent Activities -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Danh sách bài thi</h3>
                            <a href="AssignmentList" style="font-size: 0.875rem; color: #1a56db;">Xem tất cả</a>
                        </div>
                        <div class="card-content">
                            <div class="activity-list">
                                <c:choose>
                                    <c:when test="${not empty assList}">
                                        <c:forEach var="item" items="${assList}" varStatus="status">
                                            <c:if test="${status.index < 3}">
                                                <div class="activity-item">
                                                    <div class="activity-icon stat-icon-blue">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                             stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm">
                                                        <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                                                        <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                                                        </svg>
                                                    </div>
                                                    <div class="activity-content">
                                                        <div class="activity-title">${item.title}</div>
                                                        <div class="activity-description">${item.description}</div>
                                                        <div class="activity-time">
                                                            Hạn cuối: <fmt:formatDate value="${item.dueDate}" pattern="dd/MM/yyyy HH:mm" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="empty-state">
                                            <p>Hiện bạn không có bài thi nào</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Lối tắt của bạn</h3>
                        </div>
                        <div class="card-content">
                            <div style="display: grid; gap: 0.75rem;">

                                <a href="CandidateProfile" class="btn btn-outline">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm" style="margin-right: 0.5rem;">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                    </svg>
                                    Cập nhật hồ sơ
                                </a>
                                <a href="CandidateInterview" class="btn btn-outline">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm" style="margin-right: 0.5rem;">
                                    <circle cx="11" cy="11" r="8"></circle>
                                    <path d="M21 21l-4.35-4.35"></path>
                                    </svg>
                                    Lịch phỏng vấn của tôi
                                </a>
                                <a href="AppliedListPage" class="btn btn-outline">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm" style="margin-right: 0.5rem;">
                                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                    <polyline points="14,2 14,8 20,8"></polyline>
                                    <line x1="16" y1="13" x2="8" y2="13"></line>
                                    <line x1="16" y1="17" x2="8" y2="17"></line>
                                    </svg>
                                    Danh sách đã ứng tuyển
                                </a>
                                <a href="AssignmentList" class="btn btn-outline">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm" style="margin-right: 0.5rem;">
                                    <path d="M9 12l2 2 4-4"></path>
                                    <path d="M21 12c.552 0 1-.448 1-1V5c0-.552-.448-1-1-1H3c-.552 0-1 .448-1 1v6c0 .552.448 1 1 1h18z"></path>
                                    <path d="M3 12v6c0 .552.448 1 1 1h16c.552 0 1-.448 1-1v-6"></path>
                                    </svg>
                                    Danh sách bài thi
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Calendar -->
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Lịch phỏng vấn</h3>
                            <a href="CandidateInterview" style="font-size: 0.875rem; color: #1a56db;">Xem tất cả</a>
                        </div>
                        <div class="card-content">
                            <div class="calendar-header">
                                <div class="calendar-header-day">CN</div>
                                <div class="calendar-header-day">T2</div>
                                <div class="calendar-header-day">T3</div>
                                <div class="calendar-header-day">T4</div>
                                <div class="calendar-header-day">T5</div>
                                <div class="calendar-header-day">T6</div>
                                <div class="calendar-header-day">T7</div>
                            </div>
                            <div class="calendar-grid">
                                <div class="calendar-day"></div>
                                <div class="calendar-day"></div>
                                <div class="calendar-day"></div>
                                <c:forEach var="day" begin="1" end="31">
                                    <c:set var="hasEvent" value="false" />
                                    <c:if test="${not empty interviewList}">
                                        <c:forEach var="interview" items="${interviewList}">
                                            <fmt:formatDate value="${interview.interviewTime}" pattern="d" var="interviewDay"/>
                                            <fmt:formatDate value="${interview.interviewTime}" pattern="M" var="interviewMonth"/>
                                            <fmt:formatDate value="${interview.interviewTime}" pattern="yyyy" var="interviewYear"/>
                                            <c:if test="${interviewDay == day and interviewMonth == currentMonth and interviewYear == currentYear}">
                                                <c:set var="hasEvent" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${hasEvent}">
                                            <div class="calendar-day has-event">${day}</div>
                                        </c:when>
                                        <c:when test="${day == currentDay}">
                                            <div class="calendar-day today">${day}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="calendar-day">${day}</div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <!-- Danh sách sự kiện sắp tới -->
                            <div style="margin-top: 1rem;">
                                <div style="font-size: 0.875rem; color: #6b7280; margin-bottom: 0.5rem;">Sự kiện sắp tới:</div>
                                <div style="font-size: 0.875rem;">
                                    <c:choose>
                                        <c:when test="${not empty interviewList}">
                                            <c:forEach var="interview" items="${interviewList}" varStatus="status">
                                                <c:if test="${status.index < 3}">
                                                    <fmt:formatDate value="${interview.interviewTime}" pattern="dd/MM" var="date"/>
                                                    <fmt:formatDate value="${interview.interviewTime}" pattern="HH:mm" var="time"/>
                                                    <div style="margin-bottom: 0.25rem;">• ${date}: Phỏng vấn (${time})</div>
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="color: #9ca3af;">Không có lịch phỏng vấn nào</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Job Recommendations -->
                    <div class="card card-half">
                        <div class="card-header">
                            <h3 class="card-title">Một số việc làm gần đây</h3>
                            <a href="AdvancedJobSearch" style="font-size: 0.875rem; color: #1a56db;">Xem tất cả</a>
                        </div>
                        <div class="card-content">
                            <c:choose>
                                <c:when test="${not empty jobList}">
                                    <c:forEach var="item" items="${jobList}" varStatus="status">
                                        <c:if test="${status.index < 4}">
                                            <div class="job-item">
                                                <div class="job-logo">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                                                    <rect x="4" y="2" width="16" height="20" rx="2" ry="2"></rect>
                                                    <path d="M9 22v-4h6v4"></path>
                                                    <path d="M8 6h.01"></path>
                                                    <path d="M16 6h.01"></path>
                                                    <path d="M12 6h.01"></path>
                                                    </svg>
                                                </div>
                                                <div class="job-info">
                                                    <div class="job-title">${item.jobPost.title}</div>
                                                    <div class="job-company">${item.companyName}</div>
                                                    <div class="job-meta">${item.jobPost.location} • <fmt:formatNumber value="${item.jobPost.salaryMin}" type="number" groupingUsed="true"/>-<fmt:formatNumber value="${item.jobPost.salaryMax}" type="number" groupingUsed="true"/> VNĐ • ${item.jobPost.jobType}</div>
                                                </div>
                                                <a href="CandidateJobDetail?jobID=${item.jobPost.jobId}" class="btn btn-primary btn-sm">Xem chi tiết</a>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <p>Không có việc làm nào để hiển thị</p>
                                        <a href="AdvancedJobSearch" class="btn btn-primary btn-sm" style="margin-top: 1rem;">Tìm việc làm</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </main>

            <!-- Footer -->
            <footer class="footer">
                <div class="container">
                    <div class="footer-grid">
                        <div>
                            <a href="#" class="footer-logo">
                                <span style="color: var(--primary-color);">Job</span><span>Hub</span>
                            </a>
                            <p class="footer-description">JobHub là nền tảng tuyển dụng hàng đầu tại Việt Nam, kết nối ứng viên
                                với hàng nghìn cơ hội việc làm từ các công ty uy tín.</p>
                        </div>
                        <div>
                            <h5 class="footer-title">Dành cho ứng viên</h5>
                            <ul class="footer-links">
                                <li class="footer-link"><a href="#">Tìm việc làm</a></li>
                                <li class="footer-link"><a href="#">Tạo CV</a></li>
                                <li class="footer-link"><a href="#">Việc làm đã lưu</a></li>
                                <li class="footer-link"><a href="#">Cài đặt thông báo</a></li>
                                <li class="footer-link"><a href="#">Đánh giá công ty</a></li>
                            </ul>
                        </div>
                        <div>
                            <h5 class="footer-title">Dành cho nhà tuyển dụng</h5>
                            <ul class="footer-links">
                                <li class="footer-link"><a href="#">Đăng tin tuyển dụng</a></li>
                                <li class="footer-link"><a href="#">Tìm hồ sơ</a></li>
                                <li class="footer-link"><a href="#">Giải pháp tuyển dụng</a></li>
                                <li class="footer-link"><a href="#">Bảng giá dịch vụ</a></li>
                                <li class="footer-link"><a href="#">Liên hệ kinh doanh</a></li>
                            </ul>
                        </div>
                        <div>
                            <h5 class="footer-title">Về JobHub</h5>
                            <ul class="footer-links">
                                <li class="footer-link"><a href="#">Giới thiệu</a></li>
                                <li class="footer-link"><a href="#">Liên hệ</a></li>
                                <li class="footer-link"><a href="#">Trợ giúp</a></li>
                                <li class="footer-link"><a href="#">Chính sách bảo mật</a></li>
                                <li class="footer-link"><a href="#">Điều khoản sử dụng</a></li>
                            </ul>
                        </div>
                    </div>
                    <hr class="footer-divider">
                    <div class="row">
                        <div class="col-md-6">
                            <p class="footer-bottom mb-0">© 2023 JobHub. Tất cả quyền được bảo lưu.</p>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <p class="footer-bottom mb-0">Được thiết kế và phát triển bởi <a href="#">JobHub Team</a></p>
                        </div>
                    </div>
                </div>
            </footer>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            // Add interactivity for calendar
                            document.querySelectorAll('.calendar-day').forEach(day => {
                                day.addEventListener('click', function () {
                                    if (this.textContent.trim()) {
                                        console.log('Selected date:', this.textContent);
                                    }
                                });
                            });
        </script>
    </body>
</html>
