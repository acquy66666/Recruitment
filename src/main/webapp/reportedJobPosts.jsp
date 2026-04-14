<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bài đăng bị báo cáo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f9f9f9;
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            margin-top: 30px;
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        .btn-review {
            background-color: #0d6efd;
            color: white;
        }
        .btn-delete:hover, .btn-review:hover {
            opacity: 0.85;
        }
        .pagination .page-link {
            border-radius: 0.3rem !important;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            transition: 0.3s ease;
        }
        .pagination .page-link:hover {
            background-color: #0d6efd;
            color: white;
        }
        .pagination .active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: white;
        }
        .pagination .page-link:disabled {
            opacity: 0.5;
            pointer-events: none;
        }
    </style>
</head>
<body>
    <%@ include file="leftNavbar.jsp" %>

    <div style="margin-left: 280px; padding: 25px;">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Bài đăng bị báo cáo</h2>
            </div>

            <form action="ReportedJobPosts" method="post" class="row g-3 align-items-end mb-4">
                <div class="col-md-4">
                    <label class="form-label">Tìm kiếm</label>
                    <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm kiếm theo tiêu đề hoặc tên công ty">
                </div>
                <div class="col-md-1" style="width: 6%;">
                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                </div>
            </form>

            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="message" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="error" scope="session" />
            </c:if>

            <c:if test="${empty reportedPosts}">
                <p>Không có bài đăng nào bị báo cáo.</p>
            </c:if>

            <c:if test="${not empty reportedPosts}">
                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th style="width: 25%;">Tiêu đề</th>
                            <th>Công ty</th>
                            <th>Email</th>
                            <th>Địa điểm</th>
                            <th>Loại công việc</th>
                            <th>Ngày đăng</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="job" items="${reportedPosts}">
                            <tr>
                                <td>${job.jobId}</td>
                                <td>${job.title}</td>
                                <td>${job.recruiter.companyName}</td>
                                <td>${job.recruiter.email}</td>
                                <td>${job.location}</td>
                                <td>${job.jobType}</td>
                                <td>${job.createdAt}</td>
                                <td>
                                    <form action="ReportedJobPosts" method="post">
                                        <input type="hidden" name="jobId" value="${job.jobId}">
                                        <input type="hidden" name="keyword" value="${keyword}">
                                        <button type="submit" name="action" value="delete" class="btn btn-sm btn-delete">Xóa</button>
                                        <button type="submit" name="action" value="markReviewed" class="btn btn-sm btn-review">Duyệt lại</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <form action="ReportedJobPosts" method="post">
                    <input type="hidden" name="keyword" value="${keyword}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                <button type="submit" name="page" value="${page - 1}" class="page-link" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </button>
                            </li>
                            <c:forEach var="i" begin="1" end="${num}">
                                <li class="page-item ${i == page ? 'active' : ''}">
                                    <button type="submit" name="page" value="${i}" class="page-link">${i}</button>
                                </li>
                            </c:forEach>
                            <li class="page-item ${page == num ? 'disabled' : ''}">
                                <button type="submit" name="page" value="${page + 1}" class="page-link" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </button>
                            </li>
                        </ul>
                    </nav>
                </form>
            </c:if>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>