<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách ứng viên - ${jobPost.jobTitle} | MyJob</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #0046aa;
                --secondary-color: #ff6b00;
                --accent-color: #11cdef;
                --dark-color: #001e44;
                --light-color: #f7fafc;
                --success-color: #2dce89;
                --warning-color: #ffc107;
                --info-color: #17a2b8;
                --error-color: #dc3545;
            }

            body {
                font-family: 'Poppins', sans-serif;
                color: #525f7f;
                background-color: #f0f6ff;
            }

            .navbar-custom {
                background-color: #f0f6ff;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
            }

            .btn-primary {
                background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
                border: none;
                padding: 0.75rem 2rem;
                font-weight: 600;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 70, 170, 0.3);
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #003ecb 0%, #0046aa 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0, 70, 170, 0.4);
            }

            .btn-outline-primary {
                color: var(--primary-color);
                border: 2px solid var(--primary-color);
                padding: 0.5rem 1rem;
                font-weight: 600;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-size: 0.875rem;
            }

            .btn-outline-primary:hover {
                background: var(--primary-color);
                color: white;
                transform: translateY(-2px);
            }

            .page-header {
                background: linear-gradient(270deg, #69b3ff, #1e3fa6 73.72%);
                color: white;
                padding: 3rem 0;
                position: relative;
                overflow: hidden;
            }

            .page-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
                background-size: cover;
                background-position: center;
                opacity: 0.05;
            }

            .page-header .container {
                position: relative;
                z-index: 1;
            }

            /* Redesigned Stats Cards */
            .stats-section {
                margin-bottom: 2rem;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(3, minmax(200px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                border-radius: 16px;
                padding: 1.5rem;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                border-left: 4px solid;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                width: 60px;
                height: 60px;
                border-radius: 50%;
                opacity: 0.1;
                transform: translate(20px, -20px);
            }

            .stat-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            }

            .stat-card.total {
                border-left-color: var(--primary-color);
            }
            .stat-card.total::before {
                background: var(--primary-color);
            }

            .stat-card.pending {
                border-left-color: #ffc107;
            }
            .stat-card.pending::before {
                background: #ffc107;
            }

            .stat-card.interview {
                border-left-color: #17a2b8;
            }
            .stat-card.interview::before {
                background: #17a2b8;
            }

            .stat-card.testing {
                border-left-color: #fd7e14;
            }
            .stat-card.testing::before {
                background: #fd7e14;
            }

            .stat-card.accepted {
                border-left-color: var(--success-color);
            }
            .stat-card.accepted::before {
                background: var(--success-color);
            }

            .stat-card.rejected {
                border-left-color: var(--error-color);
            }
            .stat-card.rejected::before {
                background: var(--error-color);
            }

            .stat-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 0.5rem;
            }

            .stat-icon {
                width: 40px;
                height: 40px;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
                color: white;
            }

            .stat-icon.total {
                background: var(--primary-color);
            }
            .stat-icon.pending {
                background: #ffc107;
            }
            .stat-icon.interview {
                background: #17a2b8;
            }
            .stat-icon.testing {
                background: #fd7e14;
            }
            .stat-icon.accepted {
                background: var(--success-color);
            }
            .stat-icon.rejected {
                background: var(--error-color);
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                color: var(--dark-color);
                margin: 0;
                line-height: 1;
            }

            .stat-label {
                color: #8898aa;
                font-size: 0.875rem;
                font-weight: 500;
                margin: 0;
            }

            .stat-change {
                font-size: 0.75rem;
                font-weight: 600;
                margin-top: 0.5rem;
            }

            .stat-change.positive {
                color: var(--success-color);
            }

            .stat-change.negative {
                color: var(--error-color);
            }

            .job-info-card {
                background-color: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }

            .filter-card {
                background-color: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }

            /* Instructions Card */
            .instructions-card {
                background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
                border-radius: 15px;
                padding: 1.25rem;
                margin-bottom: 2rem;
                border-left: 4px solid var(--primary-color);
            }

            .instructions-card h6 {
                color: var(--primary-color);
                font-weight: 600;
                margin-bottom: 0.75rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .instructions-card ul {
                margin: 0;
                padding-left: 1.25rem;
                color: #525f7f;
            }

            .instructions-card li {
                margin-bottom: 0.25rem;
                font-size: 0.9rem;
            }

            .bulk-actions-card {
                background-color: white;
                border-radius: 15px;
                padding: 1rem 1.5rem;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
                border-left: 4px solid var(--primary-color);
                display: none;
            }

            .bulk-actions-card.show {
                display: block;
                animation: slideDown 0.3s ease-out;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Table Styles */
            .table-container {
                background-color: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
            }

            .table {
                margin-bottom: 0;
            }

            .table thead th {
                background-color: #f8f9fa;
                border-bottom: 2px solid #dee2e6;
                font-weight: 600;
                color: var(--dark-color);
                padding: 1rem 0.75rem;
                font-size: 0.875rem;
                white-space: nowrap;
            }

            .table tbody td {
                padding: 1rem 0.75rem;
                vertical-align: middle;
                border-bottom: 1px solid #f1f3f4;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
            }

            .table tbody tr.selected {
                background-color: #e3f2fd !important;
            }

            .candidate-info {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .candidate-avatar {
                width: 2.5rem;
                height: 2.5rem;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #f5f9fc;
                background: linear-gradient(45deg, var(--primary-color), #0051ff);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: bold;
                font-size: 1rem;
            }

            .candidate-details h6 {
                margin: 0;
                font-weight: 600;
                color: var(--dark-color);
                font-size: 0.95rem;
            }

            .candidate-details small {
                color: #8898aa;
                font-size: 0.8rem;
            }

            /* Status Badge Styles - Updated */
            .status-badge {
                padding: 0.35rem 0.85rem;
                font-size: 0.75rem;
                font-weight: 600;
                border-radius: 50rem;
                white-space: nowrap;
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
            }

            .status-badge i {
                font-size: 0.7rem;
            }

            .status-badge.status-pending {
                background-color: #fff3cd;
                color: #856404;
                border: 1px solid #ffeaa7;
            }
            .status-badge.status-interview {
                background-color: #d1ecf1;
                color: #0c5460;
                border: 1px solid #bee5eb;
            }
            .status-badge.status-testing {
                background-color: #ffecd1;
                color: #8a4a00;
                border: 1px solid #ffd89b;
            }
            .status-badge.status-accepted {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .status-badge.status-rejected {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .action-buttons {
                display: flex;
                gap: 0.5rem;
                justify-content: center;
            }

            .btn-sm {
                padding: 0.375rem 0.75rem;
                font-size: 0.8rem;
                border-radius: 6px;
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(0, 70, 170, 0.25);
            }

            .alert {
                border-radius: 10px;
                border: none;
                padding: 1rem 1.5rem;
            }

            .alert-success {
                background: linear-gradient(135deg, #e8f5e8 0%, #d4edda 100%);
                color: #2e7d32;
            }

            .alert-danger {
                background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 100%);
                color: #d32f2f;
            }

            .alert-info {
                background: linear-gradient(135deg, #e0f2f7 0%, #b3e5fc 100%);
                color: #01579b;
            }

            .alert-warning {
                background: linear-gradient(135deg, #fff3e0 0%, #ffe0b2 100%);
                color: #ef6c00;
            }

            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                color: #8898aa;
            }

            .empty-state i {
                font-size: 4rem;
                margin-bottom: 1rem;
                opacity: 0.5;
            }

            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .loading-spinner {
                background: white;
                padding: 20px;
                border-radius: 8px;
                text-align: center;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
            }

            .loading-spinner i {
                font-size: 2rem;
                margin-bottom: 10px;
                color: var(--primary-color);
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                from {
                    transform: rotate(0deg);
                }
                to {
                    transform: rotate(360deg);
                }
            }

            /* Custom checkbox */
            .form-check-input:checked {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .form-check-input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(0, 70, 170, 0.25);
            }

            /* FIXED Custom Toast Styles */
            .toast-notification {
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
                z-index: 10000;
                display: flex;
                align-items: center;
                gap: 10px;
                font-weight: 500;
                animation: slideInRight 0.3s ease-out;
                min-width: 300px;
                max-width: 500px;
                font-family: 'Poppins', sans-serif;
            }

            .toast-notification.success {
                background-color: #2dce89;
                color: white;
            }

            .toast-notification.error {
                background-color: #dc3545;
                color: white;
            }

            .toast-notification.warning {
                background-color: #ffc107;
                color: #000;
            }

            .toast-notification.info {
                background-color: #17a2b8;
                color: white;
            }

            .toast-notification i {
                font-size: 1.2rem;
                flex-shrink: 0;
            }

            .toast-close-btn {
                margin-left: auto;
                background: none;
                border: none;
                color: inherit;
                font-size: 1.2rem;
                cursor: pointer;
                padding: 0;
                opacity: 0.7;
            }

            .toast-close-btn:hover {
                opacity: 1;
            }

            @keyframes slideInRight {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            @keyframes slideOutRight {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(100%);
                    opacity: 0;
                }
            }
            /* Add these styles to your existing CSS */
            .btn-info {
                background: linear-gradient(135deg, var(--info-color) 0%, #0dcaf0 100%);
                border: none;
                color: white;
                transition: all 0.3s ease;
            }

            .btn-info:hover {
                background: linear-gradient(135deg, #0c9bb5 0%, var(--info-color) 100%);
                color: white;
                transform: translateY(-2px);
            }

            .btn-warning {
                background: linear-gradient(135deg, var(--warning-color) 0%, #ffca2c 100%);
                border: none;
                color: #000;
                transition: all 0.3s ease;
            }

            .btn-warning:hover {
                background: linear-gradient(135deg, #e0a800 0%, var(--warning-color) 100%);
                color: #000;
                transform: translateY(-2px);
            }

            /* Update action-buttons to handle more buttons */
            .action-buttons {
                display: flex;
                gap: 0.25rem;
                justify-content: center;
                flex-wrap: wrap;
            }

           

            /* Responsive */
            @media (max-width: 768px) {
                .stats-grid {
                    grid-template-columns: repeat(2, 1fr);
                    gap: 1rem;
                }

                .stat-card {
                    padding: 1rem;
                }

                .stat-number {
                    font-size: 1.5rem;
                }

                .bulk-actions-card {
                    padding: 1rem;
                }

                .bulk-actions-card .d-flex {
                    flex-direction: column;
                    gap: 1rem;
                }

                .toast-notification {
                    right: 10px;
                    left: 10px;
                    min-width: auto;
                }
                 .action-buttons {
                    flex-direction: column;
                    gap: 0.25rem;
                }

                .btn-sm {
                    padding: 0.25rem 0.5rem;
                    font-size: 0.75rem;
                }
            }

            @media (max-width: 576px) {
                .stats-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>

        <!-- Loading overlay -->
        <div class="loading-overlay" id="loadingOverlay">
            <div class="loading-spinner">
                <i class="bi bi-arrow-clockwise"></i>
                <div>Đang xử lý...</div>
            </div>
        </div>

        <%@ include file="RecruiterNavbar.jsp" %>

        <!-- Page Header -->
        <section class="page-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <h1 class="display-5 fw-bold mb-3">
                            <i class="bi bi-people-fill me-3"></i>Ứng viên cho vị trí
                        </h1>
                        <p class="lead mb-0">${jobPost.jobTitle} - ${jobPost.companyName}</p>
                        <small><i class="bi bi-geo-alt text-light me-1"></i>${jobPost.location}</small>
                    </div>
                    <div class="col-lg-4 text-lg-end">
                        <div class="d-flex flex-column align-items-lg-end gap-2">
                            <span class="badge bg-primary fs-6">${totalCandidates} ứng viên</span>
                            <small class="text-light">Hạn nộp: <fmt:formatDate value="${jobPost.deadline}" pattern="dd/MM/yyyy"/></small>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Main Content -->
        <div class="container mt-4">
            <!-- Alert Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    <div class="error-content">
                        <div class="fw-bold">Có lỗi xảy ra!</div>
                        <div>${error}</div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>
                    <div class="success-content">
                        <div class="fw-bold">Thành công!</div>
                        <div>${success}</div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>



            <!-- Redesigned Stats Section -->
            <div class="stats-section">
                <div class="stats-grid">
                    <div class="stat-card total">
                        <div class="stat-header">
                            <div class="stat-icon total">
                                <i class="bi bi-people-fill"></i>
                            </div>
                        </div>
                        <div class="stat-number">${stats.totalApplications}</div>
                        <div class="stat-label">Tổng ứng viên</div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up"></i> Tất cả ứng viên
                        </div>
                    </div>

                    <div class="stat-card pending">
                        <div class="stat-header">
                            <div class="stat-icon pending">
                                <i class="bi bi-clock-fill"></i>
                            </div>
                        </div>
                        <div class="stat-number">${stats.pendingCount}</div>
                        <div class="stat-label">Chờ xử lý</div>
                        <div class="stat-change">
                            <i class="bi bi-hourglass-split"></i> Cần xem xét
                        </div>
                    </div>

                    <div class="stat-card interview">
                        <div class="stat-header">
                            <div class="stat-icon interview">
                                <i class="bi bi-chat-dots-fill"></i>
                            </div>
                        </div>
                        <div class="stat-number">${stats.interviewCount}</div>
                        <div class="stat-label">Phỏng vấn</div>
                        <div class="stat-change">
                            <i class="bi bi-calendar-check"></i> Đang phỏng vấn
                        </div>
                    </div>

                    <div class="stat-card testing">
                        <div class="stat-header">
                            <div class="stat-icon testing">
                                <i class="bi bi-clipboard-check-fill"></i>
                            </div>
                        </div>
                        <div class="stat-number">${stats.testingCount}</div>
                        <div class="stat-label">Đang test</div>
                        <div class="stat-change">
                            <i class="bi bi-pencil-square"></i> Đang thực hiện
                        </div>
                    </div>

                    <div class="stat-card accepted">
                        <div class="stat-header">
                            <div class="stat-icon accepted">
                                <i class="bi bi-check-circle-fill"></i>
                            </div>
                        </div>
                        <div class="stat-number">${stats.acceptedCount}</div>
                        <div class="stat-label">Đã duyệt</div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up"></i> Thành công
                        </div>
                    </div>

                    <div class="stat-card rejected">
                        <div class="stat-header">
                            <div class="stat-icon rejected">
                                <i class="bi bi-x-circle-fill"></i>
                            </div>
                        </div>
                        <div class="stat-number">${stats.rejectedCount}</div>
                        <div class="stat-label">Từ chối</div>
                        <div class="stat-change negative">
                            <i class="bi bi-arrow-down"></i> Không phù hợp
                        </div>
                    </div>
                </div>
            </div>

            <!-- Instructions Card -->
            <div class="instructions-card">
                <h6>
                    <i class="bi bi-info-circle-fill"></i>
                    Hướng dẫn thay đổi trạng thái ứng viên
                </h6>
                <ul>
                    <li>Chọn một hoặc nhiều ứng viên bằng cách tick vào checkbox</li>
                    <li>Chọn trạng thái mới từ dropdown trong phần "Thao tác hàng loạt"</li>
                    <li>Nhấn nút "Áp dụng" để thay đổi trạng thái cho tất cả ứng viên đã chọn</li>
                    <li>Sử dụng bộ lọc để tìm kiếm ứng viên theo trạng thái, ngày hoặc tên</li>
                </ul>
            </div>

            <!-- Filter Section -->
            <div class="filter-card">
                <h5 class="mb-3">
                    <i class="bi bi-funnel me-2" style="color: var(--primary-color);"></i>Bộ lọc và tìm kiếm
                </h5>
                <form method="GET" action="JobPostCandidates" id="filterForm">
                    <input type="hidden" name="jobId" value="${jobPost.jobId}">
                    <div class="row g-3 mb-3">
                        <div class="col-md-3">
                            <label for="status" class="form-label fw-bold">Trạng thái</label>
                            <select id="status" name="status" class="form-select">
                                <option value="">Tất cả trạng thái</option>
                                <option value="Pending" ${selectedStatus == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                                <option value="Interview" ${selectedStatus == 'Interview' ? 'selected' : ''}>Phỏng vấn</option>
                                <option value="Testing" ${selectedStatus == 'Testing' ? 'selected' : ''}>Đang test</option>
                                <option value="Accepted" ${selectedStatus == 'Accepted' ? 'selected' : ''}>Đã duyệt</option>
                                <option value="Rejected" ${selectedStatus == 'Rejected' ? 'selected' : ''}>Từ chối</option>
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label for="dateFrom" class="form-label fw-bold">Từ ngày</label>
                            <input type="date" id="dateFrom" name="dateFrom" class="form-control" value="${selectedDateFrom}">
                        </div>

                        <div class="col-md-3">
                            <label for="dateTo" class="form-label fw-bold">Đến ngày</label>
                            <input type="date" id="dateTo" name="dateTo" class="form-control" value="${selectedDateTo}">
                        </div>

                        <div class="col-md-3">
                            <label for="searchName" class="form-label fw-bold">Tìm theo tên</label>
                            <div class="input-group">
                                <input type="text" id="searchName" name="searchName" class="form-control"
                                       placeholder="Nhập tên ứng viên" value="${selectedSearchName}">
                                <button class="btn btn-outline-secondary" type="button" onclick="clearSearchName()">
                                    <i class="bi bi-x"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-search me-1"></i> Tìm kiếm
                        </button>
                        <button type="button" class="btn btn-outline-secondary" onclick="clearFilters()">
                            <i class="bi bi-x-circle me-1"></i> Xóa bộ lọc
                        </button>
                    </div>
                </form>
            </div>

            <!-- Bulk Actions Card -->
            <div class="bulk-actions-card" id="bulkActionsCard">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <strong>
                            <i class="bi bi-check-square me-1"></i>
                            Đã chọn: <span id="selectedCount">0</span> ứng viên
                        </strong>
                    </div>
                    <div class="d-flex gap-2">
                        <select id="bulkStatusSelect" class="form-select form-select-sm" style="width: auto;">
                            <option value="">Chọn trạng thái mới</option>
                            <option value="Pending">Chờ xử lý</option>
                            <option value="Interview">Phỏng vấn</option>
                            <option value="Testing">Đang test</option>
                            <option value="Accepted">Đã duyệt</option>
                            <option value="Rejected">Từ chối</option>
                        </select>
                        <button class="btn btn-primary btn-sm" onclick="applyBulkStatus()">
                            <i class="bi bi-check-all me-1"></i>Áp dụng
                        </button>
                        <button class="btn btn-outline-secondary btn-sm" onclick="clearSelection()">
                            <i class="bi bi-x me-1"></i>Bỏ chọn
                        </button>
                    </div>
                </div>
            </div>

            <!-- Updated Candidates Table -->
            <div class="table-container">
                <c:choose>
                    <c:when test="${empty candidates}">
                        <div class="empty-state">
                            <i class="bi bi-people"></i>
                            <h4>Chưa có ứng viên nào</h4>
                            <p>Hiện tại chưa có ứng viên nào nộp hồ sơ cho vị trí này.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col" style="width: 50px;">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="selectAll">
                                            </div>
                                        </th>
                                        <th scope="col">Ứng viên</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Số điện thoại</th>
                                        <th scope="col">Ngày nộp</th>
                                        <th scope="col">Trạng thái</th>
                                        <th scope="col">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="candidate" items="${candidates}">
                                        <tr data-candidate-id="${candidate.candidateId}" data-application-id="${candidate.applicationId}">
                                            <td>
                                                <div class="form-check">
                                                    <input class="form-check-input candidate-checkbox" type="checkbox" 
                                                           value="${candidate.applicationId}" id="candidate-${candidate.applicationId}">
                                                </div>
                                            </td>
                                            <td>
                                                <div class="candidate-info">
                                                    <c:choose>
                                                        <c:when test="${not empty candidate.imageUrl}">
                                                            <img src="${candidate.imageUrl}" alt="Avatar" class="candidate-avatar">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="candidate-avatar">
                                                                ${fn:substring(candidate.fullName, 0, 1)}
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div class="candidate-details">
                                                        <h6>${candidate.fullName}</h6>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>${candidate.email}</td>
                                            <td>${candidate.phoneNumber}</td>
                                            <td>
                                                <fmt:formatDate value="${candidate.appliedAt}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <span class="status-badge status-${fn:toLowerCase(candidate.status)}">
                                                    <c:choose>
                                                        <c:when test="${candidate.status == 'Pending'}">
                                                            <i class="bi bi-clock"></i> Chờ xử lý
                                                        </c:when>
                                                        <c:when test="${candidate.status == 'Interview'}">
                                                            <i class="bi bi-chat-dots"></i> Phỏng vấn
                                                        </c:when>
                                                        <c:when test="${candidate.status == 'Testing'}">
                                                            <i class="bi bi-clipboard-check"></i> Đang test
                                                        </c:when>
                                                        <c:when test="${candidate.status == 'Accepted'}">
                                                            <i class="bi bi-check-circle"></i> Đã duyệt
                                                        </c:when>
                                                        <c:when test="${candidate.status == 'Rejected'}">
                                                            <i class="bi bi-x-circle"></i> Từ chối
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${candidate.status}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <!-- Always show view candidate button -->
                                                    <button class="btn btn-outline-primary btn-sm" 
                                                            onclick="viewCandidate('${candidate.candidateId}', '${candidate.applicationId}')" 
                                                            title="Xem chi tiết">
                                                        <i class="bi bi-eye"></i>
                                                    </button>

                                                    <!-- Conditional buttons based on status -->
                                                    <c:choose>
                                                        <c:when test="${candidate.status == 'Interview'}">
                                                            <a href="InterviewManager" 
                                                               class="btn btn-info btn-sm" 
                                                               title="Quản lý phỏng vấn">
                                                                <i class="bi bi-calendar-event"></i>
                                                            </a>
                                                        </c:when>
                                                        <c:when test="${candidate.status == 'Testing'}">
                                                            <a href="AssignmentManagement" 
                                                               class="btn btn-warning btn-sm" 
                                                               title="Quản lý bài test">
                                                                <i class="bi bi-file-earmark-text"></i>
                                                            </a>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="?jobId=${jobPost.jobId}&page=${currentPage - 1}&status=${selectedStatus}&dateFrom=${selectedDateFrom}&dateTo=${selectedDateTo}&searchName=${selectedSearchName}">Trước</a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?jobId=${jobPost.jobId}&page=${i}&status=${selectedStatus}&dateFrom=${selectedDateFrom}&dateTo=${selectedDateTo}&searchName=${selectedSearchName}">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="?jobId=${jobPost.jobId}&page=${currentPage + 1}&status=${selectedStatus}&dateFrom=${selectedDateFrom}&dateTo=${selectedDateTo}&searchName=${selectedSearchName}">Sau</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                                let selectedCandidates = new Set();

                                                                // Show/hide loading overlay
                                                                function showLoading() {
                                                                    document.getElementById('loadingOverlay').style.display = 'flex';
                                                                }

                                                                function hideLoading() {
                                                                    document.getElementById('loadingOverlay').style.display = 'none';
                                                                }

                                                                // Clear filters function
                                                                function clearFilters() {
                                                                    const jobId = new URLSearchParams(window.location.search).get('jobId');
                                                                    window.location.href = 'JobPostCandidates?jobId=' + jobId;
                                                                }

                                                                // Clear search name
                                                                function clearSearchName() {
                                                                    document.getElementById('searchName').value = '';
                                                                    document.getElementById('filterForm').submit();
                                                                }

                                                                // Select All functionality
                                                                document.getElementById('selectAll').addEventListener('change', function () {
                                                                    const checkboxes = document.querySelectorAll('.candidate-checkbox');
                                                                    const isChecked = this.checked;

                                                                    checkboxes.forEach(function (checkbox) {
                                                                        checkbox.checked = isChecked;
                                                                        const applicationId = checkbox.value;
                                                                        const row = checkbox.closest('tr');

                                                                        if (isChecked) {
                                                                            selectedCandidates.add(applicationId);
                                                                            row.classList.add('selected');
                                                                        } else {
                                                                            selectedCandidates.delete(applicationId);
                                                                            row.classList.remove('selected');
                                                                        }
                                                                    });

                                                                    updateBulkActionsVisibility();
                                                                });

                                                                // Individual checkbox functionality
                                                                document.querySelectorAll('.candidate-checkbox').forEach(function (checkbox) {
                                                                    checkbox.addEventListener('change', function () {
                                                                        const applicationId = this.value;
                                                                        const row = this.closest('tr');

                                                                        if (this.checked) {
                                                                            selectedCandidates.add(applicationId);
                                                                            row.classList.add('selected');
                                                                        } else {
                                                                            selectedCandidates.delete(applicationId);
                                                                            row.classList.remove('selected');
                                                                        }

                                                                        // Update select all checkbox
                                                                        const allCheckboxes = document.querySelectorAll('.candidate-checkbox');
                                                                        const checkedCheckboxes = document.querySelectorAll('.candidate-checkbox:checked');
                                                                        const selectAllCheckbox = document.getElementById('selectAll');

                                                                        if (checkedCheckboxes.length === allCheckboxes.length) {
                                                                            selectAllCheckbox.checked = true;
                                                                            selectAllCheckbox.indeterminate = false;
                                                                        } else if (checkedCheckboxes.length > 0) {
                                                                            selectAllCheckbox.checked = false;
                                                                            selectAllCheckbox.indeterminate = true;
                                                                        } else {
                                                                            selectAllCheckbox.checked = false;
                                                                            selectAllCheckbox.indeterminate = false;
                                                                        }

                                                                        updateBulkActionsVisibility();
                                                                    });
                                                                });

                                                                // Update bulk actions visibility
                                                                function updateBulkActionsVisibility() {
                                                                    const bulkActionsCard = document.getElementById('bulkActionsCard');
                                                                    const selectedCount = document.getElementById('selectedCount');

                                                                    if (selectedCandidates.size > 0) {
                                                                        bulkActionsCard.classList.add('show');
                                                                        selectedCount.textContent = selectedCandidates.size;
                                                                    } else {
                                                                        bulkActionsCard.classList.remove('show');
                                                                    }
                                                                }

                                                                // Clear selection
                                                                function clearSelection() {
                                                                    selectedCandidates.clear();
                                                                    document.querySelectorAll('.candidate-checkbox').forEach(function (checkbox) {
                                                                        checkbox.checked = false;
                                                                        checkbox.closest('tr').classList.remove('selected');
                                                                    });
                                                                    document.getElementById('selectAll').checked = false;
                                                                    document.getElementById('selectAll').indeterminate = false;
                                                                    updateBulkActionsVisibility();
                                                                }

                                                                // Apply bulk status change - FIXED WITHOUT TEMPLATE LITERALS
                                                                function applyBulkStatus() {
                                                                    const bulkStatus = document.getElementById('bulkStatusSelect').value;

                                                                    if (!bulkStatus) {
                                                                        showToast('Vui lòng chọn trạng thái mới', 'warning');
                                                                        return;
                                                                    }

                                                                    if (selectedCandidates.size === 0) {
                                                                        showToast('Vui lòng chọn ít nhất một ứng viên', 'warning');
                                                                        return;
                                                                    }

                                                                    const statusText = getStatusText(bulkStatus);
                                                                    const confirmMessage = 'Bạn có chắc chắn muốn chuyển ' + selectedCandidates.size + ' ứng viên thành trạng thái "' + statusText + '"?';
                                                                    if (!confirm(confirmMessage)) {
                                                                        return;
                                                                    }

                                                                    showLoading();

                                                                    const applicationIds = Array.from(selectedCandidates);
                                                                    const params = new URLSearchParams();
                                                                    params.append('action', 'bulkChangeStatus');
                                                                    params.append('newStatus', bulkStatus);
                                                                    params.append('applicationIds', applicationIds.join(','));

                                                                    console.log('Sending request with params:', params.toString());

                                                                    fetch('JobPostCandidates', {
                                                                        method: 'POST',
                                                                        headers: {
                                                                            'Content-Type': 'application/x-www-form-urlencoded',
                                                                            'Accept': 'application/json'
                                                                        },
                                                                        body: params.toString()
                                                                    })
                                                                            .then(function (response) {
                                                                                console.log('Response status:', response.status);
                                                                                if (!response.ok) {
                                                                                    throw new Error('HTTP error! status: ' + response.status);
                                                                                }
                                                                                return response.text();
                                                                            })
                                                                            .then(function (text) {
                                                                                console.log('Raw response:', text);
                                                                                try {
                                                                                    const data = JSON.parse(text);
                                                                                    console.log('Parsed JSON:', data);
                                                                                    hideLoading();

                                                                                    if (data.success) {
                                                                                        clearSelection();
                                                                                        document.getElementById('bulkStatusSelect').value = '';
                                                                                        const successMessage = 'Đã cập nhật trạng thái cho ' + applicationIds.length + ' ứng viên!';
                                                                                        showToast(successMessage, 'success');

                                                                                        // Refresh page after 2 seconds
                                                                                        setTimeout(function () {
                                                                                            window.location.reload();
                                                                                        }, 2000);
                                                                                    } else {
                                                                                        const errorMessage = 'Lỗi: ' + (data.message || 'Không thể cập nhật trạng thái');
                                                                                        showToast(errorMessage, 'error');
                                                                                    }
                                                                                } catch (e) {
                                                                                    console.error('JSON parse error:', e);
                                                                                    console.error('Response text:', text);
                                                                                    hideLoading();
                                                                                    showToast('Lỗi: Phản hồi từ server không hợp lệ', 'error');
                                                                                }
                                                                            })
                                                                            .catch(function (error) {
                                                                                console.error('Fetch error:', error);
                                                                                hideLoading();
                                                                                const errorMessage = 'Có lỗi xảy ra: ' + error.message;
                                                                                showToast(errorMessage, 'error');
                                                                            });
                                                                }

                                                                // View candidate details
                                                                function viewCandidate(candidateId, applicationId) {
                                                                    window.location.href = 'CandidatePro?candidateId=' + candidateId + '&applicationId=' + applicationId;
                                                                }

                                                                // Helper function to get status text in Vietnamese
                                                                function getStatusText(status) {
                                                                    switch (status) {
                                                                        case 'Pending':
                                                                            return 'Chờ xử lý';
                                                                        case 'Interview':
                                                                            return 'Phỏng vấn';
                                                                        case 'Testing':
                                                                            return 'Đang test';
                                                                        case 'Accepted':
                                                                            return 'Đã duyệt';
                                                                        case 'Rejected':
                                                                            return 'Từ chối';
                                                                        default:
                                                                            return status;
                                                                    }
                                                                }

                                                                // FIXED Toast function - NO TEMPLATE LITERALS
                                                                function showToast(message, type) {
                                                                    console.log('showToast called with:', message, type);

                                                                    // Remove any existing toasts
                                                                    const existingToasts = document.querySelectorAll('.toast-notification');
                                                                    existingToasts.forEach(function (toast) {
                                                                        toast.remove();
                                                                    });

                                                                    // Create toast element
                                                                    const toast = document.createElement('div');
                                                                    toast.className = 'toast-notification ' + (type || 'info');

                                                                    // Create icon
                                                                    const icon = document.createElement('i');
                                                                    let iconClass = 'bi-info-circle-fill';
                                                                    if (type === 'success')
                                                                        iconClass = 'bi-check-circle-fill';
                                                                    else if (type === 'error')
                                                                        iconClass = 'bi-exclamation-triangle-fill';
                                                                    else if (type === 'warning')
                                                                        iconClass = 'bi-exclamation-triangle-fill';
                                                                    icon.className = 'bi ' + iconClass;

                                                                    // Create message span
                                                                    const messageSpan = document.createElement('span');
                                                                    messageSpan.textContent = message;

                                                                    // Create close button
                                                                    const closeBtn = document.createElement('button');
                                                                    closeBtn.className = 'toast-close-btn';
                                                                    closeBtn.innerHTML = '<i class="bi bi-x"></i>';
                                                                    closeBtn.onclick = function () {
                                                                        toast.remove();
                                                                    };

                                                                    // Append elements
                                                                    toast.appendChild(icon);
                                                                    toast.appendChild(messageSpan);
                                                                    toast.appendChild(closeBtn);

                                                                    // Add to DOM
                                                                    document.body.appendChild(toast);
                                                                    console.log('Toast added to DOM:', toast);

                                                                    // Auto remove after 5 seconds
                                                                    setTimeout(function () {
                                                                        if (toast.parentNode) {
                                                                            toast.style.animation = 'slideOutRight 0.3s ease-out';
                                                                            setTimeout(function () {
                                                                                toast.remove();
                                                                            }, 300);
                                                                        }
                                                                    }, 5000);
                                                                }

                                                                // Initialize page
                                                                document.addEventListener('DOMContentLoaded', function () {
                                                                    console.log('Job post candidates page loaded');


                                                                });
        </script>

    </body>
</html>