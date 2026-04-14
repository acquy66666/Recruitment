<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử bài thi</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f9fafb;
            color: #111827;
            line-height: 1.5;
        }
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 24px;
        }
        .header {
            margin-bottom: 24px;
        }
        .header h1 {
            font-size: 30px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 4px;
        }
        .header p {
            color: #6b7280;
        }
        .card {
            background: white;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }
        .card-content {
            padding: 24px;
        }
        .table-container {
            overflow-x: auto;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }
        .table th {
            font-weight: 600;
            color: #374151;
            background-color: #f9fafb;
        }
        .table td {
            color: #111827;
        }
        .badge {
            display: inline-flex;
            align-items: center;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
            background-color: #d1fae5;
            color: #065f46;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
            background-color: #2563eb;
            color: white;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #1d4ed8;
        }
        .empty-state {
            text-align: center;
            padding: 48px 24px;
        }
        .empty-state svg {
            width: 48px;
            height: 48px;
            color: #9ca3af;
            margin: 0 auto 16px;
        }
        .empty-state h3 {
            font-size: 14px;
            font-weight: 500;
            color: #111827;
            margin-bottom: 4px;
        }
        .empty-state p {
            font-size: 14px;
            color: #6b7280;
        }
        @media (max-width: 768px) {
            .table th, .table td {
                padding: 8px;
            }
            .table-container {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Lịch sử bài thi</h1>
            <p>Xem lại các bài thi bạn đã hoàn thành</p>
        </div>
        <div class="card">
            <div class="card-content">
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Tiêu đề bài thi</th>
                                <th>Công việc</th>
                                <th>Số câu đúng</th>
                                <th>Tổng số câu</th>
                                <th>Tỷ lệ đúng</th>
                                <th>Ngày hoàn thành</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${historyItems}">
                                <tr>
                                    <td>${item.testTitle}</td>
                                    <td>${item.jobTitle}</td>
                                    <td>${item.assignment.correctAnswer}</td>
                                    <td>${item.assignment.totalQuestion}</td>
                                    <td><fmt:formatNumber value="${item.assignment.score}" pattern="#.##"/>%</td>
                                    <td><fmt:formatDate value="${item.assignment.completedAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>
                                        <a href="TestHistory?assignmentId=${item.assignment.assignmentId}" class="btn">
                                            Xem chi tiết
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${empty historyItems}">
                    <div class="empty-state">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                            <polyline points="14,2 14,8 20,8"/>
                            <line x1="16" y1="13" x2="8" y2="13"/>
                            <line x1="16" y1="17" x2="8" y2="17"/>
                            <polyline points="10,9 9,9 8,9"/>
                        </svg>
                        <h3>Không tìm thấy bài thi</h3>
                        <p>Bạn chưa hoàn thành bài thi nào.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>