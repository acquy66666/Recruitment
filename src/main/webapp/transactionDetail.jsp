<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Giao Dịch - Recruiter Dashboard</title>
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

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .btn-secondary {
            background-color: var(--secondary);
            border-color: var(--secondary);
        }

        .btn-secondary:hover {
            background-color: #0284c7;
            border-color: #0284c7;
        }
    </style>
</head>
<body>
    <fmt:setLocale value="vi_VN"/>
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container-fluid px-4">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <i class="bi bi-briefcase-fill me-2"></i>
                JobBoard Pro
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="HomePage">
                            <i class="bi bi-grid-1x2"></i> Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/buyServices">
                            <i class="bi bi-cart"></i> Mua Dịch Vụ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/transactionHistory">
                            <i class="bi bi-clock-history"></i> Lịch Sử Giao Dịch
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid px-4 py-4">
        <h1 class="mb-3 fw-bold">Chi Tiết Giao Dịch</h1>
        <p class="text-muted mb-4">Thông tin chi tiết của giao dịch #${transaction.transactionId}</p>

        <div class="card mb-4">
            <div class="card-body">
                <h5 class="mb-3">Thông Tin Giao Dịch</h5>
                <dl class="row mb-0">
                    <dt class="col-sm-3">ID Giao Dịch</dt>
                    <dd class="col-sm-9">${transaction.transactionId}</dd>

                    <dt class="col-sm-3">Mã Đơn Hàng</dt>
                    <dd class="col-sm-9">${transaction.orderId}</dd>

                    <dt class="col-sm-3">Ngày Giao Dịch</dt>
                    <dd class="col-sm-9">
                        <c:choose>
                            <c:when test="${not empty transaction.dateTime}">
                                ${transaction.dateTime}
                            </c:when>
                            <c:otherwise>
                                N/A
                            </c:otherwise>
                        </c:choose>
                    </dd>

                    <dt class="col-sm-3">Tổng Giá</dt>
                    <dd class="col-sm-9"><fmt:formatNumber value="${transaction.price}" type="currency" currencySymbol=""/></dd>

                    <dt class="col-sm-3">Phương Thức Thanh Toán</dt>
                    <dd class="col-sm-9">${transaction.paymentMethod}</dd>

                    <dt class="col-sm-3">Tổng Credits</dt>
                    <dd class="col-sm-9">${transaction.totalCredits}</dd>

                    <dt class="col-sm-3">Khuyến Mãi</dt>
                    <dd class="col-sm-9">
                        <c:choose>
                            <c:when test="${not empty promotion}">
                                ${promotion.title} (${promotion.promoCode})
                            </c:when>
                            <c:otherwise>
                                Không áp dụng
                            </c:otherwise>
                        </c:choose>
                    </dd>
                </dl>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <h5 class="mb-3">Chi Tiết Dịch Vụ</h5>
                <c:choose>
                    <c:when test="${empty detailViews}">
                        <p class="text-muted">Không tìm thấy chi tiết dịch vụ nào cho giao dịch này.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Tên Dịch Vụ</th>
                                        <th>Loại Dịch Vụ</th>
                                        <th>Credits</th>
                                        <th>Đơn Giá</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="detailView" items="${detailViews}">
                                        <tr>
                                            <td>${detailView.serviceName}</td>
                                            <td>${detailView.serviceType}</td>
                                            <td>${detailView.credit}</td>
                                            <td><fmt:formatNumber value="${detailView.unitPrice}" type="currency" currencySymbol=""/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/transactionHistory" class="btn btn-secondary mt-4">
            <i class="bi bi-arrow-left"></i> Quay Lại
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>