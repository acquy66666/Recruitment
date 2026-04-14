package com.recruitment.controller.userManage;

import com.recruitment.dao.RecruiterDAO;
import com.recruitment.model.Recruiter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;

@WebServlet(name = "VerifyOtpServlet", urlPatterns = {"/verifyOtp"})
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pendingRecruiter") == null) {
            request.setAttribute("errorMessage", "Phiên đã hết hạn. Vui lòng đăng ký lại.");
            request.setAttribute("redirectUrl", "registerRecruiter");
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
            return;
        }
        request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pendingRecruiter") == null) {
            request.setAttribute("errorMessage", "Phiên đã hết hạn. Vui lòng đăng ký lại.");
            request.setAttribute("redirectUrl", "registerRecruiter");
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
            return;
        }

        try {
            RecruiterDAO recruiterDAO = new RecruiterDAO();

            // Get session attributes
            Recruiter pendingRecruiter = (Recruiter) session.getAttribute("pendingRecruiter");
            String storedOtp = (String) session.getAttribute("otpCode");
            LocalDateTime otpExpiresAt = (LocalDateTime) session.getAttribute("otpExpiresAt");

            // Get submitted OTP
            String submittedOtp = request.getParameter("otp");

            // Check if OTP is expired or invalid
            LocalDateTime now = LocalDateTime.now();
            if (otpExpiresAt == null || storedOtp == null || now.isAfter(otpExpiresAt)) {
                session.invalidate();
                request.setAttribute("errorMessage", "Mã OTP đã hết hạn. Vui lòng đăng ký lại.");
                request.setAttribute("redirectUrl", "registerRecruiter");
                request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
                return;
            }

            // Verify OTP
            if (!storedOtp.equals(submittedOtp)) {
                request.setAttribute("errorMessage", "Mã OTP không hợp lệ. Vui lòng thử lại!");
                request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
                return;
            }

            // OTP correct: insert recruiter into database
            int recruiterId = recruiterDAO.insertRecruiter(pendingRecruiter);
            if (recruiterId <= 0) {
                throw new SQLException("Không thể tạo tài khoản nhà tuyển dụng.");
            }

            // Set success message
            request.setAttribute("successMessage", "Đăng ký thành công! Bạn sẽ được chuyển đến trang đăng nhập.");
            request.setAttribute("redirectUrl", "login");

            // Clear session
            session.invalidate();

            // Forward to JSP to display success message
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);

        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu: " + ex.getMessage());
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Xác minh thất bại: " + ex.getMessage());
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
        }
    }
}