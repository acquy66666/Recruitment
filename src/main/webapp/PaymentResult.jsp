<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Giao Dịch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Thông Tin Giao Dịch</h1>
        <%
            String status = request.getParameter("status");
            String message;
            String alertClass;
            if ("success".equals(status)) {
                message = "Giao dịch thành công";
                alertClass = "alert-success";
            } else if ("pending".equals(status)) {
                message = "Giao dịch đang được xử lí";
                alertClass = "alert-warning";
            } else {
                message = "Giao dịch thất bại. Vui lòng thử lại";
                alertClass = "alert-danger";
            }
        %>
        <div class="alert <%= alertClass %>">
            <%= message %>
        </div>
        <a href="<%= request.getContextPath() %>/transactionHistory" class="btn btn-primary">View Transaction History</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>