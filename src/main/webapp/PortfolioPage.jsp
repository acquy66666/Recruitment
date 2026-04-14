<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ Portfolio - JobHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #0046aa;
            --secondary-color: #ff6b00;
            --success-color: #2dce89;
            --warning-color: #fb6340;
            --danger-color: #f5365c;
            --info-color: #11cdef;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f6ff;
            color: #525f7f;
        }
        
        .navbar-custom {
            background-color: #f0f6ff;
            box-shadow: 0 0 2rem 0 rgba(136, 152, 170, 0.35);
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
        }
        
        .portfolio-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
        }
        
        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 0 40px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-top: -4rem;
        }
        
        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid white;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            object-fit: cover;
            margin-top: -75px;
        }
        
        .profile-avatar-placeholder {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid white;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: -75px;
            font-size: 3rem;
            color: white;
        }
        
        .skill-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            background: linear-gradient(135deg, #e6f0ff 0%, #dbeafe 100%);
            border-radius: 20px;
            margin: 0.25rem;
            font-size: 0.875rem;
            color: var(--primary-color);
            transition: all 0.3s ease;
        }
        
        .skill-badge:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }
        
        .project-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            overflow: hidden;
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
        }
        
        .project-card:hover {
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            transform: translateY(-5px);
        }
        
        .project-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: linear-gradient(135deg, #e9ecef 0%, #dee2e6 100%);
        }
        
        .project-placeholder {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
        }
        
        .certification-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            border-left: 4px solid var(--primary-color);
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .certification-card:hover {
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .experience-timeline {
            position: relative;
            padding-left: 2rem;
        }
        
        .experience-timeline::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 3px;
            background: linear-gradient(180deg, var(--primary-color), #0051ff);
        }
        
        .experience-item {
            position: relative;
            padding-bottom: 2rem;
        }
        
        .experience-item::before {
            content: '';
            position: absolute;
            left: -2.35rem;
            top: 0.5rem;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--primary-color);
            border: 3px solid white;
            box-shadow: 0 0 0 3px var(--primary-color);
        }
        
        .btn-add-project {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
        }
        
        .btn-add-project:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0, 70, 170, 0.3);
            color: white;
        }
        
        .social-link {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .social-link.github { background: #333; color: white; }
        .social-link.linkedin { background: #0077b5; color: white; }
        .social-link.facebook { background: #1877f2; color: white; }
        .social-link.twitter { background: #1da1f2; color: white; }
        
        .social-link:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .file-upload-zone {
            border: 2px dashed #dee2e6;
            border-radius: 15px;
            padding: 3rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        
        .file-upload-zone:hover {
            border-color: var(--primary-color);
            background: #e6f0ff;
        }
        
        .upload-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <%
            com.recruitment.model.Candidate candidate = (com.recruitment.model.Candidate) session.getAttribute("Candidate");
            if (candidate == null) {
                response.sendRedirect("login");
                return;
            }
    %>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
        <div class="container">
            <a class="navbar-brand" href="HomePage">
                <span style="color: var(--primary-color);">Job</span><span style="color: #001e44;">Hub</span>
            </a>
            <div class="d-flex">
                <a href="CandidateDashboard" class="btn btn-outline-primary me-2">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a href="logout" class="btn btn-danger">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <!-- Header -->
    <div class="portfolio-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1><i class="bi bi-person-badge me-2"></i>Hồ sơ Portfolio</h1>
                    <p class="mb-0 opacity-75">Giới thiệu bản thân và các dự án nổi bật</p>
                </div>
                <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                    <i class="bi bi-pencil me-2"></i>Chỉnh sửa
                </button>
            </div>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row">
            <!-- Left Column - Profile Info -->
            <div class="col-lg-4">
                <div class="profile-card p-4">
                    <div class="text-center mb-4">
                        <div class="profile-avatar-placeholder mx-auto">
                            <i class="bi bi-person-fill"></i>
                        </div>
                        <h4 class="mt-3 mb-1">Nguyễn Văn A</h4>
                        <p class="text-muted mb-2">Senior Web Developer</p>
                        <p class="small text-muted mb-0">
                            <i class="bi bi-geo-alt me-1"></i>TP. Hồ Chí Minh, Việt Nam
                        </p>
                    </div>
                    
                    <hr>
                    
                    <div class="mb-4">
                        <h6 class="mb-3">
                            <i class="bi bi-envelope me-2 text-primary"></i>Liên hệ
                        </h6>
                        <p class="small mb-1"><i class="bi bi-envelope me-2"></i>email@example.com</p>
                        <p class="small mb-1"><i class="bi bi-phone me-2"></i>+84 123 456 789</p>
                        <div class="mt-3">
                            <a href="#" class="social-link github"><i class="bi bi-github"></i></a>
                            <a href="#" class="social-link linkedin"><i class="bi bi-linkedin"></i></a>
                            <a href="#" class="social-link facebook"><i class="bi bi-facebook"></i></a>
                            <a href="#" class="social-link twitter"><i class="bi bi-twitter"></i></a>
                        </div>
                    </div>
                    
                    <hr>
                    
                    <div class="mb-4">
                        <h6 class="mb-3">
                            <i class="bi bi-tools me-2 text-primary"></i>Kỹ năng
                        </h6>
                        <div class="skill-badge">JavaScript</div>
                        <div class="skill-badge">React</div>
                        <div class="skill-badge">Node.js</div>
                        <div class="skill-badge">Java</div>
                        <div class="skill-badge">Spring Boot</div>
                        <div class="skill-badge">MySQL</div>
                        <div class="skill-badge">Git</div>
                        <div class="skill-badge">Docker</div>
                    </div>
                    
                    <hr>
                    
                    <div class="mb-4">
                        <h6 class="mb-3">
                            <i class="bi bi-translate me-2 text-primary"></i>Ngôn ngữ
                        </h6>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="small">Tiếng Việt</span>
                            <span class="badge bg-success">Bản ngữ</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="small">Tiếng Anh</span>
                            <span class="badge bg-primary">IELTS 7.0</span>
                        </div>
                    </div>
                    
                    <hr>
                    
                    <div>
                        <h6 class="mb-3">
                            <i class="bi bi-calendar-check me-2 text-primary"></i>Giới thiệu
                        </h6>
                        <p class="small text-muted">
                            Tôi là một lập trình viên với hơn 5 năm kinh nghiệm trong lĩnh vực phát triển web. 
                            Đam mê công nghệ và luôn tìm kiếm những giải pháp sáng tạo cho các vấn đề phức tạp.
                        </p>
                    </div>
                </div>
            </div>
            
            <!-- Right Column - Content -->
            <div class="col-lg-8">
                <!-- Projects Section -->
                <div class="mb-5">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4><i class="bi bi-folder2-open me-2 text-primary"></i>Dự án nổi bật</h4>
                        <button class="btn btn-add-project btn-sm" data-bs-toggle="modal" data-bs-target="#addProjectModal">
                            <i class="bi bi-plus-lg me-2"></i>Thêm dự án
                        </button>
                    </div>
                    
                    <div class="row">
                        <!-- Project 1 -->
                        <div class="col-md-6">
                            <div class="project-card">
                                <div class="project-placeholder">
                                    <i class="bi bi-cart4"></i>
                                </div>
                                <div class="p-4">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="mb-0">E-Commerce Platform</h5>
                                        <span class="badge bg-primary">Full-stack</span>
                                    </div>
                                    <p class="text-muted small mb-3">
                                        Nền tảng thương mại điện tử với thanh toán trực tuyến, quản lý kho hàng và thống kê doanh số.
                                    </p>
                                    <div class="mb-3">
                                        <span class="badge bg-light text-dark me-1">React</span>
                                        <span class="badge bg-light text-dark me-1">Node.js</span>
                                        <span class="badge bg-light text-dark">MongoDB</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="bi bi-calendar3 me-1"></i>2024
                                        </small>
                                        <a href="#" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-link-45deg me-1"></i>Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Project 2 -->
                        <div class="col-md-6">
                            <div class="project-card">
                                <div class="project-placeholder" style="background: linear-gradient(135deg, #ff6b00, #ff8c00);">
                                    <i class="bi bi-newspaper"></i>
                                </div>
                                <div class="p-4">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="mb-0">News Aggregator</h5>
                                        <span class="badge bg-info">Web App</span>
                                    </div>
                                    <p class="text-muted small mb-3">
                                        Ứng dụng tổng hợp tin tức từ nhiều nguồn với AI phân loại và gợi ý nội dung cá nhân hóa.
                                    </p>
                                    <div class="mb-3">
                                        <span class="badge bg-light text-dark me-1">Vue.js</span>
                                        <span class="badge bg-light text-dark me-1">Python</span>
                                        <span class="badge bg-light text-dark">TensorFlow</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="bi bi-calendar3 me-1"></i>2023
                                        </small>
                                        <a href="#" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-link-45deg me-1"></i>Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Certifications Section -->
                <div class="mb-5">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4><i class="bi bi-patch-check me-2 text-primary"></i>Chứng chỉ & Giải thưởng</h4>
                        <button class="btn btn-add-project btn-sm" data-bs-toggle="modal" data-bs-target="#addCertModal">
                            <i class="bi bi-plus-lg me-2"></i>Thêm chứng chỉ
                        </button>
                    </div>
                    
                    <div class="certification-card">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="mb-1">AWS Certified Solutions Architect</h6>
                                <p class="text-muted small mb-1">Amazon Web Services</p>
                                <small class="text-muted">
                                    <i class="bi bi-calendar3 me-1"></i>Tháng 3, 2024
                                </small>
                            </div>
                            <div>
                                <i class="bi bi-award-fill text-warning fs-4"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="certification-card">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="mb-1">Google Data Analytics Professional Certificate</h6>
                                <p class="text-muted small mb-1">Google</p>
                                <small class="text-muted">
                                    <i class="bi bi-calendar3 me-1"></i>Tháng 1, 2024
                                </small>
                            </div>
                            <div>
                                <i class="bi bi-award-fill text-warning fs-4"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="certification-card">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="mb-1">Oracle Certified Professional Java SE 11</h6>
                                <p class="text-muted small mb-1">Oracle</p>
                                <small class="text-muted">
                                    <i class="bi bi-calendar3 me-1"></i>Tháng 6, 2023
                                </small>
                            </div>
                            <div>
                                <i class="bi bi-award-fill text-warning fs-4"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Work Experience Section -->
                <div class="mb-5">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4><i class="bi bi-briefcase me-2 text-primary"></i>Kinh nghiệm làm việc</h4>
                        <button class="btn btn-add-project btn-sm" data-bs-toggle="modal" data-bs-target="#addExperienceModal">
                            <i class="bi bi-plus-lg me-2"></i>Thêm kinh nghiệm
                        </button>
                    </div>
                    
                    <div class="experience-timeline">
                        <div class="experience-item">
                            <h6 class="mb-1">Senior Web Developer</h6>
                            <p class="text-primary mb-2">FPT Software</p>
                            <p class="text-muted small mb-2">
                                Phát triển và bảo trì các ứng dụng web doanh nghiệp. 
                                Lead team 5 dev, triển khai CI/CD pipeline.
                            </p>
                            <small class="badge bg-light text-dark">2022 - Hiện tại</small>
                        </div>
                        
                        <div class="experience-item">
                            <h6 class="mb-1">Web Developer</h6>
                            <p class="text-primary mb-2">VNG Corporation</p>
                            <p class="text-muted small mb-2">
                                Phát triển các tính năng mới cho nền tảng game portal.
                                Tối ưu hóa hiệu suất ứng dụng.
                            </p>
                            <small class="badge bg-light text-dark">2020 - 2022</small>
                        </div>
                        
                        <div class="experience-item">
                            <h6 class="mb-1">Junior Developer</h6>
                            <p class="text-primary mb-2">Techcombank</p>
                            <p class="text-muted small mb-2">
                                Phát triển ứng dụng banking cho khách hàng doanh nghiệp.
                            </p>
                            <small class="badge bg-light text-dark">2018 - 2020</small>
                        </div>
                    </div>
                </div>
                
                <!-- Education Section -->
                <div class="mb-5">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4><i class="bi bi-mortarboard me-2 text-primary"></i>Học vấn</h4>
                    </div>
                    
                    <div class="experience-timeline">
                        <div class="experience-item">
                            <h6 class="mb-1">Cử nhân Công nghệ Thông tin</h6>
                            <p class="text-primary mb-2">Đại học Bách Khoa TP.HCM</p>
                            <p class="text-muted small mb-2">
                                GPA: 3.5/4.0 - Tham gia CLB lập trình, đạt giải thưởng ACM-ICPC regional.
                            </p>
                            <small class="badge bg-light text-dark">2014 - 2018</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Project Modal -->
    <div class="modal fade" id="addProjectModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-folder-plus me-2"></i>Thêm dự án mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="PortfolioServlet" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="addProject">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Tên dự án</label>
                            <input type="text" class="form-control" name="projectName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" rows="3" required></textarea>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Loại dự án</label>
                                <select class="form-select" name="projectType">
                                    <option value="frontend">Frontend</option>
                                    <option value="backend">Backend</option>
                                    <option value="fullstack">Full-stack</option>
                                    <option value="mobile">Mobile</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Năm</label>
                                <input type="number" class="form-control" name="year" value="2024" min="2000" max="2030">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Công nghệ sử dụng</label>
                            <input type="text" class="form-control" name="technologies" placeholder="React, Node.js, MongoDB...">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Link dự án</label>
                            <input type="url" class="form-control" name="projectUrl" placeholder="https://...">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Hình ảnh dự án</label>
                            <input type="file" class="form-control" name="projectImage" accept="image/*">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-add-project">Lưu dự án</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
