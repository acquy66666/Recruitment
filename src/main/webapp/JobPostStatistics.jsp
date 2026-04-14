<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê Bài đăng</title>
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
                text-align: center;
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
            .stats-card.danger {
                border-left-color: #dc3545;
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
                margin: 0 auto 15px;
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
            .stats-icon.danger {
                background-color: #dc3545;
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
            #jobByIndustryChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #jobStatusChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #applicationByIndustryChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #jobsByMonthChart {
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
                    <i class="fas fa-briefcase me-2"></i>
                    Thống kê Bài đăng
                </h1>
                <p class="text-muted mb-0">Theo dõi và phân tích dữ liệu bài đăng tuyển dụng</p>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-3 mb-4">
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <div class="stats-card primary">
                        <div class="stats-icon primary">
                            <i class="fas fa-file-alt"></i>
                        </div>
                        <div class="stats-number text-primary">${totalJobPosts}</div>
                        <div class="stats-label">Tổng bài đăng</div>
                    </div>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <div class="stats-card success">
                        <div class="stats-icon success">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stats-number text-success">${totalApproveJobs}</div>
                        <div class="stats-label">Đã duyệt</div>
                    </div>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <div class="stats-card warning">
                        <div class="stats-icon warning">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stats-number text-warning">${totalPendingJobs}</div>
                        <div class="stats-label">Chờ duyệt</div>
                    </div>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <div class="stats-card danger">
                        <div class="stats-icon danger">
                            <i class="fas fa-times-circle"></i>
                        </div>
                        <div class="stats-number text-danger">${totalRejectedJobs}</div>
                        <div class="stats-label">Đã từ chối</div>
                    </div>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <div class="stats-card info">
                        <div class="stats-icon info">
                            <i class="fas fa-times-circle"></i>
                        </div>
                        <div class="stats-number text-info">${totalExpiredJobs}</div>
                        <div class="stats-label">Đã hết hạn</div>
                    </div>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <div class="stats-card info">
                        <div class="stats-icon info">
                            <i class="fas fa-paper-plane"></i>
                        </div>
                        <div class="stats-number text-info">${totalApplications}</div>
                        <div class="stats-label">Số đơn ứng tuyển</div>
                    </div>
                </div>
            </div>
            <c:if test="${not empty errorJobPostStatistic}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorJobPostStatistic}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorJobPostStatistic" scope="session" />
            </c:if>
            <!-- Search Filter -->
            <form action="JobPostStatistics" method="post">
                <div class="search-container">
                    <h6 class="mb-3"><i class="fas fa-filter me-2"></i>Bộ lọc thời gian</h6>
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="fromDate" class="form-label">Từ ngày</label>
                            <input type="date" name="fromDateJobPost" class="form-control" id="fromDate" value="${fromDateJobPost}">
                        </div>
                        <div class="col-md-4">
                            <label for="toDate" class="form-label">Đến ngày</label>
                            <input type="date" name="toDateJobPost" class="form-control" id="toDate" value="${toDateJobPost}">
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
                <div class="row g-4 mb-4">
                    <!-- Jobs by Industry -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title">
                                    <i class="fas fa-chart-bar me-2 text-primary"></i>
                                    Bài đăng theo ngành nghề
                                </h6>
                                <select name="jobIndustryOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${jobIndustryOrder == null || jobIndustryOrder == "" ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${jobIndustryOrder == 'ASC' ? 'selected' : ''}>Tăng dần</option>
                                    <option value="DESC" ${jobIndustryOrder == 'DESC' ? 'selected' : ''}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="jobByIndustryChart" height="200"></canvas>
                        </div>
                    </div>

                    <!-- Job Status -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <h6 class="chart-title">
                                <i class="fas fa-chart-pie me-2 text-success"></i>
                                Trạng thái bài đăng
                            </h6>
                            <canvas id="jobStatusChart" height="200"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Applications by Industry -->
                <div class="row g-4 mb-4">
                    <div class="col-md-8">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title mb-0">
                                    <i class="fas fa-chart-line me-2 text-info"></i> Ứng tuyển theo ngành nghề
                                </h6>
                                <select name="applicationByIndustryOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${applicationByIndustryOrder == null || applicationByIndustryOrder == "" ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${applicationByIndustryOrder == 'ASC' ? 'selected' : ""}>Tăng dần</option>
                                    <option value="DESC" ${applicationByIndustryOrder == 'DESC' ? 'selected' : ""}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="applicationByIndustryChart" height="150"></canvas>
                        </div>
                    </div>

                    <!-- Job Posts by Month -->
                    <div class="col-md-4">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title">
                                    <i class="fas fa-calendar-alt me-2 text-warning"></i> Bài đăng theo tháng
                                </h6>
                                <select name="jobPostMonthOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${jobPostMonthOrder == null || jobPostMonthOrder == "" ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${jobPostMonthOrder == 'ASC' ? 'selected' : ""}>Tăng dần</option>
                                    <option value="DESC" ${jobPostMonthOrder == 'DESC' ? 'selected' : ""}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="jobsByMonthChart" height="150"></canvas>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Top Job Posts -->
            <div class="row g-4">
                <div class="col-md-8">
                    <div class="top-list">
                        <h6 class="mb-3">
                            <i class="fas fa-fire me-2 text-danger"></i>
                            Top 5 bài đăng có nhiều đơn nhất
                        </h6>
                        <c:forEach var="top" items="${top5JobPosts}">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div>
                                        <i class="fas fa-code me-2 text-primary"></i>
                                        <strong>${top.getName()}</strong>
                                    </div>
                                    <span class="badge bg-primary rounded-pill">${top.getTotal()} đơn</span>
                                </li>
                            </ul>
                        </c:forEach>
                    </div>
                </div>

                <!-- Job Statistics Summary -->
                <div class="col-md-4">
                    <div class="top-list">
                        <h6 class="mb-3">
                            <i class="fas fa-chart-pie me-2 text-info"></i>
                            Tóm tắt thống kê
                        </h6>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tỷ lệ duyệt:</span>
                            <strong class="text-success"><fmt:formatNumber value="${approvalRate}" type="number" maxFractionDigits="1" />%</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Đơn TB/bài đăng:</span>
                            <strong class="text-info"><fmt:formatNumber value="${avgAppPerPost}" type="number" maxFractionDigits="1" /></strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Bài đăng mới/ngày:</span>
                            <strong class="text-primary"><fmt:formatNumber value="${avgJobPerDay}" type="number" maxFractionDigits="1" /></strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Ngành hot nhất:</span>
                            <strong class="text-warning">${hottestIndustry}</strong>
                        </div>
                        <hr>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                    // Jobs by Industry Chart
                                    const jobIndustryLabels = [<c:forEach items="${jobPostCountGrowth}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const jobIndustryValues = [<c:forEach items="${jobPostCountGrowth}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('jobByIndustryChart'), {
                                        type: 'bar',
                                        data: {
                                            labels: jobIndustryLabels,
                                            datasets: [{
                                                    label: 'Số bài đăng',
                                                    data: jobIndustryValues,
                                                    backgroundColor: '#0d6efd',
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
                                    // Job Status Chart
                                    const jobStatusLabels = [<c:forEach items="${jobPostStatusDistribution}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const jobStatusValues = [<c:forEach items="${jobPostStatusDistribution}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('jobStatusChart'), {
                                        type: 'pie',
                                        data: {
                                            labels: jobStatusLabels,
                                            datasets: [{
                                                    data: jobStatusValues,
                                                    backgroundColor: ['#198d54', '#ffc107', '#dc3545', '#0d6efd']
                                                }]
                                        },
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: {
                                                legend: {position: 'bottom'}
                                            }
                                        }
                                    });


                                    // Applications by Industry Chart
                                    const applicationIndustryLabels = [<c:forEach items="${applicationCountByIndustry}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const applicationIndustryValues = [<c:forEach items="${applicationCountByIndustry}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('applicationByIndustryChart'), {
                                        type: 'line',
                                        data: {
                                            labels: applicationIndustryLabels,
                                            datasets: [{
                                                    label: 'Số đơn ứng tuyển',
                                                    data: applicationIndustryValues,
                                                    borderColor: '#0dcaf0',
                                                    backgroundColor: 'rgba(13, 202, 240, 0.1)',
                                                    borderWidth: 2,
                                                    fill: true,
                                                    tension: 0.4
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


                                    // Jobs by Month Chart
                                    const jobsByMonthLabels = [<c:forEach items="${jobPostCountByMonth}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const jobsByMonthValues = [<c:forEach items="${jobPostCountByMonth}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('jobsByMonthChart'), {
                                        type: 'bar',
                                        data: {
                                            labels: jobsByMonthLabels,
                                            datasets: [{
                                                    label: 'Bài đăng',
                                                    data: jobsByMonthValues,
                                                    backgroundColor: '#ffc107',
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
                                                y: {beginAtZero: true}
                                            }
                                        }
                                    });

                                    function resetFilter() {
                                        document.getElementById('fromDate').value = '2024-01-01';
                                        document.getElementById('toDate').value = '2024-12-31';
                                        alert('Đã reset bộ lọc về mặc định!');
                                    }

        </script>
    </body>
</html>
