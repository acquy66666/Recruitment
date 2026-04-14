<%-- 
    Document   : RevenueReport
    Created on : Jul 11, 2025, 9:42:38 PM
    Author     : GBCenter
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Revenue Dashboard - VietJob</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f7fa;
                color: #333;
            }

            .header {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                padding: 1rem 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .header-content {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: bold;
                color: #ff6b35;
            }

            .admin-info {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            .dashboard-title {
                margin-bottom: 2rem;
            }

            .dashboard-title h1 {
                color: #1e3c72;
                font-size: 2rem;
                margin-bottom: 0.5rem;
            }

            .breadcrumb {
                color: #666;
                font-size: 0.9rem;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                padding: 1.5rem;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border-left: 4px solid #ff6b35;
                transition: transform 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-2px);
            }

            .stat-card h3 {
                color: #666;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .stat-value {
                font-size: 2rem;
                font-weight: bold;
                color: #1e3c72;
                margin-bottom: 0.5rem;
            }

            .stat-change {
                font-size: 0.8rem;
                display: flex;
                align-items: center;
                gap: 0.3rem;
            }

            .positive {
                color: #28a745;
            }

            .negative {
                color: #dc3545;
            }

            .content-grid {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 2rem;
                margin-bottom: 2rem;
            }

            .card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .card-header {
                background: #f8f9fa;
                padding: 1rem 1.5rem;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #1e3c72;
            }

            .card-body {
                padding: 1.5rem;
            }

            .revenue-chart {
                height: 300px;
                background: linear-gradient(45deg, #f0f8ff, #e6f3ff);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #666;
                font-style: italic;
            }

            .package-list {
                list-style: none;
            }

            .package-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 0;
                border-bottom: 1px solid #f0f0f0;
            }

            .package-item:last-child {
                border-bottom: none;
            }

            .package-name {
                font-weight: 600;
                color: #1e3c72;
            }

            .package-revenue {
                font-weight: bold;
                color: #ff6b35;
            }

            .package-count {
                font-size: 0.8rem;
                color: #666;
            }

            .revenue-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
            }

            .revenue-table th,
            .revenue-table td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #e9ecef;
            }

            .revenue-table th {
                background: #f8f9fa;
                font-weight: 600;
                color: #1e3c72;
            }

            .revenue-table tr:hover {
                background: #f8f9fa;
            }

            .status-badge {
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 500;
            }

            .status-active {
                background: #d4edda;
                color: #155724;
            }

            .status-expired {
                background: #f8d7da;
                color: #721c24;
            }

            .filter-bar {
                background: white;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
                display: flex;
                gap: 1rem;
                align-items: center;
                flex-wrap: wrap;
            }

            .filter-group {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .filter-group label {
                font-weight: 500;
                color: #666;
            }

            .filter-group select,
            .filter-group input {
                padding: 0.5rem;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 0.9rem;
            }

            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 0.9rem;
                transition: background-color 0.3s ease;
            }

            .btn-primary {
                background: #1e3c72;
                color: white;
            }

            .btn-primary:hover {
                background: #2a5298;
            }

            .btn-export {
                background: #ff6b35;
                color: white;
            }

            .btn-export:hover {
                background: #e55a2b;
            }

            @media (max-width: 768px) {
                .content-grid {
                    grid-template-columns: 1fr;
                }

                .header-content {
                    flex-direction: column;
                    gap: 1rem;
                }

                .filter-bar {
                    max-width: 800px;
                    margin: 0 auto;
                    padding: 16px;
                    background-color: #f8f8f8;
                    border-radius: 8px;
                    box-shadow: 0 0 10px rgba(0,0,0,0.05);
                }

                .filter-row {
                    display: flex;
                    gap: 32px;
                    margin-bottom: 20px;
                    justify-content: space-between;
                    flex-wrap: wrap;
                }

                .filter-group {
                    flex: 1;
                    min-width: 220px;
                }

                .filter-group label {
                    display: block;
                    margin-bottom: 8px;
                    font-weight: 600;
                    color: #333;
                }

                .filter-group select {
                    width: 100%;
                    padding: 20px 20px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    font-size: 14px;
                    background-color: #fff;
                }
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>
        <main style="margin-left: 280px; padding: 25px;">
            <div class="container">
                <div class="dashboard-title">
                    <h1>Báo cáo chi tiêu của khách hàng ${recruiter.fullName}, thuộc công ty ${recruiter.companyName}</h1>
                </div>

                <div class="stats-grid">
                    <div class="stat-card">
                        <h3>Tổng chi tiêu tháng này</h3>
                        <div class="stat-value">
                            <fmt:formatNumber value="${monthlyReport['totalSpent']}" type="number" groupingUsed="true" /> đ
                        </div>
                        <div class="stat-change ${monthlyReport['changeSpent'] >= 0 ? 'positive' : 'negative'}">
                            <i class="fas fa-arrow-${monthlyReport['changeSpent'] >= 0 ? 'up' : 'down'}"></i>
                            <fmt:formatNumber value="${monthlyReport['changeSpent']}" maxFractionDigits="1" />%
                            so với tháng trước
                        </div>
                    </div>


                    <div class="stat-card">
                        <h3>Tổng số lần giao dịch</h3>
                        <div class="stat-value">
                            <fmt:formatNumber value="${monthlyReport.totalTransactions}" type="number" />
                        </div>
                        <div class="stat-change ${monthlyReport.changeCount >= 0 ? 'positive' : 'negative'}">
                            <i class="fas fa-arrow-${monthlyReport.changeCount >= 0 ? 'up' : 'down'}"></i>
                            <fmt:formatNumber value="${monthlyReport.changeCount}" maxFractionDigits="1" />% so với tháng trước
                        </div>
                    </div>

                    <div class="stat-card">
                        <h3>Chi tiêu trung bình / giao dịch</h3>
                        <div class="stat-value">
                            <fmt:formatNumber value="${monthlyReport.averageSpending}" type="number" maxFractionDigits="2" /> đ
                        </div>
                        <div class="stat-change ${monthlyReport.changeAvg >= 0 ? 'positive' : 'negative'}">
                            <i class="fas fa-arrow-${monthlyReport.changeAvg >= 0 ? 'up' : 'down'}"></i>
                            <fmt:formatNumber value="${monthlyReport.changeAvg}" maxFractionDigits="1" />% so với tháng trước
                        </div>
                    </div>
                </div>


                <div class="content-grid">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Biểu đồ chi tiêu</h3>
                            <form method="get" action="RevenueReport" style="display:inline;">
                                <input type="hidden" name="recruiterID" value="${recruiter.recruiterId}" />
                                <!-- Preserve filter state -->
                                <input type="hidden" name="time" value="${time}" />
                                <input type="hidden" name="payMethod" value="${payMethod}" />
                                <input type="hidden" name="sortPrice" value="${sortPrice}" />
                                <input type="hidden" name="sortDate" value="${sortDate}" />
                                <input type="hidden" name="pageSize" value="${pageSize}" />
                                <input type="hidden" name="page" value="${pageIndex}" />
                                <select name="rangeMonths" onchange="this.form.submit()">
                                    <option value="3" ${rangeMonths == 3 ? 'selected' : ''}>3 tháng</option>
                                    <option value="6" ${rangeMonths == 6 ? 'selected' : ''}>6 tháng</option>
                                    <option value="12" ${rangeMonths == 12 ? 'selected' : ''}>1 năm</option>
                                </select>
                            </form>
                        </div>

                        <div class="card-body">
                            <canvas id="revenueChart" style="max-height: 300px;"></canvas>
                        </div>
                    </div>                   
                </div>
                <div>
                    <form action="RevenueReport" method="get" class="filter-bar">
                        <input type="hidden" name="recruiterID" value="${recruiter.recruiterId}">
                        <!-- Row 1: Time & Payment Method -->
                        <div class="filter-row">
                            <div class="filter-group">
                                <label>Thời hạn:</label>
                                <select name="time">
                                    <option value="all" ${time == 'all' ? 'selected' : ''}>Tất cả</option>
                                    <option value="month" ${time == 'month' ? 'selected' : ''}>Tháng này</option>
                                    <option value="quarter" ${time == 'quarter' ? 'selected' : ''}>Quý này</option>
                                    <option value="year" ${time == 'year' ? 'selected' : ''}>Năm này</option>
                                </select>
                            </div>

                            <div class="filter-group">
                                <label>Phương thức thanh toán:</label>
                                <select name="payMethod">
                                    <option value="all" ${payMethod == 'all' ? 'selected' : ''}>Tất cả</option>
                                    <c:forEach items="${payments}" var="p">
                                        <option value="${p}" ${payMethod == p ? 'selected' : ''}>${p}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!-- Row 2: Price & Date Sort -->
                        <div class="filter-row">
                            <div class="filter-group">
                                <label>Giá:</label>
                                <select name="sortPrice">
                                    <option value="desc" ${sortPrice == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                    <option value="asc" ${sortPrice == 'asc' ? 'selected' : ''}>Cao dần</option>
                                </select>
                            </div>

                            <div class="filter-group">
                                <label>Ngày giao dịch:</label>
                                <select name="sortDate">
                                    <option value="desc" ${sortDate == 'desc' ? 'selected' : ''}>Mới nhất</option>
                                    <option value="asc" ${sortDate == 'asc' ? 'selected' : ''}>Cũ nhất</option>
                                </select>
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-group">
                                <label>Số giao dịch/trang:</label>
                                <select name="sortDate">
                                    <option value="10" ${pageSize == '10' ? 'selected' : ''}>10</option>
                                    <option value="20" ${pageSize == '20' ? 'selected' : ''}>20</option>
                                    <option value="50" ${pageSize == '50' ? 'selected' : ''}>50</option>
                                </select>
                            </div>
                            <div class="filter-group">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-filter"></i> Lọc
                                </button>
                            </div>
                        </div>
                    </form>
                </div>


                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Lịch sử mua dịch vụ</h3>
                    </div>
                    <div class="card-body">
                        <table class="revenue-table">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Thành tiền</th>
                                    <th>Ngày thanh toán</th>
                                    <th>Phương thức thanh toán</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="l" items="${list}" varStatus="loop">
                                    <tr>
                                        <td>${(pageIndex - 1) * pageSize + loop.index + 1}</td>
                                        <td><fmt:formatNumber value="${l.price}" type="number" groupingUsed="true" /></td>
                                        <td><strong><fmt:parseDate value="${l.transactionDate}" pattern="yyyy-MM-dd" var="createdDate" />
                                                <fmt:formatDate value="${createdDate}" pattern="dd/MM/yyyy" /></strong></td>
                                        <td>${l.paymentMethod}</td>
                                    </tr>   
                                </c:forEach>
                            </tbody>
                        </table>
                        <div style="text-align:center; margin-top:1rem;" class="pagination-buttons">

                            <!-- Prev Button -->
                            <form action="RevenueReport" method="get" style="display:inline;">
                                <input type="hidden" name="recruiterID" value="${recruiter.recruiterId}" />
                                <input type="hidden" name="time" value="${time}" />
                                <input type="hidden" name="payMethod" value="${payMethod}" />
                                <input type="hidden" name="sortPrice" value="${sortPrice}" />
                                <input type="hidden" name="sortDate" value="${sortDate}" />
                                <input type="hidden" name="pageSize" value="${pageSize}" />
                                <input type="hidden" name="page" value="${pageIndex - 1}" />
                                <button class="btn btn-primary" type="submit" ${pageIndex == 1 ? 'disabled' : ''}>
                                    Trang trước
                                </button>
                            </form>

                            <!-- Page Numbers: Show ±2 around current -->
                            <c:forEach begin="1" end="${totalPages}" var="page">
                                <c:if test="${page <= pageIndex + 2 && page >= pageIndex - 2}">
                                    <form action="RevenueReport" method="get" style="display:inline;">
                                        <input type="hidden" name="recruiterID" value="${recruiter.recruiterId}" />
                                        <input type="hidden" name="time" value="${time}" />
                                        <input type="hidden" name="payMethod" value="${payMethod}" />
                                        <input type="hidden" name="sortPrice" value="${sortPrice}" />
                                        <input type="hidden" name="sortDate" value="${sortDate}" />
                                        <input type="hidden" name="pageSize" value="${pageSize}" />
                                        <input type="hidden" name="page" value="${page}" />
                                        <button class="btn btn-primary" type="submit"
                                                style="${page == pageIndex ? 'background:#2a5298; font-weight:bold;' : ''}">
                                            ${page}
                                        </button>
                                    </form>
                                </c:if>
                            </c:forEach>

                            <!-- Next Button -->
                            <form action="RevenueReport" method="get" style="display:inline;">
                                <input type="hidden" name="recruiterID" value="${recruiter.recruiterId}" />
                                <input type="hidden" name="time" value="${time}" />
                                <input type="hidden" name="payMethod" value="${payMethod}" />
                                <input type="hidden" name="sortPrice" value="${sortPrice}" />
                                <input type="hidden" name="sortDate" value="${sortDate}" />
                                <input type="hidden" name="pageSize" value="${pageSize}" />
                                <input type="hidden" name="page" value="${pageIndex + 1}" />
                                <button class="btn btn-primary" type="submit" ${pageIndex == totalPages ? 'disabled' : ''}>
                                    Trang sau
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <script>
            const revenueData = {
            labels: [
            <c:forEach var="month" items="${monthLabels}">
            "${month}"<c:if test="${!monthLast}">,</c:if>
            </c:forEach>
            ],
                    datasets: [{
                    label: 'Doanh thu theo tháng',
                            backgroundColor: '#1e3c72',
                            borderColor: '#1e3c72',
                            data: [
            <c:forEach var="amount" items="${monthlyRevenue}">
                ${amount}<c:if test="${!amountLast}">,</c:if>
            </c:forEach>
                            ],
                            fill: true
                    }]
            };
            const config = {
            type: 'bar',
                    data: revenueData,
                    options: {
                    responsive: true,
                            scales: {
                            y: {
                            beginAtZero: true,
                                    ticks: {
                                    callback: value => value + ' đ'
                                    }
                            }
                            }
                    }
            };
            window.onload = () => {
            const ctx = document.getElementById('revenueChart').getContext('2d');
            new Chart(ctx, config);
            };
        </script>
    </body>
</html>
