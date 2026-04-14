<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.recruitment.model.Recruiter, com.recruitment.model.Candidate, com.recruitment.model.Admin"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobHub - Manage Accounts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #007bff;
            --dark-color: #343a40;
            --light-gray: #f8f9fa;
            --sidebar-width: 250px;
        }
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 20px;
        }
        .table-responsive {
            margin-top: 20px;
        }
        .card {
            margin-bottom: 20px;
        }
        .nav-tabs .nav-link {
            color: var(--dark-color);
        }
        .nav-tabs .nav-link.active {
            background-color: var(--primary-color);
            color: white;
        }
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-form {
            max-width: 800px;
            display: flex;
            align-items: center;
        }
        .search-form select {
            max-width: 150px;
            margin-left: 10px;
        }
        .pagination {
            justify-content: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%
        // Check if admin is logged in
        if (session.getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }

        // Get attributes
        String tab = (String) request.getAttribute("tab");
        if (tab == null) {
            tab = "admin";
        }
        int pageNum = (Integer) request.getAttribute("page");
        int totalPages = (Integer) request.getAttribute("totalPages");
        String errorMessage = (String) session.getAttribute("errorMessage");
        String message = (String) session.getAttribute("message");
        String searchQuery = (String) request.getAttribute("search_query");
        String status = (String) request.getAttribute("status");
        status = status.trim();
        String app= (String) request.getAttribute("status");
        // Clear session message s after displaying
        session.removeAttribute("errorMessage");
        session.removeAttribute("message");
    %>

    <!-- Include Left Navbar -->
    <%@include file="leftNavbar.jsp" %>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <div class="header-actions">
                <h2>Quản lí tài khoản</h2>
                <form action="createAccount" method="get" style="display:inline;">
                    <button type="submit" class="btn btn-primary">Create Admin Account</button>
                </form>
            </div>

            <!-- Display Messages -->
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= errorMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            <% if (message != null) { %>
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <!-- Tabs -->
            <ul class="nav nav-tabs mb-3">
                <li class="nav-item">
                    <a class="nav-link <%= "admin".equals(tab) ? "active" : "" %>" 
                       href="manageAccount?tab=admin&page=1&status=">
                        Tài khoản Quản lý
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= "recruiter".equals(tab) ? "active" : "" %>" 
                       href="manageAccount?tab=recruiter&page=1&status=">
                        Tài khoản Doanh nghiệp
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= "candidate".equals(tab) ? "active" : "" %>" 
                       href="manageAccount?tab=candidate&page=1&status=">
                        Tài khoản Ứng viên
                    </a>
                </li>
            </ul>

            <!-- Tab Content -->
            <div class="tab-content">
                <!-- Admin Accounts -->
                <div class="tab-pane <%= "admin".equals(tab) ? "show active" : "" %>">
                    <div class="card">
                        <div class="card-header">
                            <h5>Tài khoản Quản lý/Admin</h5>
                        </div>
                        <div class="card-body">
                            <!-- Search Box -->
                            <form action="manageAccount" method="get" class="search-form mb-3">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="search_query" 
                                           placeholder="Tìm tên tài khoản" 
                                           value="<%= searchQuery != null && "admin".equals(tab) ? searchQuery : "" %>">
                                    <select name="status" class="form-select">
                                        <option value="" <%= status == null || "".equals(status) ? "selected" : "" %>>Tất cả trạng thái</option>
                                        <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Khả dụng</option>
                                        <option value="inactive" <%= "inactive".equals(status) ? "selected" : "" %>>Bị hạn chế</option>
                                    </select>

                                    <input type="hidden" name="tab" value="admin">
                                    <input type="hidden" name="page" value="1">
                                    <button type="submit" class="btn btn-primary">Tìm</button>
                                </div>
                            </form>
                            <% if ("admin".equals(tab)) { %>
                                <%@include file="adminTable.jsp" %>
                            <% } %>
                        </div>
                    </div>
                </div>

                <!-- Recruiter Accounts -->
                <div class="tab-pane <%= "recruiter".equals(tab) ? "show active" : "" %>">
                    <div class="card">
                        <div class="card-header">
                            <h5>Tài khoản doanh nghiệp</h5>
                        </div>
                        <div class="card-body">
                            <!-- Search Box -->
                            <form action="manageAccount" method="get" class="search-form mb-3">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="search_query" 
                                           placeholder="Tìm tên hoặc Email" 
                                           value="<%= searchQuery != null && "recruiter".equals(tab) ? searchQuery : "" %>">
                                    <select name="status" class="form-select">
                                        <option value="" <%= status == null || "".equals(status) ? "selected" : "" %>>All Status</option>
                                        <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Active</option>
                                        <option value="inactive" <%= "inactive".equals(status) ? "selected" : "" %>>Inactive</option>
                                    </select>
                                    <input type="hidden" name="tab" value="recruiter">
                                    <input type="hidden" name="page" value="1">
                                    <button type="submit" class="btn btn-primary">Tìm</button>
                                </div>
                            </form>
                            <% if ("recruiter".equals(tab)) { %>
                                <%@include file="recruiterTable.jsp" %>
                            <% } %>
                        </div>
                    </div>
                </div>

                <!-- Candidate Accounts -->
                <div class="tab-pane <%= "candidate".equals(tab) ? "show active" : "" %>">
                    <div class="card">
                        <div class="card-header">
                            <h5>Tài khoản ứng viên</h5>
                        </div>
                        <div class="card-body">
                            <!-- Search Box -->
                            <form action="manageAccount" method="get" class="search-form mb-3">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="search_query" 
                                           placeholder="Tìm tên hoặc Email" 
                                           value="<%= searchQuery != null && "candidate".equals(tab) ? searchQuery : "" %>">
                                    <select name="status" class="form-select">
                                        <option value="" <%= status == null || "".equals(status) ? "selected" : "" %>>All Status</option>
                                        <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Active</option>
                                        <option value="inactive" <%= "inactive".equals(status) ? "selected" : "" %>>Inactive</option>
                                    </select>
                                    <input type="hidden" name="tab" value="candidate">
                                    <input type="hidden" name="page" value="1">
                                    <button type="submit" class="btn btn-primary">Tìm</button>
                                </div>
                            </form>
                            <% if ("candidate".equals(tab)) { %>
                                <%@include file="candidateTable.jsp" %>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>