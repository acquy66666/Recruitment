package com.recruitment.controller.userManage;

import com.recruitment.dao.AdminDAO;
import com.recruitment.model.Admin;
import com.recruitment.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "CreateAccountServlet", urlPatterns = {"/createAccount"})
public class CreateAccountServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        if (request.getSession().getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }
        request.getRequestDispatcher("createAccount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        if (request.getSession().getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            AdminDAO adminDAO = new AdminDAO();

            String role = request.getParameter("role");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Validate input
            if (username == null || username.trim().length() < 3 || username.length() > 50) {
                request.setAttribute("errorMessage", "Username must be 3–50 characters long.");
                request.getRequestDispatcher("createAccount.jsp").forward(request, response);
                return;
            }
            if (password == null || !PasswordUtil.isLengthValid(password)) {
                request.setAttribute("errorMessage", "Password must be at least 8 characters long.");
                request.getRequestDispatcher("createAccount.jsp").forward(request, response);
                return;
            }
            if (!PasswordUtil.isDifficultyValid(password)) {
                request.setAttribute("errorMessage", "Password must contain uppercase, lowercase letters and numbers.");
                request.getRequestDispatcher("createAccount.jsp").forward(request, response);
                return;
            }
            if (!"Admin".equals(role) && !"Moderator".equals(role)) {
                request.setAttribute("errorMessage", "Invalid role specified.");
                request.getRequestDispatcher("createAccount.jsp").forward(request, response);
                return;
            }

            // Check username uniqueness
            Admin existingAdmin = adminDAO.getAdminByUsername(username);
            if (existingAdmin != null) {
                request.setAttribute("errorMessage", "Username '" + username + "' is already taken.");
                request.getRequestDispatcher("createAccount.jsp").forward(request, response);
                return;
            }

            // Create Admin
            String hashedPass = PasswordUtil.hashPassword(password);
            Admin admin = new Admin();
            admin.setUsername(username);
            admin.setPasswordHash(hashedPass);
            admin.setRole(role); // Set role "Admin" or "Moderator"
            admin.setActive(true); // Default active
            adminDAO.insertAdmin(admin);
            request.setAttribute("successMessage", role + " account created successfully.");

            request.getRequestDispatcher("createAccount.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("createAccount.jsp").forward(request, response);
        }
    }
}