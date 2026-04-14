<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Danh sách ứng viên | MyJob</title>
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
        --warning-color: #ffc107; /* Added for consistency with original viewJobApplicants */
        --info-color: #17a2b8; /* Added for consistency with original viewJobApplicants */
        --error-color: #dc3545; /* Added for consistency with original viewJobApplicants */
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
        padding: 0.75rem 2rem;
        font-weight: 600;
        border-radius: 10px;
        transition: all 0.3s ease;
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
    .stats-card {
        background-color: white;
        border-radius: 15px;
        padding: 1.5rem;
        box-shadow: 0 0 30px rgba(0,0,0,0.1);
        text-align: center;
        height: 100%;
        transition: all 0.3s ease;
    }
    .stats-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
    }
    .stats-number {
        font-size: 2.5rem;
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 0.5rem;
    }
    .stats-title {
        color: #8898aa;
        font-size: 0.875rem;
        font-weight: 500;
    }
    .filter-card {
        background-color: white;
        border-radius: 15px;
        padding: 1.5rem;
        box-shadow: 0 0 30px rgba(0,0,0,0.1);
        margin-bottom: 2rem;
    }
    .applicant-card { /* Renamed from interview-card for clarity */
        background-color: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 0 30px rgba(0,0,0,0.1);
        transition: all 0.3s;
        border: none;
        margin-bottom: 1.5rem;
    }
    .applicant-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
    }
    .applicant-card .card-body {
        padding: 1.5rem;
    }
    .candidate-avatar {
        width: 4rem;
        height: 4rem;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #f5f9fc;
        background: linear-gradient(45deg, var(--primary-color), #0051ff);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        font-size: 1.5rem;
    }
    .candidate-name {
        font-weight: 700;
        color: var(--dark-color);
        margin: 0.5rem 0;
        font-size: 1.25rem;
    }
    .job-title {
        color: #8898aa;
        font-weight: 500;
        margin-bottom: 1rem;
    }
    .applicant-meta { /* Renamed from interview-meta */
        display: flex;
        flex-wrap: wrap;
        margin-bottom: 1rem;
    }
    .meta-item {
        display: flex;
        align-items: center;
        margin-right: 1.5rem;
        margin-bottom: 0.5rem;
        color: #8898aa;
        font-size: 0.875rem;
    }
    .meta-item i {
        margin-right: 0.5rem;
        font-size: 1rem;
        color: var(--primary-color);
    }
    .status-badge {
        padding: 0.35em 0.65em;
        font-size: 0.75rem;
        font-weight: 600;
        border-radius: 50rem;
    }
    .status-pending {
        background-color: #e3f2fd;
        color: #1976d2;
    }
    .status-reviewing {
        background-color: #fff3e0;
        color: #f57c00;
    }
    .status-interview {
        background-color: #e8f5e8;
        color: #388e3c;
    }
    .status-testing { /* New status color */
        background-color: #ffe0b2; /* Light orange */
        color: #ef6c00; /* Darker orange */
    }
    .status-accepted {
        background-color: #f3e5f5;
        color: #7b1fa2;
    }
    .status-rejected {
        background-color: #ffebee;
        color: #d32f2f;
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
    .alert-info { /* Added for filter search info */
        background: linear-gradient(135deg, #e0f2f7 0%, #b3e5fc 100%);
        color: #01579b;
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
    .search-highlight {
        background-color: #fff3cd;
        padding: 0.2rem 0.4rem;
        border-radius: 0.25rem;
    }

    /* Custom Toast for consistency with new design */
    .custom-toast {
        position: fixed;
        top: 20px;
        right: 20px;
        background-color: #343a40; /* Dark background */
        color: white;
        padding: 15px 20px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        z-index: 10000;
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 500;
        animation: slideIn 0.3s ease-out;
        min-width: 280px;
    }
    .custom-toast.success {
        background-color: var(--success-color);
    }
    .custom-toast.error {
        background-color: var(--error-color);
    }
    .custom-toast.info {
        background-color: var(--info-color);
    }
    .custom-toast i {
        font-size: 1.2rem;
    }
    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    @keyframes slideOut {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(100%); opacity: 0; }
    }

    /* Loading overlay */
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
    }
    .loading-spinner div {
        font-weight: 500;
        color: var(--dark-color);
    }

    /* Status Dropdown in card */
    .status-dropdown-in-card {
        padding: 0.375rem 0.75rem; /* Bootstrap form-select-sm padding */
        font-size: 0.875rem; /* Bootstrap form-select-sm font size */
        border-radius: 0.25rem; /* Bootstrap border-radius */
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        min-width: 130px; /* Retain original min-width for dropdown */
        display: inline-block; /* To allow side-by-side with buttons */
        margin-right: 8px; /* Spacing from buttons */
    }

    .status-dropdown-in-card:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 0.2rem rgba(0, 70, 170, 0.25);
    }

    /* Status colors for dropdown in card */
    .status-dropdown-in-card.status-pending { background-color: #e3f2fd; color: #1976d2; border-color: #bbdefb; }
    .status-dropdown-in-card.status-reviewing { background-color: #fff3e0; color: #f57c00; border-color: #ffe0b2; }
    .status-dropdown-in-card.status-interview { background-color: #e8f5e8; color: #388e3c; border-color: #c8e6c9; }
    .status-dropdown-in-card.status-testing { background-color: #ffe0b2; color: #ef6c00; border-color: #ffcc80; }
    .status-dropdown-in-card.status-accepted { background-color: #f3e5f5; color: #7b1fa2; border-color: #e1bee7; }
    .status-dropdown-in-card.status-rejected { background-color: #ffebee; color: #d32f2f; border-color: #ffcdd2; }

/* Cập nhật style cho nút thành công */
.btn-success {
    background-color: var(--success-color);
    color: white;
    /* Điều chỉnh padding để nút không bị bẹp */
    padding: 0.45rem 0.9rem; /* Tăng padding dọc và ngang */
    font-size: 0.875rem; /* Đảm bảo font size phù hợp */
    border-radius: 0.25rem; /* Giữ nguyên bo tròn */
    display: inline-flex; /* Đảm bảo icon và text nằm trên cùng một hàng */
    align-items: center; /* Căn giữa icon và text theo chiều dọc */
    gap: 0.25rem; /* Khoảng cách giữa icon và text */
}

.btn-success:hover {
    background-color: #218838; /* Giữ nguyên màu hover */
}

</style>
</head>
<body>
<!-- Loading overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner">
        <i class="bi bi-arrow-clockwise" style="font-size: 24px; margin-bottom: 10px;"></i>
        <div>Đang xử lý...</div>
    </div>
</div>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand" href="HomePage">
            <span style="color: var(--primary-color);">My</span><span style="color: var(--dark-color);">Job</span>
        </a>
        <div class="d-flex">
            <a href="RecruiterDashboard" class="btn btn-outline-primary me-2">Dashboard</a>
            <a href="logout" class="btn btn-primary">Đăng xuất</a>
        </div>
    </div>
</nav>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-5 fw-bold mb-3">
                    <i class="bi bi-people-fill me-3"></i>Danh sách ứng viên
                </h1>
                <p class="lead mb-0">Quản lý và theo dõi các ứng viên đã nộp hồ sơ cho các vị trí tuyển dụng</p>
            </div>
            <div class="col-lg-4 text-lg-end">
                <!-- No specific button for this page, can add one if needed -->
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
    
    <!-- Filter Section -->
    <div class="filter-card">
        <h5 class="mb-3">
            <i class="bi bi-funnel me-2" style="color: var(--primary-color);"></i>Bộ lọc tìm kiếm
        </h5>
        <form method="GET" action="view-job-applicants" id="filterForm">
            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <label for="jobPosition" class="form-label fw-bold">Vị trí công việc</label>
                    <select id="jobPosition" name="jobPosition" class="form-select">
                        <option value="">Tất cả vị trí</option>
                        <c:forEach var="job" items="${jobsWithApplications}">
                            <option value="${job.job_position}" 
                                ${selectedJobPosition == job.job_position ? 'selected' : ''}>
                                ${job.job_position}
                            </option>
                        </c:forEach>
                        <c:if test="${empty jobsWithApplications}">
                            <c:forEach var="position" items="${jobPositions}">
                                <option value="${position.jobPosition}" 
                                    ${selectedJobPosition == position.jobPosition ? 'selected' : ''}>
                                    ${position.jobPosition}
                                </option>
                            </c:forEach>
                        </c:if>
                    </select>
                </div>
                
                <div class="col-md-4">
                    <label for="status" class="form-label fw-bold">Trạng thái</label>
                    <select id="status" name="status" class="form-select">
                        <option value="">Tất cả trạng thái</option>
                        <option value="Pending" ${selectedStatus == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                        <option value="Interview" ${selectedStatus == 'Interview' ? 'selected' : ''}>Phỏng vấn</option>
                        <option value="Testing" ${selectedStatus == 'Testing' ? 'selected' : ''}>Đang test</option>
                        <option value="Accepted" ${selectedStatus == 'Accepted' ? 'selected' : ''}> Chấp nhận</option>
                        <option value="Rejected" ${selectedStatus == 'Rejected' ? 'selected' : ''}>Từ chối</option>
                    </select>
                </div>
                
                <div class="col-md-4">
                    <label for="dateFrom" class="form-label fw-bold">Từ ngày</label>
                    <input type="date" id="dateFrom" name="dateFrom" class="form-control" 
                           value="${selectedDateFrom}">
                </div>
                
                <div class="col-md-4">
                    <label for="dateTo" class="form-label fw-bold">Đến ngày</label>
                    <input type="date" id="dateTo" name="dateTo" class="form-control" 
                           value="${selectedDateTo}">
                </div>
                
                <div class="col-md-4">
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
    
    <!-- Stats Section -->
    <c:if test="${not empty stats}">
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-number">${stats.totalApplications}</div>
                    <div class="stats-title">Tổng ứng viên</div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-number">${stats.pendingCount}</div>
                    <div class="stats-title">Chờ xử lý</div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-number">${stats.acceptedCount}</div>
                    <div class="stats-title">Đã chấp nhận</div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-number">${stats.rejectedCount}</div>
                    <div class="stats-title">Từ chối</div>
                </div>
            </div>
        </div>
    </c:if>
    
    <!-- Applicants List -->
    <div class="row">
        <c:choose>
            <c:when test="${empty applicants}">
                <div class="col-12">
                    <div class="empty-state">
                        <i class="bi bi-people"></i>
                        <h4>Chưa có ứng viên nào</h4>
                        <p>Hiện tại chưa có ứng viên nào nộp hồ sơ cho các vị trí tuyển dụng của bạn.</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="applicant" items="${applicants}">
                    <div class="col-lg-6">
                        <div class="applicant-card">
                            <div class="card-body">
                                <div class="d-flex align-items-start">
                                    <c:choose>
                                        <c:when test="${not empty applicant.imageUrl}">
                                            <img src="${applicant.imageUrl}" alt="Avatar" class="candidate-avatar me-3">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="candidate-avatar me-3">
                                                ${fn:substring(applicant.fullName, 0, 1)}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="flex-grow-1">
                                        <h5 class="candidate-name">${applicant.fullName}</h5>
                                        <p class="job-title">
                                            <strong>${applicant.jobTitle}</strong> - ${applicant.jobPosition}
                                        </p>
                                        
                                        <div class="applicant-meta">
                                            <div class="meta-item">
                                                <i class="bi bi-calendar"></i>
                                                <span>Ngày nộp: <fmt:formatDate value="${applicant.appliedAt}" pattern="dd/MM/yyyy"/></span>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="status-badge status-${fn:toLowerCase(applicant.status)}">
                                                <c:choose>
                                                    <c:when test="${applicant.status == 'Pending'}">Chờ xử lý</c:when>
                                                    <c:when test="${applicant.status == 'Interview'}">Phỏng vấn</c:when>
                                                    <c:when test="${applicant.status == 'Testing'}">Đang test</c:when>
                                                    <c:when test="${applicant.status == 'Accepted'}">Đã chấp nhận</c:when>
                                                    <c:when test="${applicant.status == 'Rejected'}">Từ chối</c:when>
                                                    <c:otherwise>${applicant.status}</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <div class="d-flex gap-2">
                                                <!-- Dropdown chọn trạng thái -->
                                                <select class="status-dropdown-in-card form-select form-select-sm status-${fn:toLowerCase(applicant.status)}" 
                                                        data-application-id="${applicant.applicationId}"
                                                        data-current-status="${applicant.status}"
                                                        id="status-${applicant.applicationId}">
                                                    <option value="Pending" ${applicant.status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                                                    <option value="Interview" ${applicant.status == 'Interview' ? 'selected' : ''}>Phỏng vấn</option>
                                                    <option value="Testing" ${applicant.status == 'Testing' ? 'selected' : ''}>Đang test</option>
                                                    <option value="Accepted" ${applicant.status == 'Accepted' ? 'selected' : ''}>Chấp nhận</option>
                                                    <option value="Rejected" ${applicant.status == 'Rejected' ? 'selected' : ''}>Từ chối</option>
                                                </select>
                                                
                                                <button class="btn btn-sm btn-outline-primary" onclick="window.location.href='CandidatePro?candidateId=${applicant.candidateId}&applicationId=${applicant.applicationId}'" title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                
                                                <!-- Nút xanh lá để chuyển trạng thái -->
                                                <button class="btn btn-success btn-sm" 
                                                        data-application-id="${applicant.applicationId}"
                                                        onclick="applySelectedStatus('${applicant.applicationId}')"
                                                        title="Áp dụng trạng thái đã chọn">
                                                    <i class="bi bi-check me-1"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage - 1}&jobPosition=${selectedJobPosition}&status=${selectedStatus}&dateFrom=${selectedDateFrom}&dateTo=${selectedDateTo}&searchName=${selectedSearchName}">Trước</a>
                    </li>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}&jobPosition=${selectedJobPosition}&status=${selectedStatus}&dateFrom=${selectedDateFrom}&dateTo=${selectedDateTo}&searchName=${selectedSearchName}">${i}</a>
                    </li>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage + 1}&jobPosition=${selectedJobPosition}&status=${selectedStatus}&dateFrom=${selectedDateFrom}&dateTo=${selectedDateTo}&searchName=${selectedSearchName}">Sau</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Show/hide loading overlay
    function showLoading() {
        document.getElementById('loadingOverlay').style.display = 'flex';
    }

    function hideLoading() {
        document.getElementById('loadingOverlay').style.display = 'none';
    }

    // Clear filters function
    function clearFilters() {
        document.getElementById('searchName').value = ''; // Thêm dòng này
        window.location.href = 'view-job-applicants';
    }

    // Add function `clearSearchName()`
    function clearSearchName() {
        document.getElementById('searchName').value = '';
        document.getElementById('filterForm').submit();
    }

    // Function to apply selected status from dropdown
    function applySelectedStatus(applicationId) {
        var dropdown = document.getElementById('status-' + applicationId);
        var currentStatus = dropdown.getAttribute('data-current-status');
        var selectedStatus = dropdown.value;
        
        if (currentStatus === selectedStatus) {
            showToast('Trạng thái đã được chọn giống với trạng thái hiện tại', 'info');
            return;
        }
        
        // Confirm the change
        var statusText = getStatusText(selectedStatus);
        if (!confirm('Bạn có chắc chắn muốn chuyển trạng thái thành "' + statusText + '"?')) {
            return;
        }
        
        // Show loading
        dropdown.disabled = true;
        var button = document.querySelector('[data-application-id="' + applicationId + '"].btn-success'); // Changed to btn-success
        if (button) button.disabled = true;
        showLoading();
        
        // Prepare form data
        var params = new URLSearchParams();
        params.append('action', 'changeStatus');
        params.append('applicationId', applicationId);
        params.append('newStatus', selectedStatus);
        
        fetch('view-job-applicants', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Accept': 'application/json'
            },
            body: params.toString()
        })
        .then(function(response) {
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.status);
            }
            return response.text();
        })
        .then(function(text) {
            try {
                var data = JSON.parse(text);
                hideLoading();
                dropdown.disabled = false;
                if (button) button.disabled = false;
                
                if (data.success) {
                    // Update the current status attribute
                    dropdown.setAttribute('data-current-status', selectedStatus);
                    
                    // Update dropdown styling
                    dropdown.className = 'status-dropdown-in-card form-select form-select-sm status-' + selectedStatus.toLowerCase(); // Updated class
                    
                    // Update status badge in the card
                    updateStatusBadge(applicationId, selectedStatus);
                    
                    showToast('Đã cập nhật trạng thái thành công!', 'success');
                } else {
                    showToast('Lỗi: ' + data.message, 'error');
                }
            } catch (e) {
                hideLoading();
                dropdown.disabled = false;
                if (button) button.disabled = false;
                showToast('Lỗi: Phản hồi từ server không hợp lệ', 'error');
            }
        })
        .catch(function(error) {
            hideLoading();
            dropdown.disabled = false;
            if (button) button.disabled = false;
            showToast('Có lỗi xảy ra: ' + error.message, 'error');
        });
    }

    // Function to update status badge in card
    function updateStatusBadge(applicationId, newStatus) {
        var card = document.querySelector('[data-application-id="' + applicationId + '"]').closest('.applicant-card');
        var statusBadge = card.querySelector('.status-badge');
        
        if (statusBadge) {
            statusBadge.className = 'status-badge status-' + newStatus.toLowerCase();
            statusBadge.textContent = getStatusText(newStatus);
        }
    }

    // Helper function to get status text in Vietnamese
    function getStatusText(status) {
        switch(status) {
            case 'Pending': return 'Chờ xử lý';
            case 'Interview': return 'Phỏng vấn';
            case 'Testing': return 'Đang test';
            case 'Accepted': return 'Đã duyệt';
            case 'Rejected': return 'Từ chối';
            default: return status;
        }
    }

    // Custom Toast function (updated for new design)
    function showToast(message, type) {
        if (typeof type === 'undefined') type = 'info';
        
        var toast = document.createElement('div');
        toast.className = 'custom-toast ' + type;
        
        var iconClass = '';
        if (type === 'success') iconClass = 'bi bi-check-circle-fill';
        else if (type === 'error') iconClass = 'bi bi-exclamation-triangle-fill';
        else iconClass = 'bi bi-info-circle-fill';
        
        toast.innerHTML = 
            '<i class="' + iconClass + '"></i>' +
            '<span>' + message + '</span>';
        
        document.body.appendChild(toast);
        
        // Remove after 3 seconds
        setTimeout(function() {
            toast.style.animation = 'slideOut 0.3s ease-out';
            setTimeout(function() { toast.remove(); }, 300);
        }, 3000);
    }

    document.addEventListener('DOMContentLoaded', function() {
        console.log('Page loaded, adding event listeners');
        

        
        // Add click event listeners to all view buttons (now btn-outline-primary)
        var viewButtons = document.querySelectorAll('.btn-outline-primary');
        for (var i = 0; i < viewButtons.length; i++) {
            var button = viewButtons[i];
            // Ensure we only attach to the 'view' button, not the dropdown's apply button
            if (button.getAttribute('onclick') && button.getAttribute('onclick').includes('viewApplicant')) {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    var applicationId = this.getAttribute('onclick').match(/'([^']+)'/)[1];
                    if (applicationId) {
                        viewApplicant(applicationId);
                    }
                });
            }
        }
    });
</script>
</body>
</html>
