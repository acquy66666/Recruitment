/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.dao.CandidateDAO;
import com.recruitment.model.Candidate;
import com.recruitment.utils.NameUtil;
import com.recruitment.utils.PasswordUtil;
import com.recruitment.utils.PhoneUtil;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Properties;
import java.util.Random;

/**
 *
 * @author hoang
 */
@WebServlet(name = "registerCandidate", urlPatterns = {"/registerCandidate"})
public class registerCandidate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            CandidateDAO candidateDAO = new CandidateDAO();

            // Get form parameters
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm");
            // Preserve form data for error cases
            request.setAttribute("fullname", fullname);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);

            // Validate
            if (!NameUtil.validateName(fullname)) {
                request.setAttribute("errorMessage", "Tên không hợp lệ. Vui lòng nhập lại tên.");
                request.setAttribute("errorField", "fullname");
                request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
                return;
            }

            // Check email exists
            if (candidateDAO.getCandidateByEmail(email) != null) {
                request.setAttribute("errorMessage", "Email đã được đăng ký. Vui lòng sử dụng email khác.");
                request.setAttribute("errorField", "email");
                // Clear email field for user to enter new one
                request.setAttribute("email", "");
                request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
                return;
            }

            // Validate phone
            if (!PhoneUtil.validatePhoneNumber(phone)) {
                request.setAttribute("errorMessage", "Số điện thoại phải bắt đầu bằng 0 và có ít nhất 7 chữ số.");
                request.setAttribute("errorField", "phone");
                request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
                return;
            }

            // Check phone exists
            if (candidateDAO.getCandidateByPhone(phone) != null) {
                request.setAttribute("errorMessage", "Số điện thoại đã được sử dụng. Vui lòng sử dụng số khác.");
                request.setAttribute("errorField", "phone");
                // Clear phone field for user to enter new one
                request.setAttribute("phone", "");
                request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
                return;
            }

            // Validate password match
            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp. Vui lòng nhập lại.");
                request.setAttribute("errorField", "confirm");
                request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
                return;
            }

            // Validate password length
            if (!PasswordUtil.isLengthValid(password)) {
                request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 8 ký tự.");
                request.setAttribute("errorField", "password");
                request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
                return;
            }

            // Validate password complexity
            if (!PasswordUtil.isDifficultyValid(password)) {
                request.setAttribute("errorMessage", "Mật khẩu phải chứa chữ cái, số và ít nhất một chữ hoa.");
                request.setAttribute("errorField", "password");
                request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
                return;
            }

            String hashedPassword = PasswordUtil.hashPassword(password);

            Candidate candidate = new Candidate();
            candidate.setFullName(fullname);
            candidate.setEmail(email);
            candidate.setPasswordHash(hashedPassword);
            candidate.setPhone(phone);
            candidate.setCreatedAt(LocalDateTime.now());
            candidate.setIsActive(false);
            candidate.setImageUrl("default.jpg");
            candidate.setGender("Other");
            candidate.setBirthdate(LocalDate.now());
            candidate.setAddress("N/A");
            // Insert candidate
            int candidateId = candidateDAO.insertCandidate(candidate);
            if (candidateId <= 0) {
                throw new SQLException("Failed to obtain valid candidate ID after insertion");
            }
            String otpCode = generateOtp();
            LocalDateTime otpExpiresAt = LocalDateTime.now().plusMinutes(2);

            // Store OTP and related data in session
            HttpSession session = request.getSession();
            session.setAttribute("candidateId", candidateId);
            session.setAttribute("email", email);
            session.setAttribute("otpCode", otpCode);
            session.setAttribute("otpExpiresAt", otpExpiresAt);

            // Send OTP email
            sendOtpEmail(email, otpCode);

            // Redirect to OTP verification page
            response.sendRedirect("verifyOtpCandidate");
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
        } catch (MessagingException ex) {
            request.setAttribute("errorMessage", "Failed to send OTP email: " + ex.getMessage());
            request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
        } catch (ServletException | IOException ex) {
            request.setAttribute("errorMessage", "Registration failed: " + ex.getMessage());
            request.getRequestDispatcher("registercandidate.jsp").forward(request, response);
        }
    }

    private String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    private void sendOtpEmail(String toEmail, String otpCode) throws MessagingException {
        // Configure email properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Replace with your email and app-specific password
        final String username = "taptap3115@gmail.com";
        final String password = "ognv levc llxd fwkm";

        // Create session
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected jakarta.mail.PasswordAuthentication getPasswordAuthentication() {
                return new jakarta.mail.PasswordAuthentication(username, password);
            }
        });

        // Create message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("JobHub OTP Xác nhận Tài khoản");
        message.setText("Mã OTP để xác nhận tài khoản của bạn là: " + otpCode + "\n\nMã OTP này chỉ khả dụng trong 2 phút.");

        // Send message
        Transport.send(message);
    }
}
