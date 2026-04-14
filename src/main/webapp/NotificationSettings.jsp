<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cài đặt thông báo - JobHub</title>
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
        
        .settings-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 30px rgba(0,0,0,0.08);
            padding: 2rem;
            margin-bottom: 1.5rem;
        }
        
        .settings-section {
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .settings-section:last-child {
            border-bottom: none;
            padding-bottom: 0;
            margin-bottom: 0;
        }
        
        .section-title {
            font-weight: 600;
            color: #1a1a2e;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .section-title i {
            color: var(--primary-color);
        }
        
        .form-switch .form-check-input {
            width: 50px;
            height: 26px;
            cursor: pointer;
        }
        
        .form-switch .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .form-check-label {
            cursor: pointer;
        }
        
        .notification-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 10px;
            margin-bottom: 0.75rem;
            transition: all 0.3s ease;
        }
        
        .notification-item:hover {
            background: #e9ecef;
        }
        
        .notification-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
        }
        
        .notification-icon.email { background: #dbeafe; color: #1d4ed8; }
        .notification-icon.sms { background: #dcfce7; color: #16a34a; }
        .notification-icon.push { background: #fef3c7; color: #d97706; }
        
        .frequency-select {
            border-radius: 8px;
            border: 1px solid #e9ecef;
            padding: 0.5rem 1rem;
            min-width: 150px;
        }
        
        .btn-save {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
        }
        
        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0, 70, 170, 0.3);
            color: white;
        }
        
        .alert-box {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .alert-box.info {
            background: #dbeafe;
            color: #1e40af;
        }
        
        .alert-box.warning {
            background: #fef3c7;
            color: #92400e;
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

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="bi bi-bell-fill me-2"></i>Cài đặt thông báo</h1>
            <p class="mb-0 opacity-75">Quản lý cách bạn nhận thông báo từ JobHub</p>
        </div>
    </div>

    <div class="container pb-5">
        <!-- Info Alert -->
        <div class="alert-box info mb-4">
            <i class="bi bi-info-circle-fill fs-4"></i>
            <div>
                <strong>Quản lý thông báo của bạn</strong><br>
                <small>Tùy chỉnh cách bạn nhận thông báo về việc làm, ứng tuyển và tin tuyển dụng mới.</small>
            </div>
        </div>

        <form action="NotificationSettingsServlet" method="POST">
            <div class="row">
                <!-- Left Column -->
                <div class="col-lg-6">
                    <!-- Job Alerts -->
                    <div class="settings-card">
                        <div class="settings-section">
                            <h5 class="section-title">
                                <i class="bi bi-briefcase-fill"></i>
                                Thông báo việc làm
                            </h5>
                            
                            <div class="notification-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="notification-icon email">
                                        <i class="bi bi-envelope-fill"></i>
                                    </div>
                                    <div>
                                        <strong>Việc làm mới phù hợp</strong>
                                        <p class="mb-0 text-muted small">Nhận email khi có việc làm mới phù hợp với CV của bạn</p>
                                    </div>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="jobEmailAlert" name="jobEmailAlert" checked>
                                </div>
                            </div>
                            
                            <div class="notification-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="notification-icon push">
                                        <i class="bi bi-phone-fill"></i>
                                    </div>
                                    <div>
                                        <strong>Thông báo đẩy</strong>
                                        <p class="mb-0 text-muted small">Nhận thông báo trên trình duyệt</p>
                                    </div>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="jobPushAlert" name="jobPushAlert" checked>
                                </div>
                            </div>
                        </div>

                        <div class="settings-section">
                            <h5 class="section-title">
                                <i class="bi bi-clock-fill"></i>
                                Tần suất thông báo
                            </h5>
                            
                            <div class="mb-3">
                                <label class="form-label">Email thông báo việc làm</label>
                                <select class="form-select frequency-select" name="jobEmailFrequency">
                                    <option value="instant">Ngay lập tức</option>
                                    <option value="daily" selected>Hàng ngày</option>
                                    <option value="weekly">Hàng tuần</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="col-lg-6">
                    <!-- Application Status -->
                    <div class="settings-card">
                        <div class="settings-section">
                            <h5 class="section-title">
                                <i class="bi bi-file-earmark-check-fill"></i>
                                Trạng thái ứng tuyển
                            </h5>
                            
                            <div class="notification-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="notification-icon email">
                                        <i class="bi bi-envelope-fill"></i>
                                    </div>
                                    <div>
                                        <strong>Trạng thái hồ sơ</strong>
                                        <p class="mb-0 text-muted small">Thông báo khi nhà tuyển dụng xem hoặc phản hồi</p>
                                    </div>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="applicationEmail" name="applicationEmail" checked>
                                </div>
                            </div>
                            
                            <div class="notification-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="notification-icon sms">
                                        <i class="bi bi-chat-dots-fill"></i>
                                    </div>
                                    <div>
                                        <strong>Lịch phỏng vấn</strong>
                                        <p class="mb-0 text-muted small">Nhắc nhở trước lịch phỏng vấn</p>
                                    </div>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="interviewReminder" name="interviewReminder" checked>
                                </div>
                            </div>
                            
                            <div class="notification-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="notification-icon push">
                                        <i class="bi bi-exclamation-circle-fill"></i>
                                    </div>
                                    <div>
                                        <strong>Bài thi mới</strong>
                                        <p class="mb-0 text-muted small">Thông báo khi có bài thi được giao</p>
                                    </div>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="testNotification" name="testNotification" checked>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Marketing -->
                    <div class="settings-card">
                        <div class="settings-section">
                            <h5 class="section-title">
                                <i class="bi bi-megaphone-fill"></i>
                                Tiếp thị & Khuyến mãi
                            </h5>
                            
                            <div class="alert-box warning mb-3">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                <small>Nhận các tin tức, cập nhật và ưu đãi đặc biệt từ JobHub</small>
                            </div>
                            
                            <div class="notification-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="notification-icon email">
                                        <i class="bi bi-gift-fill"></i>
                                    </div>
                                    <div>
                                        <strong>Tin tức & Cập nhật</strong>
                                        <p class="mb-0 text-muted small">Tin tức thị trường lao động, xu hướng tuyển dụng</p>
                                    </div>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="newsUpdates" name="newsUpdates">
                                </div>
                            </div>
                            
                            <div class="notification-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="notification-icon push">
                                        <i class="bi bi-tag-fill"></i>
                                    </div>
                                    <div>
                                        <strong>Khuyến mãi đặc biệt</strong>
                                        <p class="mb-0 text-muted small">Các ưu đãi và giảm giá dịch vụ</p>
                                    </div>
                                </div>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="promotions" name="promotions">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Save Button -->
            <div class="text-center mt-4">
                <button type="submit" class="btn btn-save px-5">
                    <i class="bi bi-check-circle me-2"></i>Lưu cài đặt
                </button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
