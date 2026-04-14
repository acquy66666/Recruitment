<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê Người dùng</title>
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
            .stats-card.info {
                border-left-color: #17a2b8;
            }
            .stats-card.danger {
                border-left-color: #dc3545;
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
            .stats-icon.info {
                background-color: #17a2b8;
            }
            .stats-icon.danger {
                background-color: #dc3545;
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
            #jobSeekerGrowthChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #recruiterGrowthChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #registrationChart {
                max-height: 400px;  /* hoặc height: 400px; */
            }
            #genderPieChart {
                max-height: 300px;  /* hoặc height: 400px; */
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
                    <i class="fas fa-users me-2"></i>
                    Thống kê Người dùng
                </h1>
                <p class="text-muted mb-0">Theo dõi và phân tích dữ liệu người dùng hệ thống</p>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-3 mb-4">
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card primary">
                        <div class="stats-icon primary">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <div class="stats-number text-primary">${totalCandidates}</div>
                        <div class="stats-label">Tổng Ứng viên</div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card success">
                        <div class="stats-icon success">
                            <i class="fas fa-building"></i>
                        </div>
                        <div class="stats-number text-success">${totalRecruiters}</div>
                        <div class="stats-label">Tổng Nhà tuyển dụng</div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card info">
                        <div class="stats-icon info">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <div class="stats-number text-info">${totalActive}</div>
                        <div class="stats-label">Tài khoản kích hoạt</div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stats-card danger">
                        <div class="stats-icon danger">
                            <i class="fas fa-user-times"></i>
                        </div>
                        <div class="stats-number text-danger">${totalInactive}</div>
                        <div class="stats-label">Tài khoản chưa kích hoạt</div>
                    </div>
                </div>
            </div>
            <c:if test="${not empty errorUserStatistic}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorUserStatistic}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorUserStatistic" scope="session" />
            </c:if>
            <!-- Search Filter -->
            <form action="UserStatistics" method="post">
                <div class="search-container">
                    <h6 class="mb-3"><i class="fas fa-filter me-2"></i>Bộ lọc thời gian</h6>
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="fromDate" class="form-label">Từ ngày</label>
                            <input type="date" name="fromDateUser" class="form-control" id="fromDate" value="${fromDateUser}">
                        </div>
                        <div class="col-md-4">
                            <label for="toDate" class="form-label">Đến ngày</label>
                            <input type="date" name="toDateUser" class="form-control" id="toDate" value="${toDateUser}">
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
                    <!-- Job Seeker Growth Chart -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title">
                                    <i class="fas fa-chart-line me-2 text-primary"></i>
                                    Tăng trưởng Ứng viên theo tháng
                                </h6>
                                <select name="jobSeekerOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${jobSeekerOrder == null || jobSeekerOrder == '' ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${jobSeekerOrder == 'ASC' ? "selected" : ""}>Tăng dần</option>
                                    <option value="DESC" ${jobSeekerOrder == 'DESC' ? "selected" : ""}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="jobSeekerGrowthChart" height="200"></canvas>
                        </div>
                    </div>

                    <!-- Recruiter Growth Chart -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title">
                                    <i class="fas fa-chart-line me-2 text-success"></i>
                                    Tăng trưởng Nhà tuyển dụng theo tháng
                                </h6>
                                <select name="recruiterOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${recruiterOrder == null || recruiterOrder == '' ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${recruiterOrder == 'ASC' ? "selected" : ""}>Tăng dần</option>
                                    <option value="DESC" ${recruiterOrder == 'DESC' ? "selected" : ""}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="recruiterGrowthChart" height="200"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Gender Distribution Chart -->
                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <div class="chart-container">
                            <h6 class="chart-title">
                                <i class="fas fa-chart-pie me-2 text-info"></i>
                                Phân bố giới tính người dùng
                            </h6>
                            <canvas id="genderPieChart"></canvas>
                        </div>
                    </div>

                    <!-- User Registration by Month -->
                    <div class="col-md-6">
                        <div class="chart-container">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="chart-title">
                                    <i class="fas fa-chart-bar me-2 text-warning"></i>
                                    Đăng ký mới theo tháng
                                </h6>
                                <select name="registrationOrder" class="form-select w-auto" onchange="this.form.submit()">
                                    <option value="" ${registrationOrder == null || registrationOrder == '' ? "selected" : ""}>Mặc định</option>
                                    <option value="ASC" ${registrationOrder == 'ASC' ? "selected" : ""}>Tăng dần</option>
                                    <option value="DESC" ${registrationOrder == 'DESC' ? "selected" : ""}>Giảm dần</option>
                                </select>
                            </div>
                            <canvas id="registrationChart"></canvas>
                        </div>
                    </div>
                </div>
            </form>             
            <!-- Top Activities -->
            <div class="row g-4">
                <!-- Top Job Seekers -->
                <div class="col-md-6">
                    <div class="top-list">
                        <h6 class="mb-3">
                            <i class="fas fa-trophy me-2 text-warning"></i>
                            Top 5 Ứng viên nộp đơn nhiều nhất
                        </h6>
                        <c:forEach var="top" items="${getTop5CandidatesByApplications}">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div>
                                        <i class="fas fa-user me-2 text-primary"></i>
                                        <strong>${top.getName()}</strong>
                                    </div>
                                    <span class="badge bg-primary rounded-pill">${top.getTotal()} đơn</span>
                                </li>
                            </ul>
                        </c:forEach>
                    </div>
                </div>

                <!-- Top Recruiters -->
                <div class="col-md-6">
                    <div class="top-list">
                        <h6 class="mb-3">
                            <i class="fas fa-building me-2 text-success"></i>
                            Top 5 Nhà tuyển dụng có nhiều bài đăng
                        </h6>
                        <c:forEach var="top" items="${getTop5RecruitersByJobPosts}">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div>
                                        <i class="fas fa-city me-2 text-success"></i>
                                        <strong>${top.getName()}</strong>
                                    </div>
                                    <span class="badge bg-success rounded-pill">${top.getTotal()} bài</span>
                                </li>
                            </ul>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                    // Job Seeker Growth Chart
                                    const jobSeekerLabels = [<c:forEach items="${jobSeekerGrowth}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const jobSeekerValues = [<c:forEach items="${jobSeekerGrowth}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('jobSeekerGrowthChart'), {
                                        type: 'line',
                                        data: {
                                            labels: jobSeekerLabels,
                                            datasets: [{
                                                    label: 'Ứng viên mới',
                                                    data: jobSeekerValues,
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
                                                legend: {display: true, position: 'top'}
                                            },
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });

                                    // Recruiter Growth Chart
                                    const recruiterLabels = [<c:forEach items="${recruiterGrowth}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const recruiterValues = [<c:forEach items="${recruiterGrowth}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('recruiterGrowthChart'), {
                                        type: 'line',
                                        data: {
                                            labels: recruiterLabels,
                                            datasets: [{
                                                    label: 'Nhà tuyển dụng mới',
                                                    data: recruiterValues,
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
                                                legend: {display: true, position: 'top'}
                                            },
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });

                                    // Gender Pie Chart
                                    const genderLabels = [<c:forEach items="${genderDistribution}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const genderValues = [<c:forEach items="${genderDistribution}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('genderPieChart'), {
                                        type: 'pie',
                                        data: {
                                            labels: genderLabels,
                                            datasets: [{
                                                    data: genderValues,
                                                    backgroundColor: ['#0d6efd', '#dc3545', '#6c757d'] // Nam, Nữ, Khác
                                                }]
                                        },
                                        options: {
                                            responsive: true,
                                            plugins: {
                                                legend: {
                                                    position: 'bottom'
                                                }
                                            }
                                        }
                                    });

                                    // Registration Chart
                                    const registrationLabels = [<c:forEach items="${registrationByMonth}" var="e" varStatus="i">
                                    "${e.key}"<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    const registrationValues = [<c:forEach items="${registrationByMonth}" var="e" varStatus="i">
                ${e.value}<c:if test="${!i.last}">,</c:if>
            </c:forEach>
                                    ];

                                    new Chart(document.getElementById('registrationChart'), {
                                        type: 'bar',
                                        data: {
                                            labels: registrationLabels,
                                            datasets: [{
                                                    label: 'Đăng ký mới',
                                                    data: registrationValues,
                                                    backgroundColor: '#ffc107',
                                                    borderColor: '#ffc107',
                                                    borderWidth: 1
                                                }]
                                        },
                                        options: {
                                            responsive: true,
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



                                    function resetFilter() {
                                        document.getElementById('fromDate').value = '2025-01-01';
                                        document.getElementById('toDate').value = '2025-12-31';
                                        alert('Đã reset bộ lọc về mặc định!');
                                    }

        </script>
    </body>
</html>
