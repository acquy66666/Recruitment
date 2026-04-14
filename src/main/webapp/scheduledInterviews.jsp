<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Cuộc Họp Phỏng Vấn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .main-header {
                background: linear-gradient(135deg, #007bff, #0056b3);
                color: white;
                padding: 2rem 0;
                margin-bottom: 2rem;
            }

            .header-title {
                font-size: 1.8rem;
                font-weight: 600;
                margin: 0;
            }

            .table-container {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .table thead th {
                background-color: #f8f9fa;
                border: none;
                padding: 1rem;
                font-weight: 600;
                color: #495057;
            }

            .table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border-color: #e9ecef;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
            }

            .status-badge {
                padding: 0.4rem 0.8rem;
                border-radius: 15px;
                font-size: 0.8rem;
                font-weight: 500;
            }

            .status-scheduled {
                background-color: #fff3cd;
                color: #856404;
            }

            .status-completed {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            .btn-create {
                background-color: #28a745;
                border-color: #28a745;
                color: white;
                font-size: 0.85rem;
                padding: 0.4rem 0.8rem;
            }

            .btn-create:hover {
                background-color: #218838;
                border-color: #1e7e34;
                color: white;
            }

            .btn-email {
                background-color: #007bff;
                border-color: #007bff;
                color: white;
                font-size: 0.85rem;
                padding: 0.4rem 0.8rem;
            }

            .btn-email:hover {
                background-color: #0056b3;
                border-color: #004085;
                color: white;
            }

            .empty-message {
                text-align: center;
                padding: 3rem;
                color: #6c757d;
            }

            .candidate-name {
                font-weight: 600;
                color: #495057;
            }

            .candidate-email {
                font-size: 0.9rem;
                color: #6c757d;
            }

            @media (max-width: 768px) {
                .btn-group-mobile {
                    display: flex;
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .btn-group-mobile .btn {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="main-header">
            <div class="container">
                <h1 class="header-title">
                    <i class="fas fa-calendar-alt me-2"></i>
                    Quản Lý Cuộc Họp Phỏng Vấn
                </h1>
                <p class="mb-0 mt-2">Danh sách các cuộc họp đã lên lịch</p>
            </div>
        </div>
        <div class="mt-3">
            <a href="HomePage" style="margin-left: 80%;margin-bottom: 25px;" class="btn btn-primary">
                ⬅️ Quay về Trang chủ
            </a>
        </div>
        <c:if test="${not empty sessionScope.Recruiter}">
            <!-- Main Content -->
            <div class="container">
                <div class="table-container">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success text-center" role="alert">
                            ${message}
                        </div>
                    </c:if>
                    <script>
                        setTimeout(() => {
                            const alert = document.querySelector('.alert');
                            if (alert)
                                alert.style.display = 'none';
                        }, 3000);
                    </script>
                    <!--Test conflict-->
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID Đơn</th>
                                <th>Tiêu đề công việc</th>
                                <th>Ứng viên</th>
                                <th>Thời gian phỏng vấn</th>
                                <th>Mô tả</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach var="app" items="${listScheduleMeeting}">
                                <tr>
                                    <td>
                                        <span class="badge bg-secondary">${app.getApplicationId()}</span>
                                    </td>
                                    <td>
                                        <div class="candidate-name">${app.getJobTitle()}</div>
                                    </td>
                                    <td>
                                        <div class="candidate-name">${app.getCandidateName()}</div>
                                        <div class="candidate-email">${app.getCandidateEmail()}</div>
                                    </td>
                                    <td>
                                        <i class="fas fa-clock text-primary me-1"></i>
                                        <fmt:formatDate value="${app.getInterviewTime()}" pattern="dd/MM/yyyy HH:mm" />
                                    </td>
                                    <td>${app.getInterviewDescription()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${app.status eq 'pending'}">
                                                <span class="status-badge status-scheduled">${app.getStatus()}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-completed">${app.getStatus()}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group-mobile">
                                            <form action="createMeeting" method="post" style="display:inline;">
                                                <input type="hidden" name="application_id" value="${app.getApplicationId()}" />
                                                <input type="hidden" name="candidateName" value="${app.getCandidateName()}" />
                                                <button type="submit" class="btn btn-create btn-sm me-1">
                                                    <i class="fas fa-video me-1"></i>Tạo họp
                                                </button>
                                            </form>
                                            <form action="SendInterviewLinkServlet " method="post" style="display:inline;">
                                                <input type="hidden" name="application_id" value="${app.getApplicationId()}" />
                                                <button type="submit" class="btn btn-email btn-sm">
                                                    <i class="fas fa-envelope me-1"></i>Gửi mail
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listScheduleMeeting}">
                                <tr>
                                    <td colspan="6">
                                        <div class="empty-message">
                                            <i class="fas fa-calendar-times fa-3x mb-3 text-muted"></i>
                                            <h5>Chưa có cuộc họp nào được lên lịch</h5>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.Candidate}">
            <div class="container">
                <div class="table-container">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success text-center" role="alert">
                            ${message}
                        </div>
                    </c:if>
                    <script>
                        setTimeout(() => {
                            const alert = document.querySelector('.alert');
                            if (alert)
                                alert.style.display = 'none';
                        }, 3000);
                    </script>
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID Đơn</th>
                                <th>Tiêu đề công việc</th>
                                <th>Nhà tuyển dụng</th>
                                <th>Thời gian phỏng vấn</th>
                                <th>Mô tả</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach var="app" items="${listScheduleCandidate}">
                                <tr>
                                    <td>
                                        <span class="badge bg-secondary">${app.getApplicationId()}</span>
                                    </td>
                                    <td>
                                        <div class="candidate-name">${app.getJobTitle()}</div>
                                    </td>
                                    <td>
                                        <div class="candidate-name">${app.getRecruiterName()}</div>
                                        <div class="candidate-email">${app.getRecruiterEmail()}</div>
                                    </td>
                                    <td>
                                        <i class="fas fa-clock text-primary me-1"></i>
                                        <fmt:formatDate value="${app.getInterviewTime()}" pattern="dd/MM/yyyy HH:mm" />
                                    </td>
                                    <td>${app.getInterviewDescription()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${app.status eq 'pending'}">
                                                <span class="status-badge status-scheduled">${app.getStatus()}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-completed">${app.getStatus()}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group-mobile">
                                            <form action="viewMeeting" method="post" style="display:inline;">
                                                <input type="hidden" name="application_id" value="${app.getApplicationId()}" />
                                                <input type="hidden" name="candidateName" value="${app.getCandidateName()}" />
                                                <button type="submit" class="btn btn-create btn-sm me-1">
                                                    <i class="fas fa-video me-1"></i>Vào phỏng vấn
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listScheduleCandidate}">
                                <tr>
                                    <td colspan="6">
                                        <div class="empty-message">
                                            <i class="fas fa-calendar-times fa-3x mb-3 text-muted"></i>
                                            <h5>Chưa có cuộc họp nào được lên lịch</h5>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>