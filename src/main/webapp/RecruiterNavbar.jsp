<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Navbar Styles -->
<style>
    .navbar-custom {
        background-color: #f0f6ff;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.20);
    }

    /* Dropdown Styles - Made more compact */
    .dropdown-menu {
        border: none;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        border-radius: 12px;
        padding: 0.75rem 0;
        margin-top: 0.5rem;
        min-width: 240px;
    }

    .dropdown-header {
        color: var(--primary-color, #0046aa);
        font-weight: 700;
        font-size: 0.7rem;
        text-transform: uppercase;
        letter-spacing: 0.4px;
        padding: 0.4rem 1.2rem;
        margin-bottom: 0.2rem;
    }

    .dropdown-item {
        padding: 0.6rem 1.2rem;
        font-weight: 500;
        font-size: 0.9rem;
        transition: all 0.3s ease;
        border-radius: 0;
        display: flex;
        align-items: center;
    }

    .dropdown-item:hover {
        background: linear-gradient(135deg, #f0f6ff 0%, #e6f0ff 100%);
        color: var(--primary-color, #0046aa);
        transform: translateX(5px);
    }

    .dropdown-item.text-danger:hover {
        background: linear-gradient(135deg, #ffe6e6 0%, #ffcccc 100%);
        color: #dc3545;
    }

    .dropdown-item i {
        width: 18px;
        text-align: center;
        margin-right: 0.6rem;
        font-size: 0.85rem;
    }

    .dropdown-divider {
        margin: 0.4rem 1rem;
        border-color: #e9ecef;
    }

    .dropdown-toggle::after {
        margin-left: 0.5rem;
    }

    .btn-primary {
        background: linear-gradient(135deg, var(--primary-color, #0046aa) 0%, #0051ff 100%);
        border: none;
        padding: 0.65rem 1.3rem;
        font-weight: 600;
        font-size: 0.9rem;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 70, 170, 0.3);
        transition: all 0.3s ease;
    }

    .btn-primary:hover {
        background: linear-gradient(135deg, #003ecb 0%, #0046aa 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0, 70, 170, 0.4);
    }

    .navbar-brand {
        font-weight: 700;
        font-size: 1.5rem;
        text-decoration: none;
    }

    .navbar-brand:hover {
        text-decoration: none;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .dropdown-menu {
            min-width: 220px;
        }

        .dropdown-item {
            padding: 0.7rem 1.2rem;
        }
    }
</style>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand" href="HomePage">
            <span style="color: var(--primary-color, #0046aa);">Job</span><span style="color: var(--dark-color, #001e44);">Hub</span>
        </a>

        <div class="d-flex">
            <div class="dropdown">
                <button class="btn btn-primary dropdown-toggle" type="button" id="navDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-list me-2"></i>Menu
                </button>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navDropdown">
                    <!-- Management Section -->
                    <li><h6 class="dropdown-header"><i class="bi bi-gear-fill me-1"></i>Quản lý</h6></li>
                    <li>
                        <a class="dropdown-item" href="ManageJobPost">
                            <i class="bi bi-briefcase-fill"></i>Quản lý tin tuyển dụng
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="InterviewManager">
                            <i class="bi bi-calendar-check"></i>Quản lý phỏng vấn
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="TestManage">
                            <i class="bi bi-file-earmark-text"></i>Quản lý bài thi
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="ApplicationManagement">
                            <i class="bi bi-person-lines-fill"></i>Quản lý ứng viên
                        </a>
                    </li>

                    <li><hr class="dropdown-divider"></li>

                    <!-- Actions Section -->
                    <li><h6 class="dropdown-header"><i class="bi bi-lightning-fill me-1"></i>Hành động</h6></li>
                    <li>
                        <a class="dropdown-item" href="JobPostingPage">
                            <i class="bi bi-plus-circle-fill"></i>Tạo bài đăng
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="buyServices">
                            <i class="bi bi-cart-check-fill"></i>Các gói dịch vụ
                        </a>
                    </li>

                    <li><hr class="dropdown-divider"></li>

                    <!-- Profile Section -->
                    <li><h6 class="dropdown-header"><i class="bi bi-person-circle me-1"></i>Tài khoản</h6></li>
                    <li>
                        <a class="dropdown-item" href="RecruiterDashboard">
                            <i class="bi bi-speedometer2"></i>Dashboard của bạn
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="EditProfileRecruiter">
                            <i class="bi bi-person-gear"></i>Quản lí Profile
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item text-danger" href="#" onclick="return confirmLogout()">
                            <i class="bi bi-box-arrow-right"></i>Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!-- Navbar JavaScript -->
<script>
    // Confirmation dialog for logout
    function confirmLogout() {
        if (confirm('Bạn có chắc chắn muốn đăng xuất?')) {
            window.location.href = 'logout';
            return true;
        }
        return false;
    }

    // Highlight current page in dropdown
    document.addEventListener('DOMContentLoaded', function () {
        const currentPath = window.location.pathname;
        const dropdownItems = document.querySelectorAll('.dropdown-item');

        dropdownItems.forEach(item => {
            const href = item.getAttribute('href');
            if (href && currentPath.includes(href)) {
                item.style.backgroundColor = '#e3f2fd';
                item.style.color = '#0046aa';
                item.style.fontWeight = '600';
            }
        });
    });
</script>