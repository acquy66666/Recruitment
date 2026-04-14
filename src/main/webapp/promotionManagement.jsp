<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobHub - Quản Lý Khuyến Mãi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        :root {
            --primary-dark: #001a57;
            --primary-color: #0046b8;
            --primary-light: #0066ff;
            --secondary-color: #2c3e50;
            --accent-color: #ff7f50;
            --accent-hover: #ff6a3c;
            --light-gray: #f8f9fa;
            --medium-gray: #e9ecef;
            --dark-gray: #6c757d;
            --border-color: #dee2e6;
            --error-color: #dc3545;
            --success-color: #28a745;
            --sidebar-width: 250px;
        }
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 20px;
            min-height: 100vh;
        }
        .table-responsive {
            margin-top: 20px;
        }
        .card {
            margin-bottom: 20px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .filter-form {
            background-color: var(--light-gray);
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .btn-action {
            margin: 2px;
            min-width: 35px;
            padding: 6px 10px;
            font-size: 0.85rem;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        .btn-edit {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: #fff;
        }
        .btn-edit:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            color: #fff;
            transform: translateY(-2px);
        }
        .btn-deactivate {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #000;
        }
        .btn-deactivate:hover {
            background-color: #e0a800;
            border-color: #d39e00;
            color: #000;
            transform: translateY(-2px);
        }
        .btn-activate {
            background-color: #28a745;
            border-color: #28a745;
            color: #fff;
        }
        .btn-activate:hover {
            background-color: #218838;
            border-color: #1e7e34;
            color: #fff;
            transform: translateY(-2px);
        }
        .btn-delete {
            background-color: #dc3545;
            border-color: #dc3545;
            color: #fff;
        }
        .btn-delete:hover {
            background-color: #c82333;
            border-color: #bd2130;
            color: #fff;
            transform: translateY(-2px);
        }
        .btn-search {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: #fff;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .btn-search:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            color: #fff;
            transform: translateY(-2px);
        }
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 6px;
            align-items: center;
            min-width: 120px;
        }
        .action-buttons .horizontal-buttons {
            display: flex;
            gap: 4px;
            justify-content: center;
        }
        .action-buttons .status-button {
            width: 100%;
            min-width: 90px;
            font-size: 0.8rem;
            font-weight: 500;
            gap: 5px;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .status-active {
            color: var(--primary-color);
            font-weight: bold;
        }
        .status-inactive {
            color: var(--error-color);
            font-weight: bold;
        }
        .table tr {
            cursor: pointer;
        }
        .table tr td:last-child {
            cursor: default;
        }
        .modal-content {
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        .modal-header {
            border-bottom: 1px solid var(--border-color);
        }
        .modal-footer {
            border-top: 1px solid var(--border-color);
        }
        @media (max-width: 1200px) {
            .main-content {
                margin-left: 0;
                width: 100%;
                padding: 15px;
            }
        }
        @media (max-width: 768px) {
            .main-content {
                padding: 10px;
            }
            .action-buttons {
                min-width: 100px;
            }
            .action-buttons .horizontal-buttons {
                flex-wrap: wrap;
                gap: 3px;
            }
            .btn-action {
                font-size: 0.75rem;
                padding: 5px 7px;
                min-width: 30px;
            }
            .action-buttons .status-button {
                font-size: 0.7rem;
                min-width: 75px;
                gap: 3px;
            }
        }
    </style>
</head>
<body>
    <%
        if (session.getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }
    %>
    <%@include file="leftNavbar.jsp" %>
    <div class="main-content">
        <div class="container-fluid">
            <div class="header-actions">
                <h2>Quản Lý Khuyến Mãi</h2>
                <form action="createPromotion" method="get" style="display:inline;">
                    <button type="submit" class="btn btn-primary">Tạo Khuyến Mãi</button>
                </form>
            </div>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <div class="filter-form">
                <form action="managePromotions" method="get" class="row g-3">
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="search" value="${search}" placeholder="Tìm theo tiêu đề hoặc mã khuyến mãi">
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="type">
                            <option value="" ${empty type ? 'selected' : ''}>Tất cả Loại</option>
                            <c:forEach var="pType" items="${allTypes}">
                                <option value="${pType}" ${pType == type ? 'selected' : ''}>${pType}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="status">
                            <option value="" ${empty status ? 'selected' : ''}>Tất cả Trạng thái</option>
                            <option value="active" ${status == 'active' ? 'selected' : ''}>Khả dụng</option>
                            <option value="inactive" ${status == 'inactive' ? 'selected' : ''}>Ngừng</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="dateFilter">
                            <option value="" ${empty dateFilter ? 'selected' : ''}>Tất cả Ngày</option>
                            <option value="ongoing" ${dateFilter == 'ongoing' ? 'selected' : ''}>Đang diễn ra</option>
                            <option value="upcoming" ${dateFilter == 'upcoming' ? 'selected' : ''}>Sắp diễn ra</option>
                            <option value="expired" ${dateFilter == 'expired' ? 'selected' : ''}>Đã hết hạn</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="sortBy">
                            <option value="created_at_desc" ${sortBy == 'created_at_desc' ? 'selected' : ''}>Mới nhất</option>
                            <option value="discount_asc" ${sortBy == 'discount_asc' ? 'selected' : ''}>Giảm giá (Thấp đến Cao)</option>
                            <option value="discount_desc" ${sortBy == 'discount_desc' ? 'selected' : ''}>Giảm giá (Cao đến Thấp)</option>
                            <option value="quantity_asc" ${sortBy == 'quantity_asc' ? 'selected' : ''}>Số lượng (Thấp đến Cao)</option>
                            <option value="quantity_desc" ${sortBy == 'quantity_desc' ? 'selected' : ''}>Số lượng (Cao đến Thấp)</option>
                        </select>
                    </div>
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-search">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                    <input type="hidden" name="page" value="1">
                </form>
            </div>
            <div class="card">
                <div class="card-header">
                    <h5>Khuyến Mãi</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Tiêu đề</th>
                                    <td>Loại</th>
                                    <td>Giảm</th>
                                    <td>Giảm Tối Đa</td>
                                    <td>Trạng Thái</td>
                                    <td>Ngày Kết thúc</td>
                                    <td>Thao tác</td>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="promotion" items="${promotions}" varStatus="loop">
                                    <tr data-promotion-id="${promotion.promotionId}"
                                        data-title="${promotion.title}"
                                        data-promo-code="${promotion.promoCode}"
                                        data-type="${promotion.promotionType}"
                                        data-discount="${promotion.discountPercent}"
                                        data-max-discount="<fmt:formatNumber value="${promotion.maxDiscountAmount}" pattern="#,###" maxFractionDigits="0"/>"
                                        data-quantity="${promotion.quantity}"
                                        data-status="${promotion.active ? 'Khả dụng' : 'Ngừng'}"
                                        data-start-date='<fmt:formatDate value="${promotion.startDate}" pattern="dd-MM-yyyy"/>'
                                        data-end-date='<c:if test="${not empty promotion.endDate}"><fmt:formatDate value="${promotion.endDate}" pattern="dd-MM-yyyy"/></c:if>'
                                        data-description="${promotion.description}">
                                        <td>${(currentPage - 1) * 8 + loop.index + 1}</td>
                                        <td>${promotion.title}</td>
                                        <td>${promotion.promotionType}</td>
                                        <td><fmt:formatNumber value="${promotion.discountPercent}" maxFractionDigits="0"/>%</td>
                                        <td><fmt:formatNumber value="${promotion.maxDiscountAmount}" maxFractionDigits="0" pattern="#,###"/>đ</td>
                                        <td>
                                            <span class="${promotion.active ? 'status-active' : 'status-inactive'}">
                                                ${promotion.active ? 'Khả dụng' : 'Ngừng'}
                                            </span>
                                        </td>
                                        <td><c:if test="${not empty promotion.endDate}"><fmt:formatDate value="${promotion.endDate}" pattern="dd-MM-yyyy"/></c:if></td>
                                        <td>
                                            <div class="action-buttons">
                                                <div class="horizontal-buttons">
                                                    <a href="editPromotion?promotionId=${promotion.promotionId}&page=${currentPage}&search=${search}&type=${type}&status=${status}&dateFilter=${dateFilter}&sortBy=${sortBy}"
                                                       class="btn btn-sm btn-action btn-edit" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <form action="managePromotions" method="post" style="margin: 0; display: inline;">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="promotionId" value="${promotion.promotionId}">
                                                        <input type="hidden" name="page" value="${currentPage}">
                                                        <input type="hidden" name="search" value="${search}">
                                                        <input type="hidden" name="type" value="${type}">
                                                        <input type="hidden" name="status" value="${status}">
                                                        <input type="hidden" name="dateFilter" value="${dateFilter}">
                                                        <input type="hidden" name="sortBy" value="${sortBy}">
                                                        <button type="submit" class="btn btn-sm btn-action btn-delete" title="Xóa" onclick="return confirm('Bạn có chắc chắn muốn xóa khuyến mãi này không?');">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                                <form action="managePromotions" method="post" style="margin: 0; width: 100%;">
                                                    <input type="hidden" name="action" value="toggleStatus">
                                                    <input type="hidden" name="promotionId" value="${promotion.promotionId}">
                                                    <input type="hidden" name="isActive" value="${!promotion.active}">
                                                    <input type="hidden" name="page" value="${currentPage}">
                                                    <input type="hidden" name="search" value="${search}">
                                                    <input type="hidden" name="type" value="${type}">
                                                    <input type="hidden" name="status" value="${status}">
                                                    <input type="hidden" name="dateFilter" value="${dateFilter}">
                                                    <input type="hidden" name="sortBy" value="${sortBy}">
                                                    <button type="submit" class="btn btn-sm btn-action status-button ${promotion.active ? 'btn-deactivate' : 'btn-activate'}">
                                                        <i class="fas ${promotion.active ? 'fa-pause' : 'fa-play'}"></i>
                                                        ${promotion.active ? 'Tạm Ngừng' : 'Kích Hoạt'}
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="managePromotions?page=${currentPage - 1}&search=${search}&type=${type}&status=${status}&dateFilter=${dateFilter}&sortBy=${sortBy}">Trước</a>
                            </li>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="managePromotions?page=${i}&search=${search}&type=${type}&status=${status}&dateFilter=${dateFilter}&sortBy=${sortBy}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="managePromotions?page=${currentPage + 1}&search=${search}&type=${type}&status=${status}&dateFilter=${dateFilter}&sortBy=${sortBy}">Tiếp theo</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
            <div class="modal fade" id="promotionModal" tabindex="-1" aria-labelledby="promotionModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="promotionModalLabel">Chi Tiết Khuyến Mãi</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p><strong>ID:</strong> <span id="modal-promotion-id"></span></p>
                            <p><strong>Tiêu Đề:</strong> <span id="modal-title"></span></p>
                            <p><strong>Mã Khuyến Mãi:</strong> <span id="modal-promo-code"></span></p>
                            <p><strong>Loại:</strong> <span id="modal-type"></span></p>
                            <p><strong>Phần Trăm Giảm Giá:</strong> <span id="modal-discount"></span>%</p>
                            <p><strong>Giảm Tối Đa:</strong> <span id="modal-max-discount"></span>đ</p>
                            <p><strong>Số Lượng:</strong> <span id="modal-quantity"></span></p>
                            <p><strong>Trạng Thái:</strong> <span id="modal-status"></span></p>
                            <p><strong>Ngày Bắt Đầu:</strong> <span id="modal-start-date"></span></p>
                            <p><strong>Ngày Kết Thúc:</strong> <span id="modal-end-date"></span></p>
                            <p><strong>Mô Tả:</strong> <span id="modal-description"></span></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            $('tbody tr').on('click', function(e) {
                if ($(e.target).closest('td').is(':last-child') || $(e.target).is('button, input, a, i')) {
                    return;
                }
                const promotionId = $(this).data('promotion-id');
                const title = $(this).data('title');
                const promoCode = $(this).data('promo-code');
                const type = $(this).data('type');
                const discount = $(this).data('discount');
                const maxDiscount = $(this).data('max-discount');
                const quantity = $(this).data('quantity');
                const status = $(this).data('status');
                const startDate = $(this).data('start-date');
                const endDate = $(this).data('end-date') || 'Không có';
                const description = $(this).data('description') || 'Không có';
                $('#modal-promotion-id').text(promotionId);
                $('#modal-title').text(title);
                $('#modal-promo-code').text(promoCode);
                $('#modal-type').text(type);
                $('#modal-discount').text(discount);
                $('#modal-max-discount').text(maxDiscount);
                $('#modal-quantity').text(quantity);
                $('#modal-status').text(status);
                $('#modal-start-date').text(startDate);
                $('#modal-end-date').text(endDate);
                $('#modal-description').text(description);
                $('#promotionModal').modal('show');
            });
        });
    </script>
</body>
</html>