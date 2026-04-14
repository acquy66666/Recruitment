<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý câu hỏi - JobHub</title>
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
            background-image: url('https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
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
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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

        .stats-card.info {
            border-color: var(--info-color);
            background: linear-gradient(135deg, #e0f7ff 0%, #cce7ff 100%);
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

        .stats-card.info .stats-icon {
            color: var(--info-color);
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

        .question-card {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }

        .question-card:hover {
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

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            border: none;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
            background: white;
        }

        .btn-outline-primary:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .btn-danger {
            color: var(--danger-color);
            border: 2px solid var(--danger-color);
            background: white;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background: var(--danger-color);
            color: white;
            transform: translateY(-2px);
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

        .badge-secondary {
            background-color: rgba(100, 116, 139, 0.1);
            color: var(--gray-color);
        }

        .badge-success {
            background-color: rgba(45, 206, 137, 0.1);
            color: var(--success-color);
        }

        .question-title {
            font-size: 1.125rem;
            font-weight: 600;
            line-height: 1.4;
            margin-bottom: 1rem;
            color: #334155;
        }

        .option-item {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            border-radius: 8px;
            font-size: 0.875rem;
            transition: all 0.2s ease;
        }

        .option-item.correct {
            background-color: rgba(45, 206, 137, 0.1);
            color: var(--success-color);
            border: 1px solid rgba(45, 206, 137, 0.3);
        }

        .option-item.normal {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
        }

        .answer-box {
            padding: 1rem;
            background-color: rgba(45, 206, 137, 0.1);
            border: 1px solid rgba(45, 206, 137, 0.3);
            border-radius: 8px;
            color: var(--success-color);
            font-size: 0.875rem;
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

        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            background: white;
            border: 2px dashed #e9ecef;
            border-radius: 15px;
            color: var(--gray-color);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #9ca3af;
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
                        <i class="bi bi-question-circle me-3"></i>Quản lý câu hỏi
                    </h1>
                    <p class="lead mb-0">Tạo và quản lý câu hỏi cho bài thi của bạn</p>
                    <p class="text-white-50">Xây dựng ngân hàng câu hỏi chất lượng cao</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Alert Messages -->
    <c:if test="${not empty sessionScope.errorMessage}">
        <script>
            alert('${fn:escapeXml(sessionScope.errorMessage)}');
        </script>
        <c:remove var="errorMessage" scope="session" />
    </c:if>

    <!-- Main Content -->
    <div class="container">
        <div class="main-container">
            <div class="p-4">
                <!-- Header Actions -->
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                    <div class="d-flex align-items-center gap-3">
                        <a href="TestManage" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Trở về
                        </a>
                        
                    </div>
                    <div class="d-flex gap-2 flex-wrap">
                        <form method="POST" action="EditTest" onsubmit="return confirm('Bạn chắc chắn muốn xóa bài thi này?');" class="d-inline">
                            <input hidden name="testId" value="${test.testId}">
                            <input hidden name="action" value="delete">
                            <button class="btn btn-danger" type="submit">
                                <i class="bi bi-trash me-2"></i>Xóa bài thi
                            </button>
                        </form>
                        <a class="btn btn-outline-primary" href="AssignmentManagement">
                            <i class="bi bi-clipboard-data me-2"></i>Danh sách bài làm
                        </a>
                        <button class="btn btn-primary" onclick="openAddModal()">
                            <i class="bi bi-plus-lg me-2"></i>Thêm câu hỏi thủ công
                        </button>
                        <button class="btn btn-primary" onclick="openQuestionBatchModal()">
                            <i class="bi bi-upload me-2"></i>Thêm tự động
                        </button>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="stats-grid">
                    <div class="stats-card primary">
                        <div class="stats-icon">
                            <i class="bi bi-question-circle"></i>
                        </div>
                        <div class="stats-number">${totalQuestion}</div>
                        <div class="stats-title">Tổng câu hỏi</div>
                    </div>
                    
                    <div class="stats-card success">
                        <div class="stats-icon">
                            <i class="bi bi-check-circle"></i>
                        </div>
                        <div class="stats-number">${assCount}</div>
                        <div class="stats-title">Bản ghi câu trả lời</div>
                    </div>
                    
                    <div class="stats-card warning">
                        <div class="stats-icon">
                            <i class="bi bi-list-check"></i>
                        </div>
                        <div class="stats-number">${mtpQuestionCount}</div>
                        <div class="stats-title">Câu trắc nghiệm</div>
                    </div>
                    
                    <div class="stats-card info">
                        <div class="stats-icon">
                            <i class="bi bi-text-paragraph"></i>
                        </div>
                        <div class="stats-number">${textQuestionCount}</div>
                        <div class="stats-title">Câu văn bản</div>
                    </div>
                </div>

                <!-- Test Information -->
                <div class="section-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="mb-0 fw-bold">Thông tin bài thi</h3>
                        <div class="d-flex gap-2">
                            <c:choose>
                                <c:when test="${test.status == 'None' || test.status == 'Rejected'}">
                                    <form action="EditTest" method="POST" onsubmit="return confirm('Xác nhận gửi yêu cầu duyệt?');" class="d-inline">
                                        <input hidden name="testId" value="${test.testId}">
                                        <input hidden name="action" value="updateStatus">
                                        <button class="btn btn-outline-primary btn-sm" type="submit">
                                            <i class="bi bi-send me-1"></i>Gửi yêu cầu duyệt
                                        </button>
                                    </form>
                                </c:when>
                            </c:choose>
                            <button class="btn btn-outline-primary btn-sm" onclick="openInfoModal()">
                                <i class="bi bi-pencil me-1"></i>Chỉnh sửa
                            </button>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <strong class="text-muted">Tiêu đề:</strong>
                                <div class="mt-1">${test.title}</div>
                            </div>
                            <div class="mb-3">
                                <strong class="text-muted">Mô tả:</strong>
                                <div class="mt-1">${test.description}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <strong class="text-muted">Trạng thái:</strong>
                                <div class="mt-1">
                                    <c:choose>
                                        <c:when test="${test.status == 'None'}">
                                            <span class="badge bg-secondary">Chưa yêu cầu duyệt</span>
                                        </c:when>
                                        <c:when test="${test.status == 'Pending'}">
                                            <span class="badge bg-warning">Đang chờ duyệt</span>
                                        </c:when>
                                        <c:when test="${test.status == 'Accepted'}">
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:when>
                                        <c:when test="${test.status == 'Rejected'}">
                                            <span class="badge bg-danger">Từ chối</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Không xác định</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="mb-3">
                                <strong class="text-muted">Điểm trung bình:</strong>
                                <div class="mt-1">
                                    <c:choose>
                                        <c:when test="${avgScore > 0}">${avgScore}</c:when>
                                        <c:otherwise>Chưa có thông tin</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="mb-3">
                                <strong class="text-muted">Tỉ lệ đạt (>60%):</strong>
                                <div class="mt-1">${passRate}%</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Questions Section -->
                <div class="section-card">
                    <h3 class="mb-4 fw-bold">Danh sách câu hỏi</h3>
                    
                    <c:choose>
                        <c:when test="${empty questions}">
                            <div class="empty-state">
                                <i class="bi bi-question-circle"></i>
                                <h4>Bài thi này chưa có câu hỏi nào</h4>
                                <p class="text-muted">Chọn "Thêm câu hỏi mới" để bắt đầu</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="question" items="${questions}" varStatus="status">
                                <div class="question-card">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div class="flex-grow-1">
                                            <div class="d-flex align-items-center gap-2 mb-2">
                                                <span class="badge bg-light text-dark">Câu hỏi ${status.index + 1}</span>
                                                <span class="badge ${question.questionType eq 'multiple_choice' ? 'badge-primary' : 'badge-secondary'}">
                                                    ${question.questionType eq 'multiple_choice' ? 'Trắc nghiệm' : 'Văn bản'}
                                                </span>
                                            </div>
                                            <h5 class="question-title"><c:out value="${question.questionText}" /></h5>
                                        </div>
                                        <div class="d-flex gap-2">
                                            <button class="btn btn-outline-primary btn-sm" onclick="editQuestion(${question.questionId}, '<c:out value="${fn:escapeXml(question.questionText)}" />', '${question.questionType}', '<c:out value="${fn:escapeXml(question.options)}" />', '<c:out value="${fn:escapeXml(question.correctAnswer)}" />')">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <form action="DeleteQuestion" method="post" onsubmit="return confirm('Bạn chắc chắn muốn xóa câu hỏi này?');" class="d-inline">
                                                <input type="hidden" name="questionId" value="${question.questionId}" />
                                                <input type="hidden" name="testId" value="${question.testId}" />
                                                <button class="btn btn-danger btn-sm">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                    
                                    <c:choose>
                                        <c:when test="${question.questionType eq 'multiple_choice' and not empty question.optionsList}">
                                            <div class="mb-2">
                                                <strong class="text-muted small">Các lựa chọn:</strong>
                                            </div>
                                            <c:forEach var="opt" items="${question.optionsList}" varStatus="optStatus">
                                                <div class="option-item ${opt eq question.correctAnswer ? 'correct' : 'normal'}">
                                                    <span class="fw-semibold">
                                                        ${fn:substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', optStatus.index, optStatus.index + 1)}.
                                                    </span>
                                                    <span><c:out value="${opt}" /></span>
                                                    <c:if test="${opt eq question.correctAnswer}">
                                                        <span class="badge badge-success ms-auto">Đáp án</span>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="mb-2">
                                                <strong class="text-muted small">Đáp án:</strong>
                                            </div>
                                            <div class="answer-box">
                                                <c:out value="${question.correctAnswer}" />
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Add/Edit Question Modal -->
    <div class="modal fade" id="questionModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Thêm câu hỏi mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="questionForm" action="${pageContext.request.contextPath}/SaveQuestion" method="post">
                    <div class="modal-body">
                        <input type="hidden" id="questionId" name="questionId" value="">
                        <input type="hidden" name="testId" value="${test.testId}">
                        
                        <div class="mb-3">
                            <label class="form-label" for="questionText">Nội dung câu hỏi <span class="text-danger">*</span></label>
                            <textarea id="questionText" name="questionText" class="form-control" rows="3" placeholder="Nhập câu hỏi của bạn..." required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label" for="questionType">Loại câu hỏi</label>
                            <select id="questionType" name="questionType" class="form-select" onchange="toggleQuestionType()">
                                <option value="text">Văn bản</option>
                                <option value="multiple_choice">Trắc nghiệm</option>
                            </select>
                        </div>
                        
                        <div id="optionsSection" class="mb-3" style="display: none;">
                            <label class="form-label">Các lựa chọn</label>
                            <div class="row g-2">
                                <div class="col-12">
                                    <div class="input-group">
                                        <span class="input-group-text">A.</span>
                                        <input type="text" name="optionA" class="form-control option-input" placeholder="Lựa chọn A" data-index="0">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="input-group">
                                        <span class="input-group-text">B.</span>
                                        <input type="text" name="optionB" class="form-control option-input" placeholder="Lựa chọn B" data-index="1">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="input-group">
                                        <span class="input-group-text">C.</span>
                                        <input type="text" name="optionC" class="form-control option-input" placeholder="Lựa chọn C" data-index="2">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="input-group">
                                        <span class="input-group-text">D.</span>
                                        <input type="text" name="optionD" class="form-control option-input" placeholder="Lựa chọn D" data-index="3">
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label" for="correctAnswer">Đáp án đúng <span class="text-danger">*</span></label>
                            <textarea id="correctAnswerText" name="correctAnswerText" class="form-control" rows="2" required></textarea>
                            <select id="correctAnswerSelect" name="correctAnswerSelect" class="form-select" style="display: none;">
                                <option value="">Chọn đáp án đúng</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                        <button type="button" class="btn btn-primary" onclick="saveQuestion()">
                            <span id="saveButtonText">Thêm mới</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Test Info Modal -->
    <div class="modal fade" id="infoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chỉnh sửa thông tin bài thi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="EditTest" method="post" onsubmit="return validateForm()">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update" />
                        <input type="hidden" name="testId" value="${test.testId}">
                        
                        <div class="mb-3">
                            <label class="form-label" for="title">Tiêu đề <span class="text-danger">*</span></label>
                            <input type="text" id="title" name="title" class="form-control" value="${test.title}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label" for="description">Mô tả <span class="text-danger">*</span></label>
                            <textarea id="description" name="description" class="form-control" rows="3" required>${test.description}</textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Batch Upload Modal -->
    <div class="modal fade" id="questionBatchModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm câu hỏi tự động</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="OCRQuestionServlet" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="alert alert-info">
                            <h6 class="alert-heading">Lưu ý:</h6>
                            <ul class="mb-0">
                                <li>Chỉ có thể tự động nhận diện câu hỏi trắc nghiệm</li>
                                <li>Các file có thể xử lý: .pdf, .png, .jpg, .jpeg, .doc, .docx</li>
                            </ul>
                        </div>
                        
                        <input type="hidden" name="action"/>
                        <input type="hidden" name="testId" value="${test.testId}">
                        
                        <div class="mb-3">
                            <label class="form-label">Chọn file</label>
                            <input type="file" name="questionFile" class="form-control" accept=".pdf,.png,.jpg,.jpeg,.doc,.docx" required />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-upload me-2"></i>Tải lên
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        var editingQuestionId = null;

        function openInfoModal() {
            editingQuestionId = null;
            const modal = new bootstrap.Modal(document.getElementById('infoModal'));
            modal.show();
        }

        function openQuestionBatchModal() {
            editingQuestionId = null;
            const modal = new bootstrap.Modal(document.getElementById('questionBatchModal'));
            modal.show();
        }

        function openAddModal() {
            editingQuestionId = null;
            document.getElementById('modalTitle').textContent = 'Thêm câu hỏi mới';
            document.getElementById('saveButtonText').textContent = 'Thêm mới';
            resetForm();
            const modal = new bootstrap.Modal(document.getElementById('questionModal'));
            modal.show();
        }

        function editQuestion(questionId, questionText, questionType, options, correctAnswer) {
            editingQuestionId = questionId;
            document.getElementById('modalTitle').textContent = 'Sửa câu hỏi';
            document.getElementById('saveButtonText').textContent = 'Cập nhật';
            document.getElementById('questionId').value = questionId;

            // Decode HTML entities
            var textArea = document.createElement('textarea');
            textArea.innerHTML = questionText;
            document.getElementById('questionText').value = textArea.value;

            textArea.innerHTML = options;
            var optionsArray = JSON.parse(textArea.value || '[]');

            document.getElementById('questionType').value = questionType;

            if (questionType === 'multiple_choice' && optionsArray.length > 0) {
                try {
                    var optionInputs = document.querySelectorAll('.option-input');
                    for (var i = 0; i < optionInputs.length && i < optionsArray.length; i++) {
                        optionInputs[i].value = optionsArray[i] || '';
                    }
                    updateCorrectAnswerOptions();
                    
                    // Decode correct answer
                    textArea.innerHTML = correctAnswer;
                    document.getElementById('correctAnswerSelect').value = textArea.value;
                } catch (e) {
                    console.error('Error parsing options JSON:', e);
                }
            } else {
                textArea.innerHTML = correctAnswer;
                document.getElementById('correctAnswerText').value = textArea.value;
            }

            toggleQuestionType();
            const modal = new bootstrap.Modal(document.getElementById('questionModal'));
            modal.show();
        }

        function resetForm() {
            document.getElementById('questionForm').reset();
            document.getElementById('questionId').value = '';
            document.getElementById('optionsSection').style.display = 'none';
            document.getElementById('correctAnswerText').style.display = 'block';
            document.getElementById('correctAnswerSelect').style.display = 'none';
            updateCorrectAnswerOptions();
        }

        function toggleQuestionType() {
            var questionType = document.getElementById('questionType').value;
            var optionsSection = document.getElementById('optionsSection');
            var correctAnswerText = document.getElementById('correctAnswerText');
            var correctAnswerSelect = document.getElementById('correctAnswerSelect');

            if (questionType === 'multiple_choice') {
                optionsSection.style.display = 'block';
                correctAnswerText.style.display = 'none';
                correctAnswerSelect.style.display = 'block';

                var optionInputs = document.querySelectorAll('.option-input');
                optionInputs.forEach(input => {
                    input.removeEventListener('input', updateCorrectAnswerOptions);
                    input.addEventListener('input', updateCorrectAnswerOptions);
                });
                updateCorrectAnswerOptions();
            } else {
                optionsSection.style.display = 'none';
                correctAnswerText.style.display = 'block';
                correctAnswerSelect.style.display = 'none';
            }
        }

        function updateCorrectAnswerOptions() {
            var correctAnswerSelect = document.getElementById('correctAnswerSelect');
            var optionInputs = document.querySelectorAll('.option-input');

            correctAnswerSelect.innerHTML = '<option value="">Chọn đáp án đúng</option>';

            optionInputs.forEach((input, index) => {
                if (input.value.trim()) {
                    var option = document.createElement('option');
                    option.value = input.value.trim();
                    option.textContent = String.fromCharCode(65 + index) + '. ' + input.value.trim();
                    correctAnswerSelect.appendChild(option);
                }
            });
        }

        function validateForm() {
            const maxLen = 255;
            const title = document.getElementById('title').value.trim();
            const desc = document.getElementById('description').value.trim();

            if (title.length === 0) {
                alert('Tiêu đề không được để trống.');
                return false;
            }
            if (title.length > maxLen) {
                alert(`Tiêu đề không được vượt quá 255 ký tự.`);
                return false;
            }
            if (desc.length === 0) {
                alert('Mô tả không được để trống.');
                return false;
            }
            if (desc.length > maxLen) {
                alert(`Mô tả không được vượt quá 255 ký tự.`);
                return false;
            }
            return true;
        }

        function saveQuestion() {
            var questionText = document.getElementById('questionText').value.trim();
            var questionType = document.getElementById('questionType').value;

            if (!questionText) {
                alert('Vui lòng nhập nội dung câu hỏi');
                return;
            }

            var correctAnswer = '';
            if (questionType === 'multiple_choice') {
                var optionInputs = document.querySelectorAll('.option-input');
                var optionCount = 0;
                optionInputs.forEach(input => {
                    if (input.value.trim()) {
                        optionCount++;
                    }
                });

                if (optionCount < 2) {
                    alert('Hãy thêm ít nhất 2 đáp án đối với câu trắc nghiệm');
                    return;
                }

                correctAnswer = document.getElementById('correctAnswerSelect').value;
                if (!correctAnswer) {
                    alert('Hãy chọn đáp án đúng');
                    return;
                }
            } else {
                correctAnswer = document.getElementById('correctAnswerText').value.trim();
                if (!correctAnswer) {
                    alert('Hãy điền đáp án đúng');
                    return;
                }
            }

            document.getElementById('questionForm').submit();
        }

        // Initialize
        toggleQuestionType();
    </script>
</body>
</html>