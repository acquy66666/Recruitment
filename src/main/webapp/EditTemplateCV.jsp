<%-- 
    Document   : createCV
    Created on : Jul 1, 2025, 3:19:25 AM
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tạo mới CV</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <!-- <link rel="stylesheet" type="text/css" href="css/scroll.css"> -->
        <link rel="stylesheet" type="text/css" href="css/column_scroll.css">
        <link rel="stylesheet" type="text/css" href="css/thin_scroll.css">
        <link rel="stylesheet" type="text/css" href="css/theme.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link href='https://fonts.googleapis.com/css?family=Roboto:300,400,500' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700' rel='stylesheet' type='text/css'>


    </head>

    <body>


        <div class="container-fluid">

            <div class="row">


                <div class="col-sm-3 no-print" id="left">

                    <div id="panel">

                        <button class="btn btn-block btn-primary" data-toggle="modal" data-target="#usageModal">Xem Hướng
                            Dẫn</button>
                        <button class="btn btn-block btn-success" onclick="window.print()">Xuất File PDF</button>

                        <button id="saveBtn" class="btn btn-block btn-danger">Lưu CV</button>

                        <hr>

                        <h3 class="text-center">Tùy chỉnh CV</h3>
                        <button id="defaultTemplateBtn" class="btn btn-block btn-danger" onclick="template('default');">Cơ
                            bản</button>
                        <button id="customTemplateBtn" class="btn btn-block btn-default" onclick="template('custom');">Nâng
                            cao</button>
                        <h5>
                            Thông tin liên hệ (số lượng)
                            <div class="toggle-button">
                                <div class="toggle-option" data-toggle="contact" id="contact3">3</div>
                                <div class="toggle-option selected" data-toggle="contact" id="contact4">4</div>
                                <div class="toggle-option" data-toggle="contact" id="contact5">5</div>
                            </div>
                        </h5>
                        <h5>
                            Căn lề ngang
                            <div class="toggle-button">
                                <div class="toggle-option" data-toggle="margin" id="margin1">1</div>
                                <div class="toggle-option" data-toggle="margin" id="margin2">2</div>
                                <div class="toggle-option" data-toggle="margin" id="margin3">3</div>
                                <div class="toggle-option selected" data-toggle="margin" id="margin4">4</div>
                                <div class="toggle-option" data-toggle="margin" id="margin5">5</div>
                                <div class="toggle-option" data-toggle="margin" id="margin6">6</div>
                            </div>
                        </h5>
                        <h5>
                            Khoảng cách dòng
                            <div class="toggle-button">
                                <div class="toggle-option" data-toggle="line" id="line1">1</div>
                                <div class="toggle-option" data-toggle="line" id="line2">2</div>
                                <div class="toggle-option" data-toggle="line" id="line3">3</div>
                                <div class="toggle-option selected" data-toggle="line" id="line4">4</div>
                                <div class="toggle-option" data-toggle="line" id="line5">5</div>
                                <div class="toggle-option" data-toggle="line" id="line6">6</div>
                            </div>
                        </h5>

                        <br>

                        <div id="customTemplateOptions">
                            <h5>
                                Phông chữ
                                <div class="toggle-button">
                                    <div class="toggle-option" data-toggle="font" id="fontVerdanaSans">1</div>
                                    <div class="toggle-option" data-toggle="font" id="fontVerdanaSerif">2</div>
                                    <div class="toggle-option selected" data-toggle="font" id="fontRoboto">3</div>
                                    <div class="toggle-option" data-toggle="font" id="fontDroid">4</div>
                                </div>
                            </h5>
                            <h5>
                                Tiêu Đề In Hoa
                                <div class="toggle-button">
                                    <div class="toggle-option selected" data-toggle="case" id="caseNormal">Mặc định</div>
                                    <div class="toggle-option" data-toggle="case" id="caseUpper">In Hoa</div>
                                </div>
                            </h5>
                            <h5>
                                Kiểu Tiêu Đề
                                <div class="toggle-button">
                                    <div class="toggle-option selected" data-toggle="title" id="titleRuled">Đường kẻ</div>
                                    <div class="toggle-option" data-toggle="title" id="titleShaded">Có nền</div>
                                </div>
                            </h5>
                            <h5>
                                Vị trí đường kẻ Tiêu Đề
                                <div class="toggle-button">
                                    <div class="toggle-option selected" data-toggle="rule" id="ruleAbove">Bên trên</div>
                                    <div class="toggle-option" data-toggle="rule" id="ruleBelow">Bên dưới</div>
                                </div>
                            </h5>
                            <br>

                            <h5>
                                Thông tin thêm (dưới tên)
                                <div class="toggle-button">
                                    <div class="toggle-option selected" data-toggle="course" id="course1">2 dòng</div>
                                    <div class="toggle-option" data-toggle="course" id="course2">3 dòng</div>
                                </div>
                            </h5>
                            <h5>
                                Bố cục "Kinh Nghiệm"
                                <div class="toggle-button">
                                    <div class="toggle-option selected" data-toggle="experience" id="experience1">Loại 1
                                    </div>
                                    <div class="toggle-option" data-toggle="experience" id="experience2">Loại 2</div>
                                </div>
                            </h5>
                            <h5>
                                Bố cục "Dự Án"
                                <div class="toggle-button">
                                    <div class="toggle-option selected" data-toggle="projects" id="projects1">Loại 1</div>
                                    <div class="toggle-option" data-toggle="projects" id="projects2">Loại 2</div>
                                </div>
                            </h5>
                            <br>
                        </div>

                        <h5>
                            <button class="btn btn-sm btn-block btn-primary" data-toggle="modal"
                                    data-target="#sectionToggleModal">Ẩn/Hiện các danh mục</button>
                        </h5>

                        <hr>

                        <h3 class="text-center">Danh sách và các mục</h3>
                        <button class="btn btn-block btn-xs btn-success" onclick="insertList();">+ Thêm mục phụ</button>
                        <button class="btn btn-block btn-xs btn-warning" onclick="decreaseIndent();">&lt;&lt; Giảm khoảng
                            cách lề</button>
                        <button class="btn btn-block btn-xs btn-warning" onclick="increaseIndent();">&gt;&gt; Tăng khoảng
                            cách lề</button>
                        <h5>
                            Kiểu mục con
                            <div class="toggle-button">
                                <button class="btn btn-xs custom-button" onclick="changeListStyle('disc');">&#9899;</button>
                                <button class="btn btn-xs custom-button"
                                        onclick="changeListStyle('circle');">&#9898;</button>
                                <button class="btn btn-xs custom-button"
                                        onclick="changeListStyle('square');">&#9632;</button>
                                <button class="btn btn-xs custom-button" onclick="changeListStyle('dash');">-</button>
                                <button class="btn btn-xs custom-button" onclick="changeListStyle('decimal');">1.</button>
                                <button class="btn btn-xs custom-button"
                                        onclick="changeListStyle('upper-roman');">I.</button>
                                <button class="btn btn-xs custom-button"
                                        onclick="changeListStyle('lower-roman');">i.</button>
                                <button class="btn btn-xs custom-button"
                                        onclick="changeListStyle('upper-alpha');">A.</button>
                                <button class="btn btn-xs custom-button"
                                        onclick="changeListStyle('lower-alpha');">a.</button>
                            </div>
                        </h5>

                    </div>

                </div>


                <div class="col-sm-9 text-center" id="right">

                    <form id="saveCvForm" action="EditTemplateCV" method="post">
                        <input type="hidden" name="candidateId" value="${candidateId}">
                        <input type="hidden" name="templateId" value="${cvTemplate.cvId}">
                        <label for="cvTitle"style="color: #ffffff; font-size: 20px; font-weight: 500; margin: 20px 0px 8px;">Tiêu đề:</label>
                        <input type="text" name="title" id="cvTitle" value="${cvTemplate.title}" required
                            style=" margin: 0 20px 20px; padding: 10px 12px; font-size: 14px; border: 1px solid #ccc; border-radius: 3px; box-sizing: border-box;"/>
                        <input type="hidden" name="htmlContent" id="htmlContent">
                        <div id="page" class="roboto">
                            ${cvTemplate.htmlContent}
                        </div>
                    </form>

                </div>


            </div>

        </div>


        <div class="modal fade" id="usageModal" tabindex='-1'>
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h5><strong>Ghi chú : </strong>Dùng trình duyệt <strong>Google Chrome</strong> để có trải nghiệm tốt
                            nhất.</h5>
                        <h4><strong>Chỉnh sửa nội dung</strong></h4>
                        <ul>
                            <li>Chỉnh sửa nội dung CV giống như trình soạn thảo văn bản thông thường.</li>
                            <li>Toàn bộ các đề mục có thể được thêm, sắp xếp lại hoặc xóa bằng cách cắt, sao chép, dán.</li>
                            <li>Để định dạng văn bản, hãy chọn phần cần định dạng rồi nhấn <kbd>Ctrl+b</kbd> để in đậm,
                                <kbd>Ctrl+i</kbd> để in nghiêng, <kbd>Ctrl+u</kbd> để gạch chân.</li>
                            <li>Dùng nút "Thêm mục phụ" để chèn các ý nhỏ bên trong một mục (như trong phần Thành tựu).</li>
                            <li>Có thể thay đổi khoảng cách lề và kiểu đánh dấu đầu dòng của danh sách tại vị trí con trỏ.
                            </li>
                        </ul>

                        </ul>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade" id="sectionToggleModal" tabindex='-1'>
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <div class="checkbox"><label><input type="checkbox" name="sectionToggle" checked="true"
                                                            value="sectionEducation">Học Vấn</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="sectionToggle" checked="true"
                                                            value="sectionExperience">Kinh nghiệm</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="sectionToggle" checked="true"
                                                            value="sectionPublications">Công trình nghiên cứu</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="sectionToggle" checked="true"
                                                            value="sectionProjects">Dự án</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="sectionToggle" checked="true"
                                                            value="sectionSkills">Kĩ năng</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="sectionToggle" checked="true"
                                                            value="sectionAchievements">Thành tựu</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="sectionToggle" checked="true"
                                                            value="sectionCourses">Chứng chỉ</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="sectionToggle" checked="true"
                                                            value="sectionCurricular">Hoạt động ngoại khóa</label></div>
                        <div class="checkbox"><label><input type="checkbox" name="sectionToggle"
                                                            value="sectionFooterMessage">Thông tin người tham chiếu</label></div>
                    </div>
                </div>
            </div>
        </div>



        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/main.js"></script>

    </body>
    <script>
                                            document.getElementById('saveBtn').addEventListener('click', () => {
                                                document.getElementById('htmlContent').value = document.getElementById('page').innerHTML;
                                                document.getElementById('saveCvForm').submit();
                                            });
    </script>

</html>
