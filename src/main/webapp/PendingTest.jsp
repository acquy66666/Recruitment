<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                <h2>Bài thi chờ duyệt</h2>
                <!--                <a href="#" class="btn btn-primary">Create Job Post</a>-->
            </div>
            <form action="PendingTest" method="GET" class="row g-3 align-items-end mb-4">
                <div class="col-md-4">
                    <label class="form-label" style="text-align: center;">Tìm kiếm</label>
                    <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm kiếm theo tiêu đề hoặc tên công ty">
                </div>


                <!-- Nút lọc -->
                <div class="col-md-1" style="width: 6%;">
                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                </div>

            </form>
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
                        <th style="width: 25%;">Tiêu đề</th>
                        <th>Tên nhà tuyển dụng</th>
                        <th>Tên công ty</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${list}">
                        <tr>
                            <td>${item.title}</td>
                            <td>${item.fullName}</td>
                            <td>${item.companyName}</td>

                            <td>


                                <input hidden name="keyword" value="${keyword}">

                                <select name="statusUpdate"
                                        class="form-select form-select-sm"
                                        onchange="window.location.href =
                                                        'UpdateStatusServlet?testId=${item.testId}&recruiterId=${item.recruiterId}&statusUpdate=' + this.value +
                                                        '&keyword=' + encodeURIComponent('${keyword}')" 
                                        style="background-color: ${
                                        item.testStatus == 'Pending' ? 'khaki' :
                                            item.testStatus == 'Accepted' ? 'lightgreen' :
                                            item.testStatus == 'Rejected' ? '#f08080' :
                                            item.testStatus == 'Đã hết hạn' ? '#d3d3d3' : 'white'
                                        };
                                        color: black;
                                        font-weight: 500;">
                                    <option value="Pending" ${a.getStatus() == 'Pending' ? 'selected' : ''}>Chờ duyệt</option>
                                    <option value="Accepted" ${a.getStatus() == 'Accepted' ? 'selected' : ''}>Đã duyệt</option>
                                    <option value="Rejected" ${a.getStatus() == 'Rejected' ? 'selected' : ''}>Đã từ chối</option>
                                </select>
                            </td>



                            <td>${item.createdAt}</td>
                            <td>
                                <form action="" method="get">
                                    <input type="hidden" name="jobId" value="" />
                                    <input type="hidden" name="editJob" value="normal" />
                                    <button type="submit" class="btn btn-sm btn-primary">Chi tiết</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>


        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
