/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.RecruiterDAO;
import com.recruitment.model.Recruiter;
import com.recruitment.utils.PasswordUtil;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name = "EditPassword", urlPatterns = {"/EditPassword"})
public class EditPassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        if ((Recruiter) session.getAttribute("Recruiter") == null) {
            response.sendRedirect("login");
            return;
        }
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        RecruiterDAO dao = new RecruiterDAO();
        String recruiterID = Integer.toString(recruiter.getRecruiterId());

        // Lấy thông tin từ form
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String storedHash = dao.getPasswordHashByRecruiterId(recruiterID);
        String oldPasswordHash = PasswordUtil.hashPassword(oldPassword);// Giả sử có hàm này

        request.setAttribute("activeTab", "password");
        // Kiểm tra mật khẩu cũ đúng không
        if (!oldPasswordHash.equals(storedHash)) {
            request.setAttribute("oldPassword", oldPassword);
            request.setAttribute("newPassword", newPassword);
            request.setAttribute("confirmPassword", confirmPassword);
            request.setAttribute("errorPass", "Mật khẩu cũ không đúng.");
            request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xác nhận mật khẩu trùng nhau
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("oldPassword", oldPassword);
            request.setAttribute("newPassword", newPassword);
            request.setAttribute("confirmPassword", confirmPassword);
            request.setAttribute("errorPass", "Mật khẩu mới xác nhận không trùng khớp.");
            request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
            return;
        }
        // Hash mật khẩu mới để lưu
        // Validate mật khẩu mới
        String passwordError = validateNewPassword(newPassword);
        if (passwordError != null) {
            request.setAttribute("errorPass", passwordError);
            request.setAttribute("oldPassword", oldPassword);
            request.setAttribute("newPassword", newPassword);
            request.setAttribute("confirmPassword", confirmPassword);
            request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
            return;
        }
        String newPasswordHash = PasswordUtil.hashPassword(newPassword);
        if (newPasswordHash.equals(storedHash)) {
            request.setAttribute("oldPassword", oldPassword);
            request.setAttribute("newPassword", newPassword);
            request.setAttribute("confirmPassword", confirmPassword);
            request.setAttribute("errorPass", "Mật khẩu mới phải khác mật khẩu cũ.");
            request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
            return;
        }
        // Cập nhật mật khẩu vào DB
        dao.updatePasswordHashByRecruiterId(newPasswordHash, recruiterID);
        request.setAttribute("message", "Đổi mật khẩu thành công.");
        // Quay lại trang profile
        request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
    }

    public String validateNewPassword(String newPassword) {
        if (newPassword == null || newPassword.trim().isEmpty()) {
            return "Mật khẩu không được để trống hoặc chỉ chứa khoảng trắng.";
        }

        newPassword = newPassword.trim();

        if (newPassword.contains(" ")) {
            return "Mật khẩu không được chứa khoảng trắng.";
        }

        if (newPassword.length() < 8) {
            return "Mật khẩu phải có ít nhất 8 ký tự.";
        }
//        boolean hasDigit = false;
//        boolean hasUpper = false;
//        boolean hasLetter = false;
//        int countDigit = 0;
//        for (char c : newPassword.toCharArray()) {
//            if (Character.isDigit(c)) {
//                countDigit++;
//            }
//            if (Character.isUpperCase(c)) {
//                hasUpper = true;
//            }
//            if (Character.isLetter(c)) {
//                hasLetter = true;
//            }
//        }
//        
//        if(countDigit <3){
//            return "Phai co it nhat 3 so";
//        }
//        if (!hasLetter) {
//            return "Mật khẩu phải chứa ít nhất 1 chữ cái và 1 số.";
//        }
//        if (!hasUpper) {
//            return "Mật khẩu phải có ít nhất 1 chữ in hoa.";
//        }

        boolean hasDigit = false;
        boolean hasUpper = false;
        boolean hasLetter = false;
        boolean hasSpecial = false;

        for (char c : newPassword.toCharArray()) {
            if (Character.isDigit(c)) {
                hasDigit = true;
            }
            if (Character.isUpperCase(c)) {
                hasUpper = true;
            }
            if (Character.isLetter(c)) {
                hasLetter = true;
            }
            if (!Character.isLetterOrDigit(c)) {
                hasSpecial = true;
            }
        }

        if (!hasLetter || !hasDigit) {
            return "Mật khẩu phải chứa ít nhất 1 chữ cái và 1 số.";
        }

        if (!hasUpper) {
            return "Mật khẩu phải có ít nhất 1 chữ in hoa.";
        }
        if (!hasSpecial) {
            return "Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt (như @, #, $, %...).";
        }
        return null; // Mật khẩu hợp lệ
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
