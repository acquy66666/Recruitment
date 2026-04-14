<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard - Tổng quan hệ thống</title>
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

            .stats-card.primary {
                border-left-color: #007bff;
            }
            .stats-card.success {
                border-left-color: #28a745;
            }
            .stats-card.warning {
                border-left-color: #ffc107;
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

            .stats-icon.primary {
                background-color: #007bff;
            }
            .stats-icon.success {
                background-color: #28a745;
            }
            .stats-icon.warning {
                background-color: #ffc107;
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
            #revenueLineChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #jobBarChart {
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
                    Tổng quan hệ thống
                </h1>
                <p class="text-muted mb-0">Theo dõi và phân tích dữ liệu tổng quan</p>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-3 mb-4">
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card primary">
                        <div class="stats-icon primary">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stats-number text-primary">${totalCandidates}</div>
                        <div class="stats-label">Tổng số Ứng viên</div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card success">
                        <div class="stats-icon success">
                            <i class="fas fa-building"></i>
                        </div>
                        <div class="stats-number text-success">${totalRecruiters}</div>
                        <div class="stats-label">Tổng số Nhà tuyển dụng</div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card warning">
                        <div class="stats-icon warning">
                            <i class="fas fa-briefcase"></i>
                        </div>
                        <div class="stats-number text-warning">${totalJobPosts}</div>
                        <div class="stats-label">Tổng số Bài đăng đã duyệt</div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card info">
                        <div class="stats-icon info">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <div class="stats-number text-info">${totalServices}</div>
                        <div class="stats-label">Tổng số gói dịch vụ</div>
                    </div>
                </div>
            </div>
            <c:if test="${not empty errorOverview}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorOverview}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorOverview" scope="session" />
            </c:if>
            <!-- Search Filter -->
            <form action="OverviewStatistics" method="post">
                <div class="search-container">
                    <h6 class="mb-3"><i class="fas fa-filter me-2"></i>Bộ lọc thời gian</h6>

                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="fromDate" class="form-label">Từ ngày</label>
                            <input type="date" name="fromDate" class="form-control" id="fromDate" value="${fromDate}">
                        </div>
                        <div class="col-md-4">
                            <label for="toDate" class="form-label">Đến ngày</label>
                            <input type="date" name="toDate" class="form-control" id="toDate" value="${toDate}">
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

                <!-- Charts Section -->
                <div class="row g-4">
                    <!-- Revenue Line Chart -->
                    <div class="col-xl-8">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title">
                                    <i class="fas fa-chart-line me-2 text-danger"></i> Doanh thu theo tháng
                                </h6>
                                <select name="revenueOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${revenueOrder == null || revenueOrder == "" ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${revenueOrder == 'ASC' ? 'selected' : ''}>Tăng dần</option>
                                    <option value="DESC" ${revenueOrder == 'DESC' ? 'selected' : ''}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="revenueLineChart" height="100"></canvas>
                        </div>
                    </div>

                    <!-- Industry Pie Chart -->
                    <div class="col-xl-4">
                        <div class="chart-container">
                            <h6 class="chart-title">
                                <i class="fas fa-chart-pie me-2 text-primary"></i>
                                Tỷ lệ bài đăng theo ngành
                            </h6>
                            <canvas id="industryPieChart"></canvas>
                        </div>
                    </div>

                    <!-- Job Posts Bar Chart -->
                    <div class="col-12">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title">
                                    <i class="fas fa-chart-bar me-2 text-warning"></i> Bài đăng tuyển dụng theo tháng
                                </h6>
                                <select name="postOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${postOrder == null || postOrder == "" ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${postOrder == 'ASC' ? 'selected' : ''}>Tăng dần</option>
                                    <option value="DESC" ${postOrder == 'DESC' ? 'selected' : ''}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="jobBarChart" height="80"></canvas>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                    // Revenue Line Chart
                                    // Doanh thu
                                    const revenueLabels = [<c:forEach items="${revenueData}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const revenueValues = [<c:forEach items="${revenueData}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('revenueLineChart'), {
                                        type: 'line',
                                        data: {
                                            labels: revenueLabels,
                                            datasets: [{
                                                    label: 'Doanh thu (VND)',
                                                    data: revenueValues,
                                                    borderColor: '#dc3545',
                                                    backgroundColor: 'rgba(220, 53, 69, 0.1)',
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

                                    // Job Posts Bar Chart
                                    const jobLabels = [<c:forEach items="${jobPostMonthData}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const jobValues = [<c:forEach items="${jobPostMonthData}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('jobBarChart'), {
                                        type: 'bar',
                                        data: {
                                            labels: jobLabels,
                                            datasets: [{
                                                    label: 'Số bài đăng',
                                                    data: jobValues,
                                                    backgroundColor: '#ffc107',
                                                    borderColor: '#ffc107',
                                                    borderWidth: 1
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

                                    // Industry Pie Chart
                                    const industryLabels = [<c:forEach items="${jobPostIndustryData}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const industryValues = [<c:forEach items="${jobPostIndustryData}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('industryPieChart'), {
                                        type: 'pie',
                                        data: {
                                            labels: industryLabels,
                                            datasets: [{
                                                    data: industryValues,
                                                    backgroundColor: ['#0d6efd', '#198754', '#ffc107', '#dc3545', '#6f42c1', '#fd7e14']
                                                }]
                                        },
                                        options: {
                                            responsive: true,
                                            plugins: {
                                                legend: {position: 'bottom'}
                                            }
                                        }
                                    });

                                    // Filter functions
//                                    function filterData() {
//                                        const fromDate = document.getElementById('fromDate').value;
//                                        const toDate = document.getElementById('toDate').value;
//
//                                        if (!fromDate || !toDate) {
//                                            alert('Vui lòng chọn đầy đủ khoảng thời gian!');
//                                            e.preventDefault(); // huỷ submit
//                                            return;
//                                        }
//
//                                        if (new Date(fromDate) > new Date(toDate)) {
//                                            alert('Ngày bắt đầu không thể lớn hơn ngày kết thúc!');
//                                            e.preventDefault();
//                                            return;
//                                        }
//
//                                        console.log('Filtering data from', fromDate, 'to', toDate);
//                                        alert('Đã cập nhật dữ liệu theo khoảng thời gian đã chọn!');
//                                    }

                                    function resetFilter() {
                                        document.getElementById('fromDate').value = '2025-01-01';
                                        document.getElementById('toDate').value = '2025-12-31';
                                        alert('Đã reset bộ lọc về mặc định!');
                                    }

                                    // Set current date as default
//                                    document.addEventListener('DOMContentLoaded', function () {
//                                        const today = new Date().toISOString().split('T')[0];
//                                        const firstDayOfYear = new Date(new Date().getFullYear(), 0, 1).toISOString().split('T')[0];
//
//                                        document.getElementById('fromDate').value = firstDayOfYear;
//                                        document.getElementById('toDate').value = today;
//                                    });
        </script>
    </body>
</html>
