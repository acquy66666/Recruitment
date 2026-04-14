<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Employer Profile</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2563eb;
                --primary-light: #eff6ff;
                --secondary-color: #1e40af;
                --success-color: #10b981;
                --warning-color: #f59e0b;
                --danger-color: #ef4444;
                --dark-color: #1f2937;
                --gray-color: #6b7280;
                --light-gray: #f9fafb;
                --border-color: #e5e7eb;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--light-gray);
                color: var(--dark-color);
            }

            .navbar {
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .main-container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 0 15px;
            }

            .profile-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
                overflow: hidden;
            }

            .profile-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 30px;
            }

            .profile-avatar {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                border: 3px solid white;
                object-fit: cover;
            }

            .card-body {
                padding: 25px;
            }

            .section-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 1px solid var(--border-color);
            }

            .section-title h5 {
                margin: 0;
                font-weight: 600;
                display: flex;
                align-items: center;
            }

            .section-title i {
                margin-right: 10px;
                color: var(--primary-color);
            }

            .info-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 0;
                border-bottom: 1px solid #f3f4f6;
            }

            .info-row:last-child {
                border-bottom: none;
            }

            .info-label {
                font-weight: 500;
                color: var(--dark-color);
            }

            .info-value {
                color: var(--gray-color);
            }

            .edit-btn {
                background: none;
                border: 1px solid var(--primary-color);
                color: var(--primary-color);
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 14px;
                transition: all 0.2s;
            }

            .edit-btn:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
            }

            .btn-primary:hover {
                background-color: var(--secondary-color);
                border-color: var(--secondary-color);
            }

            .btn-outline-secondary {
                border-color: var(--border-color);
                color: var(--gray-color);
                padding: 10px 20px;
                border-radius: 8px;
            }

            .form-control,
            .form-select {
                border-radius: 8px;
                border: 1px solid var(--border-color);
                padding: 10px 12px;
                margin-bottom: 15px;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            .search-card {
                background: white;
                border-radius: 12px;
                padding: 25px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .search-filters {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }

            .search-result {
                border: 1px solid var(--border-color);
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 15px;
                transition: all 0.2s;
            }

            .search-result:hover {
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                transform: translateY(-1px);
            }

            .candidate-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                object-fit: cover;
            }

            .transaction-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                margin-bottom: 10px;
            }

            .transaction-amount {
                font-weight: 600;
            }

            .transaction-amount.positive {
                color: var(--success-color);
            }

            .transaction-amount.negative {
                color: var(--danger-color);
            }

            .status-badge {
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 12px;
                font-weight: 500;
            }

            .status-success {
                background-color: rgba(16, 185, 129, 0.1);
                color: var(--success-color);
            }

            .status-pending {
                background-color: rgba(245, 158, 11, 0.1);
                color: var(--warning-color);
            }

            .status-failed {
                background-color: rgba(239, 68, 68, 0.1);
                color: var(--danger-color);
            }

            .nav-tabs {
                border-bottom: 1px solid var(--border-color);
                margin-bottom: 20px;
            }

            .nav-tabs .nav-link {
                border: none;
                color: var(--gray-color);
                padding: 12px 20px;
                border-radius: 0;
            }

            .nav-tabs .nav-link.active {
                color: var(--primary-color);
                border-bottom: 2px solid var(--primary-color);
                background: none;
            }

            .edit-mode {
                display: none;
            }

            .edit-mode.active {
                display: block;
            }

            .view-mode.editing {
                display: none;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 5px;
            }

            .stat-label {
                color: var(--gray-color);
                font-size: 14px;
            }

            @media (max-width: 768px) {
                .search-filters {
                    flex-direction: column;
                }

                .search-filters>* {
                    width: 100%;
                }
            }
        </style>
    </head>

    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: var(--primary-color);">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">RecruiterHub</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="HomePage">Home Page</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Profile</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Jobs</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle"></i>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Settings</a></li>
                                <li><a class="dropdown-item" href="#">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Main Container -->
        <div class="main-container">
            <!-- Profile Header -->
            <div class="profile-card">
                <div class="profile-header">
                    <div class="row align-items-center">
                        <div class="col-md-2 text-center text-md-start">
                            <img src="${recruiter.getImageUrl()}" alt="Profile" class="profile-avatar">
                        </div>
                        <div class="col-md-8">
                            <h3 class="mb-1">${recruiter.getFullName()}</h3>
                            <p class="mb-2 opacity-75">${recruiter.getPosition()} ở ${recruiter.getCompanyName()}</p>
                            <p class="mb-0 opacity-75"><i class="bi bi-geo-alt me-1"></i></p>
                        </div>
                        <div class="col-md-2 text-center text-md-end">
                            <form method="post" action="EditImageRecruiter" enctype="multipart/form-data">
                                <label for="modalImageUrl" class="btn btn-light btn-sm">
                                    <i class="bi bi-camera me-1"></i> Thay đổi ảnh
                                </label>
                                <input type="hidden" name="action" value="editPersonal">
                                <input type="file" class="d-none" id="modalImageUrl" name="imageRecruiter" onchange="this.form.submit()">
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Overview -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number">24</div>
                    <div class="stat-label">Công việc đang tuyển</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">156</div>
                    <div class="stat-label">Số đơn ứng tuyển</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">42</div>
                    <div class="stat-label">Phỏng vấn</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">$2,450</div>
                    <div class="stat-label">Tổng chi tiêu</div>
                </div>
            </div>

            <!-- Navigation Tabs -->
            <ul class="nav nav-tabs" id="profileTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link ${empty activeTab || activeTab == 'personal' ? 'active' : ''}" id="personal-tab" data-bs-toggle="tab" data-bs-target="#personal"
                            type="button" role="tab">
                        <i class="bi bi-person me-2"></i>Thông tin cá nhân
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link ${activeTab == 'company' ? 'active' : ''}" id="company-tab" data-bs-toggle="tab" data-bs-target="#company" type="button"
                            role="tab">
                        <i class="bi bi-building me-2"></i>Thông tin công ty
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link ${activeTab == 'password' ? 'active' : ''}" id="password-tab" data-bs-toggle="tab" data-bs-target="#password" 
                            type="button" role="tab">
                        <i class="bi bi-lock me-2"></i>Đổi mật khẩu
                    </button>
                </li>

                <!--                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="search-tab" data-bs-toggle="tab" data-bs-target="#search" type="button"
                                            role="tab">
                                        <i class="bi bi-search me-2"></i>Search Candidates
                                    </button>
                                </li>-->
                <!--                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="transactions-tab" data-bs-toggle="tab" data-bs-target="#transactions"
                                            type="button" role="tab">
                                        <i class="bi bi-credit-card me-2"></i>Transactions
                                    </button>
                                </li>-->
            </ul>
            <c:if test="${not empty errorIMG}">
                <div class="alert alert-danger" role="alert">
                    ${errorIMG}
                </div>
            </c:if>
            <!-- Tab Content -->
            <div class="tab-content" id="profileTabsContent">

                <!-- Personal Information Tab -->
                <div class="tab-pane fade ${empty activeTab || activeTab == 'personal' ? 'show active' : ''}" id="personal" role="tabpanel">
                    <div class="profile-card">
                        <div class="card-body">
                            <div class="section-title">
                                <h5><i class="bi bi-person"></i>Thông tin cá nhân</h5>
                                <button class="edit-btn" title="Edit-Personal" data-bs-toggle="modal" data-bs-target="#editPersonalModal"

                                        data-fullName="${recruiter.getFullName()}"
                                        data-position="${recruiter.getPosition()}"
                                        data-phone="${recruiter.getPhone()}"

                                        data-imageUrl="${recruiter.getImageUrl()}"
                                        >
                                    <i class="bi bi-pencil me-1"></i> Edit
                                </button>
                            </div>

                            <c:if test="${not empty messagePersonal}">
                                <div class="alert alert-success" role="alert">
                                    ${messagePersonal}
                                </div>
                            </c:if>

                            <!-- View Mode -->
                            <div class="view-mode" id="personal-view">
                                <div class="info-row">
                                    <span class="info-label">Họ và tên</span>
                                    <span class="info-value">${recruiter.getFullName()}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Email</span>
                                    <span class="info-value">${recruiter.getEmail()}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Số điện thoại</span>
                                    <span class="info-value">${recruiter.getPhone()}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Vị trí công việc</span>
                                    <span class="info-value">${recruiter.getPosition()}</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Trạng thái</span>
                                    <span class="status-badge status-success">Active</span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Gia nhập từ</span>
                                    <span class="info-value">${recruiter.dateCreateNow()}</span>
                                </div>
                            </div>

                            <!-- Edit Personal Modal -->
                            <form action="EditProfileRecruiter" method="post">
                                <div class="modal fade" id="editPersonalModal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-scrollable">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <h5 class="modal-title">Chỉnh sửa thông tin cá nhân</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <c:if test="${not empty errorsPersonal}">
                                                <div class="alert alert-danger">
                                                    <ul>
                                                        <c:forEach var="err" items="${errorsPersonal}">
                                                            <li>${err}</li>
                                                            </c:forEach>
                                                    </ul>
                                                </div>
                                            </c:if>  
                                            <div class="modal-body">
                                                <!-- Hidden Recruiter ID -->
                                                <input type="hidden" value="${recruiter.getRecruiterId()}" name="recruiterId">
                                                <input type="hidden" name="action" value="editPersonal">
                                                <div class="mb-3">
                                                    <label for="modalFullName" class="form-label">Họ và tên</label>
                                                    <input type="text" class="form-control" id="modalFullName" name="fullName" value="${fullName}" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="modalPosition" class="form-label">Vị trí công việc</label>
                                                    <input type="text" class="form-control" id="modalPosition" name="position" value="${position}">
                                                </div>

                                                <div class="mb-3">
                                                    <label for="modalPhone" class="form-label">Số điện thoại</label>
                                                    <input type="text" class="form-control" id="modalPhone" name="phone" value="${phone}">
                                                </div>

                                                <!--                                                <div class="mb-3">
                                                                                                    <label for="modalAddress" class="form-label">Address</label>
                                                                                                    <input type="text" class="form-control" id="modalAddress" name="address">
                                                                                                </div>-->

                                                <!--                                                <div class="mb-3">
                                                                                                    <label for="modalImageUrl" class="form-label">Hình ảnh</label>
                                                                                                    <form method="post" action="EditImageRecruiter" enctype="multipart/form-data">
                                                                                                        <input type="file" class="form-control" id="modalImageUrl" name="imageRecruiter"> 
                                                                                                    </form>
                                                
                                                                                                </div>-->
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>

                <!-- Company Information Tab -->
                <div class="tab-pane fade ${activeTab == 'company' ? 'show active' : ''}" id="company" role="tabpanel">
                    <div class="profile-card">
                        <div class="card-body">
                            <div class="section-title">
                                <h5><i class="bi bi-building"></i>Thông tin công ty</h5>
                                <button class="edit-btn" title="Edit-Company" data-bs-toggle="modal"
                                        data-bs-target="#editCompanyModal"

                                        data-companyName="${recruiter.getCompanyName()}"
                                        data-website="${recruiter.getWebsite()}"

                                        data-companyAddress="${recruiter.getCompanyAddress()}"

                                        data-industry="${recruiter.getIndustry()}"
                                        data-tax="${recruiter.getTaxCode()}"
                                        data-companyLogoUrl="${recruiter.getCompanyLogoUrl()}"
                                        data-companyDescription="${recruiter.getCompanyDescription()}"
                                        >
                                    <i class="bi bi-pencil me-1"></i> Sửa
                                </button>
                            </div>
                            <c:if test="${not empty messageCompany}">
                                <div class="alert alert-success" role="alert">
                                    ${messageCompany}
                                </div>
                            </c:if>
                            <!-- View Mode -->
                            <div class="view-mode" id="company-view">
                                <div class="row">
                                    <!-- Left Side: Company Info -->
                                    <div class="col-md-9">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="info-row">
                                                    <span class="info-label">Tên công ty</span>
                                                    <span class="info-value">${recruiter.getCompanyName()}</span>
                                                </div>
                                                <div class="info-row">
                                                    <span class="info-label">Website</span>
                                                    <span class="info-value">${recruiter.getWebsite()}</span>
                                                </div>

                                                <div class="info-row">
                                                    <span class="info-label">Địa chỉ</span>
                                                    <span class="info-value">${recruiter.getCompanyAddress()}</span>
                                                </div>

                                            </div>
                                            <div class="col-sm-5" style="margin-left: 7%;">

                                                <div class="info-row">
                                                    <span class="info-label">Lĩnh vực</span>
                                                    <span class="info-value">${recruiter.getIndustry()}</span>
                                                </div>
                                                <div class="info-row">
                                                    <span class="info-label">Mã số thuế</span>
                                                    <span class="info-value">${recruiter.getTaxCode()}</span>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                    <!-- Right Side: Logo -->
                                    <div class="col-md-3 text-center">
                                        <form method="post" action="EditImageRecruiter" enctype="multipart/form-data">
                                            <div class="col-md-10">
                                                <!-- Ảnh hiển thị -->
                                                <img src="${recruiter.getCompanyLogoUrl()}" alt="Company Logo"
                                                     class="img-fluid rounded mb-2" style="max-width: 120px;">
                                            </div>
                                            <div class="col-md-10">
                                                <!-- Label và input upload ảnh -->
                                                <input type="hidden" name="action" value="editCompany">
                                                <label for="modalImageLogoUrl" class="btn btn-light btn-sm">
                                                    <i class="bi bi-camera me-1"></i> Thay đổi logo
                                                </label>
                                                <input type="file" class="d-none" id="modalImageLogoUrl" name="imageRecruiterCompany" onchange="this.form.submit()">
                                            </div>
                                        </form>
                                    </div>

                                </div>

                                <!-- Description, Vision, Mission, Values -->
                                <div class="mt-4">
                                    <h6>Mô tả về công ty</h6>
                                    <p class="text-muted">${recruiter.getCompanyDescription()}</p>
                                </div>

                            </div>

                            <!--Modal edit company-->
                            <form action="EditProfileRecruiter" method="post">
                                <div class="modal fade" id="editCompanyModal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-lg modal-dialog-scrollable">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <h5 class="modal-title">Chỉnh sửa thông tin công ty</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <c:if test="${not empty errorsCompany}">
                                                <div class="alert alert-danger">
                                                    <ul>
                                                        <c:forEach var="err" items="${errorsCompany}">
                                                            <li>${err}</li>
                                                            </c:forEach>
                                                    </ul>
                                                </div>
                                            </c:if> 

                                            <div class="modal-body">
                                                <input type="hidden" value="${recruiter.getRecruiterId()}" name="recruiterId">
                                                <input type="hidden" name="action" value="editCompany">
                                                <div class="mb-3">
                                                    <label class="form-label">Tên công ty</label>
                                                    <input type="text" class="form-control" id="modalCompanyName" name="companyName" value="${companyName}" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Website</label>
                                                    <input type="text" class="form-control" id="modalWebsite" name="website" value="${website}">    
                                                </div>



                                                <div class="mb-3">
                                                    <label class="form-label">Địa chỉ</label>
                                                    <!--<input type="text" class="form-control" id="modalCompanyAddress" name="companyAddress">-->
                                                    <select name="companyAddress" id="modalCompanyAddress" required
                                                            class="form-select block w-full max-w-sm p-2 border border-gray-300 rounded-md text-sm">
                                                        <option value="" disabled ${empty location ? 'selected' : ''}>-- Chọn tỉnh/thành phố --</option>

                                                        <!-- Thành phố -->
                                                        <option value="Hà Nội" ${location == 'Hà Nội' ? 'selected' : ''}>Thành phố Hà Nội</option>
                                                        <option value="Hồ Chí Minh" ${location == 'Hồ Chí Minh' ? 'selected' : ''}>Thành phố Hồ Chí Minh</option>
                                                        <option value="Đà Nẵng" ${location == 'Đà Nẵng' ? 'selected' : ''}>Thành phố Đà Nẵng</option>
                                                        <option value="Hải Phòng" ${location == 'Hải Phòng' ? 'selected' : ''}>Thành phố Hải Phòng</option>
                                                        <option value="Cần Thơ" ${location == 'Cần Thơ' ? 'selected' : ''}>Thành phố Cần Thơ</option>
                                                        <option value="Huế" ${location == 'Huế' ? 'selected' : ''}>Thành phố Huế</option>

                                                        <!-- Tỉnh -->
                                                        <option value="Lai Châu" ${location == 'Lai Châu' ? 'selected' : ''}>Tỉnh Lai Châu</option>
                                                        <option value="Điện Biên" ${location == 'Điện Biên' ? 'selected' : ''}>Tỉnh Điện Biên</option>
                                                        <option value="Sơn La" ${location == 'Sơn La' ? 'selected' : ''}>Tỉnh Sơn La</option>
                                                        <option value="Lạng Sơn" ${location == 'Lạng Sơn' ? 'selected' : ''}>Tỉnh Lạng Sơn</option>
                                                        <option value="Quảng Ninh" ${location == 'Quảng Ninh' ? 'selected' : ''}>Tỉnh Quảng Ninh</option>
                                                        <option value="Thanh Hoá" ${location == 'Thanh Hoá' ? 'selected' : ''}>Tỉnh Thanh Hoá</option>
                                                        <option value="Nghệ An" ${location == 'Nghệ An' ? 'selected' : ''}>Tỉnh Nghệ An</option>
                                                        <option value="Hà Tĩnh" ${location == 'Hà Tĩnh' ? 'selected' : ''}>Tỉnh Hà Tĩnh</option>
                                                        <option value="Cao Bằng" ${location == 'Cao Bằng' ? 'selected' : ''}>Tỉnh Cao Bằng</option>
                                                        <option value="Tuyên Quang" ${location == 'Tuyên Quang' ? 'selected' : ''}>Tỉnh Tuyên Quang</option>
                                                        <option value="Lào Cai" ${location == 'Lào Cai' ? 'selected' : ''}>Tỉnh Lào Cai</option>
                                                        <option value="Thái Nguyên" ${location == 'Thái Nguyên' ? 'selected' : ''}>Tỉnh Thái Nguyên</option>
                                                        <option value="Phú Thọ" ${location == 'Phú Thọ' ? 'selected' : ''}>Tỉnh Phú Thọ</option>
                                                        <option value="Bắc Ninh" ${location == 'Bắc Ninh' ? 'selected' : ''}>Tỉnh Bắc Ninh</option>
                                                        <option value="Hưng Yên" ${location == 'Hưng Yên' ? 'selected' : ''}>Tỉnh Hưng Yên</option>
                                                        <option value="Ninh Bình" ${location == 'Ninh Bình' ? 'selected' : ''}>Tỉnh Ninh Bình</option>
                                                        <option value="Quảng Trị" ${location == 'Quảng Trị' ? 'selected' : ''}>Tỉnh Quảng Trị</option>
                                                        <option value="Quảng Ngãi" ${location == 'Quảng Ngãi' ? 'selected' : ''}>Tỉnh Quảng Ngãi</option>
                                                        <option value="Gia Lai" ${location == 'Gia Lai' ? 'selected' : ''}>Tỉnh Gia Lai</option>
                                                        <option value="Khánh Hoà" ${location == 'Khánh Hoà' ? 'selected' : ''}>Tỉnh Khánh Hoà</option>
                                                        <option value="Lâm Đồng" ${location == 'Lâm Đồng' ? 'selected' : ''}>Tỉnh Lâm Đồng</option>
                                                        <option value="Đắk Lắk" ${location == 'Đắk Lắk' ? 'selected' : ''}>Tỉnh Đắk Lắk</option>
                                                        <option value="Đồng Nai" ${location == 'Đồng Nai' ? 'selected' : ''}>Tỉnh Đồng Nai</option>
                                                        <option value="Tây Ninh" ${location == 'Tây Ninh' ? 'selected' : ''}>Tỉnh Tây Ninh</option>
                                                        <option value="Vĩnh Long" ${location == 'Vĩnh Long' ? 'selected' : ''}>Tỉnh Vĩnh Long</option>
                                                        <option value="Đồng Tháp" ${location == 'Đồng Tháp' ? 'selected' : ''}>Tỉnh Đồng Tháp</option>
                                                        <option value="Cà Mau" ${location == 'Cà Mau' ? 'selected' : ''}>Tỉnh Cà Mau</option>
                                                        <option value="Kiên Giang" ${location == 'Kiên Giang' ? 'selected' : ''}>Tỉnh Kiên Giang</option>
                                                    </select>
                                                </div>



                                                <div class="mb-3">
                                                    <label class="form-label">Lĩnh vực</label>
                                                    <input type="text" class="form-control" id="modalIndustry" name="industry" value="${industry}">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Mã số thuế</label>
                                                    <input type="number" class="form-control" id="modalTaxCode" name="tax" value="${tax}">
                                                </div>



                                                <!--                                                <div class="mb-3">
                                                                                                    <label class="form-label">Logo công ty</label>
                                                                                                    <input type="text" class="form-control" id="modalCompanyLogoUrl" name="companyLogoUrl">
                                                                                                </div>-->

                                                <div class="mb-3">
                                                    <label class="form-label">Mô tả về công ty</label>
                                                    <textarea class="form-control" id="modalCompanyDescription" name="companyDescription" rows="3" >${companyDescription}</textarea>
                                                </div>

                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
                <!-- Password Tab -->
                <div class="tab-pane fade ${activeTab == 'password' ? 'show active' : ''}" id="password" role="tabpanel">
                    <div class="profile-card">
                        <div class="card-body">
                            <div class="section-title">
                                <h5><i class="bi bi-person"></i>Đổi mật khẩu</h5>
                            </div>
                            <c:if test="${not empty message}">
                                <div class="alert alert-success" role="alert">
                                    ${message}
                                </div>
                            </c:if>

                            <c:if test="${not empty errorPass}">
                                <div class="alert alert-danger" role="alert">
                                    ${errorPass}
                                </div>
                            </c:if>
                            <!-- Form nhập đổi mật khẩu -->
                            <form action="EditPassword" method="post" id="change-password-form">
                                <div class="form-group mb-3">
                                    <label for="oldPassword" class="form-label">Mật khẩu cũ</label>
                                    <input type="password" class="form-control w-50" id="oldPassword" name="oldPassword" value="${oldPassword}" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="newPassword" class="form-label">Mật khẩu mới</label>
                                    <input type="password" class="form-control w-50" id="newPassword" name="newPassword" value="${newPassword}" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="confirmPassword" class="form-label">Nhập lại mật khẩu mới</label>
                                    <input type="password" class="form-control w-50" id="confirmPassword" name="confirmPassword" value="${confirmPassword}" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                            </form>

                        </div>
                    </div>
                </div>                                    
                <!--                 Search Candidates Tab 
                                <div class="tab-pane fade" id="search" role="tabpanel">
                                    <div class="search-card">
                                        <h5 class="mb-4"><i class="bi bi-search me-2"></i>Search Candidates</h5>
                
                                         Search Filters 
                                        <div class="search-filters">
                                            <input type="text" class="form-control" placeholder="Search by name, skills, or keywords..."
                                                   style="flex: 2;">
                                            <select class="form-select" style="flex: 1;">
                                                <option value="">All Locations</option>
                                                <option value="san-francisco">San Francisco</option>
                                                <option value="new-york">New York</option>
                                                <option value="remote">Remote</option>
                                            </select>
                                            <select class="form-select" style="flex: 1;">
                                                <option value="">All Experience</option>
                                                <option value="entry">Entry Level</option>
                                                <option value="mid">Mid Level</option>
                                                <option value="senior">Senior Level</option>
                                            </select>
                                            <button class="btn btn-primary">
                                                <i class="bi bi-search me-1"></i> Search
                                            </button>
                                        </div>
                
                                         Search Results 
                                        <div class="search-results">
                                            <div class="search-result">
                                                <div class="d-flex align-items-center">
                                                    <img src="https://randomuser.me/api/portraits/women/24.jpg" alt="Candidate"
                                                         class="candidate-avatar me-3">
                                                    <div class="flex-grow-1">
                                                        <h6 class="mb-1">Sarah Johnson</h6>
                                                        <p class="text-muted mb-1">Senior Full Stack Developer</p>
                                                        <small class="text-muted">San Francisco, CA • 5 years experience</small>
                                                    </div>
                                                    <div class="text-end">
                                                        <button class="btn btn-outline-primary btn-sm me-2">View Profile</button>
                                                        <button class="btn btn-primary btn-sm">Contact</button>
                                                    </div>
                                                </div>
                                                <div class="mt-2">
                                                    <span class="badge bg-light text-dark me-1">React</span>
                                                    <span class="badge bg-light text-dark me-1">Node.js</span>
                                                    <span class="badge bg-light text-dark me-1">Python</span>
                                                    <span class="badge bg-light text-dark">AWS</span>
                                                </div>
                                            </div>
                
                                            <div class="search-result">
                                                <div class="d-flex align-items-center">
                                                    <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Candidate"
                                                         class="candidate-avatar me-3">
                                                    <div class="flex-grow-1">
                                                        <h6 class="mb-1">Michael Chen</h6>
                                                        <p class="text-muted mb-1">Data Scientist</p>
                                                        <small class="text-muted">Remote • 3 years experience</small>
                                                    </div>
                                                    <div class="text-end">
                                                        <button class="btn btn-outline-primary btn-sm me-2">View Profile</button>
                                                        <button class="btn btn-primary btn-sm">Contact</button>
                                                    </div>
                                                </div>
                                                <div class="mt-2">
                                                    <span class="badge bg-light text-dark me-1">Python</span>
                                                    <span class="badge bg-light text-dark me-1">Machine Learning</span>
                                                    <span class="badge bg-light text-dark me-1">SQL</span>
                                                    <span class="badge bg-light text-dark">TensorFlow</span>
                                                </div>
                                            </div>
                
                                            <div class="search-result">
                                                <div class="d-flex align-items-center">
                                                    <img src="https://randomuser.me/api/portraits/women/67.jpg" alt="Candidate"
                                                         class="candidate-avatar me-3">
                                                    <div class="flex-grow-1">
                                                        <h6 class="mb-1">Emily Rodriguez</h6>
                                                        <p class="text-muted mb-1">UX/UI Designer</p>
                                                        <small class="text-muted">New York, NY • 4 years experience</small>
                                                    </div>
                                                    <div class="text-end">
                                                        <button class="btn btn-outline-primary btn-sm me-2">View Profile</button>
                                                        <button class="btn btn-primary btn-sm">Contact</button>
                                                    </div>
                                                </div>
                                                <div class="mt-2">
                                                    <span class="badge bg-light text-dark me-1">Figma</span>
                                                    <span class="badge bg-light text-dark me-1">Adobe XD</span>
                                                    <span class="badge bg-light text-dark me-1">Sketch</span>
                                                    <span class="badge bg-light text-dark">Prototyping</span>
                                                </div>
                                            </div>
                                        </div>
                
                                         Pagination 
                                        <nav class="mt-4">
                                            <ul class="pagination justify-content-center">
                                                <li class="page-item disabled">
                                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                                </li>
                                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                                <li class="page-item">
                                                    <a class="page-link" href="#">Next</a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>-->

                <!--                 Transactions Tab 
                                <div class="tab-pane fade" id="transactions" role="tabpanel">
                                    <div class="profile-card">
                                        <div class="card-body">
                                            <div class="section-title">
                                                <h5><i class="bi bi-credit-card"></i>Transaction History</h5>
                                                <button class="btn btn-primary btn-sm">
                                                    <i class="bi bi-plus me-1"></i> Add Payment Method
                                                </button>
                                            </div>
                
                                             Transaction Filters 
                                            <div class="row mb-4">
                                                <div class="col-md-3">
                                                    <select class="form-select">
                                                        <option value="">All Transactions</option>
                                                        <option value="payment">Payments</option>
                                                        <option value="refund">Refunds</option>
                                                        <option value="promotion">Promotions</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">
                                                    <select class="form-select">
                                                        <option value="">All Status</option>
                                                        <option value="completed">Completed</option>
                                                        <option value="pending">Pending</option>
                                                        <option value="failed">Failed</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="date" class="form-control">
                                                </div>
                                                <div class="col-md-3">
                                                    <button class="btn btn-outline-primary w-100">
                                                        <i class="bi bi-funnel me-1"></i> Filter
                                                    </button>
                                                </div>
                                            </div>
                
                                             Transaction List 
                                            <div class="transaction-item">
                                                <div>
                                                    <h6 class="mb-1">Job Posting - Senior Developer</h6>
                                                    <small class="text-muted">Transaction ID: TXN-001234 • Dec 15, 2023</small>
                                                    <br>
                                                    <span class="status-badge status-success">Completed</span>
                                                </div>
                                                <div class="text-end">
                                                    <div class="transaction-amount negative">-$299.00</div>
                                                    <small class="text-muted">Credit Card</small>
                                                </div>
                                            </div>
                
                                            <div class="transaction-item">
                                                <div>
                                                    <h6 class="mb-1">Premium Promotion</h6>
                                                    <small class="text-muted">Transaction ID: TXN-001235 • Dec 12, 2023</small>
                                                    <br>
                                                    <span class="status-badge status-success">Completed</span>
                                                </div>
                                                <div class="text-end">
                                                    <div class="transaction-amount negative">-$149.00</div>
                                                    <small class="text-muted">Credit Card</small>
                                                </div>
                                            </div>
                
                                            <div class="transaction-item">
                                                <div>
                                                    <h6 class="mb-1">Refund - Cancelled Job</h6>
                                                    <small class="text-muted">Transaction ID: TXN-001236 • Dec 10, 2023</small>
                                                    <br>
                                                    <span class="status-badge status-pending">Processing</span>
                                                </div>
                                                <div class="text-end">
                                                    <div class="transaction-amount positive">+$199.00</div>
                                                    <small class="text-muted">Refund</small>
                                                </div>
                                            </div>
                
                                            <div class="transaction-item">
                                                <div>
                                                    <h6 class="mb-1">Job Posting - UX Designer</h6>
                                                    <small class="text-muted">Transaction ID: TXN-001237 • Dec 8, 2023</small>
                                                    <br>
                                                    <span class="status-badge status-failed">Failed</span>
                                                </div>
                                                <div class="text-end">
                                                    <div class="transaction-amount negative">-$299.00</div>
                                                    <small class="text-muted">Credit Card</small>
                                                </div>
                                            </div>
                
                                            <div class="transaction-item">
                                                <div>
                                                    <h6 class="mb-1">Featured Listing Upgrade</h6>
                                                    <small class="text-muted">Transaction ID: TXN-001238 • Dec 5, 2023</small>
                                                    <br>
                                                    <span class="status-badge status-success">Completed</span>
                                                </div>
                                                <div class="text-end">
                                                    <div class="transaction-amount negative">-$99.00</div>
                                                    <small class="text-muted">Credit Card</small>
                                                </div>
                                            </div>
                
                                             Transaction Summary 
                                            <div class="row mt-4 pt-4 border-top">
                                                <div class="col-md-4">
                                                    <div class="text-center">
                                                        <h6 class="text-muted">Total Spent</h6>
                                                        <h4 class="text-danger">$2,450.00</h4>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="text-center">
                                                        <h6 class="text-muted">Total Refunds</h6>
                                                        <h4 class="text-success">$199.00</h4>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="text-center">
                                                        <h6 class="text-muted">Net Amount</h6>
                                                        <h4 class="text-primary">$2,251.00</h4>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>-->
            </div>
        </div>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


        <script>
                                                    const editModal = document.getElementById('editPersonalModal');

                                                    editModal.addEventListener('show.bs.modal', function (event) {
                                                        const button = event.relatedTarget;

                                                        // Lấy dữ liệu từ nút
//                const recruiterId = button.getAttribute('data-recruiterId');
                                                        const fullName = button.getAttribute('data-fullName');
                                                        const position = button.getAttribute('data-position');
                                                        const phone = button.getAttribute('data-phone');
//                const address = button.getAttribute('data-address');
                                                        const imageUrl = button.getAttribute('data-imageUrl');

                                                        // Đổ dữ liệu vào form
//                document.getElementById('modalRecruiterId').value = recruiterId;
                                                        document.getElementById('modalFullName').value = fullName;
                                                        document.getElementById('modalPosition').value = position;
                                                        document.getElementById('modalPhone').value = phone;
//                document.getElementById('modalAddress').value = address;
//                document.getElementById('modalImageUrl').value = imageUrl;
                                                    });
        </script>
        <script>
            const companyModal = document.getElementById('editCompanyModal');

            companyModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;

//                document.getElementById('modalRecruiterId').value = button.getAttribute('data-recruiterId');
                document.getElementById('modalCompanyName').value = button.getAttribute('data-companyName');
                document.getElementById('modalWebsite').value = button.getAttribute('data-website');
//                document.getElementById('modalCompanyPhone').value = button.getAttribute('data-companyPhone');
                document.getElementById('modalCompanyAddress').value = button.getAttribute('data-companyAddress');
//                document.getElementById('modalCompanySize').value = button.getAttribute('data-companySize');
                document.getElementById('modalIndustry').value = button.getAttribute('data-industry');
//                document.getElementById('modalFounded').value = button.getAttribute('data-founded');
//                document.getElementById('modalCompanyLogoUrl').value = button.getAttribute('data-companyLogoUrl');
                document.getElementById('modalCompanyDescription').value = button.getAttribute('data-companyDescription');
                document.getElementById('modalTaxCode').value = button.getAttribute('data-tax');
//                document.getElementById('modalCompanyMission').value = button.getAttribute('data-companyMission');
//                document.getElementById('modalCoreValue').value = button.getAttribute('data-coreValue');
//                document.getElementById('modalWorkCulture').value = button.getAttribute('data-workCulture');
            });
        </script>
        <c:if test="${openEditModalCompany == true}">
            <script>
                const modal = new bootstrap.Modal(document.getElementById('editCompanyModal'));
                modal.show();
            </script>
        </c:if>
        <c:if test="${openEditModalPerson == true}">
            <script>
                const modal = new bootstrap.Modal(document.getElementById('editPersonalModal'));
                modal.show();
            </script>
        </c:if>


    </body>

</html>

