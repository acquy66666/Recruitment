<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả bài thi - ${test.title}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
            line-height: 1.6;
        }
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 24px;
        }
        .result-card {
            background: white;
            border-radius: 12px;
            padding: 32px;
            margin-bottom: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .result-title {
            font-size: 2rem;
            font-weight: 700;
            color: #111827;
            margin-bottom: 16px;
        }
        .result-message {
            font-size: 1.2rem;
            color: #10b981;
            margin-bottom: 24px;
        }
        .result-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }
        .detail-item {
            background: #f3f4f6;
            border-radius: 8px;
            padding: 16px;
        }
        .detail-label {
            font-size: 14px;
            color: #6b7280;
            font-weight: 500;
        }
        .detail-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #111827;
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 16px;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
            text-decoration: none;
        }
        .btn-primary {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            color: white;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #1d4ed8, #1e40af);
            transform: translateY(-1px);
        }
        .btn-secondary {
            background: linear-gradient(135deg, #6b7280, #4b5563);
            color: white;
        }
        .btn-secondary:hover {
            background: linear-gradient(135deg, #4b5563, #374151);
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="result-card">
            <h1 class="result-title">Kết quả bài thi: ${test.title}</h1>
            <p class="result-message">Chúc mừng bạn đã hoàn thành bài thi!</p>
            <div class="result-details">
                <div class="detail-item">
                    <div class="detail-label">Số câu đúng</div>
                    <div class="detail-value">${assignment.correctAnswer}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Số câu sai</div>
                    <div class="detail-value">${assignment.totalQuestion - assignment.correctAnswer}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Tỷ lệ đúng</div>
                    <div class="detail-value"><fmt:formatNumber value="${assignment.score}" pattern="#.##"/>%</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Ngày hoàn thành</div>
                    <div class="detail-value"><fmt:formatDate value="${assignment.completedAt}" pattern="dd/MM/yyyy HH:mm"/></div>
                </div>
            </div>
            <div class="action-buttons">
                <a href="index.jsp" class="btn btn-primary">
                    <svg class="icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                        <polyline points="9 22 9 12 15 12 15 22"/>
                    </svg>
                    Trở về trang chủ
                </a>
                <a href="TestHistory" class="btn btn-secondary">
                    <svg class="icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M12 2v2m0 16v2m10-10h-2M4 12H2m15.364-7.364l-1.414 1.414M6.636 17.364l-1.414 1.414M17.364 17.364l1.414 1.414M6.636 6.636l-1.414-1.414"/>
                        <path d="M12 6a6 6 0 0 0-6 6h3l-3 3-3-3h3a9 9 0 1 1 0 18"/>
                    </svg>
                    Lịch sử bài làm
                </a>
            </div>
        </div>
    </div>
</body>
</html>