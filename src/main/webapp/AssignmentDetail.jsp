<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết bài làm - JobHub</title>
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
            background-image: url('https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
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

        .badge-danger {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
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

        .option-item.user-selected {
            background-color: rgba(251, 99, 64, 0.1);
            color: var(--warning-color);
            border: 1px solid rgba(251, 99, 64, 0.3);
        }

        .option-item.user-selected.correct {
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
            margin-bottom: 0.5rem;
        }

        .user-answer-box {
            padding: 1rem;
            background-color: rgba(251, 99, 64, 0.1);
            border: 1px solid rgba(251, 99, 64, 0.3);
            border-radius: 8px;
            color: var(--warning-color);
            font-size: 0.875rem;
        }

        .user-answer-box.correct {
            background-color: rgba(45, 206, 137, 0.1);
            border: 1px solid rgba(45, 206, 137, 0.3);
            color: var(--success-color);
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

        .question-display, .answer-display {
            padding: 0.75rem;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.875rem;
            line-height: 1.5;
        }

        .answer-display.user-answer {
            background-color: rgba(251, 99, 64, 0.1);
            border-color: rgba(251, 99, 64, 0.3);
        }

        .evaluation-options {
            display: flex;
            gap: 1rem;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
        }

        .radio-option input[type="radio"] {
            width: 16px;
            height: 16px;
        }

        .radio-label {
            font-size: 0.875rem;
            font-weight: 500;
        }

        .radio-label.correct {
            color: var(--success-color);
        }

        .radio-label.incorrect {
            color: var(--danger-color);
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
                        <i class="bi bi-clipboard-data me-3"></i>Chi tiết bài làm
                    </h1>
                    <p class="lead mb-0">Xem chi tiết kết quả và đánh giá bài làm của ứng viên</p>
                    <p class="text-white-50">Theo dõi tiến độ và chấm điểm chính xác</p>
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
                    <div class="d-flex align-items-center gap-3">
                        <a href="AssignmentManagement" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Trở về
                        </a>
                        <div>
                            <h2 class="mb-1 fw-bold">Chi tiết bài làm</h2>
                            <p class="text-muted mb-0">Kết quả và đánh giá chi tiết</p>
                        </div>
                    </div>
                    <div>
                        <form action="EvaluateByGemini" method="post" onsubmit="return confirmReEvaluate()" class="d-inline">
                            <input type="hidden" name="action" value="reevaluate" />
                            <input type="hidden" name="assignmentId" value="${assignment.assignmentId}" />
                            <input type="hidden" name="candidateId" value="${param.candidateId}" />
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-robot me-2"></i>Chấm lại bằng AI
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="stats-grid">
                    <div class="stats-card primary">
                        <div class="stats-icon">
                            <i class="bi bi-question-circle"></i>
                        </div>
                        <div class="stats-number">${fn:length(questions)}</div>
                        <div class="stats-title">Tổng câu hỏi</div>
                    </div>
                    
                    <div class="stats-card success">
                        <div class="stats-icon">
                            <i class="bi bi-check-circle"></i>
                        </div>
                        <div class="stats-number">${assignment.correctAnswer}</div>
                        <div class="stats-title">Câu trả lời đúng</div>
                    </div>
                    
                    <div class="stats-card warning">
                        <div class="stats-icon">
                            <i class="bi bi-chat-dots"></i>
                        </div>
                        <div class="stats-number">
                            <c:set var="answeredCount" value="0" />
                            <c:forEach var="question" items="${questions}">
                                <c:if test="${not empty question.userResponse}">
                                    <c:set var="answeredCount" value="${answeredCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${answeredCount}
                        </div>
                        <div class="stats-title">Câu đã trả lời</div>
                    </div>
                    
                    <div class="stats-card danger">
                        <div class="stats-icon">
                            <i class="bi bi-award"></i>
                        </div>
                        <div class="stats-number">${assignment.score}%</div>
                        <div class="stats-title">Điểm số</div>
                    </div>
                </div>

                <!-- Assignment Information -->
                <div class="section-card">
                    <h3 class="mb-4 fw-bold">Thông tin chi tiết</h3>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <strong class="text-muted">Tên ứng viên:</strong>
                                <div class="mt-1">${candidate.fullName}</div>
                            </div>
                            <div class="mb-3">
                                <strong class="text-muted">Email:</strong>
                                <div class="mt-1">${candidate.email}</div>
                            </div>
                            <div class="mb-3">
                                <strong class="text-muted">Tên bài thi:</strong>
                                <div class="mt-1">${test.title}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <strong class="text-muted">Ngày giao:</strong>
                                <div class="mt-1">
                                    <fmt:formatDate value="${assignment.assignedAt}" pattern="dd/MM/yyyy"/>
                                </div>
                            </div>
                            <div class="mb-3">
                                <strong class="text-muted">Tình trạng:</strong>
                                <div class="mt-1">
                                    <c:choose>
                                        <c:when test="${assignment.status == 'completed'}">
                                            <span class="badge bg-success">Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${assignment.status == 'doing'}">
                                            <span class="badge bg-warning">Đang thực hiện</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${assignment.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="mb-3">
                                <strong class="text-muted">Tỉ lệ hoàn thành:</strong>
                                <div class="mt-1">
                                    <c:choose>
                                        <c:when test="${fn:length(questions) > 0}">
                                            ${Math.round(answeredCount * 100.0 / fn:length(questions))}%
                                        </c:when>
                                        <c:otherwise>0%</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Questions Section -->
                <div class="section-card">
                    <h3 class="mb-4 fw-bold">Danh sách câu hỏi và câu trả lời</h3>
                    
                    <c:choose>
                        <c:when test="${empty questions}">
                            <div class="empty-state">
                                <i class="bi bi-question-circle"></i>
                                <h4>Không tìm thấy câu hỏi nào</h4>
                                <p class="text-muted">Bài thi này có thể chưa được cấu hình câu hỏi</p>
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
                                                <c:choose>
                                                    <c:when test="${empty question.userResponse}">
                                                        <span class="badge badge-secondary">Chưa trả lời</span>
                                                    </c:when>
                                                    <c:when test="${question.isCorrect}">
                                                        <span class="badge badge-success">Đúng</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-danger">Sai</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <h5 class="question-title"><c:out value="${question.questionText}" /></h5>
                                        </div>
                                        <c:if test="${question.questionType == 'text'}">
                                            <button class="btn btn-outline-primary btn-sm" onclick="openRemarkModal(${question.responseId}, '${fn:escapeXml(question.questionText)}', '${fn:escapeXml(question.correctAnswer)}', '${fn:escapeXml(question.userResponse)}', ${question.isCorrect})">
                                                <i class="bi bi-pencil me-1"></i>Đánh giá
                                            </button>
                                        </c:if>
                                    </div>
                                    
                                    <c:choose>
                                        <c:when test="${question.questionType eq 'multiple_choice' and not empty question.optionsList}">
                                            <div class="mb-2">
                                                <strong class="text-muted small">Các lựa chọn:</strong>
                                            </div>
                                            <c:forEach var="opt" items="${question.optionsList}" varStatus="optStatus">
                                                <div class="option-item ${opt eq question.correctAnswer ? 'correct' : 'normal'} ${opt eq question.userResponse ? 'user-selected' : ''}">
                                                    <span class="fw-semibold">
                                                        ${fn:substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', optStatus.index, optStatus.index + 1)}.
                                                    </span>
                                                    <span><c:out value="${opt}" /></span>
                                                    <c:if test="${opt eq question.correctAnswer}">
                                                        <span class="badge badge-success ms-auto">Đáp án</span>
                                                    </c:if>
                                                    <c:if test="${opt eq question.userResponse and opt ne question.correctAnswer}">
                                                        <span class="badge badge-danger ms-auto">Lựa chọn của ứng viên</span>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="mb-2">
                                                <strong class="text-muted small">Đáp án đúng:</strong>
                                            </div>
                                            <div class="answer-box">
                                                <c:out value="${question.correctAnswer}" />
                                            </div>
                                            <c:if test="${not empty question.userResponse}">
                                                <div class="mb-2">
                                                    <strong class="text-muted small">Câu trả lời của ứng viên:</strong>
                                                </div>
                                                <div class="user-answer-box ${question.isCorrect ? 'correct' : ''}">
                                                    <c:out value="${question.userResponse}" />
                                                </div>
                                            </c:if>
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

    <!-- Evaluation Modal -->
    <div class="modal fade" id="remarkModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Đánh giá câu trả lời</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="AssignmentDetail" method="post" onsubmit="return validateRemarkForm()">
                    <div class="modal-body">
                        <input type="hidden" id="responseQuestionId" name="responseId" value="">
                        <input type="hidden" name="assignmentId" value="${assignment.assignmentId}">
                        <input type="hidden" name="candidateId" value="${candidate.candidateId}">
                        
                        <div class="mb-3">
                            <label class="form-label">Câu hỏi:</label>
                            <div id="questionTextDisplay" class="question-display"></div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Đáp án đúng:</label>
                            <div id="correctAnswerDisplay" class="answer-display"></div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Câu trả lời của ứng viên:</label>
                            <div id="userAnswerDisplay" class="answer-display user-answer"></div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Đánh giá:</label>
                            <div class="evaluation-options">
                                <label class="radio-option">
                                    <input type="radio" name="isCorrect" value="true" id="correctOption">
                                    <span class="radio-label correct">Đúng</span>
                                </label>
                                <label class="radio-option">
                                    <input type="radio" name="isCorrect" value="false" id="incorrectOption">
                                    <span class="radio-label incorrect">Sai</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu đánh giá</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        let currentResponseId = null;
        let currentQuestionData = null;

        function openRemarkModal(responseId, questionText, correctAnswer, userResponse, isCorrect) {
            currentResponseId = responseId;
            currentQuestionData = {
                questionText: questionText,
                correctAnswer: correctAnswer,
                userResponse: userResponse,
                isCorrect: isCorrect
            };

            // Set form data
            document.getElementById('responseQuestionId').value = responseId;
            document.getElementById('questionTextDisplay').textContent = questionText;
            document.getElementById('correctAnswerDisplay').textContent = correctAnswer;
            document.getElementById('userAnswerDisplay').textContent = userResponse || 'Chưa trả lời';

            // Set current evaluation
            if (isCorrect !== null) {
                if (isCorrect) {
                    document.getElementById('correctOption').checked = true;
                } else {
                    document.getElementById('incorrectOption').checked = true;
                }
            }

            // Show modal
            const modal = new bootstrap.Modal(document.getElementById('remarkModal'));
            modal.show();
        }

        function validateRemarkForm() {
            const isCorrectSelected = document.querySelector('input[name="isCorrect"]:checked');
            if (!isCorrectSelected) {
                alert('Vui lòng chọn đánh giá đúng hoặc sai.');
                return false;
            }
            return true;
        }

        function confirmReEvaluate() {
            return confirm("Bạn có chắc chắn muốn chấm lại bài test bằng AI?");
        }

        // Reset modal when hidden
        document.getElementById('remarkModal').addEventListener('hidden.bs.modal', function () {
            document.getElementById('responseQuestionId').value = '';
            document.getElementById('questionTextDisplay').textContent = '';
            document.getElementById('correctAnswerDisplay').textContent = '';
            document.getElementById('userAnswerDisplay').textContent = '';
            document.querySelectorAll('input[name="isCorrect"]').forEach(radio => radio.checked = false);
        });
    </script>
</body>
</html>
