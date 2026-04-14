<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý bài thi - JobHub</title>
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
            background-image: url('https://images.unsplash.com/photo-1434030216411-0b793f4b4173?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
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

        .stats-card.danger {
            border-color: var(--danger-color);
            background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 100%);
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

        .stats-card.danger .stats-icon {
            color: var(--danger-color);
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

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            border: none;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
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

        .badge-danger {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .badge-secondary {
            background-color: rgba(100, 116, 139, 0.1);
            color: var(--gray-color);
        }

        .test-title {
            font-weight: 600;
            color: #334155;
            margin-bottom: 0.25rem;
            white-space: normal;
            overflow-wrap: break-word;
            word-wrap: break-word;
            max-width: 60ch;
        }

        .test-description {
            font-size: 0.875rem;
            color: var(--gray-color);
            white-space: normal;
            overflow-wrap: break-word;
            word-wrap: break-word;
            max-width: 60ch;
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
                        <i class="bi bi-file-earmark-text me-3"></i>Quản lý bài thi
                    </h1>
                    <p class="lead mb-0">Tạo và quản lý bài thi cho ứng viên của bạn</p>
                    <p class="text-white-50">Đánh giá năng lực ứng viên một cách hiệu quả</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container">
        <div class="main-container">
            <div class="p-4">
                <!-- Header Actions -->
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                    <div>
                        <h2 class="mb-1 fw-bold">Dashboard Bài thi</h2>
                        <p class="text-muted mb-0">Tổng quan về các bài thi và kết quả</p>
                    </div>
                    <div>
                        <button class="btn btn-primary" onclick="openCreateModal()">
                            <i class="bi bi-plus-lg me-2"></i>Tạo bài thi mới
                        </button>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="stats-grid">
                    <div class="stats-card primary">
                        <div class="stats-icon">
                            <i class="bi bi-file-earmark-text"></i>
                        </div>
                        <div class="stats-number">${totalCount}</div>
                        <div class="stats-title">Tổng số bài thi</div>
                    </div>
                    
                    <div class="stats-card warning">
                        <div class="stats-icon">
                            <i class="bi bi-clock-history"></i>
                        </div>
                        <div class="stats-number">${pendingCount}</div>
                        <div class="stats-title">Chờ duyệt</div>
                    </div>
                    
                    <div class="stats-card success">
                        <div class="stats-icon">
                            <i class="bi bi-check-circle"></i>
                        </div>
                        <div class="stats-number">${acceptedCount}</div>
                        <div class="stats-title">Đã duyệt</div>
                    </div>
                    
                    <div class="stats-card danger">
                        <div class="stats-icon">
                            <i class="bi bi-x-circle"></i>
                        </div>
                        <div class="stats-number">${rejectedCount}</div>
                        <div class="stats-title">Đã từ chối</div>
                    </div>
                </div>

                <!-- Search and Filter Section -->
                <div class="section-card mb-4">
                    <form method="get" action="TestManage">
                        <div class="row g-3 align-items-center">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-search"></i>
                                    </span>
                                    <input type="text" name="searchQuery" value="${param.searchQuery}" 
                                           class="form-control" placeholder="Tìm kiếm bài thi...">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <select class="form-select" name="status">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="None" ${param.status == 'None' ? 'selected' : ''}>Chưa yêu cầu duyệt</option>
                                    <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Đang chờ duyệt</option>
                                    <option value="Accepted" ${param.status == 'Active' ? 'selected' : ''}>Hoạt động</option>
                                    <option value="Rejected" ${param.status == 'Rejected' ? 'selected' : ''}>Từ chối</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bi bi-search me-1"></i> Tìm kiếm
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Tests Table -->
                <div class="section-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h3 class="mb-1 fw-bold">Danh sách bài thi</h3>
                            <p class="text-muted mb-0">Quản lý và theo dõi các bài thi</p>
                        </div>
                        <a href="AssignmentManagement" class="btn btn-secondary">
                            <i class="bi bi-list-check me-2"></i>Danh sách bài làm
                        </a>
                    </div>

                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Tiêu đề</th>
                                    <th>Câu hỏi</th>
                                    <th>Số lượng bài làm</th>
                                    <th>Điểm trung bình</th>
                                    <th>Tỉ lệ đạt (>60%)</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày tạo</th>
                                    <th class="text-center">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${testList}">
                                    <tr>
                                        <td>
                                            <div class="test-title">${item.title}</div>
                                            <div class="test-description">${item.description}</div>
                                        </td>
                                        <td><span class="badge badge-secondary">${item.questionCount}</span></td>
                                        <td><span class="badge badge-primary">${item.testTakenCount}</span></td>
                                        <td><span class="badge badge-success">${item.avgScore}</span></td>
                                        <td><span class="badge badge-warning">${item.passRate}%</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.status == 'None'}">
                                                    <span class="badge badge-secondary">Chưa yêu cầu duyệt</span>
                                                </c:when>
                                                <c:when test="${item.status == 'Pending'}">
                                                    <span class="badge badge-warning">Đang chờ duyệt</span>
                                                </c:when>
                                                <c:when test="${item.status == 'Accepted'}">
                                                    <span class="badge badge-success">Hoạt động</span>
                                                </c:when>
                                                <c:when test="${item.status == 'Rejected'}">
                                                    <span class="badge badge-danger">Từ chối</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary">Không xác định</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="color: #6b7280; font-size: 14px;">
                                            <fmt:formatDate value="${item.createdAt}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td class="text-center">
                                            <form action="EditTest" class="d-inline">
                                                <input type="hidden" name="testId" value="${item.testId}">
                                                <button type="submit" class="btn btn-outline-primary btn-sm">
                                                    <i class="bi bi-eye me-1"></i>Chi tiết
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${empty testList}">
                        <div class="text-center py-5">
                            <i class="bi bi-file-earmark-text" style="font-size: 3rem; color: #9ca3af;"></i>
                            <h5 class="mt-3 mb-2">Không tìm thấy bài thi nào</h5>
                            <p class="text-muted">Thử điều chỉnh tiêu chí tìm kiếm hoặc bộ lọc của bạn.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Create Test Modal -->
    <div class="modal fade" id="create-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Tạo mới bài kiểm tra</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="create-test-form" action="TestManage" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label" for="test-title">Tiêu đề <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="test-title" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="test-description">Mô tả <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="test-description" name="description" rows="4" required></textarea>
                            <div class="form-text">Bạn có thể chỉnh sửa/thêm câu hỏi cho bài kiểm tra sau khi tạo mới</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="hidden" name="recruiterId" value="${recruiterId}">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                        <button type="submit" class="btn btn-primary">Tạo bài thi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Modal functions
        function openCreateModal() {
            const modal = new bootstrap.Modal(document.getElementById('create-modal'));
            modal.show();
        }

        function closeCreateModal() {
            const modal = bootstrap.Modal.getInstance(document.getElementById('create-modal'));
            if (modal) {
                modal.hide();
            }
            document.getElementById('create-test-form').reset();
        }

        // Close modal when clicking outside or pressing escape
        document.getElementById('create-modal').addEventListener('hidden.bs.modal', function () {
            document.getElementById('create-test-form').reset();
        });
    </script>
</body>
</html>