<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm gói dịch vụ</title>
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
            <div>
                <h2>Thêm/Sửa gói dịch vụ </h2>
                <c:if test="${not empty serviceErrors}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${serviceErrors}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="serviceErrors" scope="session" />
                </c:if> 
                <div class="row">
                    <!-- Cột trái: Thông tin dịch vụ -->
                    <div class="col-md-6">
                        <form action="EditServiceAdmin" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="serviceId" value="${serviceInfo.getServiceId()}">
                            <input type="hidden" name="actionService" value="${actionService}">
                            <div class="mb-3">
                                <label for="title" class="form-label">Tên gói dịch vụ</label>
                                <input type="text" class="form-control" id="title" name="titleService" value="${not empty titleService ? titleService : serviceInfo.getTitle()}" required>
                            </div>
                            <div class="mb-3">
                                <label for="credit" class="form-label">Số lượng đăng bài</label>
                                <input type="text" class="form-control" id="credit" name="creditService" value="${not empty creditService ? creditService : serviceInfo.getFormattedCredit()}" required>
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">Giá (VNĐ)</label>
                                <input type="text" class="form-control" id="price" name="priceService" value="${not empty priceService ? priceService : serviceInfo.getFormattedPriceNew()}" >
                            </div>
                            <div class="mb-3">
                                <label for="service_type" class="form-label">Loại dịch vụ</label>
                                <select class="form-select" id="service_type" name="serviceType" required>
                                    <option value="">Tất cả loại dịch vụ</option>
                                    <option value="test" ${serviceType == 'test' ? 'selected' : (serviceInfo.getServiceType() == 'test' ? 'selected' : '')}>Bài online test</option>
                                    <option value="jobPost" ${serviceType == 'jobPost' ? 'selected' : (serviceInfo.getServiceType() == 'jobPost' ? 'selected' : '')}>Đăng tuyển</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="description" name="descriptionService" rows="3">${not empty descriptionService ? descriptionService : serviceInfo.getDescription()}</textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Trạng thái</label><br>

                                <input type="radio" id="active" name="isActive" value="1"
                                       ${param.isActive == '1' || (empty param.isActive and serviceInfo.isActive) ? 'checked' : ''}>
                                <label for="active">Hoạt động</label>

                                <input type="radio" id="inactive" name="isActive" value="0"
                                       ${param.isActive == '0' || (empty param.isActive and not serviceInfo.isActive) ? 'checked' : ''}>
                                <label for="inactive">Không hoạt động</label>
                            </div>
                            <c:if test="${not empty serviceInfo.imgUrl}">
                                <div class="mb-3">
                                    <label class="form-label">Ảnh hiện tại:</label><br>
                                    <img src="${pageContext.request.contextPath}/${serviceInfo.imgUrl}" 
                                         alt="Ảnh dịch vụ" 
                                         style="max-width: 200px; height: auto; border: 1px solid #ccc; padding: 4px; border-radius: 8px;" />
                                </div>
                                <!-- Lưu đường dẫn ảnh hiện tại nếu không upload ảnh mới -->
                                <input type="hidden" name="oldImageUrl" value="${serviceInfo.imgUrl}" />
                            </c:if>    
                            <div class="mb-3">
                                <label for="imageFile" class="form-label">Chọn ảnh (nếu có thì chọn ảnh khác)</label>
                                <input class="form-control" type="file" id="imageFile" name="imageFileService" accept="image/*" ${actionService == 'create' ? 'required' : ''}>
                            </div>
                            <button type="submit" class="btn btn-primary">Cập nhật gói dịch vụ</button>
                        </form>
                    </div>

                    <!-- Cột phải: Upload ảnh -->
                    <div class="col-md-6">
                        <div class="p-4 bg-light border rounded shadow-sm" style="height: 100%;">
                            <h5 class="mb-3">📌 Quy tắc & Hướng dẫn</h5>

                            <p class="text-muted">
                                Trước khi thêm gói dịch vụ mới, vui lòng đọc kỹ các quy tắc sau để đảm bảo tính nhất quán và dễ quản lý trong hệ thống.
                            </p>

                            <ul>
                                <li>Mỗi gói dịch vụ nên có tên rõ ràng, phản ánh đúng chức năng.</li>
                                <li>Credit là số điểm người dùng cần trả khi sử dụng dịch vụ này.</li>
                                <li>Giá cần hợp lý theo thị trường và theo chính sách khuyến mãi (nếu có).</li>
                                <li>Ảnh dịch vụ nên rõ nét, tỷ lệ phù hợp (4:3 hoặc vuông), dung lượng nhỏ hơn 1MB.</li>
                                <li>Loại dịch vụ phân theo chức năng hệ thống: Bài kiểm tra, Đăng tuyển, Quảng cáo,...</li>
                                <li>Mô tả càng cụ thể càng giúp người dùng hiểu rõ lợi ích khi mua dịch vụ.</li>
                            </ul>

                            <p class="text-secondary small">
                                ⚠️ Sau khi thêm, bạn vẫn có thể chỉnh sửa hoặc tạm dừng gói dịch vụ này từ trang danh sách quản lý.
                            </p>
                            <h6>📷 Ví dụ ảnh minh họa</h6>
                            <img src="https://talentbold.com/Upload/news/20200710/142218425_kenh-tuyen-dung-hieu-qua-nhat-1.jpg" style="height: 200px;margin-left: 20%;" class="img-fluid rounded border" alt="Ảnh minh họa">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function formatNumberInput(input) {
                input.addEventListener('input', function (e) {
                    let value = this.value.replace(/\D/g, ''); // Xoá hết ký tự không phải số
                    if (value === '') {
                        this.value = '';
                        return;
                    }
                    this.value = Number(value).toLocaleString('vi-VN'); // Thêm dấu chấm mỗi 3 số
                });
            }

// Khi submit form, xóa dấu chấm để gửi dữ liệu chuẩn
            document.addEventListener("DOMContentLoaded", function () {
                const credit = document.getElementById("credit");
                const price = document.getElementById("price");

                formatNumberInput(credit);
                formatNumberInput(price);

                document.querySelector("form").addEventListener("submit", function () {
                    credit.value = credit.value.replace(/\./g, '');
                    price.value = price.value.replace(/\./g, '');
                });
            });
        </script>
    </body>
</html>
