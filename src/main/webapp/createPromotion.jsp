<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Khuyến Mãi | MyJob</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            --link-color: #0066ff;
            --box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            --transition-speed: 0.3s;
            --sidebar-width: 250px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }

        body {
            background-color: var(--light-gray);
            color: var(--secondary-color);
            line-height: 1.6;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            z-index: 1000;
            overflow-y: auto;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 20px;
            min-height: 100vh;
            width: calc(100% - var(--sidebar-width));
            box-sizing: border-box;
        }

        .card {
            margin-bottom: 20px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: var(--box-shadow);
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--secondary-color);
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 15px;
            transition: all var(--transition-speed);
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(0, 70, 184, 0.1);
            outline: none;
        }

        .form-control::placeholder {
            color: #adb5bd;
        }

        .form-control.is-invalid {
            border-color: var(--error-color);
        }

        .invalid-feedback {
            display: none;
            width: 100%;
            margin-top: 5px;
            font-size: 12px;
            color: var(--error-color);
        }

        .form-control.is-invalid ~ .invalid-feedback {
            display: block;
        }

        .btn {
            padding: 12px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all var(--transition-speed);
        }

        .btn-primary {
            background-color: var(--accent-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--accent-hover);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background-color: var(--medium-gray);
            color: var(--secondary-color);
        }

        .btn-secondary:hover {
            background-color: var(--dark-gray);
            color: white;
            transform: translateY(-2px);
        }

        .error-message {
            background-color: rgba(220, 53, 69, 0.1);
            color: var(--error-color);
            padding: 12px 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .error-message i {
            margin-right: 10px;
            font-size: 16px;
        }

        .date-field {
            position: relative;
        }

        .date-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--dark-gray);
            font-size: 16px;
            pointer-events: none;
        }

        .date-field .form-control {
            padding-right: 40px;
        }

        @media (max-width: 1200px) {
            .main-content {
                margin-left: 0;
                width: 100%;
                padding: 15px;
            }

            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }

            .sidebar.active {
                transform: translateX(0);
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 10px;
            }

            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                transform: none;
            }

            :root {
                --sidebar-width: 0px;
            }
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
    %>

    <!-- Include Left Navbar -->
    <%@include file="leftNavbar.jsp" %>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <h2>Tạo Khuyến Mãi Mới</h2>

            <div class="card">
                <div class="card-body">
                    <!-- Display error message if present -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                        </div>
                    </c:if>

                    <form action="createPromotion" method="post" id="promotionForm">
                        <div class="form-group">
                            <label for="promotionType">Loại Khuyến Mãi</label>
                            <input type="text" class="form-control" id="promotionType" name="promotionType" 
                                   value="${param.promotionType}" placeholder="Nhập loại khuyến mãi" maxlength="50" required>
                            <div class="invalid-feedback">Vui lòng nhập loại khuyến mãi.</div>
                        </div>

                        <div class="form-group">
                            <label for="title">Tiêu Đề</label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   value="${param.title}" placeholder="Nhập tiêu đề khuyến mãi" maxlength="100" required>
                            <div class="invalid-feedback">Vui lòng nhập tiêu đề khuyến mãi.</div>
                        </div>

                        <div class="form-group">
                            <label for="promoCode">Mã Khuyến Mãi</label>
                            <input type="text" class="form-control" placeholder="Nhập mã khuyến mãi (6 kí tự chữ hoặc số)" id="promoCode" name="promoCode" 
                                   value="${param.promoCode}" 
                                   maxlength="6" required>
                            <div class="invalid-feedback">Mã khuyến mãi không hợp lệ.</div>
                        </div>

                        <div class="form-group">
                            <label for="quantity">Số Lượng</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" 
                                   value="${param.quantity}" min="1" placeholder="Nhập số lượng" required>
                            <div class="invalid-feedback">Số lượng phải lớn hơn hoặc bằng 1.</div>
                        </div>

                        <div class="form-group">
                            <label for="description">Mô Tả</label>
                            <textarea class="form-control" id="description" name="description" 
                                      maxlength="255" placeholder="Nhập mô tả khuyến mãi">${param.description}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="discountPercent">Phần Trăm Giảm Giá (%)</label>
                            <input type="number" class="form-control" id="discountPercent" name="discountPercent" 
                                   value="${param.discountPercent}" min="5" max="50" step="0.1" 
                                   placeholder="Nhập phần trăm giảm giá (5-50)" required>
                            <div class="invalid-feedback">Phần trăm giảm giá phải từ 5 đến 50.</div>
                        </div>

                        <div class="form-group">
                            <label for="maxDiscountAmount">Số Tiền Giảm Tối Đa</label>
                            <input type="text" class="form-control" id="maxDiscountAmount" name="maxDiscountAmount" 
                                   value="${param.maxDiscountAmount}" placeholder="Nhập số tiền giảm tối đa (5,000-200,000)" required>
                            <div class="invalid-feedback">Số tiền giảm tối đa phải từ 5,000 đến 2,000,000.</div>
                        </div>

                        <div class="form-group date-field">
                            <label for="startDate">Ngày Bắt Đầu</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" 
                                   value="${param.startDate}" required>
                            <span class="date-icon"><i class="fas fa-calendar-alt"></i></span>
                            <div class="invalid-feedback">Ngày bắt đầu phải từ hôm nay trở đi.</div>
                        </div>

                        <div class="form-group date-field">
                            <label for="endDate">Ngày Kết Thúc (Tùy Chọn)</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" 
                                   value="${param.endDate}">
                            <span class="date-icon"><i class="fas fa-calendar-alt"></i></span>
                            <div class="invalid-feedback">Ngày kết thúc phải sau ngày bắt đầu.</div>
                        </div>

                        <div class="form-group">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="isActive" name="isActive" 
                                       ${param.isActive == 'on' ? 'checked' : 'checked'}>
                                <label class="form-check-label" for="isActive">Kích Hoạt</label>
                            </div>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary flex-grow-1">Lưu</button>
                            <button type="button" class="btn btn-secondary flex-grow-1" id="clearButton">Xóa Tất Cả</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('promotionForm');
            const maxDiscountInput = document.getElementById('maxDiscountAmount');
            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');
            const clearButton = document.getElementById('clearButton');
            const today = new Date().toISOString().split('T')[0];

            // Set minimum start date to today
            startDateInput.setAttribute('min', today);

            // Format max discount with commas
            maxDiscountInput.addEventListener('input', function(e) {
                let value = this.value.replace(/,/g, '');
                if (/^\d*$/.test(value)) {
                    if (value) {
                        value = parseInt(value).toLocaleString('en-US');
                    }
                    this.value = value;
                } else {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });

            // Clear formatting for submission
            form.addEventListener('submit', function(e) {
                let maxDiscount = maxDiscountInput.value.replace(/,/g, '');
                maxDiscountInput.value = maxDiscount;

                let valid = true;

                // Validate max discount
                const maxDiscountNum = parseFloat(maxDiscount);
                if (isNaN(maxDiscountNum) || maxDiscountNum < 5000 || maxDiscountNum > 200000) {
                    maxDiscountInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    maxDiscountInput.classList.remove('is-invalid');
                }

                // Validate start date
                if (startDateInput.value < today) {
                    startDateInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    startDateInput.classList.remove('is-invalid');
                }

                // Validate end date
                if (endDateInput.value && endDateInput.value <= startDateInput.value) {
                    endDateInput.classList.add('is-invalid');
                    valid = false;
                } else {
                    endDateInput.classList.remove('is-invalid');
                }

                if (!valid) {
                    e.preventDefault();
                }
            });

            // Clear all fields
            clearButton.addEventListener('click', function() {
                form.reset();
                document.getElementById('isActive').checked = true;
                maxDiscountInput.value = '';
                startDateInput.setAttribute('min', today);
                // Regenerate promo code
                fetch('createPromotion?generateCode=true')
                    .then(response => response.text())
                    .then(code => document.getElementById('promoCode').value = code);
            });

            // Set end date minimum dynamically
            startDateInput.addEventListener('change', function() {
                endDateInput.setAttribute('min', this.value);
            });
        });
    </script>
</body>
</html>