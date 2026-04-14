<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách tin tuyển dụng | JobHub</title>
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
            }

            .table tbody td {
                padding: 1rem 0.75rem;
                vertical-align: middle;
                border-bottom: 1px solid #f1f3f4;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
            }

            .job-title {
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 0.25rem;
                font-size: 0.95rem;
            }

            .company-name {
                color: #8898aa;
                font-size: 0.8rem;
                margin: 0;
            }

            .status-badge {
                padding: 0.25rem 0.75rem;
                font-size: 0.75rem;
                font-weight: 600;
                border-radius: 50rem;
                white-space: nowrap;
            }

            .status-active {
                background-color: #e8f5e8;
                color: #388e3c;
            }

            .status-inactive {
                background-color: #ffebee;
                color: #d32f2f;
            }

            .status-expired {
                background-color: #f5f5f5;
                color: #666;
            }

            .application-count {
                display: flex;
                flex-direction: column;
                gap: 0.25rem;
            }

            .count-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.8rem;
            }

            .count-badge {
                background-color: #f8f9fa;
                color: #495057;
                padding: 0.15rem 0.5rem;
                border-radius: 12px;
                font-weight: 600;
                min-width: 24px;
                text-align: center;
            }

            .count-badge.total {
                background-color: #e3f2fd;
                color: #1976d2;
            }
            .count-badge.pending {
                background-color: #fff3e0;
                color: #f57c00;
            }
            .count-badge.accepted {
                background-color: #e8f5e8;
                color: #388e3c;
            }
            .count-badge.rejected {
                background-color: #ffebee;
                color: #d32f2f;
            }

            .action-buttons {
                display: flex;
                gap: 0.5rem;
                flex-wrap: wrap;
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

            /* Responsive table */
            @media (max-width: 768px) {
                .table-responsive {
                    font-size: 0.875rem;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .application-count {
                    gap: 0.15rem;
                }

                .count-item {
                    font-size: 0.75rem;
                }
            }

            /* Custom scrollbar for table */
            .table-responsive::-webkit-scrollbar {
                height: 8px;
            }

            .table-responsive::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 4px;
            }

            .table-responsive::-webkit-scrollbar-thumb {
                background: #c1c1c1;
                border-radius: 4px;
            }

            .table-responsive::-webkit-scrollbar-thumb:hover {
                background: #a8a8a8;
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
                            <i class="bi bi-briefcase-fill me-3"></i>Tin tuyển dụng có ứng viên
                        </h1>
                        <p class="lead mb-0">Quản lý các tin tuyển dụng và theo dõi ứng viên đã nộp hồ sơ</p>
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

            <!-- Filter Section -->
            <div class="filter-card">
                <h5 class="mb-3">
                    <i class="bi bi-funnel me-2" style="color: var(--primary-color);"></i>Bộ lọc tìm kiếm
                </h5>
                <form method="GET" action="ApplicationManagement" id="filterForm">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="jobTitle" class="form-label fw-bold">Tiêu đề công việc</label>
                            <input type="text" id="jobTitle" name="jobTitle" class="form-control"
                                   placeholder="Nhập tiêu đề công việc" value="${selectedJobTitle}">
                        </div>


                        <div class="col-md-6">
                            <label for="minApplications" class="form-label fw-bold">Số ứng viên tối thiểu</label>
                            <input type="number" id="minApplications" name="minApplications" class="form-control"
                                   placeholder="0" value="${selectedMinApplications}" min="0">
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

            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="stats-card">
                        <div class="stats-number">${totalJobs}</div>
                        <div class="stats-title">Tổng tin tuyển dụng</div>
                    </div>
                </div>


                <div class="col-md-6">
                    <div class="stats-card">
                        <div class="stats-number">${totalApplications}</div>
                        <div class="stats-title">Tổng ứng viên</div>
                    </div>
                </div>

                
            </div>


            <!-- Job Posts Table -->
            <div class="table-container">
                <c:choose>
                    <c:when test="${empty jobPosts}">
                        <div class="empty-state">
                            <i class="bi bi-briefcase"></i>
                            <h4>Chưa có tin tuyển dụng nào</h4>
                            <p>Hiện tại chưa có tin tuyển dụng nào có ứng viên nộp hồ sơ.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Công việc</th>
                                        <th scope="col">Địa điểm</th>
                                        <th scope="col">Trạng thái</th>
                                        <th scope="col">Ngày đăng</th>
                                        <th scope="col">Hạn nộp</th>
                                        <th scope="col">Ứng viên</th>
                                        <th scope="col">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="jobPost" items="${jobPosts}">
                                        <tr>
                                            <td>
                                                <div class="job-title">${jobPost.jobTitle}</div>
                                                <div class="company-name">${jobPost.companyName}</div>
                                            </td>
                                            <td>
                                                <i class="bi bi-geo-alt text-muted me-1"></i>
                                                ${jobPost.location}
                                            </td>
                                            <td>
                                                <span class="status-badge status-${fn:toLowerCase(jobPost.status)}">
                                                    ${jobPost.status}
                                                </span>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${jobPost.postedDate}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${jobPost.deadline}" pattern="dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <div class="application-count">
                                                    <div class="count-item">
                                                        <span class="count-badge total">${jobPost.totalApplications}</span>
                                                        <span>Tổng</span>
                                                    </div>
                                                    <div class="count-item">
                                                        <span class="count-badge pending">${jobPost.pendingCount}</span>
                                                        <span>Chờ</span>
                                                    </div>
                                                    <div class="count-item">
                                                        <span class="count-badge accepted">${jobPost.acceptedCount}</span>
                                                        <span>Duyệt</span>
                                                    </div>
                                                    <div class="count-item">
                                                        <span class="count-badge rejected">${jobPost.rejectedCount}</span>
                                                        <span>Từ chối</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="JobPostCandidates?jobId=${jobPost.jobId}" 
                                                       class="btn btn-outline-primary btn-sm" title="Xem ứng viên">
                                                        <i class="bi bi-people"></i>
                                                    </a>
                                                    <a href="CandidateJobDetail?jobID=${jobPost.jobId}" 
                                                       class="btn btn-outline-info btn-sm" title="Chi tiết">
                                                        <i class="bi bi-eye"></i>
                                                    </a>
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
                                <a class="page-link" href="?page=${currentPage - 1}&jobTitle=${selectedJobTitle}&status=${selectedStatus}&minApplications=${selectedMinApplications}">Trước</a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&jobTitle=${selectedJobTitle}&status=${selectedStatus}&minApplications=${selectedMinApplications}">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage + 1}&jobTitle=${selectedJobTitle}&status=${selectedStatus}&minApplications=${selectedMinApplications}">Sau</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            // Clear filters function
                            function clearFilters() {
                                window.location.href = 'ApplicationManagement';
                            }

                            // Auto-submit form when filters change
                            document.addEventListener('DOMContentLoaded', function () {
                                const filterInputs = document.querySelectorAll('#filterForm input, #filterForm select');
                                filterInputs.forEach(input => {
                                    if (input.type !== 'submit') {
                                        input.addEventListener('change', function () {
                                            // Optional: Auto-submit on change
                                            // document.getElementById('filterForm').submit();
                                        });
                                    }
                                });
                            });
        </script>

    </body>
</html>