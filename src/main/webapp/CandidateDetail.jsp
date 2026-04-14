<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin Ứng viên - ${candidate.fullName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #0046aa;
            --secondary-color: #ff6b00;
            --accent-color: #11cdef;
            --dark-color: #001e44;
            --light-color: #f7fafc;
            --danger-color: #f5365c;
            --warning-color: #fb6340;
            --info-color: #11cdef;
            --success-color: #2dce89;
            --text-color: #525f7f; /* General text color */
            --heading-color: #333; /* For section titles, etc. */
            --border-light: #e0e0e0;
            --bg-light: #f8f9fa;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-color); /* Consistent with HomePage.jsp */
            color: var(--text-color);
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }
        h1, h2, h3, h4, h5, h6 {
            color: var(--dark-color);
            font-weight: 600;
        }

        /* General Card Styling */
        .card-custom {
            background: white;
            border-radius: 0.75rem; /* More rounded corners */
            box-shadow: 0 4px 12px rgba(0,0,0,0.05); /* Softer shadow */
            margin-bottom: 25px;
            overflow: hidden;
        }

        /* Profile Container */
        .profile-container {
            max-width: 900px; /* Slightly wider */
            margin: 40px auto; /* More top/bottom margin */
            background: transparent; /* Let inner cards handle background */
            box-shadow: none; /* No outer shadow */
            border-radius: 0;
        }

        /* Profile Header */
        .profile-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, #003ecb 100%); /* Gradient background */
            color: white;
            padding: 40px 20px; /* More padding */
            text-align: center;
            border-bottom: none;
            border-radius: 0.75rem 0.75rem 0 0; /* Rounded top corners */
            position: relative;
            z-index: 1;
        }
        .profile-header::before { /* Subtle background pattern */
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80'); /* Example pattern */
            background-size: cover;
            background-position: center;
            opacity: 0.05;
            z-index: -1;
        }

        .profile-main {
            flex-direction: column; /* Stack avatar and info vertically */
            align-items: center;
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-avatar {
            width: 120px; /* Larger avatar */
            height: 120px;
            border-radius: 50%;
            background-color: rgba(255,255,255,0.2); /* Lighter background for placeholder */
            border: 4px solid rgba(255,255,255,0.5); /* White border */
            font-size: 48px; /* Larger text */
            color: white;
            margin-bottom: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2); /* Shadow for avatar */
        }
        .profile-info h2 {
            font-size: 2.2rem; /* Larger name */
            margin: 0 0 8px 0;
            color: white;
        }
        .profile-title {
            font-size: 1.1rem;
            color: rgba(255,255,255,0.8);
            margin-bottom: 10px;
        }
        .profile-summary {
            font-size: 0.95rem;
            color: rgba(255,255,255,0.9);
            margin-bottom: 15px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        .profile-summary i {
            color: rgba(255,255,255,0.9);
        }
        .profile-stats {
            justify-content: center;
            gap: 25px; /* More space between stats */
            font-size: 0.9rem;
            color: rgba(255,255,255,0.9);
        }
        .stat-item i {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
        }

        /* Contact Button */
        .contact-button {
            background: var(--secondary-color); /* Use secondary color */
            color: white;
            border: none;
            padding: 14px 28px; /* Larger padding */
            border-radius: 0.5rem; /* More rounded */
            font-size: 1rem;
            font-weight: 600;
            width: auto; /* Auto width */
            min-width: 200px; /* Minimum width */
            margin: 20px auto 0; /* Center button */
            display: block; /* Make it a block element to center with margin auto */
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(255,107,0,0.2); /* Shadow for button */
        }
        .contact-button:hover {
            background: #e55a2b; /* Darker orange on hover */
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(255,107,0,0.3);
        }
        .contact-button:disabled {
            background: #ccc;
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }
        .contact-button.loading {
            background: #6c757d;
            position: relative;
        }
        .contact-button.loading::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
            margin: auto;
            border: 2px solid transparent;
            border-top-color: #ffffff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
        }
        .contact-button.viewed {
            background: var(--success-color);
            box-shadow: 0 4px 12px rgba(45,206,137,0.2);
        }
        .contact-button.viewed:hover {
            background: #059669;
            box-shadow: 0 6px 16px rgba(45,206,137,0.3);
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Profile Content */
        .profile-content {
            padding: 30px; /* More padding */
            background: white;
            border-radius: 0 0 0.75rem 0.75rem; /* Rounded bottom corners */
            margin-top: -20px; /* Overlap with header slightly */
            position: relative;
            z-index: 2;
        }
        .section-title {
            font-size: 1.5rem; /* Larger title */
            font-weight: 700; /* Bolder */
            color: var(--dark-color);
            margin-bottom: 25px; /* More space */
            padding-bottom: 10px;
            border-bottom: 2px solid var(--primary-color); /* Stronger underline */
            display: inline-block; /* Shrink border to content */
        }

        /* Info Table */
        .info-table {
            width: 100%;
            border-collapse: separate; /* Use separate for rounded corners if needed */
            border-spacing: 0;
            margin-bottom: 30px;
            background: var(--bg-light); /* Light background for table */
            border-radius: 0.5rem;
            overflow: hidden; /* For rounded corners */
        }
        .info-table tr {
            border-bottom: 1px solid var(--border-light);
        }
        .info-table tr:last-child {
            border-bottom: none;
        }
        .info-table td {
            padding: 15px 20px; /* More padding */
            vertical-align: middle;
        }
        .info-label {
            color: var(--text-color);
            width: 30%; /* Adjust width */
            font-size: 1rem;
            font-weight: 500;
        }
        .info-value {
            width: 70%; /* Adjust width */
            font-size: 1rem;
            color: var(--dark-color);
            padding-left: 20px;
        }

        /* CV Section */
        .cv-section {
            margin-top: 30px; /* More space */
            background: var(--bg-light); /* Light background for section */
            border-radius: 0.5rem;
            padding: 20px;
            box-shadow: inset 0 0 8px rgba(0,0,0,0.03); /* Inner shadow */
        }
        .cv-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-light);
        }
        .cv-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--dark-color);
            margin: 0;
        }
        .cv-actions {
            display: flex;
            gap: 10px;
        }
        .cv-action-btn {
            padding: 8px 16px; /* More padding */
            border-radius: 0.375rem;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .btn-download {
            background-color: var(--primary-color);
            color: white;
        }
        .btn-download:hover {
            background-color: #1d4ed8;
            transform: translateY(-1px);
            box-shadow: 0 3px 8px rgba(0,0,0,0.15);
        }
        .btn-print {
            background-color: white;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
        }
        .btn-print:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 3px 8px rgba(0,0,0,0.15);
        }
        .pdf-container {
            width: 100%;
            height: 650px; /* Slightly taller */
            border: 1px solid var(--border-light);
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08); /* Shadow for PDF viewer */
        }
        .pdf-viewer {
            width: 100%;
            height: 100%;
            border: none;
        }
        .back-button {
            position: fixed;
            top: 20px;
            left: 20px;
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 10px 18px; /* Larger button */
            border-radius: 0.5rem; /* More rounded */
            text-decoration: none;
            font-size: 0.95rem;
            z-index: 1000;
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transition: all 0.2s ease;
        }
        .back-button:hover {
            background: #1d4ed8;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
        }
        .no-cv-message {
            text-align: center;
            padding: 60px 20px; /* More padding */
            color: #999;
            background-color: white; /* Ensure white background */
            height: 100%; /* Fill container */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .no-cv-message i {
            font-size: 5rem; /* Larger icon */
            margin-bottom: 20px;
            opacity: 0.4;
            color: var(--border-light);
        }
        .no-cv-message p {
            font-size: 1.1rem;
            color: var(--text-color);
        }

        /* Modal Styling */
        .modal-content {
            border-radius: 0.75rem;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .modal-header {
            background-color: var(--primary-color);
            color: white;
            border-bottom: none;
            border-radius: 0.75rem 0.75rem 0 0;
        }
        .modal-title {
            font-weight: 600;
        }
        .modal-header .btn-close {
            filter: invert(1); /* White close button */
        }
        .modal-body strong {
            color: var(--dark-color);
        }
        .modal-body .text-primary {
            color: var(--primary-color) !important;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
            .profile-container {
                margin: 20px auto;
            }
            .profile-header {
                padding: 30px 15px;
            }
            .profile-avatar {
                width: 100px;
                height: 100px;
                font-size: 40px;
            }
            .profile-info h2 {
                font-size: 1.8rem;
            }
            .profile-title {
                font-size: 1rem;
            }
            .profile-summary {
                font-size: 0.9rem;
            }
            .profile-stats {
                gap: 15px;
            }
            .contact-button {
                padding: 12px 20px;
                font-size: 0.9rem;
                min-width: unset;
                width: 100%;
            }
            .profile-content {
                padding: 20px;
            }
            .section-title {
                font-size: 1.3rem;
                margin-bottom: 20px;
            }
            .info-table td {
                display: block;
                width: 100%;
                padding: 8px 0;
            }
            .info-label {
                font-weight: bold;
                width: 100%;
                margin-bottom: 5px;
            }
            .info-value {
                padding-left: 0;
                width: 100%;
            }
            .cv-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            .cv-actions {
                width: 100%;
                justify-content: center;
            }
            .cv-action-btn {
                flex: 1;
                text-align: center;
            }
            .pdf-container {
                height: 500px;
            }
            .back-button {
                top: 10px;
                left: 10px;
                padding: 8px 15px;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
    <a href="#" class="back-button" onclick="history.back(); return false;">
        <i class="bi bi-arrow-left me-1"></i>Quay lại
    </a>
    <div class="profile-container">
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="profile-main">
                <c:choose>
                    <c:when test="${candidate.imageUrl != null && not empty candidate.imageUrl}">
                        <img src="${candidate.imageUrl}" alt="Avatar" class="profile-avatar">
                    </c:when>
                    <c:otherwise>
                        <div class="profile-avatar" id="avatarPlaceholder">
                            <!-- Will be filled by JavaScript -->
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="profile-info">
                    <h2><c:out value="${candidate.fullName}" default="Chưa cập nhật tên"/></h2>
                    <div class="profile-stats">
                        <div class="stat-item">
                            <i class="bi bi-geo-alt"></i>
                            <span><c:out value="${candidate.address}" default="Chưa cập nhật địa chỉ"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Profile Content -->
        <div class="profile-content">
            <div class="section-title">Thông tin chung</div>
            <table class="info-table">
                <tr>
                    <td class="info-label">Ngày sinh</td>
                    <td class="info-value">
                        <c:choose>
                            <c:when test="${candidate.birthdate != null}">
                                ${candidate.birthdate.dayOfMonth}/${candidate.birthdate.monthValue}/${candidate.birthdate.year}
                            </c:when>
                            <c:otherwise>Chưa cập nhật</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td class="info-label">Giới tính</td>
                    <td class="info-value"><c:out value="${candidate.gender}" default="Chưa cập nhật"/></td>
                </tr>
                <tr>
                    <td class="info-label">Địa chỉ</td>
                    <td class="info-value"><c:out value="${candidate.address}" default="Chưa cập nhật"/></td>
                </tr>
                <tr>
                    <td class="info-label">Số điện thoại</td>
                    <td class="info-value"><c:out value="${candidate.phone}" default="Chưa cập nhật"/></td>
                </tr>
                <tr>
                    <td class="info-label">Email</td>
                    <td class="info-value"><c:out value="${candidate.email}" default="Chưa cập nhật"/></td>
                </tr>
            </table>
            <!-- CV Section -->
            <div class="cv-section card-custom">
                <div class="cv-header">
                    <h3 class="cv-title">Hồ sơ đính kèm</h3>
                    <div class="cv-actions">
                        <c:if test="${candidate.cvs != null && not empty candidate.cvs && candidate.cvs[0].cvId != null}">
                            <a href="DownloadResume?cvId=${candidate.cvs[0].cvId}&candidateId=${candidate.candidateId}"
                                class="cv-action-btn btn-download">
                                <i class="bi bi-download me-1"></i>Tải xuống
                            </a>
                        </c:if>
                        <button class="cv-action-btn btn-print" onclick="printCV()">
                            <i class="bi bi-printer me-1"></i>In
                        </button>
                    </div>
                </div>
                <div class="pdf-container">
                    <c:choose>
                        <c:when test="${candidate.cvs != null && not empty candidate.cvs && candidate.cvs[0].cvUrl != null && not empty candidate.cvs[0].cvUrl}">
                            <iframe src="${candidate.cvs[0].cvUrl}#toolbar=0&navpanes=0&scrollbar=1"
                                     class="pdf-viewer"
                                     type="application/pdf">
                                <div class="no-cv-message">
                                    <i class="bi bi-exclamation-triangle"></i>
                                    <p>Trình duyệt của bạn không hỗ trợ xem PDF trực tiếp.</p>
                                    <a href="${candidate.cvs[0].cvUrl}" target="_blank">Nhấn vào đây để mở trong tab mới</a>
                                </div>
                            </iframe>
                        </c:when>
                        <c:otherwise>
                            <div class="no-cv-message">
                                <i class="bi bi-file-earmark-x"></i>
                                <p>Không có CV đính kèm</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    <!-- Contact Modal -->
    <div class="modal fade" id="contactModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thông tin liên hệ</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="contactModalBody">
                    <!-- Contact info will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Global variable to store contact info
        let contactInfoCache = null;
        function viewContactInfo() {
            const contactBtn = document.getElementById('contactBtn');
                        // If contact info is already cached, show it directly
            if (contactInfoCache) {
                showContactModal(contactInfoCache);
                return;
            }
                        // Disable button và thay đổi text
            contactBtn.disabled = true;
            contactBtn.classList.add('loading');
            contactBtn.innerHTML = 'Đang xử lý...';
                        // Make AJAX request
            fetch('ViewContactInfo', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'candidateId=${candidate.candidateId}'
            })
            .then(response => {
                return response.json();
            })
            .then(data => {
                // Reset button state
                contactBtn.classList.remove('loading');
                contactBtn.disabled = false;
                                if (data.success) {
                    // Cache the contact info
                    contactInfoCache = data;
                                        // Show contact information
                    showContactModal(data);
                                        // Update button to show it can be viewed again
                    contactBtn.innerHTML = 'Xem lại thông tin liên hệ';
                    contactBtn.classList.add('viewed');
                                    } else {
                    alert(data.message || 'Có lỗi xảy ra khi xem thông tin liên hệ');
                    contactBtn.innerHTML = 'Xem thông tin liên hệ ';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                                // Reset button state
                contactBtn.classList.remove('loading');
                contactBtn.disabled = false;
                contactBtn.innerHTML = 'Xem thông tin liên hệ ';
                                alert('Có lỗi xảy ra khi xử lý yêu cầu: ' + error.message);
            });
        }
        function showContactModal(data) {
            const modalBody = document.getElementById('contactModalBody');
                        // Clear existing content
            modalBody.innerHTML = '';
                        // Create contact info div
            const contactDiv = document.createElement('div');
            contactDiv.className = 'contact-info';
                        // Email section
            const emailDiv = document.createElement('div');
            emailDiv.className = 'mb-3';
            emailDiv.innerHTML = '<strong>Email:</strong> <span class="text-primary">' + 
                (data.email || 'Chưa cập nhật') + '</span>';
            contactDiv.appendChild(emailDiv);
                        // Phone section
            const phoneDiv = document.createElement('div');
            phoneDiv.className = 'mb-3';
            phoneDiv.innerHTML = '<strong>Điện thoại:</strong> <span class="text-primary">' + 
                (data.phone || 'Chưa cập nhật') + '</span>';
            contactDiv.appendChild(phoneDiv);
                        // Address section
            const addressDiv = document.createElement('div');
            addressDiv.className = 'mb-3';
            addressDiv.innerHTML = '<strong>Địa chỉ:</strong> <span class="text-primary">' + 
                (data.address || 'Chưa cập nhật') + '</span>';
            contactDiv.appendChild(addressDiv);
                        // Success alert
            const alertDiv = document.createElement('div');
            contactDiv.appendChild(alertDiv);
                        // Add to modal body
            modalBody.appendChild(contactDiv);
                        // Show modal
            const contactModal = new bootstrap.Modal(document.getElementById('contactModal'));
            contactModal.show();
        }
        function printCV() {
            const iframe = document.querySelector('.pdf-viewer');
            if (iframe && iframe.contentWindow) {
                try {
                    iframe.contentWindow.print();
                } catch (e) {
                    // Fallback: open PDF in new window for printing
                    const cvUrl = '${candidate.cvs[0].cvUrl}';
                    if (cvUrl) {
                        window.open(cvUrl, '_blank');
                    } else {
                        alert('Không có CV để in');
                    }
                }
            } else {
                alert('Không có CV để in');
            }
        }
        document.addEventListener('DOMContentLoaded', function() {
            const avatarPlaceholder = document.getElementById('avatarPlaceholder');
            if (avatarPlaceholder) {
                const fullName = '${candidate.fullName}';
                if (fullName && fullName.length > 0) {
                    avatarPlaceholder.textContent = fullName.charAt(0).toUpperCase();
                } else {
                    avatarPlaceholder.textContent = '?';
                }
            }
                        const iframe = document.querySelector('.pdf-viewer');
            if (iframe) {
                iframe.addEventListener('load', function() {
                    console.log('CV loaded successfully');
                });
                                iframe.addEventListener('error', function() {
                    console.error('Error loading CV');
                });
            }
        });
    </script>
</body>
</html>
