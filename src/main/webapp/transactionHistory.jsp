<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.recruitment.model.TransactionView"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History - Recruiter Dashboard</title>
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

        .table {
            background-color: #fff;
            border-radius: 8px;
        }

        .table tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .table tr:hover {
            background-color: rgba(99, 102, 241, 0.1);
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }
    </style>
</head>
<body>
    <fmt:setLocale value="vi_VN"/>
    <div class="container-fluid px-4 py-4">
        <h1>Transaction Details</h1>
        <div class="card mb-4">
            <div class="card-body">
                <h5>Transaction Info</h5>
                <p><strong>ID:</strong> ${transaction.transactionId}</p>
                <p><strong>Order ID:</strong> ${transaction.orderId}</p>
                <p><strong>Date:</strong> <fmt:formatDate value="${transaction.dateTime}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                <p><strong>Total Price:</strong> <fmt:formatNumber value="${transaction.price}" type="currency" currencySymbol="VND"/></p>
                <p><strong>Payment Method:</strong> ${transaction.paymentMethod}</p>
                <p><strong>Status:</strong> ${transaction.status}</p>
                <p><strong>Total Credits:</strong> ${transaction.totalCredits}</p>
                <c:if test="${not empty promotion}">
                    <p><strong>Promotion:</strong> ${promotion.title} (${promotion.promoCode})</p>
                </c:if>
            </div>
        </div>
        <div class="card">
            <div class="card-body">
                <h5>Service Details</h5>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Service Name</th>
                            <th>Service Type</th>
                            <th>Credits</th>
                            <th>Unit Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="detailView" items="${detailViews}">
                            <tr>
                                <td>${detailView.serviceName}</td>
                                <td>${detailView.serviceType}</td>
                                <td>${detailView.credit}</td>
                                <td><fmt:formatNumber value="${detailView.detail.unitPrice}" type="currency" currencySymbol="VND"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/transactionHistory" class="btn btn-secondary mt-4">Back</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>