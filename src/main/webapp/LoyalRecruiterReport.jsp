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
        <title>Top khách hàng thân thiết</title>
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


        </style>
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>
        <main style="margin-left: 280px; padding: 25px;">
            <div class="container">
                <div class="dashboard-title">
                    <h1>Báo cáo khách hàng thân thiết</h1>
                </div>

                <form class="filter-bar" action="LoyalRecruiterReport" method="post">
                    <div class="filter-group">
                        <label>Số người/trang:</label>
                        <select name="top">
                            <option value="5" ${top == 5 ? 'selected' : ''}>5</option>
                            <option value="10" ${top == 10 ? 'selected' : ''}>10</option>
                            <option value="20" ${top == 20 ? 'selected' : ''}>20</option>
                            <option value="50" ${top == 50 ? 'selected' : ''}>50</option>
                            <option value="100" ${top == 100 ? 'selected' : ''}>100</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Thời hạn:</label>
                        <select name="time">
                            <option value="all" ${time == 'all' ? 'selected' : ''}>Tất cả</option>
                            <option value="month" ${time == 'month' ? 'selected' : ''}>Tháng này</option>
                            <option value="quarter" ${time == 'quarter' ? 'selected' : ''}>Quý này</option>
                            <option value="year" ${time == 'year' ? 'selected' : ''}>Năm này</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-filter"></i> Lọc
                        </button>
                    </div>
                </form>


                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Top khách hàng thân thiết</h3>
                    </div>
                    <div class="card-body">
                        <table class="revenue-table">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Nhà tuyển dụng</th>
                                    <th>Tổng tiền</th>
                                    <th>Ngày mua gói gần nhất</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="l" varStatus="loop">
                                    <tr>
                                        <td>${(currentPage - 1) * top + loop.index + 1}</td> 
                                        <td>
                                            <strong>${l.recruiter.fullName}</strong>
                                            <br>
                                            <small>${l.recruiter.companyName}</small>
                                            <br>
                                            <small>${l.recruiter.email}</small>
                                        </td>
                                        <td><fmt:formatNumber value="${l.totalPrice}" type="number" groupingUsed="true" /></td>
                                        <td><strong><fmt:parseDate value="${l.lastTransaction}" pattern="yyyy-MM-dd" var="createdDate" />
                                                <fmt:formatDate value="${createdDate}" pattern="dd/MM/yyyy" /></strong></td>
                                        <td class="action-buttons">
                                            <a href="RevenueReport?recruiterID=${l.recruiterID}" class="btn-export">Xem chi tiêu khách hàng</a>
                                            <a class="btn-export" onclick="showModal('${l.recruiter.fullName}', '${l.recruiter.companyName}', '${l.recruiter.email}', '${l.recruiter.phone}', '${l.recruiter.companyAddress}', '${l.recruiter.position}', '${l.recruiter.industry}', '${l.recruiter.imageUrl}', '${l.recruiter.website}')">Xem thông tin nhà tuyển dụng</a>
                                        </td>

                                    </tr>  
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    Có ${list.size()} trên ${totalRecords} nhà tuyển dụng
                                </tr>
                            </tfoot>
                        </table>
                        <div style="text-align:center; margin-top:1rem;" class="pagination-buttons">

                            <!-- Prev Button -->
                            <form action="RevenueReport" method="get" style="display:inline;">
                                <input type="hidden" name="recruiterID" value="${recruiter.recruiterId}" />
                                <input type="hidden" name="time" value="${time}" />
                                <input type="hidden" name="payMethod" value="${payMethod}" />
                                <input type="hidden" name="sortPrice" value="${sortPrice}" />
                                <input type="hidden" name="sortDate" value="${sortDate}" />
                                <input type="hidden" name="pageSize" value="${pageSize}" />
                                <input type="hidden" name="page" value="${pageIndex - 1}" />
                                <button class="btn btn-primary" type="submit" ${pageIndex == 1 ? 'disabled' : ''}>
                                    Trang trước
                                </button>
                            </form>

                            <!-- Page Numbers: Show ±2 around current -->
                            <c:forEach begin="1" end="${totalPages}" var="page">
                                <c:if test="${page <= pageIndex + 2 && page >= pageIndex - 2}">
                                    <form action="RevenueReport" method="get" style="display:inline;">
                                        <input type="hidden" name="recruiterID" value="${recruiter.recruiterId}" />
                                        <input type="hidden" name="time" value="${time}" />
                                        <input type="hidden" name="payMethod" value="${payMethod}" />
                                        <input type="hidden" name="sortPrice" value="${sortPrice}" />
                                        <input type="hidden" name="sortDate" value="${sortDate}" />
                                        <input type="hidden" name="pageSize" value="${pageSize}" />
                                        <input type="hidden" name="page" value="${page}" />
                                        <button class="btn btn-primary" type="submit"
                                                style="${page == pageIndex ? 'background:#2a5298; font-weight:bold;' : ''}">
                                            ${page}
                                        </button>
                                    </form>
                                </c:if>
                            </c:forEach>

                            <!-- Next Button -->
                            <form action="RevenueReport" method="get" style="display:inline;">
                                <input type="hidden" name="recruiterID" value="${recruiter.recruiterId}" />
                                <input type="hidden" name="time" value="${time}" />
                                <input type="hidden" name="payMethod" value="${payMethod}" />
                                <input type="hidden" name="sortPrice" value="${sortPrice}" />
                                <input type="hidden" name="sortDate" value="${sortDate}" />
                                <input type="hidden" name="pageSize" value="${pageSize}" />
                                <input type="hidden" name="page" value="${pageIndex + 1}" />
                                <button class="btn btn-primary" type="submit" ${pageIndex == totalPages ? 'disabled' : ''}>
                                    Trang sau
                                </button>
                            </form>
                        </div>
                    </div>
                </div>               
        </main>
        <div id="recruiterModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <div class="modal-header">
                    <img id="recruiterImage" src="" alt="Recruiter Image" class="profile-img" />
                    <div class="header-details">
                        <h3 id="recruiterName"></h3>
                        <p id="recruiterPosition" class="position"></p>
                        <p><strong>Ngành nghề:</strong> <span id="recruiterIndustry"></span></p>
                    </div>
                </div>

                <div class="modal-body">
                    <p><strong>Công ty:</strong> <span id="recruiterCompany"></span></p>
                    <p><strong>Email:</strong> <span id="recruiterEmail"></span></p>
                    <p><strong>Điện thoại:</strong> <span id="recruiterPhone"></span></p>
                    <p><strong>Địa chỉ công ty:</strong> <span id="recruiterAddress"></span></p>
                    <br>
                    <a id="companyWebsite" href="#" target="_blank" class="btn-export">Truy cập website công ty</a>
                </div>
            </div>
        </div>

        <script>
            function showModal(name, company, email, phone, address, position, industry, imageUrl, website) {
                document.getElementById("recruiterName").textContent = name;
                document.getElementById("recruiterCompany").textContent = company;
                document.getElementById("recruiterEmail").textContent = email;
                document.getElementById("recruiterPhone").textContent = phone;
                document.getElementById("recruiterAddress").textContent = address;
                document.getElementById("recruiterPosition").textContent = position;
                document.getElementById("recruiterIndustry").textContent = industry;
                document.getElementById("recruiterImage").src = imageUrl || "default-profile.png";
                document.getElementById("companyWebsite").href = website;
                document.getElementById("recruiterModal").style.display = "block";
            }

            document.querySelector(".modal .close").onclick = function () {
                document.getElementById("recruiterModal").style.display = "none";
            };

            window.onclick = function (event) {
                if (event.target === document.getElementById("recruiterModal")) {
                    document.getElementById("recruiterModal").style.display = "none";
                }
            };

        </script>
    </body>
</html>

