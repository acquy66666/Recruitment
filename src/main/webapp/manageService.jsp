<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí dịch vụ</title>
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
        </style>
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>

        <!-- Phần nội dung sẽ được đẩy sang phải bằng margin-left -->
        <div style="margin-left: 280px; padding: 25px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Quản lí các gói dịch vụ</h2>
                <a href="EditServiceAdmin?actionService=create" class="btn btn-primary">Tạo dịch vụ mới</a>
            </div>
            <form action="ManageServiceAdmin" method="post" class="row g-3 align-items-end mb-4">
                <div class="col-md-4">
                    <label class="form-label" style="text-align: center;">Tìm kiếm</label>
                    <input type="text" name="keywordService" value="${keywordService}" class="form-control" placeholder="Tìm kiếm theo tên dịch vụ">
                </div>
                <!-- Lọc theo trạng thái -->
                <div class="col-md-2" style="width: 15%;">
                    <label class="form-label">Loại dịch vụ</label>
                    <select name="typeService" class="form-select">
                        <option value="">Tất cả loại dịch vụ</option>
                        <c:forEach var="p" items="${typeServiceList}">
                            <option value="${p}" ${p == typeService ? "selected" : ""}>
                                <c:choose>
                                    <c:when test="${p == 'jobPost'}">Đăng tuyển</c:when>
                                    <c:when test="${p == 'test'}">Bài kiểm tra</c:when>
                                    <c:otherwise>${p}</c:otherwise>
                                </c:choose>
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Lọc theo ngày đăng: Từ ngày - Đến ngày -->
                <div class="col-md-2" style="width: 14%;">
                    <label class="form-label required-field">Giá từ </label>
                    <input type="text" name="fromPriceService" id="fromPriceService" class="form-control" placeholder="VD: 50,000" value="${fromPriceService}">
                </div>
                <div class="col-md-2" style="width: 14%;">
                    <label class="form-label required-field">Đến giá </label>
                    <input type="text" name="toPriceService" id="toPriceService" class="form-control" placeholder="VD: 500,000" value="${toPriceService}">
                </div>
                <!-- Sắp xếp -->
                <div class="col-md-2">
                    <label class="form-label">Sắp xếp</label>
                    <select name="sortService" class="form-select">
                        <option value="">-- Mặc định --</option>
                        <option value="credit_desc_service" ${sortService == 'credit_desc_service' ? 'selected' : ''}>Credit giảm dần</option>
                        <option value="credit_asc_service" ${sortService == 'credit_asc_service' ? 'selected' : ''}>Credit tăng dần</option>
                        <option value="title_asc_service" ${sortService == 'title_asc_service' ? 'selected' : ''}>Tên (A-Z)</option>
                        <option value="title_desc_service" ${sortService == 'title_desc_service' ? 'selected' : ''}>Tên (Z-A)</option>
                    </select>
                </div>
                <!-- Nút lọc -->
                <div class="col-md-1" style="width: 6%;">
                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                </div>
            </form>
            <c:if test="${not empty messageServiceUpdate}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${messageServiceUpdate}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="messageServiceUpdate" scope="session" />
            </c:if> 
            <c:if test="${not empty sessionScope.errorService}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.errorService}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorService" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.messageService}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.messageService}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="messageService" scope="session" />
            </c:if>

            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th style="width: 25%;">Tiêu đề</th>
                        <th>Loại</th>
                        <th>Số lượng credit</th>
                        <th>Giá</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${listService}">
                        <tr>
                            <td>${a.getServiceId()}</td>
                            <td style="width: 25%;">${a.getTitle()}</td>
                            <td style="width: 15%;">
                                <c:choose>
                                    <c:when test="${a.serviceType == 'jobPost'}">Đăng tuyển</c:when>
                                    <c:when test="${a.serviceType == 'test'}">Bài kiểm tra</c:when>
                                    <c:otherwise>${a.serviceType}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${a.getCredit()}</td>
                            <td style="width: 15%;">${a.formatPriceView(a.getPrice())}</td>
                            <td>
                                <form action="ManageServiceAdmin" method="POST">
                                    <input type="hidden" name="serviceId" value="${a.getServiceId()}" />
                                    <input type="hidden" name="actionService" value="updateService" />

                                    <input type="hidden" name="keywordService" value="${keywordService}">
                                    <input type="hidden" name="typeService" value="${typeService}">
                                    <input type="hidden" name="fromPriceService" value="${fromPriceService}">
                                    <input type="hidden" name="toPriceService" value="${toPriceService}">
                                    <input type="hidden" name="sortService" value="${sortService}">

                                    <input type="hidden" name="page" value="${page}">
                                    <select name="statusServiceUpdate"
                                            class="form-select form-select-sm"
                                            style="
                                            background-color: ${a.isActive ? 'lightgreen' : '#d3d3d3'};
                                            color: black;
                                            font-weight: 500;"
                                            border-radius: 6px;
                                            onchange="this.form.submit()">
                                        <option value="1" ${a.isActive ? "selected" : ""}>Đã kích hoạt</option>
                                        <option value="0" ${!a.isActive ? "selected" : ""}>Chưa kích hoạt</option>
                                    </select>
                                </form>
                            </td>

                            <td>
                                <form action="EditServiceAdmin" method="get" class="d-inline">
                                    <input type="hidden" name="serviceId" value="${a.getServiceId()}" />
                                    <button type="submit" class="btn btn-sm btn-primary">Sửa</button>
                                </form>
                                <%--
                            <form action="DeleteServiceAdmin" method="get" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa dịch vụ này không?');">
                                <input type="hidden" name="serviceId" value="${a.getServiceId()}" />
                                <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                            </form>
                                --%>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
            <form action="ManageServiceAdmin" method="post">
                <!-- Ẩn các tham số lọc nếu có -->
                <input type="hidden" name="keywordService" value="${keywordService}">
                <input type="hidden" name="typeService" value="${typeService}">
                <input type="hidden" name="fromPriceService" value="${fromPriceService}">
                <input type="hidden" name="toPriceService" value="${toPriceService}">
                <input type="hidden" name="sortService" value="${sortService}">
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
        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                function formatNumberInput(input) {
                                                    input.addEventListener('input', function (e) {
                                                        let value = this.value.replace(/\D/g, ''); // Xoá hết ký tự không phải số
                                                        if (value === '') {
                                                            this.value = '';
                                                            return;
                                                        }
                                                        this.value = Number(value).toLocaleString('vi-VN'); // Định dạng theo kiểu Việt Nam: 3.000
                                                    });
                                                }

                                                // Khi DOM đã sẵn sàng
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    const fromPriceService = document.getElementById("fromPriceService");
                                                    const toPriceService = document.getElementById("toPriceService");

                                                    formatNumberInput(fromPriceService);
                                                    formatNumberInput(toPriceService);

                                                    document.querySelector("form").addEventListener("submit", function () {
                                                        // Xóa dấu chấm phân cách trước khi gửi dữ liệu
                                                        fromPriceService.value = fromPriceService.value.replace(/\./g, '');
                                                        toPriceService.value = toPriceService.value.replace(/\./g, '');
                                                    });
                                                });
        </script>

    </body>
</html>
