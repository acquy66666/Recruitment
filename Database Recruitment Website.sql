create database RecruitmentDBFinal
use RecruitmentDBFinal

-- ================================
-- 1. ADMIN
-- ================================
CREATE TABLE [admin] (
    [admin_id] INT IDENTITY(1,1) PRIMARY KEY,
    [username] NVARCHAR(255),
    [password_hash] NVARCHAR(255),
    [role] NVARCHAR(50),
    [created_at] DATETIME,
    [isActive] BIT DEFAULT 1
);

-- ================================
-- 2. CANDIDATE
-- ================================
CREATE TABLE [candidate] (
    [candidate_id] INT IDENTITY(1,1) PRIMARY KEY,
    [password_hash] NVARCHAR(255) NOT NULL,
    [full_name] NVARCHAR(255) NOT NULL,
    [gender] NVARCHAR(255) NOT NULL,
    [birthdate] DATE NOT NULL,
    [phone] NVARCHAR(255) NOT NULL,
    [address] NVARCHAR(255) NOT NULL,
    [email] NVARCHAR(255) NOT NULL,
    [created_at] DATETIME NOT NULL,
    [isActive] BIT NOT NULL,
    [image_url] NVARCHAR(255),
    [social_media_url] NVARCHAR(255)
);

-- ================================
-- 3. RECRUITER
-- ================================
CREATE TABLE [recruiter] (
    [recruiter_id] INT IDENTITY(1,1) PRIMARY KEY,
    [password_hash] NVARCHAR(255) NOT NULL,
    [full_name] NVARCHAR(255) NOT NULL,
    [position] NVARCHAR(255) NOT NULL,
    [phone] NVARCHAR(255) NOT NULL,
    [email] NVARCHAR(255) NOT NULL,
    [created_at] DATETIME NOT NULL,
    [isActive] BIT NOT NULL,
    [image_url] NVARCHAR(255),
    [company_name] NVARCHAR(255) NOT NULL,
    [company_address] NVARCHAR(255),
    [website] NVARCHAR(255),
    [company_logo_url] NVARCHAR(255),
    [company_description] NVARCHAR(255),
	[industry] NVARCHAR(100),
    [tax_code] NVARCHAR(255)
);

-- ================================
-- 4. INDUSTRY
-- ================================
CREATE TABLE [industry] (
    [industry_id] INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(255) NOT NULL
);

-- ================================
-- 5. JOB POST
-- ================================
CREATE TABLE [job_post] (
    [job_id] INT IDENTITY(1,1) PRIMARY KEY,
    [recruiter_id] INT NOT NULL,
    [industry_id] INT NOT NULL,
    [job_position] NVARCHAR(255),
    [title] NVARCHAR(255),
    [location] NVARCHAR(255),
    [job_type] NVARCHAR(255),
    [salary_min] DECIMAL(18,2) NOT NULL,
    [salary_max] DECIMAL(18,2) NOT NULL,
    [experience_level] NVARCHAR(255) NOT NULL,
    [description] NVARCHAR(255) NOT NULL,
    [requirement] NVARCHAR(255) NOT NULL,
    [benefit] NVARCHAR(255) NOT NULL,
    [created_at] DATETIME,
    [deadline] DATETIME,
	[isPriority] NVARCHAR(100),
    [status] NVARCHAR(255),
    FOREIGN KEY ([recruiter_id]) REFERENCES [recruiter]([recruiter_id]),
    FOREIGN KEY ([industry_id]) REFERENCES [industry]([industry_id])
);

-- ================================
-- 6. CV
-- ================================
CREATE TABLE [cv] (
    [cv_id] INT IDENTITY(1,1) PRIMARY KEY,
    [candidate_id] INT,
    [title] NVARCHAR(255),
    [education] NVARCHAR(500),
    [experience] NVARCHAR(500),
    [skills] NVARCHAR(500),
    [languages] NVARCHAR(500),
    [cv_url] NVARCHAR(255),
    [isDefault] BIT DEFAULT 0,
    [created_at] DATETIME DEFAULT GETDATE(),
    [updated_at] DATETIME DEFAULT GETDATE(),
    [status] NVARCHAR(255),
    FOREIGN KEY ([candidate_id]) REFERENCES [candidate]([candidate_id])
);

-- ================================
-- 7. APPLICATION
-- ================================
CREATE TABLE [application] (
    [application_id] INT IDENTITY(1,1) PRIMARY KEY,
    [candidate_id] INT NOT NULL,
    [cv_id] INT NOT NULL,
    [job_id] INT NOT NULL,
    [cover_letter] NVARCHAR(255),
    [applied_at] DATETIME,
    [interview_time] DATETIME,
    [interview_description] NVARCHAR(255),
    [status] NVARCHAR(255),
    FOREIGN KEY ([candidate_id]) REFERENCES [candidate]([candidate_id]),
    FOREIGN KEY ([cv_id]) REFERENCES [cv]([cv_id]),
    FOREIGN KEY ([job_id]) REFERENCES [job_post]([job_id])
);

-- ================================
-- 8. PROMOTION
-- ================================
CREATE TABLE [promotion] (
    [promotion_id] INT IDENTITY(1,1) PRIMARY KEY,
    [promotion_type] NVARCHAR(255),
    [title] NVARCHAR(255) NOT NULL,
    [promo_code] NVARCHAR(255) NOT NULL UNIQUE,
    [quantity] INT NOT NULL,
    [description] NVARCHAR(255) NOT NULL,
    [discount_percent] DECIMAL(5,2) NOT NULL,
    [max_discount_amount] DECIMAL(18,2) NOT NULL,
    [start_date] DATETIME,
    [end_date] DATETIME,
    [isActive] BIT NOT NULL,
    [created_at] DATETIME NOT NULL
);

-- ================================
-- 9. SERVICE
-- ================================
CREATE TABLE [service] (
    [service_id] INT IDENTITY(1,1) PRIMARY KEY,
    [title] NVARCHAR(255) NOT NULL,
    [credit] INT NOT NULL,
    [service_type] NVARCHAR(255),
    [description] NVARCHAR(255),
    [isActive] BIT NOT NULL,
    [image_url] NVARCHAR(255) NOT NULL
);

-- ================================
-- 10. TRANSACTION
-- ================================
CREATE TABLE [transaction] (
    [transaction_id] INT IDENTITY(1,1) PRIMARY KEY,
    [recruiter_id] INT NOT NULL,
    [promotion_id] INT,
    [price] DECIMAL(18,2) NOT NULL,
    [transaction_date] DATETIME NOT NULL,
    [json] NVARCHAR(255) NOT NULL,
    [description] NVARCHAR(255) NOT NULL,
    [status] NVARCHAR(255) NOT NULL,
    [service_id] INT NOT NULL,
    [credit] INT NOT NULL,
    FOREIGN KEY ([recruiter_id]) REFERENCES [recruiter]([recruiter_id]),
    FOREIGN KEY ([promotion_id]) REFERENCES [promotion]([promotion_id]),
    FOREIGN KEY ([service_id]) REFERENCES [service]([service_id])
);

-- ================================
-- 11. TEST
-- ================================
CREATE TABLE [test] (
    [test_id] INT IDENTITY(1,1) PRIMARY KEY,
    [recruiter_id] INT NOT NULL,
    [title] NVARCHAR(255) NOT NULL,
    [description] NVARCHAR(255),
    [created_at] DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([recruiter_id]) REFERENCES [recruiter]([recruiter_id])
);

-- ================================
-- 12. QUESTION
-- ================================
CREATE TABLE [question] (
    [question_id] INT IDENTITY(1,1) PRIMARY KEY,
    [test_id] INT NOT NULL,
    [question_text] NVARCHAR(255) NOT NULL,
    [question_type] NVARCHAR(255) NOT NULL,
    [options] NVARCHAR(255),
    [correct_answer] NVARCHAR(255),
    FOREIGN KEY ([test_id]) REFERENCES [test]([test_id])
);

-- ================================
-- 13. ASSIGNMENT
-- ================================
CREATE TABLE [assignment] (
    [assignment_id] INT IDENTITY(1,1) PRIMARY KEY,
    [test_id] INT NOT NULL,
    [job_id] INT NOT NULL,
    [candidate_id] INT NOT NULL,
    [assigned_at] DATETIME,
    [completed_at] DATETIME,
    [total_question] INT,
    [correct_answer] INT,
    [score] DECIMAL(5,2),
    FOREIGN KEY ([test_id]) REFERENCES [test]([test_id]),
    FOREIGN KEY ([job_id]) REFERENCES [job_post]([job_id]),
    FOREIGN KEY ([candidate_id]) REFERENCES [candidate]([candidate_id])
);

-- ================================
-- 14. RESPONSE
-- ================================
CREATE TABLE [response] (
    [response_id] INT IDENTITY(1,1) PRIMARY KEY,
    [question_id] INT NOT NULL,
    [assignment_id] INT NOT NULL,
    [response__text] NVARCHAR(255),
    [is_correct] BIT,
    FOREIGN KEY ([question_id]) REFERENCES [question]([question_id]),
    FOREIGN KEY ([assignment_id]) REFERENCES [assignment]([assignment_id])
);

-- ================================
-- 15. BOOKMARK
-- ================================
CREATE TABLE [bookmark] (
    [bookmark_id] INT IDENTITY(1,1) PRIMARY KEY,
    [job_id] INT NOT NULL,
    [candidate_id] INT NOT NULL,
    FOREIGN KEY ([job_id]) REFERENCES [job_post]([job_id]),
    FOREIGN KEY ([candidate_id]) REFERENCES [candidate]([candidate_id])
);
