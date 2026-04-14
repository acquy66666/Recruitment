<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String formattedText = (String) request.getAttribute("formattedText");
    if (formattedText == null) {
        out.println("<h3 style='color:red'>Không có dữ liệu để hiển thị. Vui lòng kiểm tra lại quá trình upload hoặc xử lý CV.</h3>");
        return;
    }
    JSONObject json = new JSONObject((String) request.getAttribute("formattedText"));
    JSONObject personal = json.getJSONObject("personal_information");
    JSONArray skills = json.getJSONArray("skill_group");
    JSONArray education = json.optJSONArray("education");
    JSONArray experience = json.getJSONArray("working_experience");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin CV ứng viên | MyJob</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            :root {
                --primary-dark: #001a57;
                --primary-color: #0046b8;
                --primary-light: #0066ff;
                --secondary-color: #2c3e50;
                --accent-color: #ff7f50;
                --accent-hover: #ff6a3c;
                --light-gray: #f8f9fa;
                --medium-gray: #e9ecef;
                --dark-gray: #6c757d;
                --border-color: #dee2e6;
                --error-color: #dc3545;
                --success-color: #28a745;
                --warning-color: #ffc107;
                --info-color: #17a2b8;
                --box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                --transition-speed: 0.3s;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Roboto', sans-serif;
            }

            body {
                background-color: var(--light-gray);
                color: var(--secondary-color);
                line-height: 1.6;
            }

            /* Header */
            .header {
                background: linear-gradient(90deg, var(--primary-dark) 0%, var(--primary-light) 100%);
                color: white;
                padding: 15px 0;
                box-shadow: var(--box-shadow);
            }

            .header-container {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 20px;
            }

            .logo {
                display: flex;
                align-items: center;
                font-size: 24px;
                font-weight: bold;
            }

            .user-menu {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .logout-btn {
                background: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background var(--transition-speed);
            }

            .logout-btn:hover {
                background: rgba(255, 255, 255, 0.3);
            }

            /* Main Container */
            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 30px 20px;
            }

            /* Page Header */
            .page-header {
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: var(--box-shadow);
                margin-bottom: 30px;
            }

            .page-title {
                font-size: 28px;
                font-weight: 600;
                color: var(--secondary-color);
                margin-bottom: 10px;
            }

            .page-subtitle {
                color: var(--dark-gray);
                font-size: 16px;
            }

            /* CV Sections */
            .cv-section {
                background: white;
                border-radius: 8px;
                box-shadow: var(--box-shadow);
                margin-bottom: 30px;
                overflow: hidden;
            }

            .section-header {
                background: linear-gradient(90deg, var(--primary-dark) 0%, var(--primary-light) 100%);
                color: white;
                padding: 20px 25px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .section-header h3 {
                margin: 0;
                font-size: 18px;
                font-weight: 600;
            }

            .section-content {
                padding: 25px;
            }

            /* Personal Info Grid */
            .personal-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
            }

            .info-item {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 15px;
                background: var(--light-gray);
                border-radius: 8px;
                border-left: 4px solid var(--primary-color);
            }

            .info-item i {
                color: var(--primary-color);
                font-size: 18px;
                width: 20px;
            }

            .info-item .label {
                font-weight: 600;
                color: var(--secondary-color);
                margin-right: 8px;
            }

            .info-item .value {
                color: var(--dark-gray);
            }

            /* Skills Grid */
            .skills-grid {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }

            .skill-tag {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
                color: white;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 6px;
            }

            /* Education & Experience Cards */
            .item-card {
                background: var(--light-gray);
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 15px;
                border-left: 4px solid var(--primary-color);
                transition: all var(--transition-speed);
            }

            .item-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .item-card h4 {
                color: var(--secondary-color);
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .item-card .details {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px;
            }

            .detail-item {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .detail-item i {
                color: var(--primary-color);
                width: 16px;
            }

            .detail-item .label {
                font-weight: 500;
                color: var(--secondary-color);
            }

            .detail-item .value {
                color: var(--dark-gray);
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                gap: 15px;
                justify-content: center;
                margin-top: 30px;
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all var(--transition-speed);
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background-color: var(--primary-color);
                color: white;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0, 70, 184, 0.3);
            }

            .btn-secondary {
                background-color: var(--medium-gray);
                color: var(--secondary-color);
            }

            .btn-secondary:hover {
                background-color: var(--dark-gray);
                color: white;
            }

            .btn-success {
                background-color: var(--success-color);
                color: white;
            }

            .btn-success:hover {
                background-color: #218838;
            }

            .btn-warning {
                background-color: var(--warning-color);
                color: #212529;
            }

            .btn-warning:hover {
                background-color: #e0a800;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 40px 20px;
                color: var(--dark-gray);
            }

            .empty-state i {
                font-size: 48px;
                margin-bottom: 15px;
                color: var(--medium-gray);
            }

            .empty-state h4 {
                font-size: 18px;
                margin-bottom: 8px;
                color: var(--secondary-color);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .main-container {
                    padding: 20px 10px;
                }

                .personal-grid {
                    grid-template-columns: 1fr;
                }

                .action-buttons {
                    flex-direction: column;
                    align-items: center;
                }

                .item-card .details {
                    grid-template-columns: 1fr;
                }
            }

            /* File Link */
            .file-link {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
                padding: 8px 16px;
                background: rgba(0, 70, 184, 0.1);
                border-radius: 6px;
                transition: all var(--transition-speed);
            }

            .file-link:hover {
                background: rgba(0, 70, 184, 0.2);
                color: var(--primary-dark);
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="header">
            <div class="header-container">
                <div class="logo">
                    <i class="fas fa-briefcase" style="margin-right: 10px;"></i>
                    MyJob - Employer
                </div>
                <div class="user-menu">
                    <div class="user-info">
                        <i class="fas fa-user-circle" style="font-size: 24px;"></i>
                        <span>Chào, Nhà tuyển dụng</span>
                    </div>
                    <button class="logout-btn" onclick="logout()">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </button>
                </div>
            </div>
        </header>

        <!-- Main Container -->
        <div class="main-container">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-file-alt" style="margin-right: 10px;"></i>
                    Thông tin CV ứng viên
                </h1>
                <p class="page-subtitle">Xem chi tiết thông tin và kinh nghiệm của ứng viên</p>
            </div>

            <!-- Personal Information Section -->
            <div class="cv-section">
                <div class="section-header">
                    <i class="fas fa-user"></i>
                    <h3>Thông tin cá nhân</h3>
                </div>
                <div class="section-content">
                    <div class="personal-grid">
                        <div class="info-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span class="label">Địa chỉ:</span>
                            <span class="value"><%= personal.optString("address", "Chưa cập nhật") %></span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-birthday-cake"></i>
                            <span class="label">Ngày sinh:</span>
                            <span class="value"><%= personal.optString("birthdate", "Chưa cập nhật") %></span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-envelope"></i>
                            <span class="label">Email:</span>
                            <span class="value"><%= personal.optString("email", "Chưa cập nhật") %></span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-phone"></i>
                            <span class="label">Số điện thoại:</span>
                            <span class="value"><%= personal.optString("phone_number", "Chưa cập nhật") %></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Skills Section -->
            <div class="cv-section">
                <div class="section-header">
                    <i class="fas fa-award"></i>
                    <h3>Kỹ năng</h3>
                </div>
                <div class="section-content">
                    <% if (skills.length() > 0) { %>
                    <div class="skills-grid">
                        <% for (int i = 0; i < skills.length(); i++) {
                            JSONObject skill = skills.getJSONObject(i);
                        %>
                        <div class="skill-tag">
                            <i class="fas fa-check"></i>
                            <%= skill.optString("skill_name", "Kỹ năng " + (i+1)) %>
                        </div>
                        <% } %>
                    </div>
                    <% } else { %>
                    <div class="empty-state">
                        <i class="fas fa-award"></i>
                        <h4>Chưa có thông tin kỹ năng</h4>
                        <p>Ứng viên chưa cập nhật thông tin kỹ năng</p>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Education Section -->
            <div class="cv-section">
                <div class="section-header">
                    <i class="fas fa-graduation-cap"></i>
                    <h3>Học vấn</h3>
                </div>
                <div class="section-content">
                    <% if (education != null && education.length() > 0) { %>
                    <% for (int i = 0; i < education.length(); i++) {
                        JSONObject edu = education.getJSONObject(i);
                    %>
                    <div class="item-card">
                        <h4>Học vấn #<%= i + 1 %></h4>
                        <div class="details">
                            <div class="detail-item">
                                <i class="fas fa-book"></i>
                                <span class="label">Ngành học:</span>
                                <span class="value"><%= edu.optString("major", "Chưa cập nhật") %></span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-university"></i>
                                <span class="label">Nơi học:</span>
                                <span class="value"><%= edu.optString("education_place", "Chưa cập nhật") %></span>
                            </div>
                        </div>
                    </div>
                    <% } %>
                    <% } else { %>
                    <div class="empty-state">
                        <i class="fas fa-graduation-cap"></i>
                        <h4>Chưa có thông tin học vấn</h4>
                        <p>Ứng viên chưa cập nhật thông tin học vấn</p>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Experience Section -->
            <div class="cv-section">
                <div class="section-header">
                    <i class="fas fa-briefcase"></i>
                    <h3>Kinh nghiệm làm việc</h3>
                </div>
                <div class="section-content">
                    <% if (experience.length() > 0) { %>
                    <% for (int i = 0; i < experience.length(); i++) {
                        JSONObject exp = experience.getJSONObject(i);
                    %>
                    <div class="item-card">
                        <h4>Kinh nghiệm #<%= i + 1 %></h4>
                        <div class="details">
                            <div class="detail-item">
                                <i class="fas fa-user-tie"></i>
                                <span class="label">Vị trí:</span>
                                <span class="value"><%= exp.optString("working_position", "Chưa cập nhật") %></span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-building"></i>
                                <span class="label">Nơi làm việc:</span>
                                <span class="value"><%= exp.optString("working_place", "Chưa cập nhật") %></span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-clock"></i>
                                <span class="label">Thời gian:</span>
                                <span class="value"><%= exp.optString("working_duration", "Chưa cập nhật") %></span>
                            </div>
                        </div>
                    </div>
                    <% } %>
                    <% } else { %>
                    <div class="empty-state">
                        <i class="fas fa-briefcase"></i>
                        <h4>Chưa có thông tin kinh nghiệm</h4>
                        <p>Ứng viên chưa cập nhật thông tin kinh nghiệm làm việc</p>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- CV File Section -->
            <div class="cv-section">
                <div class="section-header">
                    <i class="fas fa-file-pdf"></i>
                    <h3>File CV</h3>
                </div>
                <div class="section-content">
                    <div style="text-align: center;">
                        <c:choose>
                            <c:when test="${not empty cv.cvUrl}">
                                <a href="${cv.cvUrl}" target="_blank" class="file-link">
                                    <i class="fas fa-download"></i>
                                    Tải xuống CV
                                </a>
                                <div style="margin-top: 10px" class="file-info">
                                    <i class="fas fa-info-circle"></i>
                                    Click để xem hoặc tải xuống file CV gốc
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-file-pdf"></i>
                                    <h4>Không có file CV</h4>
                                    <p>Ứng viên chưa tải lên file CV</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>


            <!-- Action Buttons -->
            <div class="action-buttons">

                <a class="btn btn-secondary" href="CVFilter">
                    <i class="fas fa-arrow-left"></i>
                    Quay lại
                </a>
            </div>
        </div>

    </body>
</html>