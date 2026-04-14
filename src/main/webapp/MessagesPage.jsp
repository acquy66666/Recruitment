<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin nhắn - JobHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #0046aa;
            --secondary-color: #ff6b00;
            --success-color: #2dce89;
            --light-gray: #f0f6ff;
        }
        
        * {
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-gray);
            height: 100vh;
            overflow: hidden;
        }
        
        .chat-container {
            height: 100vh;
            padding: 0;
        }
        
        .chat-sidebar {
            height: 100vh;
            background: white;
            border-right: 1px solid #e9ecef;
            overflow-y: auto;
        }
        
        .chat-main {
            height: 100vh;
            display: flex;
            flex-direction: column;
            background: #f8f9fa;
        }
        
        .chat-header {
            padding: 1rem 1.5rem;
            background: white;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .chat-user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }
        
        .chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 1.5rem;
        }
        
        .message {
            margin-bottom: 1rem;
            display: flex;
        }
        
        .message.sent {
            justify-content: flex-end;
        }
        
        .message.received {
            justify-content: flex-start;
        }
        
        .message-bubble {
            max-width: 70%;
            padding: 0.75rem 1rem;
            border-radius: 15px;
            position: relative;
        }
        
        .message.sent .message-bubble {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            color: white;
            border-bottom-right-radius: 5px;
        }
        
        .message.received .message-bubble {
            background: white;
            color: #333;
            border-bottom-left-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .message-time {
            font-size: 0.7rem;
            opacity: 0.7;
            margin-top: 0.25rem;
        }
        
        .message.sent .message-time {
            text-align: right;
        }
        
        .chat-input {
            padding: 1rem 1.5rem;
            background: white;
            border-top: 1px solid #e9ecef;
        }
        
        .conversation-item {
            padding: 1rem 1.5rem;
            cursor: pointer;
            border-bottom: 1px solid #f0f4f8;
            transition: all 0.2s ease;
        }
        
        .conversation-item:hover,
        .conversation-item.active {
            background: #e6f0ff;
        }
        
        .conversation-item.active {
            border-left: 3px solid var(--primary-color);
        }
        
        .conversation-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            color: var(--primary-color);
            flex-shrink: 0;
        }
        
        .unread-badge {
            width: 10px;
            height: 10px;
            background: var(--secondary-color);
            border-radius: 50%;
            position: absolute;
            top: 0;
            right: 0;
        }
        
        .search-box {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #e9ecef;
        }
        
        .search-input {
            border-radius: 25px;
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            border: 1px solid #e9ecef;
            background: #f8f9fa;
        }
        
        .search-input:focus {
            border-color: var(--primary-color);
            box-shadow: none;
        }
        
        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #adb5bd;
        }
        
        .no-chat-selected {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
            flex-direction: column;
            color: #adb5bd;
        }
        
        .no-chat-selected i {
            font-size: 5rem;
            margin-bottom: 1rem;
        }
        
        .attachment-btn,
        .send-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            transition: all 0.3s ease;
        }
        
        .attachment-btn {
            background: #e9ecef;
            color: #6c757d;
            margin-right: 0.5rem;
        }
        
        .attachment-btn:hover {
            background: #dee2e6;
        }
        
        .send-btn {
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            color: white;
        }
        
        .send-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0, 70, 170, 0.3);
        }
        
        .message-input {
            flex: 1;
            border-radius: 25px;
            padding: 0.75rem 1.5rem;
            border: 1px solid #e9ecef;
            background: #f8f9fa;
        }
        
        .message-input:focus {
            border-color: var(--primary-color);
            box-shadow: none;
            background: white;
        }
        
        .chat-list-header {
            padding: 1rem 1.5rem;
            background: linear-gradient(135deg, var(--primary-color) 0%, #0051ff 100%);
            color: white;
        }
        
        .online-dot {
            width: 10px;
            height: 10px;
            background: var(--success-color);
            border-radius: 50%;
            border: 2px solid white;
        }
        
        .typing-indicator {
            display: none;
            padding: 0.5rem;
            color: #adb5bd;
            font-size: 0.8rem;
            font-style: italic;
        }
        
        @media (max-width: 768px) {
            .chat-sidebar {
                display: none;
            }
            
            .chat-sidebar.show {
                display: block;
                position: fixed;
                width: 100%;
                z-index: 100;
            }
        }
    </style>
</head>
<body>
    <%
            com.recruitment.model.Candidate candidate = (com.recruitment.model.Candidate) session.getAttribute("Candidate");
            com.recruitment.model.Recruiter recruiter = (com.recruitment.model.Recruiter) session.getAttribute("Recruiter");
            
            if (candidate == null && recruiter == null) {
                response.sendRedirect("login");
                return;
            }
    %>

    <div class="container-fluid chat-container">
        <div class="row h-100">
            <!-- Chat List Sidebar -->
            <div class="col-md-4 col-lg-3 chat-sidebar" id="chatSidebar">
                <div class="chat-list-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-chat-dots me-2"></i>Tin nhắn</h5>
                        <button class="btn btn-sm btn-light rounded-circle">
                            <i class="bi bi-pen"></i>
                        </button>
                    </div>
                </div>
                
                <div class="search-box">
                    <div class="position-relative">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" class="form-control search-input" placeholder="Tìm kiếm tin nhắn...">
                    </div>
                </div>
                
                <div class="conversations-list">
                    <!-- Conversation 1 -->
                    <div class="conversation-item active" onclick="selectConversation(this)">
                        <div class="d-flex align-items-center position-relative">
                            <div class="conversation-avatar me-3">
                                FPT
                            </div>
                            <div class="flex-grow-1 overflow-hidden">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">FPT Software</h6>
                                    <small class="text-muted">10:30</small>
                                </div>
                                <p class="mb-0 text-muted small text-truncate">
                                    Cảm ơn bạn đã ứng tuyển. Chúng tôi muốn mời bạn phỏng vấn...
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Conversation 2 -->
                    <div class="conversation-item" onclick="selectConversation(this)">
                        <div class="d-flex align-items-center position-relative">
                            <div class="conversation-avatar me-3">
                                VNG
                            </div>
                            <div class="flex-grow-1 overflow-hidden">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">VNG Corporation</h6>
                                    <small class="text-muted">09:15</small>
                                </div>
                                <p class="mb-0 text-muted small text-truncate">
                                    Chúc mừng bạn đã pass vòng phỏng vấn!
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Conversation 3 -->
                    <div class="conversation-item" onclick="selectConversation(this)">
                        <div class="d-flex align-items-center position-relative">
                            <div class="conversation-avatar me-3">
                                <span class="position-relative">
                                    Viettel
                                    <span class="unread-badge"></span>
                                </span>
                            </div>
                            <div class="flex-grow-1 overflow-hidden">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0 fw-bold">Viettel</h6>
                                    <small class="text-muted">Hôm qua</small>
                                </div>
                                <p class="mb-0 small text-truncate fw-bold">
                                    Chúng tôi đã xem CV của bạn và rất ấn tượng...
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Conversation 4 -->
                    <div class="conversation-item" onclick="selectConversation(this)">
                        <div class="d-flex align-items-center">
                            <div class="conversation-avatar me-3">
                                Shop
                            </div>
                            <div class="flex-grow-1 overflow-hidden">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">Shopee</h6>
                                    <small class="text-muted">2 ngày</small>
                                </div>
                                <p class="mb-0 text-muted small text-truncate">
                                    Cảm ơn bạn đã quan tâm đến vị trí này...
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Conversation 5 -->
                    <div class="conversation-item" onclick="selectConversation(this)">
                        <div class="d-flex align-items-center">
                            <div class="conversation-avatar me-3">
                                Laz
                            </div>
                            <div class="flex-grow-1 overflow-hidden">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="mb-0">Lazada</h6>
                                    <small class="text-muted">3 ngày</small>
                                </div>
                                <p class="mb-0 text-muted small text-truncate">
                                    Bạn có thể cho chúng tôi biết thời gian rảnh để phỏng vấn không?
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Chat Main Area -->
            <div class="col-md-8 col-lg-9 chat-main">
                <!-- Chat Header -->
                <div class="chat-header">
                    <button class="btn btn-sm btn-outline-secondary d-md-none me-2" onclick="toggleSidebar()">
                        <i class="bi bi-list"></i>
                    </button>
                    <div class="chat-user-avatar">
                        FPT
                    </div>
                    <div class="flex-grow-1">
                        <h6 class="mb-0">FPT Software</h6>
                        <small class="text-success">
                            <span class="online-dot d-inline-block me-1"></span>Online
                        </small>
                    </div>
                    <div class="dropdown">
                        <button class="btn btn-link text-muted" type="button" data-bs-toggle="dropdown">
                            <i class="bi bi-three-dots-vertical"></i>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Xem hồ sơ</a></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-bell me-2"></i>Tắt thông báo</a></li>
                            <li><a class="dropdown-item text-danger" href="#"><i class="bi bi-trash me-2"></i>Xóa tin nhắn</a></li>
                        </ul>
                    </div>
                </div>
                
                <!-- Messages Area -->
                <div class="chat-messages" id="chatMessages">
                    <div class="message received">
                        <div class="message-bubble">
                            <div>Xin chào! Cảm ơn bạn đã ứng tuyển vị trí Senior Developer tại FPT Software.</div>
                            <div class="message-time">10:30 AM</div>
                        </div>
                    </div>
                    
                    <div class="message sent">
                        <div class="message-bubble">
                            <div>Xin chào! Em rất vui khi nhận được phản hồi từ công ty. Em có thể thông tin thêm về vị trí này được không ạ?</div>
                            <div class="message-time">10:32 AM</div>
                        </div>
                    </div>
                    
                    <div class="message received">
                        <div class="message-bubble">
                            <div>Đây là vị trí Senior Developer với yêu cầu 5+ năm kinh nghiệm. Mức lương từ 25-35 triệu VNĐ/tháng, thưởng cuối năm, bảo hiểm đầy đủ.</div>
                            <div class="message-time">10:35 AM</div>
                        </div>
                    </div>
                    
                    <div class="message received">
                        <div class="message-bubble">
                            <div>Chúng tôi muốn mời bạn tham gia phỏng vấn vào ngày 15/04/2024 lúc 14:00 tại tòa nhà FPT Tower, Quận 9, TP.HCM. Bạn có thể tham gia được không?</div>
                            <div class="message-time">10:36 AM</div>
                        </div>
                    </div>
                    
                    <div class="message sent">
                        <div class="message-bubble">
                            <div>Dạ, em có thể tham gia phỏng vấn vào ngày và giờ đó ạ. Em sẽ đến đúng giờ. Cảm ơn anh/chị đã mời em!</div>
                            <div class="message-time">10:40 AM</div>
                        </div>
                    </div>
                    
                    <div class="message received">
                        <div class="message-bubble">
                            <div>Tuyệt vời! Khi đến, bạn vui lòng mang theo CV bản cứng và CMND/CCCD. Chúc bạn chuẩn bị tốt!</div>
                            <div class="message-time">10:42 AM</div>
                        </div>
                    </div>
                </div>
                
                <!-- Typing Indicator -->
                <div class="typing-indicator px-3">
                    <i class="bi bi-three-dots"></i> Đang nhập...
                </div>
                
                <!-- Message Input -->
                <div class="chat-input">
                    <form class="d-flex align-items-center" onsubmit="sendMessage(event)">
                        <button type="button" class="attachment-btn">
                            <i class="bi bi-paperclip"></i>
                        </button>
                        <input type="text" class="form-control message-input" id="messageInput" 
                               placeholder="Nhập tin nhắn..." autocomplete="off">
                        <button type="button" class="attachment-btn">
                            <i class="bi bi-emoji-smile"></i>
                        </button>
                        <button type="submit" class="send-btn ms-2">
                            <i class="bi bi-send"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function selectConversation(element) {
            // Remove active class from all conversations
            document.querySelectorAll('.conversation-item').forEach(item => {
                item.classList.remove('active');
            });
            
            // Add active class to selected conversation
            element.classList.add('active');
            
            // On mobile, hide sidebar
            if (window.innerWidth < 768) {
                document.getElementById('chatSidebar').classList.remove('show');
            }
        }
        
        function toggleSidebar() {
            document.getElementById('chatSidebar').classList.toggle('show');
        }
        
        function sendMessage(event) {
            event.preventDefault();
            
            const input = document.getElementById('messageInput');
            const message = input.value.trim();
            
            if (message) {
                const messagesContainer = document.getElementById('chatMessages');
                
                // Create sent message
                const sentMessage = document.createElement('div');
                sentMessage.className = 'message sent';
                sentMessage.innerHTML = `
                    <div class="message-bubble">
                        <div>${escapeHtml(message)}</div>
                        <div class="message-time">${getCurrentTime()}</div>
                    </div>
                `;
                
                messagesContainer.appendChild(sentMessage);
                
                // Clear input
                input.value = '';
                
                // Scroll to bottom
                messagesContainer.scrollTop = messagesContainer.scrollHeight;
                
                // Simulate response after 1 second
                setTimeout(() => {
                    simulateResponse();
                }, 1000);
            }
        }
        
        function simulateResponse() {
            const messagesContainer = document.getElementById('chatMessages');
            
            // Show typing indicator
            const typingIndicator = document.querySelector('.typing-indicator');
            typingIndicator.style.display = 'block';
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
            
            // Simulate received message after delay
            setTimeout(() => {
                typingIndicator.style.display = 'none';
                
                const receivedMessage = document.createElement('div');
                receivedMessage.className = 'message received';
                receivedMessage.innerHTML = `
                    <div class="message-bubble">
                        <div>Cảm ơn bạn đã nhắn tin! Chúng tôi sẽ phản hồi sớm nhất có thể.</div>
                        <div class="message-time">${getCurrentTime()}</div>
                    </div>
                `;
                
                messagesContainer.appendChild(receivedMessage);
                messagesContainer.scrollTop = messagesContainer.scrollHeight;
            }, 2000);
        }
        
        function getCurrentTime() {
            const now = new Date();
            return now.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' });
        }
        
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
        
        // Auto-scroll to bottom on load
        document.addEventListener('DOMContentLoaded', function() {
            const messagesContainer = document.getElementById('chatMessages');
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        });
    </script>
</body>
</html>
