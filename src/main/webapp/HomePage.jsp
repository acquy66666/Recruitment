<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JobHub - Nền tảng tuyển dụng hàng đầu Việt Nam</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
              rel="stylesheet">
        <style>
            :root {
                /* Màu chính giống VietnamWorks */
                --primary-color: #0046aa;
                --secondary-color: #ff6b00;
                --accent-color: #11cdef;
                --dark-color: #001e44;
                --light-color: #f7fafc;
                --danger-color: #f5365c;
                --warning-color: #fb6340;
                --info-color: #11cdef;
                --success-color: #2dce89;
            }

            body {
                font-family: 'Poppins', sans-serif;
                color: #525f7f;
                background-color: #f0f6ff;
            }

            .navbar-custom {
                /* background: linear-gradient(270deg, #69b3ff, #1e3fa6 73.72%); */
                background-color: #f0f6ff;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
                /* padding: 1rem 0; */
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
            }

            .nav-link {
                font-weight: 500;
                padding: 0.5rem 1rem !important;
                transition: all 0.2s;
            }

            .nav-link:hover {
                color: var(--primary-color) !important;
            }

            .btn {
                font-weight: 600;
                padding: 0.625rem 1.25rem;
                border-radius: 0.375rem;
                transition: all 0.15s ease;
                box-shadow: 0 4px 6px rgba(50, 50, 93, .11), 0 1px 3px rgba(0, 0, 0, .08);
            }

            .btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 7px 14px rgba(50, 50, 93, .1), 0 3px 6px rgba(0, 0, 0, .08);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #0051ff, #003ecb);
                transform: translateY(-2px);
            }

            .btn-secondary {
                /* background-color: var(--secondary-color);
                border-color: var(--secondary-color); */
                background: linear-gradient(135deg, #3a8fff, #0051ff);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 10px;
                font-weight: 600;
                box-shadow: 0 4px 12px rgba(0, 81, 255, 0.2);
                transition: all 0.3s ease;
            }

            .btn-secondary:hover {
                /* background-color: #e65c00;
                border-color: #e65c00; */
                background: linear-gradient(135deg, #0051ff, #003ecb);
                transform: translateY(-2px);
            }

            .btn-outline-primary {
                /* color: var(--primary-color);
                border-color: var(--primary-color); */
                background: white;
                color: #0051ff;
                border: 2px solid #0051ff;
                padding: 12px 24px;
                border-radius: 10px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                /* background-color: var(--primary-color);
                color: white; */
                background: #e6f0ff;
                transform: translateY(-2px);
                color: #0051ff;
            }

            /* Hero section - VietnamWorks style */
            .hero-section {
                background: linear-gradient(270deg, #69b3ff, #1e3fa6 73.72%);
                color: white;
                padding: 7rem 0;
                position: relative;
                overflow: hidden;
            }

            .hero-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('https://images.unsplash.com/photo-1551434678-e076c223a692?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
                background-size: cover;
                background-position: center;
                opacity: 0.05;
            }

            .hero-section .container {
                position: relative;
                z-index: 1;
            }

            .search-box {
                background-color: white;
                border-radius: 0.5rem;
                padding: 2rem;
                box-shadow: 0 15px 35px rgba(50, 50, 93, .1), 0 5px 15px rgba(0, 0, 0, .07);
                transform: translateY(0);
                transition: all 0.3s;
            }

            .search-box:hover {
                transform: translateY(-5px);
                box-shadow: 0 18px 35px rgba(50, 50, 93, .15), 0 8px 15px rgba(0, 0, 0, .1);
            }

            .input-group-text {
                background-color: transparent;
                border-right: none;
            }

            .form-control {
                border-left: none;
                padding: 0.75rem 1rem;
                font-size: 1rem;
            }

            .form-control:focus {
                box-shadow: none;
                border-color: #ced4da;
            }

            .form-select {
                padding: 0.75rem 1rem;
                font-size: 1rem;
                border-left: none;
            }

            .form-select:focus {
                box-shadow: none;
                border-color: #ced4da;
            }

            .badge {
                padding: 0.55em 0.9em;
                font-weight: 600;
                font-size: 0.75rem;
            }

            .badge-search {
                background-color: #f5f9fc;
                color: #8898aa;
                border-radius: 50rem;
                transition: all 0.2s;
                font-weight: 500;
            }

            .badge-search:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .section-title {
                margin-bottom: 3rem;
            }

            .section-title h2 {
                font-weight: 700;
                color: var(--dark-color);
                margin-bottom: 1rem;
            }

            .section-title p {
                color: #8898aa;
                font-size: 1.1rem;
            }

            .job-card {
                background-color: white;
                border-radius: 0.5rem;
                overflow: hidden;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
                transition: all 0.3s;
                border: none;
                margin-bottom: 1.5rem;
            }

            .job-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .job-card .card-body {
                padding: 1.5rem;
            }

            .company-logo {
                width: 4rem;
                height: 4rem;
                object-fit: contain;
                border-radius: 0.5rem;
                padding: 0.5rem;
                background-color: white;
                box-shadow: 0 0 1rem 0 rgba(136, 152, 170, .1);
            }

            .job-title {
                font-weight: 700;
                color: var(--dark-color);
                margin: 1rem 0 0.5rem;
                font-size: 1.25rem;
            }

            .company-name {
                color: #8898aa;
                font-weight: 500;
                margin-bottom: 1rem;
            }

            .job-meta {
                display: flex;
                margin-bottom: 1rem;
            }

            .job-meta-item {
                display: flex;
                align-items: center;
                margin-right: 1.5rem;
                color: #8898aa;
                font-size: 0.875rem;
            }

            .job-meta-item i {
                margin-right: 0.5rem;
                font-size: 1rem;
            }

            .job-tags {
                display: flex;
                flex-wrap: wrap;
                margin-bottom: 1rem;
            }

            .job-tag {
                background-color: #f5f9fc;
                color: #8898aa;
                border-radius: 50rem;
                padding: 0.35em 0.65em;
                font-size: 0.75rem;
                font-weight: 600;
                margin-right: 0.5rem;
                margin-bottom: 0.5rem;
            }

            .job-card-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-top: 1px solid #e9ecef;
                padding-top: 1rem;
            }

            .job-date {
                color: #8898aa;
                font-size: 0.875rem;
            }

            .category-card {
                background-color: white;
                border-radius: 0.5rem;
                overflow: hidden;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
                transition: all 0.3s;
                border: none;
                text-align: center;
                padding: 2rem;
                height: 100%;
            }

            .category-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .category-icon {
                width: 4rem;
                height: 4rem;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #f5f9fc;
                border-radius: 50%;
                margin: 0 auto 1.5rem;
                font-size: 1.75rem;
                color: var(--primary-color);
                transition: all 0.3s;
            }

            .category-card:hover .category-icon {
                background-color: var(--primary-color);
                color: white;
            }

            .category-title {
                font-weight: 700;
                color: var(--dark-color);
                margin-bottom: 0.5rem;
            }

            .category-count {
                color: #8898aa;
                font-size: 0.875rem;
                margin-bottom: 1.5rem;
            }

            .stats-section {
                background: linear-gradient(270deg, #69b3ff, #1e3fa6 73.72%);
                color: white;
                padding: 5rem 0;
                position: relative;
                overflow: hidden;
            }

            .stats-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
                background-size: cover;
                background-position: center;
                opacity: 0.05;
            }

            .stats-section .container {
                position: relative;
                z-index: 1;
            }

            .stat-card {
                background-color: rgba(255, 255, 255, 0.1);
                border-radius: 0.5rem;
                padding: 2rem;
                text-align: center;
                backdrop-filter: blur(10px);
                height: 100%;
            }

            .stat-number {
                font-size: 3rem;
                font-weight: 700;
                margin-bottom: 1rem;
                background: linear-gradient(to right, #fff, #d7dde8);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .stat-title {
                font-size: 1.1rem;
                font-weight: 500;
                color: rgba(255, 255, 255, 0.8);
            }

            .how-it-works {
                padding: 5rem 0;
                background-color: #f0f6ff;
            }

            .step-card {
                background-color: white;
                border-radius: 0.5rem;
                overflow: hidden;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
                transition: all 0.3s;
                border: none;
                text-align: center;
                padding: 2.5rem 2rem;
                height: 100%;
                position: relative;
            }

            .step-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .step-number {
                position: absolute;
                top: 1rem;
                right: 1rem;
                width: 2.5rem;
                height: 2.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: var(--primary-color);
                color: white;
                border-radius: 50%;
                font-weight: 700;
                font-size: 1.25rem;
            }

            .step-icon {
                width: 5rem;
                height: 5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #f5f9fc;
                border-radius: 50%;
                margin: 0 auto 1.5rem;
                font-size: 2rem;
                color: var(--primary-color);
                transition: all 0.3s;
            }

            .step-card:hover .step-icon {
                background-color: var(--primary-color);
                color: white;
            }

            .step-title {
                font-weight: 700;
                color: var(--dark-color);
                margin-bottom: 1rem;
                font-size: 1.25rem;
            }

            .step-description {
                color: #8898aa;
                margin-bottom: 0;
            }

            .testimonial-section {
                padding: 5rem 0;
                background-color: white;
            }

            .testimonial-card {
                background-color: white;
                border-radius: 0.5rem;
                overflow: hidden;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
                transition: all 0.3s;
                border: none;
                padding: 2rem;
                height: 100%;
                position: relative;
            }

            .testimonial-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .testimonial-card::before {
                content: '\201C';
                position: absolute;
                top: 1rem;
                left: 2rem;
                font-size: 5rem;
                color: #f5f9fc;
                font-family: serif;
                line-height: 1;
            }

            .testimonial-content {
                font-style: italic;
                color: #525f7f;
                margin-bottom: 1.5rem;
                position: relative;
                z-index: 1;
            }

            .testimonial-author {
                display: flex;
                align-items: center;
            }

            .testimonial-img {
                width: 3.5rem;
                height: 3.5rem;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 1rem;
                border: 3px solid #f5f9fc;
            }

            .testimonial-name {
                font-weight: 700;
                color: var(--dark-color);
                margin-bottom: 0.25rem;
            }

            .testimonial-position {
                color: #8898aa;
                font-size: 0.875rem;
            }

            .blog-section {
                padding: 5rem 0;
                background-color: #f8f9fe;
            }

            .blog-card {
                background-color: white;
                border-radius: 0.5rem;
                overflow: hidden;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
                transition: all 0.3s;
                border: none;
                height: 100%;
            }

            .blog-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .blog-img-container {
                height: 200px;
                overflow: hidden;
            }

            .blog-img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: all 0.5s;
            }

            .blog-card:hover .blog-img {
                transform: scale(1.1);
            }

            .blog-card .card-body {
                padding: 1.5rem;
            }

            .blog-category {
                display: inline-block;
                background-color: var(--primary-color);
                color: white;
                border-radius: 50rem;
                padding: 0.35em 0.65em;
                font-size: 0.75rem;
                font-weight: 600;
                margin-bottom: 1rem;
            }

            .blog-date {
                color: #8898aa;
                font-size: 0.875rem;
                margin-bottom: 0.5rem;
            }

            .blog-title {
                font-weight: 700;
                color: var(--dark-color);
                margin-bottom: 1rem;
                font-size: 1.25rem;
            }

            .blog-description {
                color: #525f7f;
                margin-bottom: 1.5rem;
            }

            .blog-link {
                color: var(--primary-color);
                font-weight: 600;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
            }

            .blog-link i {
                margin-left: 0.5rem;
                transition: all 0.2s;
            }

            .blog-link:hover i {
                transform: translateX(3px);
            }

            .employer-section {
                padding: 5rem 0;
                background-color: #f0f6ff;
            }

            .employer-card {
                background-color: white;
                border-radius: 0.5rem;
                overflow: hidden;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
                transition: all 0.3s;
                border: none;
                padding: 1.5rem;
                text-align: center;
                height: 100%;
            }

            .employer-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .175);
            }

            .employer-logo {
                height: 5rem;
                object-fit: contain;
                margin-bottom: 1rem;
                filter: grayscale(100%);
                opacity: 0.7;
                transition: all 0.3s;
            }

            .employer-card:hover .employer-logo {
                filter: grayscale(0%);
                opacity: 1;
            }

            .employer-name {
                font-weight: 700;
                color: var(--dark-color);
                margin-bottom: 0.5rem;
            }

            .employer-jobs {
                color: #8898aa;
                font-size: 0.875rem;
            }

            .app-section {
                padding: 5rem 0;
                background: linear-gradient(150deg, #5e72e4 15%, #825ee4 70%, #7551e9 94%);
                color: white;
                position: relative;
                overflow: hidden;
            }

            .app-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80');
                background-size: cover;
                background-position: center;
                opacity: 0.05;
            }

            .app-section .container {
                position: relative;
                z-index: 1;
            }

            .app-img {
                max-width: 100%;
                height: auto;
                filter: drop-shadow(0 1rem 3rem rgba(0, 0, 0, .3));
            }

            .app-badge {
                height: 3rem;
                margin-right: 1rem;
                margin-bottom: 1rem;
                transition: all 0.3s;
            }

            .app-badge:hover {
                transform: translateY(-3px);
            }

            .app-rating {
                display: flex;
                align-items: center;
                margin-bottom: 0.5rem;
            }

            .app-star {
                color: #ffd700;
                margin-right: 0.25rem;
            }

            .app-downloads {
                font-weight: 700;
                font-size: 1.1rem;
                margin-top: 1rem;
            }

            .newsletter-section {
                padding: 5rem 0;
                background-color: #f0f6ff;
            }

            .newsletter-card {
                background-color: white;
                border-radius: 0.5rem;
                overflow: hidden;
                box-shadow: 0 0 2rem 0 rgba(136, 152, 170, .15);
                padding: 3rem;
                text-align: center;
            }

            .newsletter-title {
                font-weight: 700;
                color: var(--dark-color);
                margin-bottom: 1rem;
                font-size: 1.75rem;
            }

            .newsletter-description {
                color: #8898aa;
                margin-bottom: 2rem;
                font-size: 1.1rem;
            }

            .newsletter-form {
                max-width: 500px;
                margin: 0 auto;
            }

            .newsletter-input {
                padding: 0.75rem 1.5rem;
                font-size: 1rem;
                border-radius: 50rem 0 0 50rem !important;
                border: 1px solid #e9ecef;
                border-right: none;
            }

            .newsletter-input:focus {
                box-shadow: none;
                border-color: #e9ecef;
            }

            .newsletter-button {
                padding: 0.75rem 1.5rem;
                font-size: 1rem;
                border-radius: 0 50rem 50rem 0 !important;
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                color: white;
            }

            .newsletter-button:hover {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                color: white;
            }

            .footer {
                background-color: #003366;
                color: white;
                padding: 5rem 0 2rem;
            }

            .footer-logo {
                font-weight: 700;
                font-size: 1.75rem;
                margin-bottom: 1.5rem;
                display: inline-block;
            }

            .footer-description {
                color: rgba(255, 255, 255, 0.6);
                margin-bottom: 2rem;
            }

            .social-icons {
                display: flex;
                margin-bottom: 2rem;
            }

            .social-icon {
                width: 2.5rem;
                height: 2.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                margin-right: 1rem;
                color: white;
                font-size: 1.25rem;
                transition: all 0.3s;
            }

            .social-icon:hover {
                background-color: var(--primary-color);
                transform: translateY(-3px);
            }

            .footer-title {
                font-weight: 700;
                color: white;
                margin-bottom: 1.5rem;
                font-size: 1.1rem;
            }

            .footer-links {
                list-style: none;
                padding-left: 0;
                margin-bottom: 2rem;
            }

            .footer-link {
                margin-bottom: 0.75rem;
            }

            .footer-link a {
                color: rgba(255, 255, 255, 0.6);
                text-decoration: none;
                transition: all 0.2s;
            }

            .footer-link a:hover {
                color: white;
                padding-left: 5px;
            }

            .footer-divider {
                border-color: rgba(255, 255, 255, 0.1);
                margin: 2rem 0;
            }

            .footer-bottom {
                color: rgba(255, 255, 255, 0.6);
                font-size: 0.875rem;
            }

            .footer-bottom a {
                color: white;
                text-decoration: none;
            }

            /* Animations */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .animate-fadeInUp {
                animation: fadeInUp 0.5s ease-out forwards;
            }

            /* Responsive adjustments */
            @media (max-width: 991.98px) {
                .hero-section {
                    padding: 5rem 0;
                }

                .search-box {
                    margin-top: 2rem;
                }

                .stat-number {
                    font-size: 2.5rem;
                }

                .app-img {
                    margin-top: 3rem;
                }
            }

            @media (max-width: 767.98px) {
                .section-title {
                    margin-bottom: 2rem;
                }

                .job-meta {
                    flex-wrap: wrap;
                }

                .job-meta-item {
                    margin-bottom: 0.5rem;
                }

                .newsletter-card {
                    padding: 2rem;
                }
            }
        </style>
    </head>

    <body>
        <% 
    boolean isLoggedIn = false;
    String role = null;
    if (session.getAttribute("Recruiter") != null) {
        isLoggedIn = true;
        role = "recruiter";
    } else if (session.getAttribute("Candidate") != null) {
        isLoggedIn = true;
        role = "candidate";
    } else if (session.getAttribute("Admin") != null) {
        isLoggedIn = true;
        role = "admin";
    } else if (session.getAttribute("Moderator") != null) {
        isLoggedIn = true;
        role = "moderator";
    }
    
        %>
        <!-- 1. Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
            <div class="container">
                <a class="navbar-brand" href="HomePage">
                    <span style="color: var(--primary-color);">Job</span><span style="color: var(--dark-color);">Hub</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <% if ("recruiter".equals(role)) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="RecruiterDashboard">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="buyServices">Các gói dịch vụ</a>
                        </li>
                        <% } else {%>
                         <li class="nav-item">
                            <a class="nav-link" href="CandidateDashboard">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="AdvancedJobSearch">Tìm việc làm</a>
                        </li>
                        <% } %>
                        
                        <li class="nav-item">
                            <a class="nav-link" href="BlogListPage">Trang Blog</a>
                        </li>
                        
                    </ul>
                    <div class="d-flex">
                        <!--                        <a href="RecruiterHomePage.jsp" class="btn btn-outline-primary me-2">Nhà tuyển dụng</a>-->

                        <% if (!isLoggedIn) { %>
                        <a href="ChooseRole.jsp" class="btn btn-outline-primary me-2">Đăng nhập</a>
                        <a href="register.jsp" class="btn btn-primary">Đăng ký</a>
                        <% } else { %>
                        <% if ("admin".equals(role)) { %>
                        <a href="adminPage.jsp" class="btn btn-primary me-2">Trang Admin</a>
                        <% } else if ("moderator".equals(role)) { %>
                        <a href="modPage.jsp" class="btn btn-primary me-2">Trang Moderator</a>
                        <% } else if ("recruiter".equals(role)) { %>
                        <a href="JobPostingPage" class="btn btn-primary me-2">Tạo bài đăng</a>
                        <a href="EditProfileRecruiter" class="btn btn-outline-primary me-2">Quản lí Profile</a>
                        <a href="CVFilter" class="btn btn-outline-primary me-2">Lọc CV</a>
                        <% } else if ("candidate".equals(role)) { %>
                        <a href="CandidateInterview" class="btn btn-primary me-2">Quản lý lịch phỏng vấn</a>
                        <a href="CandidateProfile" class="btn btn-outline-primary me-2">Quản lí Profile</a>
                        <a href="InterviewsCandidate" class="btn btn-outline-primary me-2">Lịch phỏng vấn</a>
                        <% } %>
                        <a href="#" class="btn btn-danger" onclick="return confirmLogout()">Đăng xuất</a>
                        <% } %>
                        <script>
                            // Confirmation dialog for logout
                            function confirmLogout() {
                                if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
                                    window.location.href = 'logout';
                                    return true;
                                }
                                return false;
                            }
                        </script>
                    </div>
                </div>
            </div>
        </nav>
        <!--            </div>
                </div>
            </nav>-->

        <!-- 2. Hero Section with Search -->
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 animate-fadeInUp" style="animation-delay: 0.1s;">
                        <h1 class="display-4 fw-bold mb-4">Khám phá công việc mơ ước của bạn</h1>
                        <p class="lead mb-5">Kết nối với hơn 50,000+ cơ hội việc làm từ các công ty hàng đầu tại Việt Nam.
                            Bắt đầu hành trình sự nghiệp mới ngay hôm nay!</p>
                        <div class="d-flex">
                            <a href="#" class="btn btn-light me-3">Tìm hiểu thêm</a>
                            <% if (!isLoggedIn) { %>
                            <a href="login.jsp" class="btn btn-secondary">Đăng tuyển dụng</a>
                            <% } else if ("recruiter".equals(role)) { %>
                            <a href="JobPostingPage" class="btn btn-secondary">Đăng tuyển dụng</a>
                            <% } else { %>
                            <a href="#" class="btn btn-secondary" onclick="alert('Chức năng này chỉ dành cho nhà tuyển dụng!')">Đăng tuyển dụng</a>
                            <% } %>
                        </div>
                    </div>
                    <div class="col-lg-6 animate-fadeInUp" style="animation-delay: 0.3s;">
                        <div class="search-box">
                            <h5 class="fw-bold mb-4 text-dark">Tìm kiếm việc làm</h5>
                            <form action="HomePage" method="post">
                                <div class="mb-3">
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                                        <input type="text" name="keyWord" value="${keyWord}" class="form-control" placeholder="Chức danh, kỹ năng, công ty, công việc">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-clock"></i></span>
                                        <!--<input type="text" name="jobType" class="form-control" placeholder="Position">-->
                                        <select class="form-select" name="jobType">
                                            <option value="" ${empty jobType ? 'selected' : ''}>Chọn loại công việc</option>
                                            <option value="Toàn thời gian" ${jobType == 'Toàn thời gian' ? 'selected' : ''}>Toàn thời gian</option>
                                            <option value="Bán thời gian" ${jobType == 'Bán thời gian' ? 'selected' : ''}>Bán thời gian</option>
                                            <option value="Hợp đồng" ${jobType == 'Hợp đồng' ? 'selected' : ''}>Hợp đồng</option>
                                            <option value="Tự do" ${jobType == 'Tự do' ? 'selected' : ''}>Tự do</option>
                                            <option value="Thực tập" ${jobType == 'Thực tập' ? 'selected' : ''}>Thực tập</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-briefcase"></i></span>
                                        <select class="form-select" name="experienceLevel">
                                            <option value="" ${empty experienceLevel ? 'selected' : ''}>Chọn cấp độ kinh nghiệm</option>
                                            <option value="Mới vào nghề (0-1 năm)" ${experienceLevel == 'Mới vào nghề (0-1 năm)' ? 'selected' : ''}>Mới vào nghề (0-1 năm)</option>
                                            <option value="Nhân viên sơ cấp (1-3 năm)" ${experienceLevel == 'Nhân viên sơ cấp (1-3 năm)' ? 'selected' : ''}>Nhân viên sơ cấp (1-3 năm)</option>
                                            <option value="Trung cấp (3-5 năm)" ${experienceLevel == 'Trung cấp (3-5 năm)' ? 'selected' : ''}>Trung cấp (3-5 năm)</option>
                                            <option value="Cao cấp (trên 5 năm)" ${experienceLevel == 'Cao cấp (trên 5 năm)' ? 'selected' : ''}>Cao cấp (trên 5 năm)</option>
                                            <option value="Quản lý" ${experienceLevel == 'Quản lý' ? 'selected' : ''}>Quản lý</option>
                                            <option value="Điều hành" ${experienceLevel == 'Điều hành' ? 'selected' : ''}>Điều hành</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                                        <select name="location"
                                                class="form-select block w-full max-w-sm p-2 border border-gray-300 rounded-md text-sm">
                                            <option value="" ${empty location ? 'selected' : ''}>-- Chọn tỉnh/thành phố --</option>

                                            <!-- Thành phố -->
                                            <option value="Hà Nội" ${location == 'Hà Nội' ? 'selected' : ''}>Thành phố Hà Nội</option>
                                            <option value="Hồ Chí Minh" ${location == 'Hồ Chí Minh' ? 'selected' : ''}>Thành phố Hồ Chí Minh</option>
                                            <option value="Đà Nẵng" ${location == 'Đà Nẵng' ? 'selected' : ''}>Thành phố Đà Nẵng</option>
                                            <option value="Hải Phòng" ${location == 'Hải Phòng' ? 'selected' : ''}>Thành phố Hải Phòng</option>
                                            <option value="Cần Thơ" ${location == 'Cần Thơ' ? 'selected' : ''}>Thành phố Cần Thơ</option>
                                            <option value="Huế" ${location == 'Huế' ? 'selected' : ''}>Thành phố Huế</option>

                                            <!-- Tỉnh -->
                                            <option value="Lai Châu" ${location == 'Lai Châu' ? 'selected' : ''}>Tỉnh Lai Châu</option>
                                            <option value="Điện Biên" ${location == 'Điện Biên' ? 'selected' : ''}>Tỉnh Điện Biên</option>
                                            <option value="Sơn La" ${location == 'Sơn La' ? 'selected' : ''}>Tỉnh Sơn La</option>
                                            <option value="Lạng Sơn" ${location == 'Lạng Sơn' ? 'selected' : ''}>Tỉnh Lạng Sơn</option>
                                            <option value="Quảng Ninh" ${location == 'Quảng Ninh' ? 'selected' : ''}>Tỉnh Quảng Ninh</option>
                                            <option value="Thanh Hoá" ${location == 'Thanh Hoá' ? 'selected' : ''}>Tỉnh Thanh Hoá</option>
                                            <option value="Nghệ An" ${location == 'Nghệ An' ? 'selected' : ''}>Tỉnh Nghệ An</option>
                                            <option value="Hà Tĩnh" ${location == 'Hà Tĩnh' ? 'selected' : ''}>Tỉnh Hà Tĩnh</option>
                                            <option value="Cao Bằng" ${location == 'Cao Bằng' ? 'selected' : ''}>Tỉnh Cao Bằng</option>
                                            <option value="Tuyên Quang" ${location == 'Tuyên Quang' ? 'selected' : ''}>Tỉnh Tuyên Quang</option>
                                            <option value="Lào Cai" ${location == 'Lào Cai' ? 'selected' : ''}>Tỉnh Lào Cai</option>
                                            <option value="Thái Nguyên" ${location == 'Thái Nguyên' ? 'selected' : ''}>Tỉnh Thái Nguyên</option>
                                            <option value="Phú Thọ" ${location == 'Phú Thọ' ? 'selected' : ''}>Tỉnh Phú Thọ</option>
                                            <option value="Bắc Ninh" ${location == 'Bắc Ninh' ? 'selected' : ''}>Tỉnh Bắc Ninh</option>
                                            <option value="Hưng Yên" ${location == 'Hưng Yên' ? 'selected' : ''}>Tỉnh Hưng Yên</option>
                                            <option value="Ninh Bình" ${location == 'Ninh Bình' ? 'selected' : ''}>Tỉnh Ninh Bình</option>
                                            <option value="Quảng Trị" ${location == 'Quảng Trị' ? 'selected' : ''}>Tỉnh Quảng Trị</option>
                                            <option value="Quảng Ngãi" ${location == 'Quảng Ngãi' ? 'selected' : ''}>Tỉnh Quảng Ngãi</option>
                                            <option value="Gia Lai" ${location == 'Gia Lai' ? 'selected' : ''}>Tỉnh Gia Lai</option>
                                            <option value="Khánh Hoà" ${location == 'Khánh Hoà' ? 'selected' : ''}>Tỉnh Khánh Hoà</option>
                                            <option value="Lâm Đồng" ${location == 'Lâm Đồng' ? 'selected' : ''}>Tỉnh Lâm Đồng</option>
                                            <option value="Đắk Lắk" ${location == 'Đắk Lắk' ? 'selected' : ''}>Tỉnh Đắk Lắk</option>
                                            <option value="Đồng Nai" ${location == 'Đồng Nai' ? 'selected' : ''}>Tỉnh Đồng Nai</option>
                                            <option value="Tây Ninh" ${location == 'Tây Ninh' ? 'selected' : ''}>Tỉnh Tây Ninh</option>
                                            <option value="Vĩnh Long" ${location == 'Vĩnh Long' ? 'selected' : ''}>Tỉnh Vĩnh Long</option>
                                            <option value="Đồng Tháp" ${location == 'Đồng Tháp' ? 'selected' : ''}>Tỉnh Đồng Tháp</option>
                                            <option value="Cà Mau" ${location == 'Cà Mau' ? 'selected' : ''}>Tỉnh Cà Mau</option>
                                            <option value="Kiên Giang" ${location == 'Kiên Giang' ? 'selected' : ''}>Tỉnh Kiên Giang</option>
                                        </select>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                            </form>

                            <div class="mt-3">
                                <span class="me-2 text-muted small">Tìm kiếm phổ biến:</span>
                                <a href="#" class="badge badge-search text-decoration-none me-2 mb-2">IT & Phần mềm</a>
                                <a href="#" class="badge badge-search text-decoration-none me-2 mb-2">Marketing</a>
                                <a href="#" class="badge badge-search text-decoration-none me-2 mb-2">Kế toán</a>
                                <a href="#" class="badge badge-search text-decoration-none me-2 mb-2">Kinh doanh</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Bonus. Featured Job Search -->
        <c:if test="${not empty listJobPostSearch}">
            <section class="py-5">
                <div class="container">
                    <div class="row" style="margin-bottom: -2rem;">
                        <div class="col-lg-8 mx-auto text-center section-title">
                            <h2>Việc làm tìm kiếm</h2>
                            <p>Khám phá các cơ hội việc làm hấp dẫn từ các công ty hàng đầu</p>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach var="a" items="${listJobPostSearch}">
                            <div class="col-md-6 col-lg-4 animate-fadeInUp" style="animation-delay: 0.1s;">
                                <div class="job-card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <img src="${a.getRecruiter().getCompanyLogoUrl()}" alt="FPT" class="company-logo">
                                            <span class="badge bg-success">${a.getJobType()}</span>
                                        </div>
                                        <h5 class="job-title">${a.getTitle()}</h5>
                                        <p class="company-name">${a.getRecruiter().getCompanyName()}</p>
                                        <div class="job-meta">
                                            <div class="job-meta-item">
                                                <i class="bi bi-geo-alt"></i>
                                                <span>${a.getRecruiter().getCompanyAddress()}</span>
                                            </div>
                                            <div class="job-meta-item">
                                                <i class="bi bi-currency-dollar"></i>
                                                <span>${a.getFormattedSalaryMin()} - ${a.getFormattedSalaryMax()} đ</span>
                                            </div>
                                        </div>
                                        <div class="job-tags">
                                            <span class="job-tag">${a.getExperienceLevel()}</span>
                                            <!--                                    <span class="job-tag">JavaScript</span>
                                                                                <span class="job-tag">TypeScript</span>-->
                                        </div>
                                        <div class="job-card-footer">
                                            <span class="job-date">${a.getTimeAgo()}</span>
                                            <a href="CandidateJobDetail?jobID=${a.jobId}" class="btn btn-sm btn-outline-primary">Ứng tuyển</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>              
                    </div>
                </div>
            </section>
        </c:if>
        <!-- 3.1. Featured All Job -->
        <section class="py-5">
            <div class="container">
                <div class="row" style="margin-bottom: -2rem;">
                    <div class="col-lg-8 mx-auto text-center section-title">
                        <h2>Tất cả việc làm </h2>
                        <p>Khám phá các cơ hội việc làm hấp dẫn từ các công ty hàng đầu</p>
                    </div>
                </div>
                <div class="row" id="job-list">
                    <c:forEach var="a" items="${listJobPost}" varStatus="status">
                        <div class="col-md-6 col-lg-4 animate-fadeInUp job-item"
                             style="${status.index >= 6 ? 'display:none;' : ''}">
                            <div class="job-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <img src="${a.getRecruiter().getCompanyLogoUrl()}" alt="logo" class="company-logo">
                                        <span class="badge bg-success">${a.getJobType()}</span>
                                    </div>
                                    <h5 class="job-title">${a.getTitle()}</h5>
                                    <p class="company-name">${a.getRecruiter().getCompanyName()}</p>
                                    <div class="job-meta">
                                        <div class="job-meta-item"><i class="bi bi-geo-alt"></i> <span>${a.getRecruiter().getCompanyAddress()}</span></div>
                                        <div class="job-meta-item"><i class="bi bi-currency-dollar"></i> <span>${a.getFormattedSalaryMin()} - ${a.getFormattedSalaryMax()} đ</span></div>
                                    </div>
                                    <div class="job-tags"><span class="job-tag">${a.getExperienceLevel()}</span></div>
                                    <div class="job-card-footer">
                                        <span class="job-date">${a.getTimeAgo()}</span>
                                        <a href="CandidateJobDetail?jobID=${a.jobId}" class="btn btn-sm btn-outline-primary">Ứng tuyển</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="row mt-4">
                    <div class="col-12 text-center">
                        <button id="loadMoreBtn" class="btn btn-outline-primary">Xem thêm việc làm <i class="bi bi-arrow-down"></i></button>
                    </div>
                </div>

            </div>
        </section>





        <!--         4. Job Categories 
                <section class="py-5">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-8 mx-auto text-center section-title">
                                <h2>Khám phá theo ngành nghề</h2>
                                <p>Tìm kiếm công việc phù hợp với chuyên môn của bạn</p>
                            </div>
                        </div>
                        <div class="row g-4">
                            <div class="col-md-6 col-lg-3 animate-fadeInUp" style="animation-delay: 0.1s;">
                                <div class="category-card">
                                    <div class="category-icon">
                                        <i class="bi bi-code-slash"></i>
                                    </div>
                                    <h5 class="category-title">IT & Phần mềm</h5>
                                    <p class="category-count">12,568 việc làm</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Xem việc làm</a>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-3 animate-fadeInUp" style="animation-delay: 0.2s;">
                                <div class="category-card">
                                    <div class="category-icon">
                                        <i class="bi bi-graph-up"></i>
                                    </div>
                                    <h5 class="category-title">Marketing & Sales</h5>
                                    <p class="category-count">8,942 việc làm</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Xem việc làm</a>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-3 animate-fadeInUp" style="animation-delay: 0.3s;">
                                <div class="category-card">
                                    <div class="category-icon">
                                        <i class="bi bi-bank"></i>
                                    </div>
                                    <h5 class="category-title">Tài chính & Ngân hàng</h5>
                                    <p class="category-count">6,234 việc làm</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Xem việc làm</a>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-3 animate-fadeInUp" style="animation-delay: 0.4s;">
                                <div class="category-card">
                                    <div class="category-icon">
                                        <i class="bi bi-building"></i>
                                    </div>
                                    <h5 class="category-title">Hành chính & Nhân sự</h5>
                                    <p class="category-count">5,127 việc làm</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Xem việc làm</a>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-3 animate-fadeInUp" style="animation-delay: 0.5s;">
                                <div class="category-card">
                                    <div class="category-icon">
                                        <i class="bi bi-palette"></i>
                                    </div>
                                    <h5 class="category-title">Thiết kế & Sáng tạo</h5>
                                    <p class="category-count">3,856 việc làm</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Xem việc làm</a>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-3 animate-fadeInUp" style="animation-delay: 0.6s;">
                                <div class="category-card">
                                    <div class="category-icon">
                                        <i class="bi bi-truck"></i>
                                    </div>
                                    <h5 class="category-title">Logistics & Vận tải</h5>
                                    <p class="category-count">2,743 việc làm</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Xem việc làm</a>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-3 animate-fadeInUp" style="animation-delay: 0.7s;">
                                <div class="category-card">
                                    <div class="category-icon">
                                        <i class="bi bi-translate"></i>
                                    </div>
                                    <h5 class="category-title">Giáo dục & Đào tạo</h5>
                                    <p class="category-count">4,129 việc làm</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Xem việc làm</a>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-3 animate-fadeInUp" style="animation-delay: 0.8s;">
                                <div class="category-card">
                                    <div class="category-icon">
                                        <i class="bi bi-heart-pulse"></i>
                                    </div>
                                    <h5 class="category-title">Y tế & Dược phẩm</h5>
                                    <p class="category-count">3,218 việc làm</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Xem việc làm</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>-->

        <!-- 5. Top Employers -->
        <section class="employer-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto text-center section-title">
                        <h2>Nhà tuyển dụng hàng đầu</h2>
                        <p>Khám phá cơ hội nghề nghiệp tại các công ty uy tín</p>
                    </div>
                </div>
                <div class="row g-4">
                    <c:forEach var="a" items="${companyList}">
                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 0.1s;">
                            <div class="employer-card">
                                <img src="${a.getCompanyLogoUrl()}" alt="Image" class="employer-logo">
                                <h6 class="employer-name">${a.getCompanyName()}</h6>
                                <p class="employer-jobs">${a.getCompanyAddress()}</p>
                            </div>
                        </div>
                    </c:forEach>
                    <!--                    <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 0.2s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/vng.com.vn" alt="VNG" class="employer-logo">
                                                <h6 class="employer-name">VNG Corporation</h6>
                                                <p class="employer-jobs">98 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 0.3s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/vingroup.net" alt="Vingroup" class="employer-logo">
                                                <h6 class="employer-name">Vingroup</h6>
                                                <p class="employer-jobs">124 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 0.4s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/tiki.vn" alt="Tiki" class="employer-logo">
                                                <h6 class="employer-name">Tiki Corporation</h6>
                                                <p class="employer-jobs">87 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 0.5s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/momo.vn" alt="MoMo" class="employer-logo">
                                                <h6 class="employer-name">MoMo</h6>
                                                <p class="employer-jobs">76 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 0.6s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/grab.com" alt="Grab" class="employer-logo">
                                                <h6 class="employer-name">Grab</h6>
                                                <p class="employer-jobs">92 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 0.7s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/samsung.com" alt="Samsung" class="employer-logo">
                                                <h6 class="employer-name">Samsung Vietnam</h6>
                                                <p class="employer-jobs">112 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 0.8s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/intel.com" alt="Intel" class="employer-logo">
                                                <h6 class="employer-name">Intel Vietnam</h6>
                                                <p class="employer-jobs">68 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 0.9s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/techcombank.com.vn" alt="Techcombank" class="employer-logo">
                                                <h6 class="employer-name">Techcombank</h6>
                                                <p class="employer-jobs">83 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 1s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/viettel.com.vn" alt="Viettel" class="employer-logo">
                                                <h6 class="employer-name">Viettel Group</h6>
                                                <p class="employer-jobs">145 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 1.1s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/lazada.vn" alt="Lazada" class="employer-logo">
                                                <h6 class="employer-name">Lazada Vietnam</h6>
                                                <p class="employer-jobs">74 việc làm</p>
                                            </div>
                                        </div>
                                        <div class="col-6 col-md-4 col-lg-2 animate-fadeInUp" style="animation-delay: 1.2s;">
                                            <div class="employer-card">
                                                <img src="https://logo.clearbit.com/shopee.vn" alt="Shopee" class="employer-logo">
                                                <h6 class="employer-name">Shopee Vietnam</h6>
                                                <p class="employer-jobs">89 việc làm</p>
                                            </div>
                                        </div>-->
                </div>
                <div class="row mt-4">
                    <div class="col-12 text-center">
                        <a href="#" class="btn btn-outline-primary">Xem tất cả công ty <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>
            </div>
        </section>

        <!-- 6. Statistics Section -->
        <section class="stats-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto text-center mb-5">
                        <h2 class="fw-bold text-white">JobHub trong con số</h2>
                        <p class="text-white-50">Chúng tôi kết nối hàng nghìn ứng viên với nhà tuyển dụng mỗi ngày</p>
                    </div>
                </div>
                <div class="row g-4">
                    <div class="col-md-3 animate-fadeInUp" style="animation-delay: 0.1s;">
                        <div class="stat-card">
                            <div class="stat-number">2.5M+</div>
                            <div class="stat-title">Ứng viên</div>
                        </div>
                    </div>
                    <div class="col-md-3 animate-fadeInUp" style="animation-delay: 0.2s;">
                        <div class="stat-card">
                            <div class="stat-number">50K+</div>
                            <div class="stat-title">Việc làm đang tuyển</div>
                        </div>
                    </div>
                    <div class="col-md-3 animate-fadeInUp" style="animation-delay: 0.3s;">
                        <div class="stat-card">
                            <div class="stat-number">10K+</div>
                            <div class="stat-title">Công ty đối tác</div>
                        </div>
                    </div>
                    <div class="col-md-3 animate-fadeInUp" style="animation-delay: 0.4s;">
                        <div class="stat-card">
                            <div class="stat-number">95%</div>
                            <div class="stat-title">Tỷ lệ hài lòng</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 7. How It Works -->
        <section class="how-it-works">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto text-center section-title">
                        <h2>Cách thức hoạt động</h2>
                        <p>Tìm việc làm mơ ước chỉ với 3 bước đơn giản</p>
                    </div>
                </div>
                <div class="row g-4">
                    <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.1s;">
                        <div class="step-card">
                            <div class="step-number">1</div>
                            <div class="step-icon">
                                <i class="bi bi-person-plus"></i>
                            </div>
                            <h4 class="step-title">Tạo hồ sơ</h4>
                            <p class="step-description">Tạo hồ sơ chuyên nghiệp với CV nổi bật để thu hút nhà tuyển dụng</p>
                        </div>
                    </div>
                    <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.2s;">
                        <div class="step-card">
                            <div class="step-number">2</div>
                            <div class="step-icon">
                                <i class="bi bi-search"></i>
                            </div>
                            <h4 class="step-title">Tìm việc làm</h4>
                            <p class="step-description">Tìm kiếm và ứng tuyển vào các vị trí phù hợp với kỹ năng của bạn</p>
                        </div>
                    </div>
                    <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.3s;">
                        <div class="step-card">
                            <div class="step-number">3</div>
                            <div class="step-icon">
                                <i class="bi bi-briefcase"></i>
                            </div>
                            <h4 class="step-title">Nhận việc làm</h4>
                            <p class="step-description">Nhận phỏng vấn và bắt đầu sự nghiệp mới tại công ty mơ ước</p>
                        </div>
                    </div>
                </div>
                <!--                <div class="row mt-5">
                                    <div class="col-12 text-center">
                                        <a href="#" class="btn btn-primary">Bắt đầu ngay</a>
                                    </div>
                                </div>-->
            </div>
        </section>

        <!-- 8. Testimonials -->
        <section class="testimonial-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto text-center section-title">
                        <h2>Ứng viên nói gì về chúng tôi</h2>
                        <p>Khám phá câu chuyện thành công từ những người đã tìm được công việc mơ ước</p>
                    </div>
                </div>
                <div class="row g-4">
                    <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.1s;">
                        <div class="testimonial-card">
                            <p class="testimonial-content">"Tôi đã tìm được công việc mơ ước chỉ sau 2 tuần đăng ký tài
                                khoản tại JobHub. Giao diện dễ sử dụng và các công cụ tìm kiếm thông minh giúp tôi nhanh
                                chóng kết nối với nhà tuyển dụng phù hợp."</p>
                            <div class="testimonial-author">
                                <img src="https://randomuser.me/api/portraits/women/32.jpg" alt="Nguyễn Thị Mai"
                                     class="testimonial-img">
                                <div>
                                    <h5 class="testimonial-name">Nguyễn Thị Mai</h5>
                                    <p class="testimonial-position">Frontend Developer tại FPT Software</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.2s;">
                        <div class="testimonial-card">
                            <p class="testimonial-content">"JobHub không chỉ giúp tôi tìm được công việc mà còn cung cấp
                                nhiều tài liệu hữu ích để chuẩn bị cho phỏng vấn. Nhờ đó, tôi đã tự tin và thành công trong
                                buổi phỏng vấn tại Tiki."</p>
                            <div class="testimonial-author">
                                <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Trần Văn Hùng"
                                     class="testimonial-img">
                                <div>
                                    <h5 class="testimonial-name">Trần Văn Hùng</h5>
                                    <p class="testimonial-position">Product Manager tại Tiki</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.3s;">
                        <div class="testimonial-card">
                            <p class="testimonial-content">"Sau nhiều năm làm việc, tôi muốn tìm cơ hội mới để phát triển sự
                                nghiệp. JobHub đã giúp tôi kết nối với VNG và tôi đã có bước tiến lớn trong sự nghiệp của
                                mình. Cảm ơn JobHub!"</p>
                            <div class="testimonial-author">
                                <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="Lê Thị Hương"
                                     class="testimonial-img">
                                <div>
                                    <h5 class="testimonial-name">Lê Thị Hương</h5>
                                    <p class="testimonial-position">Marketing Manager tại VNG</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 9. Blog Section -->
        <section class="blog-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto text-center section-title">
                        <h2>Tin tức & Hướng dẫn</h2>
                        <p>Cập nhật thông tin thị trường lao động và mẹo tìm việc</p>
                    </div>
                </div>
                <div class="row g-4">
                    <c:forEach var="blog" items="${listBlogHomePage}">
                        <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.1s;">
                            <div class="blog-card">
                                <div class="blog-img-container">
                                    <img src="${pageContext.request.contextPath}/${blog.getThumbnailUrl()}"
                                         alt="Blog Image" class="blog-img">
                                </div>
                                <div class="card-body">
                                    <span class="blog-category">${blog.getCategory()}</span>
                                    <p class="blog-date">
                                        <i class="bi bi-calendar-event me-2"></i>
                                        ${blog.getTimeAgo(blog.getPublishedAt())}
                                    </p>
                                    <h5 class="blog-title">${blog.getTitle()}</h5>
                                    <p class="blog-description">${blog.getSummary()}</p>

                                    <!-- FORM ẩn gửi blogId -->
                                    <form action="viewBlogPost" method="POST">
                                        <input type="hidden" name="blogPostId" value="${blog.getBlogId()}"/>
                                        <button type="submit" class="blog-link btn btn-link p-0" style="text-decoration: none;">
                                            Đọc thêm <i class="bi bi-arrow-right"></i>
                                        </button>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <!--                    <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.2s;">
                                            <div class="blog-card">
                                                <div class="blog-img-container">
                                                    <img src="https://images.unsplash.com/photo-1573497491765-dccce02b29df?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"
                                                         alt="Blog Image" class="blog-img">
                                                </div>
                                                <div class="card-body">
                                                    <span class="blog-category">Thị trường</span>
                                                    <p class="blog-date"><i class="bi bi-calendar-event me-2"></i>10/05/2023</p>
                                                    <h5 class="blog-title">Xu hướng tuyển dụng tại Việt Nam nửa đầu năm 2023</h5>
                                                    <p class="blog-description">Phân tích chi tiết về tình hình tuyển dụng và các ngành nghề
                                                        đang có nhu cầu cao tại thị trường Việt Nam.</p>
                                                    <a href="#" class="blog-link">Đọc thêm <i class="bi bi-arrow-right"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.3s;">
                                            <div class="blog-card">
                                                <div class="blog-img-container">
                                                    <img src="https://images.unsplash.com/photo-1553877522-43269d4ea984?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"
                                                         alt="Blog Image" class="blog-img">
                                                </div>
                                                <div class="card-body">
                                                    <span class="blog-category">Mẹo phỏng vấn</span>
                                                    <p class="blog-date"><i class="bi bi-calendar-event me-2"></i>05/05/2023</p>
                                                    <h5 class="blog-title">5 cách trả lời câu hỏi phỏng vấn khó nhất</h5>
                                                    <p class="blog-description">Những mẹo hữu ích giúp bạn tự tin đối mặt với những câu hỏi khó
                                                        trong buổi phỏng vấn và gây ấn tượng với nhà tuyển dụng.</p>
                                                    <a href="#" class="blog-link">Đọc thêm <i class="bi bi-arrow-right"></i></a>
                                                </div>
                                            </div>
                                        </div>-->
                </div>
                <div class="row mt-4">
                    <div class="col-12 text-center">
                        <a href="#" class="btn btn-outline-primary">Xem tất cả bài viết <i
                                class="bi bi-arrow-right"></i></a>
                    </div>
                </div>
            </div>
        </section>

        <!--         10. Career Development Tools (Thay thế cho Mobile App Section) 
                <section class="py-5"
                         style="background: linear-gradient(270deg, #69b3ff, #1e3fa6 73.72%)   ; color: white; position: relative; overflow: hidden;">
                    <div class="container position-relative" style="z-index: 1;">
                        <div class="row">
                            <div class="col-lg-8 mx-auto text-center mb-5">
                                <h2 class="fw-bold text-white">Công cụ phát triển sự nghiệp</h2>
                                <p class="text-white-50">Các công cụ chuyên nghiệp giúp bạn xây dựng và phát triển sự nghiệp</p>
                            </div>
                        </div>
                        <div class="row g-4">
                            <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.1s;">
                                <div
                                    style="background-color: rgba(255, 255, 255, 0.1); border-radius: 0.5rem; padding: 2rem; text-align: center; height: 100%; backdrop-filter: blur(10px);">
                                    <div
                                        style="width: 5rem; height: 5rem; display: flex; align-items: center; justify-content: center; background-color: rgba(255, 255, 255, 0.2); border-radius: 50%; margin: 0 auto 1.5rem; font-size: 2rem; color: white;">
                                        <i class="bi bi-file-earmark-text"></i>
                                    </div>
                                    <h4 class="fw-bold mb-3">CV Builder</h4>
                                    <p class="mb-4 text-white-50">Tạo CV chuyên nghiệp với các mẫu được thiết kế bởi chuyên gia
                                        tuyển dụng. Tăng cơ hội được gọi phỏng vấn với CV nổi bật.</p>
                                    <a href="#" class="btn btn-light">Tạo CV ngay</a>
                                </div>
                            </div>
                            <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.2s;">
                                <div
                                    style="background-color: rgba(255, 255, 255, 0.1); border-radius: 0.5rem; padding: 2rem; text-align: center; height: 100%; backdrop-filter: blur(10px);">
                                    <div
                                        style="width: 5rem; height: 5rem; display: flex; align-items: center; justify-content: center; background-color: rgba(255, 255, 255, 0.2); border-radius: 50%; margin: 0 auto 1.5rem; font-size: 2rem; color: white;">
                                        <i class="bi bi-graph-up"></i>
                                    </div>
                                    <h4 class="fw-bold mb-3">Đánh giá năng lực</h4>
                                    <p class="mb-4 text-white-50">Kiểm tra và đánh giá kỹ năng chuyên môn của bạn. Nhận báo cáo chi
                                        tiết và đề xuất cải thiện từ các chuyên gia.</p>
                                    <a href="#" class="btn btn-light">Đánh giá ngay</a>
                                </div>
                            </div>
                            <div class="col-md-4 animate-fadeInUp" style="animation-delay: 0.3s;">
                                <div
                                    style="background-color: rgba(255, 255, 255, 0.1); border-radius: 0.5rem; padding: 2rem; text-align: center; height: 100%; backdrop-filter: blur(10px);">
                                    <div
                                        style="width: 5rem; height: 5rem; display: flex; align-items: center; justify-content: center; background-color: rgba(255, 255, 255, 0.2); border-radius: 50%; margin: 0 auto 1.5rem; font-size: 2rem; color: white;">
                                        <i class="bi bi-camera-video"></i>
                                    </div>
                                    <h4 class="fw-bold mb-3">Mô phỏng phỏng vấn</h4>
                                    <p class="mb-4 text-white-50">Luyện tập phỏng vấn với công cụ mô phỏng AI. Nhận phản hồi ngay
                                        lập tức và cải thiện kỹ năng trả lời phỏng vấn.</p>
                                    <a href="#" class="btn btn-light">Thử ngay</a>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-5">
                            <div class="col-lg-8 mx-auto">
                                <div
                                    style="background-color: rgba(255, 255, 255, 0.1); border-radius: 0.5rem; padding: 2rem; backdrop-filter: blur(10px);">
                                    <div class="row align-items-center">
                                        <div class="col-md-8 mb-4 mb-md-0">
                                            <h4 class="fw-bold mb-3">Khóa học phát triển kỹ năng</h4>
                                            <p class="mb-0 text-white-50">Truy cập hơn 1,000+ khóa học trực tuyến về các kỹ năng
                                                chuyên môn và kỹ năng mềm từ các chuyên gia hàng đầu trong ngành.</p>
                                        </div>
                                        <div class="col-md-4 text-md-end">
                                            <a href="#" class="btn btn-secondary">Khám phá khóa học</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div
                        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-image: url('https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80'); background-size: cover; background-position: center; opacity: 0.05;">
                    </div>
                </section>
        
                 11. Newsletter Section 
                <section class="newsletter-section">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8 animate-fadeInUp" style="animation-delay: 0.1s;">
                                <div class="newsletter-card">
                                    <h2 class="newsletter-title">Đăng ký nhận thông tin việc làm mới nhất</h2>
                                    <p class="newsletter-description">Nhận thông báo về các cơ hội việc làm phù hợp với kỹ năng và
                                        mong muốn của bạn</p>
                                    <form class="newsletter-form">
                                        <div class="input-group">
                                            <input type="email" class="form-control newsletter-input"
                                                   placeholder="Địa chỉ email của bạn">
                                            <button class="btn newsletter-button" type="submit">Đăng ký</button>
                                        </div>
                                        <div class="form-text mt-2 text-muted">Chúng tôi cam kết bảo mật thông tin của bạn. Xem <a
                                                href="#">Chính sách bảo mật</a>.</div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>-->

        <!-- 12. Footer -->
        <footer class="footer">
            <div class="container">
                <div class="row g-4">
                    <div class="col-lg-4 mb-4 mb-lg-0">
                        <a href="#" class="footer-logo">
                            <span style="color: var(--primary-color);">Job</span><span>Hub</span>
                        </a>
                        <p class="footer-description">JobHub là nền tảng tuyển dụng hàng đầu tại Việt Nam, kết nối ứng viên
                            với hàng nghìn cơ hội việc làm từ các công ty uy tín.</p>
                        <div class="social-icons">
                            <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                            <a href="#" class="social-icon"><i class="bi bi-linkedin"></i></a>
                            <a href="#" class="social-icon"><i class="bi bi-twitter"></i></a>
                            <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
                            <a href="#" class="social-icon"><i class="bi bi-youtube"></i></a>
                        </div>
                    </div>
                    <div class="col-6 col-md-3 col-lg-2">
                        <h5 class="footer-title">Dành cho ứng viên</h5>
                        <ul class="footer-links">
                            <li class="footer-link"><a href="#">Tìm việc làm</a></li>
                            <li class="footer-link"><a href="#">Tạo CV</a></li>
                            <li class="footer-link"><a href="#">Việc làm đã lưu</a></li>
                            <li class="footer-link"><a href="#">Cài đặt thông báo</a></li>
                            <li class="footer-link"><a href="#">Đánh giá công ty</a></li>
                        </ul>
                    </div>
                    <div class="col-6 col-md-3 col-lg-2">
                        <h5 class="footer-title">Dành cho nhà tuyển dụng</h5>
                        <ul class="footer-links">
                            <li class="footer-link"><a href="#">Đăng tin tuyển dụng</a></li>
                            <li class="footer-link"><a href="#">Tìm hồ sơ</a></li>
                            <li class="footer-link"><a href="#">Giải pháp tuyển dụng</a></li>
                            <li class="footer-link"><a href="#">Bảng giá dịch vụ</a></li>
                            <li class="footer-link"><a href="#">Liên hệ kinh doanh</a></li>
                        </ul>
                    </div>
                    <div class="col-6 col-md-3 col-lg-2">
                        <h5 class="footer-title">Về JobHub</h5>
                        <ul class="footer-links">
                            <li class="footer-link"><a href="#">Giới thiệu</a></li>
                            <li class="footer-link"><a href="#">Liên hệ</a></li>
                            <li class="footer-link"><a href="#">Trợ giúp</a></li>
                            <li class="footer-link"><a href="#">Chính sách bảo mật</a></li>
                            <li class="footer-link"><a href="#">Điều khoản sử dụng</a></li>
                        </ul>
                    </div>
                    <div class="col-6 col-md-3 col-lg-2">
                        <h5 class="footer-title">Tài nguyên</h5>
                        <ul class="footer-links">
                            <li class="footer-link"><a href="#">Blog</a></li>
                            <li class="footer-link"><a href="#">Báo cáo thị trường</a></li>
                            <li class="footer-link"><a href="#">Mẹo tìm việc</a></li>
                            <li class="footer-link"><a href="#">Sự kiện</a></li>
                            <li class="footer-link"><a href="#">Đối tác</a></li>
                        </ul>
                    </div>
                </div>
                <hr class="footer-divider">
                <div class="row">
                    <div class="col-md-6">
                        <p class="footer-bottom mb-0">© 2023 JobHub. Tất cả quyền được bảo lưu.</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p class="footer-bottom mb-0">Được thiết kế và phát triển bởi <a href="#">JobHub Team</a></p>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                const items = document.querySelectorAll('.job-item');
                                let visible = 6;

                                document.getElementById('loadMoreBtn').addEventListener('click', function () {
                                    for (let i = visible; i < visible + 6 && i < items.length; i++) {
                                        items[i].style.display = 'block';
                                    }
                                    visible += 6;

                                    if (visible >= items.length) {
                                        this.style.display = 'none'; // Ẩn nút khi hiển thị hết
                                    }
                                });
        </script>

    </body>

</html>
