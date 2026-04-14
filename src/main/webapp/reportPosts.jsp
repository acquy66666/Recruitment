<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.recruitment.model.JobPost, java.util.List"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobHub - Report Job Posts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #007bff;
            --sidebar-width: 280px;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 20px;
        }

        .card {
            margin-bottom: 20px;
        }

        .alert-dismissible {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%
        // Check if user is authenticated
        if (session.getAttribute("Moderator") == null && session.getAttribute("Candidate") == null && session.getAttribute("Recruiter") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<JobPost> jobPosts = (List<JobPost>) session.getAttribute("jobPosts");
        Integer numPage = (Integer) session.getAttribute("num");
        Integer currentPage = (Integer) session.getAttribute("page");
        String keyword = (String) session.getAttribute("keyword");
        Boolean isModerator = (Boolean) session.getAttribute("isModerator");
        String message = (String) session.getAttribute("message");
        String error = (String) session.getAttribute("error");

        if (numPage == null) numPage = 1;
        if (currentPage == null) currentPage = 1;
    %>

    <!-- Include Left Navbar -->
    <%@include file="leftNavbar.jsp" %>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <h2>Báo cáo bài đăng</h2>

            <!-- Display Messages -->
            <% if (message != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("message"); %>
            <% } %>
            <% if (error != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("error"); %>
            <% } %>

            <!-- Search Form -->
            <form action="ReportPosts" method="get" class="mb-4">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm bài đăng..." value="<%= keyword != null ? keyword : "" %>">
                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                </div>
            </form>

            <!-- Job Posts Table -->
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tiêu đề</th>
                            <th>Nhà tuyển dụng</th>
                            <th>Ngày đăng</th>
                            <th>Trạng thái</th>
                            <% if (Boolean.TRUE.equals(isModerator)) { %>
                                <th>Hành động</th>
                            <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (jobPosts != null && !jobPosts.isEmpty()) { %>
                            <% for (JobPost post : jobPosts) { %>
                                <tr>
                                    <td><%= post.getJobId() %></td>
                                    <td><%= post.getTitle() %></td>
                                    <td><%= post.getRecruiterId() %></td>
                                    <td><%= post.getCreatedAt() %></td>
                                    <td><%= post.getStatus() %></td>
                                    <% if (Boolean.TRUE.equals(isModerator)) { %>
                                        <td>
                                            <form action="ReportPosts" method="post" style="display:inline;">
                                                <input type="hidden" name="jobId" value="<%= post.getJobId() %>">
                                                <input type="text" name="reason" class="form-control d-inline-block w-auto" placeholder="Lý do báo cáo" required>
                                                <button type="submit" class="btn btn-danger btn-sm">Báo cáo</button>
                                            </form>
                                        </td>
                                    <% } %>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="<%= Boolean.TRUE.equals(isModerator) ? 6 : 5 %>" class="text-center">Không tìm thấy bài đăng</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <% if (numPage > 1) { %>
                <nav>
                    <ul class="pagination">
                        <% for (int i = 1; i <= numPage; i++) { %>
                            <li class="page-item <%= i == currentPage ? "active" : "" %>">
                                <a class="page-link" href="ReportPosts?page=<%= i %><%= keyword != null ? "&keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8") : "" %>"><%= i %></a>
                            </li>
                        <% } %>
                    </ul>
                </nav>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>