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
                <h2>Quản lí các bài Blog</h2>
                <a href="EditBlogAdmin?actionBlog=create" class="btn btn-primary">Tạo Blog mới</a>
            </div>
            <form action="ManageBlogPostAdmin" method="post" class="row g-3 align-items-end mb-4">
                <div class="col-md-4">
                    <label class="form-label" style="text-align: center;">Tìm kiếm</label>
                    <input type="text" name="keywordBlog" value="${keywordBlog}" class="form-control" placeholder="Tìm kiếm theo tên blog">
                </div>
                <!-- Lọc theo lĩnh vực -->
                <div class="col-md-2" style="width: 15%;">
                    <label class="form-label">Lĩnh vực</label>
                    <select name="typeCategory" class="form-select">
                        <option value="">Tất cả Lĩnh vực</option>
                        <option value="Công nghệ thông tin" ${typeCategory == 'Công nghệ thông tin' ? 'selected' : ''}>Công nghệ thông tin</option>
                        <option value="Tài chính" ${typeCategory == 'Tài chính' ? 'selected' : ''}>Tài chính</option>
                        <option value="Y tế" ${typeCategory == 'Y tế' ? 'selected' : ''}>Y tế</option>
                        <option value="Giáo dục" ${typeCategory == 'Giáo dục' ? 'selected' : ''}>Giáo dục</option>
                        <option value="Kế toán - Kiểm toán" ${typeCategory == 'Kế toán - Kiểm toán' ? 'selected' : ''}>Kế toán - Kiểm toán</option>
                        <option value="Ngân hàng" ${typeCategory == 'Ngân hàng' ? 'selected' : ''}>Ngân hàng</option>
                        <option value="Marketing - Truyền thông" ${typeCategory == 'Marketing - Truyền thông' ? 'selected' : ''}>Marketing - Truyền thông</option>
                        <option value="Luật pháp" ${typeCategory == 'Luật pháp' ? 'selected' : ''}>Luật pháp</option>
                        <option value="Xây dựng" ${typeCategory == 'Xây dựng' ? 'selected' : ''}>Xây dựng</option>
                        <option value="Bất động sản" ${typeCategory == 'Bất động sản' ? 'selected' : ''}>Bất động sản</option>
                        <option value="Kỹ thuật" ${typeCategory == 'Kỹ thuật' ? 'selected' : ''}>Kỹ thuật</option>
                        <option value="Sản xuất" ${typeCategory == 'Sản xuất' ? 'selected' : ''}>Sản xuất</option>
                        <option value="Vận tải - Logistics" ${typeCategory == 'Vận tải - Logistics' ? 'selected' : ''}>Vận tải - Logistics</option>
                        <option value="Du lịch - Khách sạn" ${typeCategory == 'Du lịch - Khách sạn' ? 'selected' : ''}>Du lịch - Khách sạn</option>
                        <option value="Nhân sự" ${typeCategory == 'Nhân sự' ? 'selected' : ''}>Nhân sự</option>
                        <option value="Bảo hiểm" ${typeCategory == 'Bảo hiểm' ? 'selected' : ''}>Bảo hiểm</option>
                        <option value="Nghệ thuật - Thiết kế" ${typeCategory == 'Nghệ thuật - Thiết kế' ? 'selected' : ''}>Nghệ thuật - Thiết kế</option>
                        <option value="Nông nghiệp" ${typeCategory == 'Nông nghiệp' ? 'selected' : ''}>Nông nghiệp</option>
                        <option value="Môi trường" ${typeCategory == 'Môi trường' ? 'selected' : ''}>Môi trường</option>
                        <option value="Viễn thông" ${typeCategory == 'Viễn thông' ? 'selected' : ''}>Viễn thông</option>
                    </select>
                </div>


                <!-- Lọc theo ngày đăng: Từ ngày - Đến ngày -->
                <div class="col-md-2" style="width: 14%;">
                    <label class="form-label">Từ Ngày</label>
                    <input type="date" name="fromDateBlog" class="form-control" value="${fromDateBlog}">
                </div>
                <div class="col-md-2" style="width: 14%;">
                    <label class="form-label">Đến Ngày</label>
                    <input type="date" name="toDateBlog" class="form-control" value="${toDateBlog}">
                </div>
                <!-- Sắp xếp -->
                <div class="col-md-2">
                    <label class="form-label">Sắp xếp</label>
                    <select name="sortBlog" class="form-select">
                        <option value="">-- Mặc định --</option>
                        <option value="createAt_desc_blog" ${sortBlog == 'createAt_desc_blog' ? 'selected' : ''}>Ngày giảm dần</option>
                        <option value="createAt_asc_blog" ${sortBlog == 'createAt_asc_blog' ? 'selected' : ''}>Ngày tăng dần</option>
                        <option value="title_asc_blog" ${sortBlog == 'title_asc_blog' ? 'selected' : ''}>Tên (A-Z)</option>
                        <option value="title_desc_blog" ${sortBlog == 'title_desc_blog' ? 'selected' : ''}>Tên (Z-A)</option>
                    </select>
                </div>
                <!-- Nút lọc -->
                <div class="col-md-1" style="width: 6%;">
                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                </div>
            </form>
            <c:if test="${not empty messageBlogUpdate}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${messageBlogUpdate}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="messageBlogUpdate" scope="session" />
            </c:if>  
            <c:if test="${not empty errorBlog}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorBlog}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="errorBlog" scope="session" />
            </c:if>
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th style="width: 25%;">Tiêu đề</th>
                        <th>Loại</th>
                        <th>Mô tả ngắn</th>
                        <th>Ngày tạo</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${listBlogPost}">
                        <tr>
                            <td>${a.getBlogId()}</td>
                            <td style="width: 25%;">${a.getTitle()}</td>
                            <td>${a.getCategory()}</td>
                            <td style="width: 25%;">${a.getSummary()}</td>
                            <td>${a.dateCreatAt()}</td>
                            <td>
                                <form action="ManageBlogPostAdmin" method="POST">
                                    <input type="hidden" name="blogPostId" value="${a.getBlogId()}" />
                                    <input type="hidden" name="actionBlog" value="updateBlog" />

                                    <input type="hidden" name="keywordBlog" value="${keywordBlog}">
                                    <input type="hidden" name="typeCategory" value="${typeCategory}">
                                    <input type="hidden" name="fromDateBlog" value="${fromDateBlog}">
                                    <input type="hidden" name="toDateBlog" value="${toDateBlog}">
                                    <input type="hidden" name="sortBlog" value="${sortBlog}">

                                    <input type="hidden" name="page" value="${page}">

                                    <select name="statusBlogUpdate"
                                            class="form-select form-select-sm"
                                            style="
                                            background-color: ${a.isPublished ? 'lightgreen' : '#d3d3d3'};
                                            color: black;
                                            font-weight: 500;"
                                            border-radius: 6px;
                                            onchange="this.form.submit()">
                                        <option value="1" ${a.isPublished ? "selected" : ""}>Đã đăng</option>
                                        <option value="0" ${!a.isPublished ? "selected" : ""}>Chưa đăng</option>
                                    </select>
                                </form>
                            </td>

                            <td>
                                <form action="EditBlogAdmin" method="get" class="d-inline">
                                    <input type="hidden" name="blogPostId" value="${a.getBlogId()}" />
                                    <button type="submit" class="btn btn-sm btn-primary">Sửa</button>
                                </form>
                                <form action="DeleteBlogAdmin" method="get" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa blog này không?');">
                                    <input type="hidden" name="blogPostId" value="${a.getBlogId()}" />
                                    <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
            <form action="ManageBlogPostAdmin" method="post">
                <!-- Ẩn các tham số lọc nếu có -->
                <input type="hidden" name="keywordBlog" value="${keywordBlog}">
                <input type="hidden" name="typeCategory" value="${typeCategory}">
                <input type="hidden" name="fromDateBlog" value="${fromDateBlog}">
                <input type="hidden" name="toDateBlog" value="${toDateBlog}">
                <input type="hidden" name="sortBlog" value="${sortBlog}">
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
