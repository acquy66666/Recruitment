<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.recruitment.model.Admin"%>
<style>
    :root {
        --primary-color: #0B5ED7;
        --primary-hover: #0947A6;
        --sidebar-bg: #ffffff;
        --text-primary: #212529;
        --text-secondary: #6c757d;
        --border-color: #e9ecef;
        --active-bg: #e6f0ff;
        --active-border: #0B5ED7;
        --sidebar-width: 280px;
        --shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .sidebar {
        width: var(--sidebar-width);
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        background-color: var(--sidebar-bg);
        border-right: 1px solid var(--border-color);
        box-shadow: var(--shadow);
        overflow-y: auto;
        z-index: 1000;
    }

    .sidebar-header {
        padding: 20px;
        border-bottom: 1px solid var(--border-color);
        background: linear-gradient(135deg, #0B5ED7 0%, #0947A6 100%);
    }

    .logo-container {
        display: flex;
        align-items: center;
        text-decoration: none;
    }

    .logo-container:hover {
        text-decoration: none;
    }

    .sidebar-nav {
        padding: 0;
        margin: 0;
        list-style: none;
    }

    .nav-section {
        padding: 20px 0 10px 0;
    }

    .nav-section-title {
        font-size: 12px;
        font-weight: 600;
        color: var(--text-secondary);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        padding: 0 24px 8px 24px;
        margin: 0;
    }

    .nav-item {
        margin: 2px 12px;
    }

    .nav-link {
        display: flex;
        align-items: center;
        padding: 12px 16px;
        color: var(--text-primary);
        text-decoration: none;
        border-radius: 8px;
        font-weight: 500;
        font-size: 14px;
        transition: all 0.2s ease;
        position: relative;
        border: 1px solid transparent;
    }

    .nav-link:hover {
        background-color: #f8f9fa;
        color: var(--primary-color);
        text-decoration: none;
        transform: translateX(2px);
    }

    .nav-link.active {
        background-color: var(--active-bg);
        color: var(--primary-color);
        border-color: var(--active-border);
        font-weight: 700;
        box-shadow: 0 2px 6px rgba(11, 94, 215, 0.2);
    }

    .nav-link.active::before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 4px;
        height: 24px;
        background-color: var(--primary-color);
        border-radius: 0 3px 3px 0;
    }

    .nav-icon {
        width: 20px;
        height: 20px;
        margin-right: 12px;
        opacity: 0.7;
        transition: opacity 0.2s ease;
    }

    .nav-link:hover .nav-icon,
    .nav-link.active .nav-icon {
        opacity: 1;
    }

    .logo-svg {
        filter: brightness(0) invert(1);
    }

    @media (max-width: 768px) {
        .sidebar {
            transform: translateX(-100%);
            transition: transform 0.3s ease;
        }

        .sidebar.show {
            transform: translateX(0);
        }
    }

    .sidebar::-webkit-scrollbar {
        width: 6px;
    }

    .sidebar::-webkit-scrollbar-track {
        background: #f1f1f1;
    }

    .sidebar::-webkit-scrollbar-thumb {
        background: #c1c1c1;
        border-radius: 3px;
    }

    .sidebar::-webkit-scrollbar-thumb:hover {
        background: #a8a8a8;
    }
</style>

<% 
    Admin user = (Admin) session.getAttribute("Admin");
    boolean isAdmin = user != null && "Admin".equalsIgnoreCase(user.getRole());
    boolean isUserModerator = user != null && "Moderator".equalsIgnoreCase(user.getRole());
%>

<nav class="sidebar" style="position: fixed; top: 0; left: 0;">
    <div class="sidebar-header">
        <a href="HomePage.jsp" class="logo-container">
            <svg viewBox="0 0 300 100" xmlns="http://www.w3.org/2000/svg" width="150" class="logo-svg">
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
                    JobHub
                </text>
            </svg>
        </a>
    </div>

    <div class="nav-section">
        <h6 class="nav-section-title">Thanh menu chính</h6>
        <ul class="sidebar-nav">
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().endsWith(isAdmin ? "adminPage.jsp" : "modPage.jsp") ? "active" : "" %>" 
                   href="<%= isAdmin ? "adminPage.jsp" : "modPage.jsp" %>">
                    <svg class="nav-icon" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"/>
                    </svg>
                    Bảng điều khiển
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link fw-bold text-dark text-uppercase" href="#" style="pointer-events: none;">
                    <svg class="nav-icon me-2" fill="currentColor" viewBox="0 0 20 20" width="16" height="16">
                        <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/>
                    </svg>
                    Quản lý tài khoản
                </a>
            </li>
            <% if (isAdmin) { %>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getServletPath().contains("manageAccount") ? "active" : "" %>" href="manageAccount">
                    Tất cả tài khoản
                </a>
            </li>
            <% } %>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getServletPath().contains("pendingApproval.jsp") || request.getServletPath().contains("adminEditAccount.jsp") ? "active" : "" %>" href="ManageAccountPending">
                    Chờ phê duyệt
                </a>
            </li>
        </ul>
    </div>

    <div class="nav-section">
        <h6 class="nav-section-title">Quản lý nội dung</h6>
        <ul class="sidebar-nav">
            <li class="nav-item">
                <a class="nav-link fw-bold text-dark text-uppercase" href="#" style="pointer-events: none;">
                    <svg class="nav-icon me-2" fill="currentColor" viewBox="0 0 20 20" width="16" height="16">
                        <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h8a2 2 0 012 2v12a1 1 0 110 2h-3a1 1 0 01-1-1v-2a1 1 0 00-1-1H9a1 1 0 00-1 1v2a1 1 0 01-1 1H4a1 1 0 110-2V4zm3 1h2v2H7V5zm2 4H7v2h2V9zm2-4h2v2h-2V5zm2 4h-2v2h2V9z" clip-rule="evenodd"/>
                    </svg>
                    Quản lý các bài đăng
                </a>
            </li>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getServletPath().contains("ManageJobPostAdmin") ? "active" : "" %>" 
                   href="ManageJobPostAdmin">
                    Tất cả bài đăng
                </a>
            </li>
            <% if (isAdmin) { %>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getServletPath().contains("PendingJobPosts") ? "active" : "" %>" 
                   href="PendingJobPosts">
                    Bài viết chờ duyệt
                </a>
            </li>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getServletPath().contains("ReportedJobPosts") ? "active" : "" %>" 
                   href="ReportedJobPosts">
                    Bài đăng bị báo cáo
                </a>
            </li>
            <% } %>
            <li class="nav-item">
                <a class="nav-link fw-bold text-dark text-uppercase" href="#" style="pointer-events: none;">
                    <svg class="nav-icon me-2" fill="currentColor" viewBox="0 0 24 24" width="16" height="16" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6 2a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8.828A2 2 0 0019.414 7L15 2.586A2 2 0 0013.586 2H6zm7 1.414L18.586 9H14a1 1 0 01-1-1V3.414zM8 12h8a1 1 0 110 2H8a1 1 0 110-2zm0 4h5a1 1 0 110 2H8a1 1 0 110-2z"/>
                    </svg>
                    Quản lý bài thi
                </a>
            </li>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getServletPath().contains("PendingTest") ? "active" : "" %>" 
                   href="PendingTest">
                    Bài thi chờ duyệt
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().endsWith("manageService.jsp") ? "active" : "" %> fw-bold text-dark text-uppercase disabled-link" href="ManageServiceAdmin">
                    <svg class="nav-icon me-2" fill="currentColor" viewBox="0 0 20 20" width="16" height="16">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M11.983 1.534a1 1 0 00-1.966 0l-.143.715a6.993 6.993 0 00-1.48.857l-.673-.392a1 1 0 00-1.366.366l-.5.866a1 1 0 00.366 1.366l.674.392a6.964 6.964 0 000 1.714l-.674.392a1 1 0 00-.366 1.366l.5.866a1 1 0 001.366.366l.673-.392c.45.35.945.642 1.48.857l.143.715a1 1 0 001.966 0l.143-.715a6.993 6.993 0 001.48-.857l.673.392a1 1 0 001.366-.366l.5-.866a1 1 0 00-.366-1.366l-.674-.392a6.964 6.964 0 000-1.714l.674-.392a1 1 0 00.366-1.366l-.5-.866a1 1 0 00-1.366-.366l-.673.392a6.993 6.993 0 00-1.48-.857l-.143-.715zM10 13a3 3 0 100-6 3 3 0 000 6z" />
                    </svg>
                    Quản lý các gói dịch vụ
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().endsWith("manageBlogPost.jsp") ? "active" : "" %> fw-bold text-dark text-uppercase disabled-link" href="ManageBlogPostAdmin">
                    <svg class="nav-icon me-2" fill="currentColor" viewBox="0 0 20 20" width="16" height="16" xmlns="http://www.w3.org/2000/svg">
                        <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z"/>
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M2 16.25V18h1.75l9.25-9.25-1.75-1.75L2 16.25z"/>
                    </svg>
                    Quản lý bài blog
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link fw-bold text-dark text-uppercase" href="#" style="pointer-events: none;">
                    <svg class="nav-icon me-2" fill="currentColor" viewBox="0 0 20 20" width="16" height="16">
                        <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h8a2 2 0 012 2v12a1 1 0 110 2h-3a1 1 0 01-1-1v-2a1 1 0 00-1-1H9a1 1 0 00-1 1v2a1 1 0 01-1 1H4a1 1 0 110-2V4zm3 1h2v2H7V5zm2 4H7v2h2V9zm2-4h2v2h-2V5zm2 4h-2v2h2V9z" clip-rule="evenodd"/>
                    </svg>
                    Thống kê
                </a>
            </li>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getRequestURI().endsWith("OverviewStatistics.jsp") ? "active" : "" %>"
                   href="OverviewStatistics">
                    Tổng quan hệ thống
                </a>
            </li>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getRequestURI().endsWith("RevenueStatistics.jsp") ? "active" : "" %>"
                   href="RevenueStatistics">
                    Thống kê doanh thu
                </a>
            </li>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getRequestURI().endsWith("UserStatistics.jsp") ? "active" : "" %>"
                   href="UserStatistics">
                    Thống kê Người dùng
                </a>
            </li>
            <li class="nav-item ps-4">
                <a class="nav-link <%= request.getRequestURI().endsWith("JobPostStatistics.jsp") ? "active" : "" %>"
                   href="JobPostStatistics">
                    Thống kê nội dung
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().endsWith("ReportExportExel.jsp") || request.getRequestURI().endsWith("ReportExportExel2.jsp") ? "active" : "" %> fw-bold text-dark text-uppercase disabled-link" href="TransactionExel">
                    <svg class="nav-icon me-2" fill="currentColor" viewBox="0 0 24 24" width="16" height="16" xmlns="http://www.w3.org/2000/svg">
                        <path d="M3 3v18h18v-2H5V3H3zm4 12h2v4H7v-4zm4-6h2v10h-2V9zm4-4h2v14h-2V5z"/>
                    </svg>
                    Báo cáo Giao dịch & Doanh thu
                </a>
            </li>
            <% if (isAdmin) { %>
            <li class="nav-item">
                <a class="nav-link <%= request.getServletPath().contains("managePromotions") ? "active" : "" %>" 
                   href="managePromotions">
                    <svg class="nav-icon" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                    </svg>
                    Dịch vụ khuyến mãi
                </a>
            </li>
            <% } %>
            <%--
     <li class="nav-item">
         <a class="nav-link <%= request.getRequestURI().endsWith("handleReports.jsp") ? "active" : "" %>" 
            href="handleReports.jsp">
             <svg class="nav-icon" fill="currentColor" viewBox="0 0 20 20">
                 <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
             </svg>
             Xử lý báo cáo
         </a>
     </li>
            --%>
            <li class="nav-item">
                <a class="nav-link" href="HomePage">
                    <svg class="nav-icon" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10.707 1.293a1 1 0 00-1.414 0l-7 7A1 1 0 003 9h1v7a1 1 0 001 1h4a1 1 0 001-1v-4h2v4a1 1 0 001 1h4a1 1 0 001-1V9h1a1 1 0 00.707-1.707l-7-7z"/>
                    </svg>
                    Trang chủ
                </a>
            </li>
            <!--            <li class="nav-item">
                            <a class="nav-link" href="HomePage">
                                <svg class="nav-icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M10.707 1.293a1 1 0 00-1.414 0l-7 7A1 1 0 003 9h1v7a1 1 0 001 1h4a1 1 0 001-1v-4h2v4a1 1 0 001 1h4a1 1 0 001-1V9h1a1 1 0 00.707-1.707l-7-7z"/>
                                </svg>
                                Home Page
                            </a>
                        </li>-->
        </ul>
    </div>
</nav>