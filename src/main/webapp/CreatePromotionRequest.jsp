<%-- 
    Document   : CreatePromotionRequest
    Created on : Jul 11, 2025, 10:34:49 PM
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
        <title>Tạo yêu cầu quảng cáo - JobHub Recruiter</title>
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
                background-image: url('https://images.unsplash.com/photo-1560472354-b33ff0c44a43?ixlib=rb-1.2.1&auto=format&fit=crop&w=2126&q=80');
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

            /* Job card styling */
            .job-title {
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 0.25rem;
            }

            .job-details {
                font-size: 0.875rem;
                color: #6c757d;
            }

            .salary-range {
                font-weight: 600;
                color: var(--success-color);
            }

            .deadline-badge {
                background-color: rgba(251, 99, 64, 0.1);
                color: var(--warning-color);
                padding: 0.25rem 0.75rem;
                border-radius: 1rem;
                font-size: 0.75rem;
                font-weight: 600;
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

            .btn-promotion {
                background: var(--secondary-color);
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-promotion:hover {
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
                            <a class="nav-link active" href="CreatePromotionRequest">
                                <i class="bi bi-megaphone me-1"></i>Yêu cầu quảng cáo
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
                                <i class="bi bi-megaphone me-3"></i>Yêu cầu quảng cáo
                            </h1>
                            <p class="lead mb-0">Tăng tầm nhìn cho tin tuyển dụng của bạn</p>
                            <p class="text-white-50">Chọn tin tuyển dụng và tạo yêu cầu quảng cáo để tiếp cận nhiều ứng viên hơn</p>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <div class="d-flex flex-column align-items-md-end">
                                <span class="badge bg-white text-primary fs-6 mb-2">
                                    <i class="bi bi-graph-up me-1"></i>Tăng hiệu quả tuyển dụng
                                </span>
                            </div>
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
                                <div class="stats-title">Tin có thể quảng cáo</div>
                            </div>
                            <div class="icon-wrapper icon-primary">
                                <i class="bi bi-briefcase"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="stats-card fade-in" style="animation-delay: 0.1s;">
                        <div class="d-flex align-items-center">
                            <div class="flex-grow-1">
                                <div class="stats-number text-success">${total}</div>
                                <div class="stats-title">Tổng kết quả tìm kiếm</div>
                            </div>
                            <div class="icon-wrapper icon-success">
                                <i class="bi bi-search"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="stats-card fade-in" style="animation-delay: 0.2s;">
                        <div class="d-flex align-items-center">
                            <div class="flex-grow-1">
                                <div class="stats-number text-warning">${fn:length(iList)}</div>
                                <div class="stats-title">Lĩnh vực khả dụng</div>
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
                <form action="CreatePromotionRequest" method="post">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">
                                <i class="bi bi-search me-1"></i>Tên công việc
                            </label>
                            <input type="text" name="jobName" value="${jobName}" 
                                   class="form-control" placeholder="Tìm theo tên công việc"/>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                <i class="bi bi-building me-1"></i>Lĩnh vực
                            </label>
                            <select name="industry" class="form-select">
                                <option value="" ${industry == '' ? 'selected' : ''}>Tất cả lĩnh vực</option>
                                <c:forEach items="${iList}" var="i">
                                    <option value="${i.nameIndustry}" ${industry == i.nameIndustry ? 'selected' : ''}>${i.nameIndustry}</option>  
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">
                                <i class="bi bi-briefcase me-1"></i>Loại việc
                            </label>
                            <select name="jobType" class="form-select">
                                <option value="" ${jobType == '' ? 'selected' : ''}>Tất cả loại việc</option>
                                <c:forEach items="${tList}" var="t">
                                    <option value="${t}" ${jobType == t ? 'selected' : ''}>${t}</option>  
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="bi bi-list me-1"></i>Số việc/trang
                            </label>
                            <select name="pageSize" class="form-select">
                                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                                <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="bi bi-calendar me-1"></i>Hạn chót từ
                            </label>
                            <input type="date" name="fromDate" value="${fromDate}" class="form-control"/>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">
                                <i class="bi bi-calendar-check me-1"></i>Hạn chót đến
                            </label>
                            <input type="date" name="toDate" value="${toDate}" class="form-control"/>
                        </div>
                        <div class="col-md-3">
                            <div class="d-flex align-items-end h-100">
                                <button class="btn btn-primary w-100" type="submit">
                                    <i class="bi bi-search me-1"></i>Tìm kiếm
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">
                                <i class="bi bi-currency-dollar me-1"></i>Khoảng lương (VNĐ)
                            </label>
                            <div class="row g-2">
                                <div class="col">
                                    <input type="text" name="minSalary" id="minSalary" class="form-control" placeholder="Lương tối thiểu" value="${minSalary}"/>
                                </div>
                                <div class="col-auto d-flex align-items-center">
                                    <span class="text-muted">đến</span>
                                </div>
                                <div class="col">
                                    <input type="text" name="maxSalary" id="maxSalary" class="form-control" placeholder="Lương tối thiểu" value="${maxSalary}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Job Listings Card -->
            <div class="list-card fade-in" style="animation-delay: 0.5s;">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-list-ul me-2"></i>Danh sách tin tuyển dụng có thể quảng cáo
                    </h5>
                    <span class="text-muted">
                        Tìm thấy ${total} kết quả
                    </span>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th><i class="bi bi-hash me-1"></i>STT</th>
                                <th><i class="bi bi-briefcase me-1"></i>Việc làm</th>
                                <th><i class="bi bi-building me-1"></i>Lĩnh vực</th>
                                <th><i class="bi bi-currency-dollar me-1"></i>Mức lương</th>
                                <th><i class="bi bi-calendar-x me-1"></i>Hạn chót</th>
                                <th><i class="bi bi-gear me-1"></i>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${list}" var="l" varStatus="loop">
                                <tr>
                                    <td>
                                        <span class="fw-bold text-primary">${(currentPage - 1) * pageSize + loop.index + 1}</span>
                                    </td> 
                                    <td>
                                        <div class="job-title">${l.title}</div>
                                        <div class="job-details">
                                            <span class="badge badge-status badge-info me-1">${l.experienceLevel}</span>
                                            <span class="badge badge-status badge-primary">${l.jobType}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge badge-status badge-warning">
                                            ${l.industry.nameIndustry}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="salary-range">
                                            <fmt:formatNumber value="${l.salaryMin}" type="number" groupingUsed="true" />₫
                                            <br>
                                            <small class="text-muted">đến</small>
                                            <br>
                                            <fmt:formatNumber value="${l.salaryMax}" type="number" groupingUsed="true" />₫
                                        </div>
                                    </td>
                                    <td>
                                        <span class="deadline-badge">
                                            <fmt:parseDate value="${l.deadline}" pattern="yyyy-MM-dd" var="createdDate" />
                                            <fmt:formatDate value="${createdDate}" pattern="dd/MM/yyyy" />
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-promotion btn-sm" data-bs-toggle="modal" data-bs-target="#promotionModal-${l.jobId}">
                                            <i class="bi bi-megaphone me-1"></i>Yêu cầu
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
                        <form action="CreatePromotionRequest" method="post" style="display:inline;">
                            <input type="hidden" name="page" value="${currentPage - 1}" />
                            <input type="hidden" name="pageSize" value="${pageSize}" />
                            <input type="hidden" name="jobName" value="${jobName}" />
                            <input type="hidden" name="industry" value="${industry}" />
                            <input type="hidden" name="jobType" value="${jobType}" />
                            <input type="hidden" name="fromDate" value="${fromDate}" />
                            <input type="hidden" name="toDate" value="${toDate}" />
                            <input type="hidden" name="minSalary" value="${minSalary}" />
                            <input type="hidden" name="maxSalary" value="${maxSalary}" />
                            <button class="btn btn-outline-primary" ${currentPage <= 1 ? 'disabled' : ''}>
                                <i class="bi bi-chevron-left"></i>
                            </button>
                        </form>

                        <!-- Page Numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="page">
                            <c:if test="${page >= currentPage - 2 && page <= currentPage + 2}">
                                <form action="CreatePromotionRequest" method="post" style="display:inline;">
                                    <input type="hidden" name="page" value="${page}" />
                                    <input type="hidden" name="pageSize" value="${pageSize}" />
                                    <input type="hidden" name="jobName" value="${jobName}" />
                                    <input type="hidden" name="industry" value="${industry}" />
                                    <input type="hidden" name="jobType" value="${jobType}" />
                                    <input type="hidden" name="fromDate" value="${fromDate}" />
                                    <input type="hidden" name="toDate" value="${toDate}" />
                                    <input type="hidden" name="minSalary" value="${minSalary}" />
                                    <input type="hidden" name="maxSalary" value="${maxSalary}" />
                                    <button class="btn ${page == currentPage ? 'btn-primary' : 'btn-outline-primary'}">${page}</button>
                                </form>
                            </c:if>
                        </c:forEach>

                        <!-- Next Button -->
                        <form action="CreatePromotionRequest" method="post" style="display:inline;">
                            <input type="hidden" name="page" value="${currentPage + 1}" />
                            <input type="hidden" name="pageSize" value="${pageSize}" />
                            <input type="hidden" name="jobName" value="${jobName}" />
                            <input type="hidden" name="industry" value="${industry}" />
                            <input type="hidden" name="jobType" value="${jobType}" />
                            <input type="hidden" name="fromDate" value="${fromDate}" />
                            <input type="hidden" name="toDate" value="${toDate}" />
                            <input type="hidden" name="minSalary" value="${minSalary}" />
                            <input type="hidden" name="maxSalary" value="${maxSalary}" />
                            <button class="btn btn-outline-primary" ${currentPage >= totalPages ? 'disabled' : ''}>
                                <i class="bi bi-chevron-right"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Enhanced Modals for each job -->
        <c:forEach items="${list}" var="l">
            <div class="modal fade" id="promotionModal-${l.jobId}" tabindex="-1" aria-labelledby="promotionModalLabel-${l.jobId}" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div>
                                <h4 class="modal-title fw-bold">Yêu cầu quảng cáo</h4>
                                <p class="mb-0 text-white-50">Tin tuyển dụng: ${l.title}</p>
                            </div>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="UpdatePromotionDetails" method="post">
                                <input type="hidden" name="jobId" value="${l.jobId}"/>

                                <div class="row g-3">
                                    <div class="col-12">
                                        <div class="alert alert-info">
                                            <i class="bi bi-info-circle me-2"></i>
                                            <strong>Thông tin tin tuyển dụng:</strong><br>
                                            <strong>Vị trí:</strong> ${l.title}<br>
                                            <strong>Lĩnh vực:</strong> ${l.industry.nameIndustry}<br>
                                            <strong>Mức lương:</strong> <fmt:formatNumber value="${l.salaryMin}" type="number" groupingUsed="true" />₫ - <fmt:formatNumber value="${l.salaryMax}" type="number" groupingUsed="true" />₫
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <label class="form-label">
                                            <i class="bi bi-file-text me-1"></i>Mô tả quảng cáo
                                        </label>
                                        <textarea name="description" rows="4" class="form-control" 
                                                  placeholder="Nhập mô tả chi tiết cho chiến dịch quảng cáo..." required></textarea>
                                        <div class="form-text">Mô tả sẽ được hiển thị cùng với tin tuyển dụng được quảng cáo</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="bi bi-calendar-plus me-1"></i>Ngày bắt đầu quảng cáo
                                        </label>
                                        <input type="date" name="startDate" class="form-control" required>
                                        <div class="form-text">Chọn ngày bắt đầu chiến dịch quảng cáo</div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end gap-2 mt-4">
                                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                        <i class="bi bi-x-circle me-1"></i>Hủy
                                    </button>
                                    <button type="submit" class="btn btn-success">
                                        <i class="bi bi-check-circle me-1"></i>Gửi yêu cầu
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            function formatNumberInput(input) {
                                let value = input.value.replace(/[^\d]/g, ""); // Remove non-digits
                                if (value) {
                                    input.value = Number(value).toLocaleString("vi-VN"); // Format as Vietnamese currency grouping
                                } else {
                                    input.value = ""; // Clear if empty
                                }
                            }

                            // Apply formatter as user types
                            document.getElementById("minSalary").addEventListener("input", function () {
                                formatNumberInput(this);
                            });
                            document.getElementById("maxSalary").addEventListener("input", function () {
                                formatNumberInput(this);
                            });
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

                                // Set minimum date for start date inputs
                                const today = new Date().toISOString().split('T')[0];
                                const dateInputs = document.querySelectorAll('input[name="startDate"]');
                                dateInputs.forEach(input => {
                                    input.min = today;
                                });
                            });

                            console.log('Promotion Request page loaded successfully');
        </script>
    </body>
</html>