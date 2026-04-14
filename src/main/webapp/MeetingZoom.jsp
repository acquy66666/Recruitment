<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tạo Cuộc Họp Phỏng Vấn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .meeting-form {
                max-width: 600px;
                margin: 50px auto;
                background: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 0 12px rgba(0,0,0,0.1);
            }
            .result-box {
                background: #e9f7ef;
                padding: 20px;
                border-radius: 10px;
                margin-top: 30px;
            }
            #messages {
                max-height: 300px;
                overflow-y: auto;
                background: #222;
                color: #fff;
                padding: 10px;
                border-radius: 5px;
            }
            .message.user {
                text-align: right;
                color: #0f0;
                margin-bottom: 5px;
            }
            .message.bot {
                text-align: left;
                color: #0cf;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <!--
                <iframe
                    allow="camera; microphone; fullscreen; display-capture"
                    src="https://meet.jit.si/PhongVanUngVien_12345"
                    style="height: 600px; width: 100%; border: 0px;">
                </iframe>-->

        <!--        <script>
                    document.getElementById('meetingForm').addEventListener('submit', async function (e) {
                        e.preventDefault();
        
                        const candidateId = document.getElementById('candidateId').value;
                        const recruiterId = document.getElementById('recruiterId').value;
                        const dateTimeInput = document.getElementById('dateTime').value;
                        const note = document.getElementById('note').value;
        
                        // Chuyển sang định dạng ISO 8601
                        const isoDateTime = dateTimeInput + ':00Z';
        
                        const payload = {
                            candidateId,
                            recruiterId,
                            dateTime: isoDateTime,
                            note
                        };
        
                        try {
                            const response = await fetch('/api/meetings/create', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify(payload)
                            });
        
                            if (!response.ok)
                                throw new Error('Không thể tạo cuộc họp');
        
                            const result = await response.json();
        
                            document.getElementById('resTime').innerText = result.dateTime;
                            document.getElementById('resPassword').innerText = result.password;
                            document.getElementById('joinUrl').href = result.joinUrl;
                            document.getElementById('startUrl').href = result.startUrl;
        
                            document.getElementById('result').style.display = 'block';
                        } catch (error) {
                            alert('❌ Lỗi khi tạo cuộc họp: ' + error.message);
                        }
                    });
                </script>-->

        <div class="card shadow">
            <div class="card-body">
                <h5 class="card-title">Phòng phỏng vấn</h5>

                <div id="meet" style="height: 700px; width: 100%;"></div>

                <!-- Div hiển thị sau khi call xong -->
                <div id="call-ended" style="display: none;" class="mt-3 alert alert-success">
                    Cuộc gọi đã kết thúc.
                </div>
            </div>
        </div>

        <!-- Nhúng Jitsi JS -->
        <script src='https://8x8.vc/external_api.js'></script>
        <div id="meet" style="height: 800px;"></div>
        <c:if test="${not empty sessionScope.Recruiter}">
            <script>
                const jwtToken = "${recruiterToken}";
                const domain = "8x8.vc";
                const options = {
                roomName: "vpaas-magic-cookie-8fd3c3b144904eb8b121838389334cdc/interview-room",
                        parentNode: document.getElementById("meet"),
                        jwt: jwtToken
                };
                const api = new JitsiMeetExternalAPI(domain, options);
                api.addEventListener('readyToClose', () => {
                const meetElement = document.getElementById("meet");
                meetElement.style.display = "none";
                const messageDiv = document.createElement("div");
                messageDiv.innerText = "Cuộc gọi đã kết thúc.";
                messageDiv.style.position = "fixed";
                messageDiv.style.top = "50%";
                messageDiv.style.left = "50%";
                messageDiv.style.transform = "translate(-50%, -50%)";
                messageDiv.style.padding = "20px";
                messageDiv.style.backgroundColor = "#f44336";
                messageDiv.style.color = "white";
                messageDiv.style.fontSize = "18px";
                messageDiv.style.borderRadius = "8px";
                messageDiv.style.zIndex = "10000";
                document.body.appendChild(messageDiv);
                // Ẩn sau 5 giây và chuyển hướng
                setTimeout(() => {
                messageDiv.remove();
                window.location.href = "scheduledInterviews.jsp"; // 🔁 Thay bằng trang bạn muốn quay về
                }, 3000);
                });
            </script>
        </c:if>
        <c:if test="${not empty sessionScope.Candidate}">
            <script>
                const jwtToken = "${candidateToken}";
                const domain = "8x8.vc";
                const options = {
                roomName: "vpaas-magic-cookie-8fd3c3b144904eb8b121838389334cdc/interview-room",
                        parentNode: document.getElementById("meet"),
                        jwt: jwtToken
                };
                const api = new JitsiMeetExternalAPI(domain, options);
                api.addEventListener('readyToClose', () => {
                const meetElement = document.getElementById("meet");
                meetElement.style.display = "none";
                const messageDiv = document.createElement("div");
                messageDiv.innerText = "Cuộc gọi đã kết thúc.";
                messageDiv.style.position = "fixed";
                messageDiv.style.top = "50%";
                messageDiv.style.left = "50%";
                messageDiv.style.transform = "translate(-50%, -50%)";
                messageDiv.style.padding = "20px";
                messageDiv.style.backgroundColor = "#f44336";
                messageDiv.style.color = "white";
                messageDiv.style.fontSize = "18px";
                messageDiv.style.borderRadius = "8px";
                messageDiv.style.zIndex = "10000";
                document.body.appendChild(messageDiv);
                // Ẩn sau 5 giây
                setTimeout(() => {
                messageDiv.remove();
                window.location.href = "scheduledInterviews.jsp"; // 🔁 Thay bằng trang bạn muốn quay về
                }, 3000);
                });
            </script>
        </c:if>
    </body>
</html>
