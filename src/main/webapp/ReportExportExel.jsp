<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Báo cáo Giao dịch & Doanh thu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', sans-serif;
            }

            .main-content {
                margin-left: 280px;
                padding: 20px;
            }

            .report-header {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .report-header h2 {
                color: #333;
                margin: 0;
                font-size: 24px;
                font-weight: 600;
            }

            .report-tabs {
                background-color: #fff;
                border-radius: 10px;
                padding: 5px;
                margin-bottom: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .tab-button {
                background-color: transparent;
                border: none;
                color: #6c757d;
                padding: 15px 25px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .tab-button.active {
                background-color: #007bff;
                color: #fff;
            }

            .tab-button:hover:not(.active) {
                background-color: #f8f9fa;
            }

            .report-card {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }

            .card-header-custom {
                background-color: #007bff;
                color: #fff;
                padding: 15px 20px;
                border-radius: 10px 10px 0 0;
                display: flex;
                justify-content: between;
                align-items: center;
            }

            .card-header-custom.success {
                background-color: #28a745;
            }

            .card-header-custom h5 {
                margin: 0;
                font-size: 16px;
                font-weight: 600;
            }

            .export-btn {
                background-color: #28a745;
                border: none;
                color: #fff;
                padding: 8px 15px;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }

            .export-btn:hover {
                background-color: #218838;
                color: #fff;
            }

            .filter-section {
                padding: 20px;
                background-color: #f8f9fa;
                border-bottom: 1px solid #dee2e6;
            }

            .form-select {
                border: 1px solid #ced4da;
                border-radius: 5px;
                padding: 6px 12px;
            }
            .form-control {
                border: 1px solid #ced4da;
                border-radius: 5px;
                padding: 6px 12px;
            }

            .form-control:focus, .form-select:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                border-radius: 5px;
                padding: 6px 10px;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            .btn-success {
                background-color: #28a745;
                border-color: #28a745;
                border-radius: 5px;
                padding: 10px 20px;
            }

            .btn-success:hover {
                background-color: #218838;
                border-color: #218838;
            }

            .table-section {
                padding: 0;
            }

            .table th {
                background-color: #495057;
                color: #fff;
                border: none;
                padding: 12px 8px;
                font-size: 14px;
                font-weight: 600;
                text-align: center;
            }

            .table td {
                padding: 12px 8px;
                font-size: 14px;
                text-align: center;
                vertical-align: middle;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
            }

            .status-badge {
                padding: 4px 8px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: 500;
            }

            .status-completed {
                background-color: #d4edda;
                color: #155724;
            }

            .status-pending {
                background-color: #fff3cd;
                color: #856404;
            }

            .status-failed {
                background-color: #f8d7da;
                color: #721c24;
            }

            .promo-code {
                background-color: #ffc107;
                color: #212529;
                padding: 2px 6px;
                border-radius: 10px;
                font-size: 11px;
                font-weight: 600;
            }

            .amount-text {
                color: #28a745;
                font-weight: 600;
            }

            .tab-content {
                display: none;
            }

            .tab-content.active {
                display: block;
            }

            .empty-state {
                text-align: center;
                padding: 40px 20px;
                color: #6c757d;
            }

            .empty-state i {
                font-size: 48px;
                margin-bottom: 15px;
            }
            .pagination {
                margin-top: 20px;
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                gap: 5px;
            }

            .page-item {
                list-style: none;
            }

            .page-link {
                border: 1px solid #007bff;
                color: #007bff;
                padding: 6px 12px;
                border-radius: 4px;
                background-color: white;
                transition: 0.3s;
                cursor: pointer;
            }

            .page-link:hover {
                background-color: #007bff;
                color: white;
            }

            .page-item.active .page-link {
                background-color: #007bff;
                color: white;
                font-weight: bold;
                pointer-events: none;
            }

            .page-item.disabled .page-link {
                background-color: #e9ecef;
                color: #6c757d;
                border-color: #dee2e6;
                pointer-events: none;
            }

        </style>
    </head>
    <body>
        <%@ include file="leftNavbar.jsp" %>

        <div class="main-content">
            <!-- Header -->
            <div class="report-header">
                <h2><i class="fas fa-chart-bar me-2"></i>Báo cáo Giao dịch & Doanh thu</h2>
            </div>

            <!-- Tabs -->
            <div class="report-tabs">
                <button class="tab-button active" onclick="switchTab('transactions')">
                    Báo cáo Giao dịch
                </button>
                <button class="tab-button" onclick="window.location.href = 'RevenueExel'">
                    Báo cáo Doanh thu
                </button>
            </div>

            <!-- Transactions Tab -->
            <div id="transactions-tab" class="tab-content active">
                <div class="report-card">
                    <div class="card-header-custom">
                        <h5>Lọc báo cáo giao dịch</h5>
                        <form action="ExportTransactionExcel" method="post" class="d-inline">
                            <input type="hidden" name="searchExel" value="${searchExel}">
                            <input type="hidden" name="minTotal" value="${minTotal}">
                            <input type="hidden" name="maxTotal" value="${maxTotal}">
                            <input type="hidden" name="sortDate" value="${sortDate}">
                            <input type="hidden" name="promotion" value="${promotion}">
                            <input type="hidden" name="status" value="${status}">
                            
                            <input type="hidden" name="fromDateDayTransaction" value="${fromDateDayTransaction}">
                            <input type="hidden" name="toDateDayTransaction" value="${toDateDayTransaction}">
                            <button type="submit" class="btn btn-success export-btn">
                                <i class="fas fa-download me-1"></i> Xuất Excel
                            </button>
                        </form>
                    </div>

                    <div class="filter-section">
                        <form id="TransactionExel" method="post" action="TransactionExel">
                            <input type="hidden" name="displayPercent" value="${displayPercent}">
                            <div class="row g-3">
                                <div class="col-md-3" style="width: 300px;">
                                    <input type="text" name="searchExel" class="form-control" placeholder="Nhập tên công ty hoặc gói dịch vụ" value="${searchExel}">
                                </div>
                                <div class="col-md-2" style="width: 190px;">
                                    <input type="text" id="minTotal" name="minTotal" class="form-control" placeholder="Tổng tiền từ (VNĐ)" value="${minTotal}">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" id="maxTotal" name="maxTotal" class="form-control" placeholder="Đến (VNĐ)" value="${maxTotal}">
                                </div>
                                <div class="col-md-2">
                                    <select name="sortDate" class="form-select">
                                        <option value="desc" ${sortDate == 'desc' ? 'selected' : ''}>Ngày mới nhất</option>
                                        <option value="asc" ${sortDate == 'asc' ? 'selected' : ''}>Ngày cũ nhất</option>
                                    </select>
                                </div>


                                <div class="col-md-2">
                                    <select name="promotion" class="form-select">
                                        <option value="all" ${promotion == 'all' ? 'selected' : ''}>Tất cả khuyến mãi</option>
                                        <option value="yes" ${promotion == 'yes' ? 'selected' : ''}>Có khuyến mãi</option>
                                        <option value="no" ${promotion == 'no' ? 'selected' : ''}>Không có khuyến mãi</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Tất cả trạng thái</label>
                                    <select name="status" class="form-select">
                                        <option value="all" ${status == 'all' ? 'selected' : ''}>Tất cả trạng thái</option>
                                        <option value="success" ${status == 'success' ? 'selected' : ''}>Thành công</option>
                                        <option value="pending" ${status == 'pending' ? 'selected' : ''}>Đang xử lý</option>
                                        <option value="failed" ${status == 'failed' ? 'selected' : ''}>Thất bại</option>
                                    </select>
                                </div>
                                <div class="col-md-2" style="width: 15%;">
                                    <label class="form-label">Từ ngày</label>
                                    <input type="date" name="fromDateDayTransaction" class="form-control" value="${fromDateDayTransaction}">
                                </div>

                                <!-- Đến ngày -->
                                <div class="col-md-2" style="width: 15%;">
                                    <label class="form-label">Đến ngày</label>
                                    <input type="date" name="toDateDayTransaction" class="form-control" value="${toDateDayTransaction}">
                                </div>
                                <div class="col-md-1" style="margin-top: 48px;">
                                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <form action="TransactionExel" method="post">
                        <!-- Ẩn các tham số lọc nếu có -->
                        <input type="hidden" name="searchExel" value="${searchExel}">
                        <input type="hidden" name="minTotal" value="${minTotal}">
                        <input type="hidden" name="maxTotal" value="${maxTotal}">
                        <input type="hidden" name="sortDate" value="${sortDate}">
                        <input type="hidden" name="promotion" value="${promotion}">
                        <input type="hidden" name="status" value="${status}">
                        <input type="hidden" name="page" value="${page}">
                        <div class="col-md-2">
                            <select name="displayPercent" class="form-select" onchange="this.form.submit()">
                                <option value="100" ${displayPercent == '100' ? 'selected' : ''}>Hiển thị 100%</option>
                                <option value="80" ${displayPercent == '80' ? 'selected' : ''}>Hiển thị 80%</option>
                                <option value="50" ${displayPercent == '50' ? 'selected' : ''}>Hiển thị 50%</option>
                                <option value="30" ${displayPercent == '30' ? 'selected' : ''}>Hiển thị 30%</option>
                                <option value="20" ${displayPercent == '20' ? 'selected' : ''}>Hiển thị 20%</option>
                            </select>
                        </div> 
                    </form>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="errorMessage" scope="session" />
                    </c:if>
                    <c:if test="${not empty errorMessageDateTransaction}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessageDateTransaction}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="errorMessageDateTransaction" scope="session" />
                    </c:if>
                    <script>
                        setTimeout(function () {
                            const alertBox = document.querySelector(".alert-dismissible");
                            if (alertBox) {
                                // Bootstrap 5 API để ẩn
                                let alert = bootstrap.Alert.getOrCreateInstance(alertBox);
                                alert.close();
                            }
                        }, 3000); // 3 giây
                    </script>
                    <div class="table-section">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Mã GD</th>
                                        <th>Nhà tuyển dụng</th>
                                        <th>Dịch vụ</th>
                                        <th>Đơn giá</th>
                                        <th>Khuyến mãi</th>
                                        <th>Tổng tiền</th>
                                        <th>Ngày thanh toán</th>
                                        <th>Phương thức</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty filteredTransactions}">
                                            <tr>
                                                <td colspan="10" class="empty-state">
                                                    <i class="fas fa-inbox"></i>
                                                    <p>Không có dữ liệu giao dịch</p>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="txn" items="${filteredTransactions}" varStatus="i">
                                                <tr>
                                                    <td>${i.index + 1}</td>
                                                    <td>${txn.getTransactionId()}</td>
                                                    <td>${txn.getCompanyName()}</td>
                                                    <td>${txn.getServiceTitle()}</td>
                                                    <td class="amount-text">${txn.getFormattedUnitPrice()} đ</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${txn.getPromotionTitle() != null}">
                                                                <span class="promo-code">${txn.getPromotionTitle()}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                Không có
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="amount-text"><strong>${txn.getFormattedTotalPrice()} đ</strong></td>
                                                    <td>${txn.getFormattedTransactionDate()}</td>
                                                    <td>${txn.getPaymentMethod()}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${txn.getStatus() == 'success'}">
                                                                <span class="status-badge status-completed">Thành công</span>
                                                            </c:when>
                                                            <c:when test="${txn.getStatus() == 'pending'}">
                                                                <span class="status-badge status-pending">Đang chờ</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge status-failed">Thất bại</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <!-- 🔻 HÀNG TỔNG -->
                                            <tr style="background-color: #f8f9fa; font-weight: bold;">
                                                <td class="text-center" colspan="3">Tổng:</td>
                                                <td>${totalServiceTransaction}</td>
                                                <td>${totalUnitServiceTransaction}</td>
                                                <td class="amount-text" colspan="2">${totalNetRevenueTransaction} đ</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <form action="TransactionExel" method="post">
                        <!-- Ẩn các tham số lọc nếu có -->
                        <input type="hidden" name="searchExel" value="${searchExel}">
                        <input type="hidden" name="minTotal" value="${minTotal}">
                        <input type="hidden" name="maxTotal" value="${maxTotal}">
                        <input type="hidden" name="sortDate" value="${sortDate}">
                        <input type="hidden" name="promotion" value="${promotion}">
                        <input type="hidden" name="status" value="${status}">
                        <input type="hidden" name="displayPercent" value="${displayPercent}">
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
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
                </div>
            </div>

            <!-- Revenue Tab -->
            <div id="revenue-tab" class="tab-content">
                <div class="report-card">
                    <div class="card-header-custom success">
                        <h5>Lọc báo cáo doanh thu theo tháng</h5>
                        <a href="export-revenue-excel" class="export-btn">
                            <i class="fas fa-download me-1"></i>Xuất Excel
                        </a>
                    </div>

                    <div class="filter-section">
                        <form method="post" action="RevenueExel">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <select name="searchMonth" class="form-select">
                                        <option value="">-- Chọn tháng --</option>
                                        <c:forEach var="m" items="${availableMonths}">
                                            <option value="${m}" ${searchMonth == m ? 'selected' : ''}>${m}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <input type="number" name="minRevenue" class="form-control" placeholder="Doanh thu từ" value="${minRevenue}">
                                </div>
                                <div class="col-md-2">
                                    <input type="number" name="maxRevenue" class="form-control" placeholder="Doanh thu đến" value="${maxRevenue}">
                                </div>
                                <div class="col-md-2">
                                    <select name="promotionRevenue" class="form-select">
                                        <option value="all">Tất cả khuyến mãi</option>
                                        <option value="yes">Có khuyến mãi</option>
                                        <option value="no">Không có khuyến mãi</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <select name="sortByRevenue" class="form-select">
                                        <option value="month_asc">Tháng tăng dần</option>
                                        <option value="month_desc">Tháng giảm dần</option>
                                        <option value="revenue_asc">Doanh thu tăng dần</option>
                                        <option value="revenue_desc">Doanh thu giảm dần</option>
                                        <option value="service_asc">Gói dịch vụ tăng dần</option>
                                        <option value="service_desc">Gói dịch vụ giảm dần</option>
                                    </select>
                                </div>
                                <div class="col-md-1">
                                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <form action="RevenueExel" method="post">
                        <!-- Ẩn các tham số lọc nếu có -->
                        <input type="hidden" name="searchMonth" value="${searchExel}">
                        <input type="hidden" name="minRevenue" value="${minTotal}">
                        <input type="hidden" name="maxRevenue" value="${maxTotal}">
                        <input type="hidden" name="promotionRevenue" value="${sortDate}">
                        <input type="hidden" name="sortByRevenue" value="${promotion}">
                        <input type="hidden" name="page" value="${page}">
                        <div class="col-md-2">
                            <select name="displayPercentRevenue" class="form-select" onchange="this.form.submit()">
                                <option value="100" ${displayPercentRevenue == '100' ? 'selected' : ''}>Hiển thị 100%</option>
                                <option value="80" ${displayPercentRevenue == '80' ? 'selected' : ''}>Hiển thị 80%</option>
                                <option value="50" ${displayPercentRevenue == '50' ? 'selected' : ''}>Hiển thị 50%</option>
                                <option value="30" ${displayPercentRevenue == '30' ? 'selected' : ''}>Hiển thị 30%</option>
                                <option value="20" ${displayPercentRevenue == '20' ? 'selected' : ''}>Hiển thị 20%</option>
                            </select>
                        </div> 
                    </form>
                    <div class="table-section">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover mb-0">
                                <thead class="table-success">
                                    <tr>
                                        <th>STT</th>
                                        <th>Tháng</th>
                                        <th>Số giao dịch</th>
                                        <th>Số nhà tuyển dụng</th>
                                        <th>Tổng số gói dịch vụ</th>
                                        <th>Tổng trước KM</th>
                                        <th>Giảm giá</th>
                                        <th>Doanh thu thuần</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty revenueList}">
                                            <tr>
                                                <td colspan="7" class="empty-state">
                                                    <i class="fas fa-chart-line"></i>
                                                    <p>Không có dữ liệu doanh thu</p>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="r" items="${revenueList}" varStatus="i">
                                                <tr>
                                                    <td>${i.index + 1}</td>
                                                    <td><strong>${r.getMonth()}</strong></td>
                                                    <td>${r.getTransactionCount()}</td>
                                                    <td>${r.getRecruiterCount()}</td>
                                                    <td>${r.getTotalServiceCount()}</td>
                                                    <td class="amount-text">${r.getTotalBeforeDiscount()} đ</td>
                                                    <td style="color: #dc3545;">${r.getDiscountAmount()} đ</td>
                                                    <td class="amount-text"><strong>${r.getNetRevenue()} đ</strong></td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                function switchTab(tabName) {
                                    // Hide all tabs
                                    document.querySelectorAll('.tab-content').forEach(tab => {
                                        tab.classList.remove('active');
                                    });

                                    // Remove active from buttons
                                    document.querySelectorAll('.tab-button').forEach(btn => {
                                        btn.classList.remove('active');
                                    });

                                    // Show selected tab
                                    document.getElementById(tabName + '-tab').classList.add('active');
                                    event.target.classList.add('active');
                                }
        </script>
        <script>
            function formatNumberInput(input) {
                input.addEventListener('input', function (e) {
                    let value = this.value.replace(/\D/g, ''); // Xoá hết ký tự không phải số
                    if (value === '') {
                        this.value = '';
                        return;
                    }
                    this.value = Number(value).toLocaleString('vi-VN'); // Thêm dấu chấm mỗi 3 số
                });
            }

// Khi submit form, xóa dấu chấm để gửi dữ liệu chuẩn
            document.addEventListener("DOMContentLoaded", function () {
                const minTotal = document.getElementById("minTotal");
                const maxTotal = document.getElementById("maxTotal");
                const form = document.getElementById("TransactionExel"); // 👈 chọn đúng form

                formatNumberInput(minTotal);
                formatNumberInput(maxTotal);

                form.addEventListener("submit", function () {
                    minTotal.value = minTotal.value.replace(/\./g, '');
                    maxTotal.value = maxTotal.value.replace(/\./g, '');
                });
            });
        </script>
    </body>
</html>
