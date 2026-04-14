<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá công ty - JobHub</title>
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
        
        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
        }
        
        .rating-stars {
            color: #ffc107;
            font-size: 1.25rem;
        }
        
        .rating-stars .empty {
            color: #e9ecef;
        }
        
        .review-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }
        
        .review-card:hover {
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        
        .company-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            padding: 1.5rem;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .company-card:hover {
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
            transform: translateY(-3px);
        }
        
        .company-logo {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e9ecef 0%, #dee2e6 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 2rem;
            color: var(--primary-color);
            font-weight: 700;
        }
        
        .company-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }
        
        .avg-rating {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
        }
        
        .rating-bar {
            height: 8px;
            border-radius: 4px;
            background: #e9ecef;
            overflow: hidden;
        }
        
        .rating-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, #ffc107, #ffca2c);
            border-radius: 4px;
        }
        
        .review-section {
            border-left: 3px solid var(--primary-color);
            padding-left: 1rem;
            margin: 1rem 0;
        }
        
        .pros-cons {
            display: flex;
            gap: 2rem;
            margin-top: 1rem;
        }
        
        .pros-list, .cons-list {
            flex: 1;
        }
        
        .pros-list li {
            color: var(--success-color);
        }
        
        .cons-list li {
            color: var(--danger-color);
        }
        
        .btn-write-review {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
        }
        
        .btn-write-review:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0, 70, 170, 0.3);
            color: white;
        }
        
        .modal-review {
            border-radius: 15px;
        }
        
        .star-rating-input {
            font-size: 2rem;
            cursor: pointer;
        }
        
        .star-rating-input span {
            color: #e9ecef;
            transition: color 0.2s;
        }
        
        .star-rating-input span.active,
        .star-rating-input span:hover,
        .star-rating-input span:hover ~ span {
            color: #ffc107;
        }
        
        .filter-btn {
            border: 1px solid #e9ecef;
            background: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
            transition: all 0.2s;
        }
        
        .filter-btn:hover,
        .filter-btn.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
        <div class="container">
            <a class="navbar-brand" href="HomePage">
                <span style="color: var(--primary-color);">Job</span><span style="color: #001e44;">Hub</span>
            </a>
            <div class="d-flex">
                <a href="HomePage" class="btn btn-outline-primary me-2">Trang chủ</a>
                <a href="AdvancedJobSearch" class="btn btn-outline-primary me-2">Tìm việc</a>
                <a href="login.jsp" class="btn btn-primary">Đăng nhập</a>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="bi bi-building me-2"></i>Đánh giá công ty</h1>
            <p class="mb-0 opacity-75">Xem và chia sẻ đánh giá về các công ty tuyển dụng</p>
        </div>
    </div>

    <div class="container pb-5">
        <!-- Top Companies -->
        <div class="mb-5">
            <h4 class="mb-4"><i class="bi bi-trophy-fill text-warning me-2"></i>Công ty được đánh giá cao</h4>
            <div class="row">
                <div class="col-md-3 mb-4">
                    <div class="company-card">
                        <div class="company-logo">FPT</div>
                        <h5>FPT Software</h5>
                        <p class="text-muted mb-2">Công nghệ thông tin</p>
                        <div class="avg-rating">4.8</div>
                        <div class="rating-stars mb-2">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                        </div>
                        <p class="small text-muted mb-0">127 đánh giá</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="company-card">
                        <div class="company-logo">Vn</div>
                        <h5>VNG Corporation</h5>
                        <p class="text-muted mb-2">Game & Internet</p>
                        <div class="avg-rating">4.6</div>
                        <div class="rating-stars mb-2">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-half"></i>
                        </div>
                        <p class="small text-muted mb-0">98 đánh giá</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="company-card">
                        <div class="company-logo">TG</div>
                        <h5>TGĐ Group</h5>
                        <p class="text-muted mb-2">Bán lẻ</p>
                        <div class="avg-rating">4.5</div>
                        <div class="rating-stars mb-2">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-half"></i>
                        </div>
                        <p class="small text-muted mb-0">76 đánh giá</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="company-card">
                        <div class="company-logo">Vi</div>
                        <h5>Viettel</h5>
                        <p class="text-muted mb-2">Viễn thông</p>
                        <div class="avg-rating">4.7</div>
                        <div class="rating-stars mb-2">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                        </div>
                        <p class="small text-muted mb-0">112 đánh giá</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filters -->
        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4><i class="bi bi-filter me-2"></i>Lọc đánh giá</h4>
                <button class="btn btn-write-review" data-bs-toggle="modal" data-bs-target="#writeReviewModal">
                    <i class="bi bi-pencil-square me-2"></i>Viết đánh giá
                </button>
            </div>
            <div class="d-flex flex-wrap">
                <button class="filter-btn active">Tất cả</button>
                <button class="filter-btn">5 sao</button>
                <button class="filter-btn">4 sao</button>
                <button class="filter-btn">3 sao</button>
                <button class="filter-btn">2 sao</button>
                <button class="filter-btn">1 sao</button>
            </div>
        </div>

        <!-- Reviews List -->
        <div class="row">
            <div class="col-lg-8">
                <!-- Review 1 -->
                <div class="review-card">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" 
                                 style="width: 50px; height: 50px;">
                                <span class="text-white fw-bold">NVA</span>
                            </div>
                            <div>
                                <h6 class="mb-0">Nguyễn Văn A</h6>
                                <small class="text-muted">Ứng viên - 3 tháng trước</small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="rating-stars">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                            </div>
                            <small class="text-muted">5.0</small>
                        </div>
                    </div>
                    
                    <h5 class="mb-2">Môi trường làm việc tuyệt vời!</h5>
                    
                    <div class="review-section">
                        <p class="text-muted mb-2">
                            Đây là công ty tôi đã làm việc trong 2 năm. Văn hóa công ty rất chuyên nghiệp, 
                            đồng nghiệp thân thiện và lãnh đạo quan tâm đến nhân viên. 
                            Chế độ đãi ngộ tốt, lương thưởng hấp dẫn.
                        </p>
                    </div>
                    
                    <div class="pros-cons">
                        <div class="pros-list">
                            <strong class="text-success"><i class="bi bi-check-circle me-1"></i>Ưu điểm:</strong>
                            <ul class="mt-2 mb-0 small">
                                <li>Lương cao, thưởng hấp dẫn</li>
                                <li>Môi trường năng động</li>
                                <li>Cơ hội học tập tốt</li>
                                <li>Đồng nghiệp thân thiện</li>
                            </ul>
                        </div>
                        <div class="cons-list">
                            <strong class="text-danger"><i class="bi bi-x-circle me-1"></i>Nhược điểm:</strong>
                            <ul class="mt-2 mb-0 small">
                                <li>Áp lực deadline</li>
                                <li>Giờ làm việc linh hoạt</li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="mt-3 pt-3 border-top">
                        <span class="badge bg-light text-dark me-2">
                            <i class="bi bi-building me-1"></i>FPT Software
                        </span>
                        <span class="badge bg-light text-dark me-2">
                            <i class="bi bi-briefcase me-1"></i>Lập trình viên
                        </span>
                        <span class="badge bg-success me-2">Khuyên đi làm</span>
                        <button class="btn btn-sm btn-outline-primary float-end">
                            <i class="bi bi-hand-thumbs-up"></i> 24
                        </button>
                    </div>
                </div>

                <!-- Review 2 -->
                <div class="review-card">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="d-flex align-items-center">
                            <div class="bg-info rounded-circle d-flex align-items-center justify-content-center me-3" 
                                 style="width: 50px; height: 50px;">
                                <span class="text-white fw-bold">TKB</span>
                            </div>
                            <div>
                                <h6 class="mb-0">Trần Kim Bích</h6>
                                <small class="text-muted">Nhân viên - 1 tháng trước</small>
                            </div>
                        </div>
                        <div class="text-end">
                            <div class="rating-stars">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star empty"></i>
                            </div>
                            <small class="text-muted">4.0</small>
                        </div>
                    </div>
                    
                    <h5 class="mb-2">Công ty phát triển tốt, cần cải thiện quản lý</h5>
                    
                    <div class="review-section">
                        <p class="text-muted mb-2">
                            Nhìn chung công ty khá ổn định, có nhiều cơ hội thăng tiến. 
                            Tuy nhiên, quy trình làm việc có phần rườm rà và 
                            nhiều cuộc họp không cần thiết.
                        </p>
                    </div>
                    
                    <div class="pros-cons">
                        <div class="pros-list">
                            <strong class="text-success"><i class="bi bi-check-circle me-1"></i>Ưu điểm:</strong>
                            <ul class="mt-2 mb-0 small">
                                <li>Cơ hội thăng tiến</li>
                                <li>Đào tạo nội bộ tốt</li>
                                <li>Phúc lợi đầy đủ</li>
                            </ul>
                        </div>
                        <div class="cons-list">
                            <strong class="text-danger"><i class="bi bi-x-circle me-1"></i>Nhược điểm:</strong>
                            <ul class="mt-2 mb-0 small">
                                <li>Nhiều cuộc họp</li>
                                <li>Quy trình phức tạp</li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="mt-3 pt-3 border-top">
                        <span class="badge bg-light text-dark me-2">
                            <i class="bi bi-building me-1"></i>VNG Corporation
                        </span>
                        <span class="badge bg-light text-dark me-2">
                            <i class="bi bi-briefcase me-1"></i>Marketing
                        </span>
                        <span class="badge bg-success me-2">Khuyên đi làm</span>
                        <button class="btn btn-sm btn-outline-primary float-end">
                            <i class="bi bi-hand-thumbs-up"></i> 15
                        </button>
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
                        <li class="page-item">
                            <a class="page-link" href="#"><i class="bi bi-chevron-right"></i></a>
                        </li>
                    </ul>
                </nav>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">
                        <h5 class="card-title mb-4">
                            <i class="bi bi-bar-chart-fill text-primary me-2"></i>
                            Thống kê đánh giá
                        </h5>
                        
                        <div class="text-center mb-4">
                            <div class="avg-rating">4.6</div>
                            <div class="rating-stars mb-2">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-half"></i>
                            </div>
                            <p class="text-muted mb-0">413 đánh giá</p>
                        </div>
                        
                        <div class="mb-2 d-flex align-items-center">
                            <span class="me-2">5</span>
                            <i class="bi bi-star-fill text-warning me-2"></i>
                            <div class="rating-bar flex-grow-1">
                                <div class="rating-bar-fill" style="width: 75%;"></div>
                            </div>
                            <span class="ms-2 text-muted">75%</span>
                        </div>
                        <div class="mb-2 d-flex align-items-center">
                            <span class="me-2">4</span>
                            <i class="bi bi-star-fill text-warning me-2"></i>
                            <div class="rating-bar flex-grow-1">
                                <div class="rating-bar-fill" style="width: 50%;"></div>
                            </div>
                            <span class="ms-2 text-muted">50%</span>
                        </div>
                        <div class="mb-2 d-flex align-items-center">
                            <span class="me-2">3</span>
                            <i class="bi bi-star-fill text-warning me-2"></i>
                            <div class="rating-bar flex-grow-1">
                                <div class="rating-bar-fill" style="width: 30%;"></div>
                            </div>
                            <span class="ms-2 text-muted">30%</span>
                        </div>
                        <div class="mb-2 d-flex align-items-center">
                            <span class="me-2">2</span>
                            <i class="bi bi-star-fill text-warning me-2"></i>
                            <div class="rating-bar flex-grow-1">
                                <div class="rating-bar-fill" style="width: 15%;"></div>
                            </div>
                            <span class="ms-2 text-muted">15%</span>
                        </div>
                        <div class="d-flex align-items-center">
                            <span class="me-2">1</span>
                            <i class="bi bi-star-fill text-warning me-2"></i>
                            <div class="rating-bar flex-grow-1">
                                <div class="rating-bar-fill" style="width: 5%;"></div>
                            </div>
                            <span class="ms-2 text-muted">5%</span>
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title mb-3">
                            <i class="bi bi-lightbulb-fill text-warning me-2"></i>
                            Mẹo viết đánh giá
                        </h5>
                        <ul class="list-unstyled small">
                            <li class="mb-2"><i class="bi bi-check2 text-success me-2"></i>Mô tả trải nghiệm thực tế của bạn</li>
                            <li class="mb-2"><i class="bi bi-check2 text-success me-2"></i>Chia sẻ cả ưu điểm và nhược điểm</li>
                            <li class="mb-2"><i class="bi bi-check2 text-success me-2"></i>Đánh giá khách quan, trung thực</li>
                            <li><i class="bi bi-check2 text-success me-2"></i>Giúp người khác đưa ra quyết định</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Write Review Modal -->
    <div class="modal fade" id="writeReviewModal" tabindex="-1" aria-labelledby="writeReviewModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content modal-review">
                <div class="modal-header border-0">
                    <h5 class="modal-title" id="writeReviewModalLabel">
                        <i class="bi bi-pencil-square me-2"></i>Viết đánh giá công ty
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="WriteReviewServlet" method="POST">
                    <div class="modal-body">
                        <div class="mb-4">
                            <label class="form-label fw-bold">Chọn công ty</label>
                            <select class="form-select" name="companyId" required>
                                <option value="">-- Chọn công ty --</option>
                                <option value="1">FPT Software</option>
                                <option value="2">VNG Corporation</option>
                                <option value="3">TGĐ Group</option>
                                <option value="4">Viettel</option>
                            </select>
                        </div>
                        
                        <div class="mb-4 text-center">
                            <label class="form-label fw-bold d-block">Đánh giá của bạn</label>
                            <div class="star-rating-input" id="starRating">
                                <span data-rating="1">&#9733;</span>
                                <span data-rating="2">&#9733;</span>
                                <span data-rating="3">&#9733;</span>
                                <span data-rating="4">&#9733;</span>
                                <span data-rating="5">&#9733;</span>
                            </div>
                            <input type="hidden" name="rating" id="ratingValue" value="5">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tiêu đề đánh giá</label>
                            <input type="text" class="form-control" name="title" 
                                   placeholder="Mô tả ngắn gọn trải nghiệm của bạn" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nội dung đánh giá</label>
                            <textarea class="form-control" name="content" rows="4" 
                                      placeholder="Chia sẻ chi tiết trải nghiệm làm việc của bạn..." required></textarea>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Ưu điểm</label>
                                <textarea class="form-control" name="pros" rows="2" 
                                          placeholder="Những điều bạn thích ở công ty..."></textarea>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Nhược điểm</label>
                                <textarea class="form-control" name="cons" rows="2" 
                                          placeholder="Những điều cần cải thiện..."></textarea>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Bạn có khuyên người khác đi làm ở đây không?</label>
                            <div class="btn-group w-100" role="group">
                                <input type="radio" class="btn-check" name="recommend" id="recommendYes" value="yes" checked>
                                <label class="btn btn-outline-success" for="recommendYes">
                                    <i class="bi bi-hand-thumbs-up me-1"></i> Khuyên đi làm
                                </label>
                                <input type="radio" class="btn-check" name="recommend" id="recommendNo" value="no">
                                <label class="btn btn-outline-danger" for="recommendNo">
                                    <i class="bi bi-hand-thumbs-down me-1"></i> Không khuyên
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-write-review">
                            <i class="bi bi-send me-2"></i>Gửi đánh giá
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Star rating interaction
        document.querySelectorAll('.star-rating-input span').forEach(star => {
            star.addEventListener('click', function() {
                const rating = this.dataset.rating;
                document.getElementById('ratingValue').value = rating;
                
                document.querySelectorAll('.star-rating-input span').forEach((s, index) => {
                    if (index < rating) {
                        s.classList.add('active');
                    } else {
                        s.classList.remove('active');
                    }
                });
            });
            
            star.addEventListener('mouseover', function() {
                const rating = this.dataset.rating;
                document.querySelectorAll('.star-rating-input span').forEach((s, index) => {
                    if (index < rating) {
                        s.style.color = '#ffc107';
                    }
                });
            });
            
            star.addEventListener('mouseout', function() {
                const currentRating = document.getElementById('ratingValue').value;
                document.querySelectorAll('.star-rating-input span').forEach((s, index) => {
                    if (index < currentRating) {
                        s.style.color = '#ffc107';
                    } else {
                        s.style.color = '#e9ecef';
                    }
                });
            });
        });
        
        // Filter buttons
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });
    </script>
</body>
</html>
