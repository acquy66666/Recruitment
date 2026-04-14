<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tìm kiếm ứng viên | MyJob</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            :root {
                --primary-dark: #001a57;
                --primary-color: #0046b8;
                --primary-light: #0066ff;
                --secondary-color: #2c3e50;
                --accent-color: #ff7f50;
                --accent-hover: #ff6a3c;
                --light-gray: #f8f9fa;
                --medium-gray: #e9ecef;
                --dark-gray: #6c757d;
                --border-color: #dee2e6;
                --error-color: #dc3545;
                --success-color: #28a745;
                --warning-color: #ffc107;
                --info-color: #17a2b8;
                --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                --transition-speed: 0.3s;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Roboto', sans-serif;
            }

            body {
                background-color: var(--light-gray);
                color: var(--secondary-color);
                line-height: 1.6;
            }

            /* Header */
            .header {
                background: linear-gradient(90deg, var(--primary-dark) 0%, var(--primary-light) 100%);
                color: white;
                padding: 15px 0;
                box-shadow: var(--box-shadow);
            }

            .header-container {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 20px;
            }

            .logo {
                display: flex;
                align-items: center;
                font-size: 24px;
                font-weight: bold;
            }

            .user-menu {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .logout-btn {
                background: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background var(--transition-speed);
            }

            .logout-btn:hover {
                background: rgba(255, 255, 255, 0.3);
            }

            /* Main Container */
            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 30px 20px;
            }

            /* Page Header */
            .page-header {
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: var(--box-shadow);
                margin-bottom: 30px;
            }

            .page-title {
                font-size: 28px;
                font-weight: 600;
                color: var(--secondary-color);
                margin-bottom: 10px;
            }

            .page-subtitle {
                color: var(--dark-gray);
                font-size: 16px;
            }

            /* Filters */
            .filters-section {
                background: white;
                padding: 25px;
                border-radius: 8px;
                box-shadow: var(--box-shadow);
                margin-bottom: 30px;
            }

            .filters-title {
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 20px;
                color: var(--secondary-color);
            }

            .filters-row {
                display: grid;
                grid-template-columns: repeat(3, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 20px;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
            }

            .filter-group label {
                font-weight: 500;
                margin-bottom: 8px;
                color: var(--secondary-color);
            }

            .filter-control {
                padding: 10px 12px;
                border: 1px solid var(--border-color);
                border-radius: 4px;
                font-size: 14px;
                transition: border-color var(--transition-speed);
            }

            .filter-control:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 70, 184, 0.1);
            }

            .filter-actions {
                display: flex;
                gap: 10px;
                align-items: end;
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all var(--transition-speed);
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            form {
                display: inline; /* hoặc inline-block nếu cần */
            }

            form .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 6px 12px;
                font-size: 12px;
                border-radius: 4px;
                line-height: normal;
                vertical-align: middle;
                height: 37px; /* khớp chiều cao với .btn-sm nếu cần */
            }


            .btn-primary {
                background-color: var(--primary-color);
                color: white;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
            }

            .btn-secondary {
                background-color: var(--medium-gray);
                color: var(--secondary-color);
            }

            .btn-secondary:hover {
                background-color: var(--dark-gray);
                color: white;
            }

            /* Stats Cards */
            .stats-section {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 25px;
                border-radius: 8px;
                box-shadow: var(--box-shadow);
                text-align: center;
                transition: transform var(--transition-speed);
            }

            .stat-card:hover {
                transform: translateY(-2px);
            }

            .stat-icon {
                font-size: 36px;
                margin-bottom: 15px;
            }

            .stat-icon.total {
                color: var(--primary-color);
            }
            .stat-icon.active {
                color: var(--success-color);
            }
            .stat-icon.male {
                color: var(--info-color);
            }
            .stat-icon.female {
                color: var(--accent-color);
            }

            .stat-number {
                font-size: 32px;
                font-weight: bold;
                color: var(--secondary-color);
                margin-bottom: 5px;
            }

            .stat-label {
                color: var(--dark-gray);
                font-size: 14px;
            }

            /* Candidates Table */
            .candidates-section {
                background: white;
                border-radius: 8px;
                box-shadow: var(--box-shadow);
                overflow: hidden;
            }

            .section-header {
                padding: 25px;
                border-bottom: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .section-title {
                font-size: 20px;
                font-weight: 600;
                color: var(--secondary-color);
            }

            .table-container {
                overflow-x: auto;
            }

            .candidates-table {
                width: 100%;
                border-collapse: collapse;
            }

            .candidates-table th,
            .candidates-table td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid var(--border-color);
            }

            .candidates-table th {
                background-color: var(--light-gray);
                font-weight: 600;
                color: var(--secondary-color);
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .candidates-table tbody tr {
                transition: background-color var(--transition-speed);
            }

            .candidates-table tbody tr:hover {
                background-color: rgba(0, 70, 184, 0.05);
            }

            /* Candidate Info */
            .candidate-info {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .candidate-avatar {
                width: 45px;
                height: 45px;
                border-radius: 50%;
                background: linear-gradient(45deg, var(--primary-color), var(--primary-light));
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: bold;
                font-size: 16px;
                overflow: hidden;
            }

            .candidate-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 50%;
            }

            .candidate-details h4 {
                font-size: 16px;
                font-weight: 600;
                color: var(--secondary-color);
                margin-bottom: 2px;
            }

            .candidate-details p {
                font-size: 13px;
                color: var(--dark-gray);
            }

            /* Status Badge */
            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-active {
                background-color: rgba(40, 167, 69, 0.2);
                color: #155724;
            }

            .status-inactive {
                background-color: rgba(220, 53, 69, 0.2);
                color: #721c24;
            }

            /* Gender Badge */
            .gender-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 500;
            }

            .gender-male {
                background-color: rgba(23, 162, 184, 0.2);
                color: #0c5460;
            }

            .gender-female {
                background-color: rgba(255, 127, 80, 0.2);
                color: #8b4513;
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                gap: 8px;
            }

            .btn-sm {
                padding: 6px 12px;
                font-size: 12px;
                border-radius: 4px;
            }

            .btn-view {
                background-color: var(--info-color);
                color: white;
            }

            .btn-view:hover {
                background-color: #138496;
            }

            .btn-contact {
                background-color: var(--accent-color);
                color: white;
            }

            .btn-contact:hover {
                background-color: var(--accent-hover);
            }

            /* Pagination */
            .pagination-section {
                padding: 25px;
                border-top: 1px solid var(--border-color);
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .pagination-info {
                color: var(--dark-gray);
                font-size: 14px;
            }

            .pagination {
                display: flex;
                gap: 5px;
            }

            .pagination a,
            .pagination span {
                padding: 8px 12px;
                border: 1px solid var(--border-color);
                color: var(--secondary-color);
                text-decoration: none;
                border-radius: 4px;
                transition: all var(--transition-speed);
            }

            .pagination a:hover {
                background-color: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }

            .pagination .current {
                background-color: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: var(--dark-gray);
            }

            .empty-state i {
                font-size: 64px;
                margin-bottom: 20px;
                color: var(--medium-gray);
            }

            .empty-state h3 {
                font-size: 20px;
                margin-bottom: 10px;
                color: var(--secondary-color);
            }

            a.btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                text-decoration: none;
                height: 37px; /* hoặc cùng height với button */
                line-height: normal;
                padding: 10px 20px; /* giống với button */
                vertical-align: middle;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .main-container {
                    padding: 20px 10px;
                }

                .filters-row {
                    grid-template-columns: 1fr;
                }

                .stats-section {
                    grid-template-columns: repeat(2, 1fr);
                }

                .section-header {
                    flex-direction: column;
                    gap: 15px;
                    align-items: stretch;
                }

                .candidates-table {
                    font-size: 14px;
                }

                .candidates-table th,
                .candidates-table td {
                    padding: 10px 8px;
                }

                .action-buttons {
                    flex-direction: column;
                }
            }

            @media (max-width: 480px) {
                .stats-section {
                    grid-template-columns: 1fr;
                }

                .candidate-info {
                    flex-direction: column;
                    text-align: center;
                    gap: 8px;
                }
            }
        </style>
    </head>
    <body>

        <!-- Header -->
        <header class="header">
            <div class="header-container">
                <div class="logo">
                    <i class="fas fa-briefcase" style="margin-right: 10px;"></i>
                    MyJob - Employer
                </div>
                <div class="user-menu">
                    <div class="user-info">
                        <i class="fas fa-user-circle" style="font-size: 24px;"></i>
                        <span>Chào, Nhà tuyển dụng</span>
                    </div>
                    <button class="logout-btn" onclick="logout()">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </button>
                </div>
            </div>
        </header>

        <!-- Main Container -->
        <div class="main-container">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">Tìm kiếm ứng viên</h1>
                <p class="page-subtitle">Tìm kiếm và liên hệ với các ứng viên tiềm năng trong cơ sở dữ liệu</p>
            </div>

            <!-- Filters Section -->
            <div class="filters-section">
                <h3 class="filters-title">
                    <i class="fas fa-search"></i> Bộ lọc tìm kiếm
                </h3>
                <form id="searchForm" action="CVFilter" method="GET">
                    <div class="filters-row">
                        <div class="filter-group">
                            <label for="fullName">Tên ứng viên</label>
                            <input type="text" id="search" name="search" value="${search}" class="filter-control" 
                                   placeholder="Nhập tên ứng viên...">
                        </div>


                        <div class="filter-group">
                            <label for="gender">Giới tính</label>
                            <select id="gender" name="gender" class="filter-control">
                                <option value="" ${empty param.gender ? "selected" : ""}>Tất cả</option>
                                <option value="Male" ${param.gender == 'Male' ? "selected" : ""}>Nam</option>
                                <option value="Female" ${param.gender == 'Female' ? "selected" : ""}>Nữ</option>
                                <option value="Other" ${param.gender == 'Other' ? "selected" : ""}>Khác</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="address">Địa chỉ</label>
                            <input type="text" id="address" name="address" value="${address}" class="filter-control" 
                                   placeholder="Nhập địa chỉ...">
                        </div>

                        <div class="filter-group">
                            <label for="edu">Học vấn</label>
                            <input type="text" id="edu" name="edu" value="${edu}" class="filter-control" 
                                   placeholder="Nhập ngành học/trường học">
                        </div>

                        <div class="filter-group">
                            <label for="skill">Kĩ năng</label>
                            <input type="text" id="skill" name="skill" value="${skill}" class="filter-control" 
                                   placeholder="Nhập kĩ năng ứng viên">
                        </div>

                        <div class="filter-group">
                            <label for="workexp">Kinh nghiệm làm việc</label>
                            <select id="workexp" name="workexp" class="filter-control">
                                <option value="">Số kinh nghiệm</option>
                                <option value="1" ${param.workexp == '1' ? "selected" : ""}>1+</option>
                                <option value="2" ${param.workexp == '2' ? "selected" : ""}>2+</option>
                                <option value="3" ${param.workexp == '3' ? "selected" : ""}>3+</option>
                                <option value="4" ${param.workexp == '4' ? "selected" : ""}>4+</option>
                                <option value="5" ${param.workexp == '5' ? "selected" : ""}>5+</option>
                            </select>
                        </div>
                    </div>

                    <div class="filter-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                        <a  class="btn btn-secondary" href="CVFilter">
                            <i class="fas fa-times"></i> Xóa bộ lọc
                        </a>
                    </div>
                </form>
            </div>

            <!-- Stats Section -->
            <div class="stats-section">
                <div class="stat-card">
                    <div class="stat-icon total">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-number">${totalCount}</div>
                    <div class="stat-label">Tổng ứng viên</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon male">
                        <i class="fas fa-mars"></i>
                    </div>
                    <div class="stat-number">${maleCount}</div>
                    <div class="stat-label">Nam</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon female">
                        <i class="fas fa-venus"></i>
                    </div>
                    <div class="stat-number">${femaleCount}</div>
                    <div class="stat-label">Nữ</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon other">
                        <i class="fas fa-genderless"></i>
                    </div>
                    <div class="stat-number">${otherCount}</div>
                    <div class="stat-label">Khác</div>
                </div>
            </div>

            <!-- Candidates Table -->
            <div class="candidates-section">
                <div class="section-header">
                    <h3 class="section-title">
                        <i class="fas fa-list"></i> Danh sách ứng viên
                    </h3>
                </div>

                <div class="table-container">
                    <table class="candidates-table">
                        <thead>
                            <tr>
                                <th>Ứng viên</th>
                                <th>Giới tính</th>
                                <th>Ngày sinh</th>
                                <th>Địa chỉ</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${resultList}">
                                <tr>
                                    <td>
                                        <div class="candidate-info">
                                            <div class="candidate-avatar">
                                                <c:choose>
                                                    <c:when test="${not empty item.imageUrl}">
                                                        <img src="${item.imageUrl}" alt="Avatar" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${fn:substring(item.fullName, 0, 1)}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="candidate-details">
                                                <h4>${item.fullName}</h4>
                                                <p><i class="fas fa-envelope"></i> ${item.email}</p>
                                                <p><i class="fas fa-phone"></i> ${item.phone}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="gender-badge gender-male">
                                            <c:choose>
                                                <c:when test="${item.gender == 'Male'}">Nam</c:when>
                                                <c:when test="${item.gender == 'Female'}">Nữ</c:when>
                                                <c:when test="${item.gender == 'Other'}">Khác</c:when>
                                                <c:otherwise></c:otherwise>
                                            </c:choose>
                                        </span>

                                    </td>
                                    <td><fmt:formatDate value="${item.birthdate}" pattern="dd/MM/yyyy"/></td>
                                    <td>${item.address}</td>


                                    <td>
                                        <div class="action-buttons">
                                            <a class="btn btn-view btn-sm" href="${item.cvUrl}" target="_blank">
                                                <i class="fas fa-eye"></i> Xem CV
                                            </a>

                                            <form action="CVOverview" method="post" target="_blank" style="margin: 0;">
                                                <input type="hidden" name="candidateId" value="${item.candidateId}">
                                                <input type="hidden" name="cvId" value="${item.cvId}">
                                                <button type="submit" class="btn btn-contact btn-sm">
                                                    <i class="fas fa-info-circle"></i> Chi tiết
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </div>

                <c:set var="page" value="${page}" />
                <c:set var="beginPage" value="${page - 2 < 1 ? 1 : page - 2}" />
                <c:set var="endPage" value="${page + 2 > totalPages ? totalPages : page + 2}" />

                <div class="pagination-section">
                    <div class="pagination">

                        <c:if test="${page > 1}">
                            <a href="CVFilter?page=${page - 1}&search=${param.search}&gender=${param.gender}&address=${param.address}&edu=${param.edu}&skill=${param.skill}&workexp=${param.workexp}">
                                ‹ Trước
                            </a>
                        </c:if>


                        <c:if test="${beginPage > 1}">
                            <a href="CVFilter?page=1&search=${param.search}&gender=${param.gender}&address=${param.address}&edu=${param.edu}&skill=${param.skill}&workexp=${param.workexp}">1</a>
                            <span>...</span>
                        </c:if>


                        <c:forEach var="i" begin="${beginPage}" end="${endPage}">
                            <c:choose>
                                <c:when test="${i == page}">
                                    <span class="current">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="CVFilter?page=${i}&search=${param.search}&gender=${param.gender}&address=${param.address}&edu=${param.edu}&skill=${param.skill}&workexp=${param.workexp}">
                                        ${i}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>


                        <c:if test="${endPage < totalPages}">
                            <span>...</span>
                            <a href="CVFilter?page=${totalPages}&search=${param.search}&gender=${param.gender}&address=${param.address}&edu=${param.edu}&skill=${param.skill}&workexp=${param.workexp}">${totalPages}</a>
                        </c:if>


                        <c:if test="${page < totalPages}">
                            <a href="CVFilter?page=${page + 1}&search=${param.search}&gender=${param.gender}&address=${param.address}&edu=${param.edu}&skill=${param.skill}&workexp=${param.workexp}">
                                Sau ›
                            </a>
                        </c:if>
                    </div>
                </div>

            </div>
        </div>

        <script>

        </script>
    </body>
</html>
