<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thông báo</title>
    <style>
        .notification {
            border-bottom: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
        }
        .notification-title {
            font-weight: bold;
            color: #333;
        }
        .notification-message {
            margin: 5px 0;
            color: #666;
        }
        .notification-date {
            font-size: 0.9em;
            color: #999;
        }
    </style>
</head>
<body>
    <h2>Thông báo của bạn</h2>
    <c:forEach var="n" items="${notifications}">
        <div class="notification">
            <div class="notification-title">${n.title}</div>
            <div class="notification-message">${n.message}</div>
            <div class="notification-date">${n.createdAt}</div>
        </div>
    </c:forEach>
    
    <c:if test="${empty notifications}">
        <p>Bạn chưa có thông báo nào.</p>
    </c:if>
</body>
</html>
