<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm blog</title>
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
            .image-tool__image-picture {
                max-width: 50% !important;
                vertical-align: bottom;
                display: block;
            }
        </style>
        <!-- Editor.js CDN -->
        <!-- Core Editor -->
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@2.29.1"></script>

        <!-- Các tools -->
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/paragraph@2.8.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/header@2.7.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/list@1.7.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/quote@2.5.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/delimiter@1.3.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/table@1.2.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/image@2.10.0"></script>
        

        <!--        <script>
                    const ImageTool = window.ImageTool; // Nếu bạn dùng Image
                </script>-->

    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>

        <!-- Phần nội dung sẽ được đẩy sang phải bằng margin-left -->
        <div style="margin-left: 280px; padding: 25px;">
            <div>
                <h2>Thêm/Sửa blog </h2>
                <c:if test="${not empty blogErrors}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${blogErrors}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="blogErrors" scope="session" />
                </c:if> 
                <c:if test="${not empty messageBlogUpdate}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${messageBlogUpdate}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="messageBlogUpdate" scope="session" />
                </c:if>  
                <div class="row">
                    <!-- Cột trái: Thông tin dịch vụ -->
                    <div class="col-md-6">
                        <form action="EditBlogAdmin" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="blogId" value="${blogInfo.getBlogId()}">
                            <input type="hidden" name="adminId" value="${blogInfo.getAdminId()}">
                            <input type="hidden" name="actionBlog" value="${actionBlog}">
                            <div class="mb-3">
                                <label for="title" class="form-label">Tên Blog</label>
                                <input type="text" class="form-control" id="title" name="titleBlog" value="${blogInfo.getTitle()}" required>
                            </div>
                            <div class="mb-3">
                                <label for="summary" class="form-label">Mô tả ngắn</label>
                                <textarea class="form-control" id="summary" name="summaryBlog" rows="3" required>${blogInfo.getSummary()}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="category_Blog" class="form-label">Lĩnh vực</label>
                                <select class="form-select" id="category_Blog" name="categoryBlog" required>
                                    <option value="">Tất cả Lĩnh vực</option>
                                    <option value="Công nghệ thông tin" ${blogInfo.getCategory() == 'Công nghệ thông tin' ? 'selected' : ''}>Công nghệ thông tin</option>
                                    <option value="Tài chính" ${blogInfo.getCategory() == 'Tài chính' ? 'selected' : ''}>Tài chính</option>
                                    <option value="Y tế" ${blogInfo.getCategory() == 'Y tế' ? 'selected' : ''}>Y tế</option>
                                    <option value="Giáo dục" ${blogInfo.getCategory() == 'Giáo dục' ? 'selected' : ''}>Giáo dục</option>
                                    <option value="Kế toán - Kiểm toán" ${blogInfo.getCategory() == 'Kế toán - Kiểm toán' ? 'selected' : ''}>Kế toán - Kiểm toán</option>
                                    <option value="Ngân hàng" ${blogInfo.getCategory() == 'Ngân hàng' ? 'selected' : ''}>Ngân hàng</option>
                                    <option value="Marketing - Truyền thông" ${blogInfo.getCategory() == 'Marketing - Truyền thông' ? 'selected' : ''}>Marketing - Truyền thông</option>
                                    <option value="Luật pháp" ${blogInfo.getCategory() == 'Luật pháp' ? 'selected' : ''}>Luật pháp</option>
                                    <option value="Xây dựng" ${blogInfo.getCategory() == 'Xây dựng' ? 'selected' : ''}>Xây dựng</option>
                                    <option value="Bất động sản" ${blogInfo.getCategory() == 'Bất động sản' ? 'selected' : ''}>Bất động sản</option>
                                    <option value="Kỹ thuật" ${blogInfo.getCategory() == 'Kỹ thuật' ? 'selected' : ''}>Kỹ thuật</option>
                                    <option value="Sản xuất" ${blogInfo.getCategory() == 'Sản xuất' ? 'selected' : ''}>Sản xuất</option>
                                    <option value="Vận tải - Logistics" ${blogInfo.getCategory() == 'Vận tải - Logistics' ? 'selected' : ''}>Vận tải - Logistics</option>
                                    <option value="Du lịch - Khách sạn" ${blogInfo.getCategory() == 'Du lịch - Khách sạn' ? 'selected' : ''}>Du lịch - Khách sạn</option>
                                    <option value="Nhân sự" ${blogInfo.getCategory() == 'Nhân sự' ? 'selected' : ''}>Nhân sự</option>
                                    <option value="Bảo hiểm" ${blogInfo.getCategory() == 'Bảo hiểm' ? 'selected' : ''}>Bảo hiểm</option>
                                    <option value="Nghệ thuật - Thiết kế" ${blogInfo.getCategory() == 'Nghệ thuật - Thiết kế' ? 'selected' : ''}>Nghệ thuật - Thiết kế</option>
                                    <option value="Nông nghiệp" ${blogInfo.getCategory() == 'Nông nghiệp' ? 'selected' : ''}>Nông nghiệp</option>
                                    <option value="Môi trường" ${blogInfo.getCategory() == 'Môi trường' ? 'selected' : ''}>Môi trường</option>
                                    <option value="Viễn thông" ${blogInfo.getCategory() == 'Viễn thông' ? 'selected' : ''}>Viễn thông</option>
                                </select>
                            </div>
                            <%-- 
                         <div class="mb-3">
                             <label for="description" class="form-label">Mô tả</label>
                             <textarea class="form-control" id="description" name="descriptionService" rows="3">${serviceInfo.getDescription()}</textarea>
                         </div>
                            --%>
                            <div class="mb-3">
                                <label class="form-label">Trạng thái</label><br>

                                <input type="radio" id="active" name="isPublished" value="1"
                                       ${blogInfo.isPublished ? "checked" : ""}>
                                <label for="active">Đăng công khai</label>

                                <input type="radio" id="inactive" name="isPublished" value="0"
                                       ${!blogInfo.isPublished ? "checked" : ""}>
                                <label for="inactive">Không đăng</label>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Nội dung Blog (Content JSON)</label>
                                <div id="editorjs" style="border: 1px solid #ccc; padding: 10px; border-radius: 8px; background: #fff;"></div>
                                <input type="hidden" name="contentJson" id="contentJson" />
                            </div>
                            <c:if test="${not empty blogInfo.thumbnailUrl}">
                                <div class="mb-3">
                                    <label class="form-label">Ảnh hiện tại:</label><br>
                                    <img src="${pageContext.request.contextPath}/${blogInfo.thumbnailUrl}" 
                                         alt="Ảnh dịch vụ" 
                                         style="max-width: 200px; height: auto; border: 1px solid #ccc; padding: 4px; border-radius: 8px;" />
                                </div>
                                <!-- Lưu đường dẫn ảnh hiện tại nếu không upload ảnh mới -->
                                <input type="hidden" name="oldImageBlogUrl" value="${blogInfo.thumbnailUrl}" />
                            </c:if>    
                            <div class="mb-3">
                                <label for="imageFileBlog" class="form-label">Chọn ảnh (nếu có thì chọn ảnh khác)</label>
                                <input class="form-control" type="file" id="imageFileBlog" name="imageFileBlog" accept="image/*">
                            </div>
                            <button type="submit" class="btn btn-primary">Cập nhật Blog</button>
                        </form>

                        <c:if test="${not empty blogInfo and actionBlog eq 'edit'}">
                            <form action="viewBlogPost" method="post" class="d-inline">
                                <input type="hidden" name="blogPostId" value="${blogInfo.blogId}" />
                                <button style="margin-left: 30%;margin-top: -65px;" type="submit" class="btn btn-success">Xem Blog </button>
                            </form>
                        </c:if>
                    </div>

                    <!-- Cột phải: Upload ảnh -->
                    <div class="col-md-6">
                        <div class="p-4 bg-light border rounded shadow-sm" style="height: 100%;">
                            <h5 class="mb-3">📌 Hướng dẫn viết nội dung blog</h5>

                            <p class="text-muted">
                                Trước khi đăng bài blog, bạn nên đọc kỹ các lưu ý sau để đảm bảo bài viết hiển thị đúng và đầy đủ trên hệ thống.
                            </p>

                            <ul>
                                <li>
                                    Bạn có thể soạn thảo bằng các công cụ: <b>Tiêu đề, Đoạn văn, Danh sách, Trích dẫn, Bảng, Dấu phân cách,...</b>.
                                </li>
                                <li>
                                    Để <b>thêm hình ảnh</b>, nhấn vào nút dấu <b>+</b> bên trái, chọn <i>Image</i>, sau đó:
                                    <ul>
                                        <li><b>By File:</b> Tải ảnh từ máy tính. Chỉ hỗ trợ ảnh <code>JPG, PNG, GIF</code> và dung lượng &lt; 1MB.</li>
                                        <li><b>By URL:</b> Dán liên kết ảnh trực tuyến (nếu có).</li>
                                    </ul>
                                </li>
                                <li>
                                    Nếu bạn <b>tải ảnh từ máy</b> nhưng ảnh không hiển thị → có thể do:
                                    <ul>
                                        <li>File không hợp lệ hoặc định dạng sai.</li>
                                        <li>Lỗi upload ảnh (mạng, máy chủ,...).</li>
                                        <li>Đường dẫn ảnh không lưu đúng trong dữ liệu JSON.</li>
                                    </ul>
                                    Hãy kiểm tra bằng cách nhấn F12 → Tab Console hoặc hỏi bộ phận kỹ thuật.
                                </li>
                                <li>
                                    Nội dung bài viết sẽ được lưu ở dạng JSON để hiển thị linh hoạt. Nếu bạn là quản trị viên kỹ thuật, có thể kiểm tra key <code>contentJson</code>.
                                </li>
                            </ul>

                            <p class="text-secondary small">
                                💡 Bạn có thể chỉnh sửa lại nội dung bất kỳ lúc nào sau khi đăng, kể cả hình ảnh trong bài viết.
                            </p>

                            <h6>📷 Ví dụ ảnh chèn trong bài viết</h6>
                            <img src="https://talentbold.com/Upload/news/20200710/142218425_kenh-tuyen-dung-hieu-qua-nhat-1.jpg"
                                 style="height: 200px;margin-left: 20%;"
                                 class="img-fluid rounded border"
                                 alt="Ảnh minh họa">
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            const editor = new EditorJS({
                holder: 'editorjs',
                tools: {
                    header: Header,
                    paragraph: Paragraph,
                    list: {
                        class: List,
                        inlineToolbar: true // bật toolbar mini khi bôi đen chữ
                    },
                    quote: {
                        class: Quote,
                        inlineToolbar: true
                    },
                    delimiter: Delimiter,
                    table: {
                        class: Table,
                        inlineToolbar: true
                    },
                    image: {
                        class: ImageTool,
                        config: {
                            endpoints: {
                                byFile: 'uploadImageContentJSON', // API để upload ảnh
                                byUrl: 'uploadImageContentJSON' // hoặc null nếu không hỗ trợ
                            }
                        }
                    }
                },
                placeholder: 'Viết nội dung blog ở đây...',
                data: ${blogInfo.contentJson != null ? blogInfo.contentJson : '{}'}
            });

            document.querySelector('form').addEventListener('submit', function (e) {
                e.preventDefault(); // Chặn không cho form gửi đi ngay
                editor.save().then((outputData) => { //Object JS → (stringify) → Chuỗi JSON → gửi đi.
                    document.getElementById('contentJson').value = JSON.stringify(outputData);
                    this.submit();
                }).catch((error) => {
                    console.error('Lỗi khi lưu nội dung:', error);
                    alert('Lỗi khi lưu nội dung blog. Vui lòng thử lại.');
                });
            });
        </script>



    </body>
</html>
