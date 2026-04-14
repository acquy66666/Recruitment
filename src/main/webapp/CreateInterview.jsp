<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Phỏng vấn - JobHub</title>
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

        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 30px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-top: -2rem;
            position: relative;
            z-index: 10;
        }

        .form-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        /* Candidate Table Styles */
        .candidate-table-container {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            background: white;
            overflow: hidden;
            max-height: 400px;
            position: relative;
        }

        .candidate-table-wrapper {
            max-height: 400px;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .candidate-table {
            margin-bottom: 0;
        }

        .candidate-table thead th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            font-weight: 600;
            color: var(--dark-color);
            padding: 1rem 0.75rem;
            font-size: 0.875rem;
            white-space: nowrap;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .candidate-table tbody td {
            padding: 1rem 0.75rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f3f4;
        }

        .candidate-table tbody tr {
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .candidate-table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .candidate-table tbody tr.selected {
            background-color: #e3f2fd !important;
            border-left: 4px solid var(--primary-color);
        }

        .candidate-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .candidate-avatar {
            width: 2.5rem;
            height: 2.5rem;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #f5f9fc;
            background: linear-gradient(45deg, var(--primary-color), #0051ff);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1rem;
            flex-shrink: 0;
        }

        .candidate-details h6 {
            margin: 0;
            font-weight: 600;
            color: var(--dark-color);
            font-size: 0.95rem;
        }

        .candidate-details small {
            color: #8898aa;
            font-size: 0.8rem;
        }

        .selection-radio {
            transform: scale(1.3);
            accent-color: var(--primary-color);
        }

        .interview-type-card {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
            height: 100%;
        }

        .interview-type-card:hover {
            border-color: var(--primary-color);
            box-shadow: 0 5px 15px rgba(0, 70, 170, 0.15);
            transform: translateY(-2px);
        }

        .interview-type-card.selected {
            border-color: var(--primary-color);
            background: linear-gradient(135deg, #f0f6ff 0%, #e6f0ff 100%);
        }

        .interview-icon {
            width: 4rem;
            height: 4rem;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f5f9fc;
            border-radius: 50%;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            color: var(--primary-color);
            transition: all 0.3s ease;
        }

        .interview-type-card.selected .interview-icon {
            background: var(--primary-color);
            color: white;
        }

        .section-title {
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 0.5rem;
            color: var(--primary-color);
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

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(0, 70, 170, 0.25);
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .alert {
            border-radius: 10px;
            border: none;
            padding: 1rem 1.5rem;
        }

        .alert-danger {
            background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 100%);
            color: #d32f2f;
        }

        .alert-success {
            background: linear-gradient(135deg, #e8f5e8 0%, #d4edda 100%);
            color: #2e7d32;
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

        /* Custom scrollbar for table */
        .candidate-table-wrapper::-webkit-scrollbar {
            width: 8px;
        }

        .candidate-table-wrapper::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .candidate-table-wrapper::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 10px;
        }

        .candidate-table-wrapper::-webkit-scrollbar-thumb:hover {
            background: var(--dark-color);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .candidate-table-container {
                max-height: 300px;
            }
            
            .candidate-table-wrapper {
                max-height: 300px;
            }
            
            .candidate-avatar {
                width: 2rem;
                height: 2rem;
                font-size: 0.8rem;
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
                        <i class="bi bi-calendar-plus me-3"></i>Tạo Phỏng vấn Mới
                    </h1>
                    <p class="lead mb-0">Chọn ứng viên và thiết lập lịch phỏng vấn chuyên nghiệp</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="form-container">
                    <div class="form-header">
                        <h3 class="mb-0">Tạo cuộc phỏng vấn mới</h3>
                        <p class="mb-0 mt-2">Thiết lập thông tin chi tiết cho buổi phỏng vấn</p>
                    </div>

                    <div class="p-4">
                        <!-- Alert Messages -->
                        <c:if test="${param.error != null}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle me-2"></i>${param.error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:if test="${param.success != null}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle me-2"></i>${param.success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="CreateInterview" method="post" id="createInterviewForm">
                            <input type="hidden" name="applicationId" id="selectedApplicationId">

                            <!-- Chọn ứng viên -->
                            <div class="mb-5">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5 class="section-title mb-0">
                                        <i class="bi bi-people"></i>Chọn ứng viên để phỏng vấn
                                    </h5>
                                    <small class="text-muted">
                                        <i class="bi bi-info-circle me-1"></i>
                                        Nhấp vào hàng để chọn ứng viên
                                    </small>
                                </div>

                                <c:choose>
                                    <c:when test="${not empty applications}">
                                        <div class="candidate-table-container">
                                            <div class="candidate-table-wrapper">
                                                <table class="table candidate-table">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col" style="width: 50px;">
                                                                <i class="bi bi-check-circle"></i>
                                                            </th>
                                                            <th scope="col">Ứng viên</th>
                                                            <th scope="col">Vị trí</th>
                                                            <th scope="col">Ngày ứng tuyển</th>
                                                            <th scope="col">Trạng thái</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="app" items="${applications}">
                                                            <tr onclick="selectCandidate(this)" data-application-id="${app.applicationId}">
                                                                <td>
                                                                    <input type="radio" name="candidateSelection" value="${app.applicationId}"
                                                                           id="candidate_${app.applicationId}" class="selection-radio">
                                                                </td>
                                                                <td>
                                                                    <div class="candidate-info">
                                                                        <c:choose>
                                                                            <c:when test="${not empty app.imageUrl}">
                                                                                <img src="${app.imageUrl}" alt="Avatar" class="candidate-avatar">
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="candidate-avatar">
                                                                                    ${not empty app.fullName ? app.fullName.substring(0,1).toUpperCase() : 'U'}
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                        <div class="candidate-details">
                                                                            <h6>${not empty app.fullName ? app.fullName : 'Ứng viên không xác định'}</h6>
                                                                            
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <span class="fw-medium">
                                                                        <c:choose>
                                                                            <c:when test="${not empty app.jobTitle}">${app.jobTitle}</c:when>
                                                                            <c:when test="${not empty app.jobPosition}">${app.jobPosition}</c:when>
                                                                            <c:otherwise>Vị trí không xác định</c:otherwise>
                                                                        </c:choose>
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <span class="text-muted">
                                                                        <i class="bi bi-calendar me-1"></i>
                                                                        <fmt:formatDate value="${app.appliedAt}" pattern="dd/MM/yyyy"/>
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <span class="badge bg-primary">
                                                                        ${not empty app.status ? app.status : 'Pending'}
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="empty-state">
                                            <i class="bi bi-inbox"></i>
                                            <h4>Không có ứng viên nào cần phỏng vấn</h4>
                                            <p>Chưa có ứng viên nào ứng tuyển vào các vị trí của bạn hoặc tất cả đã được xử lý.</p>
                                            <a href="InterviewManager" class="btn btn-outline-primary">
                                                <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <c:if test="${not empty applications}">
                                <!-- Chọn loại phỏng vấn -->
                                <div class="mb-5">
                                    <h5 class="section-title">
                                        <i class="bi bi-camera-video"></i>Chọn loại phỏng vấn
                                    </h5>
                                    <div class="row">
                                        <div class="col-md-4 mb-3">
                                            <div class="interview-type-card" onclick="selectInterviewType('VIDEO')">
                                                <input type="radio" name="interviewType" value="VIDEO" id="type_video" style="display: none;">
                                                <div class="interview-icon">
                                                    <i class="bi bi-camera-video"></i>
                                                </div>
                                                <h6 class="fw-bold">Video Call</h6>
                                                <p class="text-muted small mb-0">Phỏng vấn qua Zoom, Teams</p>
                                            </div>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <div class="interview-type-card" onclick="selectInterviewType('ONSITE')">
                                                <input type="radio" name="interviewType" value="ONSITE" id="type_onsite" style="display: none;">
                                                <div class="interview-icon">
                                                    <i class="bi bi-building"></i>
                                                </div>
                                                <h6 class="fw-bold">Trực tiếp</h6>
                                                <p class="text-muted small mb-0">Phỏng vấn tại văn phòng</p>
                                            </div>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <div class="interview-type-card" onclick="selectInterviewType('PHONE')">
                                                <input type="radio" name="interviewType" value="PHONE" id="type_phone" style="display: none;">
                                                <div class="interview-icon">
                                                    <i class="bi bi-telephone"></i>
                                                </div>
                                                <h6 class="fw-bold">Điện thoại</h6>
                                                <p class="text-muted small mb-0">Phỏng vấn qua điện thoại</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Thông tin phỏng vấn -->
                                <div class="mb-5">
                                    <h5 class="section-title">
                                        <i class="bi bi-calendar-event"></i>Thông tin phỏng vấn
                                    </h5>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="interviewDate" class="form-label">
                                                <i class="bi bi-calendar me-1"></i>Ngày phỏng vấn *
                                            </label>
                                            <input type="date" class="form-control" id="interviewDate" name="interviewDate"
                                                   required min="<fmt:formatDate value='<%=new java.util.Date()%>' pattern='yyyy-MM-dd'/>">
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="interviewTime" class="form-label">
                                                <i class="bi bi-clock me-1"></i>Giờ phỏng vấn *
                                            </label>
                                            <input type="time" class="form-control" id="interviewTime" name="interviewTime" required>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="location" class="form-label">
                                                <i class="bi bi-geo-alt me-1"></i>Địa điểm / Link
                                            </label>
                                            <input type="text" class="form-control" id="location" name="location"
                                                   placeholder="Địa chỉ văn phòng hoặc link">
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="interviewers" class="form-label">
                                                <i class="bi bi-person-badge me-1"></i>Người phỏng vấn
                                            </label>
                                            <input type="text" class="form-control" id="interviewers" name="interviewers"
                                                   placeholder="Người phỏng vấn">
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="description" class="form-label">
                                            <i class="bi bi-card-text me-1"></i>Mô tả phỏng vấn
                                        </label>
                                        <textarea class="form-control" id="description" name="description" rows="4"
                                                  placeholder="Mô tả chi tiết về buổi phỏng vấn, yêu cầu chuẩn bị, agenda..."></textarea>
                                    </div>
                                </div>

                                <!-- Buttons -->
                                <div class="d-flex justify-content-between">
                                    <a href="InterviewManager" class="btn btn-outline-primary">
                                        <i class="bi bi-arrow-left me-1"></i>Quay lại
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-calendar-plus me-1"></i>Tạo phỏng vấn
                                    </button>
                                </div>
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function selectCandidate(rowElement) {
            // Remove selected class from all rows
            document.querySelectorAll('.candidate-table tbody tr').forEach(function(row) {
                row.classList.remove('selected');
            });

            // Uncheck all radio buttons
            document.querySelectorAll('input[name="candidateSelection"]').forEach(function(radio) {
                radio.checked = false;
            });

            // Get application ID from data attribute
            const applicationId = rowElement.getAttribute('data-application-id');
            const radioButton = rowElement.querySelector('input[type="radio"]');

            if (rowElement && radioButton && applicationId) {
                rowElement.classList.add('selected');
                radioButton.checked = true;
                document.getElementById('selectedApplicationId').value = applicationId;
            }
        }

        function selectInterviewType(type) {
            // Remove selected class from all cards
            document.querySelectorAll('.interview-type-card').forEach(function(card) {
                card.classList.remove('selected');
            });

            // Add selected class to clicked card
            event.currentTarget.classList.add('selected');

            // Check the radio button
            document.getElementById('type_' + type.toLowerCase()).checked = true;
        }

        // Form validation
        document.getElementById('createInterviewForm').addEventListener('submit', function(e) {
            const selectedApplicationId = document.getElementById('selectedApplicationId').value;
            const interviewType = document.querySelector('input[name="interviewType"]:checked');

            if (!selectedApplicationId) {
                e.preventDefault();
                alert('Vui lòng chọn ứng viên để phỏng vấn');
                return;
            }

            if (!interviewType) {
                e.preventDefault();
                alert('Vui lòng chọn loại phỏng vấn');
                return;
            }

            const interviewDate = document.getElementById('interviewDate').value;
            const interviewTime = document.getElementById('interviewTime').value;

            if (!interviewDate || !interviewTime) {
                e.preventDefault();
                alert('Vui lòng chọn ngày và giờ phỏng vấn');
                return;
            }

            // Check if selected date/time is in the future
            const selectedDateTime = new Date(interviewDate + 'T' + interviewTime);
            const now = new Date();

            if (selectedDateTime <= now) {
                e.preventDefault();
                alert('Vui lòng chọn thời gian phỏng vấn trong tương lai');
                return;
            }

            // Confirm creation
            if (confirm('Bạn có chắc chắn muốn tạo phỏng vấn này?')) {
                return true;
            } else {
                e.preventDefault();
            }
        });

        // Prevent radio button click from triggering row click
        document.querySelectorAll('.selection-radio').forEach(function(radio) {
            radio.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        });
    </script>
</body>
</html>