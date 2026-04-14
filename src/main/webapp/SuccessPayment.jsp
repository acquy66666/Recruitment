<%-- 
    Document   : SuccessPayment
    Created on : Jun 24, 2025, 11:33:30 AM
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Payment Success</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        h1 { color: #28a745; }
        .info-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .info-table th, .info-table td { padding: 10px; border: 1px solid #ddd; }
        .info-table th { background-color: #f8f9fa; }
        .btn { display: inline-block; padding: 10px 20px; margin-top: 20px; text-decoration: none; color: #fff; background-color: #007bff; border-radius: 5px; }
        .btn:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Thanh toán thành công</h1>
        <p>Thanh toán của bạn đã được xử lý thành công. Dưới đây là thông tin chi tiết về giao dịch của bạn.</p>
        <c:if test="${not empty paymentInfo}">
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
                    <th>Số giao dịch VNPay</th>
                    <td><c:out value="${paymentInfo.vnpTransactionNo}" /></td>
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
        </c:if>
        <a href="${pageContext.request.contextPath}/HomePage" class="btn">Quay lại về trang chủ</a>
    </div>
</body>
</html>
