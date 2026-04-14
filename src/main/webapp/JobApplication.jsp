<%-- 
    Document   : JobApplication
    Created on : Jun 3, 2025, 8:50:51 PM
    Author     : GBCenter
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Job Application Form</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
                background-color: #f9fafb;
                color: #111827;
                line-height: 1.6;
            }

            .container {
                min-height: 100vh;
                padding: 2rem 1rem;
            }

            .form-container {
                max-width: 42rem;
                margin: 0 auto;
            }

            .header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .header h1 {
                font-size: 1.875rem;
                font-weight: 700;
                color: #111827;
                margin-bottom: 0.5rem;
            }

            .header p {
                color: #6b7280;
            }

            .card {
                background-color: white;
                border-radius: 0.5rem;
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
                overflow: hidden;
            }

            .card-header {
                padding: 1.5rem;
                border-bottom: 1px solid #e5e7eb;
            }

            .card-title {
                font-size: 1.25rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
            }

            .card-description {
                color: #6b7280;
                font-size: 0.875rem;
            }

            .card-content {
                padding: 1.5rem;
            }

            .form {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            @media (min-width: 768px) {
                .form-row {
                    grid-template-columns: 1fr 1fr;
                }
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .label {
                font-size: 0.875rem;
                font-weight: 500;
                color: #374151;
            }

            .required {
                color: #ef4444;
            }

            .input,
            .select,
            .textarea {
                width: 100%;
                padding: 0.75rem;
                border: 1px solid #d1d5db;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            }

            .input:focus,
            .select:focus,
            .textarea:focus {
                outline: none;
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            }

            .textarea {
                resize: vertical;
                min-height: 100px;
            }

            .file-upload {
                border: 2px dashed #d1d5db;
                border-radius: 0.5rem;
                padding: 1.5rem;
                text-align: center;
                transition: border-color 0.15s ease-in-out;
                cursor: pointer;
            }

            .file-upload:hover {
                border-color: #9ca3af;
            }

            .file-upload.has-file {
                border-color: #10b981;
                background-color: #f0fdf4;
            }

            .file-upload input {
                display: none;
            }

            .upload-icon {
                width: 2rem;
                height: 2rem;
                color: #9ca3af;
                margin: 0 auto 0.5rem;
            }

            .file-icon {
                width: 2rem;
                height: 2rem;
                color: #10b981;
                margin-right: 0.5rem;
            }

            .upload-text {
                font-size: 0.875rem;
                color: #6b7280;
            }

            .upload-subtext {
                font-size: 0.75rem;
                color: #9ca3af;
                margin-top: 0.25rem;
            }

            .file-info {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .file-name {
                font-size: 0.875rem;
                font-weight: 500;
                color: #059669;
            }

            .file-size {
                font-size: 0.75rem;
                color: #6b7280;
            }

            .checkbox-container {
                display: flex;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .checkbox {
                width: 1rem;
                height: 1rem;
                margin-top: 0.125rem;
            }

            .checkbox-label {
                font-size: 0.875rem;
                color: #374151;
            }

            .checkbox-label a {
                color: #3b82f6;
                text-decoration: none;
            }

            .checkbox-label a:hover {
                text-decoration: underline;
            }

            .alert {
                display: flex;
                align-items: flex-start;
                gap: 0.75rem;
                padding: 1rem;
                background-color: #fef3c7;
                border: 1px solid #f59e0b;
                border-radius: 0.375rem;
            }

            .alert-icon {
                width: 1rem;
                height: 1rem;
                color: #f59e0b;
                margin-top: 0.125rem;
            }

            .alert-text {
                font-size: 0.875rem;
                color: #92400e;
            }

            .button {
                width: 100%;
                padding: 0.75rem 1rem;
                background-color: #3b82f6;
                color: white;
                border: none;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.15s ease-in-out;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .button:hover:not(:disabled) {
                background-color: #2563eb;
            }

            .button:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            .button-outline {
                background-color: white;
                color: #374151;
                border: 1px solid #d1d5db;
            }

            .button-outline:hover:not(:disabled) {
                background-color: #f9fafb;
            }

            .spinner {
                width: 1rem;
                height: 1rem;
                border: 2px solid transparent;
                border-top: 2px solid currentColor;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            .success-container {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 1rem;
            }

            .success-card {
                width: 100%;
                max-width: 28rem;
                text-align: center;
                background-color: white;
                border-radius: 0.5rem;
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
                padding: 1.5rem;
            }

            .success-icon {
                width: 4rem;
                height: 4rem;
                color: #10b981;
                margin: 0 auto 1rem;
            }

            .success-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #111827;
                margin-bottom: 0.5rem;
            }

            .success-text {
                color: #6b7280;
                margin-bottom: 1.5rem;
            }

            .success-subtext {
                font-size: 0.875rem;
                color: #6b7280;
                margin-bottom: 1rem;
            }

            .footer-text {
                margin-top: 2rem;
                text-align: center;
                font-size: 0.875rem;
                color: #6b7280;
            }

            .footer-text a {
                color: #3b82f6;
                text-decoration: none;
            }

            .footer-text a:hover {
                text-decoration: underline;
            }

            .hidden {
                display: none;
            }

            /* SVG Icons */
            .icon {
                display: inline-block;
                vertical-align: middle;
            }

            .drop-list{
                width: 500px;
                height: 40px;
                border-color: #d1d5db;
                border-radius: 4px;
            }

            .cvView{
                padding: 0.75rem 1rem;
                background-color: #3b82f6;
                color: white;
                border: none;
                border-radius: 0.375rem;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .cvView:hover{
                background-color: #2563eb;
            }
            /*            Hien thi noi cv tren nen trang*/
            .modal {
                display: none; /* Hidden by default */
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.8);
                text-align: center;
                padding-top: 50px;
            }
            .modal-content {
                max-width: 80%;
                max-height: 80%;
            }
            .close {
                position: absolute;
                top: 15px;
                right: 25px;
                font-size: 30px;
                cursor: pointer;
                color: white;
            }
        </style>
    </head>
    <body>
        <div id="app">
            <!-- Main Form -->
            <div id="mainForm" class="container">
                <div class="form-container">
                    <div class="header">
                        <h1>Ứng tuyển ${job.title}</h1>
                        <p>Chúng tôi rất vui khi bạn ứng tuyển. Vui lòng điền đầy đủ thông tin</p>
                    </div>

                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">Đơn ứng tuyển việc làm</h2>
                        </div>
                        <div class="card-content">
                            <form id="applicationForm" class="form" method="post">
                                <!-- CV Upload -->
                                <div class="form-group">
                                    ${mes}
                                    <label class="label" for="cv">CV<span class="required">*</span></label>
                                    <div class="form_group">
                                        <select name="cv" id="cvSelect" class="drop-list">
                                            <c:forEach items="${list}" var="c">
                                                <option value="${c.cvId}" data-url="${c.cvUrl}">${c.title}</option>
                                            </c:forEach>
                                        </select>
                                        <button class="cvView" type="button" onclick="viewCV()">Xem CV</button>
                                    </div>
                                    <!--                                    Hien thi tren cv tren nen trang moi-->
                                    <div id="cvModal" class="modal">
                                        <span class="close" onclick="closeModal()">&times;</span>
                                        <img id="cvImage" src="" alt="CV Preview" class="modal-content">
                                    </div>

                                    <!-- Display CV image -->
                                    <div id="cvContainer" style="margin-top:10px;">
                                        <img id="cvImage" src="" alt="CV Preview" style="max-width:100%; display:none;" />
                                    </div>
                                    <label class="checkbox-label" for="terms">
                                        Chưa có CV? Vui lòng nhấn vào <a href="UploadCV">đây</a> để tải lên
                                    </label>
                                </div>

                                <!-- Cover Letter -->
                                <div class="form-group">
                                    <label class="label" for="coverLetter">Thư giới thiệu<span class="required">*</span></label>
                                    <textarea class="textarea" id="coverLetter" name="coverLetter" rows="4" placeholder="Vui lòng nói cho chúng tôi biết vì sao bạn lại muốn ứng tuyển vào đây"></textarea>
                                </div>

                                <!-- Terms and Conditions -->
                                <div class="checkbox-container">
                                    <input class="checkbox" type="checkbox" name="terms" required>
                                    <label class="checkbox-label" for="terms">
                                        Tôi đồng ý với mọi <a href="#" target="_blank">chính sách</a> và <a href="#" target="_blank">quyền riêng tư</a><span class="required">*</span>
                                    </label>
                                </div>

                                <div class="alert">
                                    <svg class="alert-icon icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                    <p class="alert-text">
                                        Khi bạn ứng tuyển, bạn đồng ý rằng thông tin của bạn được người tuyển dụng sử dụng.
                                    </p>
                                </div>

                                <!-- Submit Button -->
                                <button type="submit" class="button" id="submitBtn">
                                    <span id="submitText">Ứng tuyển</span>
                                    <div id="submitSpinner" class="spinner hidden"></div>
                                </button>
                            </form>
                        </div>
                    </div>         
                </div>
            </div>

            <!-- Success Message -->
            <div id="successMessage" class="success-container hidden">
                <div class="success-card">
                    <svg class="success-icon icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <h2 class="success-title">Đơn ứng tuyển đã được nộp</h2>
                    <p class="success-text">
                        Cảm ơn vì bạn đã ứng tuyển. Đơn của bạn sẽ được duyệt trong thời gian sớm nhất
                    </p>
                    <button class="button button-outline">
                        Quay về trang chủ
                    </button>
                </div>
            </div>
        </div>
        <script>
            //            Cai cu ma pop up ra window moi
//            function viewCV() {
//                var selectElement = document.getElementById("cvSelect");
//                var selectedOption = selectElement.options[selectElement.selectedIndex];
//                var cvUrl = selectedOption.getAttribute("data-url");
//
//                if (cvUrl) {
//                    // Open image in a new popup window
//                    var popupWindow = window.open("", "CV Preview", "width=800,height=600");
//                    popupWindow.document.write("<html><head><title>CV Preview</title></head><body>");
//                    popupWindow.document.write("<img src='" + cvUrl + "' style='max-width:100%;' />");
//                    popupWindow.document.write("</body></html>");
//                    popupWindow.document.close();
//                } else {
//                    alert("No CV URL available!");
//                }
//            }

            function viewCV() {
                var selectElement = document.getElementById("cvSelect");
                var selectedOption = selectElement.options[selectElement.selectedIndex];
                var cvUrl = selectedOption.getAttribute("data-url");

                if (cvUrl) {
                    document.getElementById("cvImage").src = cvUrl;
                    document.getElementById("cvModal").style.display = "block";
                } else {
                    alert("Không tìm thấy CV!");
                }
            }

            function closeModal() {
                document.getElementById("cvModal").style.display = "none";
            }
        </script>
    </body>
</html>