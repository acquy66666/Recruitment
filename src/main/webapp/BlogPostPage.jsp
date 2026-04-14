<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${blogInfo.title}</title>

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
            .main-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 1rem;
                background-color: transparent;
            }

            .content-wrapper {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 2rem;
                align-items: start;
            }

            /* Main Content */
            .blog-content {
                background: white;
                border-radius: 12px;
                padding: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border: 1px solid #e9ecef;
            }

            .blog-title {
                font-size: 2rem;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 1rem;
                line-height: 1.3;
            }

            .blog-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 1px solid #e9ecef;
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: #6c757d;
                font-size: 0.9rem;
            }

            .meta-item i {
                color: #007bff;
            }

            .status-badge {
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
            }

            .status-published {
                background-color: #d1ecf1;
                color: #0c5460;
                border: 1px solid #bee5eb;
            }

            .status-draft {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .blog-summary {
                background: #f8f9fa;
                border-left: 4px solid #007bff;
                padding: 1rem 1.5rem;
                margin: 1.5rem 0;
                font-style: italic;
                color: #495057;
                border-radius: 0 8px 8px 0;
            }

            .thumbnail {
                width: 100%;
                height: auto;
                border-radius: 8px;
                margin: 1.5rem 0;
            }

            #viewerjs {
                margin-top: 2rem;
            }

            /* Sidebar */
            .sidebar {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                position: sticky;
                top: 2rem;
                border: 1px solid #e9ecef;
            }

            .sidebar-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 1.5rem;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #007bff;
            }

            .related-post {
                display: block;
                text-decoration: none;
                color: inherit;
                padding: 1rem;
                border-radius: 8px;
                margin-bottom: 1rem;
                transition: all 0.3s ease;
                border: 1px solid #e9ecef;
            }

            .related-post:hover {
                background-color: #f8f9fa;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                text-decoration: none;
                color: inherit;
                border-color: #007bff;
            }

            .related-post-title {
                font-size: 1rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 0.5rem;
                line-height: 1.4;
            }

            .related-post-summary {
                font-size: 0.875rem;
                color: #6c757d;
                line-height: 1.4;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .related-post-meta {
                font-size: 0.75rem;
                color: #adb5bd;
                margin-top: 0.5rem;
            }
            .back-button {
                display: inline-flex;
                align-items: center;
                /*background-color: #f0f0f0;*/
                color: #333;
                padding: 8px 16px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .back-button:hover {
                background-color: #e0e0e0;
                color: #000;
            }
            .image-tool__image-picture {
                max-width: 50% !important;
                vertical-align: bottom;
                display: block;
            }
            /* Responsive */
            @media (max-width: 768px) {
                .content-wrapper {
                    grid-template-columns: 1fr;
                    gap: 1rem;
                }

                .blog-content,
                .sidebar {
                    padding: 1.5rem;
                }

                .blog-title {
                    font-size: 1.5rem;
                }

                .sidebar {
                    position: static;
                }
            }

            /* EditorJS Content Styling */
            #viewerjs h1, #viewerjs h2, #viewerjs h3 {
                color: #2c3e50;
                margin-top: 2rem;
                margin-bottom: 1rem;
            }

            #viewerjs p {
                margin-bottom: 1rem;
                color: #495057;
            }

            #viewerjs ul, #viewerjs ol {
                margin: 1rem 0;
                padding-left: 2rem;
            }

            #viewerjs blockquote {
                border-left: 4px solid #007bff;
                padding-left: 1rem;
                margin: 1.5rem 0;
                font-style: italic;
                color: #6c757d;
                background: #f8f9fa;
                padding: 1rem 1rem 1rem 2rem;
                border-radius: 0 8px 8px 0;
            }
        </style>

        <!-- EditorJS Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@2.29.1"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/paragraph@2.8.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/header@2.7.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/list@1.7.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/quote@2.5.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/delimiter@1.3.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/@editorjs/image@2.10.0"></script>
        <script src="https://cdn.jsdelivr.net/npm/editorjs-table-readonly@1.1.0/dist/bundle.min.js"></script>
        <script>
            const Table = window.Table;
        </script>
    </head>

    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand" href="#">
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
                        <li class="nav-item">
                            <a class="nav-link" href="#">Tìm việc làm</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Công ty</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Tin tức</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div style="display: flex; justify-content: end; margin-right: 10%; margin-top: 25px;margin-bottom: -5px;">
            <a href="javascript:history.back()" class="btn btn-primary">
                <i class="fas fa-arrow-left me-2"></i> Quay lại
            </a>
        </div>
        <div class="main-container">
            <div class="content-wrapper">
                <!-- Main Content -->
                <article class="blog-content">
                    <h1 class="blog-title">${blogInfo.title}</h1>

                    <div class="blog-meta">
                        <div class="meta-item">
                            <i class="fas fa-calendar-alt"></i>
                            <span>${blogInfo.getTimeAgo(blogInfo.getCreatedAt())}</span>
                        </div>

                        <div class="meta-item">
                            <i class="fas fa-folder-open"></i>
                            <span>${blogInfo.getCategory()}</span>
                        </div>

                        <span class="status-badge ${blogInfo.isPublished ? 'status-published' : 'status-draft'}">
                            ${blogInfo.isPublished ? 'Công khai' : 'Bản nháp'}
                        </span>
                    </div>

                    <c:if test="${not empty blogInfo.getSummary()}">
                        <div class="blog-summary">
                            <i class="fas fa-quote-left"></i>
                            ${blogInfo.getSummary()}
                        </div>
                    </c:if>

                    <c:if test="${not empty blogInfo.getThumbnailUrl()}">
                        <img src="${pageContext.request.contextPath}/${blogInfo.getThumbnailUrl()}"
                             alt="${blogInfo.title}"
                             class="thumbnail"/>
                    </c:if>

                    <div id="viewerjs"></div>
                </article>

                <!-- Sidebar -->
                <aside class="sidebar">
                    <h3 class="sidebar-title">
                        <i class="fas fa-newspaper"></i>
                        Bài viết liên quan
                    </h3>

                    <!-- Related Posts - Thay thế bằng dữ liệu thực từ controller -->

                    <c:forEach var="post" items="${relatedPosts}">
                        <div class="related-post">
                            <form action="viewBlogPost" method="POST" class="blog-card" onclick="this.submit()">
                                <!-- gởi id bằng input ẩn -->
                                <input type="hidden" name="blogPostId" value="${post.getBlogId()}" />
                                <div class="related-post-title">${post.getTitle()}</div>
                                <div class="related-post-summary">${post.getSummary()}</div>
                                <div class="related-post-meta">
                                    <i class="fas fa-calendar"></i> ${post.dateCreatAt()}
                                </div>
                            </form>
                        </div>
                    </c:forEach>

                    <!--                             Sample related posts - Remove this when you have real data 
                                                <a href="#" class="related-post">
                                                    <div class="related-post-title">Xu hướng công nghệ 2024</div>
                                                    <div class="related-post-summary">Tổng quan về những xu hướng công nghệ nổi bật trong năm 2024...</div>
                                                    <div class="related-post-meta">
                                                        <i class="fas fa-calendar"></i> 2024-12-20
                                                    </div>
                                                </a>
                    
                                                <a href="#" class="related-post">
                                                    <div class="related-post-title">Machine Learning cơ bản</div>
                                                    <div class="related-post-summary">Hướng dẫn từ A-Z về Machine Learning cho người mới bắt đầu...</div>
                                                    <div class="related-post-meta">
                                                        <i class="fas fa-calendar"></i> 2024-12-18
                                                    </div>
                                                </a>
                    
                                                <a href="#" class="related-post">
                                                    <div class="related-post-title">React vs Vue.js</div>
                                                    <div class="related-post-summary">So sánh chi tiết giữa hai framework phổ biến nhất hiện nay...</div>
                                                    <div class="related-post-meta">
                                                        <i class="fas fa-calendar"></i> 2024-12-15
                                                    </div>
                                                </a>
                    
                                                <a href="#" class="related-post">
                                                    <div class="related-post-title">DevOps Best Practices</div>
                                                    <div class="related-post-summary">Những thực hành tốt nhất trong DevOps mà mọi developer nên biết...</div>
                                                    <div class="related-post-meta">
                                                        <i class="fas fa-calendar"></i> 2024-12-12
                                                    </div>
                                                </a>
                    
                                                <a href="#" class="related-post">
                                                    <div class="related-post-title">Database Optimization</div>
                                                    <div class="related-post-summary">Cách tối ưu hóa database để cải thiện performance ứng dụng...</div>
                                                    <div class="related-post-meta">
                                                        <i class="fas fa-calendar"></i> 2024-12-10
                                                    </div>
                                                </a>-->
                </aside>
            </div>
        </div>

        <script>
            // Initialize EditorJS
            const contentData = ${blogInfo.getContentJson() != null ? blogInfo.getContentJson() : '{}'};

            new EditorJS({
                holder: 'viewerjs',
                readOnly: true,
                tools: {
                    header: Header,
                    paragraph: Paragraph,
                    list: List,
                    quote: Quote,
                    delimiter: Delimiter,
                    table: Table,
                    image: ImageTool
                },
                data: contentData
            });
        </script>
    </body>
</html>
