<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Blog - Tin tức và kiến thức</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                line-height: 1.6;
                color: #495057;
            }

            /* Header */
            .navbar {
                background: white;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 1rem 0;
            }

            .navbar-brand {
                font-size: 1.5rem;
                font-weight: 700;
                color: #007bff !important;
            }

            .navbar-nav .nav-link {
                color: #495057 !important;
                font-weight: 500;
                margin: 0 0.5rem;
                transition: color 0.3s ease;
            }

            .navbar-nav .nav-link:hover,
            .navbar-nav .nav-link.active {
                color: #007bff !important;
            }

            /* Page Header */
            .page-header {
                background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
                color: white;
                padding: 4rem 0 2rem;
                margin-bottom: 3rem;
            }

            .page-title {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 1rem;
            }

            .page-subtitle {
                font-size: 1.1rem;
                opacity: 0.9;
            }

            /* Main Container */
            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 1rem;
            }

            .content-wrapper {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 2rem;
                align-items: start;
            }

            /* Search & Filter */
            .search-filter {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border: 1px solid #e9ecef;
            }

            .search-input {
                border: 1px solid #e9ecef;
                border-radius: 8px;
                padding: 0.55rem 1rem;
                font-size: 0.95rem;
                transition: border-color 0.3s ease;
            }

            .search-input:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
            }

            .filter-buttons {
                display: flex;
                gap: 0.5rem;
                flex-wrap: wrap;
                margin-top: 1rem;
            }

            .filter-btn {
                padding: 0.5rem 1rem;
                border: 1px solid #e9ecef;
                background: white;
                color: #495057;
                border-radius: 20px;
                font-size: 0.875rem;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .filter-btn:hover,
            .filter-btn.active {
                background: #007bff;
                color: white;
                border-color: #007bff;
            }

            /* Blog List */
            .blog-list {
                display: flex;
                flex-direction: column;
                gap: 2rem;
            }

            .blog-card {
                background: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border: 1px solid #e9ecef;
                transition: all 0.3s ease;
                text-decoration: none;
                color: inherit;
            }

            .blog-card:hover {
                transform: translateY(-2px); /* Nhẹ hơn để không bị lộ bóng thừa */
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12); /* đổ bóng chủ yếu xuống dưới */
                text-decoration: none;
                color: inherit;
            }

            .blog-card-horizontal {
                display: grid;
                grid-template-columns: 300px 1fr;
                min-height: 200px;
            }

            .blog-thumbnail {
                width: 100%;
                height: 100%;
                object-fit: cover;
                background: #f8f9fa;
            }

            .blog-content {
                padding: 1.5rem;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .blog-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 0.75rem;
                line-height: 1.4;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .blog-summary {
                color: #6c757d;
                font-size: 0.95rem;
                line-height: 1.5;
                margin-bottom: 1rem;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .blog-meta {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 1rem;
                margin-top: auto;
            }

            .meta-left {
                display: flex;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: #6c757d;
                font-size: 0.875rem;
            }

            .meta-item i {
                color: #007bff;
            }

            .status-badge {
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .status-published {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            .status-draft {
                background-color: #f8d7da;
                color: #721c24;
            }

            /* Sidebar */
            .sidebar {
                display: flex;
                flex-direction: column;
                gap: 2rem;
            }

            .sidebar-widget {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border: 1px solid #e9ecef;
            }

            .widget-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 1rem;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #007bff;
            }

            .category-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.5rem 0;
                border-bottom: 1px solid #f8f9fa;
                color: #495057;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .category-item:hover {
                color: #007bff;
                text-decoration: none;
            }

            .category-count {
                background: #f8f9fa;
                color: #6c757d;
                padding: 0.25rem 0.5rem;
                border-radius: 12px;
                font-size: 0.75rem;
            }

            .recent-post {
                display: flex;
                gap: 1rem;
                padding: 1rem 0;
                border-bottom: 1px solid #f8f9fa;
                text-decoration: none;
                color: inherit;
                transition: all 0.3s ease;
            }

            .recent-post:hover {
                color: #007bff;
                text-decoration: none;
            }

            .recent-thumbnail {
                width: 60px;
                height: 60px;
                border-radius: 8px;
                object-fit: cover;
                background: #f8f9fa;
            }

            .recent-content {
                flex: 1;
            }

            .recent-title {
                font-size: 0.9rem;
                font-weight: 600;
                line-height: 1.3;
                margin-bottom: 0.25rem;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .recent-date {
                font-size: 0.75rem;
                color: #6c757d;
            }

            /* Pagination */
            .pagination-wrapper {
                margin-top: 3rem;
                display: flex;
                justify-content: center;
            }

            .pagination .page-link {
                /*color: #007bff;*/
                border-color: #e9ecef;
                padding: 0.5rem 0.75rem;
            }

            .pagination .page-link:hover {
                background-color: #f8f9fa;
                border-color: #007bff;
            }

            .pagination .page-item.active .page-link {
                background-color: #007bff;
                border-color: #007bff;
            }
            .btn-reset {
                all: unset;           /* xóa mọi style mặc định của button */
                display: block;
                width: 100%;
                cursor: pointer;
            }

            /* đảm bảo thẻ card vẫn có hover như cũ (nếu cần) */
            .blog-card:hover {
                text-decoration: none;
            }
            .category-item {
                padding: 10px 14px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                color: #333;
                border-radius: 6px;
                transition: all 0.3s;
                font-size: 15px;
            }

            .category-item:hover {
                background-color: #f5faff;
                cursor: pointer;
            }

            /* Khi được chọn */
            .category-item.active {
                background: linear-gradient(to right, #e0f0ff, #f8fbff);
                border-left: 4px solid #0d6efd;
                font-weight: 600;
                color: #0d6efd;
                box-shadow: 0 2px 6px rgba(13, 110, 253, 0.1);
                position: relative;
            }

            /* Chấm tròn số lượng */
            .category-item .category-count {
                background-color: #dee9fb;
                color: #0d6efd;
                border-radius: 999px;
                padding: 2px 10px;
                font-size: 13px;
                font-weight: 500;
            }

            /* Khi active thì đổi màu count cho nổi bật */
            .category-item.active .category-count {
                background-color: #0d6efd;
                color: #fff;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .content-wrapper {
                    grid-template-columns: 1fr;
                    gap: 1rem;
                }

                .blog-card-horizontal {
                    grid-template-columns: 1fr;
                }

                .blog-thumbnail {
                    height: 200px;
                }

                .page-title {
                    font-size: 2rem;
                }

                .filter-buttons {
                    justify-content: center;
                }
            }

            /* Loading Animation */
            .loading {
                text-align: center;
                padding: 2rem;
                color: #6c757d;
            }

            .no-results {
                text-align: center;
                padding: 3rem;
                color: #6c757d;
            }
        </style>
    </head>

    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand" href="HomePage">
                    <i class="fas fa-briefcase"></i> JobHub
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="HomePage">Trang chủ</a>
                        </li>
<!--                        <li class="nav-item">
                            <a class="nav-link" href="#">Tìm việc làm</a>
                        </li>-->
<!--                        <li class="nav-item">
                            <a class="nav-link" href="#">Công ty</a>
                        </li>-->
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Tin tức</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Page Header -->
        <section class="page-header">
            <div class="container text-center">
                <h1 class="page-title">Blog & Tin tức</h1>
                <p class="page-subtitle">Cập nhật những thông tin mới nhất về thị trường việc làm và xu hướng nghề nghiệp</p>
            </div>
        </section>

        <!-- Main Content -->
        <div class="main-container">
            <div class="content-wrapper">
                <!-- Main Content -->
                <main>
                    <!-- Search & Filter -->
                    <div class="search-filter">
                        <form action="BlogListPage" method="POST">
                            <div class="row g-2">
                                <!-- Ô tìm kiếm + icon submit (kính lúp) -->
                                <div class="col-md-8 col-lg-8">
                                    <div class="input-group">
                                        <input type="text"
                                               name="keySearchListBlog" value="${keySearchListBlog}"
                                               class="form-control"
                                               placeholder="Tìm kiếm bài viết..."
                                               id="searchInput">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Dropdown sắp xếp + icon lọc (cái phễu) -->
                                <div class="col-md-4 col-lg-4" style="width: 30%;margin-left: 2%;">
                                    <div class="input-group">
                                        <select name="sortBlogList" class="form-select">
                                            <option value="">-- Sắp xếp theo--</option>
                                            <option value="publishedAsc"  ${sortBlogList == 'publishedAsc'  ? 'selected' : ''}>Ngày (cũ → mới)</option>
                                            <option value="publishedDesc" ${sortBlogList == 'publishedDesc' ? 'selected' : ''}>Ngày (mới → cũ)</option>
                                            <option value="titleAsc"      ${sortBlogList == 'titleAsc'      ? 'selected' : ''}>Tiêu đề (A → Z)</option>
                                            <option value="titleDesc"     ${sortBlogList == 'titleDesc'     ? 'selected' : ''}>Tiêu đề (Z → A)</option>
                                        </select>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-filter"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Blog List -->
                    <div class="blog-list" id="blogList">
                        <!-- Sample Blog Posts - Replace with real data from controller -->

                        <c:forEach var="blog" items="${blogList}">
                            <form action="viewBlogPost" method="POST" class="blog-card">
                                <!-- gởi id bằng input ẩn -->
                                <input type="hidden" name="blogPostId" value="${blog.getBlogId()}" />
                                <!-- nút submit chính là nguyên card -->
                                <button type="submit" class="blog-card btn-reset">
                                    <div class="blog-card-horizontal">
                                        <c:choose>
                                            <c:when test="${not empty blog.getThumbnailUrl()}">
                                                <img style="height: 200px; width: 300px;object-fit: contain;" src="${pageContext.request.contextPath}/${blog.getThumbnailUrl()}" 
                                                     alt="${blog.getTitle()}" class="blog-thumbnail">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="blog-thumbnail d-flex align-items-center justify-content-center">
                                                    <i class="fas fa-image fa-3x text-muted"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="blog-content">
                                            <div>
                                                <h3 class="blog-title">${blog.getTitle()}</h3>
                                                <p class="blog-summary">${blog.getSummary()}</p>
                                            </div>

                                            <div class="blog-meta">
                                                <div class="meta-left">
                                                    <div class="meta-item">
                                                        <i class="fas fa-calendar-alt"></i>
                                                        <span>${blog.getTimeAgo(blog.getPublishedAt())}</span>
                                                    </div>
                                                    <div class="meta-item">
                                                        <i class="fas fa-folder-open"></i>
                                                        <span>${blog.getCategory()}</span>
                                                    </div>
                                                </div>
                                                <span class="status-badge ${blog.isPublished ? 'status-published' : 'status-draft'}">
                                                    ${blog.isPublished ? 'Công khai' : 'Bản nháp'}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </button>
                            </form>
                        </c:forEach>
                        <%--
                                                <!-- Sample Data - Remove when you have real data -->
                                                <a href="${pageContext.request.contextPath}/blog/1" class="blog-card">
                                                    <div class="blog-card-horizontal">
                                                        <img src="/placeholder.svg?height=200&width=300" alt="Blog thumbnail" class="blog-thumbnail">
                                                        <div class="blog-content">
                                                            <div>
                                                                <h3 class="blog-title">Top 5 xu hướng AI năm 2025</h3>
                                                                <p class="blog-summary">Tổng hợp các xu hướng AI mới nhất và những ứng dụng thực tế trong các ngành nghề khác nhau. Khám phá cách AI đang thay đổi thị trường lao động...</p>
                                                            </div>
                                                            <div class="blog-meta">
                                                                <div class="meta-left">
                                                                    <div class="meta-item">
                                                                        <i class="fas fa-calendar-alt"></i>
                                                                        <span>2025-06-26</span>
                                                                    </div>
                                                                    <div class="meta-item">
                                                                        <i class="fas fa-folder-open"></i>
                                                                        <span>Công nghệ thông tin</span>
                                                                    </div>
                                                                </div>
                                                                <span class="status-badge status-published">Công khai</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>

                        <a href="${pageContext.request.contextPath}/blog/2" class="blog-card">
                            <div class="blog-card-horizontal">
                                <img src="/placeholder.svg?height=200&width=300" alt="Blog thumbnail" class="blog-thumbnail">
                                <div class="blog-content">
                                    <div>
                                        <h3 class="blog-title">Cách viết CV ấn tượng để thu hút nhà tuyển dụng</h3>
                                        <p class="blog-summary">Hướng dẫn chi tiết cách tạo một CV chuyên nghiệp, nổi bật trong hàng nghìn hồ sơ ứng tuyển. Bao gồm template và ví dụ thực tế...</p>
                                    </div>
                                    <div class="blog-meta">
                                        <div class="meta-left">
                                            <div class="meta-item">
                                                <i class="fas fa-calendar-alt"></i>
                                                <span>2024-12-20</span>
                                            </div>
                                            <div class="meta-item">
                                                <i class="fas fa-folder-open"></i>
                                                <span>Nghề nghiệp</span>
                                            </div>
                                        </div>
                                        <span class="status-badge status-published">Công khai</span>
                                    </div>
                                </div>
                            </div>
                        </a>

                        <a href="${pageContext.request.contextPath}/blog/3" class="blog-card">
                            <div class="blog-card-horizontal">
                                <img src="/placeholder.svg?height=200&width=300" alt="Blog thumbnail" class="blog-thumbnail">
                                <div class="blog-content">
                                    <div>
                                        <h3 class="blog-title">10 câu hỏi phỏng vấn thường gặp và cách trả lời</h3>
                                        <p class="blog-summary">Tổng hợp những câu hỏi phỏng vấn phổ biến nhất và gợi ý cách trả lời thông minh để gây ấn tượng với nhà tuyển dụng...</p>
                                    </div>
                                    <div class="blog-meta">
                                        <div class="meta-left">
                                            <div class="meta-item">
                                                <i class="fas fa-calendar-alt"></i>
                                                <span>2024-12-18</span>
                                            </div>
                                            <div class="meta-item">
                                                <i class="fas fa-folder-open"></i>
                                                <span>Phỏng vấn</span>
                                            </div>
                                        </div>
                                        <span class="status-badge status-published">Công khai</span>
                                    </div>
                                </div>
                            </div>
                        </a>

                        <a href="${pageContext.request.contextPath}/blog/4" class="blog-card">
                            <div class="blog-card-horizontal">
                                <img src="/placeholder.svg?height=200&width=300" alt="Blog thumbnail" class="blog-thumbnail">
                                <div class="blog-content">
                                    <div>
                                        <h3 class="blog-title">Xu hướng lương IT Việt Nam 2024</h3>
                                        <p class="blog-summary">Báo cáo chi tiết về mức lương các vị trí IT tại Việt Nam, xu hướng tăng trưởng và những kỹ năng được trả lương cao nhất...</p>
                                    </div>
                                    <div class="blog-meta">
                                        <div class="meta-left">
                                            <div class="meta-item">
                                                <i class="fas fa-calendar-alt"></i>
                                                <span>2024-12-15</span>
                                            </div>
                                            <div class="meta-item">
                                                <i class="fas fa-folder-open"></i>
                                                <span>Nghề nghiệp</span>
                                            </div>
                                        </div>
                                        <span class="status-badge status-draft">Bản nháp</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                        --%>
                    </div>

                    <!-- Pagination -->
                    <form action="BlogListPage" method="post">

                        <input type="hidden" name="keySearchListBlog" value="${keySearchListBlog}">
                        <input type="hidden" name="sortBlogList" value="${sortBlogList}">

                        <!-- giữ lại category đang chọn -->
                        <c:if test="${not empty categoryBlogPublish}">
                            <input type="hidden" name="categoryBlogPublish" value="${categoryBlogPublish}">
                        </c:if>
                        <nav aria-label="Page navigation">

                            <ul class="pagination justify-content-center" style="margin-top: 25px;">
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
                </main>

                <!-- Sidebar -->
                <aside class="sidebar">
                    <!-- Categories -->
                    <div class="sidebar-widget">
                        <h3 class="widget-title">
                            <i class="fas fa-folder"></i> Danh mục
                        </h3>
                        <div>
                            <!-- Lựa chọn “Tất cả” -->
                            <form action="BlogListPage" method="POST">
                                <input type="hidden" name="categoryBlogPublish" value="" />
                                <div class="category-item ${empty categoryBlogPublish ? 'active' : ''}"
                                     onclick="this.closest('form').submit()" style="cursor:pointer;">
                                    <span>Tất cả</span>
                                    <!-- Không cần hiển thị số đếm, bỏ span nếu muốn -->
                                </div>
                            </form>
                            <c:forEach var="a" items="${category}">
                                <form action="BlogListPage" method="POST">
                                    <input type="hidden" name="categoryBlogPublish" value="${a.getCategory()}" />
                                    <div class="category-item ${categoryBlogPublish == a.getCategory() ? 'active' : ''}" onclick="this.closest('form').submit()" style="cursor: pointer;">
                                        <span>${a.getCategory()}</span>
                                        <span class="category-count">${a.getAdminId()}</span>
                                    </div>
                                </form>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Recent Posts -->
                    <div class="sidebar-widget">
                        <h3 class="widget-title">
                            <i class="fas fa-clock"></i> Bài viết mới
                        </h3>
                        <div>
                            <c:forEach var="a" items="${blogListTop5}">
                                <form action="viewBlogPost" method="POST" class="recent-post-form">
                                    <input type="hidden" name="blogPostId" value="${a.getBlogId()}" />
                                    <div class="recent-post" onclick="this.closest('form').submit()" style="cursor: pointer;">
                                        <img style="height: 60px; width: 60px;object-fit: contain;" src="${a.getThumbnailUrl()}" alt="Recent post" class="recent-thumbnail">
                                        <div class="recent-content">
                                            <div class="recent-title">${a.getTitle()}</div>
                                            <div class="recent-date">${a.dateCreatAt()}</div>
                                        </div>
                                    </div>
                                </form>
                            </c:forEach>
                        </div>
                    </div>
                </aside>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>