<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Công việc được quảng bá</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #0d6efd;
                --secondary-color: #6c757d;
                --success-color: #198754;
                --info-color: #0dcaf0;
                --warning-color: #ffc107;
                --danger-color: #dc3545;
                --light-color: #f8f9fa;
                --dark-color: #212529;
            }

            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
            }

            .hero-section {
                background: linear-gradient(135deg, #9CECFB 0%, #0052D4 100%);
                color: white;
                padding: 4rem 0;
            }

            .search-container {
                background: white;
                border-radius: 12px;
                padding: 2rem;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                margin-top: -2rem;
                position: relative;
                z-index: 10;
            }

            .job-card {
                transition: all 0.3s ease;
                border: none;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                margin-bottom: 1.5rem;
            }

            .job-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            }

            .company-logo {
                width: 50px;
                height: 50px;
                border-radius: 8px;
                object-fit: cover;
            }

            .skill-badge {
                font-size: 0.75rem;
                padding: 0.25rem 0.5rem;
                margin: 0.125rem;
            }

            .filter-section {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
                padding: 1.5rem;
                height: fit-content;
                position: sticky;
                top: 2rem;
            }

            .salary-range {
                width: 100%;
            }

            .results-header {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            }

            .btn-bookmark {
                border: none;
                background: none;
                color: #6c757d;
                font-size: 1.2rem;
            }

            .btn-bookmark:hover {
                color: #ffc107;
            }

            .btn-bookmark.active {
                color: #ffc107;
            }

            .remote-badge {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            .pagination-container {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                margin-top: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            }

            @media (max-width: 768px) {
                .filter-section {
                    position: static;
                    margin-bottom: 2rem;
                }

                .hero-section {
                    padding: 2rem 0;
                }

                .search-container {
                    margin-top: -1rem;
                    padding: 1.5rem;
                }
            }

            .form-check-input:checked {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-outline-primary:hover {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
            <div class="container">
                <a class="navbar-brand text-primary" href="#">JobPortal</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Jobs</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Companies</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Salary</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Resources</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container text-center">
                <h1 class="display-4 fw-bold mb-3">Công việc được quảng bá</h1>
                <p class="lead mb-4">Những công việc được quảng bá bởi các nhà tuyển dụng uy tín</p>
            </div>
        </section>
        <form method="get" action="ViewPromotionJobs" id="AdvancedJobSearch">
            <!-- Search Container -->
            <div class="container">
                <div class="search-container">
                    <div class="row g-3">
                        <div class="col-md-10">
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" class="form-control form-control-lg" placeholder="Bạn muốn tìm việc gì?" name="searchQuery" value="${param.searchQuery}">
                            </div>
                        </div>

                        <div class="col-md-2">
                            <button class="btn btn-primary btn-lg w-100" onclick="searchJobs()">
                                <i class="fas fa-search me-2"></i>Search
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="container mt-5">
                <div class="row">
                    <!-- Filters Sidebar -->
                    <div class="col-lg-3">
                        <div class="filter-section">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0 fw-bold">Bộ Lọc</h5>
                                <button class="btn btn-outline-secondary btn-sm d-lg-none" type="button" data-bs-toggle="collapse" data-bs-target="#filtersCollapse">
                                    <i class="fas fa-filter"></i>
                                </button>
                            </div>

                            <div class="collapse d-lg-block" id="filtersCollapse">
                                <!-- Job Type -->
                                <div class="mb-4">
                                    <h6 class="fw-semibold mb-3">Loại việc</h6>
                                    <c:forEach var="item" items="${filterJobTypeList}">
                                        <div class="form-check">
                                            <input class="form-check-input" name="jobType" type="checkbox" value="${item.jobType}"
                                                   id="${item.jobType}" <c:if test="${param.jobType == item.jobType}">checked</c:if> />
                                            <label class="form-check-label">${item.jobType}</label>
                                        </div>
                                    </c:forEach>
                                </div>

                                <hr>

                                <div class="mb-4">
                                    <h6 class="fw-semibold mb-3">Địa điểm</h6>
                                    <select name="location" class="form-select" style="width: auto;">

                                        <option value="" ${empty param.location ? 'selected' : ''}>Tất cả địa điểm</option>

                                        <c:forEach var="item" items="${location}">
                                            <option value="${item.location}" ${param.location == item.location ? 'selected' : ''}>${item.location}</option>
                                        </c:forEach>
                                    </select>
                                </div>


                                <hr>

                                <div class="mb-4">
                                    <h6 class="fw-semibold mb-3">Kinh nghiệm làm việc</h6>
                                    <c:forEach var="item" items="${filterJobExpList}">
                                        <div class="form-check">
                                            <input class="form-check-input" name="expLevel" type="checkbox" value="${item.experienceLevel}"
                                                   id="${item.experienceLevel}" <c:if test="${param.expLevel == item.experienceLevel}">checked</c:if> />
                                            <label class="form-check-label">${item.experienceLevel}</label>
                                        </div>
                                    </c:forEach>
                                </div>

                                <hr>


                                <div class="mb-4">
                                    <h6 class="fw-semibold mb-3">Lĩnh vực</h6>
                                    <c:forEach var="item" items="${industry}">
                                        <div class="form-check">
                                            <input class="form-check-input" name="industryId" type="checkbox" value="${item.industryId}"
                                                   id="${item.industryId}" <c:if test="${param.industryId == item.industryId}">checked</c:if> />
                                            <label class="form-check-label">${item.nameIndustry}</label>
                                        </div>
                                    </c:forEach>
                                </div>

                                <hr>

                                <!-- Salary Range -->
                                <div class="mb-4">
                                    <h6 class="fw-semibold mb-3">Mức lương</h6>

                                    <div class="input-group">
                                        <input type="text" name="salaryMin" class="form-control form-control-sm" placeholder="Tối thiểu" >
                                        <input type="text" name="salaryMax" class="form-control form-control-sm" placeholder="Tối đa">
                                    </div>

                                </div>
                                <p class="text-danger">${err}</p>
                                <div class="row">
                                    <div class="col-6">
                                        <a href="/Recruitment/ViewPromotionerJobs" class="btn btn-outline-primary btn-mg w-100 me-2">
                                            Xóa bộ lọc
                                        </a>
                                    </div>
                                    <div class="col-6">
                                        <button class="btn btn-primary btn-mg w-100 me-2" type="submit">Xác nhận</button>
                                    </div>
                                </div>



                            </div>
                        </div>
                    </div>

                    <!-- Job Listings -->
                    <div class="col-lg-9">
                        <!-- Results Header -->
                        <div class="results-header">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <h6 class="mb-0 me-3">Tìm kiếm theo</h6>

                                </div>
                                <select name="sort" class="form-select" style="width: auto;" onchange="document.getElementById('AdvancedJobSearch').submit()">
                                    <option value="" >Mặc định</option>
                                    <option value="lastest" ${param.sort == 'lastest' ? 'selected' : ''}>Gần đây</option>
                                    <option value="salaryDesc" ${param.sort == 'salaryDesc' ? 'selected' : ''}>Lương: Cao đến thấp</option>
                                    <option value="salaryAsc" ${param.sort == 'salaryAsc' ? 'selected' : ''}>Lương: Thấp đến cao</option>
                                </select>
                            </div>
                        </div>

                        <!-- Job Cards -->
                        <div id="jobListings">
                            <c:forEach var="item" items="${jobList}">
                                <div class="card job-card mb-4">
                                    <div class="card-body p-4">
                                        <div class="d-flex">
                                            <img src="${item.companyLogoUrl}" alt="Company Logo" class="company-logo me-3" style="height:50px;width:50px;object-fit:cover;">
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <h5 class="card-title mb-1">
                                                            <a href="job-detail?id=${item.jobPost.jobId}" class="text-decoration-none">
                                                                ${item.jobPost.title}
                                                            </a>
                                                        </h5>
                                                        <h6 class="text-muted mb-2">${item.companyName}</h6>
                                                    </div>
                                                    <button class="btn-bookmark" onclick="toggleBookmark(this)">
                                                        <i class="far fa-bookmark"></i>
                                                    </button>
                                                </div>

                                                <div class="d-flex flex-wrap align-items-center mb-3 text-muted small">
                                                    <span class="me-3">
                                                        <i class="fas fa-map-marker-alt me-1"></i>${item.jobPost.location}
                                                    </span>
                                                    <span class="badge remote-badge me-3">
                                                        ${item.jobPost.jobType}
                                                    </span>
                                                    <span class="badge remote-badge me-3">
                                                        ${item.jobPost.experienceLevel}
                                                    </span>
                                                    <span class="me-3">
                                                        <i class="fas fa-dollar-sign me-1"></i>
                                                        <fmt:formatNumber value="${item.jobPost.salaryMin}" type="number" groupingUsed="true" /> ₫ - 
                                                        <fmt:formatNumber value="${item.jobPost.salaryMax}" type="number" groupingUsed="true" /> ₫
                                                    </span>



                                                </div>

                                                <p class="card-text text-muted mb-3">
                                                    <c:choose>
                                                        <c:when test="${fn:length(item.jobPost.description) > 30}">
                                                            ${fn:substring(item.jobPost.description, 0, 30)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${item.jobPost.description}
                                                        </c:otherwise>
                                                    </c:choose>

                                                </p>
                                                <div class="d-flex justify-content-end">
                                                    <a href="CandidateJobDetail?jobID=${item.jobPost.jobId}" id="jobId" class="btn btn-outline-primary w-20 me-1">Chi tiết</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>


                        <!-- Pagination -->
                        <div class="pagination-container mt-4">
                            <nav aria-label="Job search pagination">
                                <ul class="pagination justify-content-center mb-0">

                                    <!-- Previous -->
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage - 1}">Trang trước</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${currentPage == 1}">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Trang trước</a>
                                        </li>
                                    </c:if>

                                    <!-- Page numbers -->
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Next -->
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}">Trang sau</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${currentPage == totalPages}">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Trang sau</a>
                                        </li>
                                    </c:if>

                                </ul>
                            </nav>
                        </div>

                    </div>
                </div>
            </div>
        </form>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>

                                                        // Toggle bookmark
                                                        function toggleBookmark(button) {
                                                            const icon = button.querySelector('i');
                                                            if (icon.classList.contains('far')) {
                                                                icon.classList.remove('far');
                                                                icon.classList.add('fas');
                                                                button.classList.add('active');
                                                            } else {
                                                                icon.classList.remove('fas');
                                                                icon.classList.add('far');
                                                                button.classList.remove('active');
                                                            }
                                                        }

                                                        const input = document.getElementById('locationQuery');
                                                        const suggestions = document.getElementById('suggestions');
                                                        let provinces = [];

                                                        // Gọi API lấy danh sách tỉnh thành
                                                        fetch('https://provinces.open-api.vn/api/?depth=1')
                                                                .then(res => res.json())
                                                                .then(data => provinces = data);

                                                        // Xử lý gợi ý khi người dùng nhập
                                                        input.addEventListener('input', () => {
                                                            const query = input.value.trim().toLowerCase();
                                                            suggestions.innerHTML = '';

                                                            if (query.length === 0)
                                                                return;

                                                            const matched = provinces.filter(p => p.name.toLowerCase().includes(query));

                                                            matched.forEach(p => {
                                                                const li = document.createElement('li');
                                                                li.className = 'list-group-item list-group-item-action';
                                                                li.textContent = p.name;
                                                                li.onclick = () => {
                                                                    input.value = p.name;
                                                                    suggestions.innerHTML = '';
                                                                };
                                                                suggestions.appendChild(li);
                                                            });
                                                        });

                                                        // Click ra ngoài để ẩn
                                                        document.addEventListener('click', (e) => {
                                                            if (!document.getElementById('locationQuery').contains(e.target)) {
                                                                suggestions.innerHTML = '';
                                                            }
                                                        });


                                                        // Add enter key support for search
                                                        document.getElementById('searchQuery').addEventListener('keypress', function (e) {
                                                            if (e.key === 'Enter') {
                                                                searchJobs();
                                                            }
                                                        });

        </script>
    </body>
</html>
