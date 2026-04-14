<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê Doanh thu</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .main-content {
                margin-left: 280px;
                padding: 25px;
            }

            .page-header {
                background: white;
                border-radius: 10px;
                padding: 25px;
                margin-bottom: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            }

            .page-title {
                color: #2c3e50;
                font-weight: 600;
                font-size: 1.8rem;
                margin: 0;
            }

            .stats-card {
                background: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                border-left: 4px solid;
                transition: transform 0.2s ease;
            }

            .stats-card:hover {
                transform: translateY(-2px);
            }

            .stats-card.success {
                border-left-color: #28a745;
            }
            .stats-card.primary {
                border-left-color: #007bff;
            }
            .stats-card.info {
                border-left-color: #17a2b8;
            }

            .stats-icon {
                width: 50px;
                height: 50px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                color: white;
                margin-bottom: 15px;
            }

            .stats-icon.success {
                background-color: #28a745;
            }
            .stats-icon.primary {
                background-color: #007bff;
            }
            .stats-icon.info {
                background-color: #17a2b8;
            }

            .stats-number {
                font-size: 2rem;
                font-weight: 700;
                margin: 8px 0;
            }

            .stats-label {
                color: #6c757d;
                font-weight: 500;
                font-size: 0.9rem;
            }

            .chart-container {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                margin-bottom: 25px;
            }

            .chart-title {
                font-weight: 600;
                font-size: 1.1rem;
                margin-bottom: 20px;
                color: #495057;
            }

            .search-container {
                background: white;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 25px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            }

            .form-control {
                border-radius: 8px;
                border: 1px solid #ced4da;
                padding: 10px 12px;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            .btn-search {
                background-color: #007bff;
                border-color: #007bff;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }

            .btn-search:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            .btn-reset {
                background-color: #6c757d;
                border-color: #6c757d;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }

            .btn-reset:hover {
                background-color: #545b62;
                border-color: #545b62;
            }

            .insight-card {
                background: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                margin-bottom: 25px;
            }

            .top-list {
                background: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            }

            .list-group-item {
                border: none;
                padding: 12px 0;
                border-bottom: 1px solid #f1f3f4;
            }

            .list-group-item:last-child {
                border-bottom: none;
            }

            .trend-up {
                color: #28a745;
            }

            .trend-down {
                color: #dc3545;
            }
            #revenueByMonthChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #revenueByServiceChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #transactionPerDayChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #topServicesChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 15px;
                }

                .page-title {
                    font-size: 1.5rem;
                }

                .stats-number {
                    font-size: 1.8rem;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>

        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-chart-line me-2"></i>
                    Thống kê Doanh thu
                </h1>
                <p class="text-muted mb-0">Theo dõi và phân tích doanh thu hệ thống</p>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-3 mb-4">
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card success">
                        <div class="stats-icon success">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="stats-number text-success">
                            <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                        </div>
                        <div class="stats-label">Tổng doanh thu</div>
                        <small class="text-muted">Toàn thời gian</small>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card primary">
                        <div class="stats-icon primary">
                            <i class="fas fa-calendar-month"></i>
                        </div>
                        <div class="stats-number text-primary">
                            <fmt:formatNumber value="${currentMonthRevenue}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                        </div>
                        <div class="stats-label">Doanh thu tháng này</div>
                        <c:choose>
                            <c:when test="${revenueGrowthRate >= 0}">
                                <small class="trend-up text-success">
                                    🔼 <fmt:formatNumber value="${revenueGrowthRate}" type="number" maxFractionDigits="1" />% so với tháng trước
                                </small>
                            </c:when>
                            <c:otherwise>
                                <small class="trend-down text-danger">
                                    🔽 <fmt:formatNumber value="${revenueGrowthRate}" type="number" maxFractionDigits="1" />% so với tháng trước
                                </small>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card info">
                        <div class="stats-icon info">
                            <i class="fas fa-handshake"></i>
                        </div>
                        <div class="stats-number text-info">${currentMonthTransactions}</div>
                        <div class="stats-label">Tổng giao dịch trong tháng này</div>
                        <c:choose>
                            <c:when test="${transactionGrowthRate >= 0}">
                                <small class="trend-up text-success">
                                    🔼 <fmt:formatNumber value="${transactionGrowthRateALL}" type="number" maxFractionDigits="1" />% so với tháng trước
                                </small>
                            </c:when>
                            <c:otherwise>
                                <small class="trend-down text-danger">
                                    🔽 <fmt:formatNumber value="${transactionGrowthRateALL}" type="number" maxFractionDigits="1" />% so với tháng trước
                                </small>
                            </c:otherwise>
                        </c:choose>      
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card info">
                        <div class="stats-icon info">
                            <i class="fas fa-handshake"></i>
                        </div>
                        <div class="stats-number text-info">${currentMonthTransactionsSuccess}</div>
                        <div class="stats-label">Giao dịch thành công trong tháng</div>
                        <c:choose>
                            <c:when test="${transactionGrowthRate >= 0}">
                                <small class="trend-up text-success">
                                    🔼 <fmt:formatNumber value="${transactionGrowthRate}" type="number" maxFractionDigits="1" />% so với tháng trước
                                </small>
                            </c:when>
                            <c:otherwise>
                                <small class="trend-down text-danger">
                                    🔽 <fmt:formatNumber value="${transactionGrowthRate}" type="number" maxFractionDigits="1" />% so với tháng trước
                                </small>
                            </c:otherwise>
                        </c:choose> 
                    </div>
                </div>
            </div>
            <c:if test="${not empty errorRevenueStatistic}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorRevenueStatistic}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorRevenueStatistic" scope="session" />
            </c:if>
            <!-- Search Filter -->
            <form action="RevenueStatistics" method="post">
                <div class="search-container">
                    <h6 class="mb-3"><i class="fas fa-filter me-2"></i>Bộ lọc thời gian</h6>
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="fromDate" class="form-label">Từ ngày</label>
                            <input type="date" name="fromDateRevenue" class="form-control" id="fromDate" value="${fromDateRevenue}">
                        </div>
                        <div class="col-md-4">
                            <label for="toDate" class="form-label">Đến ngày</label>
                            <input type="date" name="toDateRevenue" class="form-control" id="toDate" value="${toDateRevenue}">
                        </div>
                        <div class="col-md-4">
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary btn-search flex-fill">
                                    <i class="fas fa-search me-1"></i>Tìm kiếm
                                </button>
                                <button type="button" class="btn btn-secondary btn-reset" onclick="resetFilter()">
                                    <i class="fas fa-redo me-1"></i>Reset
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Revenue Insights -->
                <div class="insight-card">
                    <h6 class="mb-3">
                        <i class="fas fa-lightbulb me-2 text-warning"></i>
                        Nhận xét doanh thu
                    </h6>
                    <div class="alert alert-success mb-0" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        Doanh thu tháng này tăng <strong>12.5%</strong> so với tháng trước. Tiếp tục duy trì ưu đãi hiệu quả.
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="row g-4 mb-4">
                    <!-- Revenue by Month -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title mb-0">
                                    <i class="fas fa-chart-line me-2 text-success"></i> Doanh thu theo tháng
                                </h6>
                                <select name="revenueMonthOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${revenueMonthOrder == null || revenueMonthOrder == "" ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${revenueMonthOrder == 'ASC' ? 'selected' : ""}>Tăng dần</option>
                                    <option value="DESC" ${revenueMonthOrder == 'DESC' ? 'selected' : ""}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="revenueByMonthChart" height="200"></canvas>
                        </div>
                    </div>

                    <!-- Revenue by Service -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title mb-0">
                                    <i class="fas fa-chart-bar me-2 text-primary"></i> Doanh thu theo gói dịch vụ
                                </h6>
                                <select name="revenueServiceOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${revenueServiceOrder == null || revenueServiceOrder == "" ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${revenueServiceOrder == 'ASC' ? 'selected' : ""}>Tăng dần</option>
                                    <option value="DESC" ${revenueServiceOrder == 'DESC' ? 'selected' : ""}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="revenueByServiceChart" height="200"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Additional Charts -->
                <div class="row g-4 mb-4">
                    <!-- Transactions per Day -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title mb-0">
                                    <i class="fas fa-calendar-day me-2 text-info"></i> Giao dịch thành công theo tháng
                                </h6>
                                <select name="transactionDayOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${transactionDayOrder == null || transactionDayOrder == "" ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${transactionDayOrder == 'ASC' ? 'selected' : ""}>Tăng dần</option>
                                    <option value="DESC" ${transactionDayOrder == 'DESC' ? 'selected' : ""}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="transactionPerDayChart" height="200"></canvas>
                        </div>
                    </div>

                    <!-- Top Services -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title mb-0">
                                    <i class="fas fa-fire me-2 text-danger"></i> Dịch vụ bán chạy nhất
                                </h6>
                                <select name="topServiceOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${topServiceOrder == null || topServiceOrder == "" ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${topServiceOrder == 'ASC' ? 'selected' : ""}>Tăng dần</option>
                                    <option value="DESC" ${topServiceOrder == 'DESC' ? 'selected' : ""}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="topServicesChart" height="200"></canvas>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Top Customers -->
            <div class="row g-4">
                <div class="col-md-8">
                    <div class="top-list">
                        <h6 class="mb-3">
                            <i class="fas fa-trophy me-2 text-warning"></i>
                            Top 5 nhà tuyển dụng chi nhiều nhất
                        </h6>
                        <c:forEach var="top" items="${top5RecruitersBySpending}">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div>
                                        <i class="fas fa-building me-2 text-success"></i>
                                        <strong>${top.getName()}</strong>
                                    </div>
                                    <span class="badge bg-success rounded-pill"><fmt:formatNumber value="${top.getTotal()}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/></span>
                                </li>
                            </ul>
                        </c:forEach>
                    </div>
                </div>

                <!-- Revenue Summary -->
                <div class="col-md-4">
                    <div class="top-list">
                        <h6 class="mb-3">
                            <i class="fas fa-chart-pie me-2 text-info"></i>
                            Tóm tắt doanh thu
                        </h6>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Doanh thu trung bình/tháng:</span>
                            <strong class="text-primary">
                                <fmt:formatNumber value="${avgRevenuePerMonth}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                            </strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Giao dịch trung bình/ngày:</span>
                            <strong class="text-info">
                                <fmt:formatNumber value="${avgTransactionPerDay}" groupingUsed="true" maxFractionDigits="1"/>
                            </strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Giá trị giao dịch TB:</span>
                            <strong class="text-success">
                                <fmt:formatNumber value="${avgTransactionValue}" type="currency" currencySymbol="₫" groupingUsed="true" maxFractionDigits="0"/>
                            </strong>
                        </div>
                        <hr>
                        <!--                        <div class="d-flex justify-content-between">
                                                    <span>Tăng trưởng dự kiến:</span>
                                                    <strong class="text-warning">+15%</strong>
                                                </div>-->
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                    // Revenue by Month Chart
                                    const revenueMonthLabels = [<c:forEach items="${revenueByMonthGrowth}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const revenueMonthValues = [<c:forEach items="${revenueByMonthGrowth}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('revenueByMonthChart'), {
                                        type: 'line',
                                        data: {
                                            labels: revenueMonthLabels,
                                            datasets: [{
                                                    label: 'Doanh thu (VND)',
                                                    data: revenueMonthValues,
                                                    borderColor: '#198754',
                                                    backgroundColor: 'rgba(25, 135, 84, 0.1)',
                                                    borderWidth: 2,
                                                    fill: true,
                                                    tension: 0.3
                                                }]
                                        },
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: {
                                                legend: {
                                                    display: true,
                                                    position: 'top'
                                                }
                                            },
                                            scales: {
                                                y: {
                                                    beginAtZero: true,
                                                    ticks: {
                                                        callback: function (value) {
                                                            return new Intl.NumberFormat('vi-VN').format(value) + ' VND';
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    });

                                    // Revenue by Service Chart
                                    const revenueServiceLabels = [<c:forEach items="${revenueByServiceGrowth}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const revenueServiceValues = [<c:forEach items="${revenueByServiceGrowth}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('revenueByServiceChart'), {
                                        type: 'bar',
                                        data: {
                                            labels: revenueServiceLabels,
                                            datasets: [{
                                                    label: 'Doanh thu (VND)',
                                                    data: revenueServiceValues,
                                                    backgroundColor: ['#0d6efd', '#ffc107', '#dc3545'],
                                                    borderWidth: 1
                                                }]
                                        },
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: {
                                                legend: {display: false}
                                            },
                                            scales: {
                                                y: {
                                                    beginAtZero: true,
                                                    ticks: {
                                                        callback: function (value) {
                                                            return new Intl.NumberFormat('vi-VN').format(value) + ' VND';
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    });


                                    // Transaction per Day Chart
                                    const transactionLabels = [<c:forEach items="${transactionPerMonthGrowth}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const transactionValues = [<c:forEach items="${transactionPerMonthGrowth}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('transactionPerDayChart'), {
                                        type: 'line',
                                        data: {
                                            labels: transactionLabels,
                                            datasets: [{
                                                    label: 'Giao dịch',
                                                    data: transactionValues,
                                                    borderColor: '#0d6efd',
                                                    backgroundColor: 'rgba(13, 110, 253, 0.1)',
                                                    borderWidth: 2,
                                                    fill: true,
                                                    tension: 0.3
                                                }]
                                        },
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: {
                                                legend: {
                                                    display: true,
                                                    position: 'top'
                                                }
                                            },
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });


                                    // Top Services Chart
                                    const topServiceLabels = [<c:forEach items="${topServicesGrowth}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const topServiceValues = [<c:forEach items="${topServicesGrowth}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('topServicesChart'), {
                                        type: 'bar',
                                        data: {
                                            labels: topServiceLabels,
                                            datasets: [{
                                                    label: 'Lượt mua',
                                                    data: topServiceValues,
                                                    backgroundColor: ['#0d6efd', '#198754', '#ffc107', '#dc3545', '#6f42c1'],
                                                    borderWidth: 1
                                                }]
                                        },
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: {
                                                legend: {display: true, position: 'top'}
                                            },
                                            scales: {
                                                y: {beginAtZero: true}
                                            }
                                        }
                                    });



                                    function resetFilter() {
                                        document.getElementById('fromDate').value = '2025-01-01';
                                        document.getElementById('toDate').value = '2025-12-31';
                                        alert('Đã reset bộ lọc về mặc định!');
                                    }

        </script>
    </body>
</html>
