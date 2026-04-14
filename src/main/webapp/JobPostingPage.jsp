<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Job Posting - VietnamWorks Style</title>
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
            }

            .card-header {
                background-color: var(--primary-color);
                color: white;
                font-weight: 500;
                padding: 1rem 1.25rem;
                border-bottom: none;
                border-radius: var(--border-radius) var(--border-radius) 0 0 !important;
            }

            .form-label {
                font-weight: 500;
                color: #555;
            }

            .form-control, .form-select {
                border-radius: var(--border-radius);
                padding: 0.6rem 1rem;
                border: 1px solid #ddd;
            }

            .form-control:focus, .form-select:focus {
                box-shadow: 0 0 0 3px rgba(0, 185, 242, 0.25);
                border-color: var(--primary-color);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                padding: 0.6rem 1.5rem;
                font-weight: 500;
                border-radius: var(--border-radius);
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

            .btn-outline-secondary {
                border-color: #ddd;
                color: #666;
                font-weight: 500;
                border-radius: var(--border-radius);
                padding: 0.6rem 1.5rem;
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

            .activity-item {
                padding: 1rem;
                border-bottom: 1px solid #eee;
            }

            .activity-item:last-child {
                border-bottom: none;
            }

            .activity-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: rgba(0, 185, 242, 0.1);
                color: var(--primary-color);
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 1rem;
            }

            .activity-time {
                font-size: 0.8rem;
                color: #888;
            }

            .activity-title {
                font-weight: 500;
                margin-bottom: 0.25rem;
            }

            .activity-text {
                font-size: 0.9rem;
                color: #666;
                margin-bottom: 0;
            }

            .badge-custom {
                padding: 0.4rem 0.8rem;
                font-weight: 500;
                font-size: 0.75rem;
                border-radius: 20px;
            }

            .badge-posted {
                background-color: #28a745;
            }

            .badge-pending {
                background-color: #ffc107;
                color: #212529;
            }

            .badge-closed {
                background-color: #dc3545;
            }

            .footer {
                background-color: var(--secondary-color);
                color: white;
                padding: 2rem 0;
                margin-top: 3rem;
            }

            .footer h5 {
                font-weight: 500;
                margin-bottom: 1rem;
            }

            .footer a {
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
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
            .activity-item {
                transition: background-color 0.3s ease;
            }

            .activity-item:hover {
                background-color: #f1f1f1; /* màu xám nhạt, bạn có thể đổi thành màu đen nhẹ nếu muốn */
                cursor: pointer;
            }
            @media (max-width: 767.98px) {
                .header-section {
                    padding: 1.5rem 0;
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
                            <a class="nav-link active" href="#">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="view-job-applicants">Jobs</a>
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
                        <h1>Đăng tin tuyển dụng mới</h1>
                        <p class="lead mb-0">Tạo bài đăng tuyển dụng nhằm tìm kiếm ứng viên phù hợp nhất cho vị trí của bạn</p>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <a href="ManageJobPost" class="btn btn-light">
                            <i class="bi bi-arrow-right me-2"></i>Quản lí bài đăng
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${not empty errors}">
            <div class="alert alert-danger">
                <ul>
                    <c:forEach var="err" items="${errors}">
                        <li>${err}</li>
                        </c:forEach>
                </ul>
            </div>
        </c:if>

        <div class="container">
            <div class="row">
                <!-- Job Posting Form -->
                <div class="col-lg-8 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="bi bi-plus-circle me-2"></i>Tạo tin tuyển dụng mới</h5>
                        </div>
                        <c:if test="${not empty message}">
                            <div id="alertSuccess" class="alert alert-success">
                                <li>${message}</li>
                            </div>
                            <script>
                                setTimeout(function () {
                                    var alert = document.getElementById('alertSuccess');
                                    if (alert) {
                                        alert.style.display = 'none';
                                    }
                                }, 2000); // 2000 milliseconds = 2 seconds
                            </script>
                        </c:if>
                        <div class="card-body p-4">
                            <form action="JobPostingPage" method="post"> 
                                <!-- Basic Information -->
                                <div class="mb-4">
                                    <h5 class="border-bottom pb-2">Thông tin cơ bản</h5>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="jobTitle" class="form-label required-field">Tiêu đề công việc</label>
                                            <input type="text" class="form-control" id="jobTitle" name="jobTitle" value="${jobTitle}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="industry" class="form-label required-field">Ngành nghề</label>
                                            <select class="form-select" id="industry" name="industry" required>
                                                <option value="" disabled ${empty industryID ? "selected" : ""}>-- Chọn ngành nghề --</option>
                                                <c:forEach var="a" items="${listIndustries}">
                                                    <option value="${a.getIndustryId()}" ${a.getIndustryId() == industryID ? 'selected' : ''}>${a.getNameIndustry()}</option>
                                                </c:forEach>
                                                <!--                                                <option value="1">Information Technology</option>
                                                                                                <option value="2">Finance</option>
                                                                                                <option value="3">Healthcare</option>-->
                                                <!-- Thêm các ngành nghề khác -->
                                            </select>
                                        </div> 
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="jobPosition" class="form-label required-field">Vị trí công việc</label>
                                            <input type="text" class="form-control" id="jobPosition" name="jobPosition" value="${jobPosition}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="experienceLevel" class="form-label required-field">Cấp độ kinh nghiệm</label>
                                            <select class="form-select" id="experienceLevel" name="experienceLevel" required>
                                                <option value="" disabled ${empty experienceLevel ? "selected" : ""}>Chọn cấp độ kinh nghiệm</option>
                                                <option value="Mới vào nghề (0-1 năm)" ${experienceLevel == 'Mới vào nghề (0-1 năm)' ? 'selected' : ''}>Mới vào nghề (0-1 năm)</option>
                                                <option value="Nhân viên sơ cấp (1-3 năm)" ${experienceLevel == 'Nhân viên sơ cấp (1-3 năm)' ? 'selected' : ''}>Nhân viên sơ cấp (1-3 năm)</option>
                                                <option value="Trung cấp (3-5 năm)" ${experienceLevel == 'Trung cấp (3-5 năm)' ? 'selected' : ''}>Trung cấp (3-5 năm)</option>
                                                <option value="Cao cấp (trên 5 năm)" ${experienceLevel == 'Cao cấp (trên 5 năm)' ? 'selected' : ''}>Cao cấp (trên 5 năm)</option>
                                                <option value="Quản lý" ${experienceLevel == 'Quản lý' ? 'selected' : ''}>Quản lý</option>
                                                <option value="Điều hành" ${experienceLevel == 'Điều hành' ? 'selected' : ''}>Điều hành</option>
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
                                                <option value="Hà Nội" ${location == 'Hà Nội' ? 'selected' : ''}>Thành phố Hà Nội</option>
                                                <option value="Hồ Chí Minh" ${location == 'Hồ Chí Minh' ? 'selected' : ''}>Thành phố Hồ Chí Minh</option>
                                                <option value="Đà Nẵng" ${location == 'Đà Nẵng' ? 'selected' : ''}>Thành phố Đà Nẵng</option>
                                                <option value="Hải Phòng" ${location == 'Hải Phòng' ? 'selected' : ''}>Thành phố Hải Phòng</option>
                                                <option value="Cần Thơ" ${location == 'Cần Thơ' ? 'selected' : ''}>Thành phố Cần Thơ</option>
                                                <option value="Huế" ${location == 'Huế' ? 'selected' : ''}>Thành phố Huế</option>

                                                <!-- Các tỉnh còn lại -->
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
                                        <div class="col-md-6">
                                            <label for="jobType" class="form-label required-field">Hình thức làm việc</label>
                                            <select class="form-select" id="jobType" name="jobType" required>
                                                <option value="" disabled ${empty jobType ? 'selected' : ''}>Chọn loại công việc</option>
                                                <option value="Toàn thời gian" ${jobType == 'Toàn thời gian' ? 'selected' : ''}>Toàn thời gian</option>
                                                <option value="Bán thời gian" ${jobType == 'Bán thời gian' ? 'selected' : ''}>Bán thời gian</option>
                                                <option value="Hợp đồng" ${jobType == 'Hợp đồng' ? 'selected' : ''}>Hợp đồng</option>
                                                <option value="Tự do" ${jobType == 'Tự do' ? 'selected' : ''}>Tự do</option>
                                                <option value="Thực tập" ${jobType == 'Thực tập' ? 'selected' : ''}>Thực tập</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="salaryMin" class="form-label required-field">Lương tối thiểu (đồng)</label>
                                            <input type="text" class="form-control" id="salaryMin" name="salaryMin" value="${salaryMin}" placeholder="VD: 1.000.000" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="salaryMax" class="form-label required-field">Lương tối đa (đồng)</label>
                                            <input type="text" class="form-control" id="salaryMax" name="salaryMax" value="${salaryMax}" placeholder="VD: 2.000.000" required>
                                        </div>
                                    </div>

                                </div>

                                <!-- Job Details -->
                                <div class="mb-4">
                                    <h5 class="border-bottom pb-2">Chi tiết công việc</h5>

                                    <div class="mb-3">
                                        <label for="jobDescription" class="form-label required-field">Mô tả công việc</label>
                                        <textarea class="form-control" id="jobDescription" name="jobDescription" rows="4" required minlength="30" placeholder="Tối thiểu phải có 30 ký tự">${jobDescription != null ? jobDescription : ''}</textarea>
                                        <div class="form-text">Mô tả vai trò, trách nhiệm và những công việc mà ứng viên sẽ thực hiện.</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="requirements" class="form-label required-field">Yêu cầu</label>
                                        <textarea class="form-control" id="requirements" name="requirements" rows="3" required minlength="30" placeholder="Tối thiểu phải có 30 ký tự">${requirements != null ? requirements : ''}</textarea>
                                        <div class="form-text">Liệt kê các kỹ năng, trình độ và kinh nghiệm yêu cầu.</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="benefits" class="form-label required-field">Quyền lợi</label>
                                        <textarea class="form-control" id="benefits" name="benefits" rows="2" placeholder="Ví dụ: Bảo hiểm y tế, lương tháng 13, v.v." required>${benefits != null ? benefits : ''}</textarea>
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
                                            <input type="date" class="form-control" id="applicationDeadline" name="applicationDeadline" value="${applicationDeadline}" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between mt-4">
                                    <!--<button type="button" class="btn btn-outline-secondary">Save as Draft</button>-->
                                    <button type="submit" class="btn btn-primary" style="margin-left: 43%;margin-top: 15px;">
                                        <i class="bi bi-check-circle me-2"></i>Đăng tin tuyển dụng
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <!-- Recent Activity -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="bi bi-activity me-2"></i>Các bài đăng gần đây</h5>
                        </div>

                        <form action="JobPostingPage" method="get">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" placeholder="Tìm kiếm tên công việc, vị trí..." name="search" value="${keyWord}">
                                <button class="btn" type="submit"><i class="bi bi-search"></i></button>
                            </div>
                        </form>
                        <!-- Sau lam them tim kiem advance de khi an vao thi co nhieu option lua chon tim kiem job post --!>
                        <!--                        <div class="row" style="margin-top: -10px;">
                                                    <div class="col-md-6">
                                                        <select class="form-select form-select-sm" style="height: 40px;w" name="category">
                                                            <option value="" selected>All Categories</option>
                                                            <option value="development">Development</option>
                                                            <option value="design">Design</option>
                                                            <option value="marketing">Marketing</option>
                                                            <option value="management">Management</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <select class="form-select form-select-sm" style="height: 40px;" name="location">
                                                            <option value="" selected>All Locations</option>
                                                            <option value="remote">Remote</option>
                                                            <option value="onsite">On-site</option>
                                                            <option value="hybrid">Hybrid</option>
                                                        </select>
                                                    </div>
                                                </div>-->
                        <div class="card-body p-0">

                            <c:forEach var="a" items="${listJobPost}" varStatus="status">
                                <div class="activity-item d-flex align-items-start job-post-item
                                     ${status.index >= 3 ? 'd-none' : ''}" 
                                     data-index="${status.index}"  style="cursor: pointer;"
                                     data-bs-toggle="modal" data-bs-target="#editJobModal"
                                     data-id="${a.getJobId()}"
                                     data-title="${a.getTitle()}"
                                     data-department="${a.getJobPosition()}"
                                     data-location="${a.getLocation()}"
                                     data-type="${a.getJobType()}"
                                     data-experiencelevel="${a.getExperienceLevel()}"
                                     data-minsalary="${a.getSalaryMin()}"
                                     data-maxsalary="${a.getSalaryMax()}"
                                     data-deadline="${a.getDeadline()}"
                                     data-description="${a.getDescription()}"
                                     data-requirements="${a.getRequirement()}"
                                     data-benefits="${a.getBenefit()}"
                                     data-industryid="${a.getIndustry().getIndustryId()}"
                                     >
                                    <div class="activity-icon">
                                        <i class="bi bi-plus-circle"></i>
                                    </div>
                                    <div>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="activity-title">${a.getTitle()}</h6>
                                            <span class="badge badge-custom badge-posted">Posted</span>
                                        </div>
                                        <p class="activity-text">${a.getLocation()}</p>
                                        <span class="activity-time">${a.getTimeAgo()}</span>
                                    </div>
                                </div>                
                            </c:forEach> 
                            <!--                            <div class="activity-item d-flex align-items-start">
                                                            <div class="activity-icon">
                                                                <i class="bi bi-plus-circle"></i>
                                                            </div>
                                                            <div>
                                                                <div class="d-flex justify-content-between align-items-center">
                                                                    <h6 class="activity-title">Senior Developer job posted</h6>
                                                                    <span class="badge badge-custom badge-posted">Posted</span>
                                                                </div>
                                                                <p class="activity-text">Job posting created and published to the job board.</p>
                                                                <span class="activity-time">Today, 10:45 AM</span>
                                                            </div>
                                                        </div>-->

                        </div>
                        <div class="card-footer text-center">
                            <button id="loadMoreBtn" class="btn btn-link text-primary">Xem thêm hoạt động</button>
                        </div>
                    </div>
                    <!-- Edit Job Modal -->
                    <!--<form action="EditJobPostingPage" method="post">-->
                    <div class="modal fade" id="editJobModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-scrollable">
                            <div class="modal-content">

                                <div class="modal-header">
                                    <h5 class="modal-title">Thông tin tuyển dụng</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">

                                    <div class="mb-4">
                                        <h6 class="fw-bold mb-3">Thông tin cơ bản</h6>
                                        <div class="row g-3">
                                            <input type="hidden" class="form-control" name="action" value="JobPostingPage">
                                            <input type="hidden" class="form-control" id="editJobId" name="jobId">
                                            <div class="col-md-6">
                                                <label for="editJobTitle" class="form-label">Tên công việc <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="editJobTitle" name="jobTitle" readonly>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="industry" class="form-label required-field">Ngành nghề</label>
                                                <select class="form-select" id="editIndustry" name="industry" disabled>
                                                    <option value="">-- Chọn ngành nghề --</option>
                                                    <c:forEach var="a" items="${listIndustries}">
                                                        <option value="${a.getIndustryId()}">${a.getNameIndustry()}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="editDepartment" class="form-label">Vị trí công việc <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="editDepartment" name="jobPosition" readonly>

                                            </div>
                                            <div class="col-md-6">
                                                <label for="editLocation" class="form-label">Địa điểm <span class="text-danger">*</span></label>
                                                <!--<input type="text" class="form-control" id="editLocation" name="location" required>-->
                                                <select name="location" id="editLocation" disabled
                                                        class="form-select block w-full max-w-sm p-2 border border-gray-300 rounded-md text-sm">
                                                    <option value="">-- Chọn tỉnh/thành phố --</option>

                                                    <!-- Thành phố trước -->
                                                    <option value="Hà Nội">Thành phố Hà Nội</option>
                                                    <option value="Hồ Chí Minh">Thành phố Hồ Chí Minh</option>
                                                    <option value="Đà Nẵng">Thành phố Đà Nẵng</option>
                                                    <option value="Hải Phòng">Thành phố Hải Phòng</option>
                                                    <option value="Cần Thơ">Thành phố Cần Thơ</option>
                                                    <option value="Huế">Thành phố Huế</option>

                                                    <!-- Các tỉnh còn lại -->
                                                    <option value="Lai Châu">Tỉnh Lai Châu</option>
                                                    <option value="Điện Biên">Tỉnh Điện Biên</option>
                                                    <option value="Sơn La">Tỉnh Sơn La</option>
                                                    <option value="Lạng Sơn">Tỉnh Lạng Sơn</option>
                                                    <option value="Quảng Ninh">Tỉnh Quảng Ninh</option>
                                                    <option value="Thanh Hoá">Tỉnh Thanh Hoá</option>
                                                    <option value="Nghệ An">Tỉnh Nghệ An</option>
                                                    <option value="Hà Tĩnh">Tỉnh Hà Tĩnh</option>
                                                    <option value="Cao Bằng">Tỉnh Cao Bằng</option>
                                                    <option value="Tuyên Quang">Tỉnh Tuyên Quang</option>
                                                    <option value="Lào Cai">Tỉnh Lào Cai</option>
                                                    <option value="Thái Nguyên">Tỉnh Thái Nguyên</option>
                                                    <option value="Phú Thọ">Tỉnh Phú Thọ</option>
                                                    <option value="Bắc Ninh">Tỉnh Bắc Ninh</option>
                                                    <option value="Hưng Yên">Tỉnh Hưng Yên</option>
                                                    <option value="Ninh Bình">Tỉnh Ninh Bình</option>
                                                    <option value="Quảng Trị">Tỉnh Quảng Trị</option>
                                                    <option value="Quảng Ngãi">Tỉnh Quảng Ngãi</option>
                                                    <option value="Gia Lai">Tỉnh Gia Lai</option>
                                                    <option value="Khánh Hoà">Tỉnh Khánh Hoà</option>
                                                    <option value="Lâm Đồng">Tỉnh Lâm Đồng</option>
                                                    <option value="Đắk Lắk">Tỉnh Đắk Lắk</option>
                                                    <option value="Đồng Nai">Tỉnh Đồng Nai</option>
                                                    <option value="Tây Ninh">Tỉnh Tây Ninh</option>
                                                    <option value="Vĩnh Long">Tỉnh Vĩnh Long</option>
                                                    <option value="Đồng Tháp">Tỉnh Đồng Tháp</option>
                                                    <option value="Cà Mau">Tỉnh Cà Mau</option>
                                                    <option value="Kiên Giang">Tỉnh Kiên Giang</option>
                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="editEmploymentType" class="form-label">Hình thức làm việc <span class="text-danger">*</span></label>
                                                <!--<input type="text" class="form-control" id="editEmploymentType" name="jobType" required>-->
                                                <select class="form-select" id="editEmploymentType" name="jobType" disabled>
                                                    <option value="" selected disabled>Chọn loại công việc</option>
                                                    <option value="Toàn thời gian">Toàn thời gian</option>
                                                    <option value="Bán thời gian">Bán thời gian</option>
                                                    <option value="Hợp đồng">Hợp đồng</option>
                                                    <option value="Tự do">Tự do</option>
                                                    <option value="Thực tập">Thực tập</option>

                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="editMinSalary" class="form-label">Lương tối thiểu (đồng)</label>
                                                <div class="input-group">
                                                    <span class="input-group-text">$</span>
                                                    <input type="text" class="form-control" id="editMinSalary" name="salaryMin" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="editMaxSalary" class="form-label">Lương tối đa (đồng)</label>
                                                <div class="input-group">
                                                    <span class="input-group-text">$</span>
                                                    <input type="text" class="form-control" id="editMaxSalary" name="salaryMax" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="editExperienceLevel" class="form-label">Cấp độ kinh nghiệm</label>
                                                <!--                                                    <input type="text" class="form-control" id="editExperienceLevel" name="experienceLevel">-->
                                                <select class="form-select" id="editExperienceLevel" name="experienceLevel" disabled>
                                                    <option value="" selected disabled>Chọn cấp độ kinh nghiệm</option>
                                                    <option value="Mới vào nghề (0-1 năm)">Mới vào nghề (0-1 năm)</option>
                                                    <option value="Nhân viên sơ cấp (1-3 năm)">Nhân viên sơ cấp (1-3 năm)</option>
                                                    <option value="Trung cấp (3-5 năm)">Trung cấp (3-5 năm)</option>
                                                    <option value="Cao cấp (trên 5 năm)">Cao cấp (trên 5 năm)</option>
                                                    <option value="Quản lý">Quản lý</option>
                                                    <option value="Điều hành">Điều hành</option>

                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="editExpiryDate" class="form-label">Hạn cuối nhận hồ sơ <span class="text-danger">*</span></label>
                                                <input type="date" class="form-control" id="editExpiryDate" name="applicationDeadline" readonly >
                                            </div>


                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <h6 class="fw-bold mb-3">Công việc</h6>
                                        <div class="mb-3">
                                            <label for="editDescription" class="form-label">Mô tả công việc <span class="text-danger">*</span></label>
                                            <textarea class="form-control" id="editDescription" rows="15" name="jobDescription" readonly></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="editRequirements" class="form-label">Yêu cầu <span class="text-danger">*</span></label>
                                            <textarea class="form-control" id="editRequirements" rows="15" name="requirements" readonly></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="editBenefits" class="form-label">Quyền lợi</label>
                                            <textarea class="form-control" id="editBenefits" name="benefits" rows="15" readonly></textarea>
                                        </div>
                                    </div>

                                    <!--                                        <div class="mb-4">
                                                                                <h6 class="fw-bold mb-3">Tùy chọn bổ sung</h6>
                                                                                <div class="row g-3">
                                                                                    <div class="col-md-6">
                                                                                        <div class="form-check form-switch">
                                                                                            <input class="form-check-input" type="checkbox" id="editFeatureJob" checked>
                                                                                            <label class="form-check-label" for="editFeatureJob">Feature this job (highlighted in listings)</label>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <div class="form-check form-switch">
                                                                                            <input class="form-check-input" type="checkbox" id="editHideCompany">
                                                                                            <label class="form-check-label" for="editHideCompany">Hide company name</label>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <div class="form-check form-switch">
                                                                                            <input class="form-check-input" type="checkbox" id="editRemotePossible">
                                                                                            <label class="form-check-label" for="editRemotePossible">Remote work possible</label>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <div class="form-check form-switch">
                                                                                            <input class="form-check-input" type="checkbox" id="editUrgentHiring">
                                                                                            <label class="form-check-label" for="editUrgentHiring">Urgent hiring</label>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>-->

                                </div>
                                <!--                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                        <button type="submit" class="btn btn-primary">Save Changes</button>
                                                                    </div>-->

                            </div>
                        </div>
                    </div>
                    <!--                    </form>-->
                    <!-- Tips & Guidelines -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="bi bi-lightbulb me-2"></i>Mẹo & Hướng dẫn</h5>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item px-0 pt-0 border-0">
                                    <h6><i class="bi bi-check-circle-fill text-primary me-2"></i>Hãy cụ thể</h6>
                                    <p class="small text-muted mb-0">Mô tả rõ ràng trách nhiệm và yêu cầu để thu hút các ứng viên phù hợp.</p>
                                </li>
                                <li class="list-group-item px-0 border-0">
                                    <h6><i class="bi bi-check-circle-fill text-primary me-2"></i>Đưa mức lương vào</h6>
                                    <p class="small text-muted mb-0">Tin tuyển dụng có thông tin lương nhận được nhiều hơn 30% đơn ứng tuyển.</p>
                                </li>
                                <li class="list-group-item px-0 border-0">
                                    <h6><i class="bi bi-check-circle-fill text-primary me-2"></i>Nhấn mạnh phúc lợi</h6>
                                    <p class="small text-muted mb-0">Đề cập đến các phúc lợi đặc biệt để công việc của bạn nổi bật hơn so với đối thủ.</p>
                                </li>
                            </ul>
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
                                const editModal = document.getElementById('editJobModal');

                                editModal.addEventListener('show.bs.modal', function (event) {
                                    const button = event.relatedTarget;

                                    // Lấy dữ liệu từ nút
                                    const id = button.getAttribute('data-id');
                                    const title = button.getAttribute('data-title');
                                    const department = button.getAttribute('data-department');
                                    const location = button.getAttribute('data-location');
                                    const type = button.getAttribute('data-type');
                                    const experienceLevel = button.getAttribute('data-experiencelevel');
                                    const minSalary = button.getAttribute('data-minsalary');
                                    const maxSalary = button.getAttribute('data-maxsalary');
                                    const deadline = button.getAttribute('data-deadline');
                                    const formattedDate = deadline.split(" ")[0];
                                    const description = button.getAttribute('data-description');
                                    const requirements = button.getAttribute('data-requirements');
                                    const benefits = button.getAttribute('data-benefits');
                                    const industryid = button.getAttribute('data-industryid');


                                    // Đổ dữ liệu vào form
                                    document.getElementById('editJobId').value = id;
                                    document.getElementById('editJobTitle').value = title;
                                    document.getElementById('editDepartment').value = department;
                                    document.getElementById('editLocation').value = location;
                                    document.getElementById('editEmploymentType').value = type;

                                    document.getElementById('editExperienceLevel').value = experienceLevel;

                                    //  Format tiền tệ
                                    document.getElementById('editMinSalary').value = Number(minSalary).toLocaleString('vi-VN');
                                    document.getElementById('editMaxSalary').value = Number(maxSalary).toLocaleString('vi-VN');

                                    document.getElementById('editExpiryDate').value = formattedDate;
                                    document.getElementById('editDescription').value = description;
                                    document.getElementById('editRequirements').value = requirements;
                                    document.getElementById('editBenefits').value = benefits;
                                    document.getElementById('editIndustry').value = industryid;

//                console.log("Industry ID:", industryid);
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
        <script>
            let visibleCount = 3;
            const step = 3;
            const items = document.querySelectorAll('.job-post-item');
            const loadMoreBtn = document.getElementById('loadMoreBtn');

            loadMoreBtn.addEventListener('click', function () {
                let nextCount = visibleCount + step;
                for (let i = visibleCount; i < nextCount && i < items.length; i++) {
                    items[i].classList.remove('d-none');
                }
                visibleCount = nextCount;

                if (visibleCount >= items.length) {
                    loadMoreBtn.style.display = 'none'; // Ẩn nút nếu hết item
                }
            });
        </script>

    </body>
</html>
