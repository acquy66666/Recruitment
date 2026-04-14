<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Phỏng vấn - JobHub</title>
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
                vertical-align: middle;
            }

            .table tbody td {
                padding: 1rem 0.75rem;
                vertical-align: middle;
                border-bottom: 1px solid #f1f3f4;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
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
                flex-shrink: 0;
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

            .status-badge {
                padding: 0.35em 0.65em;
                font-size: 0.75rem;
                font-weight: 600;
                border-radius: 50rem;
                white-space: nowrap;
            }

            .status-badge.status-completed {
                background-color: #e8f5e8;
                color: #2e7d32;
                border: 1px solid #c8e6c9;
            }

            .status-badge.status-upcoming {
                background-color: #e3f2fd;
                color: #1565c0;
                border: 1px solid #bbdefb;
            }

            .status-badge.status-today {
                background-color: #fff3e0;
                color: #ef6c00;
                border: 1px solid #ffcc02;
                animation: pulse 2s infinite;
            }

            @keyframes pulse {
                0% {
                    box-shadow: 0 0 0 0 rgba(239, 108, 0, 0.4);
                }
                70% {
                    box-shadow: 0 0 0 10px rgba(239, 108, 0, 0);
                }
                100% {
                    box-shadow: 0 0 0 0 rgba(239, 108, 0, 0);
                }
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

            /* Modal styles */
            .candidate-info-card {
                border: 1px solid #e9ecef;
            }

            .modal-loading-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.8);
                z-index: 1060;
            }

            .modal-content {
                border-radius: 15px;
                border: none;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            }

            .modal-header {
                background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
                color: white;
                border-radius: 15px 15px 0 0;
                border-bottom: none;
            }

            .modal-header .btn-close {
                filter: brightness(0) invert(1);
            }

            .form-label.fw-bold {
                color: var(--dark-color);
                margin-bottom: 0.5rem;
            }

            /* Toast styles */
            .toast-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1200;
            }

            /* Responsive table */
            @media (max-width: 768px) {
                .table-responsive {
                    font-size: 0.875rem;
                }

                .candidate-avatar {
                    width: 2rem;
                    height: 2rem;
                    font-size: 0.8rem;
                }

                .action-buttons {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
       <%@ include file="RecruiterNavbar.jsp" %>

        <!-- Page Header -->
        <section class="page-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <h1 class="display-5 fw-bold mb-3">
                            <i class="bi bi-calendar-check me-3"></i>Quản lý Phỏng vấn
                        </h1>
                        <p class="lead mb-0">Tạo và lên lịch phỏng vấn cho các ứng viên tiềm năng</p>
                    </div>
                    <div class="col-lg-4 text-lg-end">
                        <a href="CreateInterview" class="btn btn-light btn-lg">
                            <i class="bi bi-plus-circle me-2"></i>Tạo phỏng vấn mới
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Main Content -->
        <div class="container mt-4">
            <!-- Session Alert Messages -->
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>${sessionScope.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="success" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <!-- Parameter Alert Messages -->
            <c:if test="${param.success != null}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>${param.success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${param.error != null}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Search Results Info -->
            <c:if test="${not empty param.search}">
                <div class="alert alert-info">
                    <i class="bi bi-search me-2"></i>
                    Kết quả tìm kiếm cho: "<strong>${param.search}</strong>"
                    - Tìm thấy ${totalCount != null ? totalCount : 0} kết quả
                </div>
            </c:if>

            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="stats-number">${totalInterviews != null ? totalInterviews : 0}</div>
                        <div class="stats-title">Tổng phỏng vấn</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="stats-number">${todayInterviews != null ? todayInterviews : 0}</div>
                        <div class="stats-title">Hôm nay</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="stats-number">${upcomingInterviews != null ? upcomingInterviews : 0}</div>
                        <div class="stats-title">Sắp tới</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="stats-number">${completedInterviews != null ? completedInterviews : 0}</div>
                        <div class="stats-title">Đã hoàn thành</div>
                    </div>
                </div>
            </div>

            <!-- Filter Section -->
            <div class="filter-card">
                <h5 class="mb-3">
                    <i class="bi bi-funnel me-2" style="color: var(--primary-color);"></i>Bộ lọc và tìm kiếm
                </h5>
                <form method="get" action="InterviewManager" id="filterForm">
                    <div class="row g-3 mb-3">
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Vị trí công việc</label>
                            <select name="jobPosition" class="form-select">
                                <option value="">Tất cả vị trí</option>
                                <c:forEach var="job" items="${jobsWithApplications}">
                                    <option value="${job.job_position}" ${param.jobPosition == job.job_position ? 'selected' : ''}>
                                        ${job.job_position}
                                    </option>
                                </c:forEach>
                                <c:if test="${empty jobsWithApplications}">
                                    <c:forEach var="position" items="${jobPositions}">
                                        <option value="${position}" ${param.jobPosition == position ? 'selected' : ''}>
                                            ${position}
                                        </option>
                                    </c:forEach>
                                </c:if>
                            </select>
                        </div>

                        <div class="col-md-2">
                            <label class="form-label fw-bold">Từ ngày</label>
                            <input type="date" name="dateFrom" value="${param.dateFrom}" class="form-control">
                        </div>

                        <div class="col-md-2">
                            <label class="form-label fw-bold">Đến ngày</label>
                            <input type="date" name="dateTo" value="${param.dateTo}" class="form-control">
                        </div>

                        <div class="col-md-3">
                            <label class="form-label fw-bold">Tìm kiếm theo tên</label>
                            <div class="input-group">
                                <input type="text" name="search" value="${param.search}" class="form-control"
                                       placeholder="Nhập tên ứng viên" maxlength="100">
                                <button class="btn btn-outline-secondary" type="button" onclick="clearSearch()">
                                    <i class="bi bi-x"></i>
                                </button>
                            </div>
                        </div>

                        <div class="col-md-2 d-flex align-items-end">
                            <div class="d-flex flex-column gap-2 w-100">
                                <button class="btn btn-primary" type="submit">
                                    <i class="bi bi-search me-1"></i>Tìm kiếm
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12 text-end">
                            <small class="text-muted">
                                Hiển thị ${interviews != null ? interviews.size() : 0} / ${totalCount != null ? totalCount : 0} kết quả
                            </small>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Interviews Table -->
            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty interviews}">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Ứng viên</th>
                                        <th scope="col">Vị trí</th>
                                        <th scope="col">Thời gian phỏng vấn</th>
                                        <th scope="col">Loại hình</th>
                                        <th scope="col">Địa điểm</th>
                                        <th scope="col">Trạng thái</th>
                                        <th scope="col" class="text-center">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="interview" items="${interviews}">
                                        <tr data-interview-id="${interview.interviewId}"
                                            data-candidate-name="<c:out value='${interview.fullName}'/>"
                                            data-job-position="<c:out value='${interview.jobPosition}'/>"
                                            data-image-url="<c:out value='${interview.imageUrl}'/>"
                                            data-interview-date="<fmt:formatDate value='${interview.interviewTime}' pattern='yyyy-MM-dd'/>"
                                            data-interview-time="<fmt:formatDate value='${interview.interviewTime}' pattern='HH:mm'/>"
                                            data-interview-type="<c:out value='${interview.interviewType}'/>"
                                            data-location="<c:out value='${interview.location}'/>"
                                            data-interviewers="<c:out value='${interview.interviewers}'/>"
                                            data-description="<c:out value='${interview.description}'/>">

                                            <td>
                                                <div class="candidate-info">
                                                    <c:choose>
                                                        <c:when test="${not empty interview.imageUrl}">
                                                            <img src="${interview.imageUrl}" alt="Avatar" class="candidate-avatar">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="candidate-avatar">
                                                                ${interview.fullName.substring(0,1).toUpperCase()}
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div class="candidate-details">
                                                        <h6>${interview.fullName}</h6>
                                                        <small>${interview.email}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="fw-medium">${interview.jobPosition}</span>
                                                <br>
                                                <small class="text-muted">${interview.jobTitle}</small>
                                            </td>
                                            <td>
                                                <c:if test="${interview.interviewTime != null}">
                                                    <span class="fw-medium">
                                                        <i class="bi bi-calendar me-1"></i>
                                                        <fmt:formatDate value="${interview.interviewTime}" pattern="dd/MM/yyyy"/>
                                                    </span>
                                                    <br>
                                                    <small class="text-muted">
                                                        <i class="bi bi-clock me-1"></i>
                                                        <fmt:formatDate value="${interview.interviewTime}" pattern="HH:mm"/>
                                                    </small>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${interview.interviewType == 'VIDEO'}">
                                                        <span class="badge bg-info">
                                                            <i class="bi bi-camera-video me-1"></i>Online
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${interview.interviewType == 'ONSITE'}">
                                                        <span class="badge bg-success">
                                                            <i class="bi bi-geo-alt me-1"></i>Trực tiếp
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${interview.interviewType == 'PHONE'}">
                                                        <span class="badge bg-secondary">
                                                            <i class="bi bi-geo-alt me-1"></i>Điện thoại
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${interview.interviewType}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${interview.interviewType == 'VIDEO'}">
                                                        <small class="text-info">
                                                            <i class="bi bi-link-45deg me-1"></i>Phòng online
                                                        </small>
                                                    </c:when>
                                                    <c:when test="${interview.interviewType == 'PHONE'}">
                                                        <small class="">
                                                            <i class="bi bi-phone me-1"></i>${interview.phone}
                                                        </small>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <small class="text-muted">
                                                            <i class="bi bi-geo-alt me-1"></i>
                                                            ${interview.location != null ? interview.location : 'Chưa xác định'}
                                                        </small>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <jsp:useBean id="currentDate" class="java.util.Date"/>
                                                <c:set var="now" value="${currentDate}"/>
                                                <c:choose>
                                                    <c:when test="${interview.interviewTime lt now}">
                                                        <span class="status-badge status-completed">
                                                            <i class="bi bi-check-circle me-1"></i>Đã qua
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-upcoming">
                                                            <i class="bi bi-clock me-1"></i>Sắp tới
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <!-- Show join button only for video interviews -->
                                                    <c:if test="${interview.interviewType == 'VIDEO'}">
                                                        <a href="VideoInterview?interviewId=${interview.interviewId}"
                                                           class="btn btn-sm btn-success" title="Tham gia phỏng vấn"
                                                           target="_blank">
                                                            <i class="bi bi-camera-video me-1"></i>
                                                        </a>
                                                    </c:if>

                                                    <!-- Edit interview button -->
                                                    <button type="button" class="btn btn-sm btn-warning edit-interview-btn"
                                                            title="Chỉnh sửa phỏng vấn">
                                                        <i class="bi bi-pencil me-1"></i>
                                                    </button>

                                                    <!-- Delete interview button - using form -->
                                                    <form method="get" action="DeleteInterview" style="display: inline;" 
                                                          onsubmit="return confirmDelete('${interview.fullName}', '<fmt:formatDate value='${interview.interviewTime}' pattern='dd/MM/yyyy HH:mm'/>')">
                                                        <input type="hidden" name="interviewId" value="${interview.interviewId}">
                                                        <input type="hidden" name="candidateName" value="<c:out value='${interview.fullName}'/>">
                                                        <input type="hidden" name="interviewDate" value="<fmt:formatDate value='${interview.interviewTime}' pattern='dd/MM/yyyy HH:mm'/>">
                                                        <button type="submit" class="btn btn-sm btn-danger" title="Xóa phỏng vấn">
                                                            <i class="bi bi-trash me-1"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <c:choose>
                                <c:when test="${not empty param.search or not empty param.jobPosition or not empty param.dateFrom or not empty param.dateTo}">
                                    <i class="bi bi-search"></i>
                                    <h4>Không tìm thấy kết quả</h4>
                                    <p>Không có cuộc phỏng vấn nào phù hợp với tiêu chí tìm kiếm của bạn.</p>
                                    <a href="InterviewManager" class="btn btn-primary">
                                        <i class="bi bi-arrow-clockwise me-2"></i>Xóa bộ lọc
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-calendar-x"></i>
                                    <h4>Chưa có phỏng vấn nào</h4>
                                    <p>Bạn chưa lên lịch phỏng vấn nào. Hãy tạo lịch phỏng vấn cho các ứng viên tiềm năng.</p>
                                    <a href="CreateInterview" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Tạo phỏng vấn mới
                                    </a>
                                </c:otherwise>
                            </c:choose>
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
                                <a class="page-link" href="?page=${currentPage - 1}&search=${param.search}&jobPosition=${param.jobPosition}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}">Trước</a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&search=${param.search}&jobPosition=${param.jobPosition}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage + 1}&search=${param.search}&jobPosition=${param.jobPosition}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}">Sau</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </div>

        <!-- Edit Interview Modal -->
        <div class="modal fade" id="editInterviewModal" tabindex="-1" aria-labelledby="editInterviewModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editInterviewModalLabel">
                            <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa thông tin phỏng vấn
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="editInterviewForm" method="POST" action="InterviewManager">
                        <div class="modal-body">
                            <input type="hidden" id="editInterviewId" name="interviewId">
                            <input type="hidden" name="action" value="editInterview">

                            <!-- Candidate Info (Read-only) -->
                            <div class="row mb-3">
                                <div class="col-12">
                                    <div class="candidate-info-card p-3 bg-light rounded">
                                        <div class="d-flex align-items-center">
                                            <img id="editCandidateAvatar" src="" alt="Avatar" class="candidate-avatar me-3" style="display: none;">
                                            <div id="editCandidateAvatarText" class="candidate-avatar me-3"></div>
                                            <div>
                                                <h6 id="editCandidateName" class="mb-1"></h6>
                                                <small id="editJobPosition" class="text-muted"></small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Interview Details -->
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="editInterviewDate" class="form-label fw-bold">
                                        <i class="bi bi-calendar me-1"></i>Ngày phỏng vấn *
                                    </label>
                                    <input type="date" class="form-control" id="editInterviewDate" name="interviewDate" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="editInterviewTime" class="form-label fw-bold">
                                        <i class="bi bi-clock me-1"></i>Giờ phỏng vấn *
                                    </label>
                                    <input type="time" class="form-control" id="editInterviewTime" name="interviewTime" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="editInterviewType" class="form-label fw-bold">
                                        <i class="bi bi-camera-video me-1"></i>Hình thức phỏng vấn *
                                    </label>
                                    <select class="form-select" id="editInterviewType" name="interviewType" required>
                                        <option value="">Chọn hình thức</option>
                                        <option value="VIDEO">Phỏng vấn online</option>
                                        <option value="ONSITE">Phỏng vấn trực tiếp</option>
                                        <option value="PHONE">Phỏng vấn qua điện thoại</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="editInterviewers" class="form-label fw-bold">
                                        <i class="bi bi-people me-1"></i>Người phỏng vấn
                                    </label>
                                    <input type="text" class="form-control" id="editInterviewers" name="interviewers" 
                                           placeholder="Nhập tên người phỏng vấn (phân cách bằng dấu phẩy)">
                                </div>
                            </div>

                            <div class="mb-3" id="editLocationGroup">
                                <label for="editLocation" class="form-label fw-bold">
                                    <i class="bi bi-geo-alt me-1"></i>Địa điểm phỏng vấn
                                </label>
                                <input type="text" class="form-control" id="editLocation" name="location" 
                                       placeholder="Nhập địa điểm phỏng vấn">
                                <div class="form-text">Bắt buộc đối với phỏng vấn trực tiếp</div>
                            </div>

                            <div class="mb-3">
                                <label for="editDescription" class="form-label fw-bold">
                                    <i class="bi bi-card-text me-1"></i>Ghi chú thêm
                                </label>
                                <textarea class="form-control" id="editDescription" name="description" rows="3"
                                          placeholder="Thêm ghi chú hoặc hướng dẫn cho buổi phỏng vấn"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                <i class="bi bi-x-circle me-1"></i>Hủy
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle me-1"></i>Cập nhật phỏng vấn
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>



        <!-- Loading overlay for modal -->
        <div class="modal-loading-overlay" id="modalLoadingOverlay" style="display: none;">
            <div class="d-flex justify-content-center align-items-center h-100">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>

                                                              function clearSearch() {
                                                                  document.querySelector('input[name="search"]').value = '';
                                                                  document.getElementById('filterForm').submit();
                                                              }


                                                              function confirmDelete(candidateName, interviewDate) {
                                                                  const message = `Bạn có chắc chắn muốn xóa cuộc phỏng vấn?\nHành động này không thể hoàn tác!`;
                                                                  return confirm(message);
                                                              }


                                                              document.addEventListener('DOMContentLoaded', function () {
                                                                  // Add click event to all edit buttons
                                                                  document.querySelectorAll('.edit-interview-btn').forEach(function (button) {
                                                                      button.addEventListener('click', function () {
                                                                          const row = this.closest('tr');
                                                                          openEditModalFromRow(row);
                                                                      });
                                                                  });

                                                                  // Auto-submit form when filters change (optional)
                                                                  document.querySelectorAll('select[name="jobPosition"], input[name="dateFrom"], input[name="dateTo"]').forEach(function (element) {
                                                                      element.addEventListener('change', function () {
                                                                          // Optional: auto-submit when dropdown or date changes
                                                                          // document.getElementById('filterForm').submit();
                                                                      });
                                                                  });

                                                                  // Enter key support for search
                                                                  const searchInput = document.querySelector('input[name="search"]');
                                                                  if (searchInput) {
                                                                      searchInput.addEventListener('keypress', function (e) {
                                                                          if (e.key === 'Enter') {
                                                                              document.getElementById('filterForm').submit();
                                                                          }
                                                                      });
                                                                  }

                                                                  // Date validation
                                                                  const dateFromInput = document.querySelector('input[name="dateFrom"]');
                                                                  const dateToInput = document.querySelector('input[name="dateTo"]');

                                                                  if (dateFromInput) {
                                                                      dateFromInput.addEventListener('change', function () {
                                                                          const dateFrom = this.value;
                                                                          const dateTo = dateToInput ? dateToInput.value : '';

                                                                          if (dateFrom && dateTo && dateFrom > dateTo) {
                                                                              alert('Ngày bắt đầu không thể lớn hơn ngày kết thúc');
                                                                              this.value = '';
                                                                          }
                                                                      });
                                                                  }

                                                                  if (dateToInput) {
                                                                      dateToInput.addEventListener('change', function () {
                                                                          const dateFrom = dateFromInput ? dateFromInput.value : '';
                                                                          const dateTo = this.value;

                                                                          if (dateFrom && dateTo && dateFrom > dateTo) {
                                                                              alert('Ngày kết thúc không thể nhỏ hơn ngày bắt đầu');
                                                                              this.value = '';
                                                                          }
                                                                      });
                                                                  }

                                                                  // Interview type change handler
                                                                  const editInterviewType = document.getElementById('editInterviewType');
                                                                  if (editInterviewType) {
                                                                      editInterviewType.addEventListener('change', toggleLocationField);
                                                                  }

                                                                  // Form validation
                                                                  const editForm = document.getElementById('editInterviewForm');
                                                                  if (editForm) {
                                                                      editForm.addEventListener('submit', function (e) {
                                                                          const interviewDate = document.getElementById('editInterviewDate').value;
                                                                          const interviewTime = document.getElementById('editInterviewTime').value;
                                                                          const interviewType = document.getElementById('editInterviewType').value;
                                                                          const location = document.getElementById('editLocation').value;

                                                                          // Validate required fields
                                                                          if (!interviewDate || !interviewTime || !interviewType) {
                                                                              e.preventDefault();
                                                                              alert('Vui lòng điền đầy đủ thông tin bắt buộc');
                                                                              return;
                                                                          }

                                                                          // Validate location for ONSITE interviews
                                                                          if (interviewType === 'ONSITE' && !location.trim()) {
                                                                              e.preventDefault();
                                                                              alert('Vui lòng nhập địa điểm cho phỏng vấn trực tiếp');
                                                                              return;
                                                                          }

                                                                          // Validate interview date (not in the past)
                                                                          const selectedDate = new Date(interviewDate + 'T' + interviewTime);
                                                                          const now = new Date();

                                                                          if (selectedDate < now) {
                                                                              const confirmPast = confirm('Thời gian phỏng vấn đã qua. Bạn có chắc chắn muốn tiếp tục?');
                                                                              if (!confirmPast) {
                                                                                  e.preventDefault();
                                                                                  return;
                                                                              }
                                                                          }

                                                                          // Show loading
                                                                          showModalLoading(true);
                                                                      });
                                                                  }

                                                                  showModalLoading(false);
                                                              });

// Function to open edit modal using data from table row
                                                              function openEditModalFromRow(row) {
                                                                  const interviewId = row.getAttribute('data-interview-id');
                                                                  const candidateName = row.getAttribute('data-candidate-name');
                                                                  const jobPosition = row.getAttribute('data-job-position');
                                                                  const imageUrl = row.getAttribute('data-image-url');
                                                                  const interviewDate = row.getAttribute('data-interview-date');
                                                                  const interviewTime = row.getAttribute('data-interview-time');
                                                                  const interviewType = row.getAttribute('data-interview-type');
                                                                  const location = row.getAttribute('data-location');
                                                                  const interviewers = row.getAttribute('data-interviewers');
                                                                  const description = row.getAttribute('data-description');

                                                                  console.log('Opening edit modal for interview:', interviewId);

                                                                  // Set hidden fields
                                                                  document.getElementById('editInterviewId').value = interviewId;

                                                                  // Set candidate info
                                                                  document.getElementById('editCandidateName').textContent = candidateName || 'N/A';
                                                                  document.getElementById('editJobPosition').textContent = jobPosition || 'N/A';

                                                                  // Set avatar
                                                                  const avatarImg = document.getElementById('editCandidateAvatar');
                                                                  const avatarText = document.getElementById('editCandidateAvatarText');

                                                                  if (imageUrl && imageUrl !== '' && imageUrl !== 'null') {
                                                                      avatarImg.src = imageUrl;
                                                                      avatarImg.style.display = 'block';
                                                                      avatarText.style.display = 'none';
                                                                  } else {
                                                                      avatarImg.style.display = 'none';
                                                                      avatarText.style.display = 'flex';
                                                                      avatarText.textContent = candidateName ? candidateName.charAt(0).toUpperCase() : '?';
                                                                  }

                                                                  // Set form fields
                                                                  document.getElementById('editInterviewDate').value = interviewDate || '';
                                                                  document.getElementById('editInterviewTime').value = interviewTime || '';
                                                                  document.getElementById('editInterviewType').value = interviewType || '';
                                                                  document.getElementById('editLocation').value = location || '';
                                                                  document.getElementById('editInterviewers').value = interviewers || '';
                                                                  document.getElementById('editDescription').value = description || '';

                                                                  // Handle location field visibility
                                                                  toggleLocationField();

                                                                  // Show modal
                                                                  const modal = new bootstrap.Modal(document.getElementById('editInterviewModal'));
                                                                  modal.show();
                                                              }

// Toggle location field based on interview type
                                                              function toggleLocationField() {
                                                                  const interviewType = document.getElementById('editInterviewType').value;
                                                                  const locationGroup = document.getElementById('editLocationGroup');
                                                                  const locationInput = document.getElementById('editLocation');

                                                                  if (interviewType === 'ONSITE') {
                                                                      locationGroup.style.display = 'block';
                                                                      locationInput.required = true;
                                                                      locationInput.placeholder = 'Nhập địa điểm phỏng vấn (bắt buộc)';
                                                                  } else if (interviewType === 'VIDEO') {
                                                                      locationGroup.style.display = 'none';
                                                                      locationInput.required = false;
                                                                      locationInput.value = '';
                                                                  } else {
                                                                      locationGroup.style.display = 'block';
                                                                      locationInput.required = false;
                                                                      locationInput.placeholder = 'Nhập địa điểm phỏng vấn';
                                                                  }
                                                              }

// Show/hide modal loading
                                                              function showModalLoading(show) {
                                                                  const overlay = document.getElementById('modalLoadingOverlay');
                                                                  if (overlay) {
                                                                      if (show) {
                                                                          overlay.style.display = 'block';
                                                                      } else {
                                                                          overlay.style.display = 'none';
                                                                      }
                                                                  }
                                                              }
        </script>
    </body>
</html>