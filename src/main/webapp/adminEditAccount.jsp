<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Job Post</title>
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
            label.form-label {
                font-weight: 500;
            }
            input[readonly] {
                background-color: #f5f5f5;
                cursor: not-allowed;
            }
        </style>
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>
        <div style="margin-left: 260px; padding: 30px 40px 30px 40px;">
            <h4 class="mb-4">Thông tin tài khoản nhà tuyển dụng</h4>
            <c:if test="${not empty errorsAcc}">
                <div class="alert alert-danger">
                    <ul>
                        <c:forEach var="err" items="${errorsAcc}">
                            <li>${err}</li>
                            </c:forEach>
                    </ul>
                </div>
            </c:if>
            <div class="row">
                <form action="EditAdminAccountRecruiter" method="post">
                    <input type="hidden" name="recruiterId" value="${recruiterEdit.recruiterId}">
                    <div class="col-md-12 row">
                        <!-- Phần trái: Thông tin bắt buộc -->
                        <div class="col-md-5">
                            <h5 class="fw-bold mb-3">Thông tin bắt buộc</h5>

                            <!-- Họ tên -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Họ tên</label>
                                <input type="text" class="form-control" name="fullName" value="${recruiterEdit.fullName}" required>
                            </div>

                            <!-- Số điện thoại -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Số điện thoại</label>
                                <input type="text" class="form-control" name="phone" value="${recruiterEdit.phone}" required>
                            </div>

                            <!-- Email (readonly) -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Email</label>
                                <input type="email" class="form-control" name="email" value="${recruiterEdit.email}" readonly>
                            </div>

                            <!-- Chức vụ -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Chức vụ</label>
                                <input type="text" class="form-control" name="position" value="${recruiterEdit.position}" required>
                            </div>

                            <!-- Tên công ty -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Tên công ty</label>
                                <input type="text" class="form-control" name="companyName" value="${recruiterEdit.companyName}" required>
                            </div>

                            <!-- Mã số thuế -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Mã số thuế</label>
                                <input type="number" class="form-control" name="tax" value="${recruiterEdit.taxCode}" required>
                            </div>
                        </div>

                        <!-- Phần phải: Thông tin bổ sung -->
                        <div class="col-md-7">
                            <h5 class="fw-bold mb-3">Thông tin bổ sung</h5>

                            <!-- Địa chỉ công ty -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Địa chỉ công ty</label>
                                <select name="companyAddress"
                                        class="form-select block w-full max-w-sm p-2 border border-gray-300 rounded-md text-sm">
                                    <option value="" selected >-- Chọn tỉnh/thành phố --</option>

                                    <!-- Thành phố -->
                                    <option value="Hà Nội" ${recruiterEdit.companyAddress == 'Hà Nội' ? 'selected' : ''}>Thành phố Hà Nội</option>
                                    <option value="Hồ Chí Minh" ${recruiterEdit.companyAddress == 'Hồ Chí Minh' ? 'selected' : ''}>Thành phố Hồ Chí Minh</option>
                                    <option value="Đà Nẵng" ${recruiterEdit.companyAddress == 'Đà Nẵng' ? 'selected' : ''}>Thành phố Đà Nẵng</option>
                                    <option value="Hải Phòng" ${recruiterEdit.companyAddress == 'Hải Phòng' ? 'selected' : ''}>Thành phố Hải Phòng</option>
                                    <option value="Cần Thơ" ${recruiterEdit.companyAddress == 'Cần Thơ' ? 'selected' : ''}>Thành phố Cần Thơ</option>
                                    <option value="Huế" ${recruiterEdit.companyAddress == 'Huế' ? 'selected' : ''}>Thành phố Huế</option>

                                    <!-- Tỉnh -->
                                    <option value="Lai Châu" ${recruiterEdit.companyAddress == 'Lai Châu' ? 'selected' : ''}>Tỉnh Lai Châu</option>
                                    <option value="Điện Biên" ${recruiterEdit.companyAddress == 'Điện Biên' ? 'selected' : ''}>Tỉnh Điện Biên</option>
                                    <option value="Sơn La" ${recruiterEdit.companyAddress == 'Sơn La' ? 'selected' : ''}>Tỉnh Sơn La</option>
                                    <option value="Lạng Sơn" ${recruiterEdit.companyAddress == 'Lạng Sơn' ? 'selected' : ''}>Tỉnh Lạng Sơn</option>
                                    <option value="Quảng Ninh" ${recruiterEdit.companyAddress == 'Quảng Ninh' ? 'selected' : ''}>Tỉnh Quảng Ninh</option>
                                    <option value="Thanh Hoá" ${recruiterEdit.companyAddress == 'Thanh Hoá' ? 'selected' : ''}>Tỉnh Thanh Hoá</option>
                                    <option value="Nghệ An" ${recruiterEdit.companyAddress == 'Nghệ An' ? 'selected' : ''}>Tỉnh Nghệ An</option>
                                    <option value="Hà Tĩnh" ${recruiterEdit.companyAddress == 'Hà Tĩnh' ? 'selected' : ''}>Tỉnh Hà Tĩnh</option>
                                    <option value="Cao Bằng" ${recruiterEdit.companyAddress == 'Cao Bằng' ? 'selected' : ''}>Tỉnh Cao Bằng</option>
                                    <option value="Tuyên Quang" ${recruiterEdit.companyAddress == 'Tuyên Quang' ? 'selected' : ''}>Tỉnh Tuyên Quang</option>
                                    <option value="Lào Cai" ${recruiterEdit.companyAddress == 'Lào Cai' ? 'selected' : ''}>Tỉnh Lào Cai</option>
                                    <option value="Thái Nguyên" ${recruiterEdit.companyAddress == 'Thái Nguyên' ? 'selected' : ''}>Tỉnh Thái Nguyên</option>
                                    <option value="Phú Thọ" ${recruiterEdit.companyAddress == 'Phú Thọ' ? 'selected' : ''}>Tỉnh Phú Thọ</option>
                                    <option value="Bắc Ninh" ${recruiterEdit.companyAddress == 'Bắc Ninh' ? 'selected' : ''}>Tỉnh Bắc Ninh</option>
                                    <option value="Hưng Yên" ${recruiterEdit.companyAddress == 'Hưng Yên' ? 'selected' : ''}>Tỉnh Hưng Yên</option>
                                    <option value="Ninh Bình" ${recruiterEdit.companyAddress == 'Ninh Bình' ? 'selected' : ''}>Tỉnh Ninh Bình</option>
                                    <option value="Quảng Trị" ${recruiterEdit.companyAddress == 'Quảng Trị' ? 'selected' : ''}>Tỉnh Quảng Trị</option>
                                    <option value="Quảng Ngãi" ${recruiterEdit.companyAddress == 'Quảng Ngãi' ? 'selected' : ''}>Tỉnh Quảng Ngãi</option>
                                    <option value="Gia Lai" ${recruiterEdit.companyAddress == 'Gia Lai' ? 'selected' : ''}>Tỉnh Gia Lai</option>
                                    <option value="Khánh Hoà" ${recruiterEdit.companyAddress == 'Khánh Hoà' ? 'selected' : ''}>Tỉnh Khánh Hoà</option>
                                    <option value="Lâm Đồng" ${lrecruiterEdit.companyAddressocation == 'Lâm Đồng' ? 'selected' : ''}>Tỉnh Lâm Đồng</option>
                                    <option value="Đắk Lắk" ${recruiterEdit.companyAddress == 'Đắk Lắk' ? 'selected' : ''}>Tỉnh Đắk Lắk</option>
                                    <option value="Đồng Nai" ${recruiterEdit.companyAddress == 'Đồng Nai' ? 'selected' : ''}>Tỉnh Đồng Nai</option>
                                    <option value="Tây Ninh" ${locrecruiterEdit.companyAddressation == 'Tây Ninh' ? 'selected' : ''}>Tỉnh Tây Ninh</option>
                                    <option value="Vĩnh Long" ${recruiterEdit.companyAddress == 'Vĩnh Long' ? 'selected' : ''}>Tỉnh Vĩnh Long</option>
                                    <option value="Đồng Tháp" ${recruiterEdit.companyAddress == 'Đồng Tháp' ? 'selected' : ''}>Tỉnh Đồng Tháp</option>
                                    <option value="Cà Mau" ${recruiterEdit.companyAddress == 'Cà Mau' ? 'selected' : ''}>Tỉnh Cà Mau</option>
                                    <option value="Kiên Giang" ${recruiterEdit.companyAddress == 'Kiên Giang' ? 'selected' : ''}>Tỉnh Kiên Giang</option>
                                </select>
                            </div>

                            <!-- Website -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Website</label>
                                <input type="text" class="form-control" name="website" value="${recruiterEdit.website}">
                            </div>

                            <!-- Lĩnh vực -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Lĩnh vực</label>
                                <input type="text" class="form-control" name="industry" value="${recruiterEdit.industry}">
                            </div>

                            <!-- Mô tả -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">Mô tả công ty</label>
                                <textarea class="form-control" name="companyDescription" rows="8">${recruiterEdit.companyDescription}</textarea>
                            </div>


                        </div>
                        <!-- Nút cập nhật -->
                        <div class="text-center mt-3">
                            <button type="submit" class="btn btn-primary px-4">Cập nhật</button>
                        </div>

                    </div>
                </form>
                <%--                    
                        <form>         
                            <div class="col-md-3">
                                <h5 class="fw-bold mb-3">Logo công ty</h5>
                                <!-- Logo -->
                                <label class="form-label fw-bold">Logo</label><br>
                                <c:if test="${not empty recruiterEdit.getCompanyLogoUrl()}">
                                    <img src="${recruiterEdit.getCompanyLogoUrl()}" alt="Logo công ty" style="max-height: 100px; border: 1px solid #ccc; padding: 5px; margin-bottom: 10px;">
                                </c:if>
                                <input type="file" class="form-control" name="companyLogo">
                            </div>  
                        </form>
                --%>                 
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
