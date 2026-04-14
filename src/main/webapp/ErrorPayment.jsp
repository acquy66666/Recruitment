<%-- 
    Document   : ErrorPayment
    Created on : Jun 24, 2025, 11:34:16 AM
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Payment Error</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        h1 { color: #dc3545; }
        .info-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .info-table th, .info-table td { padding: 10px; border: 1px solid #ddd; }
        .info-table th { background-color: #f8f9fa; }
        .btn { display: inline-block; padding: 10px 20px; margin-top: 20px; text-decoration: none; color: #fff; background-color: #007bff; border-radius: 5px; }
        .btn:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Thanh toán thất bại</h1>
        <p>Đã xảy ra sự cố trong quá trình xử lý thanh toán. Vui lòng thử lại hoặc liên hệ bộ phận hỗ trợ.</p>
        <c:choose>
            <c:when test="${not empty paymentInfo}">
                <table class="info-table">
                    <tr>
                        <th>Mã giao dịch</th>
                        <td><c:out value="${paymentInfo.transactionId}" /></td>
                    </tr>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <td><c:out value="${paymentInfo.orderId}" /></td>
                    </tr>
                    <tr>
                        <th>Mã tham chiếu giao dịch VNPay</th>
                        <td><c:out value="${paymentInfo.vnpTxnRef}" /></td>
                    </tr>
                    <tr>
                        <th>Số tiền</th>
                        <td><c:out value="${paymentInfo.amount}" /> VND</td>
                    </tr>
                    <tr>
                        <th>Phương thức thanh toán</th>
                        <td><c:out value="${paymentInfo.paymentMethod}" /></td>
                    </tr>
                    <tr>
                        <th>Ngày giao dịch</th>
                        <td><c:out value="${paymentInfo.transactionDate}" /></td>
                    </tr>
                    <tr>
                        <th>Trạng thái</th>
                        <td><c:out value="${paymentInfo.status}" /></td>
                    </tr>
                    <tr>
                        <th>Thông báo</th>
                        <td><c:out value="${paymentInfo.message}" /></td>
                    </tr>
                </table>
            </c:when>
            <c:otherwise>
                <p><c:out value="${paymentMessage}" default="Không có thông tin bổ sung." /></p>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/buyServices" class="btn">Thử lại</a>
        <a href="${pageContext.request.contextPath}/HomePage" class="btn">Quay về trang chủ</a>
    </div>
</body>
</html>