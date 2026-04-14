<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phỏng vấn - JobHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #0046aa;
            --secondary-color: #ff6b00;
            --accent-color: #11cdef;
            --dark-color: #001e44;
            --light-color: #f7fafc;
            --success-color: #2dce89;
        }
        body {
            font-family: 'Poppins', sans-serif;
            color: #525f7f;
            background-color: #f0f6ff;
        }
        .navbar-custom {
            background-color: #f0f6ff;
            box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
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
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-outline-primary:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }
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
            background-image: url('https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
            background-size: cover;
            background-position: center;
            opacity: 0.05;
        }
        .page-header .container {
            position: relative;
            z-index: 1;
        }
        .detail-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 0 30px rgba(0,0,0,0.1);
            margin-top: -2rem;
            position: relative;
            z-index: 10;
            overflow: hidden;
        }
        .detail-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem;
        }
        .company-logo-large {
            width: 5rem;
            height: 5rem;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 2rem;
            margin-bottom: 1rem;
        }
        .info-section {
            padding: 2rem;
            border-bottom: 1px solid #e9ecef;
        }
        .info-section:last-child {
            border-bottom: none;
        }
        .section-title {
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            font-size: 1.25rem;
        }
        .section-title i {
            margin-right: 0.75rem;
            color: var(--primary-color);
            font-size: 1.5rem;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        .info-item {
            display: flex;
            align-items: flex-start;
            padding: 1rem;
            background-color: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid var(--primary-color);
        }
        .info-item i {
            margin-right: 1rem;
            color: var(--primary-color);
            font-size: 1.25rem;
            margin-top: 0.25rem;
            min-width: 24px;
        }
        .info-content {
            flex: 1;
        }
        .info-label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.25rem;
            font-size: 0.875rem;
        }
        .info-value {
            color: #525f7f;
            font-size: 1rem;
            line-height: 1.5;
        }
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50rem;
            font-weight: 600;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
        }
        .status-upcoming {
            background-color: #e3f2fd;
            color: #1976d2;
        }
        .status-completed {
            background-color: #e8f5e8;
            color: #388e3c;
        }
        .interview-type-badge {
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-weight: 500;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
        }
        .type-video {
            background-color: #e3f2fd;
            color: #1976d2;
        }
        .type-onsite {
            background-color: #e8f5e8;
            color: #388e3c;
        }
        .type-phone {
            background-color: #fff3e0;
            color: #f57c00;
        }
        .countdown-timer {
            background: linear-gradient(135deg, #ff6b00 0%, #ff8f00 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.3);
        }
        .countdown-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .countdown-label {
            font-size: 1rem;
            opacity: 0.9;
        }
        .action-section {
            padding: 2rem;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            text-align: center;
        }
        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: center;
            margin-top: 1rem;
        }
        .action-buttons .btn {
            min-width: 150px;
        }
        .description-box {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            border-left: 4px solid var(--primary-color);
            margin-top: 1rem;
        }
        .alert {
            border-radius: 10px;
            border: none;
            padding: 1rem 1.5rem;
        }
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #8898aa;
        }
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        .meta-item {
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }
        .meta-item i {
            margin-right: 0.5rem;
            font-size: 1rem;
        }
        /* DEBUG STYLES */
        .debug-panel {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            font-family: 'Courier New', monospace;
            font-size: 12px;
        }
        .debug-toggle {
            cursor: pointer;
            color: #007bff;
            text-decoration: underline;
            font-weight: bold;
        }
        .debug-content {
            margin-top: 10px;
            background-color: white;
            padding: 10px;
            border-radius: 4px;
            border-left: 4px solid #007bff;
        }
        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
            }
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            .action-buttons .btn {
                width: 100%;
                max-width: 300px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <span style="color: var(--primary-color);">Job</span><span style="color: var(--dark-color);">Hub</span>
            </a>
            <div class="d-flex">
                <a href="CandidateInterview" class="btn btn-outline-primary me-2">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại
                </a>
                <a href="logout" class="btn btn-primary">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-5 fw-bold mb-3">
                        <i class="bi bi-calendar-event me-3"></i>Chi tiết phỏng vấn
                    </h1>
                    <p class="lead mb-0">Thông tin chi tiết về cuộc phỏng vấn của bạn</p>
                </div>
                <div class="col-lg-4 text-lg-end">
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <!-- Alert Messages -->
                <c:if test="${param.success != null}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>${param.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>${param.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty interview}">
                    <!-- DEBUG PANEL -->
                    <c:if test="${debugMode == true}">
                        <div class="debug-panel">
                            <div class="debug-toggle" onclick="toggleDebug()">
                                <i class="bi bi-bug"></i> DEBUG INFORMATION (Click để xem)
                            </div>
                            <div id="debugContent" class="debug-content" style="display: none;">
                                <h6><strong>Interview Object Data:</strong></h6>
                                <p>Interview ID: ${interview.interviewId}</p>
                                <p>Job Title: ${interview.jobTitle}</p>
                                <p>Interview Time: ${interview.interviewTime}</p>
                                <p>Interview Type: ${interview.interviewType}</p>
                                <p>Location: ${interview.location}</p>
                                <p>Interviewers: ${interview.interviewers}</p>
                                <p>Description: ${interview.description}</p>
                                <p>Application ID: ${interview.applicationId}</p>
                                <p>Application Status: ${interview.applicationStatus}</p>
                                <p>Applied At: ${interview.appliedAt}</p>
                                <p>Recruiter Name: ${interview.recruiterName}</p>
                                <p>Recruiter Email: ${interview.recruiterEmail}</p>
                                <p>Recruiter Phone: ${interview.recruiterPhone}</p>
                                <p>Candidate ID: ${interview.candidateId}</p>
                                <p>Candidate Name: ${interview.candidateName}</p>
                                <p>Candidate Email: ${interview.candidateEmail}</p>
                                <p>Candidate Phone: ${interview.candidatePhone}</p>
                                <p>Job ID: ${interview.jobId}</p>
                                <p>Job Description: ${interview.jobDescription}</p>
                                <%-- Removed Job Requirements, Job Benefits, Salary Range from debug display --%>
                            </div>
                        </div>
                    </c:if>

                    <div class="detail-card">
                        <!-- Header -->
                        <div class="detail-header">
                            <div class="row align-items-center">
                                <div class="col-md-2 text-center">
                                    <div class="company-logo-large">
                                        ${interview.jobTitle != null && !interview.jobTitle.isEmpty() ? interview.jobTitle.substring(0,1).toUpperCase() : 'J'}
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <h2 class="mb-2">${interview.jobTitle}</h2>
                                    <div class="meta-item">
                                        <i class="bi bi-calendar"></i>
                                        <span><fmt:formatDate value="${interview.interviewTime}" pattern="EEEE, dd/MM/yyyy 'lúc' HH:mm"/></span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="bi bi-person"></i>
                                        <span>${interview.candidateName}</span>
                                    </div>
                                </div>
                                <div class="col-md-3 text-md-end">
                                    <jsp:useBean id="now" class="java.util.Date" />
                                    <c:choose>
                                        <c:when test="${interview.interviewTime > now}">
                                            <span class="status-badge status-upcoming">
                                                <i class="bi bi-clock me-2"></i>Sắp diễn ra
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-completed">
                                                <i class="bi bi-check-circle me-2"></i>Đã hoàn thành
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="mt-2">
                                        <c:choose>
                                            <c:when test="${interview.interviewType == 'VIDEO'}">
                                                <span class="interview-type-badge type-video">
                                                    <i class="bi bi-camera-video me-1"></i>Video Call
                                                </span>
                                            </c:when>
                                            <c:when test="${interview.interviewType == 'ONSITE'}">
                                                <span class="interview-type-badge type-onsite">
                                                    <i class="bi bi-building me-1"></i>Trực tiếp
                                                </span>
                                            </c:when>
                                            <c:when test="${interview.interviewType == 'PHONE'}">
                                                <span class="interview-type-badge type-phone">
                                                    <i class="bi bi-telephone me-1"></i>Điện thoại
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="interview-type-badge">${interview.interviewType}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Countdown Timer (chỉ hiện khi phỏng vấn sắp tới) -->
                        <c:if test="${interview.interviewTime > now}">
                            <div class="info-section">
                                <div class="countdown-timer" id="countdownTimer">
                                    <div class="countdown-number" id="countdownDisplay">Đang tính toán...</div>
                                    <div class="countdown-label">Thời gian còn lại</div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Thông tin cơ bản -->
                        <div class="info-section">
                            <h5 class="section-title">
                                <i class="bi bi-info-circle"></i>Thông tin phỏng vấn
                            </h5>
                            <div class="info-grid">
                                <c:if test="${not empty interview.interviewers}">
                                <div class="info-item">
                                    <i class="bi bi-people"></i>
                                    <div class="info-content">
                                        <div class="info-label">Tên ứng viên</div>
                                        <div class="info-value">${interview.candidateName}</div>
                                    </div>
                                </div>
                            </c:if>
                                <div class="info-item">
                                    <i class="bi bi-calendar"></i>
                                    <div class="info-content">
                                        <div class="info-label">Ngày phỏng vấn</div>
                                        <div class="info-value">
                                            <fmt:formatDate value="${interview.interviewTime}" pattern="dd/MM/yyyy"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <i class="bi bi-clock"></i>
                                    <div class="info-content">
                                        <div class="info-label">Giờ phỏng vấn</div>
                                        <div class="info-value">
                                            <fmt:formatDate value="${interview.interviewTime}" pattern="HH:mm"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <i class="bi bi-geo-alt"></i>
                                    <div class="info-content">
                                        <div class="info-label">Địa điểm / Link</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty interview.location}">
                                                    <c:choose>
                                                        <c:when test="${interview.interviewType == 'VIDEO' && (interview.location.startsWith('http') || interview.location.startsWith('https'))}">
                                                            <a href="${interview.location}" target="_blank" class="text-decoration-none">
                                                                ${interview.location}
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${interview.location}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa cập nhật</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <i class="bi bi-calendar-check"></i>
                                    <div class="info-content">
                                        <div class="info-label">Ngày ứng tuyển</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${not empty interview.appliedAt}">
                                                    <fmt:formatDate value="${interview.appliedAt}" pattern="dd/MM/yyyy"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa cập nhật</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Thông tin người phỏng vấn -->
                        <div class="info-section">
                            <h5 class="section-title">
                                <i class="bi bi-person-badge"></i>Thông tin liên hệ
                            </h5>
                            <div class="info-grid">
                                <div class="info-item">
                                    <i class="bi bi-person"></i>
                                    <div class="info-content">
                                        <div class="info-label">Người phỏng vấn</div>
                                        <div class="info-value">${interview.interviewers}</div>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <i class="bi bi-envelope"></i>
                                    <div class="info-content">
                                        <div class="info-label">Email liên hệ</div>
                                        <div class="info-value">
                                            <a href="mailto:${interview.recruiterEmail}" class="text-decoration-none">
                                                ${interview.recruiterEmail}
                                            </a>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${not empty interview.recruiterPhone}">
                                <div class="info-item">
                                    <i class="bi bi-telephone"></i>
                                    <div class="info-content">
                                        <div class="info-label">Số điện thoại</div>
                                        <div class="info-value">
                                            <a href="tel:${interview.recruiterPhone}" class="text-decoration-none">
                                                ${interview.recruiterPhone}
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Ghi chú phỏng vấn (thay thế Thông tin công việc) -->
                    <div class="info-section">
                        <h5 class="section-title">
                            <i class="bi bi-card-text"></i>Mô tả phỏng vấn
                        </h5>
                        <c:if test="${not empty interview.description}">
                            <div class="description-box">
                                <div class="info-value">${interview.description}</div>
                            </div>
                        </c:if>
                        <c:if test="${empty interview.description}">
                            <div class="description-box">
                                <div class="info-value text-muted">Chưa có mô tả phỏng vấn.</div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-section">
                        <div class="action-buttons">
                            <c:if test="${interview.interviewTime > now}">
                                <c:if test="${interview.interviewType == 'VIDEO' && not empty interview.location}">
                                    <a href="${interview.location}" target="_blank" class="btn btn-primary">
                                        <i class="bi bi-camera-video me-2"></i>Tham gia phỏng vấn
                                    </a>
                                </c:if>
                            </c:if>
                            
                            <a href="mailto:${interview.recruiterEmail}" class="btn btn-outline-primary">
                                <i class="bi bi-envelope me-2"></i>Liên hệ HR
                            </a>
                            
                            <c:if test="${not empty interview.recruiterPhone}">
                                <a href="tel:${interview.recruiterPhone}" class="btn btn-outline-primary">
                                    <i class="bi bi-telephone me-2"></i>Gọi điện
                                </a>
                            </c:if>
                            
                            <a href="CandidateInterview" class="btn btn-outline-primary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách
                            </a>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${empty interview}">
                    <div class="detail-card">
                        <div class="empty-state">
                            <i class="bi bi-exclamation-triangle"></i>
                            <h4 class="text-muted">Không tìm thấy thông tin phỏng vấn</h4>
                            <p class="text-muted">Phỏng vấn không tồn tại hoặc bạn không có quyền xem.</p>
                            <a href="CandidateInterview" class="btn btn-primary">
                                <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách
                            </a>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleDebug() {
            const debugContent = document.getElementById('debugContent');
            if (debugContent.style.display === 'none') {
                debugContent.style.display = 'block';
            } else {
                debugContent.style.display = 'none';
            }
        }

        // Countdown timer
        function updateCountdown() {
            const interviewTime = new Date('${interview.interviewTime}').getTime();
            const now = new Date().getTime();
            const distance = interviewTime - now;
            
            if (distance > 0) {
                const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);
                
                let countdownText = '';
                if (days > 0) {
                    countdownText += days + ' ngày ';
                }
                if (hours > 0) {
                    countdownText += hours + ' giờ ';
                }
                if (minutes > 0) {
                    countdownText += minutes + ' phút ';
                }
                countdownText += seconds + ' giây';
                
                document.getElementById('countdownDisplay').innerHTML = countdownText;
            } else {
                document.getElementById('countdownTimer').innerHTML = '<div class="countdown-number">Đã bắt đầu</div><div class="countdown-label">Phỏng vấn đang diễn ra</div>';
            }
        }
        
        // Update countdown every second
        <c:if test="${interview.interviewTime != null && interview.interviewTime.time > now.time}">
            setInterval(updateCountdown, 1000);
            updateCountdown(); // Initial call
        </c:if>
        
        // Auto-refresh page when interview time arrives
        <c:if test="${interview.interviewTime != null && interview.interviewTime.time > now.time}">
            setTimeout(function() {
                window.location.reload();
            }, ${interview.interviewTime.time - now.time});
        </c:if>
        <c:if test="${interview.interviewTime == null || interview.interviewTime.time <= now.time}">
            // If interview time is null or in the past, refresh every 5 minutes (default)
            setTimeout(function() {
                window.location.reload();
            }, 300000); 
        </c:if>
    </script>
</body>
</html>
