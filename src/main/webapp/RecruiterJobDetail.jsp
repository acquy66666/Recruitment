<%-- 
    Document   : RecruiterJobDetail
    Created on : May 27, 2025, 10:09:11 PM
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
        <title>JobHub - Nền tảng tuyển dụng hàng đầu Việt Nam</title>
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
                background: linear-gradient(to bottom right, #7828DC, #1a56db);
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

            .btn-icon {
                padding: 0.5rem;
            }

            .btn-full {
                width: 100%;
            }

            /* Main content */
            main {
                padding: 2rem 1rem;
            }

            .back-link {
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .grid {
                display: grid;
                gap: 1.5rem;
            }

            @media (min-width: 1024px) {
                .grid {
                    grid-template-columns: 2fr 1fr;
                }
            }

            .space-y {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }

            /* Cards */
            .card {
                background-color: white;
                border-radius: 0.5rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .card-content {
                padding: 1.5rem;
            }

            /* Job header */
            .job-header {
                display: flex;
                flex-direction: column;
                margin-bottom: 1.5rem;
            }

            @media (min-width: 768px) {
                .job-header {
                    flex-direction: row;
                    align-items: center;
                    justify-content: space-between;
                }
            }

            .job-title-company {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 1rem;
            }

            @media (min-width: 768px) {
                .job-title-company {
                    margin-bottom: 0;
                }
            }

            .company-logo {
                width: 4rem;
                height: 4rem;
                background-color: #f3f4f6;
                border-radius: 0.375rem;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .job-title {
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 0.25rem;
            }

            .company-name {
                color: #1a56db;
            }

            .company-name:hover {
                text-decoration: underline;
            }

            /* Enhanced Action Buttons Styles */
            .action-buttons {
                display: flex;
                gap: 0.5rem;
                align-items: center;
            }

            .btn {
                position: relative;
                transition: all 0.2s ease;
            }

            .btn-text {
                display: none;
                margin-left: 0.5rem;
                font-size: 0.875rem;
            }

            @media (min-width: 768px) {
                .btn-text {
                    display: inline;
                }

                .btn-icon {
                    padding: 0.5rem 1rem;
                }
            }

            .bookmark-btn.bookmarked {
                background-color: #1a56db;
                color: white;
                border-color: #1a56db;
            }

            .bookmark-btn.bookmarked .bookmark-icon {
                fill: currentColor;
            }

            /* Dropdown Styles */
            .dropdown-container {
                position: relative;
            }

            .dropdown-menu {
                position: absolute;
                top: 100%;
                right: 0;
                background: white;
                border: 1px solid #e5e7eb;
                border-radius: 0.5rem;
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
                min-width: 200px;
                z-index: 50;
                opacity: 0;
                visibility: hidden;
                transform: translateY(-10px);
                transition: all 0.2s ease;
            }

            .dropdown-menu.show {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            .dropdown-item {
                display: flex;
                align-items: center;
                width: 100%;
                padding: 0.75rem 1rem;
                background: none;
                border: none;
                text-align: left;
                cursor: pointer;
                transition: background-color 0.2s ease;
                font-size: 0.875rem;
            }

            .dropdown-item:hover {
                background-color: #f3f4f6;
            }

            .dropdown-item svg {
                margin-right: 0.75rem;
                flex-shrink: 0;
            }

            .dropdown-item.text-danger {
                color: #dc2626;
            }

            .dropdown-item.text-danger:hover {
                background-color: #fef2f2;
            }

            .dropdown-divider {
                height: 1px;
                background-color: #e5e7eb;
                margin: 0.5rem 0;
            }

            /* Toast Notification */
            .toast {
                position: fixed;
                bottom: 2rem;
                right: 2rem;
                background: #10b981;
                color: white;
                padding: 1rem 1.5rem;
                border-radius: 0.5rem;
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
                transform: translateX(100%);
                transition: transform 0.3s ease;
                z-index: 100;
            }

            .toast.show {
                transform: translateX(0);
            }

            .toast-content {
                display: flex;
                align-items: center;
            }

            /* Modal Styles */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 100;
                opacity: 0;
                visibility: hidden;
                transition: all 0.3s ease;
            }

            .modal-overlay.show {
                opacity: 1;
                visibility: visible;
            }

            .modal {
                background: white;
                border-radius: 0.75rem;
                max-width: 500px;
                width: 90%;
                max-height: 90vh;
                overflow: hidden;
                transform: scale(0.9);
                transition: transform 0.3s ease;
            }

            .modal-overlay.show .modal {
                transform: scale(1);
            }

            .modal-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 1.5rem;
                border-bottom: 1px solid #e5e7eb;
            }

            .modal-header h3 {
                font-size: 1.25rem;
                font-weight: 600;
                margin: 0;
            }

            .modal-close {
                background: none;
                border: none;
                cursor: pointer;
                padding: 0.25rem;
                border-radius: 0.25rem;
                transition: background-color 0.2s ease;
            }

            .modal-close:hover {
                background-color: #f3f4f6;
            }

            .modal-body {
                padding: 1.5rem;
            }

            .share-options {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
            }

            .share-option {
                display: flex;
                align-items: center;
                padding: 1rem;
                background: none;
                border: 1px solid #e5e7eb;
                border-radius: 0.5rem;
                cursor: pointer;
                transition: all 0.2s ease;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .share-option:hover {
                border-color: #1a56db;
                background-color: #f8fafc;
            }

            .share-icon {
                width: 2.5rem;
                height: 2.5rem;
                border-radius: 0.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 0.75rem;
            }

            .share-icon.facebook {
                background-color: #1877f2;
                color: white;
            }
            .share-icon.linkedin {
                background-color: #0077b5;
                color: white;
            }
            .share-icon.twitter {
                background-color: #1da1f2;
                color: white;
            }
            .share-icon.email {
                background-color: #6b7280;
                color: white;
            }

            /* Job details */
            .job-details {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            @media (min-width: 768px) {
                .job-details {
                    grid-template-columns: 1fr 1fr;
                }
            }

            .detail-item {
                display: flex;
                align-items: center;
                color: #4b5563;
            }

            .detail-item svg {
                margin-right: 0.5rem;
                color: #1a56db;
            }

            /* Tags */
            .tags {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                margin-bottom: 1.5rem;
            }

            .tag {
                background-color: #e5e7eb;
                color: #374151;
                font-size: 0.875rem;
                padding: 0.25rem 0.75rem;
                border-radius: 9999px;
            }

            /* Dates */
            .dates {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                font-size: 0.875rem;
                color: #6b7280;
            }

            /* Tabs */
            .tabs {
                margin-top: 1.5rem;
            }

            .tabs-list {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 0.5rem;
                margin-bottom: 1rem;
            }

            .tab {
                padding: 0.75rem;
                text-align: center;
                background-color: #f3f4f6;
                border-radius: 0.375rem;
                cursor: pointer;
                font-weight: 500;
            }

            .tab.active {
                background-color: #1a56db;
                color: white;
            }

            .tab-content {
                display: none;
                margin-top: 1rem;
            }

            .tab-content.active {
                display: block;
            }

            /* Lists */
            ul {
                list-style-position: inside;
                padding-left: 1.25rem;
            }

            ul.list-none {
                list-style: none;
                padding-left: 0;
            }

            ul li {
                margin-bottom: 0.5rem;
            }

            /* Benefits list */
            .benefits-list {
                list-style: none;
                padding: 0;
            }

            .benefits-list li {
                display: flex;
                align-items: flex-start;
                margin-bottom: 0.75rem;
            }

            .benefits-list svg {
                color: #10b981;
                margin-right: 0.5rem;
                flex-shrink: 0;
                margin-top: 0.125rem;
            }

            /* Company info */
            .company-info-item {
                display: flex;
                align-items: center;
                color: #4b5563;
                margin-bottom: 0.75rem;
            }

            .company-info-item svg {
                margin-right: 0.5rem;
                color: #1a56db;
                flex-shrink: 0;
            }

            /* Enhanced Similar Jobs Section */
            .similar-job {
                background: #f8fafc;
                border: 1px solid #e2e8f0;
                border-radius: 0.75rem;
                padding: 1.5rem;
                transition: all 0.2s ease;
                position: relative;
                overflow: hidden;
                margin-bottom: 1rem;
            }

            .similar-job:hover {
                border-color: #1a56db;
                box-shadow: 0 4px 12px rgba(26, 86, 219, 0.1);
                transform: translateY(-2px);
            }

            .similar-job:last-child {
                margin-bottom: 0;
            }

            .job-card-header {
                margin-bottom: 1rem;
            }

            .job-card-title {
                margin: 0 0 0.5rem 0;
                font-size: 1.125rem;
                font-weight: 600;
                line-height: 1.4;
            }

            .job-card-title a {
                color: #1f2937;
                transition: color 0.2s ease;
            }

            .job-card-title a:hover {
                color: #1a56db;
            }

            .job-card-meta {
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 0.5rem;
            }

            .job-type-badge {
                background: #dbeafe;
                color: #1e40af;
                font-size: 0.75rem;
                font-weight: 500;
                padding: 0.25rem 0.75rem;
                border-radius: 9999px;
            }

            .job-posted-date {
                font-size: 0.75rem;
                color: #6b7280;
                font-weight: 500;
            }

            .job-card-details {
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
                margin-bottom: 1.25rem;
            }

            .job-detail-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.875rem;
                color: #4b5563;
            }

            .job-detail-item svg {
                color: #1a56db;
                flex-shrink: 0;
            }

            .salary-range {
                font-weight: 500;
                color: #059669;
            }

            .job-card-footer {
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 1rem;
                padding-top: 1rem;
                border-top: 1px solid #e5e7eb;
            }

            .job-deadline {
                display: flex;
                align-items: center;
                gap: 0.25rem;
                font-size: 0.75rem;
                color: #6b7280;
            }

            .job-deadline svg {
                color: #9ca3af;
            }

            .btn-sm {
                padding: 0.5rem 1rem;
                font-size: 0.875rem;
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

            .error {
                height: 400px;
                padding-top: 30px;
                justify-items: center;
                color: white;
            }

            /* Responsive adjustments */
            @media (max-width: 640px) {
                .share-options {
                    grid-template-columns: 1fr;
                }

                .toast {
                    bottom: 1rem;
                    right: 1rem;
                    left: 1rem;
                }

                .job-card-footer {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 0.75rem;
                }

                .btn-sm {
                    width: 100%;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <div class="min-h-screen bg-gradient-to-br">
            <header>
                <div class="container header-container">
                    <div class="logo-nav">
                        <a href="/" class="logo">JobHub</a>
                        <nav>
                            <a href="/">Trang chủ</a>
                            <a href="/jobs" class="active">Tìm việc làm</a>
                            <a href="/companies">Công ty</a>
                            <a href="/news">Tin tức</a>
                            <a href="/services">Dịch vụ ▼</a>
                        </nav>
                    </div>
                </div>
            </header>

            <c:choose>
                <c:when test="${mes==''}">
                    <main class="container">
                        <div class="back-link">
                            <a href="HomePage" class="btn btn-ghost">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-sm">
                                <path d="m12 19-7-7 7-7"></path>
                                <path d="M19 12H5"></path>
                                </svg>
                                Quay lại
                            </a>
                        </div>

                        <div class="grid">
                            <div class="space-y">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="job-header">
                                            <div class="job-title-company">
                                                <div class="company-logo">
                                                    <svg width="64" height="64" xmlns="http://www.w3.org/2000/svg">
                                                    <rect x="0" y="0" width="64" height="64" rx="10" ry="10" fill="#eee" stroke="#ccc" stroke-width="1"/>
                                                    <image href="${recruiter.getCompanyLogoUrl()}" x="0" y="0" width="64" height="64" preserveAspectRatio="xMidYMid slice"/>
                                                    </svg>
                                                </div>
                                                <div>
                                                    <h1 class="job-title">${data.getTitle()}</h1>
                                                    <a class="company-name">${data.getJobPosition()}</a>
                                                </div>
                                            </div>
                                            <div class="action-buttons">
                                                <!-- Save/Bookmark Button -->
                                                <button class="btn btn-outline btn-icon bookmark-btn" id="bookmarkBtn" title="Lưu công việc">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon bookmark-icon">
                                                    <path d="m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16z"></path>
                                                    </svg>
                                                    <span class="btn-text">Lưu</span>
                                                </button>

                                                <!-- More Actions Dropdown -->
                                                <div class="dropdown-container">
                                                    <button class="btn btn-outline btn-icon dropdown-toggle" id="moreActionsBtn" title="Thêm tùy chọn">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                                                        <circle cx="12" cy="12" r="1"></circle>
                                                        <circle cx="12" cy="5" r="1"></circle>
                                                        <circle cx="12" cy="19" r="1"></circle>
                                                        </svg>
                                                    </button>

                                                    <!-- Dropdown Menu -->
                                                    <div class="dropdown-menu" id="dropdownMenu">
                                                        <button class="dropdown-item" id="shareBtn">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                            <circle cx="18" cy="5" r="3"></circle>
                                                            <circle cx="6" cy="12" r="3"></circle>
                                                            <circle cx="18" cy="19" r="3"></circle>
                                                            <line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
                                                            <line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line>
                                                            </svg>
                                                            Chia sẻ
                                                        </button>

                                                        <button class="dropdown-item" id="copyLinkBtn">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                            <path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path>
                                                            <path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path>
                                                            </svg>
                                                            Sao chép liên kết
                                                        </button>

                                                        <div class="dropdown-divider"></div>

                                                        <button class="dropdown-item text-danger" id="reportBtn">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                            <path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"></path>
                                                            <path d="M12 9v4"></path>
                                                            <path d="m12 17 .01 0"></path>
                                                            </svg>
                                                            Báo cáo
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Toast Notification -->
                                        <div class="toast" id="toast">
                                            <div class="toast-content">
                                                <span class="toast-message" id="toastMessage"></span>
                                            </div>
                                        </div>

                                        <!-- Share Modal -->
                                        <div class="modal-overlay" id="shareModal">
                                            <div class="modal">
                                                <div class="modal-header">
                                                    <h3>Chia sẻ công việc</h3>
                                                    <button class="modal-close" id="closeShareModal">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <path d="M18 6 6 18"></path>
                                                        <path d="m6 6 12 12"></path>
                                                        </svg>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="share-options">
                                                        <button class="share-option" data-platform="facebook">
                                                            <div class="share-icon facebook">
                                                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                                                <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                                                                </svg>
                                                            </div>
                                                            Facebook
                                                        </button>

                                                        <button class="share-option" data-platform="linkedin">
                                                            <div class="share-icon linkedin">
                                                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                                                <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                                                                </svg>
                                                            </div>
                                                            LinkedIn
                                                        </button>

                                                        <button class="share-option" data-platform="twitter">
                                                            <div class="share-icon twitter">
                                                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                                                <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
                                                                </svg>
                                                            </div>
                                                            Twitter
                                                        </button>

                                                        <button class="share-option" data-platform="email">
                                                            <div class="share-icon email">
                                                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                                                <polyline points="22,6 12,13 2,6"></polyline>
                                                                </svg>
                                                            </div>
                                                            Email
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="job-details">
                                            <div class="detail-item">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                                                <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"></path>
                                                <circle cx="12" cy="10" r="3"></circle>
                                                </svg>
                                                <span>${data.getLocation()}</span>
                                            </div>
                                            <div class="detail-item">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                                                <circle cx="12" cy="12" r="10"></circle>
                                                <path d="m16 12-4 4-4-4"></path>
                                                <path d="M12 8v8"></path>
                                                </svg>
                                                <span><fmt:formatNumber value="${data.getSalaryMin()}" type="number" groupingUsed="true"/> - <fmt:formatNumber value="${data.getSalaryMax()}" type="number" groupingUsed="true"/> VNĐ</span>
                                            </div>
                                            <div class="detail-item">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                                                <circle cx="12" cy="12" r="10"></circle>
                                                <polyline points="12 6 12 12 16 14"></polyline>
                                                </svg>
                                                <span>${data.getJobType()}</span>
                                            </div>
                                            <div class="detail-item">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                                                <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                                <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                                </svg>
                                                <span>${data.getExperienceLevel()}</span>
                                            </div>
                                        </div>

                                        <div class="dates">
                                            <div>Đăng ngày: <fmt:parseDate value="${data.getCreatedAt()}" pattern="yyyy-MM-dd" var="createdDate"/>
                                                <fmt:formatDate value="${createdDate}" pattern="dd/MM/yyyy" /></div>
                                            <div>Hết hạn: <fmt:parseDate value="${data.getDeadline()}" pattern="yyyy-MM-dd" var="Deadline"/>
                                                <fmt:formatDate value="${Deadline}" pattern="dd/MM/yyyy"/></div>
                                        </div>
                                        <div>
                                            <c:if test="${status=='yes'}">
                                                <a href="EditJobPostingPage?jobID=${data.jobId}" class="btn btn-primary">Sửa đơn</a>
                                                <a href="view-job-applicants" class="btn btn-primary">Xem danh sách ứng viên</a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                                <div class="tabs">
                                    <div class="tabs-list">
                                        <div class="tab active" data-tab="description">Mô tả công việc</div>
                                        <div class="tab" data-tab="requirements">Yêu cầu</div>
                                        <div class="tab" data-tab="benefits">Quyền lợi</div>
                                    </div>

                                    <div class="tab-content active" id="description">
                                        <div class="card">
                                            <div class="card-content">
                                                <h2 class="text-xl font-semibold mb-4">Mô tả công việc</h2>
                                                <div class="space-y-4">
                                                    <p>${data.getDescription()}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-content" id="requirements">
                                        <div class="card">
                                            <div class="card-content">
                                                <h2 class="text-xl font-semibold mb-4">Yêu cầu ứng viên</h2>
                                                <div class="space-y-4">
                                                    <p>${data.getRequirement()}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-content" id="benefits">
                                        <div class="card">
                                            <div class="card-content">
                                                <h2 class="text-xl font-semibold mb-4">Quyền lợi</h2>
                                                <div class="space-y-4">
                                                    <p>${data.getBenefit()}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="space-y">
                                <div class="card">
                                    <div class="card-content">
                                        <h2 class="text-xl font-semibold mb-4">Thông tin nhà tuyển dụng</h2>
                                        <div class="flex items-center space-x-4 mb-4">
                                            <div class="company-logo">
                                                <svg width="64" height="64" xmlns="http://www.w3.org/2000/svg">
                                                <rect x="0" y="0" width="64" height="64" rx="10" ry="10" fill="#eee" stroke="#ccc" stroke-width="1"/>
                                                <image href="${recruiter.getImageUrl()}" x="0" y="0" width="64" height="64" preserveAspectRatio="xMidYMid slice"/>
                                                </svg>
                                            </div>
                                            <div>
                                                <h3 class="font-semibold">${recruiter.getCompanyName()}</h3>
                                                <p class="text-sm text-gray-500">${recruiter.getFullName()}</p>
                                            </div>
                                        </div>

                                        <div class="space-y-3 mb-4">
                                            <div class="company-info-item">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                                                <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"></path>
                                                <circle cx="12" cy="10" r="3"></circle>
                                                </svg>
                                                <span>${recruiter.getCompanyAddress()}</span>
                                            </div>
                                            <div class="company-info-item">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                                                <path d="M22 16.92v3a2 2 0 0 1-2 2c-8.8 0-16-7.2-16-16a2 2 0 0 1 2-2h3a2 2 0 0 1 2 1.72 10.1 10.1 0 0 0 1 4.28 2 2 0 0 1-.45 2.1l-2 2a16 16 0 0 0 6 6l2-2a2 2 0 0 1 2.1-.45 10.1 10.1 0 0 0 4.28 1 2 2 0 0 1 1.72 2z"></path>
                                                </svg>
                                                <span>${recruiter.getPhone()}</span>
                                            </div>

                                            <div class="company-info-item">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                                                <rect x="3" y="5" width="18" height="14" rx="2" ry="2"></rect>
                                                <path d="M3 5l9 7 9-7"></path>
                                                </svg>
                                                <span>${recruiter.getEmail()}</span>
                                            </div>

                                        </div>
                                        <a href="${recruiter.getWebsite()}" class="btn btn-outline btn-full">Xem trang công ty</a>

                                    </div>
                                </div>

                                <div class="card">
                                    <div class="card-content">
                                        <h2 class="text-xl font-semibold mb-4">Việc làm tương tự</h2>
                                        <div class="space-y-4">
                                            <c:choose>
                                                <c:when test="${not empty suggestedList}">
                                                    <c:forEach items="${suggestedList}" var="job">
                                                        <div class="similar-job">
                                                            <div class="job-card-header">
                                                                <h3 class="job-card-title">
                                                                    <a href="RecruiterJobDetail?jobID=${job.jobId}">${job.title}</a>
                                                                </h3>
                                                                <div class="job-card-meta">
                                                                    <span class="job-type-badge">${job.jobType}</span>
                                                                </div>
                                                            </div>

                                                            <div class="job-card-details">
                                                                <div class="job-detail-item">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon-sm">
                                                                    <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"></path>
                                                                    <circle cx="12" cy="10" r="3"></circle>
                                                                    </svg>
                                                                    <span>${job.location}</span>
                                                                </div>

                                                                <div class="job-detail-item">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon-sm">
                                                                    <circle cx="12" cy="12" r="10"></circle>
                                                                    <path d="m16 12-4 4-4-4"></path>
                                                                    <path d="M12 8v8"></path>
                                                                    </svg>
                                                                    <span class="salary-range">
                                                                        <fmt:formatNumber value="${job.salaryMin}" type="number" groupingUsed="true" /> - 
                                                                        <fmt:formatNumber value="${job.salaryMax}" type="number" groupingUsed="true" /> VNĐ
                                                                    </span>
                                                                </div>

                                                                <div class="job-detail-item">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon-sm">
                                                                    <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                                                    <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                                                    </svg>
                                                                    <span>${job.experienceLevel}</span>
                                                                </div>
                                                            </div>

                                                            <div class="job-card-footer">
                                                                <div class="job-deadline">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon-sm">
                                                                    <circle cx="12" cy="12" r="10"></circle>
                                                                    <polyline points="12 6 12 12 16 14"></polyline>
                                                                    </svg>
                                                                    Hết hạn: 
                                                                    <fmt:parseDate value="${job.deadline}" pattern="yyyy-MM-dd" var="jobDeadlineDate" />
                                                                    <fmt:formatDate value="${jobDeadlineDate}" pattern="dd/MM/yyyy" />
                                                                </div>
                                                                <a href="RecruiterJobDetail?jobID=${job.jobId}" class="btn btn-primary btn-sm">
                                                                    Xem chi tiết
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-jobs-message">
                                                        <div class="no-jobs-icon">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                                            <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                                            <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                                            </svg>
                                                        </div>
                                                        <h3>Chưa có việc làm tương tự</h3>
                                                        <p>Hiện tại chưa có việc làm tương tự nào khác.</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </c:when>
                <c:otherwise>
                    <div class="error">
                        <h1>Trang việc không tồn tại!</h1>
                    </div>
                </c:otherwise>
            </c:choose>

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
            // Simple tabs functionality
            document.addEventListener('DOMContentLoaded', function () {
                const tabs = document.querySelectorAll('.tab');
                const tabContents = document.querySelectorAll('.tab-content');

                tabs.forEach(tab => {
                    tab.addEventListener('click', () => {
                        const tabId = tab.getAttribute('data-tab');

                        // Remove active class from all tabs and contents
                        tabs.forEach(t => t.classList.remove('active'));
                        tabContents.forEach(c => c.classList.remove('active'));

                        // Add active class to current tab and content
                        tab.classList.add('active');
                        document.getElementById(tabId).classList.add('active');
                    });
                });

                // Enhanced Interactive Features
                const bookmarkBtn = document.getElementById('bookmarkBtn');
                const moreActionsBtn = document.getElementById('moreActionsBtn');
                const dropdownMenu = document.getElementById('dropdownMenu');
                const shareBtn = document.getElementById('shareBtn');
                const copyLinkBtn = document.getElementById('copyLinkBtn');
                const reportBtn = document.getElementById('reportBtn');
                const shareModal = document.getElementById('shareModal');
                const closeShareModal = document.getElementById('closeShareModal');
                const toast = document.getElementById('toast');
                const toastMessage = document.getElementById('toastMessage');

                // Bookmark functionality
                let isBookmarked = false;
                if (bookmarkBtn) {
                    bookmarkBtn.addEventListener('click', function () {
                        isBookmarked = !isBookmarked;

                        if (isBookmarked) {
                            bookmarkBtn.classList.add('bookmarked');
                            bookmarkBtn.title = 'Bỏ lưu công việc';
                            showToast('Đã lưu công việc!');
                        } else {
                            bookmarkBtn.classList.remove('bookmarked');
                            bookmarkBtn.title = 'Lưu công việc';
                            showToast('Đã bỏ lưu công việc!');
                        }
                    });
                }

                // Dropdown functionality
                if (moreActionsBtn && dropdownMenu) {
                    moreActionsBtn.addEventListener('click', function (e) {
                        e.stopPropagation();
                        dropdownMenu.classList.toggle('show');
                    });

                    // Close dropdown when clicking outside
                    document.addEventListener('click', function (e) {
                        if (!moreActionsBtn.contains(e.target) && !dropdownMenu.contains(e.target)) {
                            dropdownMenu.classList.remove('show');
                        }
                    });
                }

                // Share functionality
                if (shareBtn && shareModal) {
                    shareBtn.addEventListener('click', function () {
                        dropdownMenu.classList.remove('show');
                        shareModal.classList.add('show');
                    });
                }

                // Copy link functionality
                if (copyLinkBtn) {
                    copyLinkBtn.addEventListener('click', function () {
                        let currentUrl = window.location.href;

                        // Convert Recruiter link to Candidate link
                        if (currentUrl.includes("RecruiterJobDetail")) {
                            currentUrl = currentUrl.replace("RecruiterJobDetail", "CandidateJobDetail");
                        }


                        if (navigator.clipboard) {
                            navigator.clipboard.writeText(currentUrl).then(function () {
                                showToast('Đã sao chép liên kết!');
                            }).catch(function () {
                                fallbackCopyTextToClipboard(currentUrl);
                            });
                        } else {
                            fallbackCopyTextToClipboard(currentUrl);
                        }

                        dropdownMenu.classList.remove('show');
                    });
                }

                // Fallback copy function for older browsers
                function fallbackCopyTextToClipboard(text) {
                    const textArea = document.createElement("textarea");
                    textArea.value = text;
                    textArea.style.position = "fixed";
                    textArea.style.left = "-999999px";
                    textArea.style.top = "-999999px";
                    document.body.appendChild(textArea);
                    textArea.focus();
                    textArea.select();

                    try {
                        document.execCommand('copy');
                        showToast('Đã sao chép liên kết!');
                    } catch (err) {
                        showToast('Không thể sao chép liên kết!');
                    }

                    document.body.removeChild(textArea);
                }

                // Report functionality
                if (reportBtn) {
                    reportBtn.addEventListener('click', function () {
                        if (confirm('Bạn có chắc chắn muốn báo cáo công việc này?')) {
                            showToast('Đã gửi báo cáo. Cảm ơn bạn!');
                        }
                        dropdownMenu.classList.remove('show');
                    });
                }

                // Share modal functionality
                if (closeShareModal && shareModal) {
                    closeShareModal.addEventListener('click', function () {
                        shareModal.classList.remove('show');
                    });

                    shareModal.addEventListener('click', function (e) {
                        if (e.target === shareModal) {
                            shareModal.classList.remove('show');
                        }
                    });
                }

                // Social sharing
                const shareOptions = document.querySelectorAll('.share-option');
                shareOptions.forEach(option => {
                    option.addEventListener('click', function () {
                        const platform = this.dataset.platform;
                        const url = encodeURIComponent(window.location.href);
                        const title = encodeURIComponent(document.title);

                        let shareUrl = '';

                        switch (platform) {
                            case 'facebook':
                                shareUrl = `https://www.facebook.com/sharer/sharer.php?u=${url}`;
                                break;
                            case 'linkedin':
                                shareUrl = `https://www.linkedin.com/sharing/share-offsite/?url=${url}`;
                                break;
                            case 'twitter':
                                shareUrl = `https://twitter.com/intent/tweet?url=${url}&text=${title}`;
                                break;
                            case 'email':
                                shareUrl = `mailto:?subject=${title}&body=${url}`;
                                break;
                        }

                        if (shareUrl) {
                            if (platform === 'email') {
                                window.location.href = shareUrl;
                            } else {
                                window.open(shareUrl, '_blank', 'width=600,height=400');
                            }
                            shareModal.classList.remove('show');
                            showToast('Đã mở cửa sổ chia sẻ!');
                        }
                    });
                });

                // Toast notification function
                function showToast(message) {
                    if (toastMessage && toast) {
                        toastMessage.textContent = message;
                        toast.classList.add('show');

                        setTimeout(function () {
                            toast.classList.remove('show');
                        }, 3000);
                    }
                }

                // Keyboard accessibility
                document.addEventListener('keydown', function (e) {
                    if (e.key === 'Escape') {
                        if (dropdownMenu)
                            dropdownMenu.classList.remove('show');
                        if (shareModal)
                            shareModal.classList.remove('show');
                    }
                });
            });
        </script>

    </body>
</html>