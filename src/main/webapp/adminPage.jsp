<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.recruitment.dao.RecruiterDAO, com.recruitment.dao.CandidateDAO"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobHub - Admin General</title>
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

        .card {
            margin-bottom: 20px;
            text-align: center;
        }

        .card-title {
            font-size: 2rem;
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <%
        // Check if admin is logged in
        if (session.getAttribute("Admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch counts
        RecruiterDAO recruiterDAO = new RecruiterDAO();
        CandidateDAO candidateDAO = new CandidateDAO();

        int recruiterCount = recruiterDAO.getAllRecruiter().size();
        int candidateCount = candidateDAO.getAllCandidate().size();

    %>

    <!-- Include Left Navbar -->
    <%@include file="leftNavbar.jsp" %>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <h2>Tổng quan</h2>
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= recruiterCount %></h5>
                            <p class="card-text">Tổng số tài khoản nhà tuyển dụng</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= candidateCount %></h5>
                            <p class="card-text">Tổng số tài khoản ứng viên</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>