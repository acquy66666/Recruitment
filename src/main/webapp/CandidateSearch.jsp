<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm ứng viên - JobHub</title>
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
        
        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        
        .search-filters {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .candidate-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .candidate-card:hover {
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            border-color: var(--primary-color);
            transform: translateY(-3px);
        }
        
        .candidate-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
            color: white;
            font-weight: 600;
        }
        
        .candidate-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }
        
        .skill-tag {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background: #e6f0ff;
            border-radius: 15px;
            font-size: 0.75rem;
            color: var(--primary-color);
            margin: 0.15rem;
        }
        
        .match-score {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: linear-gradient(135deg, var(--success-color), #20c997);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
        }
        
        .salary-expectation {
            color: var(--success-color);
            font-weight: 600;
        }
        
        .filter-section {
            margin-bottom: 1.5rem;
        }
        
        .filter-section:last-child {
            margin-bottom: 0;
        }
        
        .filter-title {
            font-weight: 600;
            color: #1a1a2e;
            margin-bottom: 0.75rem;
            font-size: 0.875rem;
        }
        
        .btn-search {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
        }
        
        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0, 70, 170, 0.3);
            color: white;
        }
        
        .experience-badge {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #92400e;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .location-text {
            color: #6b7280;
            font-size: 0.875rem;
        }
        
        .verified-badge {
            color: var(--success-color);
            font-size: 0.875rem;
        }
        
        .view-cv-btn {
            background: white;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .view-cv-btn:hover {
            background: var(--primary-color);
            color: white;
        }
        
        .invite-btn {
            background: linear-gradient(135deg, var(--secondary-color), #ff8c00);
            border: none;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .invite-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 0, 0.3);
            color: white;
        }
        
        .form-check-label {
            cursor: pointer;
        }
        
        .salary-range {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .salary-input {
            border-radius: 8px;
            padding: 0.5rem;
            border: 1px solid #e9ecef;
        }
        
        .result-count {
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .sort-select {
            border-radius: 8px;
            padding: 0.5rem 1rem;
            border: 1px solid #e9ecef;
        }
        
        .ai-badge {
            background: linear-gradient(135deg, #8b5cf6, #a78bfa);
            color: white;
            padding: 0.2rem 0.5rem;
            border-radius: 10px;
            font-size: 0.7rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <%
            com.recruitment.model.Recruiter recruiter = (com.recruitment.model.Recruiter) session.getAttribute("Recruiter");
            if (recruiter == null) {
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
                <a href="RecruiterDashboard" class="btn btn-outline-primary me-2">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a href="logout" class="btn btn-danger">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2><i class="bi bi-people-fill me-2"></i>Tìm kiếm ứng viên</h2>
                    <p class="mb-0 opacity-75">Tìm ứng viên phù hợp với yêu cầu tuyển dụng của bạn</p>
                </div>
                <button class="btn btn-light">
                    <i class="bi bi-download me-2"></i>Xuất danh sách
                </button>
            </div>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row">
            <!-- Filters Sidebar -->
            <div class="col-lg-3">
                <div class="search-filters">
                    <h5 class="mb-4">
                        <i class="bi bi-funnel me-2"></i>Bộ lọc
                    </h5>
                    
                    <!-- Keyword Search -->
                    <div class="filter-section">
                        <label class="filter-title">Từ khóa</label>
                        <input type="text" class="form-control" placeholder="VD: Java Developer, Designer...">
                    </div>
                    
                    <!-- Location -->
                    <div class="filter-section">
                        <label class="filter-title">Địa điểm</label>
                        <select class="form-select">
                            <option>Tất cả địa điểm</option>
                            <option>TP. Hồ Chí Minh</option>
                            <option>Hà Nội</option>
                            <option>Đà Nẵng</option>
                            <option>Cần Thơ</option>
                            <option>Hải Phòng</option>
                        </select>
                    </div>
                    
                    <!-- Experience -->
                    <div class="filter-section">
                        <label class="filter-title">Kinh nghiệm</label>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="exp1" checked>
                            <label class="form-check-label" for="exp1">Chưa có kinh nghiệm</label>
                        </div>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="exp2">
                            <label class="form-check-label" for="exp2">1-2 năm</label>
                        </div>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="exp3" checked>
                            <label class="form-check-label" for="exp3">3-5 năm</label>
                        </div>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="exp4">
                            <label class="form-check-label" for="exp4">5-10 năm</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="exp5">
                            <label class="form-check-label" for="exp5">10+ năm</label>
                        </div>
                    </div>
                    
                    <!-- Salary Expectation -->
                    <div class="filter-section">
                        <label class="filter-title">Mức lương mong muốn (VNĐ/tháng)</label>
                        <div class="salary-range mb-2">
                            <input type="number" class="form-control salary-input" placeholder="Từ" value="10">
                            <span>-</span>
                            <input type="number" class="form-control salary-input" placeholder="Đến" value="50">
                        </div>
                    </div>
                    
                    <!-- Education -->
                    <div class="filter-section">
                        <label class="filter-title">Trình độ học vấn</label>
                        <select class="form-select">
                            <option>Tất cả</option>
                            <option>Trung học</option>
                            <option>Cao đẳng</option>
                            <option>Đại học</option>
                            <option>Thạc sĩ</option>
                            <option>Tiến sĩ</option>
                        </select>
                    </div>
                    
                    <!-- Job Type -->
                    <div class="filter-section">
                        <label class="filter-title">Loại công việc</label>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="type1" checked>
                            <label class="form-check-label" for="type1">Toàn thời gian</label>
                        </div>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="type2">
                            <label class="form-check-label" for="type2">Bán thời gian</label>
                        </div>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="type3">
                            <label class="form-check-label" for="type3">Freelance</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="type4">
                            <label class="form-check-label" for="type4">Thực tập</label>
                        </div>
                    </div>
                    
                    <hr>
                    
                    <button class="btn btn-search w-100">
                        <i class="bi bi-search me-2"></i>Tìm kiếm
                    </button>
                </div>
            </div>
            
            <!-- Results -->
            <div class="col-lg-9">
                <!-- Results Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <span class="result-count">156</span> ứng viên được tìm thấy
                    </div>
                    <div class="d-flex gap-2">
                        <select class="form-select sort-select">
                            <option>Độ phù hợp</option>
                            <option>Mới nhất</option>
                            <option>Lương cao nhất</option>
                            <option>Kinh nghiệm nhiều nhất</option>
                        </select>
                        <div class="btn-group">
                            <button class="btn btn-outline-secondary"><i class="bi bi-grid"></i></button>
                            <button class="btn btn-outline-secondary active"><i class="bi bi-list"></i></button>
                        </div>
                    </div>
                </div>
                
                <!-- Candidate 1 -->
                <div class="candidate-card position-relative">
                    <span class="match-score">
                        <i class="bi bi-lightning-fill me-1"></i>95% phù hợp
                        <span class="ai-badge">AI</span>
                    </span>
                    <div class="d-flex">
                        <div class="candidate-avatar me-4">
                            NVA
                        </div>
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h5 class="mb-1">Nguyễn Văn An <i class="bi bi-patch-check-fill verified-badge"></i></h5>
                                    <p class="text-muted mb-2">Senior Java Developer</p>
                                    <p class="location-text mb-2">
                                        <i class="bi bi-geo-alt me-1"></i>TP. Hồ Chí Minh
                                        <span class="mx-2">|</span>
                                        <span class="experience-badge">5 năm kinh nghiệm</span>
                                    </p>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <span class="skill-tag">Java</span>
                                <span class="skill-tag">Spring Boot</span>
                                <span class="skill-tag">Microservices</span>
                                <span class="skill-tag">MySQL</span>
                                <span class="skill-tag">Docker</span>
                                <span class="skill-tag">AWS</span>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="salary-expectation">
                                        <i class="bi bi-currency-exchange me-1"></i>
                                        30 - 40 triệu VNĐ/tháng
                                    </span>
                                    <small class="text-muted ms-3">Cập nhật: 2 ngày trước</small>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="view-cv-btn">
                                        <i class="bi bi-eye me-1"></i>Xem CV
                                    </button>
                                    <button class="invite-btn">
                                        <i class="bi bi-send me-1"></i>Mời ứng tuyển
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Candidate 2 -->
                <div class="candidate-card position-relative">
                    <span class="match-score">
                        <i class="bi bi-lightning-fill me-1"></i>88% phù hợp
                        <span class="ai-badge">AI</span>
                    </span>
                    <div class="d-flex">
                        <div class="candidate-avatar me-4" style="background: linear-gradient(135deg, #ff6b00, #ff8c00);">
                            TKB
                        </div>
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h5 class="mb-1">Trần Kim Bích</h5>
                                    <p class="text-muted mb-2">Frontend Developer</p>
                                    <p class="location-text mb-2">
                                        <i class="bi bi-geo-alt me-1"></i>Hà Nội
                                        <span class="mx-2">|</span>
                                        <span class="experience-badge">3 năm kinh nghiệm</span>
                                    </p>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <span class="skill-tag">React</span>
                                <span class="skill-tag">Vue.js</span>
                                <span class="skill-tag">TypeScript</span>
                                <span class="skill-tag">CSS3</span>
                                <span class="skill-tag">Node.js</span>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="salary-expectation">
                                        <i class="bi bi-currency-exchange me-1"></i>
                                        20 - 28 triệu VNĐ/tháng
                                    </span>
                                    <small class="text-muted ms-3">Cập nhật: 5 ngày trước</small>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="view-cv-btn">
                                        <i class="bi bi-eye me-1"></i>Xem CV
                                    </button>
                                    <button class="invite-btn">
                                        <i class="bi bi-send me-1"></i>Mời ứng tuyển
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Candidate 3 -->
                <div class="candidate-card position-relative">
                    <span class="match-score">
                        <i class="bi bi-lightning-fill me-1"></i>82% phù hợp
                    </span>
                    <div class="d-flex">
                        <div class="candidate-avatar me-4" style="background: linear-gradient(135deg, #2dce89, #20c997);">
                            LTH
                        </div>
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <h5 class="mb-1">Lê Thị Hương <i class="bi bi-patch-check-fill verified-badge"></i></h5>
                                    <p class="text-muted mb-2">UI/UX Designer</p>
                                    <p class="location-text mb-2">
                                        <i class="bi bi-geo-alt me-1"></i>TP. Hồ Chí Minh
                                        <span class="mx-2">|</span>
                                        <span class="experience-badge">4 năm kinh nghiệm</span>
                                    </p>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <span class="skill-tag">Figma</span>
                                <span class="skill-tag">Adobe XD</span>
                                <span class="skill-tag">Photoshop</span>
                                <span class="skill-tag">Illustrator</span>
                                <span class="skill-tag">Sketch</span>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="salary-expectation">
                                        <i class="bi bi-currency-exchange me-1"></i>
                                        22 - 30 triệu VNĐ/tháng
                                    </span>
                                    <small class="text-muted ms-3">Cập nhật: 1 ngày trước</small>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="view-cv-btn">
                                        <i class="bi bi-eye me-1"></i>Xem CV
                                    </button>
                                    <button class="invite-btn">
                                        <i class="bi bi-send me-1"></i>Mời ứng tuyển
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Pagination -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center mt-4">
                        <li class="page-item disabled">
                            <a class="page-link" href="#"><i class="bi bi-chevron-left"></i></a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">4</a></li>
                        <li class="page-item"><a class="page-link" href="#">5</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#"><i class="bi bi-chevron-right"></i></a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
