<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Job Posts</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            .btn-edit {
                background-color: #0d6efd;
                color: white;
            }
            .btn-delete {
                background-color: #dc3545;
                color: white;
            }
            .btn-edit:hover, .btn-delete:hover {
                opacity: 0.85;
            }
            .pagination .page-link {
                border-radius: 0.3rem !important; /* Bo tròn */
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1); /* Bóng nhẹ */
                transition: 0.3s ease;
            }

            .pagination .page-link:hover {
                background-color: #0d6efd;
                color: white;
            }

            .pagination .active .page-link {
                background-color: #0d6efd;
                border-color: #0d6efd;
                color: white;
            }

            .pagination .page-link:disabled {
                opacity: 0.5;
                pointer-events: none;
            }
        </style>
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>

        <!-- Phần nội dung sẽ được đẩy sang phải bằng margin-left -->
        <div style="margin-left: 280px; padding: 25px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Quản lí bài đăng</h2>
                <!--                <a href="#" class="btn btn-primary">Create Job Post</a>-->
            </div>
            <form action="ManageJobPostAdmin" method="post" class="row g-3 align-items-end mb-4">
                <div class="col-md-4">
                    <label class="form-label" style="text-align: center;">Tìm kiếm</label>
                    <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm kiếm theo tiêu đề hoặc tên công ty">
                </div>
                <!-- Lọc theo trạng thái -->
                <div class="col-md-2" style="width: 10%;">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="">Tất cả</option>
                        <option value="Pending" ${status == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Active" ${status == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Rejected" ${status == 'Rejected' ? 'selected' : ''}>Rejected</option>
                        <option value="Expired" ${status == 'Expired' ? 'selected' : ''}>Expired</option>
                        <option value="Hidden" ${status == 'Hidden' ? 'selected' : ''}>Hidden</option>
                    </select>
                </div>

                <!-- Lọc theo ngày đăng: Từ ngày - Đến ngày -->
                <div class="col-md-2">
                    <label class="form-label">Từ ngày</label>
                    <input type="date" name="fromDate" class="form-control" value="${fromDate}">
                </div>
                <div class="col-md-2">
                    <label class="form-label">Đến ngày</label>
                    <input type="date" name="toDate" class="form-control" value="${toDate}">
                </div>
                <!-- Sắp xếp -->
                <div class="col-md-2">
                    <label class="form-label">Sắp xếp</label>
                    <select name="sort" class="form-select">
                        <option value="">-- Mặc định --</option>
                        <option value="created_at_desc" ${sort == 'created_at_desc' ? 'selected' : ''}>Ngày đăng mới nhất</option>
                        <option value="created_at_asc" ${sort == 'created_at_asc' ? 'selected' : ''}>Ngày đăng cũ nhất</option>
                        <option value="title_asc" ${sort == 'title_asc' ? 'selected' : ''}>Tiêu đề (A-Z)</option>
                        <option value="title_desc" ${sort == 'title_desc' ? 'selected' : ''}>Tiêu đề (Z-A)</option>
                    </select>
                </div>
                <!-- Nút lọc -->
                <div class="col-md-1" style="width: 6%;">
                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                </div>
            </form>
            <!-- Lọc nâng cao -->
            <div class="col-md-2">
                <a href="FilterAdvancedAdmin" class="btn btn-outline-secondary w-100">
                    Lọc nâng cao
                </a>
            </div>
            <!----------------------Hien thi them trang dong------------------------------------->
            <%--
            <form action="ManageJobPostAdmin" method="post">
                <label for="percent">Hiển thị:</label>
                <select name="percent" id="percent" onchange="this.form.submit()">
                    <option value="20" ${percent == 20 ? 'selected' : ''}>20%</option>
                    <option value="30" ${percent == 30 ? 'selected' : ''}>30%</option>
                    <option value="50" ${percent == 50 ? 'selected' : ''}>50%</option>
                    <option value="100" ${percent == 100 ? 'selected' : ''}>100%</option>
                </select>
            </form>
            --%>
            <!---------------------------------------------------------------->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="message" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorJobPost}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.errorJobPost}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorJobPost" scope="session" />
            </c:if>
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th style="width: 25%;">Tiêu đề</th>
                        <th>Công ty</th>
                        <th>Email</th>
                        <th>Trạng thái</th>
                        <th>Ngày đăng</th>
                        <th>Hết hạn</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${manageJobPost}">
                        <tr>
                            <td>${a.getJobId()}</td>
                            <td>${a.getTitle()}</td>
                            <td>${a.getRecruiter().getCompanyName()}</td>
                            <td>${a.getRecruiter().getEmail()}</td>

                            <td>
                                <form action="ManageJobPostAdmin" method="POST">
                                    <input type="hidden" name="jobId" value="${a.getJobId()}" />
                                    <input type="hidden" name="action" value="updateStatus" />

                                    <input type="hidden" name="keyword" value="${keyword}">
                                    <input type="hidden" name="status" value="${status}">
                                    <input type="hidden" name="fromDate" value="${fromDate}">
                                    <input type="hidden" name="toDate" value="${toDate}">
                                    <input type="hidden" name="sort" value="${sort}">

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



                            <td>${a.dateCreatAt()}</td>
                            <td>${a.dateDaealine()}</td>
                            <td>
                                <form action="EditAdminJobPost" method="get">
                                    <input type="hidden" name="jobId" value="${a.getJobId()}" />
                                    <input type="hidden" name="editJob" value="normal" />
                                    <button type="submit" class="btn btn-sm btn-primary">Sửa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
            <form action="ManageJobPostAdmin" method="post">
                <!-- Ẩn các tham số lọc nếu có -->
                <input type="hidden" name="keyword" value="${keyword}">
                <input type="hidden" name="status" value="${status}">
                <input type="hidden" name="fromDate" value="${fromDate}">
                <input type="hidden" name="toDate" value="${toDate}">
                <input type="hidden" name="sort" value="${sort}">
                <!------------------------------------------------------>
                <%--
                <input type="hidden" name="percent" value="${percent}">
                --%>
                <!------------------------------------------------------>
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
