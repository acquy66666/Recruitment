<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobHub - Create Accounts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #007bff;
            --dark-color: #343a40;
            --light-gray: #f8f9fa;
            --sidebar-width: 250px;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 40px;
        }

        .form-container {
            max-width: 600px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <%
        // Check if admin is logged in
        if (session.getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }

        // Get attributes for messages
        String errorMessage = (String) request.getAttribute("errorMessage");
        String successMessage = (String) request.getAttribute("successMessage");
    %>

    <!-- Include Left Navbar -->
    <%@include file="leftNavbar.jsp" %>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <h2>Create Account</h2>

            <!-- Display Messages -->
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger"><%= errorMessage %></div>
            <% } %>
            <% if (successMessage != null) { %>
                <div class="alert alert-success"><%= successMessage %></div>
            <% } %>

            <!-- Form -->
            <div class="form-container">
                <form action="createAccount" method="post" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="role" class="form-label">Role</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="" disabled selected>Select a role</option>
                            <option value="Admin">Admin</option>
                            <option value="Moderator">Moderator</option>
                        </select>
                        <div class="invalid-feedback">
                            Please select a role.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required minlength="3" maxlength="50">
                        <div class="invalid-feedback">
                            Username is required and must be 3–50 characters long.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required minlength="8">
                        <div class="invalid-feedback">
                            Password is required and must be at least 8 characters long.
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Create Account</button>
                        <a href="manageAccount" class="btn btn-secondary">Back to Manage Account</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Bootstrap form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>
</body>
</html>