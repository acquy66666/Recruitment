package com.recruitment.controller.userManage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "ResendOtpServlet", urlPatterns = {"/resendOtp"})
public class ResendOtpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("recruiterId") == null || session.getAttribute("email") == null) {
            request.setAttribute("errorMessage", "Phiên đã hết hạn. Vui lòng đăng ký lại.");
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
            return;
        }

        try {
            // Generate new OTP (example: 6-digit random number)
            String newOtp = String.format("%06d", (int)(Math.random() * 1000000));
            LocalDateTime otpExpiresAt = LocalDateTime.now().plusMinutes(2); // OTP valid for 2 minutes

            // Update session with new OTP and expiration
            session.setAttribute("otpCode", newOtp);
            session.setAttribute("otpExpiresAt", otpExpiresAt);

            // TODO: Send new OTP to email (replace with your email service logic)
            // Example: EmailService.sendOtpEmail((String) session.getAttribute("email"), newOtp);

            request.setAttribute("successMessage", "Mã OTP mới đã được gửi tới email của bạn.");
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);

        } catch (ServletException | IOException ex) {
            request.setAttribute("errorMessage", "Lỗi khi gửi OTP: " + ex.getMessage());
            request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
        }
    }
}