<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Modern Job Management Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <!-- Custom CSS -->
        <style>
            :root {
                --primary: #0046aa;
                --primary-dark: #4f46e5;
                --secondary: #0ea5e9;
                --success: #10b981;
                --warning: #f59e0b;
                --danger: #ef4444;
                --info: #3b82f6;
                --dark: #1e293b;
                --light: #f8fafc;
                --gray: #64748b;
            }

            body {
                background-color: #f1f5f9;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
                color: #334155;
            }

            .navbar {
                background: linear-gradient(270deg, #69b3ff, #1e3fa6 73.72%);
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            }

            .navbar-brand {
                font-weight: 700;
                letter-spacing: 0.5px;
            }

            .card {
                border: none;
                border-radius: 12px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
                transition: all 0.3s ease;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.08), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            }

            .stat-card {
                position: relative;
                overflow: hidden;
                z-index: 1;
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                width: 100px;
                height: 100px;
                background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1));
                border-radius: 50%;
                transform: translate(30%, -30%);
                z-index: -1;
            }

            .stat-card .icon {
                width: 48px;
                height: 48px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 12px;
                font-size: 1.5rem;
            }

            .stat-card .stat-title {
                font-size: 0.875rem;
                font-weight: 500;
                color: var(--gray);
                margin-bottom: 0.5rem;
            }

            .stat-card .stat-value {
                font-size: 1.75rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .stat-card .stat-desc {
                font-size: 0.75rem;
                color: var(--gray);
            }

            .btn-primary {
                background-color: var(--primary);
                border-color: var(--primary);
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

            .btn-outline-primary {
                color: var(--primary);
                border-color: var(--primary);
            }

            .btn-outline-primary:hover {
                background-color: var(--primary);
                border-color: var(--primary);
            }

            .table {
                border-collapse: separate;
                border-spacing: 0;
            }

            .table th {
                font-weight: 600;
                font-size: 0.875rem;
                color: var(--gray);
                border-bottom: 2px solid #e2e8f0;
                padding: 1rem;
            }

            .table td {
                padding: 1rem;
                vertical-align: middle;
                border-bottom: 1px solid #e2e8f0;
            }

            .table tr:last-child td {
                border-bottom: none;
            }

            .table tbody tr {
                transition: all 0.2s ease;
            }

            .table tbody tr:hover {
                background-color: rgba(99, 102, 241, 0.05);
            }

            .status-badge {
                padding: 0.35rem 0.75rem;
                border-radius: 50px;
                font-size: 0.75rem;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
            }

            .status-active {
                background-color: rgba(16, 185, 129, 0.1);
                color: var(--success);
            }

            .status-expired {
                background-color: rgba(239, 68, 68, 0.1);
                color: var(--danger);
            }

            .status-draft {
                background-color: rgba(100, 116, 139, 0.1);
                color: var(--gray);
            }

            .status-featured {
                background-color: rgba(245, 158, 11, 0.1);
                color: var(--warning);
            }

            .action-btn {
                width: 32px;
                height: 32px;
                padding: 0;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 8px;
                transition: all 0.2s ease;
            }

            .action-btn:hover {
                transform: translateY(-2px);
            }

            .search-box {
                position: relative;
            }

            .search-box i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--gray);
            }

            .search-box input {
                padding-left: 40px;
                border-radius: 8px;
                border: 1px solid #e2e8f0;
                background-color: #fff;
            }

            .search-box input:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
            }

            .filter-btn {
                border-radius: 8px;
                padding: 0.5rem 1rem;
                font-weight: 500;
                border: 1px solid #e2e8f0;
                background-color: #fff;
                color: var(--gray);
                transition: all 0.2s ease;
            }

            .filter-btn:hover {
                border-color: var(--primary);
                color: var(--primary);
            }

            .filter-btn.active {
                background-color: var(--primary);
                border-color: var(--primary);
                color: #fff;
            }

            .dropdown-menu {
                border: none;
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
                border-radius: 8px;
                padding: 0.5rem;
            }

            .dropdown-item {
                padding: 0.5rem 1rem;
                border-radius: 6px;
                transition: all 0.2s ease;
            }

            .dropdown-item:hover {
                background-color: rgba(99, 102, 241, 0.1);
                color: var(--primary);
            }

            .dropdown-item i {
                margin-right: 0.5rem;
            }

            .modal-content {
                border: none;
                border-radius: 12px;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            }

            .modal-header {
                border-bottom: 1px solid #e2e8f0;
                padding: 1.25rem 1.5rem;
            }

            .modal-footer {
                border-top: 1px solid #e2e8f0;
                padding: 1.25rem 1.5rem;
            }

            .form-label {
                font-weight: 500;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
            }

            .form-control, .form-select {
                padding: 0.5rem 0.75rem;
                border-radius: 8px;
                border: 1px solid #e2e8f0;
                font-size: 0.875rem;
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
            }

            .form-text {
                font-size: 0.75rem;
                color: var(--gray);
            }

            .form-check-input:checked {
                background-color: var(--primary);
                border-color: var(--primary);
            }

            .form-switch .form-check-input:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
            }

            .page-link {
                border: none;
                color: var(--gray);
                margin: 0 0.25rem;
                border-radius: 6px;
                padding: 0.375rem 0.75rem;
                font-size: 0.875rem;
            }

            .page-item.active .page-link {
                background-color: var(--primary);
                color: #fff;
            }

            .page-link:hover {
                background-color: rgba(99, 102, 241, 0.1);
                color: var(--primary);
            }

            .page-link:focus {
                box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
            }

            .avatar-group {
                display: flex;
            }

            .avatar-group .avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                border: 2px solid #fff;
                margin-left: -8px;
                object-fit: cover;
            }

            .avatar-group .avatar:first-child {
                margin-left: 0;
            }

            .avatar-group .avatar-more {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                background-color: #e2e8f0;
                color: var(--gray);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.75rem;
                font-weight: 600;
                margin-left: -8px;
                border: 2px solid #fff;
            }

            .job-title {
                font-weight: 600;
                color: #334155;
                margin-bottom: 0.25rem;
            }

            .job-meta {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: 0.75rem;
                font-size: 0.75rem;
                color: var(--gray);
            }

            .job-meta i {
                margin-right: 0.25rem;
            }

            .badge-featured {
                background-color: var(--warning);
                color: #fff;
                font-size: 0.65rem;
                padding: 0.2rem 0.5rem;
                border-radius: 4px;
                margin-left: 0.5rem;
            }

            .applicant-info {
                display: flex;
                align-items: center;
            }

            .applicant-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 0.75rem;
            }

            .applicant-name {
                font-weight: 500;
                margin-bottom: 0;
                font-size: 0.875rem;
            }

            .applicant-email {
                font-size: 0.75rem;
                color: var(--gray);
                margin-bottom: 0;
            }

            .section-title {
                font-size: 1rem;
                font-weight: 600;
                margin-bottom: 1rem;
                color: #334155;
            }

            .table-responsive {
                border-radius: 12px;
                overflow: hidden;
                background-color: #fff;
            }

            .notification-badge {
                position: absolute;
                top: 0;
                right: 0;
                transform: translate(25%, -25%);
                background-color: var(--danger);
                color: #fff;
                font-size: 0.65rem;
                width: 18px;
                height: 18px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                border: 2px solid #fff;
            }

            .user-avatar {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                object-fit: cover;
            }

            .nav-link {
                color: rgba(255, 255, 255, 0.8);
                padding: 0.5rem 1rem;
                border-radius: 8px;
                transition: all 0.2s ease;
            }

            .nav-link:hover, .nav-link.active {
                color: #fff;
                background-color: rgba(255, 255, 255, 0.1);
            }

            .nav-link i {
                margin-right: 0.5rem;
            }

            .dropdown-toggle::after {
                display: none;
            }

            .progress {
                height: 6px;
                border-radius: 3px;
                overflow: hidden;
            }

            .progress-bar {
                background-color: var(--primary);
            }

            .progress-sm {
                height: 4px;
            }

            .bg-light-primary {
                background-color: rgba(99, 102, 241, 0.1);
                color: var(--primary);
            }

            .bg-light-success {
                background-color: rgba(16, 185, 129, 0.1);
                color: var(--success);
            }

            .bg-light-warning {
                background-color: rgba(245, 158, 11, 0.1);
                color: var(--warning);
            }

            .bg-light-danger {
                background-color: rgba(239, 68, 68, 0.1);
                color: var(--danger);
            }

            .bg-light-info {
                background-color: rgba(59, 130, 246, 0.1);
                color: var(--info);
            }
            .mb-3 {
                margin-bottom: 0rem !important;
            }

            /* Responsive styles */
            @media (max-width: 1199px) {
                .table th, .table td {
                    padding: 0.75rem;
                }

                .action-btn {
                    width: 28px;
                    height: 28px;
                }
            }

            @media (max-width: 991px) {
                .filter-btn {
                    padding: 0.4rem 0.75rem;
                    font-size: 0.875rem;
                }

                .stat-card .icon {
                    width: 40px;
                    height: 40px;
                    font-size: 1.25rem;
                }

                .stat-card .stat-value {
                    font-size: 1.5rem;
                }
            }

            @media (max-width: 767px) {
                .container-fluid {
                    padding-left: 1rem;
                    padding-right: 1rem;
                }

                .table-responsive {
                    border-radius: 8px;
                    border: 1px solid rgba(0, 0, 0, 0.08);
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                    overflow: hidden;
                }

                .table th, .table td {
                    white-space: nowrap;
                }

                .job-title {
                    max-width: 150px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .card-footer {
                    flex-direction: column;
                    gap: 1rem;
                    align-items: flex-start !important;
                    border-top: 1px solid rgba(0, 0, 0, 0.08);
                    padding-top: 1rem;
                }

                .card-footer > div {
                    width: 100%;
                }

                .pagination {
                    justify-content: center;
                    width: 100%;
                    padding: 0.5rem;
                    background-color: #f8f9fa;
                    border-radius: 8px;
                }

                .filter-buttons-wrapper {
                    overflow-x: auto;
                    padding-bottom: 0.5rem;
                    margin-bottom: -0.5rem;
                    -webkit-overflow-scrolling: touch;
                    border: 1px solid rgba(0, 0, 0, 0.08);
                    border-radius: 8px;
                    padding: 0.5rem;
                    background-color: #fff;
                }

                .filter-buttons-container {
                    display: flex;
                    min-width: max-content;
                }

                /* Enhanced mobile card view */
                .job-card {
                    border: 1px solid rgba(0, 0, 0, 0.08);
                    border-radius: 12px;
                    padding: 1.25rem;
                    margin-bottom: 1rem;
                    background-color: #fff;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    transition: transform 0.2s ease, box-shadow 0.2s ease;
                }

                .job-card:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                }

                .job-card-header {
                    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                    padding-bottom: 0.75rem;
                    margin-bottom: 0.75rem;
                }

                .job-card-meta {
                    background-color: #f8f9fa;
                    border-radius: 8px;
                    padding: 0.75rem;
                    margin-bottom: 1rem;
                }

                .job-card-footer {
                    border-top: 1px solid rgba(0, 0, 0, 0.05);
                    padding-top: 1rem;
                    margin-top: 1rem;
                }

                .action-buttons-wrapper {
                    display: flex;
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .action-buttons-wrapper .btn {
                    border-radius: 8px;
                    border: 1px solid rgba(0, 0, 0, 0.1);
                }

                /* Stats cards with borders */
                .stat-card {
                    border: 1px solid rgba(0, 0, 0, 0.08);
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                }

                /* Search boxes with enhanced styling */
                .search-box input {
                    border: 1px solid rgba(0, 0, 0, 0.1);
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                }
            }

            @media (max-width: 575px) {
                .stat-card {
                    margin-bottom: 1rem;
                }

                .modal-footer {
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .modal-footer .btn {
                    width: 100%;
                }

                .applicant-email {
                    display: none;
                }

                .action-buttons-wrapper {
                    display: flex;
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .action-buttons-wrapper .dropdown {
                    width: 100%;
                }

                .action-buttons-wrapper .dropdown button {
                    width: 100%;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 0.5rem 1rem;
                    height: auto;
                }

                .action-buttons-wrapper .btn {
                    width: 100%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    padding: 0.5rem 1rem;
                    height: auto;
                }

                .action-buttons-wrapper .btn i {
                    margin-right: 0.5rem;
                }

                .table-mobile-view .table-header {
                    display: none;
                }

                .table-mobile-view .job-card {
                    margin-bottom: 1rem;
                    padding: 1rem;
                    border-radius: 8px;
                    background-color: #fff;
                    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                }

                .table-mobile-view .job-card-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                    margin-bottom: 0.75rem;
                }

                .table-mobile-view .job-card-title {
                    font-weight: 600;
                    font-size: 1rem;
                    margin-bottom: 0.25rem;
                }

                .table-mobile-view .job-card-meta {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 0.5rem;
                    margin-bottom: 0.75rem;
                    font-size: 0.75rem;
                }

                .table-mobile-view .job-card-meta-item {
                    display: flex;
                    align-items: center;
                }

                .table-mobile-view .job-card-meta-item i {
                    margin-right: 0.25rem;
                    font-size: 0.875rem;
                }

                .table-mobile-view .job-card-footer {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-top: 0.75rem;
                    padding-top: 0.75rem;
                    border-top: 1px solid #e2e8f0;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center" href="HomePage">
                    <i class="bi bi-briefcase-fill me-2"></i>
                    JobHub
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="HomePage">
                                <i class="bi bi-grid-1x2"></i> Trang chủ
                            </a>
                        </li>
<!--                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="bi bi-briefcase"></i> Jobs
                            </a>
                        </li>-->
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="bi bi-people"></i> Ứng viên
                            </a>
                        </li>
<!--                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="bi bi-bar-chart"></i> Analytics
                            </a>
                        </li>-->
<!--                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="bi bi-building"></i> Company
                            </a>
                        </li>-->
                    </ul>
<!--                    <div class="d-flex align-items-center">
                        <div class="dropdown me-3">
                            <a class="nav-link position-relative" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-bell fs-5"></i>
                                <span class="notification-badge">3</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end" style="width: 320px;">
                                <div class="d-flex justify-content-between align-items-center px-3 py-2">
                                    <h6 class="mb-0 fw-semibold">Notifications</h6>
                                    <a href="#" class="text-decoration-none text-primary small">Mark all as read</a>
                                </div>
                                <div class="dropdown-divider"></div>
                                <div class="notification-list" style="max-height: 300px; overflow-y: auto;">
                                    <a href="#" class="dropdown-item p-3 d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <div class="bg-light-primary rounded-circle p-2">
                                                <i class="bi bi-person-plus"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <p class="mb-0 fw-medium small">New application for Senior Developer</p>
                                            <p class="text-muted mb-0 small">10 minutes ago</p>
                                        </div>
                                    </a>
                                    <a href="#" class="dropdown-item p-3 d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <div class="bg-light-success rounded-circle p-2">
                                                <i class="bi bi-check-circle"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <p class="mb-0 fw-medium small">Job posting approved: UX Designer</p>
                                            <p class="text-muted mb-0 small">1 hour ago</p>
                                        </div>
                                    </a>
                                    <a href="#" class="dropdown-item p-3 d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <div class="bg-light-warning rounded-circle p-2">
                                                <i class="bi bi-calendar-event"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <p class="mb-0 fw-medium small">Interview scheduled with John Doe</p>
                                            <p class="text-muted mb-0 small">Tomorrow at 10:00 AM</p>
                                        </div>
                                    </a>
                                </div>
                                <div class="dropdown-divider"></div>
                                <a href="#" class="dropdown-item text-center text-primary small py-2">View all notifications</a>
                            </div>
                        </div>
                        <div class="dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                                <img src="https://ui-avatars.com/api/?name=Acme+Inc&background=6366f1&color=fff" class="user-avatar me-2" alt="Profile">
                                <span class="d-none d-sm-inline-block">Acme Inc</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Profile</a></li>
                                <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i>Settings</a></li>
                                <li><a class="dropdown-item" href="#"><i class="bi bi-question-circle me-2"></i>Help</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                            </ul>
                        </div>
                    </div>-->
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="container-fluid px-4 py-4">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                <div>
                    <h1 class="mb-1 fw-bold">Quản lý tuyển dụng</h1>
                    <p class="text-muted mb-0">Quản lý và theo dõi tất cả các tin tuyển dụng của bạn</p>
                </div>
                <div>
                    <a href="JobPostingPage" class="btn btn-primary w-100 w-md-auto">
                        <i class="bi bi-plus-lg me-2"></i>Đăng tin tuyển dụng mới
                    </a>
                </div>
            </div>

            <!-- Dashboard Summary -->
            <div class="row g-4 mb-4">
                <div class="col-6 col-md-3">
                    <div class="card stat-card h-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="icon bg-light-primary me-3">
                                    <i class="bi bi-briefcase"></i>
                                </div>
                                <div>
                                    <div class="stat-title">Tổng số tin tuyển dụng</div>
                                    <div class="stat-value">${listtotalJobsJobPosts}</div>
                                </div>
                            </div>
                            <!--                            <div class="d-flex align-items-center">
                                                            <span class="text-success me-2"><i class="bi bi-arrow-up"></i> 12%</span>
                                                            <span class="stat-desc">from last month</span>
                                                        </div>-->
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="card stat-card h-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="icon bg-light-success me-3">
                                    <i class="bi bi-check-circle"></i>
                                </div>
                                <div>
                                    <div class="stat-title">Tin đang tuyển</div>
                                    <div class="stat-value">${listtotalJobsJobPostsActive}</div>
                                </div>
                            </div>
                            <!--                            <div class="d-flex align-items-center">
                                                            <span class="text-success me-2"><i class="bi bi-arrow-up"></i> 5%</span>
                                                            <span class="stat-desc">from last month</span>
                                                        </div>-->
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="card stat-card h-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="icon bg-light-warning me-3">
                                    <i class="bi bi-people"></i>
                                </div>
                                <div>
                                    <div class="stat-title">Tổng số ứng viên</div>
                                    <div class="stat-value">25</div>
                                </div>
                            </div>
                            <!--                            <div class="d-flex align-items-center">
                                                            <span class="text-success me-2"><i class="bi bi-arrow-up"></i> 18%</span>
                                                            <span class="stat-desc">from last month</span>
                                                        </div>-->
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="card stat-card h-100">
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="icon bg-light-danger me-3">
                                    <i class="bi bi-clock-history"></i>
                                </div>
                                <div>
                                    <div class="stat-title">Sắp hết hạn</div>
                                    <div class="stat-value">3</div>
                                </div>
                            </div>
                            <!--                            <div class="d-flex align-items-center">
                                                            <span class="text-danger me-2"><i class="bi bi-arrow-down"></i> 2%</span>
                                                            <span class="stat-desc">from last month</span>
                                                        </div>-->
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filter and Search -->
            <form action="FilterJobPostingPage" method="post">
                <div class="card mb-4"> 
                    <div class="card-body">
                        <div class="row g-3 align-items-md-center" style="margin-left: 20%;">
                            <!-- Search -->
                            <div class="col-md-7 col-sm-6">
                                <!--<label class="form-label">Search</label>-->
                                <div class="input-group">
                                    <button class="input-group-text"><i class="bi bi-search"></i></button>
                                    <input type="text" name="search" value="${requestScope.search}" class="form-control" placeholder="Tìm kiếm tên công việc...">
                                </div>
                            </div>
                            <!-- Submit Button -->
                            <div class="col-md-2 col-sm-4">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bi bi-search me-1"></i> Lọc kết quả
                                </button>
                            </div>
                            <%--
                                            <!-- Position Filter -->
                                            <div class="col-md-2 col-sm-6" style="width: 150px;">
                                                <!--<label class="form-label">Position</label>-->
                                                <select class="form-select" name="position" onchange="this.form.submit()">
                                                    <option value="">Tất cả vị trí</option>
                                                    <c:forEach var="a" items="${listPositionJobPost}">
                                                        <option value="${a.getLocation()}"
                                                                <c:if test="${requestScope.position == a.getLocation()}">selected</c:if>
                                                                >${a.getLocation()}</option>
                                                    </c:forEach>

                                </select>
                            </div>

                            <!-- Location Filter -->
                            <div class="col-md-2 col-sm-6" style="width: 150px;">
                                <!--<label class="form-label">Location</label>-->
                                <select class="form-select" name="location" onchange="this.form.submit()">

                                    <option value="">Tất cả địa điểm</option>
                                    <c:forEach var="a" items="${listLocationJobPost}">
                                        <option value="${a.getLocation()}"
                                                <c:if test="${requestScope.location == a.getLocation()}">selected</c:if>
                                                >${a.getLocation()}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Sort Filter -->
                            <div class="col-md-2 col-sm-6"  style="width: 150px;">
                                <!--<label class="form-label">Sort By</label>-->
                                <select class="form-select" name="sort" onchange="this.form.submit()">
                                    <option value="">Mặc định</option>
                                    <option value="date_asc" <c:if test="${requestScope.sort == 'date_asc'}">selected</c:if>>Date ↑</option>
                                    <option value="date_desc" <c:if test="${requestScope.sort == 'date_desc'}">selected</c:if> >Date ↓</option>
                                    <option value="salary_asc" <c:if test="${requestScope.sort == 'salary_asc'}">selected</c:if> >Salary ↑</option>
                                    <option value="salary_desc" <c:if test="${requestScope.sort == 'salary_desc'}">selected</c:if> >Salary ↓</option>
                                    </select>
                                </div>

                                <!-- Buttons & Export -->
                                <div class="col-md-5 col-sm-6">
                                    <div class="d-flex flex-wrap gap-2 justify-content-md-end">
                                        <button class="filter-btn <c:if test='${empty requestScope.status}'>active</c:if>" name="status">Tất cả</button>
                                    <c:forEach var="a" items="${listStatusJobPost}">
                                        <button class="filter-btn <c:if test='${requestScope.status == a.getLocation()}'>active</c:if>" name="status" value="${a.getLocation()}">${a.getLocation()}</button>
                                    </c:forEach>
                                    <!--                                    <div class="dropdown">
                                                                            <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                                                <i class="bi bi-download me-1"></i> Export
                                                                            </button>
                                                                            <ul class="dropdown-menu dropdown-menu-end">
                                                                                <li><a class="dropdown-item" href="#"><i class="bi bi-file-earmark-excel"></i> Excel</a></li>
                                                                                <li><a class="dropdown-item" href="#"><i class="bi bi-file-earmark-pdf"></i> PDF</a></li>
                                                                                <li><a class="dropdown-item" href="#"><i class="bi bi-file-earmark-text"></i> CSV</a></li>
                                                                            </ul>
                                                                        </div>-->
                                </div>
                            </div>
                            --%>
                        </div>
                    </div>
                </div>
            </form>

            <c:if test="${not empty errors}">
                <div id="alertError" class="alert alert-danger">
                    <ul>
                        <c:forEach var="err" items="${errors}">
                            <li>${err}</li>
                            </c:forEach>
                    </ul>
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div id="alertSuccess" class="alert alert-success">
                    <li>${message}</li>
                </div>
            </c:if>
            <%--            
            <p>Position: ${position}</p>
            <p>Selected JobTypes: ${selectedJobTypes}</p>
            <p>Selected Experience Levels: ${selectedExperienceLevels}</p>
            <p>Selected Industries: ${selectedIndustries}</p>
            <p>Selected Statuses: ${selectedStatuses}</p> --%>
            <div class="row">

                <div class="col-md-2 card mb-4">
                    <div class="card-body">
                        <form action="FilterJobPostingPage" method="post">
                            <h5 style="text-align: center;">Bộ Lọc</h5>
                            <!-----Loc Position----->
                            <label class="form-label" style="margin-top: 5px;">Vị trí công việc</label>
                            <select class="form-select" name="position">
                                <option value="">Tất cả vị trí</option>
                                <c:forEach var="a" items="${listPositionJobPost}">
                                    <option value="${a.getLocation()}"
                                            <c:if test="${requestScope.position == a.getLocation()}">selected</c:if>
                                            >${a.getLocation()}</option>
                                </c:forEach>
                            </select>

                            <!-----Loc cong viec----->
                            <label class="form-label" style="margin-top: 15px;">Loại công việc</label>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="jobType" value="Toàn thời gian" <c:if test="${fn:contains(selectedJobTypes, 'Toàn thời gian')}">checked</c:if> id="jobType1">
                                    <label class="form-check-label" for="jobType1">Toàn thời gian</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="jobType" value="Bán thời gian" <c:if test="${fn:contains(selectedJobTypes, 'Bán thời gian')}">checked</c:if> id="jobType2">
                                    <label class="form-check-label" for="jobType2">Bán thời gian</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="jobType" value="Hợp đồng" <c:if test="${fn:contains(selectedJobTypes, 'Hợp đồng')}">checked</c:if> id="jobType3">
                                    <label class="form-check-label" for="jobType3">Hợp đồng</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="jobType" value="Tự do" <c:if test="${fn:contains(selectedJobTypes, 'Tự do')}">checked</c:if> id="jobType4">
                                    <label class="form-check-label" for="jobType4">Tự do</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="jobType" value="Thực tập" <c:if test="${fn:contains(selectedJobTypes, 'Thực tập')}">checked</c:if> id="jobType5">
                                    <label class="form-check-label" for="jobType5">Thực tập</label>
                                </div>

                                <!-----Loc Location----->
                                <label class="form-label" style="margin-top: 15px;">Địa điểm</label>
                                <select class="form-select" name="location">

                                    <option value="">Tất cả địa điểm</option>
                                <c:forEach var="a" items="${listLocationJobPost}">
                                    <option value="${a.getLocation()}"
                                            <c:if test="${requestScope.location == a.getLocation()}">selected</c:if>
                                            >${a.getLocation()}</option>
                                </c:forEach>
                            </select>
                            <!-----Loc kinh nghiem----->
                            <label class="form-label" style="margin-top: 15px;">Cấp độ kinh nghiệm</label>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="experienceLevel" value="Mới vào nghề (0-1 năm)" <c:if test="${fn:contains(selectedExperienceLevels, 'Mới vào nghề (0-1 năm)')}">checked</c:if> id="exp1">
                                    <label class="form-check-label" for="exp1">Mới vào nghề</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="experienceLevel" value="Nhân viên sơ cấp (1-3 năm)" <c:if test="${fn:contains(selectedExperienceLevels, 'Nhân viên sơ cấp (1-3 năm)')}">checked</c:if> id="exp2">
                                    <label class="form-check-label" for="exp2">Nhân viên sơ cấp</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="experienceLevel" value="Trung cấp (3-5 năm)" <c:if test="${fn:contains(selectedExperienceLevels, 'Trung cấp (3-5 năm)')}">checked</c:if> id="exp3">
                                    <label class="form-check-label" for="exp3">Trung cấp</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="experienceLevel" value="Cao cấp (trên 5 năm)" <c:if test="${fn:contains(selectedExperienceLevels, 'Cao cấp (trên 5 năm)')}">checked</c:if> id="exp4">
                                    <label class="form-check-label" for="exp4">Cao cấp</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="experienceLevel" value="Quản lý" <c:if test="${fn:contains(selectedExperienceLevels, 'Quản lý')}">checked</c:if> id="exp5">
                                    <label class="form-check-label" for="exp5">Quản lý</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="experienceLevel" value="Điều hành" <c:if test="${fn:contains(selectedExperienceLevels, 'Điều hành')}">checked</c:if> id="exp6">
                                    <label class="form-check-label" for="exp6">Điều hành</label>
                                </div>
                                <!-----Loc linh vuc----->
                            <%--                   <c:forEach var="item" items="${selectedIndustries}">
                                                   <p>'${item}'</p>
                                               </c:forEach> --%>
                            <label class="form-label" style="margin-top: 15px;">Lĩnh vực</label>
                            <c:forEach var="a" items="${listIndustries}" varStatus="loop">
                                <c:set var="isChecked" value="false" />
                                <c:forEach var="id" items="${selectedIndustries}">
                                    <c:if test="${id == a.getIndustryId()}">
                                        <c:set var="isChecked" value="true" />
                                    </c:if>
                                </c:forEach>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="industry" value="${a.getIndustryId()}"
                                           <c:if test="${isChecked}">checked</c:if>
                                           id="industry${loop.index}">
                                    <label class="form-check-label" for="industry${loop.index}">${a.getNameIndustry()}</label>
                                </div>
                            </c:forEach>
                            <!-----Loc trang thai----->
                            <label class="form-label" style="margin-top: 15px;">Trạng thái</label>
                            <c:forEach var="a" items="${listStatusJobPost}" varStatus="loop">
                                <c:set var="isChecked" value="false" />
                                <c:forEach var="id" items="${selectedStatuses}">
                                    <c:if test="${id == a.getLocation()}">
                                        <c:set var="isChecked" value="true" />
                                    </c:if>
                                </c:forEach>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="status" value="${a.getLocation()}"
                                           <c:if test="${isChecked}">checked</c:if>
                                           id="status${loop.index}">
                                    <label class="form-check-label" for="status${loop.index}">${a.getLocation()}</label>
                                </div>
                            </c:forEach>
                            <!-----Loc sắp xếp----->
                            <label class="form-label" style="margin-top: 15px;">Sắp xếp</label>
                            <select class="form-select" name="sort">
                                <option value="">Mặc định</option>
                                <option value="date_asc" <c:if test="${requestScope.sort == 'date_asc'}">selected</c:if>>Ngày ↑</option>
                                <option value="date_desc" <c:if test="${requestScope.sort == 'date_desc'}">selected</c:if> >Ngày ↓</option>
                                <option value="salary_asc" <c:if test="${requestScope.sort == 'salary_asc'}">selected</c:if> >Lương ↑</option>
                                <option value="salary_desc" <c:if test="${requestScope.sort == 'salary_desc'}">selected</c:if> >Lương ↓</option>
                                </select>
                                <div class="col-md-8 d-flex align-items-center" style="margin-left: 12%;margin-top: 15px;">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="bi bi-funnel"></i> Lọc tất cả
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>                        
                    <!-- Jobs Table - Desktop View -->
                    <div class="col-md-10">
                        <div class="card d-none d-md-block">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table mb-0">
                                        <thead>
                                            <tr>
                                                <!--                                    <th>
                                                                                        <div class="form-check">
                                                                                            <input class="form-check-input" type="checkbox" id="selectAll">
                                                                                            <label class="form-check-label" for="selectAll"></label>
                                                                                        </div>
                                                                                    </th>-->
                                                <th style="width: 30%">Tên công việc</th>
                                                <th>Vị trí</th>
                                                <th>Địa điểm</th>
                                                <!--                                            <th>Ngày đăng</th>-->
                                                <th>Hạn cuối</th>
                                                <th>Trạng thái</th>
                                                <!--                                                <th>Ứng viên</th>-->
                                                <th class="text-center">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="a" items="${listJobPost}">
                                            <tr>
                                                <!--                                        <td>
                                                                                            <div class="form-check">
                                                                                                <input class="form-check-input" type="checkbox">
                                                                                                <label class="form-check-label"></label>
                                                                                            </div>
                                                                                        </td>-->
                                                <td>
                                                    <div>
                                                        <div class="job-title d-flex align-items-center">
                                                            ${a.getTitle()}
                                                            <!--                                                <span class="badge-featured ms-2">Featured</span>-->
                                                        </div>
                                                        <div class="job-meta">
                                                            <span><i class="bi bi-clock"></i> ${a.getJobType()}</span>
                                                            <span><i class="bi bi-currency-dollar"></i> ${a.getFormattedSalaryMin()}-${a.getFormattedSalaryMax()} đ</span>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${a.getJobPosition()}</td>
                                                <td>${a.getLocation()}</td>
                                                <%--           <td>${a.getCreatedAt()}</td> --%>
                                                <td>${a.dateDaealine()}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${a.status == 'Active'}">
                                                            <span class="badge" style="background-color: #d4edda; color: #155724;font-size: 0.9rem;">
                                                                <i class="bi bi-check-circle-fill"></i> Active
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${a.status == 'Pending'}">
                                                            <span class="badge" style="background-color: #fff3cd; color: #856404;font-size: 0.9rem;">
                                                                <i class="bi bi-hourglass-split"></i> Pending
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${a.status == 'Rejected'}">
                                                            <span class="badge" style="background-color: #f8d7da; color: #721c24;font-size: 0.9rem;">
                                                                <i class="bi bi-x-circle-fill"></i> Rejected
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${a.status == 'Expired'}">
                                                            <span class="badge" style="background-color: #e2e3e5; color: #6c757d;font-size: 0.9rem;">
                                                                <i class="bi bi-exclamation-circle-fill"></i> Expired
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge" style="background-color: #fefefe; color: #333;font-size: 0.9rem;">
                                                                <i class="bi bi-question-circle-fill"></i> ${a.status}
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>


                                                <%--      <td><span class="status-badge status-active"><i class="bi bi-circle-fill"></i> ${a.getStatus()}</span></td>  --%>
                                                <!--                                                <td>
                                                                                                    <div class="d-flex align-items-center">
                                                                                                        <div class="avatar-group me-2">
                                                                                                            <img src="https://ui-avatars.com/api/?name=J+D&background=6366f1&color=fff" class="avatar" alt="Applicant">
                                                                                                                                                                        <img src="https://ui-avatars.com/api/?name=S+M&background=0ea5e9&color=fff" class="avatar" alt="Applicant">
                                                                                                                                                                        <img src="https://ui-avatars.com/api/?name=A+B&background=f59e0b&color=fff" class="avatar" alt="Applicant">
                                                                                                            <div class="avatar-more">+21</div>
                                                                                                        </div>
                                                                                                        <span>24</span>
                                                                                                    </div>
                                                                                                </td>-->
                                                <td>
                                                    <div class="d-flex justify-content-end">
<!--                                                        <button class="btn btn-sm btn-outline-primary action-btn me-1" title="View Applicants" data-bs-toggle="modal" data-bs-target="#applicantsModal">
                                                            <i class="bi bi-people"></i>
                                                        </button>-->
                                                        <form action="ViewJobPostEdit" method="post">
                                                            <input type="hidden" name="jobId" value="${a.getJobId()}">
                                                            <!-- Hidden inputs to preserve filter states -->
                                                            <input type="hidden" name="searchONE" value="${requestScope.search}">
                                                            <input type="hidden" name="positionONE" value="${requestScope.position}">
                                                            <input type="hidden" name="locationONE" value="${requestScope.location}">
                                                            <input type="hidden" name="sortONE" value="${requestScope.sort}">
                                                            <input type="hidden" name="pageONE" value="${requestScope.page}">
                                                            <input type="hidden" name="numONE" value="${requestScope.num}">

                                                            <c:forEach var="stat" items="${selectedStatuses}">
                                                                <input type="hidden" name="statusONE" value="${stat}" />
                                                            </c:forEach>

                                                            <c:forEach var="jobType" items="${selectedJobTypes}">
                                                                <input type="hidden" name="jobTypeONE" value="${jobType}" />
                                                            </c:forEach>

                                                            <c:forEach var="exp" items="${selectedExperienceLevels}">
                                                                <input type="hidden" name="experienceLevelONE" value="${exp}" />
                                                            </c:forEach>

                                                            <c:forEach var="ind" items="${selectedIndustries}">
                                                                <input type="hidden" name="industryONE" value="${ind}" />
                                                            </c:forEach>
                                                            <button class="btn btn-sm btn-outline-secondary action-btn me-1" title="Sửa bài đăng" 
                                                                    <%--                                    data-bs-toggle="modal" data-bs-target="#editJobModal"
                                                                                                        data-id="${a.getJobId()}"
                                                                                                        data-title="${a.getTitle()}"
                                                                                                        data-department="${a.getJobPosition()}"
                                                                                                        data-location="${a.getLocation()}"
                                                                                                        data-type="${a.getJobType()}"
                                                                                                        data-experiencelevel="${a.getExperienceLevel()}"
                                                                                                        data-minsalary="${a.getSalaryMin()}"
                                                                                                        data-maxsalary="${a.getSalaryMax()}"
                                                                                                        data-deadline="${a.getDeadline()}"
                                                                                                        data-description="${a.getDescription()}"
                                                                                                        data-requirements="${a.getRequirement()}"
                                                                                                        data-benefits="${a.getBenefit()}"
                                                                                                        data-industryid="${a.getIndustry().getIndustryId()}" --%>

                                                                    >
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                        </form>
                                                        <div class="dropdown">
                                                                                                                        <button class="btn btn-sm btn-outline-secondary action-btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                                                                                            <i class="bi bi-three-dots"></i>
                                                                                                                        </button>
                                                            <ul class="dropdown-menu dropdown-menu-end">
<!--                                                                <li><a class="dropdown-item" href="#"><i class="bi bi-eye"></i> View Details</a></li>-->
                                                                <!--                                                        <li><a class="dropdown-item" href="#"><i class="bi bi-star"></i> Unfeature Job</a></li>
                                                                                                                        <li><a class="dropdown-item" href="#"><i class="bi bi-toggle-off"></i> Deactivate</a></li>
                                                                                                                        <li><a class="dropdown-item" href="#"><i class="bi bi-files"></i> Duplicate</a></li>
                                                                                                                        <li><a class="dropdown-item" href="#"><i class="bi bi-share"></i> Share</a></li>-->
                                                                <li><hr class="dropdown-divider"></li>
                                                                <li><a class="dropdown-item text-danger" href="#" data-bs-toggle="modal" data-bs-target="#deleteModal"
                                                                       data-id="${a.getJobId()}"
                                                                       data-title="${a.getTitle()}">
                                                                        <i class="bi bi-trash"></i> Xóa</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        <!-- More table rows would go here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="card-footer d-flex justify-content-end align-items-center">
                            <form method="post" action="FilterJobPostingPage">
                                <!-- Hidden inputs to preserve filter states -->
                                <input type="hidden" name="search" value="${requestScope.search}">
                                <input type="hidden" name="position" value="${requestScope.position}">
                                <input type="hidden" name="location" value="${requestScope.location}">
                                <input type="hidden" name="sort" value="${requestScope.sort}">


                                <c:forEach var="stat" items="${selectedStatuses}">
                                    <input type="hidden" name="status" value="${stat}" />
                                </c:forEach>

                                <c:forEach var="jobType" items="${selectedJobTypes}">
                                    <input type="hidden" name="jobType" value="${jobType}" />
                                </c:forEach>

                                <c:forEach var="exp" items="${selectedExperienceLevels}">
                                    <input type="hidden" name="experienceLevel" value="${exp}" />
                                </c:forEach>

                                <c:forEach var="ind" items="${selectedIndustries}">
                                    <input type="hidden" name="industry" value="${ind}" />
                                </c:forEach>
                                <ul class="pagination pagination-sm mb-0">

                                    <!-- Previous page -->
                                    <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                        <button type="submit" name="page" value="${page - 1}" class="page-link" ${page == 1 ? 'disabled' : ''} aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </button>
                                    </li>

                                    <!-- Page numbers -->
                                    <c:forEach var="i" begin="1" end="${num}">
                                        <li class="page-item ${i == page ? 'active' : ''}">
                                            <button type="submit" name="page" value="${i}" class="page-link">${i}</button>
                                        </li>
                                    </c:forEach>

                                    <!-- Next page -->
                                    <li class="page-item ${page == num ? 'disabled' : ''}">
                                        <button type="submit" name="page" value="${page + 1}" class="page-link" ${page == num ? 'disabled' : ''} aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </button>
                                    </li>
                                </ul>
                            </form>
                        </div>


                    </div>
                </div>
            </div>
            <!-- Jobs Mobile View -->
            <div class="d-md-none table-mobile-view">
                <!-- Job Card 1 -->
                <div class="job-card">
                    <div class="job-card-header">
                        <div>
                            <div class="job-card-title">Senior Software Engineer</div>
                            <div class="d-flex align-items-center">
                                <span class="status-badge status-active me-2"><i class="bi bi-circle-fill"></i> Active</span>
                                <span class="badge-featured">Featured</span>
                            </div>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox">
                        </div>
                    </div>

                    <div class="job-card-meta">
                        <div class="job-card-meta-item"><i class="bi bi-building"></i> Engineering</div>
                        <div class="job-card-meta-item"><i class="bi bi-geo-alt"></i> San Francisco, CA</div>
                        <div class="job-card-meta-item"><i class="bi bi-clock"></i> Full-time</div>
                        <div class="job-card-meta-item"><i class="bi bi-currency-dollar"></i> $120k-$150k</div>
                        <div class="job-card-meta-item"><i class="bi bi-calendar"></i> May 1, 2023</div>
                        <div class="job-card-meta-item"><i class="bi bi-calendar-x"></i> Jun 1, 2023</div>
                    </div>

                    <div class="d-flex align-items-center">
                        <div class="avatar-group me-2">
                            <img src="https://ui-avatars.com/api/?name=J+D&background=6366f1&color=fff" class="avatar" alt="Applicant">
                            <img src="https://ui-avatars.com/api/?name=S+M&background=0ea5e9&color=fff" class="avatar" alt="Applicant">
                            <img src="https://ui-avatars.com/api/?name=A+B&background=f59e0b&color=fff" class="avatar" alt="Applicant">
                            <div class="avatar-more">+21</div>
                        </div>
                        <span>24 Applicants</span>
                    </div>

                    <div class="job-card-footer">
                        <div class="action-buttons-wrapper">
                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#applicantsModal">
                                <i class="bi bi-people"></i> View Applicants
                            </button>
                            <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#editJobModal">
                                <i class="bi bi-pencil"></i> Edit Job
                            </button>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-three-dots"></i> More Actions
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-eye"></i> View Details</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-star"></i> Unfeature Job</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-toggle-off"></i> Deactivate</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-files"></i> Duplicate</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-share"></i> Share</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="#" data-bs-toggle="modal" data-bs-target="#deleteModal"><i class="bi bi-trash"></i> Delete</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Job Card 2 -->
                <div class="job-card">
                    <div class="job-card-header">
                        <div>
                            <div class="job-card-title">Product Manager</div>
                            <div class="d-flex align-items-center">
                                <span class="status-badge status-active me-2"><i class="bi bi-circle-fill"></i> Active</span>
                            </div>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox">
                        </div>
                    </div>

                    <div class="job-card-meta">
                        <div class="job-card-meta-item"><i class="bi bi-building"></i> Product</div>
                        <div class="job-card-meta-item"><i class="bi bi-geo-alt"></i> New York, NY</div>
                        <div class="job-card-meta-item"><i class="bi bi-clock"></i> Full-time</div>
                        <div class="job-card-meta-item"><i class="bi bi-currency-dollar"></i> $100k-$130k</div>
                        <div class="job-card-meta-item"><i class="bi bi-calendar"></i> Apr 15, 2023</div>
                        <div class="job-card-meta-item"><i class="bi bi-calendar-x"></i> May 15, 2023</div>
                    </div>

                    <div class="d-flex align-items-center">
                        <div class="avatar-group me-2">
                            <img src="https://ui-avatars.com/api/?name=R+S&background=6366f1&color=fff" class="avatar" alt="Applicant">
                            <img src="https://ui-avatars.com/api/?name=T+W&background=0ea5e9&color=fff" class="avatar" alt="Applicant">
                            <div class="avatar-more">+16</div>
                        </div>
                        <span>18 Applicants</span>
                    </div>

                    <div class="job-card-footer">
                        <div class="action-buttons-wrapper">
                            <button class="btn btn-sm btn-outline-primary">
                                <i class="bi bi-people"></i> View Applicants
                            </button>
                            <button class="btn btn-sm btn-outline-secondary">
                                <i class="bi bi-pencil"></i> Edit Job
                            </button>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-three-dots"></i> More Actions
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-eye"></i> View Details</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-star"></i> Feature Job</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-toggle-off"></i> Deactivate</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-files"></i> Duplicate</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="bi bi-share"></i> Share</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-trash"></i> Delete</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pagination for mobile -->
                <div class="d-flex justify-content-between align-items-center mt-4 flex-column flex-sm-row gap-3">
                    <div>
                        <span class="text-muted">Showing 1 to 2 of 15 entries</span>
                    </div>
                    <nav>
                        <ul class="pagination pagination-sm mb-0">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <form action="DeleteJobPostingPage" method="post">
            <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Xác nhận xóa</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body text-center">
                            <div class="mb-4">
                                <div class="bg-light-danger p-3 rounded-circle d-inline-flex mb-3">
                                    <i class="bi bi-exclamation-triangle-fill text-danger fs-1"></i>
                                </div>

                                <input type="text" id="deleteJobId" name="jobId" hidden>

                                <h4 class="mb-2">Bạn có chắc không</h4>
                                <p class="text-muted">Bạn sắp xóa tin tuyển dụng này "<span id="modal-job-title"></span>". Hành động này không thể hoàn tác.</p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Xóa tin tuyển dụng</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <%--
                <!-- Edit Job Modal -->
                <form action="EditJobPostingPage" method="post">
                    <div class="modal fade" id="editJobModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-scrollable">
                            <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title">Chỉnh sửa tin tuyển dụng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">

                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Thông tin cơ bản</h6>
                                <div class="row g-3">
                                    <input type="hidden" class="form-control" name="action" value="ManageJobPost">
                                    <input type="hidden" class="form-control" id="editJobId" name="jobId">
                                    <div class="col-md-6">
                                        <label for="editJobTitle" class="form-label">Tên công việc <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="editJobTitle" name="jobTitle" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="industry" class="form-label required-field">Ngành nghề</label>
                                        <select class="form-select" id="editIndustry" name="industry" required>
                                            <option value="">-- Chọn ngành nghề --</option>
                                            <c:forEach var="a" items="${listIndustries}">
                                                <option value="${a.getIndustryId()}">${a.getNameIndustry()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="editDepartment" class="form-label">Vị trí công việc <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="editDepartment" name="jobPosition" required>

                                    </div>
                                    <div class="col-md-6">
                                        <label for="editLocation" class="form-label">Địa điểm <span class="text-danger">*</span></label>
                                        <!--<input type="text" class="form-control" id="editLocation" name="location" required>-->
                                        <select name="location" id="editLocation" required
                                                class="form-select block w-full max-w-sm p-2 border border-gray-300 rounded-md text-sm">
                                            <option value="">-- Chọn tỉnh/thành phố --</option>

                                            <!-- Thành phố trước -->
                                            <option value="Hà Nội">Thành phố Hà Nội</option>
                                            <option value="Hồ Chí Minh">Thành phố Hồ Chí Minh</option>
                                            <option value="Đà Nẵng">Thành phố Đà Nẵng</option>
                                            <option value="Hải Phòng">Thành phố Hải Phòng</option>
                                            <option value="Cần Thơ">Thành phố Cần Thơ</option>
                                            <option value="Huế">Thành phố Huế</option>

                                            <!-- Các tỉnh còn lại -->
                                            <option value="Lai Châu">Tỉnh Lai Châu</option>
                                            <option value="Điện Biên">Tỉnh Điện Biên</option>
                                            <option value="Sơn La">Tỉnh Sơn La</option>
                                            <option value="Lạng Sơn">Tỉnh Lạng Sơn</option>
                                            <option value="Quảng Ninh">Tỉnh Quảng Ninh</option>
                                            <option value="Thanh Hoá">Tỉnh Thanh Hoá</option>
                                            <option value="Nghệ An">Tỉnh Nghệ An</option>
                                            <option value="Hà Tĩnh">Tỉnh Hà Tĩnh</option>
                                            <option value="Cao Bằng">Tỉnh Cao Bằng</option>
                                            <option value="Tuyên Quang">Tỉnh Tuyên Quang</option>
                                            <option value="Lào Cai">Tỉnh Lào Cai</option>
                                            <option value="Thái Nguyên">Tỉnh Thái Nguyên</option>
                                            <option value="Phú Thọ">Tỉnh Phú Thọ</option>
                                            <option value="Bắc Ninh">Tỉnh Bắc Ninh</option>
                                            <option value="Hưng Yên">Tỉnh Hưng Yên</option>
                                            <option value="Ninh Bình">Tỉnh Ninh Bình</option>
                                            <option value="Quảng Trị">Tỉnh Quảng Trị</option>
                                            <option value="Quảng Ngãi">Tỉnh Quảng Ngãi</option>
                                            <option value="Gia Lai">Tỉnh Gia Lai</option>
                                            <option value="Khánh Hoà">Tỉnh Khánh Hoà</option>
                                            <option value="Lâm Đồng">Tỉnh Lâm Đồng</option>
                                            <option value="Đắk Lắk">Tỉnh Đắk Lắk</option>
                                            <option value="Đồng Nai">Tỉnh Đồng Nai</option>
                                            <option value="Tây Ninh">Tỉnh Tây Ninh</option>
                                            <option value="Vĩnh Long">Tỉnh Vĩnh Long</option>
                                            <option value="Đồng Tháp">Tỉnh Đồng Tháp</option>
                                            <option value="Cà Mau">Tỉnh Cà Mau</option>
                                            <option value="Kiên Giang">Tỉnh Kiên Giang</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="editEmploymentType" class="form-label">Hình thức làm việc <span class="text-danger">*</span></label>
                                        <!--<input type="text" class="form-control" id="editEmploymentType" name="jobType" required>-->
                                        <select class="form-select" id="editEmploymentType" name="jobType" required>
                                            <option value="" selected disabled>Chọn loại công việc</option>
                                            <option value="Toàn thời gian">Toàn thời gian</option>
                                            <option value="Bán thời gian">Bán thời gian</option>
                                            <option value="Hợp đồng">Hợp đồng</option>
                                            <option value="Tự do">Tự do</option>
                                            <option value="Thực tập">Thực tập</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="editMinSalary" class="form-label">Lương tối thiểu (USD)</label>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <input type="number" class="form-control" id="editMinSalary" name="salaryMin">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="editMaxSalary" class="form-label">Lương tối đa (USD)</label>
                                        <div class="input-group">
                                            <span class="input-group-text">$</span>
                                            <input type="number" class="form-control" id="editMaxSalary" name="salaryMax">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="editExperienceLevel" class="form-label">Cấp độ kinh nghiệm</label>
                                        <!--<input type="text" class="form-control" id="editExperienceLevel" name="experienceLevel">-->
                                        <select class="form-select" id="editExperienceLevel" name="experienceLevel">
                                            <option value="" selected disabled>Chọn cấp độ kinh nghiệm</option>
                                            <option value="Mới vào nghề (0-1 năm)">Mới vào nghề (0-1 năm)</option>
                                            <option value="Nhân viên sơ cấp (1-3 năm)">Nhân viên sơ cấp (1-3 năm)</option>
                                            <option value="Trung cấp (3-5 năm)">Trung cấp (3-5 năm)</option>
                                            <option value="Cao cấp (trên 5 năm)">Cao cấp (trên 5 năm)</option>
                                            <option value="Quản lý">Quản lý</option>
                                            <option value="Điều hành">Điều hành</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="editExpiryDate" class="form-label">Hạn cuối nhận hồ sơ <span class="text-danger">*</span></label>
                                        <input type="date" class="form-control" id="editExpiryDate" name="applicationDeadline" required >
                                    </div>


                                </div>
                            </div>

                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Công việc</h6>
                                <div class="mb-3">
                                    <label for="editDescription" class="form-label">Mô tả công việc <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="editDescription" rows="5" name="jobDescription" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="editRequirements" class="form-label">Yêu cầu <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="editRequirements" rows="4" name="requirements" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="editBenefits" class="form-label">Quyền lợi</label>
                                    <textarea class="form-control" id="editBenefits" name="benefits" rows="3"></textarea>
                                </div>
                            </div>

                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Tùy chọn bổ sung</h6>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="editFeatureJob" checked>
                                            <label class="form-check-label" for="editFeatureJob">Feature this job (highlighted in listings)</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="editHideCompany">
                                            <label class="form-check-label" for="editHideCompany">Hide company name</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="editRemotePossible">
                                            <label class="form-check-label" for="editRemotePossible">Remote work possible</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="editUrgentHiring">
                                            <label class="form-check-label" for="editUrgentHiring">Urgent hiring</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>

                    </div>
                </div>
            </div>
        </form>
        --%>
        <!-- View Applicants Modal -->
        <div class="modal fade" id="applicantsModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Applicants for Senior Software Engineer</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                            <div>
                                <h6 class="mb-0">24 Applicants</h6>
                            </div>
                            <div class="d-flex gap-2 flex-wrap">
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        <i class="bi bi-funnel me-1"></i> Filter
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><a class="dropdown-item" href="#">All Applicants</a></li>
                                        <li><a class="dropdown-item" href="#">New</a></li>
                                        <li><a class="dropdown-item" href="#">Reviewing</a></li>
                                        <li><a class="dropdown-item" href="#">Shortlisted</a></li>
                                        <li><a class="dropdown-item" href="#">Interview</a></li>
                                        <li><a class="dropdown-item" href="#">Offer</a></li>
                                        <li><a class="dropdown-item" href="#">Hired</a></li>
                                        <li><a class="dropdown-item" href="#">Rejected</a></li>
                                    </ul>
                                </div>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        <i class="bi bi-sort-down me-1"></i> Sort
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><a class="dropdown-item" href="#">Newest First</a></li>
                                        <li><a class="dropdown-item" href="#">Oldest First</a></li>
                                        <li><a class="dropdown-item" href="#">Name (A-Z)</a></li>
                                        <li><a class="dropdown-item" href="#">Name (Z-A)</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="selectAllApplicants">
                                                <label class="form-check-label" for="selectAllApplicants"></label>
                                            </div>
                                        </th>
                                        <th>Applicant</th>
                                        <th>Applied On</th>
                                        <th>Experience</th>
                                        <th>Education</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox">
                                                <label class="form-check-label"></label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="applicant-info">
                                                <img src="https://ui-avatars.com/api/?name=John+Doe&background=6366f1&color=fff" class="applicant-avatar" alt="John Doe">
                                                <div>
                                                    <p class="applicant-name">John Doe</p>
                                                    <p class="applicant-email">john.doe@example.com</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td>May 5, 2023</td>
                                        <td>7 years</td>
                                        <td>M.S. Computer Science</td>
                                        <td><span class="badge bg-primary">Shortlisted</span></td>
                                        <td>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary action-btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                    <i class="bi bi-three-dots"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end">
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-eye"></i> View Profile</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-file-earmark-text"></i> View Resume</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-envelope"></i> Send Email</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-calendar-event"></i> Schedule Interview</a></li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-check-circle"></i> Change Status</a></li>
                                                    <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-x-circle"></i> Reject</a></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox">
                                                <label class="form-check-label"></label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="applicant-info">
                                                <img src="https://ui-avatars.com/api/?name=Sarah+Johnson&background=0ea5e9&color=fff" class="applicant-avatar" alt="Sarah Johnson">
                                                <div>
                                                    <p class="applicant-name">Sarah Johnson</p>
                                                    <p class="applicant-email">sarah.johnson@example.com</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td>May 4, 2023</td>
                                        <td>5 years</td>
                                        <td>B.S. Software Engineering</td>
                                        <td><span class="badge bg-info">Interview</span></td>
                                        <td>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary action-btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                    <i class="bi bi-three-dots"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end">
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-eye"></i> View Profile</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-file-earmark-text"></i> View Resume</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-envelope"></i> Send Email</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-calendar-event"></i> Schedule Interview</a></li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-check-circle"></i> Change Status</a></li>
                                                    <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-x-circle"></i> Reject</a></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox">
                                                <label class="form-check-label"></label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="applicant-info">
                                                <img src="https://ui-avatars.com/api/?name=Michael+Brown&background=f59e0b&color=fff" class="applicant-avatar" alt="Michael Brown">
                                                <div>
                                                    <p class="applicant-name">Michael Brown</p>
                                                    <p class="applicant-email">michael.brown@example.com</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td>May 3, 2023</td>
                                        <td>8 years</td>
                                        <td>Ph.D. Computer Science</td>
                                        <td><span class="badge bg-success">Offer</span></td>
                                        <td>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary action-btn dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                    <i class="bi bi-three-dots"></i>
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end">
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-eye"></i> View Profile</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-file-earmark-text"></i> View Resume</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-envelope"></i> Send Email</a></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-calendar-event"></i> Schedule Interview</a></li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li><a class="dropdown-item" href="#"><i class="bi bi-check-circle"></i> Change Status</a></li>
                                                    <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-x-circle"></i> Reject</a></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Bulk Actions</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Custom JavaScript -->

        <!--        <script>
                                            const editModal = document.getElementById('editJobModal');
        
                                            editModal.addEventListener('show.bs.modal', function (event) {
                                                const button = event.relatedTarget;
        
                                                // Lấy dữ liệu từ nút
                                                const id = button.getAttribute('data-id');
                                                const title = button.getAttribute('data-title');
                                                const department = button.getAttribute('data-department');
                                                const location = button.getAttribute('data-location');
                                                const type = button.getAttribute('data-type');
                                                const experienceLevel = button.getAttribute('data-experiencelevel');
                                                const minSalary = button.getAttribute('data-minsalary');
                                                const maxSalary = button.getAttribute('data-maxsalary');
                                                const deadline = button.getAttribute('data-deadline');
                                                const formattedDate = deadline.split(" ")[0];
                                                const description = button.getAttribute('data-description');
                                                const requirements = button.getAttribute('data-requirements');
                                                const benefits = button.getAttribute('data-benefits');
                                                const industryid = button.getAttribute('data-industryid');
        
                                                // Đổ dữ liệu vào form
                                                document.getElementById('editJobId').value = id;
                                                document.getElementById('editJobTitle').value = title;
                                                document.getElementById('editDepartment').value = department;
                                                document.getElementById('editLocation').value = location;
                                                document.getElementById('editEmploymentType').value = type;
        
                                                document.getElementById('editExperienceLevel').value = experienceLevel;
        
                                                document.getElementById('editMinSalary').value = minSalary;
                                                document.getElementById('editMaxSalary').value = maxSalary;
                                                document.getElementById('editExpiryDate').value = formattedDate;
                                                document.getElementById('editDescription').value = description;
                                                document.getElementById('editRequirements').value = requirements;
                                                document.getElementById('editBenefits').value = benefits;
                                                document.getElementById('editIndustry').value = industryid;
        
        //                console.log("Experience Level:", experienceLevel);
                                            });
                </script>-->

        <script>
            var deleteModal = document.getElementById('deleteModal');
            deleteModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var jobId = button.getAttribute('data-id');
                var jobTitle = button.getAttribute('data-title');

                // Gán vào thẻ span trong modal
                document.getElementById('modal-job-title').textContent = jobTitle;
                document.getElementById('deleteJobId').value = jobId;

            });
        </script>
        <script>
            // Lấy 2 phần tử thông báo (nếu có)
            const alertError = document.getElementById('alertError');
            const alertSuccess = document.getElementById('alertSuccess');

            // Nếu có lỗi thì hiển thị và 2s sau ẩn
            if (alertError) {
                alertError.style.display = 'block';
                setTimeout(() => {
                    alertError.style.display = 'none';
                }, 2000);
            }

            // Nếu có message thành công thì hiển thị và 2s sau ẩn
            if (alertSuccess) {
                alertSuccess.style.display = 'block';
                setTimeout(() => {
                    alertSuccess.style.display = 'none';
                }, 2000);
            }
        </script>

    </body>
</html>
