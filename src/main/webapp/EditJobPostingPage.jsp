<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Job Post - Improved Design</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #0046aa; /* VietnamWorks blue */
                --primary-dark: #0095c3;
                --secondary-color: #1a4f8b;
                --accent-color: #ff9e1b;
                --success-color: #28a745;
                --warning-color: #ffc107;
                --danger-color: #dc3545;
                --light-bg: #f5f9fc;
                --text-color: #333;
                --border-radius: 6px;
                --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            body {
                font-family: 'Roboto', sans-serif;
                background-color: var(--light-bg);
                color: var(--text-color);
            }

            .navbar {
                background-color: var(--primary-color);
                box-shadow: var(--box-shadow);
            }

            .navbar-brand {
                font-weight: 700;
                color: white !important;
            }

            .nav-link {
                color: white !important;
                font-weight: 500;
            }

            .header-section {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 2rem 0;
                margin-bottom: 2rem;
            }

            .card {
                border: none;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                margin-bottom: 1.5rem;
                overflow: hidden;
            }

            .card-header {
                background-color: var(--primary-color);
                color: white;
                font-weight: 500;
                padding: 1rem 1.25rem;
                border-bottom: none;
                border-radius: var(--border-radius) var(--border-radius) 0 0 !important;
            }

            .card-header h5 {
                margin-bottom: 0;
                font-weight: 600;
            }

            .card-body {
                padding: 1.5rem;
            }

            .form-section {
                margin-bottom: 1.5rem;
                padding-bottom: 1.5rem;
                border-bottom: 1px solid #eee;
            }

            .form-section:last-child {
                border-bottom: none;
                margin-bottom: 0;
                padding-bottom: 0;
            }

            .section-title {
                color: var(--primary-color);
                font-weight: 600;
                margin-bottom: 1.25rem;
                display: flex;
                align-items: center;
            }

            .section-title i {
                margin-right: 0.5rem;
            }

            .form-label {
                font-weight: 500;
                color: #555;
                margin-bottom: 0.5rem;
            }

            .form-control, .form-select {
                border-radius: var(--border-radius);
                padding: 0.6rem 1rem;
                border: 1px solid #ddd;
                transition: all 0.2s ease;
            }

            .form-control:focus, .form-select:focus {
                box-shadow: 0 0 0 3px rgba(0, 185, 242, 0.25);
                border-color: var(--primary-color);
            }

            .btn {
                border-radius: var(--border-radius);
                padding: 0.6rem 1.5rem;
                font-weight: 500;
                transition: all 0.2s ease;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

            .btn-success {
                background-color: var(--success-color);
                border-color: var(--success-color);
            }

            .btn-warning {
                background-color: var(--warning-color);
                border-color: var(--warning-color);
                color: #212529;
            }

            .btn-danger {
                background-color: var(--danger-color);
                border-color: var(--danger-color);
            }

            .btn-outline-secondary {
                border-color: #ddd;
                color: #666;
            }

            .btn-outline-secondary:hover {
                background-color: #f5f5f5;
                color: #333;
                border-color: #ccc;
            }

            .required-field::after {
                content: "*";
                color: #dc3545;
                margin-left: 4px;
            }

            .status-badge {
                padding: 0.4rem 0.8rem;
                font-weight: 500;
                font-size: 0.75rem;
                border-radius: 20px;
            }

            .status-active {
                background-color: var(--success-color);
                color: white;
            }

            .status-inactive {
                background-color: var(--warning-color);
                color: #212529;
            }

            .status-closed {
                background-color: var(--danger-color);
                color: white;
            }

            .stats-row {
                display: flex;
                flex-wrap: wrap;
                margin: -0.5rem;
            }

            .stat-box {
                flex: 1;
                min-width: 120px;
                background-color: white;
                border-radius: var(--border-radius);
                padding: 1rem;
                margin: 0.5rem;
                text-align: center;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                border: 1px solid #eee;
                transition: all 0.2s ease;
            }

            .stat-box:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                border-color: var(--primary-color);
            }

            .stat-number {
                font-size: 1.75rem;
                font-weight: 700;
                color: var(--primary-color);
                line-height: 1.2;
            }

            .stat-label {
                font-size: 0.875rem;
                color: #666;
                margin-top: 0.25rem;
            }

            .candidate-stage {
                display: flex;
                align-items: center;
                padding: 1rem;
                border-bottom: 1px solid #eee;
            }

            .candidate-stage:last-child {
                border-bottom: none;
            }

            .stage-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: rgba(0, 185, 242, 0.1);
                color: var(--primary-color);
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 1rem;
                flex-shrink: 0;
            }

            .stage-content {
                flex: 1;
            }

            .stage-title {
                font-weight: 600;
                margin-bottom: 0.25rem;
            }

            .stage-count {
                background-color: var(--primary-color);
                color: white;
                padding: 0.25rem 0.5rem;
                border-radius: 4px;
                font-size: 0.75rem;
                font-weight: 600;
                margin-left: 0.5rem;
            }

            .stage-description {
                font-size: 0.875rem;
                color: #666;
                margin-bottom: 0;
            }

            .action-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
            }

            .action-buttons .btn {
                flex: 1;
                min-width: 120px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .action-buttons .btn i {
                margin-right: 0.5rem;
            }

            .quick-action {
                display: flex;
                align-items: center;
                padding: 1rem;
                border-bottom: 1px solid #eee;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .quick-action:last-child {
                border-bottom: none;
            }

            .quick-action:hover {
                background-color: rgba(0, 185, 242, 0.05);
            }

            .action-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: rgba(0, 185, 242, 0.1);
                color: var(--primary-color);
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 1rem;
                flex-shrink: 0;
            }

            .action-content {
                flex: 1;
            }

            .action-title {
                font-weight: 600;
                margin-bottom: 0.25rem;
            }

            .action-description {
                font-size: 0.875rem;
                color: #666;
                margin-bottom: 0;
            }

            .footer {
                background-color: var(--secondary-color);
                color: white;
                padding: 2rem 0;
                margin-top: 3rem;
            }

            .footer h5 {
                font-weight: 600;
                margin-bottom: 1rem;
            }

            .footer a {
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                transition: all 0.2s ease;
            }

            .footer a:hover {
                color: white;
                text-decoration: underline;
            }

            .footer-bottom {
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                padding-top: 1rem;
                margin-top: 2rem;
            }

            @media (max-width: 767.98px) {
                .header-section {
                    padding: 1.5rem 0;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .action-buttons .btn {
                    width: 100%;
                }

                .stats-row {
                    flex-direction: column;
                }

                .stat-box {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="bi bi-briefcase-fill me-2"></i>JobBoard
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Jobs</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Candidates</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Reports</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Header Section -->
        <div class="header-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1>Chỉnh sửa bài đăng tuyển dụng</h1>
                        <p class="lead mb-0">Cập nhật thông tin bài tuyển dụng</p>
                    </div>
                    <div class="col-md-4 text-md-end mt-3 mt-md-0">
                        <a href="ManageJobPost" class="btn btn-light">
                            <i class="bi bi-arrow-left me-2"></i>Quay lại quản lí bài đăng
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <!-- Main Content -->
                <!-- Job Posting Form -->
                <div class="col-lg-8 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="bi bi-plus-circle me-2"></i>Chỉnh sửa bài đăng tuyển dụng</h5>
                        </div>
                        <div class="card-body p-4">
                            <c:if test="${not empty errors}">
                                <div class="alert alert-danger">
                                    <ul>
                                        <c:forEach var="err" items="${errors}">
                                            <li>${err}</li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </c:if>    
                            <%--
                            ${requestScope.searchONE}
                            ${requestScope.positionONE}
                            ${requestScope.locationONE}
                            ${requestScope.sortONE}
                            ${requestScope.pageONE}
                            ${requestScope.numONE}
                            <c:forEach var="stat" items="${selectedStatuses}">
                                   ${stat}
                                </c:forEach>

                                <c:forEach var="jobType" items="${selectedJobTypes}">
                                    ${jobType}
                                </c:forEach>

                                <c:forEach var="exp" items="${selectedExperienceLevels}">
                                    ${exp}
                                </c:forEach>

                                <c:forEach var="ind" items="${selectedIndustries}">
                                    ${ind}
                                </c:forEach>
                            --%>
                            <form action="EditJobPostingPage" method="post"> 

                                <!-- Hidden inputs to preserve filter states -->
                                <input type="hidden" name="searchONE" value="${requestScope.searchONE}">
                                <input type="hidden" name="positionONE" value="${requestScope.positionONE}">
                                <input type="hidden" name="locationONE" value="${requestScope.locationONE}">
                                <input type="hidden" name="sortONE" value="${requestScope.sortONE}">
                                <input type="hidden" name="pageONE" value="${requestScope.pageONE}">
                                <input type="hidden" name="numONE" value="${requestScope.numONE}">

                                <c:forEach var="stat" items="${selectedStatuses}">
                                    <input type="hidden" name="statusONE" value="${stat}" />
                                </c:forEach>

                                <c:forEach var="jobType" items="${selectedJobTypes}">
                                    <input type="hidden" name="jobTypeONE" value="${jobType}" />
                                </c:forEach>

                                <c:forEach var="exp" items="${selectedExperienceLevels}">
                                    <input type="hidden" name="experienceLevelONE" value="${exp}" />
                                </c:forEach>

                                <c:forEach var="ind" items="${selectedIndustries}">
                                    <input type="hidden" name="industryONE" value="${ind}" />
                                </c:forEach>
                                <!-- Basic Information -->
                                <div class="mb-4">
                                    <h5 class="border-bottom pb-2">Thông tin cơ bản</h5>
                                    <input type="hidden" name="jobId" value="${jobPost.getJobId()}">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="jobTitle" class="form-label required-field">Tiêu đề công việc</label>
                                            <input type="text" class="form-control" id="jobTitle" name="jobTitle" value="${not empty jobTitle ? jobTitle : jobPost.getTitle()}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="industry" class="form-label required-field">Ngành nghề</label>
                                            <select class="form-select" id="industry" name="industry" required>
                                                <option value="" disabled ${empty industryID and empty jobPost.getIndustry().getIndustryId() ? "selected" : ""}>-- Chọn ngành nghề --</option>
                                                <c:forEach var="a" items="${listIndustries}">
                                                    <option value="${a.getIndustryId()}"
                                                            ${a.getIndustryId() == (not empty industryID ? industryID : jobPost.getIndustry().getIndustryId()) ? 'selected' : ''}>
                                                        ${a.getNameIndustry()}
                                                    </option>
                                                </c:forEach>

                                            </select>
                                        </div> 
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="jobPosition" class="form-label required-field">Vị trí công việc</label>
                                            <input type="text" class="form-control" id="jobPosition" name="jobPosition" value="${not empty jobPosition ? jobPosition : jobPost.getJobPosition()}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="experienceLevel" class="form-label required-field">Cấp độ kinh nghiệm</label>
                                            <select class="form-select" id="experienceLevel" name="experienceLevel" required>
                                                <option value="" disabled ${empty experienceLevel and empty jobPost.getExperienceLevel() ? "selected" : ""}>Chọn cấp độ kinh nghiệm</option>
                                                <option value="Mới vào nghề (0-1 năm)" ${'Mới vào nghề (0-1 năm)' == (not empty experienceLevel ? experienceLevel : jobPost.getExperienceLevel()) ? 'selected' : ''}>Mới vào nghề (0-1 năm)</option>
                                                <option value="Nhân viên sơ cấp (1-3 năm)" ${'Nhân viên sơ cấp (1-3 năm)' == (not empty experienceLevel ? experienceLevel : jobPost.getExperienceLevel()) ? 'selected' : ''}>Nhân viên sơ cấp (1-3 năm)</option>
                                                <option value="Trung cấp (3-5 năm)" ${'Trung cấp (3-5 năm)' == (not empty experienceLevel ? experienceLevel : jobPost.getExperienceLevel()) ? 'selected' : ''}>Trung cấp (3-5 năm)</option>
                                                <option value="Cao cấp (trên 5 năm)" ${'Cao cấp (trên 5 năm)' == (not empty experienceLevel ? experienceLevel : jobPost.getExperienceLevel()) ? 'selected' : ''}>Cao cấp (trên 5 năm)</option>
                                                <option value="Quản lý" ${'Quản lý' == (not empty experienceLevel ? experienceLevel : jobPost.getExperienceLevel()) ? 'selected' : ''}>Quản lý</option>
                                                <option value="Điều hành" ${'Điều hành' == (not empty experienceLevel ? experienceLevel : jobPost.getExperienceLevel()) ? 'selected' : ''}>Điều hành</option>
                                            </select>
                                        </div>
                                    </div>   


                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="location" class="form-label required-field">Địa điểm</label>
                                            <!-- <input type="text" class="form-control" id="location" name="location" placeholder="City, Province or Remote" required>-->
                                            <select name="location" id="location" required
                                                    class="form-select block w-full max-w-sm p-2 border border-gray-300 rounded-md text-sm">
                                                <option value="">-- Chọn tỉnh/thành phố --</option>

                                                <!-- Thành phố trước -->
                                                <option value="Hà Nội" ${'Hà Nội' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Thành phố Hà Nội</option>
                                                <option value="Hồ Chí Minh" ${'Hồ Chí Minh' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Thành phố Hồ Chí Minh</option>
                                                <option value="Đà Nẵng" ${'Đà Nẵng' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Thành phố Đà Nẵng</option>
                                                <option value="Hải Phòng" ${'Hải Phòng' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Thành phố Hải Phòng</option>
                                                <option value="Cần Thơ" ${'Cần Thơ' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Thành phố Cần Thơ</option>
                                                <option value="Huế" ${'Huế' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Thành phố Huế</option>

                                                <!-- Các tỉnh -->
                                                <option value="Lai Châu" ${'Lai Châu' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Lai Châu</option>
                                                <option value="Điện Biên" ${'Điện Biên' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Điện Biên</option>
                                                <option value="Sơn La" ${'Sơn La' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Sơn La</option>
                                                <option value="Lạng Sơn" ${'Lạng Sơn' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Lạng Sơn</option>
                                                <option value="Quảng Ninh" ${'Quảng Ninh' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Quảng Ninh</option>
                                                <option value="Thanh Hoá" ${'Thanh Hoá' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Thanh Hoá</option>
                                                <option value="Nghệ An" ${'Nghệ An' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Nghệ An</option>
                                                <option value="Hà Tĩnh" ${'Hà Tĩnh' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Hà Tĩnh</option>
                                                <option value="Cao Bằng" ${'Cao Bằng' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Cao Bằng</option>
                                                <option value="Tuyên Quang" ${'Tuyên Quang' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Tuyên Quang</option>
                                                <option value="Lào Cai" ${'Lào Cai' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Lào Cai</option>
                                                <option value="Thái Nguyên" ${'Thái Nguyên' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Thái Nguyên</option>
                                                <option value="Phú Thọ" ${'Phú Thọ' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Phú Thọ</option>
                                                <option value="Bắc Ninh" ${'Bắc Ninh' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Bắc Ninh</option>
                                                <option value="Hưng Yên" ${'Hưng Yên' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Hưng Yên</option>
                                                <option value="Ninh Bình" ${'Ninh Bình' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Ninh Bình</option>
                                                <option value="Quảng Trị" ${'Quảng Trị' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Quảng Trị</option>
                                                <option value="Quảng Ngãi" ${'Quảng Ngãi' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Quảng Ngãi</option>
                                                <option value="Gia Lai" ${'Gia Lai' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Gia Lai</option>
                                                <option value="Khánh Hoà" ${'Khánh Hoà' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Khánh Hoà</option>
                                                <option value="Lâm Đồng" ${'Lâm Đồng' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Lâm Đồng</option>
                                                <option value="Đắk Lắk" ${'Đắk Lắk' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Đắk Lắk</option>
                                                <option value="Đồng Nai" ${'Đồng Nai' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Đồng Nai</option>
                                                <option value="Tây Ninh" ${'Tây Ninh' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Tây Ninh</option>
                                                <option value="Vĩnh Long" ${'Vĩnh Long' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Vĩnh Long</option>
                                                <option value="Đồng Tháp" ${'Đồng Tháp' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Đồng Tháp</option>
                                                <option value="Cà Mau" ${'Cà Mau' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Cà Mau</option>
                                                <option value="Kiên Giang" ${'Kiên Giang' == (not empty location ? location : jobPost.getLocation()) ? 'selected' : ''}>Tỉnh Kiên Giang</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="jobType" class="form-label required-field">Hình thức làm việc</label>
                                            <select class="form-select" id="jobType" name="jobType" required>
                                                <option value="" disabled ${empty jobType and empty jobPost.getJobType() ? 'selected' : ''}>Chọn loại công việc</option>
                                                <option value="Toàn thời gian" ${'Toàn thời gian' == (not empty jobType ? jobType : jobPost.getJobType()) ? 'selected' : ''}>Toàn thời gian</option>
                                                <option value="Bán thời gian" ${'Bán thời gian' == (not empty jobType ? jobType : jobPost.getJobType()) ? 'selected' : ''}>Bán thời gian</option>
                                                <option value="Hợp đồng" ${'Hợp đồng' == (not empty jobType ? jobType : jobPost.getJobType()) ? 'selected' : ''}>Hợp đồng</option>
                                                <option value="Tự do" ${'Tự do' == (not empty jobType ? jobType : jobPost.getJobType()) ? 'selected' : ''}>Tự do</option>
                                                <option value="Thực tập" ${'Thực tập' == (not empty jobType ? jobType : jobPost.getJobType()) ? 'selected' : ''}>Thực tập</option>

                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="salaryMin" class="form-label required-field">Lương tối thiểu (đồng)</label>
                                            <input type="text" class="form-control" id="salaryMin" name="salaryMin" value="${not empty salaryMin ? salaryMin : jobPost.getFormattedSalaryMin()}" placeholder="VD: 1.000.000" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="salaryMax" class="form-label required-field">Lương tối đa (đồng)</label>
                                            <input type="text" class="form-control" id="salaryMax" name="salaryMax" value="${not empty salaryMax ? salaryMax : jobPost.getFormattedSalaryMax()}" placeholder="VD: 2.000.000" required>
                                        </div>
                                    </div>

                                </div>

                                <!-- Job Details -->
                                <div class="mb-4">
                                    <h5 class="border-bottom pb-2">Chi tiết công việc</h5>

                                    <div class="mb-3">
                                        <label for="jobDescription" class="form-label required-field">Mô tả công việc</label>
                                        <textarea class="form-control" id="jobDescription" name="jobDescription" rows="15" required minlength="30" placeholder="Tối thiểu phải có 30 ký tự">${not empty jobDescription ? jobDescription : jobPost.getDescription()}</textarea>
                                        <div class="form-text">Mô tả vai trò, trách nhiệm và những công việc mà ứng viên sẽ thực hiện.</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="requirements" class="form-label required-field">Yêu cầu</label>
                                        <textarea class="form-control" id="requirements" name="requirements" rows="15" required >${not empty requirements ? requirements : jobPost.getRequirement()}</textarea>
                                        <div class="form-text">Liệt kê các kỹ năng, trình độ và kinh nghiệm yêu cầu.</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="benefits" class="form-label required-field">Quyền lợi</label>
                                        <textarea class="form-control" id="benefits" name="benefits" rows="15" placeholder="Ví dụ: Bảo hiểm y tế, lương tháng 13, v.v." required>${not empty benefits ? benefits : jobPost.getBenefit()}</textarea>
                                    </div>
                                </div>

                                <!-- Contact Information -->
                                <div class="mb-4">
                                    <h5 class="border-bottom pb-2">Thời hạn</h5>

                                    <div class="row mb-3">
                                        <!--                                        <div class="col-md-6">
                                                                                    <label for="contactEmail" class="form-label">Contact Email</label>
                                                                                    <input type="email" class="form-control" id="contactEmail" name="contactEmail">
                                                                                </div>-->
                                        <div class="col-md-6">
                                            <label for="applicationDeadline" class="form-label required-field">Hạn cuối nhận hồ sơ</label>
                                            <input type="date" class="form-control" id="applicationDeadline" name="applicationDeadline" value="${not empty applicationDeadline ? applicationDeadline : jobPost.dateDaealine()}" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between mt-4">
                                    <!--<button type="button" class="btn btn-outline-secondary">Save as Draft</button>-->
                                    <button type="submit" class="btn btn-primary" style="margin-left: 35%;margin-top: 15px;">
                                        <i class="bi bi-check-circle me-2"></i>Cập nhật tin tuyển dụng
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>  
                <!-- Sidebar -->
                <div class="col-lg-4">
                    <!-- Candidate Pipeline -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="bi bi-funnel me-2"></i>Candidate Pipeline</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="candidate-stage">
                                <div class="stage-icon">
                                    <i class="bi bi-file-earmark-person"></i>
                                </div>
                                <div class="stage-content">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="stage-title mb-0">New Applications</h6>
                                        <span class="stage-count">12</span>
                                    </div>
                                    <p class="stage-description">Applications waiting for review</p>
                                </div>
                            </div>
                            <div class="candidate-stage">
                                <div class="stage-icon">
                                    <i class="bi bi-eye"></i>
                                </div>
                                <div class="stage-content">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="stage-title mb-0">Under Review</h6>
                                        <span class="stage-count">8</span>
                                    </div>
                                    <p class="stage-description">Applications being evaluated</p>
                                </div>
                            </div>
                            <div class="candidate-stage">
                                <div class="stage-icon">
                                    <i class="bi bi-star"></i>
                                </div>
                                <div class="stage-content">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="stage-title mb-0">Shortlisted</h6>
                                        <span class="stage-count">5</span>
                                    </div>
                                    <p class="stage-description">Candidates selected for interviews</p>
                                </div>
                            </div>
                            <div class="candidate-stage">
                                <div class="stage-icon">
                                    <i class="bi bi-calendar-check"></i>
                                </div>
                                <div class="stage-content">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="stage-title mb-0">Interview Scheduled</h6>
                                        <span class="stage-count">3</span>
                                    </div>
                                    <p class="stage-description">Interviews arranged with candidates</p>
                                </div>
                            </div>
                            <div class="candidate-stage">
                                <div class="stage-icon">
                                    <i class="bi bi-trophy"></i>
                                </div>
                                <div class="stage-content">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="stage-title mb-0">Final Round</h6>
                                        <span class="stage-count">1</span>
                                    </div>
                                    <p class="stage-description">Top candidates in final evaluation</p>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-center">
                            <a href="#" class="btn btn-primary w-100">Manage Candidates</a>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="bi bi-lightning me-2"></i>Quick Actions</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="quick-action" onclick="shareJob()">
                                <div class="action-icon">
                                    <i class="bi bi-share"></i>
                                </div>
                                <div class="action-content">
                                    <h6 class="action-title">Share Job</h6>
                                    <p class="action-description">Share on social media or via email</p>
                                </div>
                            </div>
                            <div class="quick-action" onclick="promoteJob()">
                                <div class="action-icon">
                                    <i class="bi bi-megaphone"></i>
                                </div>
                                <div class="action-content">
                                    <h6 class="action-title">Promote Job</h6>
                                    <p class="action-description">Boost visibility with premium features</p>
                                </div>
                            </div>
                            <div class="quick-action" onclick="downloadReport()">
                                <div class="action-icon">
                                    <i class="bi bi-file-earmark-bar-graph"></i>
                                </div>
                                <div class="action-content">
                                    <h6 class="action-title">Download Report</h6>
                                    <p class="action-description">Get detailed performance analytics</p>
                                </div>
                            </div>
                            <div class="quick-action" onclick="exportCandidates()">
                                <div class="action-icon">
                                    <i class="bi bi-file-earmark-excel"></i>
                                </div>
                                <div class="action-content">
                                    <h6 class="action-title">Export Candidates</h6>
                                    <p class="action-description">Download candidate list as Excel</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Job Tips -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="bi bi-lightbulb me-2"></i>Job Posting Tips</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <h6><i class="bi bi-check-circle-fill text-success me-2"></i>Optimize Your Title</h6>
                                <p class="small text-muted">Use industry-standard job titles to improve searchability.</p>
                            </div>
                            <div class="mb-3">
                                <h6><i class="bi bi-check-circle-fill text-success me-2"></i>Be Specific</h6>
                                <p class="small text-muted">Clearly describe responsibilities and requirements to attract qualified candidates.</p>
                            </div>
                            <div>
                                <h6><i class="bi bi-check-circle-fill text-success me-2"></i>Highlight Benefits</h6>
                                <p class="small text-muted">Emphasize unique perks to make your job stand out from competitors.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 mb-4 mb-md-0">
                        <h5>JobBoard</h5>
                        <p class="mb-0">Find the best talent for your company with our easy-to-use job posting platform.</p>
                    </div>
                    <div class="col-md-3 col-6">
                        <h5>Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="#">Dashboard</a></li>
                            <li><a href="#">Post a Job</a></li>
                            <li><a href="#">Find Candidates</a></li>
                            <li><a href="#">Pricing</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3 col-6">
                        <h5>Contact</h5>
                        <ul class="list-unstyled">
                            <li><i class="bi bi-envelope me-2"></i>support@jobboard.com</li>
                            <li><i class="bi bi-telephone me-2"></i>(123) 456-7890</li>
                        </ul>
                    </div>
                </div>
                <div class="footer-bottom text-center">
                    <p class="mb-0">&copy; 2023 JobBoard. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                // Form submission handler
                                document.getElementById('editJobForm').addEventListener('submit', function (e) {
                                    e.preventDefault();
                                    alert('Job post updated successfully!');
                                });

        </script>
        <script>
            function formatNumberInput(input) {
                input.addEventListener('input', function (e) {
                    let value = this.value.replace(/\D/g, ''); // Xoá hết ký tự không phải số
                    if (value === '') {
                        this.value = '';
                        return;
                    }
                    this.value = Number(value).toLocaleString('vi-VN'); // Thêm dấu chấm mỗi 3 số
                });
            }

// Khi submit form, xóa dấu chấm để gửi dữ liệu chuẩn
            document.addEventListener("DOMContentLoaded", function () {
                const salaryMin = document.getElementById("salaryMin");
                const salaryMax = document.getElementById("salaryMax");

                formatNumberInput(salaryMin);
                formatNumberInput(salaryMax);

                document.querySelector("form").addEventListener("submit", function () {
                    salaryMin.value = salaryMin.value.replace(/\./g, '');
                    salaryMax.value = salaryMax.value.replace(/\./g, '');
                });
            });
        </script>
    </body>
</html>
