<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý danh sách bài làm - JobHub</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <style>
            :root {
                --primary-color: #0046aa;
                --secondary-color: #ff6b00;
                --accent-color: #11cdef;
                --dark-color: #001e44;
                --light-color: #f7fafc;
                --success-color: #2dce89;
                --warning-color: #fb6340;
                --info-color: #11cdef;
                --danger-color: #ef4444;
                --gray-color: #64748b;
            }

            body {
                font-family: 'Poppins', sans-serif;
                color: #525f7f;
                background-color: #f0f6ff;
            }

           

            /* Page Header Styles */
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
                background-image: url('https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
                background-size: cover;
                background-position: center;
                opacity: 0.05;
            }

            .main-container {
                background: white;
                border-radius: 15px;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-top: -2rem;
                position: relative;
                z-index: 10;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stats-card {
                background: white;
                border: 2px solid #e9ecef;
                border-radius: 15px;
                padding: 1.5rem;
                text-align: center;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .stats-card:hover {
                border-color: var(--primary-color);
                box-shadow: 0 5px 15px rgba(0, 70, 170, 0.15);
                transform: translateY(-2px);
            }

            .stats-card.primary {
                border-color: var(--primary-color);
                background: linear-gradient(135deg, #f0f6ff 0%, #e6f0ff 100%);
            }

            .stats-card.success {
                border-color: var(--success-color);
                background: linear-gradient(135deg, #e8f5e8 0%, #d4edda 100%);
            }

            .stats-card.warning {
                border-color: var(--warning-color);
                background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
            }

            .stats-icon {
                width: 4rem;
                height: 4rem;
                display: flex;
                align-items: center;
                justify-content: center;
                background: white;
                border-radius: 50%;
                margin: 0 auto 1rem;
                font-size: 1.5rem;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .stats-card.primary .stats-icon {
                color: var(--primary-color);
            }

            .stats-card.success .stats-icon {
                color: var(--success-color);
            }

            .stats-card.warning .stats-icon {
                color: var(--warning-color);
            }

            .stats-number {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .stats-title {
                color: #8898aa;
                font-size: 0.875rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .section-card {
                background: white;
                border: 2px solid #e9ecef;
                border-radius: 15px;
                padding: 1.5rem;
                margin-bottom: 2rem;
                transition: all 0.3s ease;
            }

            .section-card:hover {
                border-color: var(--primary-color);
                box-shadow: 0 5px 15px rgba(0, 70, 170, 0.15);
                transform: translateY(-2px);
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

            .btn-secondary {
                background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
                border: none;
                padding: 0.75rem 2rem;
                font-weight: 600;
                border-radius: 10px;
                transition: all 0.3s ease;
            }

            .btn-secondary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
            }

            .btn-outline-primary {
                color: var(--primary-color);
                border: 2px solid var(--primary-color);
                padding: 0.5rem 1.5rem;
                font-weight: 600;
                border-radius: 10px;
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                background: var(--primary-color);
                color: white;
                transform: translateY(-2px);
            }

            .table {
                border-radius: 10px;
                overflow: hidden;
            }

            .table th {
                background-color: #f8f9fa;
                border: none;
                font-weight: 600;
                color: var(--dark-color);
                padding: 1rem 0.75rem;
            }

            .table td {
                border: none;
                vertical-align: middle;
                padding: 1rem 0.75rem;
            }

            .table tbody tr {
                transition: all 0.2s ease;
            }

            .table tbody tr:hover {
                background-color: rgba(0, 70, 170, 0.05);
            }

            .badge {
                padding: 0.35rem 0.75rem;
                border-radius: 50px;
                font-size: 0.75rem;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
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

            .status-badge.completed {
                background-color: rgba(45, 206, 137, 0.1);
                color: var(--success-color);
            }

            .status-badge.in-progress {
                background-color: rgba(251, 99, 64, 0.1);
                color: var(--warning-color);
            }

            .status-badge.not-started {
                background-color: rgba(100, 116, 139, 0.1);
                color: var(--gray-color);
            }

            .score-display {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .score-bar {
                width: 60px;
                height: 6px;
                background-color: #f1f5f9;
                border-radius: 3px;
                overflow: hidden;
            }

            .score-fill {
                height: 100%;
                border-radius: 3px;
                transition: width 0.3s ease;
            }

            .score-fill.excellent {
                background-color: var(--success-color);
            }

            .score-fill.good {
                background-color: var(--warning-color);
            }

            .score-fill.poor {
                background-color: var(--danger-color);
            }

            .score-text {
                font-weight: 600;
                font-size: 13px;
            }

            .form-control, .form-select {
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem;
                transition: all 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 70, 170, 0.1);
            }

            .modal-content {
                border: none;
                border-radius: 15px;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            }

            .modal-header {
                border-bottom: 2px solid #e9ecef;
                padding: 1.5rem;
            }

            .modal-body {
                padding: 1.5rem;
            }

            .modal-footer {
                border-top: 2px solid #e9ecef;
                padding: 1.5rem;
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

            .user-avatar {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                object-fit: cover;
            }

            .notification-badge {
                position: absolute;
                top: 0;
                right: 0;
                transform: translate(25%, -25%);
                background-color: var(--danger-color);
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
                background-color: rgba(0, 70, 170, 0.1);
                color: var(--primary-color);
            }

            .dropdown-item i {
                margin-right: 0.5rem;
            }

            .action-btn {
                width: 32px;
                height: 32px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
                margin: 0 2px;
            }

            .action-btn:hover {
                transform: translateY(-1px);
            }

            .action-btn.view {
                background-color: rgba(0, 70, 170, 0.1);
                color: var(--primary-color);
            }

            .action-btn.view:hover {
                background-color: rgba(0, 70, 170, 0.2);
            }

            .search-section {
                background-color: #f8fafc;
                border-radius: 12px;
                padding: 1rem;
                margin-bottom: 1rem;
            }

            .candidate-result {
                background-color: white;
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 1rem;
                margin-top: 0.5rem;
                cursor: pointer;
                transition: all 0.2s;
            }

            .candidate-result:hover {
                border-color: var(--primary-color);
                box-shadow: 0 2px 4px rgba(0, 70, 170, 0.1);
            }

            .candidate-result.selected-candidate {
                background-color: rgba(0, 70, 170, 0.05);
                border-color: var(--primary-color);
                box-shadow: 0 2px 4px rgba(0, 70, 170, 0.2);
            }

            .candidate-info {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .candidate-name {
                font-weight: 600;
                color: #334155;
                margin-bottom: 0.25rem;
            }

            .candidate-email {
                font-size: 0.875rem;
                color: var(--gray-color);
                margin-bottom: 0.125rem;
            }

            .select-candidate-btn {
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 0.5rem 1rem;
                font-size: 0.875rem;
                cursor: pointer;
                transition: all 0.2s;
            }

            .select-candidate-btn:hover {
                background-color: #003ecb;
                transform: translateY(-1px);
            }

            .selected-candidate .select-candidate-btn {
                background-color: var(--success-color);
            }

            .selected-candidate .select-candidate-btn:hover {
                background-color: #059669;
            }

            .custom-toast {
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: var(--success-color);
                color: white;
                padding: 12px 20px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.2);
                font-size: 14px;
                animation: slideIn 0.3s ease-out, fadeOut 0.5s ease-out 3s forwards;
                z-index: 9999;
            }

            .custom-toast.error {
                background-color: var(--danger-color);
            }

            .custom-toast.success {
                background-color: var(--success-color);
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateX(100%);
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            @keyframes fadeOut {
                to {
                    opacity: 0;
                    transform: translateX(100%);
                }
            }

            .loading {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px;
                color: var(--gray-color);
            }

            .spinner {
                width: 20px;
                height: 20px;
                border: 2px solid #f3f4f6;
                border-top: 2px solid var(--primary-color);
                border-radius: 50%;
                animation: spin 1s linear infinite;
                margin-right: 8px;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                padding: 20px;
            }

            .pagination .page-link {
                border: none;
                color: var(--gray-color);
                margin: 0 0.25rem;
                border-radius: 6px;
                padding: 0.5rem 0.75rem;
                font-weight: 500;
            }

            .pagination .page-item.active .page-link {
                background-color: var(--primary-color);
                color: #fff;
            }

            .pagination .page-link:hover {
                background-color: rgba(0, 70, 170, 0.1);
                color: var(--primary-color);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .page-header {
                    padding: 2rem 0;
                }

                .main-container {
                    margin-top: -1rem;
                }

                .stats-grid {
                    grid-template-columns: repeat(2, 1fr);
                }

                .stats-number {
                    font-size: 2rem;
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
        <%@ include file="RecruiterNavbar.jsp" %>


        <!-- Page Header -->
        <section class="page-header">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8 text-center">
                        <h1 class="display-5 fw-bold mb-3">
                            <i class="bi bi-clipboard-check me-3"></i>Quản lý danh sách bài làm
                        </h1>
                        <p class="lead mb-0">Giao bài và theo dõi tiến độ làm bài của ứng viên</p>
                        <p class="text-white-50">Quản lý hiệu quả quá trình đánh giá ứng viên</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Toast Messages -->
        <c:if test="${not empty sessionScope.message}">
            <div id="toast-message" class="custom-toast success">${sessionScope.message}</div>
            <c:remove var="message" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div id="toast-message" class="custom-toast error">${sessionScope.error}</div>
            <c:remove var="error" scope="session" />
        </c:if>

        <!-- Main Content -->
        <div class="container">
            <div class="main-container">
                <div class="p-4">
                    <!-- Header Actions -->
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                        <div>
                            <h2 class="mb-1 fw-bold">Quản lý bài làm</h2>
                            <p class="text-muted mb-0">Tổng quan về các bài làm đã giao</p>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-secondary" onclick="openManualAssignModal()">
                                <i class="bi bi-person-plus me-2"></i>Giao bài thủ công
                            </button>
                            <button class="btn btn-primary" onclick="openAssignModal()">
                                <i class="bi bi-plus-lg me-2"></i>Giao bài tự động
                            </button>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="stats-grid">
                        <div class="stats-card primary">
                            <div class="stats-icon">
                                <i class="bi bi-clipboard-check"></i>
                            </div>
                            <div class="stats-number">${totalCount}</div>
                            <div class="stats-title">Bài làm đã giao</div>
                        </div>

                        <div class="stats-card success">
                            <div class="stats-icon">
                                <i class="bi bi-check-circle"></i>
                            </div>
                            <div class="stats-number">${completedCount}</div>
                            <div class="stats-title">Bài làm đã hoàn thành</div>
                        </div>

                        <div class="stats-card warning">
                            <div class="stats-icon">
                                <i class="bi bi-clock-history"></i>
                            </div>
                            <div class="stats-number">${doingCount}</div>
                            <div class="stats-title">Đang thực hiện</div>
                        </div>
                    </div>

                    <!-- Filter Section -->
                    <div class="section-card mb-4">
                        <form method="get" action="AssignmentManagement">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <label class="form-label">Tìm kiếm</label>
                                    <input type="text" name="search" class="form-control" placeholder="Tìm theo tên hoặc email" value="${param.search}">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Tên bài thi</label>
                                    <select class="form-select" name="testId">
                                        <option value="">Tất cả</option>
                                        <c:forEach var="item" items="${testFilter}">
                                            <option value="${item.testId}" ${param.testId == item.testId ? 'selected' : ''}>${item.title}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Bài tuyển dụng</label>
                                    <select class="form-select" name="jobId">
                                        <option value="">Tất cả</option>
                                        <c:forEach var="item" items="${jobFilter}">
                                            <option value="${item.jobId}" ${param.jobId == item.jobId ? 'selected' : ''}>${item.title}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Trạng thái</label>
                                    <select class="form-select" name="status">
                                        <option value="">Tất cả</option>
                                        <c:forEach var="item" items="${statusFilter}">
                                            <c:choose>
                                                <c:when test="${item == 'completed'}">
                                                    <option value="${item}" ${param.status == item ? 'selected' : ''}>Hoàn thành</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${item}" ${param.status == item ? 'selected' : ''}>Đang thực hiện</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Điểm số</label>
                                    <select class="form-select" name="scoreRange">
                                        <option value="">Tất cả</option>
                                        <option value="0-25" ${param.scoreRange == '0-25' ? 'selected' : ''}>0 - 25</option>
                                        <option value="25-50" ${param.scoreRange == '25-50' ? 'selected' : ''}>25 - 50</option>
                                        <option value="50-75" ${param.scoreRange == '50-75' ? 'selected' : ''}>50 - 75</option>
                                        <option value="75-100" ${param.scoreRange == '75-100' ? 'selected' : ''}>75 - 100</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Từ ngày</label>
                                    <input type="date" class="form-control" name="fromDate" value="${param.fromDate}">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Đến ngày</label>
                                    <input type="date" class="form-control" name="toDate" value="${param.toDate}">
                                </div>
                                <div class="col-md-3 d-flex align-items-end">
                                    <button class="btn btn-primary w-100" type="submit">
                                        <i class="bi bi-search me-2"></i>Tìm kiếm
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Table Section -->
                    <div class="section-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h3 class="mb-1 fw-bold">Danh sách bài làm</h3>
                                <p class="text-muted mb-0">Theo dõi tiến độ và kết quả bài làm</p>
                            </div>
                            <div>
                                <form method="get" action="AssignmentManagement" class="d-inline">
                                    <select class="form-select" name="pageSize" onchange="this.form.submit()">
                                        <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                        <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                                    </select>
                                    <input type="hidden" name="search" value="${param.search}">
                                    <input type="hidden" name="testId" value="${param.testId}">
                                    <input type="hidden" name="jobId" value="${param.jobId}">
                                    <input type="hidden" name="status" value="${param.status}">
                                    <input type="hidden" name="scoreRange" value="${param.scoreRange}">
                                    <input type="hidden" name="fromDate" value="${param.fromDate}">
                                    <input type="hidden" name="toDate" value="${param.toDate}">
                                </form>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${empty aList}">
                                <div class="text-center py-5">
                                    <i class="bi bi-clipboard-x" style="font-size: 3rem; color: #9ca3af;"></i>
                                    <h5 class="mt-3 mb-2">Không tìm thấy bài làm nào</h5>
                                    <p class="text-muted">Thử điều chỉnh tiêu chí tìm kiếm của bạn.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Ứng viên</th>
                                                <th>Tên bài thi</th>
                                                <th>Bài tuyển dụng</th>
                                                <th>Ngày giao</th>
                                                <th>Trạng thái</th>
                                                <th>Điểm số</th>
                                                <th>Ngày hoàn thành</th>
                                                <th class="text-center">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${aList}">
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <div class="fw-semibold">${item.candidateName}</div>
                                                            <div class="text-muted small">${item.candidateEmail}</div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="fw-semibold">${item.testTitle}</div>
                                                    </td>
                                                    <td>
                                                        <div class="fw-semibold">${item.jobTitle}</div>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${item.assignedAt}" pattern="dd/MM/yyyy" />
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${item.status == 'completed'}">
                                                                <span class="status-badge completed">
                                                                    <i class="bi bi-check-circle-fill"></i> Hoàn thành
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${item.status == 'doing'}">
                                                                <span class="status-badge in-progress">
                                                                    <i class="bi bi-clock-fill"></i> Đang thực hiện
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge not-started">
                                                                    <c:out value="${item.status}" />
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="score-display">
                                                            <div class="score-bar">
                                                                <div class="score-fill ${item.score >= 75 ? 'excellent' : item.score >= 50 ? 'good' : 'poor'}" style="width: ${item.score}%;"></div>
                                                            </div>
                                                            <span class="score-text">${item.score}%</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty item.completedAt}">
                                                                <fmt:formatDate value="${item.completedAt}" pattern="dd/MM/yyyy"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">N/A</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center">
                                                        <a class="action-btn view" href="AssignmentDetail?assignmentId=${item.assignmentId}&candidateId=${item.candidateId}" title="Xem chi tiết">
                                                            <i class="bi bi-eye"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a href="?page=${currentPage - 1}&pageSize=${pageSize}&search=${param.search}&testId=${param.testId}&jobId=${param.jobId}&status=${param.status}&scoreRange=${param.scoreRange}&fromDate=${param.fromDate}&toDate=${param.toDate}" class="page-link">
                                                    <i class="bi bi-chevron-left"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a href="?page=${i}&pageSize=${pageSize}&search=${param.search}&testId=${param.testId}&jobId=${param.jobId}&status=${param.status}&scoreRange=${param.scoreRange}&fromDate=${param.fromDate}&toDate=${param.toDate}" class="page-link">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a href="?page=${currentPage + 1}&pageSize=${pageSize}&search=${param.search}&testId=${param.testId}&jobId=${param.jobId}&status=${param.status}&scoreRange=${param.scoreRange}&fromDate=${param.fromDate}&toDate=${param.toDate}" class="page-link">
                                                    <i class="bi bi-chevron-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Regular Assignment Modal -->
        <div class="modal fade" id="assignmentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Giao bài thi tự động</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form id="assignmentForm" method="POST" action="AssignmentManagement">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Bài tuyển dụng <span class="text-danger">*</span></label>
                                <select class="form-select" id="jobPostSelect" name="jobId" required>
                                    <option value="">-- Chọn bài tuyển dụng --</option>
                                    <c:forEach var="item" items="${jobFilter}">
                                        <option value="${item.jobId}">${item.title}</option>
                                    </c:forEach>
                                </select>
                                <div id="assignmentStats" style="display: none; margin-top: 10px;">
                                    <p class="text-warning mb-1">Đã giao: <span id="assignedCount">-</span></p>
                                    <p class="text-success mb-0">Có thể giao: <span id="availableCount">-</span></p>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Bài thi <span class="text-danger">*</span></label>
                                <select class="form-select" id="testSelect" name="testId" required>
                                    <option value="">-- Chọn bài thi --</option>
                                    <c:forEach var="item" items="${testFilter}">
                                        <option value="${item.testId}">${item.title}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Hạn cuối <span class="text-danger">*</span></label>
                                <input type="datetime-local" class="form-control" id="dueDateInput" name="dueDate" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Xác nhận</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Manual Assignment Modal -->
        <div class="modal fade" id="manualAssignmentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Giao bài làm thủ công</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form id="manualAssignmentForm" method="POST" action="AssignTestManual">
                        <div class="modal-body">
                            <!-- Candidate Search Section -->
                            <div class="search-section">
                                <div class="mb-3">
                                    <label class="form-label">Tìm kiếm ứng viên</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="candidateEmailSearch" placeholder="Nhập email ứng viên" required>
                                        <button type="button" class="btn btn-primary" onclick="searchCandidate()">
                                            <i class="bi bi-search"></i> Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                                <div id="candidateSearchResults"></div>
                            </div>

                            <!-- Hidden inputs for selected candidate -->
                            <input type="hidden" id="selectedCandidateId" name="candidateId">
                            <input type="hidden" id="selectedCandidateEmail" name="candidateEmail">
                            <input type="hidden" id="selectedJobId" name="jobId" />

                            <!-- Test Selection -->
                            <div class="mb-3">
                                <label class="form-label">Bài thi <span class="text-danger">*</span></label>
                                <select class="form-select" id="manualTestSelect" name="testId" required>
                                    <option value="">-- Chọn bài thi --</option>
                                    <c:forEach var="item" items="${testFilter}">
                                        <option value="${item.testId}">${item.title}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Deadline -->
                            <div class="mb-3">
                                <label class="form-label">Hạn cuối <span class="text-danger">*</span></label>
                                <input type="datetime-local" class="form-control" id="manualDueDateInput" name="dueDate" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary" id="manualAssignBtn" disabled>
                                Giao bài
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                            let selectedCandidate = null;

                                            function openAssignModal() {
                                                const modal = new bootstrap.Modal(document.getElementById('assignmentModal'));
                                                modal.show();
                                            }

                                            function openManualAssignModal() {
                                                const modal = new bootstrap.Modal(document.getElementById('manualAssignmentModal'));
                                                modal.show();
                                                resetManualForm();
                                            }

                                            function resetManualForm() {
                                                document.getElementById('manualAssignmentForm').reset();
                                                document.getElementById('candidateSearchResults').innerHTML = '';
                                                document.getElementById('selectedCandidateId').value = '';
                                                document.getElementById('selectedCandidateEmail').value = '';
                                                document.getElementById('selectedJobId').value = '';
                                                document.getElementById('manualAssignBtn').disabled = true;
                                                selectedCandidate = null;
                                            }

                                            function searchCandidate() {
                                                const email = document.getElementById('candidateEmailSearch').value.trim();
                                                if (!email) {
                                                    showNotification('Vui lòng nhập email để tìm kiếm', 'error');
                                                    return;
                                                }

                                                // Show loading
                                                const resultsDiv = document.getElementById('candidateSearchResults');
                                                resultsDiv.innerHTML = '<div class="loading"><div class="spinner"></div>Đang tìm kiếm...</div>';

                                                // Fetch candidate data
                                                fetch('SearchCandidateServlet?email=' + encodeURIComponent(email))
                                                        .then(response => response.json())
                                                        .then(data => {
                                                            displaySearchResults(data);
                                                        })
                                                        .catch(error => {
                                                            console.error('Error searching candidate:', error);
                                                            resultsDiv.innerHTML = '<div class="text-center text-muted py-3">Lỗi khi tìm kiếm ứng viên</div>';
                                                            showNotification('Lỗi khi tìm kiếm ứng viên', 'error');
                                                        });
                                            }

                                            function displaySearchResults(data) {
                                                const resultsDiv = document.getElementById('candidateSearchResults');

                                                if (data.success && data.candidates && data.candidates.length > 0) {
                                                    let html = '';
                                                    data.candidates.forEach(candidate => {
                                                        const candidateId = candidate.candidateId;
                                                        const candidateName = candidate.fullName;
                                                        const candidateEmail = candidate.email;
                                                        const candidatePhone = candidate.phone || '';
                                                        const jobId = candidate.jobId;
                                                        const jobTitle = candidate.jobTitle;

                                                        const uniqueId = 'candidate-' + candidateId + '-job-' + jobId;

                                                        html += '<div class="candidate-result" id="' + uniqueId + '">';
                                                        html += '<div class="candidate-info">';
                                                        html += '<div class="candidate-details">';
                                                        html += '<div class="candidate-name">' + candidateName + '</div>';
                                                        html += '<div class="candidate-email">' + candidateEmail + '</div>';
                                                        html += '<div class="candidate-email">Bài tuyển dụng: ' + jobTitle + '</div>';
                                                        if (candidatePhone) {
                                                            html += '<div class="candidate-email">SĐT: ' + candidatePhone + '</div>';
                                                        }
                                                        html += '</div>';
                                                        html += '<button type="button" class="select-candidate-btn" onclick="selectCandidate(' + candidateId + ', \'' + candidateName.replace(/'/g, "\\'") + '\', \'' + candidateEmail + '\', ' + jobId + ', \'' + uniqueId + '\')">';
                                                        html += 'Chọn';
                                                        html += '</button>';
                                                        html += '</div>';
                                                        html += '</div>';
                                                    });
                                                    resultsDiv.innerHTML = html;
                                                } else {
                                                    resultsDiv.innerHTML = '<div class="text-center text-muted py-3">Không tìm thấy ứng viên với email này</div>';
                                                }
                                            }

                                            function selectCandidate(id, name, email, jobId, uniqueId) {
                                                // Remove previous selection
                                                document.querySelectorAll('.candidate-result').forEach(el => {
                                                    el.classList.remove('selected-candidate');
                                                    const btn = el.querySelector('.select-candidate-btn');
                                                    if (btn) {
                                                        btn.textContent = 'Chọn';
                                                    }
                                                });

                                                // Mark current selection
                                                const candidateElement = document.getElementById(uniqueId);
                                                if (candidateElement) {
                                                    candidateElement.classList.add('selected-candidate');
                                                    const selectedBtn = candidateElement.querySelector('.select-candidate-btn');
                                                    if (selectedBtn) {
                                                        selectedBtn.textContent = 'Đã chọn';
                                                    }
                                                }

                                                // Update hidden inputs
                                                document.getElementById('selectedCandidateId').value = id;
                                                document.getElementById('selectedCandidateEmail').value = email;
                                                document.getElementById('selectedJobId').value = jobId;

                                                // Enable submit button
                                                document.getElementById('manualAssignBtn').disabled = false;

                                                selectedCandidate = {id: id, name: name, email: email, jobId: jobId};
                                                showNotification('Đã chọn ứng viên: ' + name, 'success');
                                            }

                                            function showNotification(message, type) {
                                                const toast = document.createElement('div');
                                                toast.className = 'custom-toast ' + type;
                                                toast.textContent = message;
                                                document.body.appendChild(toast);
                                                setTimeout(() => toast.remove(), 3500);
                                            }

                                            // Regular assignment modal functionality
                                            document.getElementById("jobPostSelect").addEventListener("change", function () {
                                                const jobId = this.value;
                                                const url = "GetAssignmentStatsServlet?jobId=" + jobId;
                                                if (!jobId) {
                                                    document.getElementById("assignmentStats").style.display = "none";
                                                    return;
                                                }

                                                fetch(url)
                                                        .then(response => {
                                                            if (!response.ok) {
                                                                throw new Error('HTTP error! Status: ' + response.status);
                                                            }
                                                            return response.json();
                                                        })
                                                        .then(data => {
                                                            if (data.error) {
                                                                throw new Error(data.error);
                                                            }
                                                            document.getElementById("assignedCount").innerText = data.assigned;
                                                            document.getElementById("availableCount").innerText = data.available;
                                                            document.getElementById("assignmentStats").style.display = "block";
                                                        })
                                                        .catch(error => {
                                                            console.error("Lỗi khi lấy thống kê:", error);
                                                            document.getElementById("assignmentStats").style.display = "none";
                                                            showNotification('Error fetching assignment stats', 'error');
                                                        });
                                            });

                                            document.getElementById("assignmentForm").addEventListener("submit", function (event) {
                                                const jobSelect = document.getElementById("jobPostSelect");
                                                const testSelect = document.getElementById("testSelect");
                                                const dueDate = document.getElementById("dueDateInput");
                                                if (!jobSelect.value || !testSelect.value || !dueDate.value) {
                                                    event.preventDefault();
                                                    showNotification("Vui lòng điền đầy đủ các trường bắt buộc.", 'error');
                                                }
                                            });

                                            // Manual assignment form validation
                                            document.getElementById("manualAssignmentForm").addEventListener("submit", function (event) {
                                                const candidateId = document.getElementById("selectedCandidateId").value;
                                                const testId = document.getElementById("manualTestSelect").value;
                                                const dueDate = document.getElementById("manualDueDateInput").value;

                                                if (!candidateId || !testId || !dueDate) {
                                                    event.preventDefault();
                                                    showNotification("Vui lòng điền đầy đủ các trường bắt buộc và chọn ứng viên.", 'error');
                                                }
                                            });

                                            // Allow Enter key to trigger search
                                            document.getElementById('candidateEmailSearch').addEventListener('keypress', function (e) {
                                                if (e.key === 'Enter') {
                                                    e.preventDefault();
                                                    searchCandidate();
                                                }
                                            });

                                            // Reset forms when modals are hidden
                                            document.getElementById('assignmentModal').addEventListener('hidden.bs.modal', function () {
                                                document.getElementById('assignmentForm').reset();
                                                document.getElementById('assignmentStats').style.display = 'none';
                                            });

                                            document.getElementById('manualAssignmentModal').addEventListener('hidden.bs.modal', function () {
                                                resetManualForm();
                                            });
        </script>
    </body>
</html>