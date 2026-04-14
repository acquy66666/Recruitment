<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.recruitment.model.Service"%>
<%@page import="com.recruitment.model.Promotion"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Payment - Recruiter Dashboard</title>
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
        }

        .service-item {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .service-item label {
            font-weight: bold;
        }

        .total-amount {
            font-size: 1.5em;
            font-weight: bold;
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

        .btn-secondary {
            background-color: var(--secondary);
            border-color: var(--secondary);
        }

        .btn-secondary:hover {
            background-color: #0284c7;
            border-color: #0284c7;
        }

        .message {
            margin-top: 10px;
            color: var(--success);
            font-weight: bold;
        }
    </style>
<script>
    function calculateTotal() {
        let total = 0;

        // Collect total from services
        const serviceInputs = document.querySelectorAll('input[name="serviceIds"]');
        serviceInputs.forEach(input => {
            const serviceId = input.value;
            const priceInput = document.getElementById('price_' + serviceId);
            const price = parseFloat(priceInput?.value) || 0;
            total += price;
        });

        // Apply promotion if selected
        let discount = 0;
        const promotionSelect = document.getElementById('promotionId');
        const promotionId = promotionSelect.value;

        if (promotionId !== "") {
            const selectedOption = promotionSelect.options[promotionSelect.selectedIndex];
            const discountPercent = parseFloat(selectedOption.dataset.discountPercent) || 0;
            const maxDiscount = parseFloat(selectedOption.dataset.maxDiscount) || 0;

            if (discountPercent > 0) {
                const calculatedDiscount = total * discountPercent / 100;
                discount = Math.min(calculatedDiscount, maxDiscount);
            }
        }

        const finalTotal = Math.max(0, total - discount);
        document.getElementById('totalAmount').textContent = finalTotal.toLocaleString('vi-VN') + ' VND';
    }

    window.onload = calculateTotal;
</script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <i class="bi bi-briefcase-fill me-2"></i>
            JobBoard Pro
        </a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="HomePage"><i class="bi bi-grid-1x2"></i> Home Page</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/buyServices"><i class="bi bi-cart"></i> Buy Services</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/transactionHistory"><i class="bi bi-clock-history"></i> Transaction History</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 py-4">
    <h1 class="mb-1 fw-bold">Thanh toán dịch vụ</h1>
    <p class="text-muted mb-4">Xác nhận các dịch vụ đã chọn để hoàn tất mua hàng</p>

    <form action="${pageContext.request.contextPath}/servicepayment" method="post">
        <!-- Services Card -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="mb-3">Dịch vụ đã chọn</h5>
                <c:forEach var="service" items="${selectedServices}">
                    <div class="service-item">
                        <label>${service.title} (Type: ${service.serviceType})</label>
                        <p>Price: ${service.price != null ? service.getFormattedPrice() : "0"} VND</p>
                        <p>Credits: ${service.credit}</p>
                        <input type="hidden" name="serviceIds" value="${service.serviceId}">
                        <input type="hidden" id="price_${service.serviceId}" value="${service.price != null ? service.price : 0}">
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Promotion Card -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="mb-3">Chọn khuyến mãi</h5>
                <select class="form-select" name="promotionId" id="promotionId" onchange="calculateTotal()">
                    <option value="">Không sử dụng khuyến mãi</option>
                    <c:forEach var="promotion" items="${activePromotions}">
                        <option value="${promotion.promotionId}"
                                data-discount-percent="${promotion.discountPercent != null ? promotion.discountPercent : 0}"
                                data-max-discount="${promotion.maxDiscountAmount != null ? promotion.maxDiscountAmount : 0}">
                            ${promotion.title} (${promotion.promoCode} - ${promotion.discountPercent}% off, max ${promotion.maxDiscountAmount} VND)
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <!-- Total -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="mb-3">Tổng tiền</h5>
                <p class="total-amount" id="totalAmount">0 VND</p>
            </div>
        </div>

        <!-- Buttons -->
        <button type="submit" class="btn btn-primary">Hoàn tất thanh toán</button>
        <a href="${pageContext.request.contextPath}/buyServices" class="btn btn-secondary">Quay lại</a>
    </form>

    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>