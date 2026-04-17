<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Job Posts</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <style>
            body {
                background-color: #f9f9f9;
                font-family: 'Segoe UI', sans-serif;
            }
            .container {
                margin-top: 30px;
                background-color: #fff;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }
            .card {
                padding-top: 10px;
                margin-top: -15px;
                border: none;
                border-radius: 12px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
                transition: all 0.3s ease;
            }
            .job-meta {
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: 0.75rem;
                font-size: 0.75rem;
                color: var(--gray);
            }

            .job-meta i {
                margin-right: 0.25rem;
            }
        </style>
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>
        <div style="margin-left: 280px; padding: 25px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Quản lí bài đăng - Lọc nâng cao</h2>
            </div>
            <div class="container-fluid mb-3 card">
                <div class="card-body">
                    <form action="FilterAdvancedAdmin" method="post">
                        <div class="row g-3 align-items-end">
                            <div class="row">
                                <!-- Search -->
                                <div class="col-md-6">
                                    <label class="form-label">Tìm kiếm</label>
                                    <div class="input-group">
                                        <button class="input-group-text"><i class="bi bi-search"></i></button>
                                        <input type="text" name="search" value="${search}" class="form-control" placeholder="Tìm kiếm tên công việc...">
                                    </div>
                                </div>
                                <!-- Vị trí -->
                                <div class="col-md-2">
                                    <label class="form-label">Vị trí</label>
                                    <select class="form-select" name="position">
                                        <option value="">Tất cả vị trí</option>
                                        <c:forEach var="a" items="${listPositionJobPost}">
                                            <option value="${a.getLocation()}"
                                                    <c:if test="${position == a.getLocation()}">selected</c:if>
                                                    >${a.getLocation()}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Địa điểm -->
                                <div class="col-md-2">
                                    <label class="form-label">Địa điểm</label>
                                    <div class="d-flex flex-wrap gap-2">
                                        <select class="form-select" name="location">
                                            <option value="">Tất cả địa điểm</option>
                                            <c:forEach var="a" items="${listLocationJobPost}">
                                                <option value="${a.getLocation()}"
                                                        <c:if test="${location == a.getLocation()}">selected</c:if>
                                                        >${a.getLocation()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <!-- Sắp xếp -->
                                <div class="col-md-2">
                                    <label class="form-label">Sắp xếp</label>
                                    <select class="form-select" name="sort">
                                        <option value="">Mặc định</option>
                                        <option value="date_asc" <c:if test="${sort == 'date_asc'}">selected</c:if>>Ngày ↑</option>
                                        <option value="date_desc" <c:if test="${sort == 'date_desc'}">selected</c:if> >Ngày ↓</option>
                                        <option value="salary_asc" <c:if test="${sort == 'salary_asc'}">selected</c:if> >Lương ↑</option>
                                        <option value="salary_desc" <c:if test="${sort == 'salary_desc'}">selected</c:if> >Lương ↓</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row" style="margin-top: 15px;">
                                    <!-- Lĩnh vực -->
                                    <div class="col-md-6">
                                        <label class="form-label">Lĩnh vực</label>
                                        <div class="row">
                                        <c:set var="half" value="${fn:length(listIndustries) / 2}" />

                                        <!-- Cột bên trái -->
                                        <div class="col-md-6">
                                            <c:forEach var="a" items="${listIndustries}" varStatus="loop">
                                                <c:if test="${loop.index < half}">
                                                    <c:set var="isChecked" value="false" />
                                                    <c:forEach var="id" items="${selectedIndustries}">
                                                        <c:if test="${id == a.getIndustryId()}"><c:set var="isChecked" value="true" /></c:if>
                                                    </c:forEach>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="industry" value="${a.getIndustryId()}"
                                                               <c:if test="${isChecked}">checked</c:if>
                                                               id="industry${loop.index}">
                                                        <label class="form-check-label" for="industry${loop.index}">${a.getNameIndustry()}</label>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>

                                        <!-- Cột bên phải -->
                                        <div class="col-md-6">
                                            <c:forEach var="a" items="${listIndustries}" varStatus="loop">
                                                <c:if test="${loop.index >= half}">
                                                    <c:set var="isChecked" value="false" />
                                                    <c:forEach var="id" items="${selectedIndustries}">
                                                        <c:if test="${id == a.getIndustryId()}"><c:set var="isChecked" value="true" /></c:if>
                                                    </c:forEach>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="industry" value="${a.getIndustryId()}"
                                                               <c:if test="${isChecked}">checked</c:if>
                                                               id="industry${loop.index}">
                                                        <label class="form-check-label" for="industry${loop.index}">${a.getNameIndustry()}</label>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>

                                <!-- Loại công việc -->
                                <div class="col-md-2">
                                    <label class="form-label">Loại công việc</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="jobType" value="Toàn thời gian" <c:if test="${fn:contains(selectedJobTypes, 'Toàn thời gian')}">checked</c:if> id="jobType1">
                                            <label class="form-check-label" for="jobType1">Toàn thời gian</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="jobType" value="Bán thời gian" <c:if test="${fn:contains(selectedJobTypes, 'Bán thời gian')}">checked</c:if> id="jobType2">
                                            <label class="form-check-label" for="jobType2">Bán thời gian</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="jobType" value="Hợp đồng" <c:if test="${fn:contains(selectedJobTypes, 'Hợp đồng')}">checked</c:if> id="jobType3">
                                            <label class="form-check-label" for="jobType3">Hợp đồng</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="jobType" value="Tự do" <c:if test="${fn:contains(selectedJobTypes, 'Tự do')}">checked</c:if> id="jobType4">
                                            <label class="form-check-label" for="jobType4">Tự do</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="jobType" value="Thực tập" <c:if test="${fn:contains(selectedJobTypes, 'Thực tập')}">checked</c:if> id="jobType5">
                                            <label class="form-check-label" for="jobType5">Thực tập</label>
                                        </div>
                                    </div>

                                    <!-- Kinh nghiệm -->
                                    <div class="col-md-2">
                                        <label class="form-label">Kinh nghiệm</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="experienceLevel" value="Mới vào nghề (0-1 năm)" <c:if test="${fn:contains(selectedExperienceLevels, 'Mới vào nghề (0-1 năm)')}">checked</c:if> id="exp1">
                                            <label class="form-check-label" for="exp1">Mới vào nghề</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="experienceLevel" value="Nhân viên sơ cấp (1-3 năm)" <c:if test="${fn:contains(selectedExperienceLevels, 'Nhân viên sơ cấp (1-3 năm)')}">checked</c:if> id="exp2">
                                            <label class="form-check-label" for="exp2">Nhân viên sơ cấp</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="experienceLevel" value="Trung cấp (3-5 năm)" <c:if test="${fn:contains(selectedExperienceLevels, 'Trung cấp (3-5 năm)')}">checked</c:if> id="exp3">
                                            <label class="form-check-label" for="exp3">Trung cấp</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="experienceLevel" value="Cao cấp (trên 5 năm)" <c:if test="${fn:contains(selectedExperienceLevels, 'Cao cấp (trên 5 năm)')}">checked</c:if> id="exp4">
                                            <label class="form-check-label" for="exp4">Cao cấp</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="experienceLevel" value="Quản lý" <c:if test="${fn:contains(selectedExperienceLevels, 'Quản lý')}">checked</c:if> id="exp5">
                                            <label class="form-check-label" for="exp5">Quản lý</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="experienceLevel" value="Điều hành" <c:if test="${fn:contains(selectedExperienceLevels, 'Điều hành')}">checked</c:if> id="exp6">
                                            <label class="form-check-label" for="exp6">Điều hành</label>
                                        </div>
                                    </div>

                                    <!-- Trạng thái -->
                                    <div class="col-md-2">
                                        <label class="form-label">Trạng thái</label>
                                    <c:forEach var="a" items="${listStatusJobPost}" varStatus="loop">
                                        <c:set var="isChecked" value="false" />
                                        <c:forEach var="id" items="${selectedStatuses}">
                                            <c:if test="${id == a.getLocation()}">
                                                <c:set var="isChecked" value="true" />
                                            </c:if>
                                        </c:forEach>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="status" value="${a.getLocation()}"
                                                   <c:if test="${isChecked}">checked</c:if>
                                                   id="status${loop.index}">
                                            <label class="form-check-label" for="status${loop.index}">${a.getLocation()}</label>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <!-- Nút lọc -->
                            <div class="col-md-2 text-end">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bi bi-filter"></i> Lọc tất cả
                                </button>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="message" scope="session" />
            </c:if>                               
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th style="width: 25%;">Tiêu đề</th>
                        <th>Lĩnh vực</th>
                        <th>Vị trí</th>
                        <th>Địa điểm</th>
                        <th>Kinh nghiệm</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${listJobPostAdmin}">
                        <tr>
                            <td>${a.getJobId()}</td>
                            <td>                                                    <div>
                                    <div class="job-title d-flex align-items-center">
                                        ${a.getTitle()}
                                    </div>
                                    <div class="job-meta">
                                        <span><i class="bi bi-clock"></i> ${a.getJobType()}</span>
                                        <span><i class="bi bi-currency-dollar"></i> ${a.getFormattedSalaryMin()}-${a.getFormattedSalaryMax()} đ</span>
                                    </div>
                                </div>
                            </td>
                            <td style="width: 13%;">${a.getIndustry().getNameIndustry()}</td>
                            <td>${a.getJobPosition()}</td>
                            <td>${a.getLocation()}</td>
                            <td>${a.getExperienceLevel()}</td>
                            <td>
                                <form action="FilterAdvancedAdmin" method="POST">
                                    <input type="hidden" name="jobId" value="${a.getJobId()}" />
                                    <input type="hidden" name="action" value="updateStatus" />

                                    <input type="hidden" name="search" value="${search}">
                                    <input type="hidden" name="position" value="${position}">
                                    <input type="hidden" name="location" value="${location}">
                                    <input type="hidden" name="sort" value="${sort}">

                                    <c:forEach var="stat" items="${selectedStatuses}">
                                        <input type="hidden" name="status" value="${stat}" />
                                    </c:forEach>

                                    <c:forEach var="jobType" items="${selectedJobTypes}">
                                        <input type="hidden" name="jobType" value="${jobType}" />
                                    </c:forEach>

                                    <c:forEach var="exp" items="${selectedExperienceLevels}">
                                        <input type="hidden" name="experienceLevel" value="${exp}" />
                                    </c:forEach>

                                    <c:forEach var="ind" items="${selectedIndustries}">
                                        <input type="hidden" name="industry" value="${ind}" />
                                    </c:forEach>

                                    <input type="hidden" name="page" value="${page}">
                                    <select name="statusUpdate"
                                            class="form-select form-select-sm"
                                            style="
                                            background-color: ${
                                            a.getStatus() == 'Pending' ? 'khaki' :
                                                a.getStatus() == 'Active' ? 'lightgreen' :
                                                a.getStatus() == 'Rejected' ? '#f08080' :
                                                a.getStatus() == 'Expired' ? '#d3d3d3' :
                                                a.getStatus() == 'Hidden' ? '#808080' : 'white'
                                            };
                                            color: black;
                                            font-weight: 500;"
                                            border-radius: 6px;
                                            onchange="this.form.submit()">
                                        <option value="Pending" ${a.getStatus() == 'Pending' ? 'selected' : ''}>Pending</option>
                                        <option value="Active" ${a.getStatus() == 'Active' ? 'selected' : ''}>Active</option>
                                        <option value="Rejected" ${a.getStatus() == 'Rejected' ? 'selected' : ''}>Rejected</option>
                                        <option value="Expired" ${a.getStatus() == 'Expired' ? 'selected' : ''}>Expired</option>
                                        <option value="Hidden" ${a.status == 'Hidden' ? 'selected' : ''}>Hidden</option>
                                    </select>
                                </form>
                            </td>
                            <td>
                                <form action="EditAdminJobPost" method="get">
                                    <input type="hidden" name="jobId" value="${a.getJobId()}" />
                                    <input type="hidden" name="editJob" value="advanced" />
                                    <button type="submit" class="btn btn-sm btn-primary">Sửa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
            <%--                                       
                   <div style="border:1px solid red; padding: 10px; margin: 10px; color: red;">
                       <h4>Debug thông tin lọc</h4>
                       <p>Search: ${search}</p>
                       <p>Position: ${position}</p>
                       <p>Location: ${location}</p>
                       <p>Sort: ${sort}</p>

                <p>Statuses:
                    <c:forEach var="stat" items="${selectedStatuses}">${stat}, </c:forEach>
                    </p>
                    <p>Job Types:
                    <c:forEach var="jt" items="${selectedJobTypes}">${jt}, </c:forEach>
                    </p>
                    <p>Experience Levels:
                    <c:forEach var="exp" items="${selectedExperienceLevels}">${exp}, </c:forEach>
                    </p>
                    <p>Industries:
                    <c:forEach var="ind" items="${selectedIndustries}">${ind}, </c:forEach>
                    </p>
                </div>
            --%>
            <form action="FilterAdvancedAdmin" method="post">
                <!-- Ẩn các tham số lọc nếu có -->
                <input type="hidden" name="search" value="${search}">
                <input type="hidden" name="position" value="${position}">
                <input type="hidden" name="location" value="${location}">
                <input type="hidden" name="sort" value="${sort}">

                <c:forEach var="stat" items="${selectedStatuses}">
                    <input type="hidden" name="status" value="${stat}" />
                </c:forEach>

                <c:forEach var="jobType" items="${selectedJobTypes}">
                    <input type="hidden" name="jobType" value="${jobType}" />
                </c:forEach>

                <c:forEach var="exp" items="${selectedExperienceLevels}">
                    <input type="hidden" name="experienceLevel" value="${exp}" />
                </c:forEach>

                <c:forEach var="ind" items="${selectedIndustries}">
                    <input type="hidden" name="industry" value="${ind}" />
                </c:forEach>

                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <!-- Previous page -->
                        <li class="page-item ${page == 1 ? 'disabled' : ''}">
                            <button type="submit" name="page" value="${page - 1}" class="page-link" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </button>
                        </li>

                        <!-- Page numbers -->
                        <c:forEach var="i" begin="1" end="${num}">
                            <li class="page-item ${i == page ? 'active' : ''}">
                                <button type="submit" name="page" value="${i}" class="page-link">${i}</button>
                            </li>
                        </c:forEach>

                        <!-- Next page -->
                        <li class="page-item ${page == num ? 'disabled' : ''}">
                            <button type="submit" name="page" value="${page + 1}" class="page-link" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </button>
                        </li>
                    </ul>
                </nav>
            </form>
        </div>
    </body>
</html>
