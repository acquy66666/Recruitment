<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - JobHub</title>
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
                color: #525f7f;
                background-color: #f0f6ff;
            }

            .navbar-custom {
                background-color: #f0f6ff;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
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

            .dashboard-container {
                background: white;
                border-radius: 15px;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-top: -2rem;
                position: relative;
                z-index: 10;
            }

            .dashboard-header {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
                color: white;
                padding: 2rem;
                text-align: center;
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

            .section-title {
                color: var(--dark-color);
                font-weight: 700;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                justify-content: between;
            }

            .section-title i {
                margin-right: 0.5rem;
                color: var(--primary-color);
            }

            .chart-container {
                position: relative;
                min-height: 300px;
                background: #f8f9fa;
                border-radius: 10px;
                padding: 1rem;
            }

            .chart-loading {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 1rem;
            }

            .spinner {
                width: 40px;
                height: 40px;
                border: 4px solid #f3f3f3;
                border-top: 4px solid var(--primary-color);
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }
                100% {
                    transform: rotate(360deg);
                }
            }

            .list-item {
                padding: 1rem;
                border-bottom: 1px solid #f1f3f4;
                transition: all 0.3s ease;
                border-radius: 0.5rem;
            }

            .list-item:hover {
                background-color: #f8f9fa;
                transform: translateX(5px);
            }

            .list-item:last-child {
                border-bottom: none;
            }

            .notification-item {
                padding: 1rem;
                border-left: 4px solid transparent;
                margin-bottom: 0.5rem;
                border-radius: 0.5rem;
                transition: all 0.3s ease;
                background: #f8f9fa;
            }

            .notification-item:hover {
                background-color: #e9ecef;
                transform: translateX(5px);
            }

            .notification-item.unread {
                background-color: #e3f2fd;
                border-left-color: var(--info-color);
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

            .badge {
                padding: 0.5rem 1rem;
                border-radius: 50rem;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 2rem;
                color: #8898aa;
            }

            .empty-state i {
                font-size: 3rem;
                margin-bottom: 1rem;
                opacity: 0.5;
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

            .alert {
                border-radius: 10px;
                border: none;
                padding: 1rem 1.5rem;
            }

            .alert-danger {
                background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 100%);
                color: #d32f2f;
            }

            .alert-success {
                background: linear-gradient(135deg, #e8f5e8 0%, #d4edda 100%);
                color: #2e7d32;
            }

            .alert-info {
                background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
                color: #1976d2;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .page-header {
                    padding: 2rem 0;
                }

                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .stats-number {
                    font-size: 2rem;
                }
            }

            /* Dropdown Styles */
            .dropdown-menu {
                border: none;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
                border-radius: 15px;
                padding: 1rem 0;
                margin-top: 0.5rem;
            }

            .dropdown-header {
                color: var(--primary-color);
                font-weight: 700;
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                padding: 0.5rem 1.5rem;
                margin-bottom: 0.25rem;
            }

            .dropdown-item {
                padding: 0.75rem 1.5rem;
                font-weight: 500;
                transition: all 0.3s ease;
                border-radius: 0;
            }

            .dropdown-item:hover {
                background: linear-gradient(135deg, #f0f6ff 0%, #e6f0ff 100%);
                color: var(--primary-color);
                transform: translateX(5px);
            }

            .dropdown-item.text-danger:hover {
                background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 100%);
                color: #dc3545;
            }

            .dropdown-item i {
                width: 20px;
                text-align: center;
            }

            .dropdown-divider {
                margin: 0.5rem 1rem;
                border-color: #e9ecef;
            }

            .dropdown-toggle::after {
                margin-left: 0.5rem;
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
                            <i class="bi bi-speedometer2 me-3"></i>Dashboard
                        </h1>
                        <p class="lead mb-0">Chào mừng trở lại, ${recruiter.fullName}!</p>
                        <p class="text-white-50">Quản lý tuyển dụng hiệu quả với JobHub</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Main Content -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="dashboard-container">
                        <div class="dashboard-header">
                            <h3 class="mb-0">Tổng quan hoạt động</h3>
                            <p class="mb-0 mt-2">
                                <i class="bi bi-building me-1"></i>${recruiter.companyName} • 
                                <i class="bi bi-clock me-1"></i>Cập nhật: <span id="currentTime"></span>
                            </p>
                        </div>

                        <div class="p-4">
                            <!-- Alert Messages -->
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="bi bi-exclamation-triangle me-2"></i>${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Debug Info -->
                            <c:if test="${param.debug == 'true'}">
                                <div class="alert alert-info alert-dismissible fade show" role="alert">
                                    <h6><i class="bi bi-bug me-2"></i>Debug Information</h6>
                                    <strong>Recruiter ID:</strong> ${recruiter.recruiterId}<br>
                                    <strong>Recent Jobs Count:</strong> ${fn:length(recentJobs)}<br>
                                    <strong>Total Applications:</strong> ${totalApplications}<br>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Statistics Cards -->
                            <div class="stats-grid">
                                <div class="stats-card primary">
                                    <div class="stats-icon">
                                        <i class="bi bi-briefcase"></i>
                                    </div>
                                    <div class="stats-number">${totalActiveJobs != null ? totalActiveJobs : 0}</div>
                                    <div class="stats-title">Tin đang tuyển</div>
                                </div>

                                <div class="stats-card success">
                                    <div class="stats-icon">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="stats-number">${totalApplications != null ? totalApplications : 0}</div>
                                    <div class="stats-title">Tổng lượt ứng tuyển</div>
                                </div>

                                <div class="stats-card warning">
                                    <div class="stats-icon">
                                        <i class="bi bi-calendar-check"></i>
                                    </div>
                                    <div class="stats-number">${totalInterviews != null ? totalInterviews : 0}</div>
                                    <div class="stats-title">Số phỏng vấn đã đặt</div>
                                </div>
                            </div>

                            <!-- Charts Section -->
                            <div class="row mb-4">
                                <div class="col-lg-8 mb-3">
                                    <div class="section-card">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="section-title mb-0">
                                                <i class="bi bi-bar-chart"></i>Lượt ứng tuyển theo tin tuyển dụng
                                            </h5>
                                        </div>
                                        <div class="chart-container">
                                            <div class="chart-loading" id="jobChartLoading">
                                                <div class="spinner"></div>
                                                <small class="text-muted">Đang tải biểu đồ...</small>
                                            </div>
                                            <canvas id="jobApplicationChart" style="display: none;"></canvas>
                                            <div id="jobChartError" class="empty-state" style="display: none;">
                                                <i class="bi bi-exclamation-triangle"></i>
                                                <p>Không thể tải biểu đồ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-4 mb-3">
                                    <div class="section-card">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="section-title mb-0">
                                                <i class="bi bi-graph-up"></i>Xu hướng (7 ngày)
                                            </h5>
                                        </div>
                                        <div class="chart-container">
                                            <div class="chart-loading" id="dailyChartLoading">
                                                <div class="spinner"></div>
                                                <small class="text-muted">Đang tải biểu đồ...</small>
                                            </div>
                                            <canvas id="dailyApplicationChart" style="display: none; height: 250px;"></canvas>
                                            <div id="dailyChartError" class="empty-state" style="display: none;">
                                                <i class="bi bi-exclamation-triangle"></i>
                                                <p>Không thể tải biểu đồ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Lists Section -->
                            <div class="row mb-4">
                                <!-- Recent Jobs -->
                                <div class="col-lg-6 mb-3">
                                    <div class="section-card">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="section-title mb-0">
                                                <i class="bi bi-briefcase"></i>Tin tuyển dụng gần đây
                                            </h5>
                                            <a href="ManageJobPost" class="btn btn-outline-primary btn-sm">Xem tất cả</a>
                                        </div>

                                        <c:choose>
                                            <c:when test="${not empty recentJobs}">
                                                <c:forEach var="job" items="${recentJobs}">
                                                    <div class="list-item">
                                                        <div class="d-flex justify-content-between align-items-start">
                                                            <div class="flex-grow-1">
                                                                <h6 class="mb-1 fw-bold">${job.title}</h6>
                                                                <small class="text-muted">
                                                                    <i class="bi bi-calendar me-1"></i>
                                                                    <fmt:formatDate value="${job.createdDate}" pattern="dd/MM/yyyy"/>
                                                                </small>
                                                            </div>
                                                            <span class="badge bg-primary">${job.applicationCount} ứng viên</span>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="empty-state">
                                                    <i class="bi bi-briefcase"></i>
                                                    <p>Chưa có tin tuyển dụng nào</p>
                                                    <a href="JobPostingPage" class="btn btn-primary btn-sm">Tạo tin tuyển dụng đầu tiên</a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- New Applications -->
                                <div class="col-lg-6 mb-3">
                                    <div class="section-card">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="section-title mb-0">
                                                <i class="bi bi-people"></i>Ứng viên mới ứng tuyển
                                            </h5>
                                            <a href="view-job-applicants" class="btn btn-outline-primary btn-sm">Xem tất cả</a>
                                        </div>

                                        <c:choose>
                                            <c:when test="${not empty newApplications}">
                                                <c:forEach var="app" items="${newApplications}">
                                                    <div class="list-item">
                                                        <div class="d-flex justify-content-between align-items-start">
                                                            <div class="flex-grow-1">
                                                                <h6 class="mb-1 fw-bold">${app.candidateName}</h6>
                                                                <small class="text-muted">${app.jobTitle}</small>
                                                            </div>
                                                            <small class="text-muted">
                                                                <fmt:formatDate value="${app.appliedDate}" pattern="dd/MM HH:mm"/>
                                                            </small>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="empty-state">
                                                    <i class="bi bi-people"></i>
                                                    <p>Chưa có ứng viên mới</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- More Lists Section -->
                            <div class="row mb-4">
                                <!-- Upcoming Interviews -->
                                <div class="col-lg-6 mb-3">
                                    <div class="section-card">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="section-title mb-0">
                                                <i class="bi bi-calendar-check"></i>Phỏng vấn sắp tới
                                            </h5>
                                            <a href="InterviewManager" class="btn btn-outline-primary btn-sm">Xem tất cả</a>
                                        </div>

                                        <c:choose>
                                            <c:when test="${not empty upcomingInterviews}">
                                                <c:forEach var="interview" items="${upcomingInterviews}">
                                                    <div class="list-item">
                                                        <div class="d-flex justify-content-between align-items-start">
                                                            <div class="flex-grow-1">
                                                                <h6 class="mb-1 fw-bold">${interview.candidateName}</h6>
                                                                <small class="text-muted">${interview.jobTitle}</small>
                                                                <div class="mt-1">
                                                                    <span class="badge bg-info">${interview.interviewType}</span>
                                                                </div>
                                                            </div>
                                                            <small class="text-muted">
                                                                <fmt:formatDate value="${interview.interviewTime}" pattern="dd/MM HH:mm"/>
                                                            </small>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="empty-state">
                                                    <i class="bi bi-calendar-check"></i>
                                                    <p>Không có phỏng vấn sắp tới</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Recent Transactions -->
                                <div class="col-lg-6 mb-3">
                                    <div class="section-card">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="section-title mb-0">
                                                <i class="bi bi-credit-card"></i>Lịch sử giao dịch
                                            </h5>
                                            <a href="buyServices" class="btn btn-outline-primary btn-sm">Xem tất cả</a>
                                        </div>

                                        <c:choose>
                                            <c:when test="${not empty transactions}">
                                                <div class="table-responsive">
                                                    <table class="table table-sm">
                                                        <thead>
                                                            <tr>
                                                                <th>Dịch vụ</th>
                                                                <th>Giá</th>
                                                                <th>Ngày</th>
                                                                <th>Trạng thái</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="transaction" items="${transactions}">
                                                                <tr>
                                                                    <td>${transaction.serviceName}</td>
                                                                    <td>
                                                                        <fmt:formatNumber value="${transaction.amount}" type="currency" currencySymbol="₫"/>
                                                                    </td>
                                                                    <td>
                                                                        <fmt:formatDate value="${transaction.paymentDate}" pattern="dd/MM/yyyy"/>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${transaction.status == 'COMPLETED'}">
                                                                                <span class="badge bg-success">Thành công</span>
                                                                            </c:when>
                                                                            <c:when test="${transaction.status == 'PENDING'}">
                                                                                <span class="badge bg-warning">Đang xử lý</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="badge bg-danger">Thất bại</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="empty-state">
                                                    <i class="bi bi-credit-card"></i>
                                                    <p>Chưa có giao dịch nào</p>
                                                    <a href="buyServices" class="btn btn-primary btn-sm">Mua gói dịch vụ</a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- Notifications -->
                            <div class="section-card">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5 class="section-title mb-0">
                                        <i class="bi bi-bell"></i>Thông báo
                                        <c:if test="${totalNotifications > 0}">
                                            <span class="badge bg-danger ms-2">${totalNotifications}</span>
                                        </c:if>
                                    </h5>
                                    <a href="notifications" class="btn btn-outline-primary btn-sm">Xem tất cả</a>
                                </div>

                                <c:choose>
                                    <c:when test="${not empty notifications}">
                                        <c:forEach var="notification" items="${notifications}">
                                            <div class="notification-item ${notification.isRead ? '' : 'unread'}">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div class="flex-grow-1">
                                                        <h6 class="mb-1 fw-bold">${notification.title}</h6>
                                                        <p class="mb-1 text-muted">${notification.message}</p>
                                                        <small class="text-muted">
                                                            <i class="bi bi-clock me-1"></i>
                                                            <fmt:formatDate value="${notification.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                        </small>
                                                    </div>
                                                    <c:if test="${!notification.isRead}">
                                                        <span class="badge bg-primary">Mới</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="empty-state">
                                            <i class="bi bi-bell"></i>
                                            <p>Không có thông báo mới</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/chart.js@4.4.0/dist/chart.umd.js"></script>
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

            // Chart error handling
            function showChartError(chartId, errorId) {
                const loadingElement = document.getElementById(chartId.replace('ApplicationChart', 'Chart') + 'Loading');
                const chartElement = document.getElementById(chartId);
                const errorElement = document.getElementById(errorId);

                if (loadingElement)
                    loadingElement.style.display = 'none';
                if (chartElement)
                    chartElement.style.display = 'none';
                if (errorElement)
                    errorElement.style.display = 'block';
            }

            function showChart(chartId) {
                const loadingElement = document.getElementById(chartId.replace('ApplicationChart', 'Chart') + 'Loading');
                const chartElement = document.getElementById(chartId);

                if (loadingElement)
                    loadingElement.style.display = 'none';
                if (chartElement)
                    chartElement.style.display = 'block';
            }

            // Job Application Chart
            function loadJobChart() {
                const jobLabels = [
            <c:forEach var="job" items="${jobStats}" varStatus="status">
                '${job.jobTitle}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
                ];
                const jobData = [
            <c:forEach var="job" items="${jobStats}" varStatus="status">
                ${job.applicationCount}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
                ];

                try {
                    const jobCtx = document.getElementById('jobApplicationChart');
                    if (!jobCtx) {
                        showChartError('jobApplicationChart', 'jobChartError');
                        return;
                    }

                    if (jobLabels.length === 0 || (jobLabels.length === 1 && jobLabels[0] === '')) {
                        const loadingDiv = document.getElementById('jobChartLoading');
                        if (loadingDiv) {
                            loadingDiv.innerHTML = '<div class="empty-state"><i class="bi bi-bar-chart"></i><p>Chưa có dữ liệu biểu đồ</p></div>';
                        }
                        return;
                    }

                    if (typeof Chart === 'undefined') {
                        showChartError('jobApplicationChart', 'jobChartError');
                        return;
                    }

                    new Chart(jobCtx.getContext('2d'), {
                        type: 'bar',
                        data: {
                            labels: jobLabels,
                            datasets: [{
                                    label: 'Số lượt ứng tuyển',
                                    data: jobData,
                                    backgroundColor: 'rgba(0, 70, 170, 0.8)',
                                    borderColor: 'rgba(0, 70, 170, 1)',
                                    borderWidth: 1,
                                    borderRadius: 8,
                                }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {display: false}
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {stepSize: 1}
                                }
                            }
                        }
                    });

                    showChart('jobApplicationChart');
                } catch (error) {
                    console.error('Error loading job chart:', error);
                    showChartError('jobApplicationChart', 'jobChartError');
                }
            }

            // Daily Application Chart
            function loadDailyChart() {
                const dailyLabels = [
            <c:forEach var="daily" items="${dailyStats}" varStatus="status">
                '<fmt:formatDate value="${daily.date}" pattern="dd/MM"/>'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
                ];
                const dailyData = [
            <c:forEach var="daily" items="${dailyStats}" varStatus="status">
                ${daily.count}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
                ];

                try {
                    const dailyCtx = document.getElementById('dailyApplicationChart');
                    if (!dailyCtx) {
                        showChartError('dailyApplicationChart', 'dailyChartError');
                        return;
                    }

                    if (dailyLabels.length === 0 || (dailyLabels.length === 1 && dailyLabels[0] === '')) {
                        const loadingDiv = document.getElementById('dailyChartLoading');
                        if (loadingDiv) {
                            loadingDiv.innerHTML = '<div class="empty-state"><i class="bi bi-graph-up"></i><p>Chưa có dữ liệu biểu đồ</p></div>';
                        }
                        return;
                    }

                    if (typeof Chart === 'undefined') {
                        showChartError('dailyApplicationChart', 'dailyChartError');
                        return;
                    }

                    new Chart(dailyCtx.getContext('2d'), {
                        type: 'line',
                        data: {
                            labels: dailyLabels,
                            datasets: [{
                                    label: 'Ứng tuyển theo ngày',
                                    data: dailyData,
                                    borderColor: 'rgba(45, 206, 137, 1)',
                                    backgroundColor: 'rgba(45, 206, 137, 0.1)',
                                    borderWidth: 3,
                                    fill: true,
                                    tension: 0.4,
                                }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {display: false}
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {stepSize: 1}
                                }
                            }
                        }
                    });

                    showChart('dailyApplicationChart');
                } catch (error) {
                    console.error('Error loading daily chart:', error);
                    showChartError('dailyApplicationChart', 'dailyChartError');
                }
            }

            // Initialize charts
            document.addEventListener('DOMContentLoaded', function () {
                setTimeout(() => {
                    loadJobChart();
                    loadDailyChart();
                }, 50);
            });
        </script>
    </body>
</html>