<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${test.title}</title>
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

            .test-container {
                display: flex;
                min-height: 100vh;
            }

            .main-content {
                flex: 1;
                padding: 24px;
                margin-right: 300px; /* Space for sidebar */
            }

            .test-header {
                background: white;
                border-radius: 12px;
                padding: 24px;
                margin-bottom: 24px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .test-title {
                font-size: 1.8rem;
                font-weight: 700;
                color: #111827;
                margin-bottom: 8px;
            }

            .test-info {
                color: #6b7280;
                font-size: 14px;
            }

            .question-card {
                background: white;
                border-radius: 12px;
                padding: 24px;
                margin-bottom: 24px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                scroll-margin-top: 20px;
                transition: box-shadow 0.3s ease;
            }

            .question-card:hover {
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            .question-header {
                margin-bottom: 20px;
            }

            .question-number {
                display: inline-block;
                background: #3b82f6;
                color: white;
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                margin-bottom: 12px;
            }

            .question-type-badge {
                display: inline-block;
                background: #f3f4f6;
                color: #6b7280;
                padding: 4px 10px;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 500;
                margin-left: 8px;
            }

            .question-type-badge.multiple_choice {
                background: #dbeafe;
                color: #1d4ed8;
            }

            .question-type-badge.text {
                background: #f0fdf4;
                color: #166534;
            }

            .question-text {
                font-size: 18px;
                font-weight: 600;
                color: #111827;
                line-height: 1.5;
            }

            .answer-section {
                margin-top: 20px;
            }

            .answer-instruction {
                font-size: 14px;
                color: #6b7280;
                margin-bottom: 16px;
                font-style: italic;
            }

            /* Multiple Choice Options */
            .option-item {
                display: flex;
                align-items: flex-start;
                gap: 12px;
                padding: 14px 16px;
                margin-bottom: 10px;
                border: 2px solid #e5e7eb;
                border-radius: 10px;
                cursor: pointer;
                transition: all 0.2s ease;
                position: relative;
                background: white;
            }

            .option-item:hover {
                border-color: #3b82f6;
                background-color: #f8fafc;
                transform: translateY(-1px);
                box-shadow: 0 2px 8px rgba(59, 130, 246, 0.1);
            }

            .option-item.selected {
                border-color: #3b82f6;
                background-color: #eff6ff;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            }

            .option-input {
                margin-top: 2px;
                width: 18px;
                height: 18px;
                accent-color: #3b82f6;
            }

            .option-text {
                flex: 1;
                font-size: 16px;
                color: #374151;
                cursor: pointer;
                line-height: 1.4;
            }

            .option-letter {
                font-weight: 600;
                color: #3b82f6;
                margin-right: 8px;
            }

            /* Text Answer */
            .text-answer {
                width: 100%;
                min-height: 120px;
                padding: 16px;
                border: 2px solid #e5e7eb;
                border-radius: 10px;
                font-size: 16px;
                font-family: inherit;
                resize: vertical;
                transition: all 0.2s ease;
                background: white;
            }

            .text-answer:focus {
                outline: none;
                border-color: #3b82f6;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            }

            .text-answer::placeholder {
                color: #9ca3af;
            }

            /* Character counter for text answers */
            .text-counter {
                text-align: right;
                font-size: 12px;
                color: #6b7280;
                margin-top: 4px;
            }

            /* Sticky Sidebar */
            .test-sidebar {
                position: fixed;
                right: 0;
                top: 0;
                width: 300px;
                height: 100vh;
                background: white;
                border-left: 1px solid #e5e7eb;
                padding: 24px;
                overflow-y: auto;
                box-shadow: -2px 0 10px rgba(0, 0, 0, 0.1);
                z-index: 1000;
            }

            .sidebar-header {
                margin-bottom: 24px;
                padding-bottom: 16px;
                border-bottom: 1px solid #e5e7eb;
            }

            .timer {
                background: linear-gradient(135deg, #fef3c7, #fde68a);
                border: 1px solid #f59e0b;
                border-radius: 12px;
                padding: 16px;
                text-align: center;
                margin-bottom: 16px;
                position: relative;
                overflow: hidden;
            }

            .timer-label {
                font-size: 12px;
                color: #92400e;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .timer-value {
                font-size: 28px;
                font-weight: 700;
                color: #92400e;
                font-family: 'Courier New', monospace;
            }

            .timer.warning {
                background: linear-gradient(135deg, #fecaca, #fca5a5);
                border-color: #ef4444;
            }

            .timer.warning .timer-label,
            .timer.warning .timer-value {
                color: #dc2626;
            }

            .progress-info {
                text-align: center;
                color: #6b7280;
                font-size: 14px;
                font-weight: 500;
            }

            .progress-bar {
                width: 100%;
                height: 8px;
                background: #f3f4f6;
                border-radius: 4px;
                margin: 8px 0;
                overflow: hidden;
            }

            .progress-fill {
                height: 100%;
                background: linear-gradient(90deg, #10b981, #34d399);
                border-radius: 4px;
                transition: width 0.3s ease;
                width: 0%;
            }

            .question-nav {
                margin-bottom: 24px;
            }

            .nav-title {
                font-size: 16px;
                font-weight: 600;
                margin-bottom: 16px;
                color: #111827;
            }

            .question-grid {
                display: grid;
                grid-template-columns: repeat(5, 1fr);
                gap: 10px;
                margin-bottom: 24px;
            }

            .question-nav-btn {
                width: 44px;
                height: 44px;
                border: 2px solid #e5e7eb;
                background: white;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                font-size: 14px;
            }

            .question-nav-btn:hover {
                border-color: #3b82f6;
                transform: translateY(-1px);
                box-shadow: 0 2px 8px rgba(59, 130, 246, 0.2);
            }

            .question-nav-btn.answered {
                background: #10b981;
                border-color: #10b981;
                color: white;
            }

            .question-nav-btn.partial {
                background: #f59e0b;
                border-color: #f59e0b;
                color: white;
            }

            .question-nav-btn.current {
                background: #3b82f6;
                border-color: #3b82f6;
                color: white;
                box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
            }

            .question-nav-btn.flagged::after {
                content: '🚩';
                position: absolute;
                top: -5px;
                right: -5px;
                font-size: 12px;
            }

            .legend {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-bottom: 20px;
                font-size: 12px;
            }

            .legend-item {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .legend-box {
                width: 18px;
                height: 18px;
                border-radius: 6px;
                border: 2px solid;
                flex-shrink: 0;
            }

            .legend-box.answered {
                background: #10b981;
                border-color: #10b981;
            }

            .legend-box.partial {
                background: #f59e0b;
                border-color: #f59e0b;
            }

            .legend-box.current {
                background: #3b82f6;
                border-color: #3b82f6;
            }

            .legend-box.unanswered {
                background: white;
                border-color: #e5e7eb;
            }

            .submit-section {
                border-top: 1px solid #e5e7eb;
                padding-top: 24px;
            }

            .submit-btn {
                width: 100%;
                background: linear-gradient(135deg, #10b981, #059669);
                color: white;
                border: none;
                padding: 14px 24px;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .submit-btn:hover {
                background: linear-gradient(135deg, #059669, #047857);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
            }

            .submit-btn:disabled {
                background: #9ca3af;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
                margin-bottom: 16px;
            }

            .action-btn {
                flex: 1;
                padding: 8px 12px;
                border: 1px solid #d1d5db;
                background: white;
                border-radius: 6px;
                font-size: 12px;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .action-btn:hover {
                background: #f9fafb;
                border-color: #9ca3af;
            }

            .action-btn.active {
                background: #3b82f6;
                border-color: #3b82f6;
                color: white;
            }

            /* Animations */
            @keyframes pulse {
                0%, 100% {
                    opacity: 1;
                }
                50% {
                    opacity: 0.5;
                }
            }

            .timer.critical {
                animation: pulse 1s infinite;
            }

            /* Mobile Responsive */
            @media (max-width: 768px) {
                .main-content {
                    margin-right: 0;
                    padding: 16px;
                }

                .test-sidebar {
                    position: fixed;
                    bottom: 0;
                    right: 0;
                    left: 0;
                    top: auto;
                    width: 100%;
                    height: auto;
                    max-height: 60vh;
                    border-left: none;
                    border-top: 1px solid #e5e7eb;
                    border-radius: 16px 16px 0 0;
                }

                .question-grid {
                    grid-template-columns: repeat(6, 1fr);
                }

                .question-nav-btn {
                    width: 38px;
                    height: 38px;
                    font-size: 12px;
                }

                .timer-value {
                    font-size: 24px;
                }
            }
        </style>
    </head>
    <body>
        <div class="test-container">
            <div class="main-content">
                <div class="test-header">
                    <h1 class="test-title">${test.title}</h1>
                    <div class="test-info">
                        <p><strong>Tổng số câu hỏi:</strong> ${fn:length(questions)}</p>
                        <p>Vui lòng đọc kỹ từng câu hỏi và chọn đáp án. Bạn có thể chuyển giữa các câu hỏi bằng thanh bên phải.</p>
                    </div>
                </div>

                <form id="testForm" action="${pageContext.request.contextPath}/TakingTest" method="post">
                    <input type="hidden" name="assignmentId" value="${assignment.assignmentId}">
                    <input type="hidden" name="testId" value="${test.testId}">
                    <input type="hidden" name="candidateId" value="${sessionScope.Candidate.candidateId}">

                    <c:forEach var="question" items="${questions}" varStatus="status">
                        <div class="question-card" id="question-${question.questionId}">
                            <div class="question-header">
                                <div>
                                    <span class="question-number">Câu hỏi ${status.index + 1}</span>
                                    <span class="question-type-badge ${question.questionType}">
                                        <c:choose>
                                            <c:when test="${question.questionType eq 'multiple_choice'}">Trắc nghiệm</c:when>
                                            <c:otherwise>Văn bản</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="question-text">
                                    <c:out value="${question.questionText}" />
                                </div>
                            </div>

                            <div class="answer-section">
                                <c:choose>
                                    <c:when test="${question.questionType eq 'multiple_choice'}">
                                        <div class="answer-instruction">Chọn một đáp án:</div>
                                        <c:forEach var="option" items="${question.optionsList}" varStatus="optStatus">
                                            <div class="option-item" onclick="selectSingleOption(${question.questionId}, '${fn:escapeXml(option)}', this)">
                                                <input type="radio" 
                                                       name="answer_${question.questionId}" 
                                                       value="${fn:escapeXml(option)}" 
                                                       id="q${question.questionId}_opt${optStatus.index}"
                                                       class="option-input"
                                                       onchange="updateProgress()">
                                                <label for="q${question.questionId}_opt${optStatus.index}" class="option-text">
                                                    <span class="option-letter">${fn:substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', optStatus.index, optStatus.index + 1)}.</span>
                                                    <c:out value="${option}" />
                                                </label>
                                            </div>
                                        </c:forEach>
                                    </c:when>

                                    <c:otherwise>
                                        <div class="answer-instruction">Nhập câu trả lời của bạn dưới đây:</div>
                                        <textarea name="answer_${question.questionId}" 
                                                  class="text-answer" 
                                                  placeholder="Nhập câu trả lời chi tiết của bạn tại đây..."
                                                  onchange="updateProgress()"
                                                  oninput="updateProgress(); updateCharCount(this)"
                                                  maxlength="1000"></textarea>
                                        <div class="text-counter">
                                            <span class="char-count">0</span>/1000 ký tự
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </form>
            </div>

            <div class="test-sidebar">
                <div class="sidebar-header">

                    <div class="progress-info">
                        <div><span id="answered-count">0</span> / ${fn:length(questions)} đã trả lời</div>
                        <div class="progress-bar">
                            <div class="progress-fill" id="progress-fill"></div>
                        </div>
                        <div style="font-size: 12px; margin-top: 4px;">
                            <span id="progress-percentage">0%</span> hoàn thành
                        </div>
                    </div>
                </div>

                <div class="question-nav">
                    <div class="nav-title">Danh sách câu hỏi</div>

                    <div class="legend">
                        <div class="legend-item">
                            <div class="legend-box answered"></div>
                            <span>Đã trả lời</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-box current"></div>
                            <span>Câu hỏi hiện tại</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-box unanswered"></div>
                            <span>Chưa trả lời</span>
                        </div>
                    </div>

                    <div class="question-grid">
                        <c:forEach var="question" items="${questions}" varStatus="status">
                            <button type="button" 
                                    class="question-nav-btn" 
                                    data-question-id="${question.questionId}"
                                    data-question-type="${question.questionType}"
                                    onclick="scrollToQuestion(${question.questionId})"
                                    title="Câu hỏi ${status.index + 1}: ${question.questionType}">
                                ${status.index + 1}
                            </button>
                        </c:forEach>
                    </div>
                </div>

                <div class="submit-section">
                    <button type="button" class="submit-btn" onclick="submitTest()" id="submit-button">
                        Nộp bài
                    </button>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            // Global variables
            let currentQuestion = 1;
            let flaggedQuestions = new Set();
            let totalQuestions = ${totalQuestion};



            // Single choice selection (radio buttons)
            function selectSingleOption(questionId, value, element) {
                // Remove selected class from all siblings
                const siblings = element.parentNode.querySelectorAll('.option-item');
                siblings.forEach(sibling => sibling.classList.remove('selected'));

                // Add selected class to clicked option
                element.classList.add('selected');

                // Check the radio button
                const radio = element.querySelector('input[type="radio"]');
                if (radio) {
                    radio.checked = true;
                }

                updateProgress();
            }

            // Update character count for text answers
            function updateCharCount(textarea) {
                const counter = textarea.parentNode.querySelector('.char-count');
                if (counter) {
                    counter.textContent = textarea.value.length;
                }
            }

            // Update progress tracking
            function updateProgress() {
                let answeredCount = 0;
                

                // Get all actual question IDs from the page
                const questionCards = document.querySelectorAll('.question-card');
                const actualQuestionIds = Array.from(questionCards).map(card =>
                    card.id.replace('question-', '')
                );

                // Count answered questions using actual question IDs
                actualQuestionIds.forEach(questionId => {
                    const questionElements = document.querySelectorAll('[name="answer_' + questionId + '"]');
                    if (questionElements.length > 0) {
                        const firstElement = questionElements[0];

                        if (firstElement.type === 'radio') {
                            // Single choice - check if any radio is selected
                            const isAnswered = Array.from(questionElements).some(radio => radio.checked);
                            if (isAnswered)
                                answeredCount++;
                        } else if (firstElement.type === 'textarea') {
                            // Text answer
                            const text = firstElement.value.trim();
                            if (text.length > 0) {
                                if (text.length > 0) {
                                    answeredCount++; 
                                }
                            }
                        }
                    }
                });

                // Update progress display
                const totalAnswered = answeredCount;
                const answeredCountElement = document.getElementById('answered-count');
                const progressPercentageElement = document.getElementById('progress-percentage');
                const progressFillElement = document.getElementById('progress-fill');

                if (answeredCountElement) {
                    answeredCountElement.textContent = totalAnswered;
                }

                const progressPercent = Math.round((totalAnswered / totalQuestions) * 100);
                if (progressPercentageElement) {
                    progressPercentageElement.textContent = progressPercent + '%';
                }
                if (progressFillElement) {
                    progressFillElement.style.width = progressPercent + '%';
                }

                // Update navigation buttons
                updateNavigationButtons();
            }

            // Update navigation button states
            function updateNavigationButtons() {
                const navButtons = document.querySelectorAll('.question-nav-btn');
                navButtons.forEach((button, index) => {
                    const questionId = button.dataset.questionId; 

                    button.classList.remove('answered', 'current');

                    // Check if question is answered
                    const questionElements = document.querySelectorAll('[name="answer_' + questionId + '"]');
                    if (questionElements.length > 0) {
                        const firstElement = questionElements[0];

                        if (firstElement.type === 'radio') {
                            const isAnswered = Array.from(questionElements).some(radio => radio.checked);
                            if (isAnswered)
                                button.classList.add('answered');
                        } else if (firstElement.type === 'textarea') {
                            const text = firstElement.value.trim();
                            if (text.length > 0) {
                                button.classList.add('answered');
                            }
                        }
                    }
                });
            }

            // Scroll to specific question
            function scrollToQuestion(questionId) {
                const questionElement = document.getElementById('question-' + questionId);
                if (questionElement) {
                    questionElement.scrollIntoView({behavior: 'smooth', block: 'start'});

                    // Update current question indicator
                    document.querySelectorAll('.question-nav-btn').forEach(btn => {
                        btn.classList.remove('current');
                    });
                    const currentBtn = document.querySelector('[data-question-id="' + questionId + '"]');
                    if (currentBtn) {
                        currentBtn.classList.add('current');
                    }
                    currentQuestion = questionId;
                }
            }

            // Submit test with validation
            function submitTest() {

                // Get all actual question IDs from the page
                const questionCards = document.querySelectorAll('.question-card');
                const actualQuestionIds = Array.from(questionCards).map(card =>
                    card.id.replace('question-', '')
                );

                const confirmSubmit = confirm(
                        'Bạn có chắc chắn muốn nộp bài?\n' +
                        'Nhấn OK để nộp bài hoặc Cancel để tiếp tục làm bài.'
                        );
                if (!confirmSubmit)
                    return;



                // Disable submit button
                const submitBtn = document.getElementById('submit-button');
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.textContent = 'Đang nộp bài...';
                }

                // Submit the form
                document.getElementById('testForm').submit();
            }

            // Initialize on page load
            document.addEventListener('DOMContentLoaded', function () {
                updateProgress();

                // Set first question as current
                const firstNavBtn = document.querySelector('.question-nav-btn');
                if (firstNavBtn) {
                    firstNavBtn.classList.add('current');
                }

                // Auto-save functionality (optional)
                setInterval(function () {
                    try {
                        const formData = new FormData(document.getElementById('testForm'));
                        const answers = {};
                        for (let [key, value] of formData.entries()) {
                            if (key.startsWith('answer_')) {
                                if (!answers[key])
                                    answers[key] = [];
                                answers[key].push(value);
                            }
                        }
                        localStorage.setItem('test_answers_backup', JSON.stringify(answers));
                    } catch (e) {
                        console.log('Auto-save failed:', e);
                    }
                }, 30000); // Save every 30 seconds
            });

            // Prevent accidental page refresh
            window.addEventListener('beforeunload', function (e) {
                if (timeRemaining === null || timeRemaining > 0) {
                    e.preventDefault();
                    e.returnValue = 'Bạn có chắc chắn muốn rời khỏi trang? Tiến trình làm bài sẽ bị mất.';
                }
            });

            
        </script>
    </body>
</html>