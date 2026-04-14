<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch phỏng vấn của tôi - JobHub</title>
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
            .stats-card {
                background-color: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                text-align: center;
                height: 100%;
                transition: all 0.3s ease;
            }
            .stats-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }
            .stats-number {
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 0.5rem;
            }
            .stats-title {
                color: #8898aa;
                font-size: 0.875rem;
                font-weight: 500;
            }
            .filter-card {
                background-color: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }
            .interview-card {
                background-color: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 0 30px rgba(0,0,0,0.1);
                transition: all 0.3s;
                border: none;
                margin-bottom: 1.5rem;
                cursor: pointer; /* Thêm cursor pointer */
            }
            .interview-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }
            /* Ngăn event bubbling cho các nút */
            .action-buttons {
                position: relative;
                z-index: 10;
            }
            .action-buttons .btn {
                position: relative;
                z-index: 11;
            }
            .interview-card .card-body {
                padding: 1.5rem;
            }
            .company-logo {
                width: 4rem;
                height: 4rem;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #f5f9fc;
                background: linear-gradient(45deg, var(--primary-color), #0051ff);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: bold;
                font-size: 1.5rem;
            }
            .job-title {
                font-weight: 700;
                color: var(--dark-color);
                margin: 0.5rem 0;
                font-size: 1.25rem;
            }
            .company-name {
                color: #8898aa;
                font-weight: 500;
                margin-bottom: 1rem;
            }
            .interview-meta {
                display: flex;
                flex-wrap: wrap;
                margin-bottom: 1rem;
            }
            .meta-item {
                display: flex;
                align-items: center;
                margin-right: 1.5rem;
                margin-bottom: 0.5rem;
                color: #8898aa;
                font-size: 0.875rem;
            }
            .meta-item i {
                margin-right: 0.5rem;
                font-size: 1rem;
                color: var(--primary-color);
            }
            .status-badge {
                padding: 0.35em 0.65em;
                font-size: 0.75rem;
                font-weight: 600;
                border-radius: 50rem;
            }
            .status-scheduled {
                background-color: #e3f2fd;
                color: #1976d2;
            }
            .status-completed {
                background-color: #e8f5e8;
                color: #388e3c;
            }
            .status-cancelled {
                background-color: #ffebee;
                color: #d32f2f;
            }
            .interview-type-badge {
                padding: 0.25em 0.5em;
                font-size: 0.75rem;
                font-weight: 500;
                border-radius: 0.375rem;
                background-color: #f8f9fa;
                color: #495057;
            }
            .interview-type-video {
                background-color: #e3f2fd;
                color: #1976d2;
            }
            .interview-type-onsite {
                background-color: #e8f5e8;
                color: #388e3c;
            }
            .interview-type-phone {
                background-color: #fff3e0;
                color: #f57c00;
            }
            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(0, 70, 170, 0.25);
            }
            .alert {
                border-radius: 10px;
                border: none;
                padding: 1rem 1.5rem;
            }
            .alert-success {
                background: linear-gradient(135deg, #e8f5e8 0%, #d4edda 100%);
                color: #2e7d32;
            }
            .alert-danger {
                background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 100%);
                color: #d32f2f;
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
            .nav-pills .nav-link {
                border-radius: 10px;
                font-weight: 600;
                padding: 0.75rem 1.5rem;
                margin-right: 0.5rem;
                transition: all 0.3s ease;
            }
            .nav-pills .nav-link.active {
                background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
                box-shadow: 0 4px 15px rgba(0, 70, 170, 0.3);
            }
            .nav-pills .nav-link:not(.active) {
                color: var(--primary-color);
                background-color: #f8f9fa;
            }
            .nav-pills .nav-link:not(.active):hover {
                background-color: #e9ecef;
                color: var(--dark-color);
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
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
            <div class="container">
                <a class="navbar-brand" href="HomePage">
                    <span style="color: var(--primary-color);">Job</span><span style="color: var(--dark-color);">Hub</span>
                </a>
                <div class="d-flex">
                    <a href="candidate-dashboard" class="btn btn-outline-primary me-2">Dashboard</a>
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
                            <i class="bi bi-calendar-check me-3"></i>Lịch phỏng vấn của tôi
                        </h1>
                        <p class="lead mb-0">Theo dõi và quản lý các cuộc phỏng vấn sắp tới</p>
                    </div>
                    <div class="col-lg-4 text-lg-end">
                    </div>
                </div>
            </div>
        </section>

        <!-- Main Content -->
        <div class="container mt-4">

            <!-- DEBUG PANEL -->
            <c:if test="${debugMode == true}">
                <div class="debug-panel">
                    <div class="debug-toggle" onclick="toggleDebug()">
                        <i class="bi bi-bug"></i> DEBUG INFORMATION (Click để xem)
                    </div>
                    <div id="debugContent" class="debug-content" style="display: none;">
                        <h6><strong>Session Information:</strong></h6>
                        <p>Candidate ID: ${candidate.candidateId}</p>
                        <p>Candidate Name: ${candidate.fullName}</p>
                        <p>Candidate Email: ${candidate.email}</p>

                        <h6><strong>Database Information:</strong></h6>
                        <c:if test="${not empty debugInfo}">
                            <c:forEach var="entry" items="${debugInfo}">
                                <p>${entry.key}: ${entry.value}</p>
                            </c:forEach>
                        </c:if>

                        <h6><strong>Request Information:</strong></h6>
                        <p>Current Filter: ${currentFilter}</p>
                        <p>Total Interviews: ${totalInterviews}</p>
                        <p>Upcoming Count: ${upcomingCount}</p>
                        <p>Completed Count: ${completedCount}</p>
                        <p>Interviews List Size: ${interviews.size()}</p>

                        <h6><strong>Interview Data:</strong></h6>
                        <c:choose>
                            <c:when test="${not empty interviews}">
                                <c:forEach var="interview" items="${interviews}" varStatus="status">
                                    <p>Interview ${status.index + 1}:</p>
                                    <p>&nbsp;&nbsp;- ID: ${interview.interviewId}</p>
                                    <p>&nbsp;&nbsp;- Job: ${interview.jobTitle}</p>
                                    <p>&nbsp;&nbsp;- Time: ${interview.interviewTime}</p>
                                    <p>&nbsp;&nbsp;- Type: ${interview.interviewType}</p>
                                    <p>&nbsp;&nbsp;- Recruiter: ${interview.recruiterName}</p>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p style="color: red;">No interviews found in list!</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:if>

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

            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="stats-card">
                        <div class="stats-number">${totalInterviews != null ? totalInterviews : 0}</div>
                        <div class="stats-title">Tổng phỏng vấn</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card">
                        <div class="stats-number">${upcomingCount != null ? upcomingCount : 0}</div>
                        <div class="stats-title">Sắp tới</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card">
                        <div class="stats-number">${completedCount != null ? completedCount : 0}</div>
                        <div class="stats-title">Đã hoàn thành</div>
                    </div>
                </div>
            </div>

            <!-- Filter Tabs -->
            <div class="filter-card">
                <ul class="nav nav-pills justify-content-center">
                    <li class="nav-item">
                        <a class="nav-link ${currentFilter == 'all' || currentFilter == null ? 'active' : ''}" 
                           href="CandidateInterview?filter=all">
                            <i class="bi bi-list me-2"></i>Tất cả (${totalInterviews != null ? totalInterviews : 0})
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${currentFilter == 'upcoming' ? 'active' : ''}" 
                           href="CandidateInterview?filter=upcoming">
                            <i class="bi bi-clock me-2"></i>Sắp tới (${upcomingCount != null ? upcomingCount : 0})
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Interviews List -->
            <div class="row">
                <c:choose>
                    <c:when test="${not empty interviews}">
                        <c:forEach var="interview" items="${interviews}">
                            <div class="col-lg-6">
                                <div class="interview-card" onclick="viewInterviewDetail(${interview.interviewId})" data-interview-id="${interview.interviewId}">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start">
                                            <div class="company-logo me-3">
                                                ${interview.jobTitle != null && !interview.jobTitle.isEmpty() ? interview.jobTitle.substring(0,1).toUpperCase() : 'J'}
                                            </div>
                                            <div class="flex-grow-1">
                                                <h5 class="job-title">${interview.jobTitle}</h5>


                                                <div class="interview-meta">
                                                    <div class="meta-item">
                                                        <i class="bi bi-calendar"></i>
                                                        <span><fmt:formatDate value="${interview.interviewTime}" pattern="dd/MM/yyyy"/></span>
                                                    </div>
                                                    <div class="meta-item">
                                                        <i class="bi bi-clock"></i>
                                                        <span><fmt:formatDate value="${interview.interviewTime}" pattern="HH:mm"/></span>
                                                    </div>
                                                </div>

                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <c:choose>
                                                        <c:when test="${interview.interviewType == 'VIDEO'}">
                                                            <span class="interview-type-badge interview-type-video">
                                                                <i class="bi bi-camera-video me-1"></i>Video Call
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${interview.interviewType == 'ONSITE'}">
                                                            <span class="interview-type-badge interview-type-onsite">
                                                                <i class="bi bi-building me-1"></i>Trực tiếp
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${interview.interviewType == 'PHONE'}">
                                                            <span class="interview-type-badge interview-type-phone">
                                                                <i class="bi bi-telephone me-1"></i>Điện thoại
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="interview-type-badge">${interview.interviewType}</span>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <jsp:useBean id="now" class="java.util.Date" />
                                                    <c:choose>
                                                        <c:when test="${interview.interviewTime > now}">
                                                            <span class="status-badge status-scheduled">
                                                                <i class="bi bi-clock me-1"></i>Sắp tới
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge status-completed">
                                                                <i class="bi bi-check-circle me-1"></i>Đã qua
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <div class="d-flex gap-2 action-buttons">
                                                    <c:if test="${interview.interviewTime > now}">
                                                        <c:if test="${interview.interviewType == 'VIDEO'}">
                                                            <%--
                                                            <button class="btn btn-primary btn-sm flex-fill" 
                                                                    onclick="event.stopPropagation(); window.open('${interview.jobLocation}', '_blank')">
                                                                <i class="bi bi-camera-video me-1"></i>Tham gia
                                                            </button>
                                                            --%>
                                                            <c:forEach var="app" items="${listScheduleCandidate}">
                                                                <form action="viewMeeting" method="post" style="display:inline;">
                                                                    <input type="hidden" name="application_id" value="${app.getApplicationId()}" />
                                                                    <input type="hidden" name="candidateName" value="${app.getCandidateName()}" />
                                                                    <button type="submit" class="btn btn-primary btn-sm flex-fill">
                                                                        <i class="bi bi-camera-video me-1"></i>Tham gia
                                                                    </button>
                                                                </form>
                                                            </c:forEach>
                                                        </c:if>
                                                    </c:if>
                                                    <button class="btn btn-outline-primary btn-sm" 
                                                            onclick="event.stopPropagation(); window.open('mailto:${interview.recruiterEmail}', '_blank')">
                                                        <i class="bi bi-envelope me-1"></i>Liên hệ HR
                                                    </button>
                                                </div>

                                                <!-- DEBUG INFO cho từng interview -->
                                                <c:if test="${debugMode == true}">
                                                    <small class="text-muted mt-2 d-block">
                                                        DEBUG: ID=${interview.interviewId}, AppID=${interview.applicationId}, RecruiterID=${interview.recruiterId}
                                                    </small>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="empty-state">
                                <c:choose>
                                    <c:when test="${currentFilter == 'upcoming'}">
                                        <i class="bi bi-calendar-x"></i>
                                        <h4>Không có phỏng vấn sắp tới</h4>
                                        <p>Bạn chưa có lịch phỏng vấn nào được sắp xếp trong thời gian tới.</p>
                                        <a href="CandidateInterview?filter=all" class="btn btn-primary">
                                            <i class="bi bi-list me-2"></i>Xem tất cả phỏng vấn
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-calendar"></i>
                                        <h4>Chưa có phỏng vấn nào</h4>
                                        <p>Bạn chưa có lịch phỏng vấn nào. Hãy ứng tuyển vào các vị trí phù hợp để có cơ hội phỏng vấn.</p>
                                        <a href="job-search" class="btn btn-primary">
                                            <i class="bi bi-search me-2"></i>Tìm việc làm
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
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

                                                                // Set current time for comparison
                                                                const now = new Date();

                                                                // Auto-refresh page every 5 minutes to update interview status
                                                                setTimeout(function () {
                                                                    window.location.reload();
                                                                }, 300000); // 5 minutes

                                                                // Show notification for upcoming interviews (within 1 hour)
                                                                document.addEventListener('DOMContentLoaded', function () {
                                                                    const upcomingInterviews = document.querySelectorAll('.status-scheduled');
                                                                    upcomingInterviews.forEach(function (element) {
                                                                        const card = element.closest('.interview-card');
                                                                        const timeElement = card.querySelector('.meta-item i.bi-clock').nextElementSibling;
                                                                        const dateElement = card.querySelector('.meta-item i.bi-calendar').nextElementSibling;

                                                                        if (timeElement && dateElement) {
                                                                            const interviewDateTime = new Date(dateElement.textContent.split('/').reverse().join('-') + 'T' + timeElement.textContent);
                                                                            const timeDiff = interviewDateTime - now;
                                                                            const hoursDiff = timeDiff / (1000 * 60 * 60);

                                                                            if (hoursDiff > 0 && hoursDiff <= 1) {
                                                                                card.style.border = '2px solid #ff6b00';
                                                                                card.style.boxShadow = '0 0 20px rgba(255, 107, 0, 0.3)';

                                                                                // Add notification badge
                                                                                const badge = document.createElement('span');
                                                                                badge.className = 'badge bg-warning position-absolute top-0 start-100 translate-middle';
                                                                                badge.innerHTML = '<i class="bi bi-bell"></i>';
                                                                                badge.style.zIndex = '10';
                                                                                card.style.position = 'relative';
                                                                                card.appendChild(badge);
                                                                            }
                                                                        }
                                                                    });

                                                                    // Add click prevention for action buttons
                                                                    const actionButtons = document.querySelectorAll('.action-buttons .btn');
                                                                    actionButtons.forEach(function (button) {
                                                                        button.addEventListener('click', function (e) {
                                                                            e.stopPropagation();
                                                                        });
                                                                    });
                                                                });

                                                                // Function để xem chi tiết phỏng vấn
                                                                function viewInterviewDetail(interviewId) {
                                                                    window.location.href = 'InterviewDetail?id=' + interviewId;
                                                                }
        </script>
    </body>
</html>
