<%-- 
    Document   : ViewServicePackage
    Created on : Jul 13, 2025, 2:55:15 PM
    Author     : GBCenter
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thống kê gói dịch vụ - JobHub Admin</title>
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
                background-image: url('https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
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

            /* Modal styles */
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
            }

            .modal-body {
                padding: 2rem;
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
                            <a class="nav-link active" href="RecruiterDashboard">
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
                                <i></i>Các gói dịch vụ
                            </h1>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <div class="d-flex flex-column align-items-md-end">
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Statistics Cards -->
            <div class="row mb-4">

            </div>

            <!-- Filter Card -->
            <div class="filter-card fade-in" style="animation-delay: 0.4s;">
                <form action="ViewServicePackage" method="post">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-list me-1"></i>Số dịch vụ/trang
                            </label>
                            <select name="top" class="form-select">
                                <option value="10" ${top == 10 ? 'selected' : ''}>10</option>
                                <option value="20" ${top == 20 ? 'selected' : ''}>20</option>
                                <option value="50" ${top == 50 ? 'selected' : ''}>50</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-tags me-1"></i>Loại hình
                            </label>
                            <select name="type" class="form-select">
                                <option value="all" ${type == 'all' ? 'selected' : ''}>Tất cả</option>
                                <c:forEach items="${sList}" var="t">
                                    <option value="${t}" ${type == t ? 'selected' : ''}>${t}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-sort-down me-1"></i>Thứ tự
                            </label>
                            <select name="sortOrder" class="form-select">
                                <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>Tăng dần</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-primary w-100" type="submit">
                                <i class="bi bi-funnel me-1"></i>Áp dụng bộ lọc
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Main Data Table -->
            <div class="list-card fade-in" style="animation-delay: 0.5s;">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0 fw-bold">
                        <i></i>Danh sách gói của bạn
                    </h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th><i class="bi bi-hash me-1"></i>STT</th>
                                <th><i class="bi bi-box me-1"></i>Tên dịch vụ</th>
                                <th><i class="bi bi-tag me-1"></i>Loại dịch vụ</th>
                                <th><i class="bi bi-currency-dollar me-1"></i>Giá dịch vụ</th>
                                <th><i class="bi bi-cart-check me-1"></i>Số lượng đã mua</th>
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
                                        <div class="fw-bold text-dark">${l.service.title}</div>
                                    </td>
                                    <td>
                                        <span class="badge badge-status badge-primary">
                                            ${l.service.serviceType}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="fw-bold text-success">
                                            <fmt:formatNumber value="${l.service.price}" type="number" groupingUsed="true" />₫
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge badge-status badge-info fs-6">
                                            ${l.count}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-detail btn-sm" 
                                                onclick="showModal('${l.service.title}', '${l.service.serviceType}', '${l.service.credit}', '${l.service.price}', '${l.service.isActive}', '${l.service.description}')">
                                            <i class="bi bi-eye me-1"></i>Xem chi tiết
                                        </button>
                                    </td>
                                </tr>  
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Pagination -->
            <div class="pagination-container text-center fade-in" style="animation-delay: 0.6s;">
                <div class="d-flex justify-content-center align-items-center gap-2">
                    <!-- Prev Button -->
                    <form action="ViewServicePackage" method="post" style="display:inline;">
                        <input type="hidden" name="type" value="${type}" />
                        <input type="hidden" name="sortOrder" value="${sortOrder}" />
                        <input type="hidden" name="top" value="${top}" />
                        <input type="hidden" name="page" value="${page - 1}" />
                        <button class="btn btn-outline-primary" ${page == 1 ? 'disabled' : ''}>
                            <i class="bi bi-chevron-left"></i>
                        </button>
                    </form>

                    <!-- Page Numbers -->
                    <c:forEach begin="1" end="${totalPages}" var="p">
                        <c:if test="${p <= page + 2 && p >= page - 2}">
                            <form action="ViewServicePackage" method="post" style="display:inline;">
                                <input type="hidden" name="type" value="${type}" />
                                <input type="hidden" name="sortOrder" value="${sortOrder}" />
                                <input type="hidden" name="top" value="${top}" />
                                <input type="hidden" name="page" value="${p}" />
                                <button class="btn ${p == page ? 'btn-primary' : 'btn-outline-primary'}">${p}</button>
                            </form>
                        </c:if>
                    </c:forEach>

                    <!-- Next Button -->
                    <form action="ViewServicePackage" method="post" style="display:inline;">
                        <input type="hidden" name="type" value="${type}" />
                        <input type="hidden" name="sortOrder" value="${sortOrder}" />
                        <input type="hidden" name="top" value="${top}" />
                        <input type="hidden" name="page" value="${page + 1}" />
                        <button class="btn btn-outline-primary" ${page == totalPages ? 'disabled' : ''}>
                            <i class="bi bi-chevron-right"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Enhanced Modal -->
        <div class="modal fade" id="serviceModal" tabindex="-1" aria-labelledby="serviceModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div>
                            <h4 class="modal-title fw-bold" id="modalTitle">Tên dịch vụ</h4>
                            <p class="mb-0 text-white-50" id="modalType">Loại dịch vụ</p>
                        </div>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-12">
                                <div class="info-item">
                                    <div class="icon-wrapper icon-info">
                                        <i class="bi bi-credit-card"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">Lượng sử dụng:</div>
                                        <div class="info-value" id="modalCredit"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="info-item">
                                    <div class="icon-wrapper icon-success">
                                        <i class="bi bi-currency-dollar"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">Giá:</div>
                                        <div class="info-value" id="modalPrice"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="info-item">
                                    <div class="icon-wrapper icon-warning">
                                        <i class="bi bi-toggle-on"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">Trạng thái:</div>
                                        <div class="info-value" id="modalStatus"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="info-item">
                                    <div class="icon-wrapper icon-primary">
                                        <i class="bi bi-info-circle"></i>
                                    </div>
                                    <div>
                                        <div class="info-label">Mô tả:</div>
                                        <div class="info-value" id="modalDescription"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

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

                                                    // Modal functionality
                                                    function showModal(title, type, credit, price, status, description) {
                                                        document.getElementById('modalTitle').textContent = title;
                                                        document.getElementById('modalType').textContent = type;
                                                        document.getElementById('modalCredit').textContent = credit;
                                                        document.getElementById('modalPrice').textContent = parseFloat(price).toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                                                        document.getElementById('modalStatus').textContent = status === 'true' ? 'Hoạt động' : 'Ngừng hoạt động';
                                                        document.getElementById('modalDescription').textContent = description;

                                                        const modal = new bootstrap.Modal(document.getElementById('serviceModal'));
                                                        modal.show();
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

                                                    console.log('Service Package Dashboard loaded successfully');
        </script>
    </body>
</html>