<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Việc làm đã lưu - JobHub</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #3b4cb8 0%, #4169e1 25%, #5b9bd5 50%, #6bb6ff 75%, #87ceeb 100%);
            min-height: 100vh;
        }

        .header {
            background: white;
            padding: 0.75rem 0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .logo {
            font-size: 1.75rem;
            font-weight: 700;
            color: #2563eb;
            text-decoration: none;
        }

        .nav-left {
            display: flex;
            align-items: center;
            flex: 1;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 2.5rem;
            margin-left: 3rem;
        }

        .nav-menu a {
            text-decoration: none;
            color: #374151;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-menu a:hover {
            color: #2563eb;
        }

        .auth-buttons {
            display: flex;
            gap: 0.75rem;
        }

        .btn {
            padding: 0.6rem 1.25rem;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: 1px solid transparent;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-outline {
            border: 1px solid #2563eb;
            color: #2563eb;
            background: white;
        }

        .btn-primary {
            background: #2563eb;
            color: white;
        }

        .btn-secondary {
            background: #6b7280;
            color: white;
            border: 1px solid #6b7280;
        }

        .btn-secondary:hover {
            background: #4b5563;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .page-header {
            text-align: center;
            color: white;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .stats-section {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #2563eb;
        }

        .job-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            margin-bottom: 1.5rem;
            position: relative;
            transition: all 0.3s ease;
        }

        .job-card.removing {
            opacity: 0.5;
            transform: scale(0.98);
        }

        .job-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .company-name {
            font-size: 1.25rem;
            font-weight: bold;
            color: #2563eb;
            margin-bottom: 0.5rem;
        }

        .job-location {
            color: #6b7280;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .bookmark-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            color: #ef4444;
            cursor: pointer;
            transition: color 0.3s;
            padding: 0.5rem;
        }

        .bookmark-btn:hover {
            color: #dc2626;
        }

        .bookmark-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .job-tags {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .job-tag {
            background: #dbeafe;
            color: #2563eb;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .job-description {
            color: #6b7280;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .job-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: white;
        }

        .empty-icon {
            font-size: 5rem;
            margin-bottom: 2rem;
            opacity: 0.8;
        }

        .empty-title {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .empty-text {
            margin-bottom: 3rem; /* Increased from default to add more spacing */
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .spinner {
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .success-message, .error-message {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            z-index: 1000;
            max-width: 400px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .success-message {
            background: #10b981;
        }

        .error-message {
            background: #ef4444;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="nav-container">
            <div class="nav-left">
                <a href="HomePage.jsp" class="logo">JobHub</a>
                <nav>
                    <ul class="nav-menu">
                        <li><a href="HomePage.jsp">Trang chủ</a></li>
                        <li><a href="jobs.jsp">Tìm việc làm</a></li>
                        <li><a href="companies.jsp">Công ty</a></li>
                    </ul>
                </nav>
            </div>
            <div class="auth-buttons">
                <c:choose>
                    <c:when test="${sessionScope.Candidate != null}">
                        <a href="profile.jsp" class="btn btn-outline">Hồ sơ</a>
                        <a href="logout" class="btn btn-primary">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" class="btn btn-outline">Đăng nhập</a>
                        <a href="register.jsp" class="btn btn-primary">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <main class="main-container">
        <div class="page-header">
            <h1 class="page-title">Việc làm đã lưu</h1>
            <p class="page-subtitle">Quản lý các công việc bạn quan tâm và ứng tuyển ngay khi sẵn sàng</p>
        </div>

        <div class="stats-section">
            <div class="stats-title">Tổng số việc làm đã lưu</div>
            <div class="stats-number" id="total-count">${totalBookmarks != null ? totalBookmarks : 0}</div>
        </div>

        <div id="jobs-container">
            <c:choose>
                <c:when test="${not empty bookmarkedJobs}">
                    <c:forEach var="job" items="${bookmarkedJobs}">
                        <div class="job-card" id="job-card-${job.jobId}">
                            <div class="job-header">
                                <div class="job-info">
                                    <div class="company-name">${job.companyName}</div>
                                    <div class="job-location">
                                        <i class="fas fa-map-marker-alt"></i>
                                        ${job.location}
                                    </div>
                                </div>
                                <button class="bookmark-btn" 
                                        onclick="removeBookmark(${job.jobId})"
                                        title="Bỏ lưu việc làm"
                                        id="bookmark-btn-${job.jobId}">
                                    <i class="fas fa-heart"></i>
                                </button>
                            </div>
                            
                            <div class="job-tags">
                                <span class="job-tag">
                                    <i class="fas fa-clock"></i> ${job.jobType != null ? job.jobType : 'Full-time'}
                                </span>
                                <span class="job-tag">
                                    <i class="fas fa-briefcase"></i> ${job.experienceLevel != null ? job.experienceLevel : 'Senior'}
                                </span>
                            </div>
                            
                            <c:if test="${not empty job.shortDescription}">
                                <p class="job-description">${job.shortDescription}</p>
                            </c:if>
                            
                            <div class="job-actions">
                                <a href="job-detail?id=${job.jobId}" class="btn btn-primary">
                                    <i class="fas fa-eye"></i> Xem chi tiết
                                </a>
                                <a href="apply-job?id=${job.jobId}" class="btn btn-primary">
                                    <i class="fas fa-paper-plane"></i> Ứng tuyển
                                </a>
                                <button onclick="removeBookmark(${job.jobId})" 
                                        class="btn btn-secondary"
                                        id="remove-btn-${job.jobId}">
                                    <i class="fas fa-trash"></i> Bỏ lưu
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" id="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-bookmark"></i>
                        </div>
                        <h2 class="empty-title">Chưa có việc làm nào được lưu</h2>
                        <p class="empty-text">
                            Hãy khám phá và lưu những công việc bạn quan tâm để dễ dàng quản lý và ứng tuyển sau này.
                        </p>
                        <a href="jobs.jsp" class="btn btn-primary">
                            <i class="fas fa-search"></i> Tìm việc làm
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script>
        // Track jobs being removed to prevent duplicate requests
        const removingJobs = new Set();
        
        function removeBookmark(jobId) {
            if (removingJobs.has(jobId)) {
                return; // Already processing this job
            }
            
            if (!confirm('Bạn có chắc chắn muốn bỏ lưu việc làm này?')) {
                return;
            }
            
            removingJobs.add(jobId);
            
            // Get ALL elements with this jobId (handle duplicates)
            const allJobCards = document.querySelectorAll('[id^="job-card-' + jobId + '"]');
            const allBookmarkBtns = document.querySelectorAll('[id^="bookmark-btn-' + jobId + '"]');
            const allRemoveBtns = document.querySelectorAll('[id^="remove-btn-' + jobId + '"]');
            
            // Show loading state for all duplicate elements
            allBookmarkBtns.forEach(btn => {
                if (btn) {
                    btn.disabled = true;
                    btn.innerHTML = '<i class="fas fa-spinner spinner"></i>';
                }
            });
            
            allRemoveBtns.forEach(btn => {
                if (btn) {
                    btn.disabled = true;
                    btn.innerHTML = '<i class="fas fa-spinner spinner"></i> Đang xử lý...';
                }
            });
            
            allJobCards.forEach(card => {
                if (card) {
                    card.classList.add('removing');
                }
            });
            
            // Make the request
            fetch('bookmark-job', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=remove&jobId=' + jobId
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    // Successfully removed - remove ALL duplicate cards from DOM
                    const removedCount = data.removedCount || allJobCards.length;
                    showMessage(data.message || 'Đã bỏ lưu việc làm thành công.', 'success');
                    
                    // Remove all duplicate job cards with animation
                    allJobCards.forEach((card, index) => {
                        if (card) {
                            card.style.transition = 'all 0.5s ease';
                            card.style.opacity = '0';
                            card.style.transform = 'translateX(-100%)';
                            
                            setTimeout(() => {
                                if (card.parentNode) {
                                    card.remove();
                                }
                                
                                // Update counter only after the last card is removed
                                if (index === allJobCards.length - 1) {
                                    updateTotalCount(removedCount);
                                    checkEmptyState();
                                }
                            }, 500 + (index * 100)); // Stagger the removal animation
                        }
                    });
                    
                    // If no cards found, fallback to page reload
                    if (allJobCards.length === 0) {
                        setTimeout(() => location.reload(), 1000);
                    }
                    
                } else {
                    // Failed to remove
                    showMessage('Lỗi: ' + (data.message || 'Không thể bỏ lưu việc làm.'), 'error');
                    resetButtonStates(jobId);
                    
                    if (data.redirect) {
                        setTimeout(() => {
                            window.location.href = data.redirect;
                        }, 2000);
                    }
                }
            })
            .catch(error => {
                showMessage('Có lỗi xảy ra: ' + error.message + '. Vui lòng thử lại.', 'error');
                resetButtonStates(jobId);
            })
            .finally(() => {
                removingJobs.delete(jobId);
            });
        }
        
        function resetButtonStates(jobId) {
            const allBookmarkBtns = document.querySelectorAll('[id^="bookmark-btn-' + jobId + '"]');
            const allRemoveBtns = document.querySelectorAll('[id^="remove-btn-' + jobId + '"]');
            const allJobCards = document.querySelectorAll('[id^="job-card-' + jobId + '"]');
            
            allBookmarkBtns.forEach(btn => {
                if (btn) {
                    btn.disabled = false;
                    btn.innerHTML = '<i class="fas fa-heart"></i>';
                }
            });
            
            allRemoveBtns.forEach(btn => {
                if (btn) {
                    btn.disabled = false;
                    btn.innerHTML = '<i class="fas fa-trash"></i> Bỏ lưu';
                }
            });
            
            allJobCards.forEach(card => {
                if (card) {
                    card.classList.remove('removing');
                }
            });
        }
        
        function updateTotalCount(removedCount) {
            const totalCount = document.getElementById('total-count');
            if (totalCount) {
                const currentCount = parseInt(totalCount.textContent) || 0;
                const newCount = Math.max(0, currentCount - removedCount);
                totalCount.textContent = newCount;
                
                // Add animation to counter update
                totalCount.style.transform = 'scale(1.1)';
                totalCount.style.color = '#ef4444';
                setTimeout(() => {
                    totalCount.style.transform = 'scale(1)';
                    totalCount.style.color = '#2563eb';
                }, 300);
            }
        }
        
        function checkEmptyState() {
            const remainingJobs = document.querySelectorAll('[id^="job-card-"]');
            if (remainingJobs.length === 0) {
                setTimeout(showEmptyState, 600); // Wait for animations to complete
            }
        }
        
        function showEmptyState() {
            const jobsContainer = document.getElementById('jobs-container');
            if (jobsContainer) {
                jobsContainer.innerHTML = `
                    <div class="empty-state" id="empty-state" style="opacity: 0; transform: translateY(20px);">
                        <div class="empty-icon">
                            <i class="fas fa-bookmark"></i>
                        </div>
                        <h2 class="empty-title">Chưa có việc làm nào được lưu</h2>
                        <p class="empty-text">
                            Hãy khám phá và lưu những công việc bạn quan tâm để dễ dàng quản lý và ứng tuyển sau này.
                        </p>
                        <a href="jobs.jsp" class="btn btn-primary">
                            <i class="fas fa-search"></i> Tìm việc làm
                        </a>
                    </div>
                `;
                
                // Animate empty state appearance
                const emptyState = document.getElementById('empty-state');
                setTimeout(() => {
                    emptyState.style.transition = 'all 0.5s ease';
                    emptyState.style.opacity = '1';
                    emptyState.style.transform = 'translateY(0)';
                }, 100);
            }
        }
        
        function showMessage(message, type) {
            // Remove existing messages
            const existingMessages = document.querySelectorAll('.success-message, .error-message');
            existingMessages.forEach(msg => msg.remove());
            
            const messageDiv = document.createElement('div');
            messageDiv.className = type === 'success' ? 'success-message' : 'error-message';
            messageDiv.textContent = message;
            messageDiv.style.opacity = '0';
            messageDiv.style.transform = 'translateX(100%)';
            
            document.body.appendChild(messageDiv);
            
            // Animate message appearance
            setTimeout(() => {
                messageDiv.style.transition = 'all 0.3s ease';
                messageDiv.style.opacity = '1';
                messageDiv.style.transform = 'translateX(0)';
            }, 100);
            
            // Auto remove message
            setTimeout(() => {
                messageDiv.style.opacity = '0';
                messageDiv.style.transform = 'translateX(100%)';
                setTimeout(() => {
                    if (messageDiv.parentNode) {
                        messageDiv.parentNode.removeChild(messageDiv);
                    }
                }, 300);
            }, 3000);
        }
        
        // Add CSS for better animations
        const style = document.createElement('style');
        style.textContent = `
            .job-card {
                transition: all 0.3s ease;
            }
            
            .job-card.removing {
                opacity: 0.5;
                transform: scale(0.98);
                pointer-events: none;
            }
            
            .success-message, .error-message {
                transition: all 0.3s ease;
            }
            
            @keyframes pulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.05); }
                100% { transform: scale(1); }
            }
            
            .stats-number {
                transition: all 0.3s ease;
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>

