<%-- 
    Document   : LoyalRecruiterReport
    Created on : Jul 11, 2025, 10:34:49 PM
    Author     : GBCenter
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý đơn quảng cáo</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f7fa;
                color: #333;
            }

            .header {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                padding: 1rem 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .header-content {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: bold;
                color: #ff6b35;
            }

            .admin-info {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            .dashboard-title {
                margin-bottom: 2rem;
            }

            .dashboard-title h1 {
                color: #1e3c72;
                font-size: 2rem;
                margin-bottom: 0.5rem;
            }

            .breadcrumb {
                color: #666;
                font-size: 0.9rem;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                padding: 1.5rem;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border-left: 4px solid #ff6b35;
                transition: transform 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-2px);
            }

            .stat-card h3 {
                color: #666;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .stat-value {
                font-size: 2rem;
                font-weight: bold;
                color: #1e3c72;
                margin-bottom: 0.5rem;
            }

            .stat-change {
                font-size: 0.8rem;
                display: flex;
                align-items: center;
                gap: 0.3rem;
            }

            .positive {
                color: #28a745;
            }

            .negative {
                color: #dc3545;
            }

            .content-grid {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 2rem;
                margin-bottom: 2rem;
            }

            .card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .card-header {
                background: #f8f9fa;
                padding: 1rem 1.5rem;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .card-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #1e3c72;
            }

            .card-body {
                padding: 1.5rem;
            }

            .revenue-chart {
                height: 300px;
                background: linear-gradient(45deg, #f0f8ff, #e6f3ff);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #666;
                font-style: italic;
            }

            .package-list {
                list-style: none;
            }

            .package-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 0;
                border-bottom: 1px solid #f0f0f0;
            }

            .package-item:last-child {
                border-bottom: none;
            }

            .package-name {
                font-weight: 600;
                color: #1e3c72;
            }

            .package-revenue {
                font-weight: bold;
                color: #ff6b35;
            }

            .package-count {
                font-size: 0.8rem;
                color: #666;
            }

            .revenue-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
            }

            .revenue-table th,
            .revenue-table td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #e9ecef;
            }

            .revenue-table th {
                background: #f8f9fa;
                font-weight: 600;
                color: #1e3c72;
            }

            .revenue-table tr:hover {
                background: #f8f9fa;
            }

            .status-badge {
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 500;
            }

            .status-active {
                background: #d4edda;
                color: #155724;
            }

            .status-expired {
                background: #f8d7da;
                color: #721c24;
            }

            .filter-bar {
                background: white;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
                display: flex;
                gap: 1rem;
                align-items: center;
                flex-wrap: wrap;
            }

            .filter-group {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .filter-group label {
                font-weight: 500;
                color: #666;
            }

            .filter-group select,
            .filter-group input {
                padding: 0.5rem;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 0.9rem;
            }

            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 0.9rem;
                transition: background-color 0.3s ease;
            }

            .btn-primary {
                background: #1e3c72;
                color: white;
            }

            .btn-primary:hover {
                background: #2a5298;
            }

            .btn-export {
                background: #ff6b35;
                color: white;
                padding: 5px;
                text-decoration: none;
                border-radius: 5px;
            }

            .btn-export:hover {
                background: #e55a2b;
            }
            .action-buttons .btn-export {
                display: block;
                margin-bottom: 0.5rem; /* space between buttons */
            }

            @media (max-width: 768px) {
                .content-grid {
                    grid-template-columns: 1fr;
                }

                .header-content {
                    flex-direction: column;
                    gap: 1rem;
                }

                .filter-bar {
                    flex-direction: column;
                    align-items: stretch;
                }

                .revenue-table {
                    font-size: 0.8rem;
                }
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 999;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.6);
                padding-top: 60px;
            }

            .modal-content {
                background-color: #fff;
                margin: auto;
                padding: 20px 30px;
                border-radius: 10px;
                width: 500px;
                max-width: 90%;
                box-shadow: 0 0 10px rgba(0,0,0,0.3);
            }

            .close {
                float: right;
                font-size: 24px;
                font-weight: bold;
                color: #aaa;
                cursor: pointer;
            }

            .modal-header {
                display: flex;
                gap: 1rem;
                align-items: center;
                margin-bottom: 1rem;
            }

            .profile-img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 50%;
                border: 2px solid #ddd;
            }

            .header-details {
                flex: 1;
            }

            .position {
                font-style: italic;
                color: #666;
            }

            .btn-danger {
                background: #fef2f2;
                color: #dc2626;
                border: 1px solid #fecaca;
            }

            .btn-danger:hover {
                background: #fee2e2;
            }
            .btn-success {
                background: #059669;
                color: white;
            }

            .btn-success:hover {
                background: #047857;
            }
            .btn-sm{
                width: 110px;
                margin: 2px;
            }
        </style>
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>
        <main style="margin-left: 280px; padding: 25px;">
            <div class="container">
                <div class="dashboard-title">
                    <h1>Quản lý yêu cầu quảng cáo</h1>
                </div>

                <form class="filter-bar" action="ManageJobPromotion" method="post">
                    <!-- Job Name Search -->
                    <div class="filter-group">
                        <label>Tên công việc:</label>
                        <input type="text" name="jobName" value="${jobName}" placeholder="Tìm theo tên công việc" />
                    </div>

                    <!-- Status -->
                    <div class="filter-group">
                        <label>Trạng thái:</label>
                        <select name="status">
                            <option value="" ${status == '' ? 'selected' : ''}>Tất cả</option>
                            <option value="Pending" ${status == 'Pending' ? 'selected' : ''}>Đang chờ</option>
                            <option value="Accepted" ${status == 'Accepted' ? 'selected' : ''}>Chấp nhận</option>
                            <option value="Rejected" ${status == 'Rejected' ? 'selected' : ''}>Từ chối</option>
                        </select>
                    </div>

                    <!-- Page Size -->
                    <div class="filter-group">
                        <label>Số việc/trang:</label>
                        <select name="pageSize">
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                            <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                            <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                        </select>
                    </div>

                    <!-- Created Date Picker -->
                    <div class="filter-group">
                        <label>Từ ngày:</label>
                        <input type="date" name="fromDate" value="${fromDate}" />
                    </div>

                    <div class="filter-group">
                        <label>Đến ngày:</label>
                        <input type="date" name="toDate" value="${toDate}" />
                    </div>
                    <br><br>
                    <!-- Submit -->
                    <div class="filter-group">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-filter"></i> Tìm kiếm
                        </button>
                    </div>
                </form>



                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Các đơn việc cần xử lý</h3>
                    </div>
                    <div class="card-body">
                        <table class="revenue-table">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Việc làm</th>
                                    <th>Nhà tuyển dụng</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày tạo</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="l" varStatus="loop">
                                    <tr>
                                        <td>${(currentPage - 1) * pageSize + loop.index + 1}</td> 
                                        <td>
                                            <strong>${l.jobPost.title}</strong>
                                            <br>
                                            <small>${l.jobPost.jobPosition}</small>
                                            <br>
                                            <small>${l.jobPost.jobType}</small>
                                        </td>
                                        <td>
                                            <strong>${l.recruiter.fullName}</strong>
                                            <br>
                                            <small>${l.recruiter.companyName}</small>
                                        </td>
                                        <td><c:choose>
                                                <c:when test="${l.status=='Pending'}">Đang đợi</c:when>
                                                <c:when test="${l.status=='Accepted'}">Chấp nhận</c:when>
                                                <c:when test="${l.status=='Rejected'}">Từ chối</c:when>
                                            </c:choose></td>
                                        <td><strong><fmt:parseDate value="${l.createdAt}" pattern="yyyy-MM-dd" var="createdDate" />
                                                <fmt:formatDate value="${createdDate}" pattern="dd/MM/yyyy" /></strong></td>
                                        <td class="action-buttons">
                                            <!-- Approve Button -->
                                            <c:if test="${l.status=='Pending'}">
                                                <form action="UpdateJobPromotion" method="post" style="display:inline;">
                                                    <input type="hidden" name="adId" value="${l.adId}" />
                                                    <input type="hidden" name="actionType" value="Accepted" />
                                                    <button class="btn btn-success btn-sm" type="submit">
                                                        Chấp nhận
                                                    </button>
                                                </form>

                                                <!-- Reject Button -->
                                                <form action="UpdateJobPromotion" method="post" style="display:inline;">
                                                    <input type="hidden" name="adId" value="${l.adId}" />
                                                    <input type="hidden" name="actionType" value="Rejected" />
                                                    <button class="btn btn-danger btn-sm" type="submit">
                                                        Từ chối
                                                    </button>
                                                </form>
                                            </c:if>
                                        </td>

                                    </tr>  
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    Có tất cả ${total} đơn việc tìm thấy
                                </tr>
                            </tfoot>
                        </table>
                        <div style="text-align:center; margin-top:1rem;" class="pagination-buttons">

                            <!-- Previous Button -->
                            <form action="ManageJobPromotion" method="get" style="display:inline;">
                                <input type="hidden" name="page" value="${currentPage - 1}" />
                                <input type="hidden" name="pageSize" value="${pageSize}" />
                                <button class="btn btn-primary" type="submit"
                                        ${currentPage <= 1 ? 'disabled' : ''}>
                                    Trang trước
                                </button>
                            </form>

                            <!-- Page Number Buttons -->
                            <c:forEach begin="1" end="${totalPages}" var="page">
                                <c:if test="${page >= currentPage - 2 && page <= currentPage + 2}">
                                    <form action="ManageJobPromotion" method="get" style="display:inline;">
                                        <input type="hidden" name="page" value="${page}" />
                                        <input type="hidden" name="pageSize" value="${pageSize}" />
                                        <button class="btn btn-primary" type="submit"
                                                style="${page == currentPage ? 'background:#2a5298; font-weight:bold;' : ''}">
                                            ${page}
                                        </button>
                                    </form>
                                </c:if>
                            </c:forEach>

                            <!-- Next Button -->
                            <form action="ManageJobPromotion" method="get" style="display:inline;">
                                <input type="hidden" name="page" value="${currentPage + 1}" />
                                <input type="hidden" name="pageSize" value="${pageSize}" />
                                <button class="btn btn-primary" type="submit"
                                        ${currentPage >= totalPages ? 'disabled' : ''}>
                                    Trang sau
                                </button>
                            </form>
                        </div>
                    </div>
                </div>               
        </main>
    </body>
</html>
