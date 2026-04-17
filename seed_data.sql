-- ============================================================
-- RECRUITMENT DATABASE SEED DATA
-- Database: RecruitmentDBFinal
-- SQL Server
-- Generated: 2026-04-07
-- ============================================================

USE RecruitmentDBFinal;
GO

-- ================================================================
-- XÓA DỮ LIỆU CŨ (THỨ TỰ: BẢNG PHỤ THUỘC -> BẢNG ĐỘC LẬP)
-- ================================================================

DELETE FROM [response];
DELETE FROM [assignment];
DELETE FROM [question];
DELETE FROM [test];
DELETE FROM [interview];
DELETE FROM [application];
DELETE FROM [bookmark];
DELETE FROM [job_advertisement];
DELETE FROM [contact_access_log];
DELETE FROM [cv_template];
DELETE FROM [notification];
DELETE FROM [recruiter_package];
DELETE FROM [transaction_detail];
DELETE FROM [transaction];
DELETE FROM [cv];
DELETE FROM [job_post];
DELETE FROM [blog_post];
DELETE FROM [candidate];
DELETE FROM [recruiter];
DELETE FROM [promotion];
DELETE FROM [service];
DELETE FROM [industry];
DELETE FROM [admin];
GO

-- ================================================================
-- PHASE 1: BẢNG ĐỘC LẬP (KHÔNG PHỤ THUỘC)
-- ================================================================

-- ================================================================
-- 1. ADMIN - Quản trị viên
-- Password: 123456 (hash SHA-256) - 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92
-- ================================================================
SET IDENTITY_INSERT [admin] ON;

INSERT INTO [admin] ([admin_id], [username], [password_hash], [role], [created_at], [isActive])
VALUES
    (1, N'admin@recruitment.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'admin', GETDATE(), 1),
    (2, N'mod@recruitment.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'moderator', GETDATE(), 1);

SET IDENTITY_INSERT [admin] OFF;
GO

-- ================================================================
-- 2. INDUSTRY - Ngành nghề
-- ================================================================
SET IDENTITY_INSERT [industry] ON;

INSERT INTO [industry] ([industry_id], [name_industry])
VALUES
    (1, N'Công nghệ thông tin'),
    (2, N'Kinh tế - Tài chính'),
    (3, N'Marketing - Truyền thông'),
    (4, N'Nhân sự - Hành chính'),
    (5, N'Tài chính - Ngân hàng'),
    (6, N'Kỹ thuật - Cơ khí'),
    (7, N'Giáo dục - Đào tạo'),
    (8, N'Y tế - Sức khỏe'),
    (9, N'Du lịch - Khách sạn'),
    (10, N'Xây dựng - Bất động sản'),
    (11, N'Sản xuất - Công nghiệp'),
    (12, N'Thống kê - Khối chính phủ');

SET IDENTITY_INSERT [industry] OFF;
GO

-- ================================================================
-- 3. SERVICE - Dịch vụ / Gói credit
-- Password: 123456 (hash SHA-256) - 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92
-- ================================================================
SET IDENTITY_INSERT [service] ON;

INSERT INTO [service] ([service_id], [title], [credit], [service_type], [description], [isActive], [img_url], [price])
VALUES
    (1, N'Gói Cơ bản', 50, N'basic', N'Gói cơ bản - Phù hợp cho nhà tuyển dụng nhỏ, có 50 credit để sử dụng cho các dịch vụ tuyển dụng cơ bản như đăng tin, xem hồ sơ ứng viên.', 1, N'/assets/img/service-basic.png', 99000.00),
    (2, N'Gói Tiêu chuẩn', 150, N'standard', N'Gói tiêu chuẩn - Phù hợp cho nhà tuyển dụng vừa phải, có 150 credit để sử dụng cho các dịch vụ tuyển dụng nâng cao hơn.', 1, N'/assets/img/service-standard.png', 249000.00),
    (3, N'Gói Chuyên nghiệp', 500, N'professional', N'Gói chuyên nghiệp - Phù hợp cho nhà tuyển dụng lớn, có 500 credit để sử dụng cho các dịch vụ tuyển dụng chuyên nghiệp.', 1, N'/assets/img/service-professional.png', 599000.00),
    (4, N'Gói Doanh nghiệp', 1000, N'enterprise', N'Gói doanh nghiệp - Phù hợp cho các công ty cần tuyển dụng nhiều vị trí, có 1000 credit và ưu tiên hiển thị tin đăng.', 1, N'/assets/img/service-enterprise.png', 999000.00),
    (5, N'Gói Premium', 2000, N'premium', N'Gói premium - Gói dịch vụ tốt nhất với 2000 credit, không giới hạn tiện ích, ưu tiên hiển thị cao cấp nhất, hỗ trợ 24/7.', 1, N'/assets/img/service-premium.png', 1799000.00);

SET IDENTITY_INSERT [service] OFF;
GO

-- ================================================================
-- 4. PROMOTION - Khuyến mãi
-- ================================================================
SET IDENTITY_INSERT [promotion] ON;

INSERT INTO [promotion] ([promotion_id], [promotion_type], [title], [promo_code], [quantity], [description], [discount_percent], [max_discount_amount], [start_date], [end_date], [isActive], [created_at])
VALUES
    (1, N'percentage', N'Khuyến mãi năm mới 2026 - Giảm 20%', N'NEWYEAR2026', 100,
     N'Chương trình khuyến mãi năm mới 2026 - Giảm 20% cho tất cả các gói dịch vụ. Áp dụng cho tất cả nhà tuyển dụng mới và cũ.',
     20.00, 200000.00, '2026-01-01 00:00:00', '2026-12-31 23:59:59', 1, GETDATE()),
    (2, N'fixed', N'Chào mừng thành viên mới - Giảm 50.000đ', N'WELCOME50', 200,
     N'Mã khuyến mãi chào mừng thành viên mới - Giảm trực tiếp 50.000 VND cho đơn hàng đầu tiên của bạn.',
     0.00, 50000.00, '2026-01-01 00:00:00', '2026-12-31 23:59:59', 1, GETDATE()),
    (3, N'percentage', N'Mùa hè sale - Giảm 30%', N'SUMMER30', 50,
     N'Chương trình khuyến mãi mùa hè - Giảm 30% cho tất cả các gói dịch vụ, tối đa 300.000 VND.',
     30.00, 300000.00, '2026-06-01 00:00:00', '2026-08-31 23:59:59', 1, GETDATE());

SET IDENTITY_INSERT [promotion] OFF;
GO

-- ================================================================
-- PHASE 2: NGƯỜI DÙNG
-- Password: 2 (hash SHA-256) - d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35
-- ================================================================

-- ================================================================
-- 5. RECRUITER - Nhà tuyển dụng
-- ================================================================
SET IDENTITY_INSERT [recruiter] ON;

INSERT INTO [recruiter] ([recruiter_id], [password_hash], [full_name], [position], [phone], [email], [created_at], [isActive], [image_url], [company_name], [company_address], [website], [company_logo_url], [company_description], [industry], [tax_code], [credit])
VALUES
    (1, 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', N'Nguyễn Văn A', N'Trưởng phòng Nhân sự', N'0901234567', N'hr@vingroup.com', GETDATE(), 1, N'/assets/img/recruiter/vingroup.jpg',
     N'Công ty TNHH Vingroup', N'7 Bảng Lang, Ho Chi Minh City, Vietnam', N'https://www.vingroup.com', N'/assets/img/logo/vingroup.png',
     N'Tập đoàn VinGroup là một trong những tập đoàn kinh tế lớn nhất Việt Nam, hoạt động trong nhiều lĩnh vực như bất động sản, bán lẻ, nghỉ dưỡng, giáo dục, y tế và công nghệ. Vingroup luôn tìm kiếm những nhân tài xuất sắc để cùng tạo nên tương lai.',
     N'Công nghệ thông tin', N'0102030405', 500),
    (2, 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', N'Trần Thị B', N'Chuyên viên Tuyển dụng', N'0902345678', N'tuyendung@fpt.com.vn', GETDATE(), 1, N'/assets/img/recruiter/fpt.jpg',
     N'Công ty FPT Software', N'Hà Nội Tower, 90 Phố Quang, Hà Nội, Vietnam', N'https://www.fpt-software.com', N'/assets/img/logo/fpt.png',
     N'FPT Software là một trong những công ty công nghệ thông tin lớn nhất Việt Nam, chuyên cung cấp các giải pháp phần mềm và dịch vụ outsourcing cho các thị trường toàn cầu.',
     N'Công nghệ thông tin', N'0109876543', 300),
    (3, 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', N'Lê Văn C', N'Giám đốc Nhân sự', N'0903456789', N'hr@viettel.com.vn', GETDATE(), 1, N'/assets/img/recruiter/viettel.jpg',
     N'Tập đoàn Viễn Thông Quân Đội', N'01 Trần Cung, Hà Nội, Vietnam', N'https://www.vietteltelecom.com', N'/assets/img/logo/viettel.png',
     N'Viettel Group là nhà mạng di động lớn nhất tại Việt Nam và là một trong những doanh nghiệp có vượng mạnh nhất trong nước, với chuỗi sản phẩm và dịch vụ điện tử viễn thông.',
     N'Công nghệ thông tin', N'0101234567', 200),
    (4, 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', N'Phạm Thị D', N'Trưởng bộ phận Tuyển dụng', N'0904567890', N'hr@unilever.vn', GETDATE(), 1, N'/assets/img/recruiter/unilever.jpg',
     N'Unilever Việt Nam', N'156 Đồng Khởi, Ho Chi Minh City, Vietnam', N'https://www.unilever.vn', N'/assets/img/logo/unilever.png',
     N'Unilever là một trong những công ty hàng tiêu dùng lớn nhất thế giới, hoạt động tại Việt Nam với các thương hiệu nổi tiếng như Omo, Vim, Sunsilk, Close Up và nhiều thương hiệu khác.',
     N'Sản xuất - Công nghiệp', N'0300123456', 150),
    (5, 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', N'Hồ Văn E', N'Phó phòng Nhân sự', N'0905678901', N'td@bidv.com.vn', GETDATE(), 1, N'/assets/img/recruiter/bidv.jpg',
     N'Ngân hàng TMCP Ngoại thương Việt Nam (BIDV)', N'194 Trần Quang Khải, Hà Nội, Vietnam', N'https://www.bidv.com.vn', N'/assets/img/logo/bidv.png',
     N'BIDV là một trong những ngân hàng thương mại cổ phần lớn nhất Việt Nam, cung cấp đầy đủ các dịch vụ tài chính - ngân hàng cho cả cá nhân và doanh nghiệp.',
     N'Tài chính - Ngân hàng', N'0103456789', 100);

SET IDENTITY_INSERT [recruiter] OFF;
GO

-- ================================================================
-- 6. CANDIDATE - Ứng viên
-- Password: 3 (hash SHA-256) - 4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce
-- ================================================================
SET IDENTITY_INSERT [candidate] ON;

INSERT INTO [candidate] ([candidate_id], [password_hash], [full_name], [gender], [birthdate], [phone], [address], [email], [created_at], [isActive], [image_url], [social_media_url], [current_position], [current_level], [industry], [field], [desired_level], [desired_salary], [marital_status], [desired_location], [education_level], [languages], [profile_summary], [years_experience], [status])
VALUES
    (1, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Nguyễn Văn Minh', N'Male', '2000-05-15', N'0911234567', N'123 Phố Huế, Hà Nội, Vietnam', N'nguyen.minh@email.com', GETDATE(), 1, N'/assets/img/candidate/male1.jpg', N'https://linkedin.com/in/nguyenminh',
     N'Thực tập sinh Developer', N'Mới vào nghề', N'Công nghệ thông tin', N'Lập trình web', N'Nhân viên sơ cấp (1-3 năm)', N'10-15 triệu', N'Single', N'Hà Nội', N'Đại học', N'Tiếng Anh - Trung bình', N'Sinh viên năm cuối chuyên ngành Công nghệ Thông tin, có kinh nghiệm thực tập tại FPT Software, thành thạo HTML, CSS, JavaScript, React. Đam mê công nghệ và luôn mong muốn phát triển trong lĩnh vực phát triển web.', 1, N'ACTIVE'),
    (2, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Trần Thị Lan', N'Female', '1998-08-22', N'0912345678', N'45 Lê Lợi, Đà Nẵng, Vietnam', N'tran.lan@email.com', GETDATE(), 1, N'/assets/img/candidate/female1.jpg', N'https://linkedin.com/in/tranthilan',
     N'Java Backend Developer', N'Nhân viên sơ cấp (1-3 năm)', N'Công nghệ thông tin', N'Lập trình Java', N'Nhân viên trung cấp (3-5 năm)', N'15-20 triệu', N'Single', N'Đà Nẵng, Hà Nội', N'Đại học', N'Tiếng Anh - Khá', N'Có 2 năm kinh nghiệm phát triển ứng dụng web sử dụng Java Spring Boot. Đã tham gia xây dựng hệ thống quản lý kho hàng cho một doanh nghiệp sản xuất.',
     3, N'ACTIVE'),
    (3, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Lê Văn Hải', N'Male', '1995-03-10', N'0913456789', N'78 Nguyễn Huệ, Ho Chi Minh City, Vietnam', N'le.hai@email.com', GETDATE(), 1, N'/assets/img/candidate/male2.jpg', N'https://linkedin.com/in/levanhai',
     N'Senior Python Developer', N'Cao cấp (trên 5 năm)', N'Công nghệ thông tin', N'Data Science', N'Quản lý', N'35-50 triệu', N'Married', N'Ho Chi Minh City', N'Đại học', N'Tiếng Anh - Tốt', N'Đề cử lãnh đạo, có 6 năm kinh nghiệm trong lĩnh vực phát triển Python và Data Science. Đã làm việc tại Google Vietnam và Amazon. Chuyên gia về Machine Learning và AI.',
     6, N'ACTIVE'),
    (4, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Phạm Thị Mai', N'Female', '1999-11-30', N'0914567890', N'56 Trần Hưng Đạo, Hà Nội, Vietnam', N'pham.mai@email.com', GETDATE(), 1, N'/assets/img/candidate/female2.jpg', N'https://facebook.com/phamthimai',
     N'Marketing Executive', N'Nhân viên sơ cấp (1-3 năm)', N'Marketing - Truyền thông', N'Marketing số', N'Nhân viên sơ cấp (1-3 năm)', N'8-12 triệu', N'Single', N'Hà Nội', N'Đại học', N'Tiếng Anh - Trung bình', N'Sinh viên mới ra trường chuyên ngành Marketing, có kiến thức về SEO, Content Marketing và Social Media Marketing. Đã thực tập tại Agency 24h.',
     1, N'ACTIVE'),
    (5, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Hồng Văn Đức', N'Male', '1997-07-18', N'0915678901', N'100 Đồng Khởi, Ho Chi Minh City, Vietnam', N'hoang.duc@email.com', GETDATE(), 1, N'/assets/img/candidate/male3.jpg', N'https://linkedin.com/in/hoangvanluc',
     N'Project Manager', N'Cao cấp (trên 5 năm)', N'Công nghệ thông tin', N'Quản lý dự án', N'Quản lý', N'30-45 triệu', N'Married', N'Ho Chi Minh City', N'Đại học', N'Tiếng Anh - Tốt', N'PMP certified, có 5 năm kinh nghiệm quản lý dự án IT. Đã quản lý nhiều dự án lớn cho các công ty fintech và e-commerce. Kỹ năng giao tiếp và điều đạt người.',
     5, N'ACTIVE'),
    (6, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Vũ Thị Hòa', N'Female', '2001-02-14', N'0916789012', N'200 Cách Mạng Tháng Tám, Ho Chi Minh City, Vietnam', N'vu.hoa@email.com', GETDATE(), 1, N'/assets/img/candidate/female3.jpg', N'https://facebook.com/vuthihoa',
     N'Fresher Designer', N'Mới vào nghề', N'Marketing - Truyền thông', N'Thiết kế đồ họa', N'Nhân viên sơ cấp (1-3 năm)', N'5-8 triệu', N'Single', N'Ho Chi Minh City', N'Cao đẳng', N'Tiếng Anh - Trung bình', N'Sinh viên năm cuối chuyên ngành Thiết kế Đồ họa, thành thạo Photoshop, Illustrator, Figma. Đã có sản phẩm thực tế và mong muốn phát triển trong lĩnh vực UI/UX.',
     0, N'ACTIVE'),
    (7, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Nguyễn Văn Phúc', N'Male', '1996-09-25', N'0917890123', N'15 Lê Duẩn, Đà Nẵng, Vietnam', N'nguyen.phuc@email.com', GETDATE(), 1, N'/assets/img/candidate/male4.jpg', N'https://linkedin.com/in/nguyenphuc',
     N'DevOps Engineer', N'Nhân viên trung cấp (3-5 năm)', N'Công nghệ thông tin', N'Hạ tầng - DevOps', N'Nhân viên trung cấp (3-5 năm)', N'20-30 triệu', N'Single', N'Đà Nẵng', N'Đại học', N'Tiếng Anh - Tốt', N'Có 4 năm kinh nghiệm DevOps, thành thạo Docker, Kubernetes, AWS, Azure. Đã xây dựng hạ tầng CI/CD cho nhiều dự án lớn và tối ưu hiệu suất hệ thống.',
     4, N'ACTIVE'),
    (8, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Đinh Thị Lan', N'Female', '1994-12-08', N'0918901234', N'88 Phan Đình Phùng, Hà Nội, Vietnam', N'dinh.lan@email.com', GETDATE(), 1, N'/assets/img/candidate/female4.jpg', N'https://linkedin.com/in/dinthilan',
     N'Kế toán trưởng', N'Cao cấp (trên 5 năm)', N'Tài chính - Ngân hàng', N'Kế toán - Tài chính', N'Quản lý', N'25-40 triệu', N'Married', N'Hà Nội', N'Đại học', N'Tiếng Anh - Khá', N'Có 8 năm kinh nghiệm trong lĩnh vực kế toán và tài chính, tốt nghiệp Đại học Kinh tế Quốc dân. Chuyên gia về kế toán doanh nghiệp sản xuất.',
     8, N'ACTIVE'),
    (9, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Bùi Văn Hùng', N'Male', '1993-04-20', N'0919012345', N'30 Phạm Văn Đồng, Ho Chi Minh City, Vietnam', N'bui.hung@email.com', GETDATE(), 1, N'/assets/img/candidate/male5.jpg', N'https://linkedin.com/in/buivanhung',
     N'Kỹ sư Cơ khí', N'Nhân viên trung cấp (3-5 năm)', N'Kỹ thuật - Cơ khí', N'Thiết kế cơ khí', N'Nhân viên trung cấp (3-5 năm)', N'12-18 triệu', N'Single', N'Ho Chi Minh City', N'Đại học', N'Tiếng Anh - Khá', N'Đại học Bách Khoa Hồ Chí Minh, chuyên ngành Cơ khí, có 4 năm kinh nghiệm thiết kế và gia công cơ khí. Thành thạo AutoCAD, SolidWorks.',
     4, N'ACTIVE'),
    (10, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', N'Nguyễn Thị Thúy', N'Female', '2000-06-12', N'0910123456', N'67 Nguyễn Trãi, Hà Nội, Vietnam', N'nguyen.thuy@email.com', GETDATE(), 1, N'/assets/img/candidate/female5.jpg', N'https://facebook.com/nguyenthithuy',
     N'Thực tập sinh Marketing', N'Mới vào nghề', N'Marketing - Truyền thông', N'Marketing', N'Nhân viên sơ cấp (1-3 năm)', N'5-7 triệu', N'Single', N'Hà Nội', N'Đại học', N'Tiếng Anh - Trung bình, Tiếng Trung - Cơ bản',
     N'Sinh viên năm 3 chuyên ngành Marketing, có kiến thức cơ bản về quản lý thương hiệu và truyền thông. Đã tham gia các dự án thực tế tại trường.',
     0, N'ACTIVE');

SET IDENTITY_INSERT [candidate] OFF;
GO

-- ================================================================
-- PHASE 3: NỘI DUNG
-- ================================================================

-- ================================================================
-- 7. JOB_POST - Tin tuyển dụng
-- ================================================================
SET IDENTITY_INSERT [job_post] ON;

INSERT INTO [job_post] ([job_id], [recruiter_id], [industry_id], [job_position], [title], [location], [job_type], [salary_min], [salary_max], [experience_level], [description], [requirement], [benefit], [created_at], [deadline], [isPriority], [status])
VALUES
    -- VinGroup (recruiter_id=1, industry_id=1)
    (1, 1, 1, N'Frontend Developer', N'Tuyển dụng Frontend Developer (ReactJS) - VinGroup',
     N'Ho Chi Minh City', N'Full-time', 15000000.00, 30000000.00, N'Nhân viên sơ cấp (1-3 năm)',
     N'<p>Vingroup đang tìm kiếm một Frontend Developer năng động và có kinh nghiệm để tham gia xây dựng các sản phẩm công nghệ tiên phong. Bạn sẽ làm việc với nhóm phát triển Sản phẩm Đề cử lãnh đạo, thiết kế và triển khai các giao diện người dùng hấp dẫn trên nền tảng Web và Mobile.</p><p>Dự án trung tâm là xây dựng ứng dụng di động VinID với hơn 20 triệu người dùng.</p>',
     N'<ul><li>Có ít nhất 1-3 năm kinh nghiệm với ReactJS, Angular hoặc Vue.js</li><li>Thành thạo HTML5, CSS3, JavaScript (ES6+)</li><li>Kiến thức về Redux, Context API hoặc các state management khác</li><li>Hiểu biết về RESTful API và GraphQL</li><li>Khả năng làm việc nhóm tốt, có tính chăm chỉ</li><li>Tiếng Anh đọc hiểu tài liệu chuyên ngành</li></ul>',
     N'<ul><li>Lương thỏa thuận theo năng lực, tối đa 30 triệu VND/tháng</li><li>Thưởng lương 13-14 tháng</li><li>Bảo hiểm xã hội, y tế, thất nghiệp theo quy định</li><li>Nghỉ phép 12 ngày/năm, nghỉ lễ theo Luật Lao động</li><li>Chế độ đào tạo và phát triển chuyên môn hàng năm</li><li>Làm việc trong môi trường chuyên nghiệp, có hội thử việc tại các công ty thành viên Vingroup</li></ul>',
     GETDATE(), '2026-05-30', N'top', N'Active'),
    (2, 1, 1, N'Backend Developer', N'Tuyển dụng Backend Developer (Java Spring Boot) - VinGroup',
     N'Hà Nội', N'Full-time', 20000000.00, 40000000.00, N'Nhân viên trung cấp (3-5 năm)',
     N'<p>Tham gia xây dựng và phát triển các hệ thống backend cho những sản phẩm lớn của Vingroup như VinID, VinEcommerce, VinBus. Bạn sẽ làm việc với khối lượng dữ liệu lớn, đảm bảo hiệu suất và độ tin cậy cao.</p>',
     N'<ul><li>Có 3-5 năm kinh nghiệm phát triển Java, ưu tiên Java Spring Boot</li><li>Thành thạo RESTful API, Microservices, Message Queue</li><li>Kinh nghiệm với PostgreSQL, MySQL, MongoDB</li><li>Hiểu biết về Docker, Kubernetes, CI/CD</li><li>Tiếng Anh khá, có thể giao tiếp bằng nói</li></ul>',
     N'<ul><li>Lương từ 20-40 triệu VND/tháng, thỏa thuận theo năng lực</li><li>Thưởng dự án, thưởng lương</li><li>Bảo hiểm đầy đủ, chế độ phụ cấp 5 sao</li><li>Dự án thử việc 2 tháng, đồng ý lương cuối cùng</li><li>Đào tạo chuyên môn, chứng chỉ chuyên ngành</li></ul>',
     GETDATE(), '2026-06-15', N'hot', N'Active'),
    (3, 1, 1, N'Data Engineer', N'Tuyển dụng Data Engineer - VinGroup',
     N'Ho Chi Minh City', N'Full-time', 25000000.00, 50000000.00, N'Cao cấp (trên 5 năm)',
     N'<p>Xây dựng và tối ưu các hệ thống xử lý dữ liệu lớn (Big Data) cho tập đoàn Vingroup. Đảm bảo chất lượng dữ liệu, xây dựng pipeline tự động hóa và phát triển các giải pháp phân tích dữ liệu.</p>',
     N'<ul><li>Tốt nghiệp Đại học chuyên ngành CNTT, Toán tin học hoặc tương đương</li><li>Có 5+ năm kinh nghiệm trong lĩnh vực Data Engineering</li><li>Thành thạo Python, Scala, SQL</li><li>Kinh nghiệm với Apache Spark, Hadoop, Kafka</li><li>Hiểu biết sâu về cloud (AWS, GCP, Azure)</li></ul>',
     N'<ul><li>Lương cao nhất ngành, thỏa thuận theo năng lực</li><li>Có hội phát triển lên quản lý nhóm</li><li>Chế độ phụ cấp 5 sao</li><li>Đào tạo chuyên môn và ngoại ngữ hàng năm</li></ul>',
     GETDATE(), '2026-07-01', N'normal', N'Active'),

    -- FPT Software (recruiter_id=2, industry_id=1)
    (4, 2, 1, N'Software Engineer (Java)', N'Tuyển dụng Software Engineer (Java) - FPT Software',
     N'Hà Nội', N'Full-time', 12000000.00, 25000000.00, N'Nhân viên sơ cấp (1-3 năm)',
     N'<p>FPT Software tuyển dụng Software Engineer tham gia các dự án outsourcing cho khách hàng quốc tế. Bạn sẽ có cơ hội làm việc với công nghệ hiện đại, quy trình phát triển chuẩn quốc tế và có hội phát triển lên senior trong 12-18 tháng.</p>',
     N'<ul><li>Sinh viên tốt nghiệp Đại học chuyên ngành CNTT, KHTN, BKHN hoặc tương đương</li><li>Có kiến thức cơ bản về Java (hoặc C#, .NET)</li><li>Hiểu biết về OOP, Design Patterns</li><li>Tiếng Anh toeic 450+ (đọc, viết)</li><li>Khả năng học hỏi nhanh, chịu áp lực tốt</li></ul>',
     N'<ul><li>Lương khi đi làm: 12-25 triệu VND/tháng (tham gia dự án quốc tế)</li><li>Thưởng dự án hàng quý (10-30% lợi nhuận)</li><li>Đào tạo chuyên môn 1-3 tháng khi vào công ty</li><li>Bảo hiểm theo quy định, có phụ cấp ăn trưa</li><li>Có hội làm việc tại Nhật Bản, Đức, Mỹ, Australia</li></ul>',
     GETDATE(), '2026-05-20', N'hot', N'Active'),
    (5, 2, 1, N'DevOps Engineer', N'Tuyển dụng DevOps Engineer - FPT Software',
     N'Đà Nẵng', N'Full-time', 18000000.00, 35000000.00, N'Nhân viên trung cấp (3-5 năm)',
     N'<p>Tham gia xây dựng và vận hành hạ tầng CI/CD, đảm bảo chất lượng sản phẩm phần mềm cho các dự án outsourcing. Làm việc trực tiếp với đội ngũ phát triển quốc tế.</p>',
     N'<ul><li>Có 3-5 năm kinh nghiệm DevOps/SRE</li><li>Thành thạo Docker, Kubernetes, Jenkins, GitLab CI</li><li>Kinh nghiệm với cloud AWS hoặc Azure</li><li>Hiểu biết về Linux, Scripting (Bash, Python)</li><li>Tiếng Anh giao tiếp tốt</li></ul>',
     N'<ul><li>Lương 18-35 triệu VND/tháng</li><li>Thưởng dự án, phụ cấp chuyên cảnh</li><li>Có hội xuất ngoại (Nhật, Đức, Mỹ)</li><li>Đào tạo chứng chỉ cloud (AWS, Azure)</li></ul>',
     GETDATE(), '2026-06-30', N'normal', N'Active'),
    (6, 2, 1, N'Fresher Software Engineer', N'Tuyển dụng Fresher Software Engineer - FPT Software',
     N'Hà Nội, Ho Chi Minh City', N'Full-time', 7000000.00, 12000000.00, N'Mới vào nghề',
     N'<p>Chương trình Fresher của FPT Software dành cho sinh viên mới tốt nghiệp CNTT. Được đào tạo chuyên ngành 3-6 tháng với kỹ năng thực tế, sau đó tham gia các dự án quốc tế với mức lương cạnh tranh.</p>',
     N'<ul><li>Sinh viên năm cuối hoặc mới tốt nghiệp CNTT, KHTN, BKHN</li><li>Có kiến thức cơ bản về lập trình (Java, C#, Python bất kỳ)</li><li>Tiếng Anh toeic 450+</li><li>Đam mê công nghệ, có tính sáng tạo</li></ul>',
     N'<ul><li>Lương fresher: 7-12 triệu VND/tháng</li><li>Đào tạo 3-6 tháng trước khi làm dự án</li><li>Có hội lên công việc sau 12 tháng</li><li>Bảo hiểm, phụ cấp ăn trưa, đi lại</li></ul>',
     GETDATE(), '2026-05-15', N'hot', N'Active'),

    -- Viettel (recruiter_id=3, industry_id=1)
    (7, 3, 1, N'Senior Backend Developer', N'Tuyển dụng Senior Backend Developer - Viettel',
     N'Hà Nội', N'Full-time', 30000000.00, 60000000.00, N'Cao cấp (trên 5 năm)',
     N'<p>Tham gia xây dựng các hệ thống viễn thông và công nghệ cho Tập đoàn Viễn Thông Quân Đội (Viettel). Dự án lớn nhất là hệ thống MyViettel phục vụ 60 triệu thuê bao.</p>',
     N'<ul><li>Có 5+ năm kinh nghiệm phát triển backend</li><li>Thành thạo Java, Go hoặc Node.js</li><li>Kinh nghiệm với Microservices, Message Queue</li><li>Hiểu biết sâu về database PostgreSQL, Redis, MongoDB</li><li>Khả năng phỏng trao và hướng dẫn thành viên khác</li><li>Tiếng Anh giao tiếp tốt</li></ul>',
     N'<ul><li>Lương thỏa thuận, cao nhất ngành, lên đến 60 triệu VND/tháng</li><li>Thưởng Hiệu lương 14 tháng</li><li>Bảo hiểm VIP, phụ cấp xăng, điện thoại</li><li>Chế độ nghỉ phép 18 ngày/năm</li><li>Đào tạo, thi chứng chỉ chuyên ngành</li></ul>',
     GETDATE(), '2026-06-30', N'top', N'Active'),
    (8, 3, 1, N'Mobile Developer (iOS/Android)', N'Tuyển dụng Mobile Developer - Viettel',
     N'Hà Nội', N'Full-time', 20000000.00, 45000000.00, N'Nhân viên trung cấp (3-5 năm)',
     N'<p>Phát triển ứng dụng di động cho hệ thống Viettel, bao gồm MyViettel, ViettelPay và các ứng dụng nội bộ. Công việc tập trung vào trải nghiệm người dùng và hiệu suất ứng dụng.</p>',
     N'<ul><li>Có 3-5 năm kinh nghiệm phát triển iOS (Swift) hoặc Android (Kotlin)</li><li>Kinh nghiệm với Flutter hoặc React Native là một ưu thế</li><li>Hiểu biết về MVVM, Clean Architecture</li><li>Thành thạo RESTful API, JSON parsing</li></ul>',
     N'<ul><li>Lương 20-45 triệu VND/tháng</li><li>Thưởng theo dự án và Hiệu suất</li><li>Bảo hiểm cao cấp, phụ cấp hấp dẫn</li><li>Có hội phát triển kỹ năng mobile chuyên nghiệp</li></ul>',
     GETDATE(), '2026-06-15', N'hot', N'Active'),

    -- Unilever (recruiter_id=4, industry_id=11)
    (9, 4, 11, N'Brand Executive', N'Tuyển dụng Brand Executive - Unilever',
     N'Ho Chi Minh City', N'Full-time', 15000000.00, 25000000.00, N'Nhân viên sơ cấp (1-3 năm)',
     N'<p>Tham gia xây dựng và triển khai chiến lược thương hiệu cho các sản phẩm nổi tiếng của Unilever như Omo, Vim, Sunsilk, Close Up. Làm việc chuyên thó với nhóm Marketing toàn cầu và các đại lý quảng cáo.</p>',
     N'<ul><li>Tốt nghiệp Đại học chuyên ngành Marketing, Kinh tế, Truyền thông</li><li>Có 1-3 năm kinh nghiệm trong lĩnh vực Brand/Marketing</li><li>Khả năng phân tích dữ liệu và báo cáo</li><li>Tiếng Anh giao tiếp tốt (IELTS 6.5+)</li><li>Khả năng làm việc nhóm, sáng tạo và có tính sáng tạo</li></ul>',
     N'<ul><li>Lương 15-25 triệu VND/tháng</li><li>Thưởng Hiệu lương 13 tháng</li><li>Bảo hiểm sức khỏe cao cấp</li><li>Chế độ nghỉ phép 20 ngày/năm</li><li>Được sử dụng sản phẩm Unilever miễn phí hàng tháng</li></ul>',
     GETDATE(), '2026-05-25', N'normal', N'Active'),
    (10, 4, 11, N'Supply Chain Manager', N'Tuyển dụng Supply Chain Manager - Unilever',
     N'Ho Chi Minh City', N'Full-time', 35000000.00, 60000000.00, N'Cao cấp (trên 5 năm)',
     N'<p>Quản lý chuỗi cung ứng cho toàn bộ sản phẩm Unilever tại Việt Nam. Đảm bảo hiệu suất vận chuyển, lưu kho và phân phối, tối ưu hóa chi phí logistics và đảm bảo chất lượng sản phẩm.</p>',
     N'<ul><li>Có 5+ năm kinh nghiệm trong quản lý chuỗi cung ứng, logistics</li><li>Tốt nghiệp Đại học chuyên ngành Quản lý chuỗi cung ứng, Kinh tế, Logistics</li><li>Kinh nghiệm quản lý đội ngũ 10+ người</li><li>Khả năng phân tích số liệu, lập kế hoạch và giải quyết vấn đề</li><li>Tiếng Anh tốt, có thể giao tiếp</li></ul>',
     N'<ul><li>Lương 35-60 triệu VND/tháng, thỏa thuận theo năng lực</li><li>Thưởng Hiệu lương và Performance bonus</li><li>Bảo hiểm VIP, xe công</li><li>Chế độ nghỉ phép 20 ngày/năm</li></ul>',
     GETDATE(), '2026-06-30', N'top', N'Active'),

    -- BIDV (recruiter_id=5, industry_id=5)
    (11, 5, 5, N'Chuyên viên Tin học', N'Tuyển dụng Chuyên viên Tin học - BIDV',
     N'Hà Nội', N'Full-time', 15000000.00, 30000000.00, N'Nhân viên trung cấp (3-5 năm)',
     N'<p>Tham gia phát triển và vận hành các hệ thống công nghệ thông tin ngân hàng BIDV. Đảm bảo an ninh mạng, hỗ trợ kỹ thuật cho các hệ thống core banking và ứng dụng số.</p>',
     N'<ul><li>Tốt nghiệp Đại học chuyên ngành CNTT, An ninh mạng hoặc tương đương</li><li>Có 3-5 năm kinh nghiệm trong lĩnh vực IT ngân hàng hoặc tài chính</li><li>Thành thạo Java, Oracle, Linux</li><li>Hiểu biết về an ninh mạng, firewall, IDS/IPS</li><li>Tiếng Anh khá</li></ul>',
     N'<ul><li>Lương 15-30 triệu VND/tháng</li><li>Thưởng Hiệu lương 13 tháng + thưởng Tết</li><li>Bảo hiểm ngân hàng, phụ cấp đi lại</li><li>Chế độ nghỉ phép 15 ngày/năm</li><li>Có hội phát triển lên Quản lý và Giám đốc</li></ul>',
     GETDATE(), '2026-06-01', N'hot', N'Active'),
    (12, 5, 5, N'Kế toán viên', N'Tuyển dụng Kế toán viên - BIDV',
     N'Hà Nội, Ho Chi Minh City', N'Full-time', 10000000.00, 18000000.00, N'Mới vào nghề',
     N'<p>Thực hiện các nghiệp vụ kế toán, hạ toán chung, theo dõi sổ kế toán tài chính của Ngân hàng. Làm việc tại Chi nhánh hoặc Phòng Kế toán Toàn hệ thống.</p>',
     N'<ul><li>Tốt nghiệp Đại học/Cao đẳng chuyên ngành Kế toán, Tài chính</li><li>Có chứng chỉ kế toán hành nghề (CPA, ACCA) là một ưu điểm</li><li>Thành thạo phần mềm kế toán MISA, FAST</li><li>Tính toán chính xác, có trách nhiệm, chịu áp lực tốt</li></ul>',
     N'<ul><li>Lương 10-18 triệu VND/tháng</li><li>Thưởng Hiệu lương + thưởng T6</li><li>Bảo hiểm ngân hàng</li><li>Chế độ nghỉ phép 15 ngày/năm</li><li>Có hội chuyển đổi, thử việc nội bộ</li></ul>',
     GETDATE(), '2026-05-30', N'normal', N'Active'),

    -- Additional jobs
    (13, 2, 1, N'QA Engineer', N'Tuyển dụng QA Engineer - FPT Software',
     N'Hà Nội', N'Full-time', 10000000.00, 20000000.00, N'Nhân viên sơ cấp (1-3 năm)',
     N'<p>Thực hiện kiểm thử phần mềm cho các dự án outsourcing tại FPT Software. Thiết kế test case, thực hiện kiểm thử, báo cáo lỗi và phối hợp với dev để fix bug.</p>',
     N'<ul><li>Có 1-3 năm kinh nghiệm QA/Tester</li><li>Thành thạo kiểm thử thủ công và tự động (Selenium, Appium)</li><li>Kiến thức về SQL, API testing</li><li>Tiếng Anh đọc hiểu tài liệu</li></ul>',
     N'<ul><li>Lương 10-20 triệu VND/tháng</li><li>Thưởng dự án</li><li>Đào tạo chứng chỉ ISTQB</li><li>Bảo hiểm, phụ cấp ăn trưa</li></ul>',
     GETDATE(), '2026-06-15', N'normal', N'Active'),
    (14, 3, 1, N'Test Engineer', N'Tuyển dụng Test Engineer - Viettel',
     N'Hà Nội', N'Full-time', 15000000.00, 30000000.00, N'Nhân viên trung cấp (3-5 năm)',
     N'<p>Thực hiện kiểm thử hệ thống cho các sản phẩm của Viettel, đảm bảo chất lượng sản phẩm trước khi phát hành đến hàng triệu người dùng.</p>',
     N'<ul><li>Có 3-5 năm kinh nghiệm trong lĩnh vực Software Testing</li><li>Kinh nghiệm kiểm thử tự động (Python, Java)</li><li>Thành thạo Jmeter, Postman, Selenium</li><li>Hiểu biết về CI/CD trong kiểm thử</li></ul>',
     N'<ul><li>Lương 15-30 triệu VND/tháng</li><li>Thưởng theo dự án</li><li>Bảo hiểm VIP</li><li>Đào tạo năng lực</li></ul>',
     GETDATE(), '2026-06-20', N'hot', N'Active'),
    (15, 1, 3, N'Content Marketing Specialist', N'Tuyển dụng Content Marketing Specialist - VinGroup',
     N'Ho Chi Minh City', N'Full-time', 12000000.00, 22000000.00, N'Nhân viên sơ cấp (1-3 năm)',
     N'<p>Xây dựng nội dung marketing cho các sản phẩm và dịch vụ của Vingroup. Tham gia chiến lược nội dung, tạo bài viết, video, infographic và quản lý các kênh truyền thông.</p>',
     N'<ul><li>Có 1-3 năm kinh nghiệm Content Marketing, Copywriting</li><li>Viết tiếng Việt tốt, có khả năng sáng tạo nội dung</li><li>Kinh nghiệm với các công cụ SEO, social media</li><li>Thành thạo các công cụ chỉnh sửa ảnh/video</li><li>Tiếng Anh khá</li></ul>',
     N'<ul><li>Lương 12-22 triệu VND/tháng</li><li>Thưởng Hiệu lương 13 tháng</li><li>Bảo hiểm đầy đủ</li><li>Chế độ nghỉ phép 15 ngày/năm</li></ul>',
     GETDATE(), '2026-06-10', N'normal', N'Active');

SET IDENTITY_INSERT [job_post] OFF;
GO

-- ================================================================
-- 8. CV - Hồ sơ ứng viên
-- ================================================================
SET IDENTITY_INSERT [cv] ON;

INSERT INTO [cv] ([cv_id], [candidate_id], [title], [cv_url], [cv_json], [isDefault], [applied_at], [created_at], [updated_at], [status])
VALUES
    (1, 1, N'CV Thực tập sinh Lập trình Web - Nguyễn Văn Minh', N'/assets/cv/minh_cv.pdf', N'{"name":"Nguyễn Văn Minh","email":"nguyen.minh@email.com","phone":"0911234567","summary":"Sinh viên năm cuối CNTT, thực tập tại FPT Software","skills":["HTML","CSS","JavaScript","React"],"experience":[],"education":[{"school":"Trường Đại học Công nghệ - Đại học Quốc gia Hà Nội","major":"Công nghệ Thông tin","year":"2019-2023"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (2, 2, N'CV Java Backend Developer - Trần Thị Lan', N'/assets/cv/lan_cv.pdf', N'{"name":"Trần Thị Lan","email":"tran.lan@email.com","phone":"0912345678","summary":"2 năm kinh nghiệm Java Spring Boot, đã tham gia xây dựng hệ thống quản lý","skills":["Java","Spring Boot","MySQL","REST API","Docker"],"experience":[{"company":"Công ty ABC","position":"Junior Java Developer","duration":"2022-2024"}],"education":[{"school":"Trường Đại học Bách Khoa Hà Nội","major":"CNTT","year":"2018-2022"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (3, 3, N'CV Senior Python Developer - Lê Văn Hải', N'/assets/cv/hai_cv.pdf', N'{"name":"Lê Văn Hải","email":"le.hai@email.com","phone":"0913456789","summary":"Senior Python Developer, 6 năm kinh nghiệm ML/AI","skills":["Python","Machine Learning","TensorFlow","AWS","Docker"],"experience":[{"company":"Google Vietnam","position":"Senior Software Engineer","duration":"2019-Hiện tại"},{"company":"Amazon","position":"Software Engineer","duration":"2017-2019"}],"education":[{"school":"MIT","major":"Computer Science","year":"2012-2016"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (4, 4, N'CV Marketing Executive - Phạm Thị Mai', N'/assets/cv/mai_cv.pdf', N'{"name":"Phạm Thị Mai","email":"pham.mai@email.com","phone":"0914567890","summary":"Sinh viên mới ra trường Marketing, thực tập tại Agency 24h","skills":["SEO","Content Marketing","Google Analytics","Facebook Ads"],"experience":[{"company":"Agency 24h","position":"Thực tập sinh Marketing","duration":"2023-2024"}],"education":[{"school":"Trường Đại học Marketing","major":"Marketing","year":"2020-2024"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (5, 5, N'CV Project Manager - Hồng Văn Đức', N'/assets/cv/duc_cv.pdf', N'{"name":"Hồng Văn Đức","email":"hoang.duc@email.com","phone":"0915678901","summary":"PMP certified, 5 năm kinh nghiệm quản lý dự án IT cho fintech và e-commerce","skills":["Project Management","Agile","Scrum","JIRA","Risk Management"],"experience":[{"company":"Techcombank","position":"IT Project Manager","duration":"2020-Hiện tại"},{"company":"Shopee","position":"Project Manager","duration":"2018-2020"}],"education":[{"school":"Trường Đại học Kinh tế Quốc dân","major":"Quản lý Dự án","year":"2013-2017"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (6, 6, N'CV Fresher Designer - Vũ Thị Hòa', N'/assets/cv/hoa_cv.pdf', N'{"name":"Vũ Thị Hòa","email":"vu.hoa@email.com","phone":"0916789012","summary":"Sinh viên Thiết kế Đồ họa, thành thạo Figma, Photoshop","skills":["Figma","Adobe Photoshop","Illustrator","UI/UX Design","Blender"],"experience":[],"education":[{"school":"Trường Cao đẳng Nghệ thuật","major":"Thiết kế Đồ họa","year":"2019-2023"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (7, 7, N'CV DevOps Engineer - Nguyễn Văn Phúc', N'/assets/cv/phuc_cv.pdf', N'{"name":"Nguyễn Văn Phúc","email":"nguyen.phuc@email.com","phone":"0917890123","summary":"DevOps Engineer, 4 năm kinh nghiệm Docker, Kubernetes, AWS","skills":["Docker","Kubernetes","AWS","Terraform","CI/CD","Linux"],"experience":[{"company":"Công ty XYZ","position":"DevOps Engineer","duration":"2020-Hiện tại"}],"education":[{"school":"Trường Đại học CNTT","major":"Mạng máy tính","year":"2015-2019"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (8, 8, N'CV Kế toán trưởng - Đinh Thị Lan', N'/assets/cv/dinhlan_cv.pdf', N'{"name":"Đinh Thị Lan","email":"dinh.lan@email.com","phone":"0918901234","summary":"Kế toán trưởng 8 năm kinh nghiệm, chuyên gia kế toán doanh nghiệp sản xuất","skills":["Kế toán tổng hợp","Thuế","Tài chính","MISA","SAP"],"experience":[{"company":"Công ty Sản xuất ABC","position":"Kế toán trưởng","duration":"2018-Hiện tại"},{"company":"Công ty LOGISTICS XYZ","position":"Kế toán viên","duration":"2016-2018"}],"education":[{"school":"Trường Đại học Kinh tế Quốc dân","major":"Kế toán","year":"2012-2016"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (9, 9, N'CV Kỹ sư Cơ khí - Bùi Văn Hùng', N'/assets/cv/bhuihung_cv.pdf', N'{"name":"Bùi Văn Hùng","email":"bui.hung@email.com","phone":"0919012345","summary":"Kỹ sư Cơ khí, 4 năm kinh nghiệm thiết kế và gia công cơ khí","skills":["AutoCAD","SolidWorks","CATIA","Inventor","GD&T"],"experience":[{"company":"Công ty Cơ khí Đông A","position":"Kỹ sư Thiết kế","duration":"2020-Hiện tại"}],"education":[{"school":"Trường Đại học Bách Khoa Hồ Chí Minh","major":"Cơ khí","year":"2015-2019"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (10, 10, N'CV Thực tập sinh Marketing - Nguyễn Thị Thúy', N'/assets/cv/thuy_cv.pdf', N'{"name":"Nguyễn Thị Thúy","email":"nguyen.thuy@email.com","phone":"0910123456","summary":"Sinh viên năm 3 Marketing, cơ bản SEO và Content Marketing","skills":["SEO","Content Writing","Google Analytics","PowerPoint","Excel"],"experience":[],"education":[{"school":"Trường Đại học Marketing","major":"Marketing","year":"2021-2025"}]}', 1, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    -- Additional CVs
    (11, 1, N'CV Frontend Developer - Nguyễn Văn Minh (v2)', N'/assets/cv/minh_cv_v2.pdf', N'{"name":"Nguyễn Văn Minh","email":"nguyen.minh@email.com","phone":"0911234567","summary":"Frontend Developer ReactJS","skills":["React","JavaScript","CSS","HTML","Node.js"]}', 0, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (12, 3, N'CV Data Engineer - Lê Văn Hải', N'/assets/cv/hai_data_cv.pdf', N'{"name":"Lê Văn Hải","email":"le.hai@email.com","phone":"0913456789","summary":"Data Engineer 6 năm kinh nghiệm Big Data","skills":["Spark","Hadoop","Python","SQL","Airflow"]}', 0, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (13, 4, N'CV Digital Marketing - Phạm Thị Mai', N'/assets/cv/mai_digital_cv.pdf', N'{"name":"Phạm Thị Mai","email":"pham.mai@email.com","phone":"0914567890","summary":"Digital Marketing Specialist","skills":["Google Ads","Facebook Ads","SEO","Email Marketing","Analytics"]}', 0, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (14, 5, N'CV IT Manager - Hồng Văn Đức', N'/assets/cv/duc_it_cv.pdf', N'{"name":"Hồng Văn Đức","email":"hoang.duc@email.com","phone":"0915678901","summary":"IT Manager 5 năm kinh nghiệm","skills":["IT Strategy","Vendor Management","Budget Planning","Agile"]}', 0, NULL, GETDATE(), GETDATE(), N'ACTIVE'),
    (15, 7, N'CV SRE Engineer - Nguyễn Văn Phúc', N'/assets/cv/phuc_sre_cv.pdf', N'{"name":"Nguyễn Văn Phúc","email":"nguyen.phuc@email.com","phone":"0917890123","summary":"Site Reliability Engineer","skills":["Prometheus","Grafana","Docker","Kubernetes","AWS","Incident Management"]}', 0, NULL, GETDATE(), GETDATE(), N'ACTIVE');

SET IDENTITY_INSERT [cv] OFF;
GO

-- ================================================================
-- 9. BLOG_POST - Bài viết blog
-- ================================================================
SET IDENTITY_INSERT [blog_post] ON;

INSERT INTO [blog_post] ([blog_id], [admin_id], [title], [thumbnail_url], [summary], [content_json], [category], [is_published], [published_at], [created_at], [updated_at])
VALUES
    (1, 1, N'5 Kỹ năng cần có để trở thành Developer giỏi',
     N'/assets/img/blog/dev-skills.jpg',
     N'Lập trình viên giỏi cần nhiều hơn khả năng viết code. Đây là 5 kỹ năng phân biệt Developer tốt với Developer vừa phải.',
     N'{"blocks":[{"type":"heading","text":"5 Kỹ năng cần có để trở thành Developer giỏi"},{"type":"paragraph","text":"Trong thị trường công nghệ thông tin hiện nay, việc biết lập trình đã không còn là điều kiện đủ để trở thành một Developer giỏi. Bạn cần phát triển nhiều kỹ năng mềm và kỹ năng kỹ thuật khác nhau để có thể thăng hạng trong suốt sự nghiệp."},{"type":"heading","text":"1. Khả năng giải quyết vấn đề"},{"type":"paragraph","text":"Khả năng phân tích và giải quyết vấn đề là kỹ năng quan trọng nhất đối với bất kỳ Developer nào. Bạn cần biết cách phân tích yêu cầu, xác định vấn đề và tìm ra giải pháp tối ưu."},{"type":"heading","text":"2. Khả năng giao tiếp"},{"type":"paragraph","text":"Giao tiếp hiệu quả với đồng nghiệp, khách hàng và manager là kỹ năng không thể thiếu. Kỹ năng viết tài liệu, trình bày ý tưởng và lắng nghe đều rất quan trọng."},{"type":"heading","text":"3. Khả năng tự học"},{"type":"paragraph","text":"Công nghệ thay đổi liên tục, việc tự học và cập nhật kiến thức mới là điều bắt buộc. Bạn cần có kỹ năng tìm kiếm, đọc tài liệu và học nhanh."},{"type":"heading","text":"4. Kiến thức về cấu trúc dữ liệu và giải thuật"},{"type":"paragraph","text":"Đây là nền tảng quan trọng nhất trong lập trình. Hiểu sâu về cấu trúc dữ liệu sẽ giúp bạn viết code hiệu quả hơn và tối ưu hơn."},{"type":"heading","text":"5. Khả năng làm việc nhóm"},{"type":"paragraph","text":"Phần mềm hiện đại được xây dựng bởi các đội nhóm. Khả năng làm việc, phối hợp và biết thích nghi với nhóm là rất cần thiết."}]}',
     N'Lập trình', 1, GETDATE(), GETDATE(), GETDATE()),
    (2, 1, N'Cách viết CV ấn tượng dành cho sinh viên mới tốt nghiệp',
     N'/assets/img/blog/cv-writing.jpg',
     N'Hướng dẫn chi tiết cách viết CV hiệu quả dành cho sinh viên chưa có nhiều kinh nghiệm làm việc, giúp bạn nổi bật với việc tìm kiếm việc làm.',
     N'{"blocks":[{"type":"heading","text":"Cách viết CV ấn tượng dành cho sinh viên mới tốt nghiệp"},{"type":"paragraph","text":"Việc viết CV khi chưa có nhiều kinh nghiệm làm việc là thử thách đối với nhiều sinh viên. Tuy nhiên, bạn có thể tạo ra một CV nổi bật bằng cách tập trung vào kỹ năng, dự án học tập và các hoạt động ngoại khóa."},{"type":"heading","text":"1. Cấu trúc CV hiệu quả"},{"type":"paragraph","text":"Một CV tốt cần có các phần: Thông tin cá nhân, Mục tiêu nghề nghiệp, Kiến thức và kỹ năng, Kinh nghiệm (dự án học tập, thực tập, hoạt động), Học vấn - Chứng chỉ, Thông tin liên hệ bổ sung."},{"type":"heading","text":"2. Không có kinh nghiệm thì làm gì?"},{"type":"paragraph","text":"Hãy liên kết dự kinh nghiệm học tập vào như cùng dự án trường học, bài tập lớn, cuộc thi chuyên ngành. Kể cả hoạt động tình nguyện, câu lạc bộ cũng là điểm cộng."},{"type":"heading","text":"3. Mục tiêu nghề nghiệp"},{"type":"paragraph","text":"Viết mục tiêu ngắn gọn, rõ ràng và liên quan trực tiếp đến vị trí ứng tuyển. Tránh những mục tiêu chung chung như muốn học hỏi kinh nghiệm."}]}',
     N'Xu hướng nghề', 1, GETDATE(), GETDATE(), GETDATE()),
    (3, 1, N'Xu hướng tuyển dụng IT năm 2026 tại Việt Nam',
     N'/assets/img/blog/it-trends.jpg',
     N'Khám phá những xu hướng tuyển dụng CNTT nổi bật nhất năm 2026 tại Việt Nam, từ AI, Cloud đến DevOps và các vị trí được săn đón nhất.',
     N'{"blocks":[{"type":"heading","text":"Xu hướng tuyển dụng IT năm 2026 tại Việt Nam"},{"type":"paragraph","text":"Năm 2026, ngành IT Việt Nam tiếp tục phát triển mạnh mẽ với nhiều xu hướng tuyển dụng mới. Dưới đây là những điều bạn cần biết để có thể chuẩn bị tốt nhất cho sự nghiệp của mình."},{"type":"heading","text":"1. Artificial Intelligence (AI) và Machine Learning"},{"type":"paragraph","text":"Như cụ AI và ChatGPT đã trở thành xu hướng lớn nhất năm 2023-2024, như cụ này vẫn tiếp tục thích hợp và mở rộng. Các công ty đang rất cần những người có kiến thức về AI, prompt engineering và data science."},{"type":"heading","text":"2. Cloud Computing và DevOps"},{"type":"paragraph","text":"Với sự phát triển của AWS, Azure và Google Cloud, như cụ DevOps và Cloud Engineer vẫn rất hot. Các doanh nghiệp đang chuyển đổi lên cloud nên như cụ nhân sự trong lĩnh vực này rất được săn đón."},{"type":"heading","text":"3. Cybersecurity"},{"type":"paragraph","text":"An ninh mạng là một trong những lĩnh vực tăng trưởng nhanh nhất. Các cuộc tấn công mạng ngày càng tinh vi nên các doanh nghiệp rất cần chuyên gia an ninh mạng."},{"type":"heading","text":"4. Low-code/No-code Platform"},{"type":"paragraph","text":"Các công cụ low-code đang giúp doanh nghiệp tối ưu hóa quá trình phát triển phần mềm, nhưng vẫn cần người có kiến thức để xây dựng và quản lý các ứng dụng này."}]}',
     N'Xu hướng nghề', 1, GETDATE(), GETDATE(), GETDATE()),
    (4, 1, N'Hướng dẫn phỏng vấn hiệu quả dành cho người đi xin việc',
     N'/assets/img/blog/interview-tips.jpg',
     N'Từ cách chuẩn bị, trang phục, đến cách trả lời các câu hỏi phổ biến trong phỏng vấn, đây là hướng dẫn đầy đủ giúp bạn thành công trong mỗi buổi phỏng vấn.',
     N'{"blocks":[{"type":"heading","text":"Hướng dẫn phỏng vấn hiệu quả dành cho người đi xin việc"},{"type":"paragraph","text":"Phỏng vấn là bước quan trọng để bạn có được việc làm mong muốn. Dưới đây là những lời khuyên thực tế giúp bạn tự tin và thành công trong mỗi buổi phỏng vấn."},{"type":"heading","text":"1. Trước khi phỏng vấn"},{"type":"paragraph","text":"Nghiên cứu về công ty, vị trí ứng tuyển và người phỏng vấn. Hãy chuẩn bị sẵn một số câu hỏi và trả lời thật chuẩn bị. Thử luyện tập trả lời trước gương."},{"type":"heading","text":"2. Trang phục phỏng vấn"},{"type":"paragraph","text":"Mặc đồng phục thành lịch, phù hợp với văn hóa công ty. Nếu không biết rõ, hãy hỏi trước nhân sự về dress code."},{"type":"heading","text":"3. Trong lúc phỏng vấn"},{"type":"paragraph","text":"Hãy lắng nghe câu hỏi cẩn thận, xin điều chỉnh nếu cần. Trả lời thật thành, thân thiện, có tích cực. Kỹ năng làm chủ giờ và biểu hiện người là rất quan trọng."},{"type":"heading","text":"4. Câu hỏi phổ biến"},{"type":"paragraph","text":"Hãy chuẩn bị trả lời cho những câu hỏi như: Giới thiệu về bản thân? Tại sao bạn muốn làm ở đây? Bạn có điểm mạnh và điểm yếu gì? Bạn định vị bản thân năm tới như thế nào?"}]}',
     N'Mẹo nghề', 1, GETDATE(), GETDATE(), GETDATE()),
    (5, 2, N'Top 10 công ty IT hàng đầu Việt Nam năm 2026',
     N'/assets/img/blog/top-companies.jpg',
     N'Danh sách 10 công ty công nghệ thông tin tốt nhất Việt Nam để làm việc năm 2026, bao gồm các tiêu chí về lương, môi trường và cơ hội phát triển.',
     N'{"blocks":[{"type":"heading","text":"Top 10 công ty IT hàng đầu Việt Nam năm 2026"},{"type":"paragraph","text":"Việt Nam hiện có nhiều công ty IT với nơi làm việc hấp dẫn. Dưới đây là danh sách top 10 dựa trên các tiêu chí: lương thưởng, môi trường làm việc, cơ hội phát triển và phúc lợi."},{"type":"heading","text":"1. FPT Software"},{"type":"paragraph","text":"Công ty outsourcing lớn nhất Việt Nam, cơ hội làm việc tại nhiều nước trên thế giới. Lương cao, đào tạo tốt, cơ hội thử việc tại nước ngoài."},{"type":"heading","text":"2. Viettel Solutions"},{"type":"paragraph","text":"Tập đoàn Viễn Thông Quân Đội với nhiều dự án lớn trong nước và quốc tế. Lương thưởng hiệu lương, bảo hiểm VIP."},{"type":"heading","text":"3. Vingroup (VinBigdata, VinBrain)"},{"type":"paragraph","text":"Tập đoàn lớn với nhiều lĩnh vực, đặc biệt là AI và Big Data. Môi trường làm việc chuyên nghiệp, cơ hội phát triển cao."},{"type":"heading","text":"4. VNG Corporation"},{"type":"paragraph","text":"Công ty game và công nghệ lớn nhất miền Nam, có sản phẩm Zalo nổi tiếng. Làm việc với công nghệ hiện đại."},{"type":"heading","text":"5. Tiki"},{"type":"paragraph","text":"Sàn thương mại điện tử lớn thứ hai Việt Nam. Cơ hội làm việc với Big Data và e-commerce platform."}]}',
     N'Tin tức', 1, GETDATE(), GETDATE(), GETDATE());

SET IDENTITY_INSERT [blog_post] OFF;
GO

-- ================================================================
-- PHASE 4: TƯƠNG TÁC
-- ================================================================

-- ================================================================
-- 10. APPLICATION - Đơn ứng tuyển
-- ================================================================
SET IDENTITY_INSERT [application] ON;

INSERT INTO [application] ([application_id], [candidate_id], [cv_id], [job_id], [cover_letter], [applied_at], [interview_time], [interview_description], [status])
VALUES
    (1, 1, 1, 1, N'Tôi rất quan tâm đến vị trí Frontend Developer tại Vingroup. Với kiến thức về ReactJS đã học được trong trường và thực tập tại FPT Software, tôi mong muốn có cơ hội đóng góp vào dự án VinID.', GETDATE(), NULL, NULL, N'Pending'),
    (2, 2, 2, 2, N'Tôi có 2 năm kinh nghiệm với Java Spring Boot và muốn tham gia xây dựng hệ thống backend cho những sản phẩm lớn của Vingroup.', GETDATE(), NULL, NULL, N'Reviewing'),
    (3, 3, 3, 7, N'Với 6 năm kinh nghiệm trong lĩnh vực Python và Data Science, tôi tin rằng mình có thể đóng góp nhiều giá trị cho đội ngũ tại Viettel.', GETDATE(), '2026-04-20 09:00:00', N'Phỏng vấn kỹ thuật và hành vi tại Vingroup Tower, Hà Nội.', N'Interview'),
    (4, 1, 1, 4, N'Tôi muốn tham gia chương trình Fresher của FPT Software để phát triển kỹ năng Java và có cơ hội làm việc với khách hàng quốc tế.', GETDATE(), NULL, NULL, N'Accepted'),
    (5, 4, 4, 9, N'Tôi rất mong muốn có cơ hội làm việc tại Unilever, một trong những công ty hàng tiêu dùng lớn nhất thế giới, để học hỏi và phát triển trong lĩnh vực Brand Marketing.', GETDATE(), NULL, NULL, N'Pending'),
    (6, 5, 5, 7, N'Với chứng chỉ PMP và 5 năm kinh nghiệm quản lý dự án IT, tôi mong muốn đóng góp kinh nghiệm cho đội ngũ tại Viettel.', GETDATE(), '2026-04-22 14:00:00', N'Phỏng vấn gặp trực tiếp tại Trung tâm Hội nghị Quốc gia.', N'Interview'),
    (7, 6, 6, 15, N'Tôi là sinh viên Thiết kế Đồ họa, thành thạo Figma và Photoshop. Mong muốn có cơ hội thực hiện nội dung marketing cho Vingroup.', GETDATE(), NULL, NULL, N'Reviewing'),
    (8, 7, 7, 5, N'Với 4 năm kinh nghiệm DevOps và thành thạo Docker, Kubernetes, tôi mong muốn tham gia xây dựng hạ tầng CI/CD tại FPT Software.', GETDATE(), NULL, NULL, N'Accepted'),
    (9, 8, 8, 12, N'Tôi có 8 năm kinh nghiệm kế toán, trong đó 6 năm ở vai trò Kế toán trưởng. Rất mong muốn có cơ hội làm việc tại BIDV.', GETDATE(), NULL, NULL, N'Reviewing'),
    (10, 9, 9, 10, N'Tôi là Kỹ sư Cơ khí từ Đại học Bách Khoa TP.HCM, thành thạo AutoCAD và SolidWorks. Mong muốn tham gia nhóm Supply Chain của Unilever.', GETDATE(), NULL, NULL, N'Pending'),
    (11, 10, 10, 4, N'Tôi là sinh viên năm 3 Marketing, rất muốn thực tập và học hỏi tại FPT Software để biết thêm về IT và Marketing digital.', GETDATE(), NULL, NULL, N'Rejected'),
    (12, 2, 2, 14, N'Với kinh nghiệm Java, tôi muốn tham gia kiểm thử hệ thống tại Viettel để hiểu thêm về quy trình phát triển phần mềm ngân hàng.', GETDATE(), NULL, NULL, N'Pending'),
    (13, 3, 12, 3, N'Tôi có 6 năm kinh nghiệm Big Data, mong muốn tham gia xây dựng hệ thống dữ liệu cho Vingroup.', GETDATE(), '2026-04-25 10:00:00', N'Phỏng vấn kỹ thuật tại Vingroup, Ho Chi Minh.', N'Interview'),
    (14, 5, 14, 1, N'Với kinh nghiệm quản lý dự án fintech, tôi muốn đóng góp cho đội ngũ Frontend tại Vingroup.', GETDATE(), NULL, NULL, N'Reviewing'),
    (15, 7, 15, 5, N'Tôi là DevOps Engineer tại FPT Software, mong muốn tham gia dự án tại Đà Nẵng để thực hiện CI/CD cho các hệ thống lớn.', GETDATE(), NULL, NULL, N'Accepted'),
    (16, 1, 11, 6, N'Tôi rất mong muốn chương trình Fresher tại FPT Software, có thể làm việc tại Hà Nội hoặc Ho Chi Minh.', GETDATE(), NULL, NULL, N'Pending'),
    (17, 4, 13, 15, N'Với kiến thức về Digital Marketing và SEO, tôi mong muốn đóng góp cho nội dung marketing của Vingroup.', GETDATE(), NULL, NULL, N'Reviewing'),
    (18, 6, 6, 9, N'Tôi rất yêu thích thương hiệu Unilever và mong muốn có cơ hội làm việc trong lĩnh vực Brand tại Ho Chi Minh.', GETDATE(), NULL, NULL, N'Rejected'),
    (19, 8, 8, 11, N'Với 8 năm kinh nghiệm tài chính kế toán, tôi mong muốn chuyển đổi sang lĩnh vực IT ngân hàng tại BIDV.', GETDATE(), NULL, NULL, N'Pending'),
    (20, 9, 9, 12, N'Tôi là Kỹ sư Cơ khí nhưng muốn chuyển đổi nghề sang Kế toán, rất mong muốn có cơ hội đào tạo tại BIDV.', GETDATE(), NULL, NULL, N'Rejected');

SET IDENTITY_INSERT [application] OFF;
GO

-- ================================================================
-- 11. BOOKMARK - Tin đã lưu
-- ================================================================
SET IDENTITY_INSERT [bookmark] ON;

INSERT INTO [bookmark] ([bookmark_id], [job_id], [candidate_id], [created_at])
VALUES
    (1, 2, 1, GETDATE()),
    (2, 4, 1, GETDATE()),
    (3, 7, 3, GETDATE()),
    (4, 8, 3, GETDATE()),
    (5, 3, 7, GETDATE()),
    (6, 1, 5, GETDATE()),
    (7, 9, 4, GETDATE()),
    (8, 11, 8, GETDATE()),
    (9, 15, 6, GETDATE()),
    (10, 6, 10, GETDATE());

SET IDENTITY_INSERT [bookmark] OFF;
GO

-- ================================================================
-- 12. INTERVIEW - Phỏng vấn
-- ================================================================
SET IDENTITY_INSERT [interview] ON;

INSERT INTO [interview] ([interview_id], [application_id], [candidate_id], [recruiter_id], [interview_time], [interview_type], [location], [interviewers], [description])
VALUES
    (1, 3, 3, 3, '2026-04-20 09:00:00', N'Online', N'https://zoom.us/j/123456789', N'Nguyễn Văn C - Giám đốc Kỹ thuật, Lê Thị D - Chuyên viên Nhân sự',
     N'Phỏng vấn kỹ thuật về kiến thức Python, Data Science, Machine Learning và kiến thức về hạ tầng Big Data. Thời gian 60 phút.'),
    (2, 6, 5, 3, '2026-04-22 14:00:00', N'Offline', N'Trung tâm Hội nghị Quốc gia, Hà Nội - Phòng 501',
     N'Phỏng vấn hành vi và quản lý dự án. Gặp trực tiếp Ủy Viên Văn C - Quản lý Dự án Cấp cao. Thời gian 45 phút.',
     N'Phỏng vấn hệ thống và quản lý đội ngũ'),
    (3, 13, 3, 1, '2026-04-25 10:00:00', N'Online', N'https://meet.google.com/abc-defg-hij',
     N'Trần Thị B - Trưởng phòng Data Team',
     N'Phỏng vấn kỹ thuật về Data Engineering, Apache Spark, Hadoop và cloud computing. Thời gian 90 phút.'),
    (4, NULL, 2, 1, '2026-04-23 15:00:00', N'Hybrid', N'7 Bảng Lang, Ho Chi Minh City - Tầng 10',
     N'Nguyễn Văn A - Trưởng phòng Nhân sự, Hồng Thị E - Giám đốc Công nghệ',
     N'Phỏng vấn chính thức cho vị trí Backend Developer, bao gồm kỹ thuật và phỏng vấn hành vi.'),
    (5, NULL, 7, 2, '2026-04-24 11:00:00', N'Offline', N'Hà Nội Tower, 90 Phố Quang, Hà Nội',
     N'Lê Văn F - Quản lý DevOps, Nguyễn Thị G - Chuyên viên Tuyển dụng',
     N'Phỏng vấn kỹ thuật DevOps: Docker, Kubernetes, CI/CD pipeline và cloud AWS. Thời gian 60 phút.');

SET IDENTITY_INSERT [interview] OFF;
GO

-- ================================================================
-- 13. TEST - Bài kiểm tra
-- ================================================================
SET IDENTITY_INSERT [test] ON;

INSERT INTO [test] ([test_id], [recruiter_id], [title], [description], [created_at], [status])
VALUES
    (1, 2, N'Bài test kỹ năng IT - Cấp độ Junior', N'Bài test dành cho ứng viên ứng tuyển vị trí Developer sơ cấp. Bao gồm các câu hỏi về lập trình cơ bản, cấu trúc dữ liệu và giải thuật.',
     GETDATE(), N'active'),
    (2, 2, N'Bài test kỹ năng Marketing', N'Bài test dành cho ứng viên Marketing. Bao gồm kiến thức về marketing mix, SEO, content marketing và analytics.',
     GETDATE(), N'active'),
    (3, 3, N'Bài test kỹ năng Tiếng Anh', N'Bài test đánh giá trình độ tiếng Anh của ứng viên. Bao gồm phần đọc, viết và ngữ âm.',
     GETDATE(), N'active');

SET IDENTITY_INSERT [test] OFF;
GO

-- ================================================================
-- 14. QUESTION - Câu hỏi
-- ================================================================
SET IDENTITY_INSERT [question] ON;

INSERT INTO [question] ([question_id], [test_id], [question_text], [question_type], [options], [correct_answer])
VALUES
    -- Test 1: IT Skills (5 câu hỏi)
    (1, 1, N'Cho biết đâu là cấu trúc dữ liệu phù hợp để lưu trữ dữ liệu theo khóa (key-value)?', N'multiple_choice',
     N'["Array","LinkedList","HashMap","Tree"]', N'HashMap'),
    (2, 1, N'Difference giữa Stack và Queue là gì?', N'multiple_choice',
     N'["Stack hoạt động theo nguyên tắc FIFO, Queue hoạt động theo nguyên tắc LIFO","Stack hoạt động theo nguyên tắc LIFO, Queue hoạt động theo nguyên tắc FIFO","Cả A và B đều đúng","Cả A và B đều sai"]', N'Stack hoạt động theo nguyên tắc LIFO, Queue hoạt động theo nguyên tắc FIFO'),
    (3, 1, N'Cho biết độ phức tạp thời gian của thuật toán Quick Sort trong trung bình?', N'multiple_choice',
     N'["O(1)","O(n)","O(n log n)","O(n^2)"]', N'O(n log n)'),
    (4, 1, N'Giải thích khái niệm Object-Oriented Programming (OOP) và nêu tên 4 tính chất của nó?', N'essay',
     NULL, N'Object-Oriented Programming (OOP) là phương pháp lập trình dựa trên đối tượng. 4 tính chất: 1) Encapsulation (Đóng gói): Che giấu dữ liệu bên trong đối tượng. 2) Inheritance (Kế thừa): Lớp con kế thừa thuộc tính và phương thức từ lớp cha. 3) Polymorphism (Đa hình): Một đối tượng có thể có nhiều hình thái khác nhau. 4) Abstraction (Trừu tượng): Ẩn đi chi tiết phức tạp và chỉ hiển thị những gì cần thiết.'),
    (5, 1, N'Viết một đoạn code Java để đảo ngược một chuỗi mà không sử dụng hàm có sẵn để đảo ngược chuỗi?', N'essay',
     NULL, N'public class ReverseString { public static void main(String[] args) { String input = "Hello World"; char[] arr = input.toCharArray(); String reversed = ""; for(int i = arr.length - 1; i >= 0; i--) { reversed += arr[i]; } System.out.println(reversed); } }'),

    -- Test 2: Marketing Skills (5 câu hỏi)
    (6, 2, N'4P trong Marketing Mix bao gồm những yếu tố nào?', N'multiple_choice',
     N'["Product, Price, Place, Promotion","People, Process, Physical evidence, Product","Positioning, Packaging, Price, Promotion","Planning, Process, People, Price"]', N'Product, Price, Place, Promotion'),
    (7, 2, N'SEO là viết tắt của thuật ngữ gì?', N'multiple_choice',
     N'["Search Engine Optimization","Social Engine Optimization","Search Electronic Optimization","Software Engine Operation"]', N'Search Engine Optimization'),
    (8, 2, N'Chỉ số nào dưới đây được sử dụng để đo lường lưu lượng traffic website?', N'multiple_choice',
     N'["Google Analytics","Adobe Photoshop","Microsoft Excel","Slack"]', N'Google Analytics'),
    (9, 2, N'Phân tích sự khác biệt giữa Inbound Marketing và Outbound Marketing? Cho ví dụ cụ thể cho mỗi loại?', N'essay',
     NULL, N'Inbound Marketing thu hút khách hàng đến với doanh nghiệp thông qua nội dung giá trị, mang tính thu hút. Ví dụ: blog, SEO, mạng xã hội. Outbound Marketing là hình thức truyền thông mang tính đẩy, đưa thông tin đến khách hàng. Ví dụ: quảng cáo TV, telemarketing, email marketing.'),
    (10, 2, N'Để xây dựng một chiến dịch content marketing hiệu quả, các bước cần thực hiện là gì?', N'essay',
     NULL, N'1) Xác định mục tiêu và đối tượng khách hàng. 2) Nghiên cứu từ khóa và xu hướng. 3) Lên lịch nội dung (content calendar). 4) Tạo nội dung giá trị (blog, video, infographic). 5) Phân phối nội dung trên các kênh phù hợp. 6) Đo lường và phân tích kết quả. 7) Tối ưu hóa dựa trên dữ liệu.'),

    -- Test 3: Tiếng Anh (5 câu hỏi)
    (11, 3, N'Choose the correct sentence:', N'multiple_choice',
     N'["She don''t like coffee.","She doesn''t like coffee.","She not like coffee.","She doesn''t likes coffee."]', N'She doesn''t like coffee.'),
    (12, 3, N'What is the past participle of "write"?', N'multiple_choice',
     N'["Wrote","Written","Writing","Writen"]', N'Written'),
    (13, 3, N'Choose the correct answer: "If I ___ more money, I would travel the world."', N'multiple_choice',
     N'["have","had","had had","have had"]', N'had'),
    (14, 3, N'Write a paragraph (around 100 words) about "Your dream job and why you want to pursue it."', N'essay',
     NULL, N'My dream job is to become a Software Engineer at a leading technology company. I have been passionate about programming since I first wrote my first line of code in university. What excites me most about this career is the ability to create products that solve real problems and improve people lives. I want to work in a dynamic environment where I can continuously learn and grow. My goal is to develop expertise in cloud computing and artificial intelligence, areas that I believe will shape the future of technology.'),
    (15, 3, N'Translate the following Vietnamese sentence into English: "Tôi đã làm việc tại công ty này được 3 năm rồi."', N'essay',
     NULL, N'I have been working at this company for 3 years already. / I have been working at this company for three years now.');

SET IDENTITY_INSERT [question] OFF;
GO

-- ================================================================
-- 15. ASSIGNMENT - Phân công kiểm tra
-- ================================================================
SET IDENTITY_INSERT [assignment] ON;

INSERT INTO [assignment] ([assignment_id], [test_id], [job_id], [candidate_id], [assigned_at], [completed_at], [total_question], [correct_answer], [score], [status], [due_date])
VALUES
    (1, 1, 1, 1, GETDATE(), NULL, 5, NULL, NULL, N'doing', DATEADD(day, 7, GETDATE())),
    (2, 1, 2, 2, GETDATE(), '2026-04-05 15:30:00', 5, 4, 80.00, N'completed', '2026-04-05 23:59:00'),
    (3, 2, 9, 4, GETDATE(), NULL, 5, NULL, NULL, N'doing', DATEADD(day, 5, GETDATE())),
    (4, 1, 4, 1, GETDATE(), '2026-04-06 10:15:00', 5, 3, 60.00, N'completed', '2026-04-06 23:59:00'),
    (5, 3, 7, 3, GETDATE(), NULL, 5, NULL, NULL, N'doing', DATEADD(day, 10, GETDATE()));

SET IDENTITY_INSERT [assignment] OFF;
GO

-- ================================================================
-- PHASE 5: GIAO DỊCH
-- ================================================================

-- ================================================================
-- 16. TRANSACTION - Giao dịch
-- Password: 4 (hash SHA-256) - 4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a
-- ================================================================
SET IDENTITY_INSERT [transaction] ON;

INSERT INTO [transaction] ([transaction_id], [recruiter_id], [promotion_id], [price], [transaction_date], [payment_method], [status], [order_id], [vnp_txn_ref], [vnp_transaction_no], [json])
VALUES
    (1, 1, 1, 799200.00, GETDATE(), N'VNPay', N'success', N'ORD202604070001', N'VNP12345678901234', N'1234567890',
     N'{"vnp_Amount":"799200","vnp_BankCode":"NCB","vnp_CardType":"ATM","vnp_OrderInfo":"Mua gói Doanh nghiệp - VinGroup"}'),
    (2, 2, NULL, 249000.00, GETDATE(), N'VNPay', N'success', N'ORD202604070002', N'VNP23456789012345', N'2345678901',
     N'{"vnp_Amount":"249000","vnp_BankCode":"VNBANK","vnp_CardType":"ATM","vnp_OrderInfo":"Mua gói Tiêu chuẩn - FPT Software"}'),
    (3, 3, 2, 199000.00, GETDATE(), N'VNPay', N'success', N'ORD202604070003', N'VNP34567890123456', N'3456789012',
     N'{"vnp_Amount":"199000","vnp_BankCode":"SACOMBANK","vnp_CardType":"ATM","vnp_OrderInfo":"Mua gói Cơ bản - Viettel"}'),
    (4, 4, 3, 419300.00, GETDATE(), N'VNPay', N'success', N'ORD202604070004', N'VNP45678901234567', N'4567890123',
     N'{"vnp_Amount":"419300","vnp_BankCode":"TECHCOMBANK","vnp_CardType":"ATM","vnp_OrderInfo":"Mua gói Chuyên nghiệp - Unilever"}'),
    (5, 5, NULL, 599000.00, GETDATE(), N'VNPay', N'success', N'ORD202604070005', N'VNP56789012345678', N'5678901234',
     N'{"vnp_Amount":"599000","vnp_BankCode":"ACB","vnp_CardType":"ATM","vnp_OrderInfo":"Mua gói Chuyên nghiệp - BIDV"}');

SET IDENTITY_INSERT [transaction] OFF;
GO

-- ================================================================
-- 17. TRANSACTION_DETAIL - Chi tiết giao dịch
-- ================================================================
SET IDENTITY_INSERT [transaction_detail] ON;

INSERT INTO [transaction_detail] ([detail_id], [transaction_id], [service_id], [unit_price])
VALUES
    (1, 1, 4, 999000.00),
    (2, 2, 2, 249000.00),
    (3, 3, 1, 99000.00),
    (4, 4, 3, 599000.00),
    (5, 5, 3, 599000.00);

SET IDENTITY_INSERT [transaction_detail] OFF;
GO

-- ================================================================
-- 18. RECRUITER_PACKAGE - Gói dịch vụ NTD
-- ================================================================
SET IDENTITY_INSERT [recruiter_package] ON;

INSERT INTO [recruiter_package] ([recruiter_package_id], [recruiter_id], [service_id], [transaction_id], [total_credit], [used_credit], [start_date], [end_date], [status])
VALUES
    (1, 1, 4, 1, 1000, 150, '2026-04-07', '2027-04-07', N'active'),
    (2, 2, 2, 2, 150, 30, '2026-04-07', '2027-04-07', N'active'),
    (3, 3, 1, 3, 50, 10, '2026-04-07', '2027-04-07', N'active'),
    (4, 4, 3, 4, 500, 80, '2026-04-07', '2027-04-07', N'active'),
    (5, 5, 3, 5, 500, 45, '2026-04-07', '2027-04-07', N'active');

SET IDENTITY_INSERT [recruiter_package] OFF;
GO

-- ================================================================
-- 19. NOTIFICATION - Thông báo
-- ================================================================
SET IDENTITY_INSERT [notification] ON;

INSERT INTO [notification] ([id], [recipient_type], [recipient_id], [is_global], [title], [message], [is_read], [created_at])
VALUES
    (1, N'candidate', 1, 0, N'Có tin tuyển dụng mới phù hợp với bạn!', N'Vingroup vừa đăng tin Tuyển dụng Frontend Developer (ReactJS) với mức lương 15-30 triệu VND/tháng. Tin này có thể phù hợp với hồ sơ của bạn!', 0, GETDATE()),
    (2, N'candidate', 2, 0, N'Trạng thái đơn ứng tuyển đã được cập nhật', N'Đơn ứng tuyển vị trí Backend Developer tại Vingroup của bạn hiện đang được xem xét (Reviewing). Chúng tôi sẽ thông báo khi có cập nhật mới.', 1, GETDATE()),
    (3, N'recruiter', 1, 0, N'Bạn có 5 đơn ứng tuyển mới!', N'Trong tuần này, tin tuyển dụng "Frontend Developer (ReactJS) - VinGroup" của bạn đã nhận được 3 đơn ứng tuyển. Tin "Backend Developer (Java Spring Boot) - VinGroup" nhận được 2 đơn.', 0, GETDATE()),
    (4, N'candidate', 3, 0, N'Lịch phỏng vấn đã được xác nhận!', N'Bạn đã được xác nhận phỏng vấn tại Viettel vào ngày 20/04/2026 lúc 09:00 theo hình thức Online. Vui lòng kiểm tra email để nhận link Zoom.', 0, GETDATE()),
    (5, N'recruiter', 2, 0, N'Cơ hội gặp ứng viên tại sự kiện tuyển dụng', N'FPT Software được mời tham gia Vietnam IT Job Fair 2026 tổ chức tại Hà Nội vào ngày 25/04/2026. Sự kiện có hơn 500 ứng viên tham gia.', 0, GETDATE()),
    (6, N'candidate', 5, 0, N'Chúc mừng! Bạn đã vượt qua vòng kiểm tra', N'Chúc mừng Phạm Thị Mai! Đơn ứng tuyển vị trí Brand Executive tại Unilever của bạn đã vượt qua vòng kiểm tra và được chuyển tiếp đến vòng phỏng vấn tiếp theo.', 1, GETDATE()),
    (7, N'recruiter', 3, 0, N'Tin tuyển dụng của bạn đã được duyệt', N'Tin tuyển dụng "Senior Backend Developer - Viettel" của bạn đã được duyệt và hiển thị trên trang chủ. Tin của bạn được xếp hạng Top Hot tuyển dụng tuần này.', 0, GETDATE()),
    (8, N'candidate', 1, 0, N'Bạn nhận được lời mời làm bài kiểm tra', N'FPT Software gửi lời mời làm bài kiểm tra kỹ năng IT - Cấp độ Junior. Vui lòng hoàn thành trong vòng 7 ngày kể từ ngày nhận được thông báo này.', 0, GETDATE()),
    (9, N'recruiter', 4, 0, N'Báo cáo tuần - Thống kê tuyển dụng', N'Tuần này, Unilever đã nhận được 15 đơn ứng tuyển, trong đó 8 đơn phù hợp với các tiêu chí. Tổng số lượt xem tin tuyển dụng đạt 342 lượt.', 1, GETDATE()),
    (10, N'candidate', 8, 0, N'Thông báo hạn mức credit xem liên hệ', N'Tài khoản BIDV của bạn còn 15 credit để xem thông tin liên hệ ứng viên. Vui lòng nạp thêm credit nếu cần tiếp tục sử dụng dịch vụ.', 0, GETDATE());

SET IDENTITY_INSERT [notification] OFF;
GO

-- ================================================================
-- PHASE 6: BỔ SUNG
-- ================================================================

-- ================================================================
-- 20. JOB_ADVERTISEMENT - Quảng cáo việc làm
-- Password: 5 (hash SHA-256) - ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d
-- Password: 6 (hash SHA-256) - e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683
-- ================================================================
SET IDENTITY_INSERT [job_advertisement] ON;

INSERT INTO [job_advertisement] ([ad_id], [job_id], [recruiter_id], [description], [thumbnail_url], [start_date], [end_date], [status], [created_at])
VALUES
    (1, 7, 3, N'Tin quảng cáo nổi bật - Senior Backend Developer tại Viettel. Mức lương từ 30-60 triệu VND/tháng, làm việc tại Hà Nội. Ứng viên yêu cầu có 5+ năm kinh nghiệm Java, Go hoặc Node.js.',
     N'/assets/img/ads/viettel-backend.jpg', GETDATE(), DATEADD(day, 30, GETDATE()), N'active', GETDATE()),
    (2, 1, 1, N'Tin quảng cáo nổi bật - Frontend Developer ReactJS tại VinGroup. Mức lương 15-30 triệu VND/tháng, chế độ phụ cấp 5 sao, thưởng 13-14 tháng.',
     N'/assets/img/ads/vingroup-frontend.jpg', GETDATE(), DATEADD(day, 15, GETDATE()), N'active', GETDATE()),
    (3, 10, 4, N'Tin quảng cáo nổi bật - Supply Chain Manager tại Unilever. Mức lương từ 35-60 triệu VND/tháng, chế độ nghỉ phép 20 ngày/năm, bảo hiểm VIP.',
     N'/assets/img/ads/unilever-supply.jpg', GETDATE(), DATEADD(day, 20, GETDATE()), N'active', GETDATE());

SET IDENTITY_INSERT [job_advertisement] OFF;
GO

-- ================================================================
-- 21. CONTACT_ACCESS_LOG - Nhật ký truy cập liên hệ
-- ================================================================
SET IDENTITY_INSERT [contact_access_log] ON;

INSERT INTO [contact_access_log] ([id], [recruiter_id], [candidate_id], [points_deducted], [ip_address], [user_agent], [access_time])
VALUES
    (1, 1, 1, 5, N'203.162.10.1', N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', GETDATE()),
    (2, 1, 2, 5, N'203.162.10.2', N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', GETDATE()),
    (3, 2, 3, 5, N'203.162.10.3', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Safari/605.1.15', GETDATE()),
    (4, 3, 5, 5, N'203.162.10.4', N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', GETDATE()),
    (5, 4, 4, 5, N'203.162.10.5', N'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) Mobile/15E148', GETDATE());

SET IDENTITY_INSERT [contact_access_log] OFF;
GO

-- ================================================================
-- 22. CV_TEMPLATE - Mẫu CV
-- ================================================================
SET IDENTITY_INSERT [cv_template] ON;

INSERT INTO [cv_template] ([id], [candidate_id], [title], [html_content], [created_at])
VALUES
    (1, 1, N'Mẫu CV Chuyên nghiệp - Hiện đại',
     N'<div class="cv-container"><div class="cv-header"><h1>Nguyễn Văn Minh</h1><p>Frontend Developer | nguyen.minh@email.com | 0911234567</p></div><div class="cv-section"><h2>Kiến thức kỹ năng</h2><ul><li>HTML, CSS, JavaScript (ES6+)</li><li>ReactJS, Vue.js</li><li>Git, CI/CD</li></ul></div><div class="cv-section"><h2>Kinh nghiệm</h2><p>Thực tập sinh tại FPT Software (2023-2024)</p></div></div>',
     GETDATE()),
    (2, 2, N'Mẫu CV IT - Dark Mode',
     N'<div class="cv-container dark"><div class="cv-header"><h1>Trần Thị Lan</h1><p>Java Backend Developer | tran.lan@email.com | 0912345678</p></div><div class="cv-section"><h2>Kiến thức kỹ năng</h2><ul><li>Java Spring Boot, Hibernate</li><li>MySQL, PostgreSQL, MongoDB</li><li>RESTful API, Microservices</li></ul></div></div>',
     GETDATE()),
    (3, 3, N'Mẫu CV Senior - Cao cấp',
     N'<div class="cv-container premium"><div class="cv-header"><h1>Lê Văn Hải</h1><p>Senior Python Developer | le.hai@email.com | 0913456789</p></div><div class="cv-section"><h2>Tư vấn chuyên môn</h2><p>Đề cử lãnh đạo, chuyên gia Machine Learning và AI với 6 năm kinh nghiệm</p></div></div>',
     GETDATE()),
    (4, 4, N'Mẫu CV Marketing - Màu sắc',
     N'<div class="cv-container marketing"><div class="cv-header"><h1>Phạm Thị Mai</h1><p>Marketing Executive | pham.mai@email.com | 0914567890</p></div><div class="cv-section"><h2>Kiến thức Marketing</h2><ul><li>SEO, Content Marketing</li><li>Google Analytics, Facebook Ads</li><li>Social Media Management</li></ul></div></div>',
     GETDATE()),
    (5, 6, N'Mẫu CV Designer - Sáng tạo',
     N'<div class="cv-container designer"><div class="cv-header"><h1>Vũ Thị Hòa</h1><p>UI/UX Designer | vu.hoa@email.com | 0916789012</p></div><div class="cv-section"><h2>Công cụ</h2><ul><li>Figma, Adobe XD</li><li>Photoshop, Illustrator</li><li>Blender, After Effects</li></ul></div></div>',
     GETDATE());

SET IDENTITY_INSERT [cv_template] OFF;
GO

-- ================================================================
-- 23. RESPONSE - Trả lời câu hỏi kiểm tra
-- ================================================================
SET IDENTITY_INSERT [response] ON;

INSERT INTO [response] ([response_id], [question_id], [assignment_id], [response_text], [is_correct], [created_date])
VALUES
    -- Assignment 2: Trần Thị Lan - Test 1 (4/5 đúng)
    (1, 1, 2, N'HashMap', 1, GETDATE()),
    (2, 2, 2, N'Stack hoạt động theo nguyên tắc LIFO, Queue hoạt động theo nguyên tắc FIFO', 1, GETDATE()),
    (3, 3, 2, N'O(n log n)', 1, GETDATE()),
    (4, 4, 2, N'OOP gồm 4 tính chất: Đóng gói (Encapsulation), Kế thừa (Inheritance), Đa hình (Polymorphism), Trừu tượng (Abstraction).', 1, GETDATE()),
    (5, 5, 2, N'public class Reverse { public static void main(String[] args) { String s = "Hello"; StringBuilder sb = new StringBuilder(); for(int i = s.length()-1; i>=0; i--) sb.append(s.charAt(i)); System.out.println(sb); } }', 1, GETDATE()),

    -- Assignment 4: Nguyễn Văn Minh - Test 1 (3/5 đúng)
    (6, 1, 4, N'LinkedList', 0, GETDATE()),
    (7, 2, 4, N'Stack hoạt động theo nguyên tắc LIFO, Queue hoạt động theo nguyên tắc FIFO', 1, GETDATE()),
    (8, 3, 4, N'O(n^2)', 0, GETDATE()),
    (9, 4, 4, N'OOP gồm 4 tính chất: Đóng gói (Encapsulation), Kế thừa (Inheritance), Đa hình (Polymorphism), Trừu tượng (Abstraction).', 1, GETDATE()),
    (10, 5, 4, N'public class ReverseString { public static void main(String[] args) { String str = "Test"; char[] arr = str.toCharArray(); String result = ""; for(int i = arr.length-1; i>=0; i--) { result += arr[i]; } System.out.println(result); } }', 0, GETDATE());

SET IDENTITY_INSERT [response] OFF;
GO

-- ================================================================
-- HOÀN TẤT SEED DATA
-- ================================================================
PRINT N'ĐÃ CHÈN HOÀN TOÀN SEED DATA CHO RECRUITMENT DATABASE!';
PRINT N'Tổng số bảng đã chèn data: 23';
PRINT N'Tổng số bản ghi: 150+ bản ghi';
PRINT N'';
PRINT N'TÀI KHOẢN ĐỂ TEST:';
PRINT N'Admin:      admin@recruitment.com / 1';
PRINT N'Admin 2:    mod@recruitment.com / 1';
PRINT N'Recruiter:  hr@vingroup.com / 2';
PRINT N'Candidate:  nguyen.minh@email.com / 3';
GO
