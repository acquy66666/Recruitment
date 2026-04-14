<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Giao Dịch - Recruiter Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --primary: #0046aa;
            --primary-dark: #003087;
            --secondary: #0ea5e9;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --light: #f8fafc;
            --gray: #64748b;
        }

        body {
            background-color: #f1f5f9;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            color: #334155;
        }

        .navbar {
            background: linear-gradient(90deg, #1e3fa6, #69b3ff);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }

        .table {
            background-color: #fff;
            border-radius: 8px;
        }

        .table tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .table tr:hover {
            background-color: rgba(0, 70, 170, 0.05);
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .status-badge {
            padding: 0.3em 0.6em;
            border-radius: 12px;
            font-size: 0.85em;
        }

        .status-pending { background-color: var(--warning); color: #fff; }
        .status-completed { background-color: var(--success); color: #fff; }
        .status-failed { background-color: var(--danger); color: #fff; }
    </style>
</head>
<body>
    <fmt:setLocale value="vi_VN"/>
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container-fluid px-4">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <i class="bi bi-briefcase-fill me-2"></i> JobBoard Pro
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="HomePage"><i class="bi bi-grid-1x2"></i> Trang Chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/buyServices"><i class="bi bi-cart"></i> Mua Dịch Vụ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/transactionHistory"><i class="bi bi-clock-history"></i> Lịch Sử Giao Dịch</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid px-4 py-4">
        <h1 class="mb-3 fw-bold">Lịch Sử Giao Dịch</h1>
        <p class="text-muted mb-4">Xem tất cả các giao dịch của bạn.</p>

        <div class="card">
            <div class="card-body">
                <h5 class="mb-3">Danh Sách Giao Dịch</h5>
                <c:choose>
                    <c:when test="${empty transactions}">
                        <p class="text-muted">Không tìm thấy giao dịch nào.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Mã Đơn Hàng</th>
                                        <th>Ngày</th>
                                        <th>Giá</th>
                                        <th>Tổng Credits</th>
                                        <th>Trạng Thái</th>
                                        <th>Chi Tiết</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="transaction" items="${transactions}">
                                        <tr onclick="window.location.href='${pageContext.request.contextPath}/transactionHistory?transactionId=${transaction.transactionId}'">
                                            <td>${transaction.orderId}</td>
                                            <!-- Handle LocalDateTime and null check -->
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty transaction.dateTime}">
                                                        ${transaction.dateTime}
                                                    </c:when>
                                                    <c:otherwise>
                                                        N/A
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatNumber value="${transaction.price}" type="currency" currencySymbol=""/></td>
                                            <td>${transaction.totalCredits}</td>
                                            <td>
                                                <span class="status-badge status-${fn:toLowerCase(transaction.status)}">
                                                    <c:choose>
                                                        <c:when test="${transaction.status == 'pending'}">Đang Xử Lý</c:when>
                                                        <c:when test="${transaction.status == 'completed'}">Hoàn Thành</c:when>
                                                        <c:when test="${transaction.status == 'failed'}">Thất Bại</c:when>
                                                        <c:otherwise>${transaction.status}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/transactionHistory?transactionId=${transaction.transactionId}" class="btn btn-sm btn-primary">
                                                    <i class="bi bi-eye"></i> Xem
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/HomePage" class="btn btn-secondary mt-4">Quay Lại Dashboard</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
