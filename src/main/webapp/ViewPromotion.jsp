<%-- 
    Document   : ViewPromotion
    Created on : Jul 13, 2025, 9:56:20 AM
    Author     : GBCenter
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mã khuyến mại - JobHub Recruiter</title>
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
                --warning-color: #fb6340;
                --info-color: #11cdef;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f0f6ff;
                color: #525f7f;
            }

            .navbar-custom {
                background-color: #f0f6ff;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
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

            .nav-link.active {
                color: var(--primary-color) !important;
                font-weight: 600;
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
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                background: #e6f0ff;
                transform: translateY(-2px);
                color: #0051ff;
            }

            /* Hero section */
            .hero-section {
                background: linear-gradient(270deg, #69b3ff, #1e3fa6 73.72%);
                color: white;
                padding: 3rem 0;
                position: relative;
                overflow: hidden;
                border-radius: 15px;
                margin-bottom: 2rem;
            }

            .hero-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-1.2.1&auto=format&fit=crop&w=2340&q=80');
                background-size: cover;
                background-position: center;
                opacity: 0.05;
            }

            .hero-section .container {
                position: relative;
                z-index: 1;
            }

            .stats-card {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                border: none;
                transition: all 0.3s ease;
                height: 100%;
            }

            .stats-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .stats-number {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .stats-title {
                color: #8898aa;
                font-size: 0.875rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .filter-card {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
                transition: all 0.3s ease;
            }

            .filter-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .list-card {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
                transition: all 0.3s ease;
            }

            .list-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .table-responsive {
                border-radius: 10px;
                overflow: hidden;
            }

            .table th {
                background-color: #f8f9fa;
                border: none;
                font-weight: 600;
                color: var(--dark-color);
                padding: 1rem;
            }

            .table td {
                border: none;
                vertical-align: middle;
                padding: 1rem;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
                transform: translateX(2px);
                transition: all 0.3s ease;
            }

            .badge-status {
                padding: 0.5rem 1rem;
                border-radius: 50rem;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .badge-primary {
                background-color: rgba(0, 70, 170, 0.1);
                color: var(--primary-color);
            }

            .badge-success {
                background-color: rgba(45, 206, 137, 0.1);
                color: var(--success-color);
            }

            .badge-warning {
                background-color: rgba(251, 99, 64, 0.1);
                color: var(--warning-color);
            }

            .badge-info {
                background-color: rgba(17, 205, 239, 0.1);
                color: var(--info-color);
            }

            .badge-danger {
                background-color: rgba(220, 53, 69, 0.1);
                color: #dc3545;
            }

            .icon-wrapper {
                width: 3rem;
                height: 3rem;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                font-size: 1.25rem;
            }

            .icon-primary {
                background-color: rgba(0, 70, 170, 0.1);
                color: var(--primary-color);
            }

            .icon-success {
                background-color: rgba(45, 206, 137, 0.1);
                color: var(--success-color);
            }

            .icon-warning {
                background-color: rgba(251, 99, 64, 0.1);
                color: var(--warning-color);
            }

            .icon-info {
                background-color: rgba(17, 205, 239, 0.1);
                color: var(--info-color);
            }

            /* Enhanced Modal styles */
            .modal-content {
                border-radius: 15px;
                border: none;
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .modal-header {
                background: linear-gradient(270deg, #69b3ff, #1e3fa6 73.72%);
                color: white;
                border-radius: 15px 15px 0 0;
                border-bottom: none;
                padding: 1.5rem;
            }

            .modal-body {
                padding: 2rem;
            }

            .form-label {
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 0.5rem;
            }

            .form-control, .form-select {
                border-radius: 0.5rem;
                border: 1px solid #e9ecef;
                padding: 0.75rem;
                transition: all 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(0, 70, 170, 0.25);
            }

            .pagination-container {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                margin-top: 1rem;
            }

            .fade-in {
                animation: fadeIn 0.5s ease-in;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Promotion card styling */
            .promo-title {
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 0.25rem;
            }

            .promo-code {
                font-family: 'Courier New', monospace;
                background: rgba(0, 70, 170, 0.1);
                color: var(--primary-color);
                padding: 0.25rem 0.5rem;
                border-radius: 0.25rem;
                font-weight: 600;
                font-size: 0.875rem;
            }

            .quantity-badge {
                background-color: rgba(45, 206, 137, 0.1);
                color: var(--success-color);
                padding: 0.25rem 0.75rem;
                border-radius: 1rem;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .expiry-badge {
                background-color: rgba(251, 99, 64, 0.1);
                color: var(--warning-color);
                padding: 0.25rem 0.75rem;
                border-radius: 1rem;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .info-item {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1rem;
                background: #f8f9fa;
                border-radius: 10px;
                margin-bottom: 1rem;
                border-left: 4px solid var(--primary-color);
            }

            .info-label {
                font-weight: 600;
                color: var(--dark-color);
                min-width: 120px;
            }

            .info-value {
                color: #525f7f;
                font-weight: 500;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .hero-section {
                    padding: 2rem 0;
                }

                .stats-number {
                    font-size: 2rem;
                }

                .table-responsive {
                    font-size: 0.875rem;
                }

                .filter-card .row > div {
                    margin-bottom: 1rem;
                }
            }

            .btn-detail {
                background: var(--secondary-color);
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-detail:hover {
                background: #e55a00;
                transform: translateY(-1px);
                color: white;
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
            <div class="container">
                <a class="navbar-brand" href="HomePage">
                    <span style="color: var(--primary-color);">Job</span><span style="color: var(--dark-color);">Hub</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="RecruiterDashboard">
                                <i class="bi bi-speedometer2 me-1"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="job-management">
                                <i class="bi bi-briefcase me-1"></i>Quản lý tin tuyển dụng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="application-management">
                                <i class="bi bi-people me-1"></i>Quản lý ứng viên
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="ViewPromotion">
                                <i class="bi bi-percent me-1"></i>Mã khuyến mại
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="buyServices">Các gói dịch vụ</a>
                        </li>
                    </ul>
                    <div class="d-flex">
                        <a href="JobPostingPage" class="btn btn-primary me-2">Tạo bài đăng</a>
                        <a href="EditProfileRecruiter" class="btn btn-outline-primary me-2">Quản lí Profile</a>
                        <a href="#" class="btn btn-danger" onclick="return confirmLogout()">Đăng xuất</a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid px-4 py-3">
            <!-- Hero Header -->
            <section class="hero-section">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h1 class="display-5 fw-bold mb-3">
                                <i class="bi bi-percent me-3"></i>Mã khuyến mại
                            </h1>
                            <p class="lead mb-0">Tiết kiệm chi phí với các mã giảm giá hấp dẫn</p>
                            <p class="text-white-50">Khám phá và sử dụng các mã khuyến mại để mua dịch vụ với giá ưu đãi</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="stats-card fade-in">
                        <div class="d-flex align-items-center">
                            <div class="flex-grow-1">
                                <div class="stats-number text-primary">${fn:length(list)}</div>
                                <div class="stats-title">Mã khuyến mại khả dụng</div>
                            </div>
                            <div class="icon-wrapper icon-primary">
                                <i class="bi bi-percent"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="stats-card fade-in" style="animation-delay: 0.2s;">
                        <div class="d-flex align-items-center">
                            <div class="flex-grow-1">
                                <div class="stats-number text-warning">${fn:length(proList)}</div>
                                <div class="stats-title">Loại khuyến mại</div>
                            </div>
                            <div class="icon-wrapper icon-warning">
                                <i class="bi bi-tags"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="stats-card fade-in" style="animation-delay: 0.3s;">
                        <div class="d-flex align-items-center">
                            <div class="flex-grow-1">
                                <div class="stats-number text-info">${totalPages}</div>
                                <div class="stats-title">Tổng số trang</div>
                            </div>
                            <div class="icon-wrapper icon-info">
                                <i class="bi bi-file-earmark-text"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Advanced Filter Card -->
            <div class="filter-card fade-in" style="animation-delay: 0.4s;">
                <h5 class="mb-3 fw-bold">
                    <i class="bi bi-funnel me-2"></i>Bộ lọc tìm kiếm nâng cao
                </h5>
                <form action="ViewPromotion" method="post">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">
                                <i class="bi bi-tag me-1"></i>Loại khuyến mại
                            </label>
                            <select name="type" class="form-select">
                                <option value="all" ${type == 'all' ? 'selected' : ''}>Tất cả loại</option>
                                <c:forEach items="${proList}" var="pro">
                                    <option value="${pro}" ${type == pro ? 'selected' : ''}>${pro}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                <i class="bi bi-calendar-x me-1"></i>Sắp xếp theo hạn sử dụng
                            </label>
                            <select name="endDate" class="form-select">
                                <option value="asc" ${endDate == 'asc' ? 'selected' : ''}>Gần hạn đến xa hạn</option>
                                <option value="desc" ${endDate == 'desc' ? 'selected' : ''}>Xa hạn đến gần hạn</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                <i class="bi bi-percent me-1"></i>Sắp xếp theo mức giảm giá
                            </label>
                            <select name="discount" class="form-select">
                                <option value="desc" ${discount == 'desc' ? 'selected' : ''}>Cao xuống thấp</option>
                                <option value="asc" ${discount == 'asc' ? 'selected' : ''}>Thấp lên cao</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="bi bi-cash me-1"></i>Sắp xếp theo trần giảm giá
                            </label>
                            <select name="maxDiscount" class="form-select">
                                <option value="desc" ${maxDiscount == 'desc' ? 'selected' : ''}>Cao xuống thấp</option>
                                <option value="asc" ${maxDiscount == 'asc' ? 'selected' : ''}>Thấp lên cao</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="bi bi-stack me-1"></i>Sắp xếp theo số lượng
                            </label>
                            <select name="remaining" class="form-select">
                                <option value="asc" ${remaining == 'asc' ? 'selected' : ''}>Ít đến nhiều</option>
                                <option value="desc" ${remaining == 'desc' ? 'selected' : ''}>Nhiều đến ít</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="bi bi-list me-1"></i>Số lượng/trang
                            </label>
                            <select name="top" class="form-select">
                                <option value="10" ${top == 10 ? 'selected' : ''}>10</option>
                                <option value="20" ${top == 20 ? 'selected' : ''}>20</option>
                                <option value="50" ${top == 50 ? 'selected' : ''}>50</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <div class="d-flex align-items-end h-100">
                                <button class="btn btn-primary w-100" type="submit">
                                    <i class="bi bi-search me-1"></i>Áp dụng bộ lọc
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Promotion Listings Card -->
            <div class="list-card fade-in" style="animation-delay: 0.5s;">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-gift me-2"></i>Danh sách mã khuyến mại
                    </h5>
                    <span class="text-muted">
                        Hiển thị ${(page - 1) * top + 1} - ${(page - 1) * top + fn:length(list)} kết quả
                    </span>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th><i class="bi bi-hash me-1"></i>STT</th>
                                <th><i class="bi bi-gift me-1"></i>Tên khuyến mại</th>
                                <th><i class="bi bi-tag me-1"></i>Loại</th>
                                <th><i class="bi bi-code me-1"></i>Mã khuyến mại</th>
                                <th><i class="bi bi-stack me-1"></i>Số lượng</th>
                                <th><i class="bi bi-calendar-x me-1"></i>Hạn sử dụng</th>
                                <th><i class="bi bi-gear me-1"></i>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${list}" var="l" varStatus="loop">
                                <tr>
                                    <td>
                                        <span class="fw-bold text-primary">${(page - 1) * top + loop.index + 1}</span>
                                    </td> 
                                    <td>
                                        <div class="promo-title">${l.title}</div>
                                    </td>
                                    <td>
                                        <span class="badge badge-status badge-info">
                                            ${l.promotionType}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="promo-code">${l.promoCode}</span>
                                    </td>
                                    <td>
                                        <span class="quantity-badge">
                                            ${l.quantity} 
                                        </span>
                                    </td>
                                    <td>
                                        <span class="expiry-badge">
                                            <fmt:formatDate value="${l.endDate}" pattern="dd/MM/yyyy" />
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-detail btn-sm" data-bs-toggle="modal" data-bs-target="#promoModal-${l.promoCode}">
                                            <i class="bi bi-eye me-1"></i>Chi tiết
                                        </button>
                                    </td>
                                </tr>  
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Enhanced Pagination -->
                <div class="pagination-container text-center">
                    <div class="d-flex justify-content-center align-items-center gap-2">
                        <!-- Previous Button -->
                        <form action="ViewPromotion" method="post" style="display:inline;">
                            <input type="hidden" name="top" value="${top}" />
                            <input type="hidden" name="type" value="${type}" />
                            <input type="hidden" name="endDate" value="${endDate}" />
                            <input type="hidden" name="discount" value="${discount}" />
                            <input type="hidden" name="maxDiscount" value="${maxDiscount}" />
                            <input type="hidden" name="remaining" value="${remaining}" />
                            <input type="hidden" name="page" value="${page - 1}" />
                            <button class="btn btn-outline-primary" ${page == 1 ? 'disabled' : ''}>
                                <i class="bi bi-chevron-left"></i>
                            </button>
                        </form>

                        <!-- Page Numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="pageNum">
                            <c:if test="${pageNum <= page + 2 && pageNum >= page - 2}">
                                <form action="ViewPromotion" method="post" style="display:inline;">
                                    <input type="hidden" name="top" value="${top}" />
                                    <input type="hidden" name="type" value="${type}" />
                                    <input type="hidden" name="endDate" value="${endDate}" />
                                    <input type="hidden" name="discount" value="${discount}" />
                                    <input type="hidden" name="maxDiscount" value="${maxDiscount}" />
                                    <input type="hidden" name="remaining" value="${remaining}" />
                                    <input type="hidden" name="page" value="${pageNum}" />
                                    <button class="btn ${pageNum == page ? 'btn-primary' : 'btn-outline-primary'}">${pageNum}</button>
                                </form>
                            </c:if>
                        </c:forEach>

                        <!-- Next Button -->
                        <form action="ViewPromotion" method="post" style="display:inline;">
                            <input type="hidden" name="top" value="${top}" />
                            <input type="hidden" name="type" value="${type}" />
                            <input type="hidden" name="endDate" value="${endDate}" />
                            <input type="hidden" name="discount" value="${discount}" />
                            <input type="hidden" name="maxDiscount" value="${maxDiscount}" />
                            <input type="hidden" name="remaining" value="${remaining}" />
                            <input type="hidden" name="page" value="${page + 1}" />
                            <button class="btn btn-outline-primary" ${page == totalPages ? 'disabled' : ''}>
                                <i class="bi bi-chevron-right"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Enhanced Modals for each promotion -->
        <c:forEach items="${list}" var="l">
            <div class="modal fade" id="promoModal-${l.promoCode}" tabindex="-1" aria-labelledby="promoModalLabel-${l.promoCode}" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div>
                                <h4 class="modal-title fw-bold">${l.title}</h4>
                                <p class="mb-0 text-white-50">Loại: ${l.promotionType}</p>
                            </div>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-12">
                                    <div class="alert alert-primary">
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-code-square me-3" style="font-size: 2rem;"></i>
                                            <div>
                                                <h6 class="mb-1">Mã khuyến mại</h6>
                                                <h4 class="mb-0 fw-bold">${l.promoCode}</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="info-item">
                                        <div class="icon-wrapper icon-info">
                                            <i class="bi bi-info-circle"></i>
                                        </div>
                                        <div>
                                            <div class="info-label">Mô tả:</div>
                                            <div class="info-value">${l.description}</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="icon-wrapper icon-success">
                                            <i class="bi bi-percent"></i>
                                        </div>
                                        <div>
                                            <div class="info-label">Mức giảm giá:</div>
                                            <div class="info-value">${l.discountPercent}%</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="icon-wrapper icon-warning">
                                            <i class="bi bi-cash"></i>
                                        </div>
                                        <div>
                                            <div class="info-label">Trần giảm giá:</div>
                                            <div class="info-value">
                                                <fmt:formatNumber value="${l.maxDiscountAmount}" type="number" groupingUsed="true"/>₫
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="icon-wrapper icon-primary">
                                            <i class="bi bi-calendar-plus"></i>
                                        </div>
                                        <div>
                                            <div class="info-label">Ngày bắt đầu:</div>
                                            <div class="info-value">
                                                <fmt:formatDate value="${l.startDate}" pattern="dd/MM/yyyy" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="icon-wrapper icon-danger">
                                            <i class="bi bi-calendar-x"></i>
                                        </div>
                                        <div>
                                            <div class="info-label">Ngày hết hạn:</div>
                                            <div class="info-value">
                                                <fmt:formatDate value="${l.endDate}" pattern="dd/MM/yyyy" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="info-item">
                                        <div class="icon-wrapper icon-success">
                                            <i class="bi bi-stack"></i>
                                        </div>
                                        <div>
                                            <div class="info-label">Số lượng còn lại:</div>
                                            <div class="info-value">
                                                <span class="badge bg-success fs-6">${l.quantity}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4">
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                    <i class="bi bi-x-circle me-1"></i>Đóng
                                </button>
                                <button type="button" class="btn btn-primary" onclick="copyPromoCode('${l.promoCode}')">
                                    <i class="bi bi-clipboard me-1"></i>Sao chép mã
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    // Confirmation dialog for logout
                                    function confirmLogout() {
                                        if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                                            window.location.href = 'logout';
                                            return true;
                                        }
                                        return false;
                                    }

                                    // Update current time
                                    function updateTime() {
                                        const now = new Date();
                                        const timeString = now.toLocaleString('vi-VN');
                                        const timeElement = document.getElementById('currentTime');
                                        if (timeElement) {
                                            timeElement.textContent = timeString;
                                        }
                                    }
                                    updateTime();
                                    setInterval(updateTime, 1000);

                                    // Copy promo code to clipboard
                                    function copyPromoCode(code) {
                                        navigator.clipboard.writeText(code).then(function () {
                                            // Show success message
                                            const toast = document.createElement('div');
                                            toast.className = 'toast align-items-center text-white bg-success border-0 position-fixed top-0 end-0 m-3';
                                            toast.style.zIndex = '9999';
                                            toast.innerHTML = `
                        <div class="d-flex">
                            <div class="toast-body">
                                <i class="bi bi-check-circle me-2"></i>Đã sao chép mã: ${code}
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                        </div>
                    `;
                                            document.body.appendChild(toast);
                                            const bsToast = new bootstrap.Toast(toast);
                                            bsToast.show();

                                            // Remove toast after it's hidden
                                            toast.addEventListener('hidden.bs.toast', function () {
                                                document.body.removeChild(toast);
                                            });
                                        }).catch(function (err) {
                                            console.error('Could not copy text: ', err);
                                            alert('Không thể sao chép mã. Vui lòng thử lại.');
                                        });
                                    }

                                    // Initialize animations
                                    document.addEventListener('DOMContentLoaded', function () {
                                        // Add fade-in animation to elements
                                        const elements = document.querySelectorAll('.fade-in');
                                        elements.forEach((element, index) => {
                                            element.style.opacity = '0';
                                            element.style.transform = 'translateY(20px)';

                                            setTimeout(() => {
                                                element.style.transition = 'all 0.5s ease';
                                                element.style.opacity = '1';
                                                element.style.transform = 'translateY(0)';
                                            }, index * 100);
                                        });
                                    });

                                    console.log('Promotion codes page loaded successfully');
        </script>
    </body>
</html>