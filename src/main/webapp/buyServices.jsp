<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.recruitment.model.Service"%>
<%@page import="com.recruitment.utils.CreditManager"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Buy Services - Recruiter Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <style>
            :root {
                --primary: #0046aa;
                --primary-dark: #4f46e5;
                --secondary: #0ea5e9;
                --success: #10b981;
                --warning: #f59e0b;
                --danger: #ef4444;
                --info: #3b82f6;
                --dark: #1e293b;
                --light: #f8fafc;
                --gray: #64748b;
            }

            body {
                background-color: #f1f5f9;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
                color: #334155;
            }

            .navbar {
                background: linear-gradient(270deg, #69b3ff, #1e3fa6 73.72%);
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            }

            .navbar-brand {
                font-weight: 700;
                letter-spacing: 0.5px;
            }

            .card {
                border: none;
                border-radius: 12px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
                transition: all 0.3s ease;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.08), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            }

            .service-item {
                background-color: #e9ecef;
                padding: 15px;
                border-radius: 8px;
                text-align: center;
                transition: transform 0.2s;
            }

            .service-item:hover {
                transform: scale(1.05);
            }

            .service-item input[type="checkbox"] {
                margin-bottom: 10px;
            }

            .service-item label {
                display: block;
                font-weight: bold;
            }

            .service-item p {
                margin: 5px 0;
                color: #555;
            }

            .service-item .credits-owned {
                color: var(--warning);
                font-weight: bold;
            }

            .service-item .disabled-message {
                color: var(--danger);
                font-size: 0.9em;
                margin-top: 5px;
            }

            .total-credits {
                margin-top: 20px;
                font-size: 1.2em;
                color: var(--primary);
            }

            .btn-primary {
                background-color: var(--primary);
                border-color: var(--primary);
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

            .search-box {
                position: relative;
            }

            .search-box i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--gray);
            }

            .search-box input {
                padding-left: 40px;
                border-radius: 8px;
                border: 1px solid #e2e8f0;
                background-color: #fff;
            }

            .search-box input:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
            }

            .page-link {
                border: none;
                color: var(--gray);
                margin: 0 0.25rem;
                border-radius: 6px;
                padding: 0.375rem 0.75rem;
                font-size: 0.875rem;
            }

            .page-item.active .page-link {
                background-color: var(--primary);
                color: #fff;
            }

            .page-link:hover {
                background-color: rgba(99, 102, 241, 0.1);
                color: var(--primary);
            }

            .message {
                margin-top: 10px;
                color: var(--success);
                font-weight: bold;
            }

            @media (max-width: 767px) {
                .service-item {
                    margin-bottom: 1rem;
                }
                .search-box input {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center" href="#">
                    <i class="bi bi-briefcase-fill me-2"></i>
                    JobHub
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="HomePage">
                                <i class="bi bi-grid-1x2"></i> Trang chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="#">
                                <i class="bi bi-cart"></i> Mua gói dịch vụ
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid px-4 py-4">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                <div>
                    <h1 class="mb-1 fw-bold">Mua dịch vụ</h1>
                    <p class="text-muted mb-0">Chọn và mua các gói dịch vụ để đăng tin tuyển dụng</p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/buyServices" method="get">
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row g-3 align-items-md-center">
                            <div class="col-md-4">
                                <div class="search-box">
                                    <i class="bi bi-search"></i>
                                    <input type="text" name="search" value="${search}" class="form-control" placeholder="Tìm kiếm tên dịch vụ...">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" name="serviceType">
                                    <option value="">Tất cả loại dịch vụ</option>
                                    <c:forEach var="type" items="${availableServiceTypes}">
                                        <option value="${type}" ${serviceType == type ? 'selected' : ''}>
                                            <c:choose>
                                                <c:when test="${type == 'jobPost'}">Đăng tuyển</c:when>
                                                <c:when test="${type == 'test'}">Bài kiểm tra</c:when>
                                                <c:otherwise>${type}</c:otherwise>
                                            </c:choose>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" name="sort">
                                    <option value="service_id_desc" ${sort == 'service_id_desc' ? 'selected' : ''}>Mặc định</option>
                                    <option value="credit_asc" ${sort == 'credit_asc' ? 'selected' : ''}>Số lượt ↑</option>
                                    <option value="credit_desc" ${sort == 'credit_desc' ? 'selected' : ''}>Số lượt ↓</option>
                                    <option value="price_asc" ${sort == 'price_asc' ? 'selected' : ''}>Giá ↑</option>
                                    <option value="price_desc" ${sort == 'price_desc' ? 'selected' : ''}>Giá ↓</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bi bi-search me-1"></i> Tìm kiếm
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <form action="${pageContext.request.contextPath}/buyServices" method="post">
                <% 
                    String message = (String) request.getAttribute("message");
                    if (message != null) {
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% 
                    }
                %>
                <div class="row g-4">
                    <c:forEach var="service" items="${services}">
                        <div class="col-12 col-md-6 col-lg-4">
                            <div class="card service-item">
                                <c:set var="credits" value="${recruiterCredits.get(service.serviceType)}" />
                                <c:set var="isRestricted" value="${credits > 0}" />
                                <input type="checkbox" name="serviceId" value="${service.serviceId}" ${isRestricted ? 'disabled' : ''}>
                                <label>${service.title}</label>
                                <p>Loại: 
                                    <c:choose>
                                        <c:when test="${service.serviceType == 'jobPost'}">Đăng tuyển</c:when>
                                        <c:when test="${service.serviceType == 'test'}">Bài kiểm tra</c:when>
                                        <c:otherwise>${service.serviceType}</c:otherwise>
                                    </c:choose>
                                </p>
                                <p>Số lượt: ${service.credit}</p>
                                <p>Giá: ${service.getFormattedPrice()} VND</p>
                                <p class="credits-owned">Tín dụng còn lại: ${credits > 0 ? credits : 0}</p>
                                <c:if test="${isRestricted}">
                                    <p class="disabled-message">Bạn không thể mua: Bạn vẫn còn số lượt cho gói ${service.serviceType}</p>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button type="submit" class="btn btn-primary mt-4">Thanh toán các dịch vụ đã chọn</button>
            </form>

            <c:if test="${not empty message}">
                <div class="message">${message}</div>
                <c:if test="${not empty totalCredits}">
                    <div class="total-credits">Total Credits: ${totalCredits}</div>
                </c:if>
            </c:if>

            <div class="card-footer d-flex justify-content-end align-items-center mt-4">
                <form method="get" action="${pageContext.request.contextPath}/buyServices">
                    <input type="hidden" name="search" value="${search}">
                    <input type="hidden" name="serviceType" value="${serviceType}">
                    <input type="hidden" name="sort" value="${sort}">
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${page == 1 ? 'disabled' : ''}">
                            <button type="submit" name="page" value="${page - 1}" class="page-link" ${page == 1 ? 'disabled' : ''} aria-label="Previous">
                                <span aria-hidden="true">«</span>
                            </button>
                        </li>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == page ? 'active' : ''}">
                                <button type="submit" name="page" value="${i}" class="page-link">${i}</button>
                            </li>
                        </c:forEach>
                        <li class="page-item ${page == totalPages ? 'disabled' : ''}">
                            <button type="submit" name="page" value="${page + 1}" class="page-link" ${page == totalPages ? 'disabled' : ''} aria-label="Next">
                                <span aria-hidden="true">»</span>
                            </button>
                        </li>
                    </ul>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>