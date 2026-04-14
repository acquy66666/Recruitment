<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%
    JSONObject json = new JSONObject((String) request.getAttribute("formattedText"));
    JSONObject personal = json.getJSONObject("personal_information");
    JSONArray skills = json.getJSONArray("skill_group");
    JSONArray education = json.optJSONArray("education");
    JSONArray experience = json.getJSONArray("working_experience");
    int initialSkillIndex = (skills != null ? skills.length() : 0);
    int initialEduIndex = (education != null ? education.length() : 0);
    int initialExpIndex = (experience != null ? experience.length() : 0);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa thông tin CV</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

        <style>
            body {
                background: linear-gradient(135deg, #44a1ff 0%, #204d91 50%, #58affc 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .main-container {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(30, 60, 114, 0.2);
                margin: 2rem auto;
                max-width: 1200px;
            }

            .section-card {
                background: white;
                border-radius: 15px;
                box-shadow: 0 8px 25px rgba(30, 60, 114, 0.1);
                border: none;
                margin-bottom: 2rem;
                overflow: hidden;
            }

            .section-header {
                background: linear-gradient(135deg, #204d91 0%, #44a1ff 100%);
                color: white;
                padding: 1.5rem;
                margin: 0;
            }

            .section-header.skills {
                background: linear-gradient(135deg, #204d91 0%, #44a1ff 100%);
            }

            .section-header.education {
                background: linear-gradient(135deg, #204d91 0%, #44a1ff 100%);
            }

            .section-header.experience {
                background: linear-gradient(135deg, #204d91 0%, #44a1ff 100%);
            }

            .section-header.debug {
                background: linear-gradient(135deg, #37474f 0%, #263238 100%);
            }

            .input-group-custom {
                background: #f8faff;
                border-radius: 10px;
                padding: 1.5rem;
                margin-bottom: 1rem;
                border: 2px solid transparent;
                transition: all 0.3s ease;
            }

            .input-group-custom:hover {
                border-color: #e3f2fd;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(30, 60, 114, 0.15);
            }

            .form-control {
                border-radius: 8px;
                border: 2px solid #e3f2fd;
                padding: 0.75rem 1rem;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #2196f3;
                box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.25);
            }

            .btn-add {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                border: none;
                border-radius: 10px;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                transition: all 0.3s ease;
                color: white;
            }

            .btn-add:hover {
                background: linear-gradient(135deg, #1a3464 0%, #245289 100%);
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(30, 60, 114, 0.4);
                color: white;
            }

            .btn-add.skills {
                background: linear-gradient(135deg, #2196f3 0%, #1976d2 100%);
            }

            .btn-add.skills:hover {
                background: linear-gradient(135deg, #1e88e5 0%, #1565c0 100%);
                color: white;
            }

            .btn-add.education {
                background: linear-gradient(135deg, #2196f3 0%, #1976d2 100%);
            }

            .btn-add.education:hover {
                background: linear-gradient(135deg, #1e88e5 0%, #1565c0 100%);
                color: white;
            }

            .btn-add.experience {
                background: linear-gradient(135deg, #2196f3 0%, #1976d2 100%);
            }

            .btn-add.experience:hover {
                background: linear-gradient(135deg, #1e88e5 0%, #1565c0 100%);
                color: white;
            }

            .btn-remove {
                background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);
                border: none;
                border-radius: 8px;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }

            .btn-remove:hover {
                background: linear-gradient(135deg, #e53935 0%, #c62828 100%);
                transform: scale(1.1);
            }

            .debug-card {
                background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
                border-radius: 10px;
                padding: 1rem;
                text-align: center;
                border: 2px solid #90caf9;
            }

            .debug-number {
                font-size: 2rem;
                font-weight: bold;
                color: #1565c0;
            }

            .submit-btn {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 50%, #4facfe 100%);
                border: none;
                border-radius: 15px;
                padding: 1rem 3rem;
                font-size: 1.2rem;
                font-weight: 600;
                color: white;
                transition: all 0.3s ease;
            }

            .submit-btn:hover {
                background: linear-gradient(135deg, #1a3464 0%, #245289 50%, #3d8bfe 100%);
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(30, 60, 114, 0.5);
                color: white;
            }

            .page-title {
                text-align: center;
                color: white;
                margin-bottom: 3rem;
            }

            .page-title h1 {
                font-size: 3rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            }

            .page-title p {
                font-size: 1.2rem;
                opacity: 0.9;
            }
        </style>
    </head>
    <body>
        <% String error = (String) request.getAttribute("errorMessage"); %>
        <% if (error != null) { %>
        <div style="color:red;"><%= error %></div>
        <% } %>

        <div class="container-fluid py-4">
            <div class="page-title">
                <h1><i class="bi bi-person-vcard"></i> Chỉnh sửa thông tin CV</h1>
                <p>Cập nhật thông tin cá nhân và kinh nghiệm của bạn</p>
            </div>

            <div class="main-container p-4">
                <form action="SaveCVServlet" method="post" enctype="multipart/form-data">

                    <!-- Personal Information Section -->
                    <div class="section-card">
                        <div class="section-header">
                            <h3 class="mb-0">
                                <i class="bi bi-person-fill me-2"></i>
                                Thông tin cá nhân
                            </h3>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="address" class="form-label fw-semibold">Địa chỉ</label>
                                    <input type="text" class="form-control" id="address" name="address" 
                                           value="<%= personal.getString("address") %>" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="birthdate" class="form-label fw-semibold">Ngày sinh</label>
                                    <input type="text" class="form-control" id="birthdate" name="birthdate" placeholder="dd/mm/yyyy" 
                                           value="<%= personal.getString("birthdate") %>" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label fw-semibold">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="<%= personal.getString("email") %>" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                                    <input type="text" class="form-control" id="phone" name="phone"
                                           value="<%= personal.getString("phone_number") %>" required
                                           pattern="\d{10,11}" title="Số điện thoại từ 10-11 chữ số">
                                </div>
                            </div>
                        </div>
                    </div>



                    <!-- Education Section -->
                    <div class="section-card">
                        <div class="section-header education">
                            <h3 class="mb-0">
                                <i class="bi bi-mortarboard-fill me-2"></i>
                                Học vấn
                            </h3>
                        </div>
                        <div class="card-body p-4">
                            <div id="eduSection">
                                <!-- Initial education entries -->
                                <%
                                if (education != null) {
                                    for (int i = 0; i < education.length(); i++) {
                                        JSONObject edu = education.getJSONObject(i);
                                %>
                                <div class="input-group-custom">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="mb-0 text-muted">Học vấn #<%= i + 1 %></h5>
                                        <button type="button" class="btn btn-remove" onclick="removeField('eduSection', 'edu')">
                                            <i class="bi bi-x-lg text-white"></i>
                                        </button>
                                    </div>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold">Ngành học</label>
                                            <input type="text" class="form-control" name="edu_major_<%= i %>" value="<%= edu.getString("major") %>" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold">Nơi học</label>
                                            <input type="text" class="form-control" name="edu_place_<%= i %>" value="<%= edu.getString("education_place") %>" required>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                }
                                %>
                            </div>
                            <button type="button" class="btn btn-add education text-white" onclick="addField('eduSection', 'edu')">
                                <i class="bi bi-plus-lg me-2"></i>Thêm học vấn
                            </button>
                        </div>
                    </div>

                    <!-- Experience Section -->
                    <div class="section-card">
                        <div class="section-header experience">
                            <h3 class="mb-0">
                                <i class="bi bi-briefcase-fill me-2"></i>
                                Kinh nghiệm làm việc
                            </h3>
                        </div>
                        <div class="card-body p-4">
                            <div id="expSection">
                                <!-- Initial experience entries -->
                                <%
                                    for (int i = 0; i < experience.length(); i++) {
                                        JSONObject exp = experience.getJSONObject(i);
                                %>
                                <div class="input-group-custom">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="mb-0 text-muted">Kinh nghiệm #<%= i + 1 %></h5>
                                        <button type="button" class="btn btn-remove" onclick="removeField('expSection', 'exp')">
                                            <i class="bi bi-x-lg text-white"></i>
                                        </button>
                                    </div>
                                    <div class="row g-3">
                                        <div class="col-md-4">
                                            <label class="form-label fw-semibold">Vị trí</label>
                                            <input type="text" class="form-control" name="exp_pos_<%= i %>" value="<%= exp.getString("working_position") %>" required>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-semibold">Nơi làm việc</label>
                                            <input type="text" class="form-control" name="exp_place_<%= i %>" value="<%= exp.getString("working_place") %>" required>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-semibold">Thời gian</label>
                                            <input type="text" class="form-control" name="exp_duration_<%= i %>" value="<%= exp.getString("working_duration") %>" required>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <button type="button" class="btn btn-add experience text-white" onclick="addField('expSection', 'exp')">
                                <i class="bi bi-plus-lg me-2"></i>Thêm kinh nghiệm
                            </button>
                        </div>
                    </div>


                    <!-- Skills Section -->
                    <div class="section-card">
                        <div class="section-header skills">
                            <h3 class="mb-0">
                                <i class="bi bi-award-fill me-2"></i>
                                Kỹ năng
                            </h3>
                        </div>
                        <div class="card-body p-4">
                            <div id="skillSection">
                                <!-- Initial skills will be populated by JavaScript -->
                                <%
                                for (int i = 0; i < skills.length(); i++) {
                                    JSONObject skill = skills.getJSONObject(i);
                                %>
                                <div class="input-group-custom">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <label class="form-label fw-semibold">Kỹ năng #<%= i + 1 %></label>
                                            <input type="text" class="form-control" name="skill_<%= i %>" value="<%= skill.getString("skill_name") %>" required>
                                        </div>
                                        <div class="col-auto">
                                            <button type="button" class="btn btn-remove" onclick="removeField('skillSection', 'skill')">
                                                <i class="bi bi-x-lg text-white"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <%
                                }
                                %>
                            </div>
                            <button type="button" class="btn btn-add skills text-white" onclick="addField('skillSection', 'skill')">
                                <i class="bi bi-plus-lg me-2"></i>Thêm kỹ năng
                            </button>
                        </div>
                    </div>

                    <input type="text" class="form-control" name="fileUrl" value="${fileUrl}" hidden>
                    <!-- Submit Button -->
                    <div class="text-center py-4">
                        <button type="submit" class="btn submit-btn">
                            <i class="bi bi-floppy-fill me-2"></i>
                            Lưu thông tin
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                // Initialize indices with current values
                                let skillIndex = <%= initialSkillIndex %>;
                                let eduIndex = <%= initialEduIndex %>;
                                let expIndex = <%= initialExpIndex %>;

                                function addField(sectionId, prefix) {
                                    const container = document.getElementById(sectionId);
                                    let index;
                                    let fieldName;

                                    if (prefix === 'skill') {
                                        index = skillIndex++;
                                        fieldName = 'skill_' + index;
                                        const div = document.createElement("div");
                                        div.className = "input-group-custom";
                                        div.innerHTML = "<div class='row align-items-center'>" +
                                                "<div class='col'>" +
                                                "<label class='form-label fw-semibold'>Kỹ năng #" + (index + 1) + "</label>" +
                                                "<input type='text' class='form-control' name='skill_" + index + "' required />" +
                                                "</div>" +
                                                "<div class='col-auto'>" +
                                                "<button type='button' class='btn btn-remove' onclick='removeField(\"" + sectionId + "\", \"" + prefix + "\")'>" +
                                                "<i class='bi bi-x-lg text-white'></i>" +
                                                "</button>" +
                                                "</div>" +
                                                "</div>";
                                        container.appendChild(div);
                                    } else if (prefix === 'edu') {
                                        index = eduIndex++;
                                        fieldName = 'edu_major_' + index;
                                        const div = document.createElement("div");
                                        div.className = "input-group-custom";
                                        div.innerHTML = "<div class='d-flex justify-content-between align-items-center mb-3'>" +
                                                "<h5 class='mb-0 text-muted'>Học vấn #" + (index + 1) + "</h5>" +
                                                "<button type='button' class='btn btn-remove' onclick='removeField(\"" + sectionId + "\", \"" + prefix + "\")'>" +
                                                "<i class='bi bi-x-lg text-white'></i>" +
                                                "</button>" +
                                                "</div>" +
                                                "<div class='row g-3'>" +
                                                "<div class='col-md-6'>" +
                                                "<label class='form-label fw-semibold'>Ngành học</label>" +
                                                "<input type='text' class='form-control' name='edu_major_" + index + "' required />" +
                                                "</div>" +
                                                "<div class='col-md-6'>" +
                                                "<label class='form-label fw-semibold'>Nơi học</label>" +
                                                "<input type='text' class='form-control' name='edu_place_" + index + "' required />" +
                                                "</div>" +
                                                "</div>";
                                        container.appendChild(div);
                                    } else if (prefix === 'exp') {
                                        index = expIndex++;
                                        fieldName = 'exp_pos_' + index;
                                        const div = document.createElement("div");
                                        div.className = "input-group-custom";
                                        div.innerHTML = "<div class='d-flex justify-content-between align-items-center mb-3'>" +
                                                "<h5 class='mb-0 text-muted'>Kinh nghiệm #" + (index + 1) + "</h5>" +
                                                "<button type='button' class='btn btn-remove' onclick='removeField(\"" + sectionId + "\", \"" + prefix + "\")'>" +
                                                "<i class='bi bi-x-lg text-white'></i>" +
                                                "</button>" +
                                                "</div>" +
                                                "<div class='row g-3'>" +
                                                "<div class='col-md-4'>" +
                                                "<label class='form-label fw-semibold'>Vị trí</label>" +
                                                "<input type='text' class='form-control' name='exp_pos_" + index + "' required />" +
                                                "</div>" +
                                                "<div class='col-md-4'>" +
                                                "<label class='form-label fw-semibold'>Nơi làm việc</label>" +
                                                "<input type='text' class='form-control' name='exp_place_" + index + "' required />" +
                                                "</div>" +
                                                "<div class='col-md-4'>" +
                                                "<label class='form-label fw-semibold'>Thời gian</label>" +
                                                "<input type='text' class='form-control' name='exp_duration_" + index + "' required />" +
                                                "</div>" +
                                                "</div>";
                                        container.appendChild(div);
                                    }
                                    updateIndicesDisplay();
                                    const lastInput = container.lastChild.querySelector('input');
                                    if (lastInput) {
                                        document.getElementById('lastNameDisplay').innerText = lastInput.name;
                                    }
                                }

                                function removeField(sectionId, prefix) {
                                    const container = document.getElementById(sectionId);
                                    const removedElement = event.target.closest('.input-group-custom');
                                    if (removedElement) {
                                        removedElement.remove();
                                        updateIndicesAfterRemoval(sectionId, prefix);
                                    }
                                }

                                function updateIndicesAfterRemoval(sectionId, prefix) {
                                    const container = document.getElementById(sectionId);
                                    const items = container.getElementsByClassName('input-group-custom');
                                    let newIndex = 0;

                                    for (let item of items) {
                                        const inputs = item.getElementsByTagName('input');
                                        for (let input of inputs) {
                                            const nameMatch = input.name.match(/(\w+)_(\d+)/);
                                            if (nameMatch) {
                                                const baseName = nameMatch[1];
                                                input.name = baseName + '_' + newIndex;
                                            }
                                        }

                                        // Update labels based on the new index
                                        if (prefix === 'skill') {
                                            const label = item.querySelector('label');
                                            if (label)
                                                label.textContent = 'Kỹ năng #' + (newIndex + 1);
                                        } else if (prefix === 'edu') {
                                            const heading = item.querySelector('h5');
                                            if (heading)
                                                heading.textContent = 'Học vấn #' + (newIndex + 1);
                                        } else if (prefix === 'exp') {
                                            const heading = item.querySelector('h5');
                                            if (heading)
                                                heading.textContent = 'Kinh nghiệm #' + (newIndex + 1);
                                        }
                                        newIndex++;
                                    }

                                    // Update the corresponding index to the next available number
                                    if (prefix === 'skill') {
                                        skillIndex = newIndex;
                                    } else if (prefix === 'edu') {
                                        eduIndex = newIndex;
                                    } else if (prefix === 'exp') {
                                        expIndex = newIndex;
                                    }
                                    updateIndicesDisplay();
                                    const lastInput = container.lastChild ? container.lastChild.querySelector('input') : null;
                                    document.getElementById('lastNameDisplay').innerText = lastInput ? lastInput.name : '';
                                }



                                document.querySelector("form").addEventListener("submit", function (e) {
                                    const birthInput = document.getElementById("birthdate");
                                    const value = birthInput.value.trim();

                                    // Regex kiểm tra định dạng dd/mm/yyyy
                                    const regex = /^(0?[1-9]|[12][0-9]|3[01])[/](0?[1-9]|1[0-2])[/](19|20)\d{2}$/;

                                    // Hàm kiểm tra ngày hợp lệ thực sự
                                    function isValidDate(dateStr) {
                                        if (!regex.test(dateStr))
                                            return false;

                                        const [day, month, year] = dateStr.split('/').map(Number);
                                        const date = new Date(year, month - 1, day);
                                        return (
                                                date.getFullYear() === year &&
                                                date.getMonth() === month - 1 &&
                                                date.getDate() === day
                                                );
                                    }

                                    if (!isValidDate(value)) {
                                        alert("Vui lòng nhập ngày sinh hợp lệ (dd/mm/yyyy).");
                                        birthInput.focus();
                                        e.preventDefault(); // Ngăn form submit
                                    }
                                });

        </script>
    </body>
</html>
