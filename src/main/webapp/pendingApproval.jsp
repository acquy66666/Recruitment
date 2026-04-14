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
        </style>   
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>
        <div style="margin-left: 280px; padding: 25px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Danh sách tài khoản chờ phê duyệt</h2>
            </div>

            <form action="ManageAccountPending" method="post" class="row g-3 align-items-end mb-4">
                <div class="col-md-4">
                    <label class="form-label" style="text-align: center;">Tìm kiếm</label>
                    <input type="text" name="keywordAccount" value="${keywordAccount}" class="form-control" placeholder="Tìm kiếm theo họ tên hoặc tên công ty">
                </div>
                <!-- Lọc theo trạng thái -->
                <div class="col-md-2" style="width: 15%;">
                    <label class="form-label">Chức vụ</label>
                    <select name="positionAccount" class="form-select">
                        <option value="">Tất cả chức vụ</option>
                        <c:forEach var="p" items="${positionAccountList}">
                            <option value="${p}" ${p == positionAccount ? "selected" : ""}>${p}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Lọc theo ngày đăng: Từ ngày - Đến ngày -->
                <div class="col-md-2" style="width: 14%;">
                    <label class="form-label">Từ ngày</label>
                    <input type="date" name="fromDateAccount" class="form-control" value="${fromDateAccount}">
                </div>
                <div class="col-md-2" style="width: 14%;">
                    <label class="form-label">Đến ngày</label>
                    <input type="date" name="toDateAccount" class="form-control" value="${toDateAccount}">
                </div>
                <!-- Sắp xếp -->
                <div class="col-md-2">
                    <label class="form-label">Sắp xếp</label>
                    <select name="sortAccount" class="form-select">
                        <option value="">-- Mặc định --</option>
                        <option value="created_at_desc_account" ${sortAccount == 'created_at_desc_account' ? 'selected' : ''}>Ngày tạo mới nhất</option>
                        <option value="created_at_asc_account" ${sortAccount == 'created_at_asc_account' ? 'selected' : ''}>Ngày tạo cũ nhất</option>
                        <option value="title_asc_account" ${sortAccount == 'title_asc_account' ? 'selected' : ''}>Tên (A-Z)</option>
                        <option value="title_desc_account" ${sortAccount == 'title_desc_account' ? 'selected' : ''}>Tên (Z-A)</option>
                    </select>
                </div>
                <!-- Nút lọc -->
                <div class="col-md-1" style="width: 6%;">
                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                </div>
            </form>

            <c:if test="${not empty sessionScope.messageAccount}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.messageAccount}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="messageAccount" scope="session" />
            </c:if>  
            <c:if test="${not empty sessionScope.errorAccount}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.errorAccount}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorAccount" scope="session" />
            </c:if>
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th style="width: 15%;">Họ và tên</th>
                        <th>Chức vụ</th>
                        <th>Công ty</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Ngày tạo</th>
                        <th style="width: 15%;">Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${listAllRecruitersPending}">
                        <tr>
                            <td>${a.getRecruiterId()}</td>
                            <td>${a.getFullName()}</td>
                            <td>${a.getPosition()}</td>
                            <td>${a.getCompanyName()}</td>
                            <td>${a.getEmail()}</td>
                            <td>${a.getPhone()}</td>
                            <td>${a.dateCreateNow()}</td>
                            <td>
                                <form action="ManageAccountPending" method="post">
                                    <input type="hidden" name="recruiterId" value="${a.getRecruiterId()}" />
                                    <input type="hidden" name="recruiterName" value="${a.getFullName()}" />
                                    <input type="hidden" name="actionAccount" value="updateActive" />

                                    <input type="hidden" name="keywordAccount" value="${keywordAccount}" />
                                    <input type="hidden" name="positionAccount" value="${positionAccount}" />
                                    <input type="hidden" name="fromDateAccount" value="${fromDateAccount}" />
                                    <input type="hidden" name="toDateAccount" value="${toDateAccount}" />
                                    <input type="hidden" name="sortAccount" value="${sortAccount}" />
                                    <input type="hidden" name="page" value="${page}" />

                                    <select name="isActive"
                                            class="form-select"
                                            style="
                                            background-color: ${a.isActive ? 'lightgreen' : '#d3d3d3'};
                                            color: black;
                                            font-weight: 500;
                                            border-radius: 6px;
                                            "
                                            onchange="this.form.submit()">
                                        <option value="1" ${a.isActive ? "selected" : ""}>Đã kích hoạt</option>
                                        <option value="0" ${!a.isActive ? "selected" : ""}>Chưa kích hoạt</option>
                                    </select>
                                </form>

                            </td>
                            <td>
                                <form action="EditAdminAccountRecruiter" method="get">
                                    <input type="hidden" name="recruiterId" value="${a.getRecruiterId()}" />
                                    <button type="submit" class="btn btn-sm btn-primary">Sửa</button>
                                </form>
                            </td>
                            <td>
                                <%--
                                <form action="EditAdminJobPost" method="get">
                                    <input type="hidden" name="jobId" value="${a.getJobId()}" />
                                    <input type="hidden" name="editJob" value="normal" />
                                    <button type="submit" class="btn btn-sm btn-primary">Sửa</button>
                                </form>
                                --%>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>

            <form action="ManageAccountPending" method="post">
                <!-- Ẩn các tham số lọc nếu có -->
                <input type="hidden" name="keywordAccount" value="${keywordAccount}">
                <input type="hidden" name="positionAccount" value="${positionAccount}">
                <input type="hidden" name="fromDateAccount" value="${fromDateAccount}">
                <input type="hidden" name="toDateAccount" value="${toDateAccount}">
                <input type="hidden" name="sortAccount" value="${sortAccount}">

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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
