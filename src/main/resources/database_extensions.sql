-- =====================================================
-- CÁC BẢNG MỚI CHO TÍNH NĂNG MỞ RỘNG
-- =====================================================

-- =====================================================
-- 16. NOTIFICATION_SETTINGS - Cài đặt thông báo
-- =====================================================
CREATE TABLE notification_settings (
    setting_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    user_type NVARCHAR(50) NOT NULL, -- 'candidate' hoặc 'recruiter'
    job_email_alert BIT DEFAULT 1,
    job_push_alert BIT DEFAULT 1,
    job_email_frequency NVARCHAR(50) DEFAULT 'daily',
    application_email BIT DEFAULT 1,
    interview_reminder BIT DEFAULT 1,
    test_notification BIT DEFAULT 1,
    news_updates BIT DEFAULT 0,
    promotions BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- =====================================================
-- 17. COMPANY_REVIEW - Đánh giá công ty
-- =====================================================
CREATE TABLE company_review (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    company_id INT NOT NULL,
    recruiter_id INT,
    candidate_id INT,
    rating DECIMAL(2,1) NOT NULL, -- 1.0 - 5.0
    title NVARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    pros NVARCHAR(500),
    cons NVARCHAR(500),
    is_recommended BIT DEFAULT 1,
    status NVARCHAR(50) DEFAULT 'pending', -- pending, approved, rejected
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id)
);

-- =====================================================
-- 18. PORTFOLIO_PROJECT - Dự án portfolio
-- =====================================================
CREATE TABLE portfolio_project (
    project_id INT IDENTITY(1,1) PRIMARY KEY,
    candidate_id INT NOT NULL,
    project_name NVARCHAR(255) NOT NULL,
    description TEXT,
    project_type NVARCHAR(50), -- frontend, backend, fullstack, mobile
    year INT,
    technologies NVARCHAR(500),
    project_url NVARCHAR(255),
    image_url NVARCHAR(255),
    is_featured BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id)
);

-- =====================================================
-- 19. CERTIFICATION - Chứng chỉ
-- =====================================================
CREATE TABLE certification (
    certification_id INT IDENTITY(1,1) PRIMARY KEY,
    candidate_id INT NOT NULL,
    cert_name NVARCHAR(255) NOT NULL,
    issuer NVARCHAR(255) NOT NULL,
    issue_date DATE,
    expiry_date DATE,
    credential_url NVARCHAR(255),
    credential_id NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id)
);

-- =====================================================
-- 20. CONVERSATION - Cuộc trò chuyện
-- =====================================================
CREATE TABLE conversation (
    conversation_id INT IDENTITY(1,1) PRIMARY KEY,
    candidate_id INT,
    recruiter_id INT,
    last_message TEXT,
    last_message_at DATETIME,
    unread_count_candidate INT DEFAULT 0,
    unread_count_recruiter INT DEFAULT 0,
    is_active BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id)
);

-- =====================================================
-- 21. MESSAGE - Tin nhắn
-- =====================================================
CREATE TABLE message (
    message_id INT IDENTITY(1,1) PRIMARY KEY,
    conversation_id INT NOT NULL,
    sender_type NVARCHAR(50) NOT NULL, -- 'candidate' hoặc 'recruiter'
    sender_id INT NOT NULL,
    content TEXT NOT NULL,
    is_read BIT DEFAULT 0,
    attachment_url NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (conversation_id) REFERENCES conversation(conversation_id)
);

-- =====================================================
-- 22. JOB_ALERT - Thông báo việc làm
-- =====================================================
CREATE TABLE job_alert (
    alert_id INT IDENTITY(1,1) PRIMARY KEY,
    candidate_id INT NOT NULL,
    keywords NVARCHAR(255),
    location NVARCHAR(255),
    min_salary DECIMAL(18,2),
    max_salary DECIMAL(18,2),
    job_type NVARCHAR(100),
    industry_id INT,
    is_active BIT DEFAULT 1,
    alert_frequency NVARCHAR(50) DEFAULT 'daily',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (candidate_id) REFERENCES candidate(candidate_id),
    FOREIGN KEY (industry_id) REFERENCES industry(industry_id)
);

-- =====================================================
-- 23. NOTIFICATION - Thông báo hệ thống
-- =====================================================
CREATE TABLE notification (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    user_type NVARCHAR(50) NOT NULL,
    title NVARCHAR(255) NOT NULL,
    content TEXT,
    notification_type NVARCHAR(50), -- interview, application, job, system
    reference_id INT, -- ID của bản ghi liên quan (job_id, application_id, etc.)
    is_read BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE()
);

-- =====================================================
-- THÊM INDEX CHO CÁC BẢNG MỚI
-- =====================================================
CREATE INDEX idx_company_review_company ON company_review(company_id);
CREATE INDEX idx_company_review_status ON company_review(status);
CREATE INDEX idx_portfolio_candidate ON portfolio_project(candidate_id);
CREATE INDEX idx_certification_candidate ON certification(candidate_id);
CREATE INDEX idx_conversation_candidate ON conversation(candidate_id);
CREATE INDEX idx_conversation_recruiter ON conversation(recruiter_id);
CREATE INDEX idx_message_conversation ON message(conversation_id);
CREATE INDEX idx_notification_user ON notification(user_id, user_type);
