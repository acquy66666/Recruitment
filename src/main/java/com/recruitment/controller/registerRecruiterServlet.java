package com.recruitment.controller;

import com.recruitment.dao.CandidateDAO;
import com.recruitment.dao.RecruiterDAO;
import com.recruitment.model.Candidate;
import com.recruitment.model.Recruiter;
import com.recruitment.utils.NameUtil;
import com.recruitment.utils.PasswordUtil;
import com.recruitment.utils.PhoneUtil;
import com.recruitment.utils.taxCodeUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet(name = "registerRecruiterServlet", urlPatterns = {"/registerRecruiter"})
public class registerRecruiterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RecruiterDAO recruiterDAO = new RecruiterDAO();
        CandidateDAO candidateDAO = new CandidateDAO();

        try {
            // Get form parameters
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm");
            String position = request.getParameter("position");
            String phone = request.getParameter("phone");
            String companyName = request.getParameter("companyName");
            String taxCode = request.getParameter("taxCode");

            // Store form data in request attributes for repopulation
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("position", position);
            request.setAttribute("phone", phone);
            request.setAttribute("companyName", companyName);
            request.setAttribute("taxCode", taxCode);

            System.out.println("DEBUG: Checking email for Recruiter registration: " + email);

            // Validate name
            if (!NameUtil.validateName(fullName)) {
                request.setAttribute("errorMessage", "Định dạng họ và tên không hợp lệ.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }

            // KIỂM TRA EMAIL ĐÃ ĐƯỢC SỬ DỤNG BỞI CANDIDATE CHƯA (BẤT KỂ GOOGLE HAY THƯỜNG)
            try {
                Candidate existingCandidate = candidateDAO.getCandidateByEmail(email);
                System.out.println("DEBUG: Found existing candidate: " + (existingCandidate != null));

                if (existingCandidate != null) {
                    System.out.println("DEBUG: Candidate password hash: " + existingCandidate.getPasswordHash());
                    System.out.println("DEBUG: Is Google account: " + isGoogleAccount(existingCandidate));

                    if (isGoogleAccount(existingCandidate)) {
                        System.out.println("DEBUG: Blocking registration - Email used by Google Candidate");
                        request.setAttribute("errorMessage", "Email này đã được sử dụng");
                        request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                        return;
                    } else {
                        System.out.println("DEBUG: Blocking registration - Email used by regular Candidate");
                        request.setAttribute("errorMessage", "Email này đã được sử dụng");
                        request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                        return;
                    }
                }
            } catch (SQLException e) {
                System.err.println("ERROR: Cannot check candidate email: " + e.getMessage());
                request.setAttribute("errorMessage", "Lỗi hệ thống khi kiểm tra email. Vui lòng thử lại.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }

            // Check if email is already registered as Recruiter
            try {
                if (recruiterDAO.getRecruiterByEmailOrPhone(email) != null) {
                    System.out.println("DEBUG: Email already used by another Recruiter");
                    request.setAttribute("errorMessage", "Email đã được đăng ký. Vui lòng sử dụng email khác.");
                    request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                System.err.println("ERROR: Cannot check recruiter email: " + e.getMessage());
                request.setAttribute("errorMessage", "Lỗi hệ thống khi kiểm tra email. Vui lòng thử lại.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }
            if (recruiterDAO.getRecruiterByEmailOrPhone(phone) != null) {
                request.setAttribute("errorMessage", "Số điện thoại này đã được sử dụng. Vui lòng sử dụng số khác.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }

            // Check password confirmation
            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu không khớp.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }

            // Validate password length
            if (!PasswordUtil.isLengthValid(password)) {
                request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 8 ký tự.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }

            // Validate password strength
            if (!PasswordUtil.isDifficultyValid(password)) {
                request.setAttribute("errorMessage", "Mật khẩu phải chứa chữ cái, số và chữ in hoa.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }

            // Validate phone number
            if (!PhoneUtil.validatePhoneNumber(phone)) {
                request.setAttribute("errorMessage", "Số điện thoại phải bắt đầu bằng 0 và có ít nhất 7 chữ số.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }

            // validate taxcode length and format
            if (!taxCodeUtil.validLengTaxCode(taxCode) && !taxCodeUtil.validateTaxCode(taxCode)) {
                request.setAttribute("errorMessage", "Mã số thuế phải là dãy các số có độ dài từ 8 đến 20.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }

            if (recruiterDAO.getRecruiterByEmailOrPhone(taxCode) != null) {
                request.setAttribute("errorMessage", "Mã số thuế này đã được đăng ký.");
                request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                return;
            }

            // Check if phone number is already registered by Recruiter
            try {
                if (recruiterDAO.getRecruiterByPhone(phone) != null) {
                    request.setAttribute("errorMessage", "Số điện thoại này đã được sử dụng. Vui lòng sử dụng số khác.");
                    request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException e) {
                System.err.println("ERROR: Cannot check recruiter phone: " + e.getMessage());
            }

            System.out.println("Đăng kí thành công");

            // Create Recruiter object
            Recruiter recruiter = new Recruiter();
            recruiter.setFullName(fullName);
            recruiter.setEmail(email);
            recruiter.setPasswordHash(PasswordUtil.hashPassword(password));
            recruiter.setPosition(position);
            recruiter.setPhone(phone);
            recruiter.setCreatedAt(LocalDateTime.now());
            recruiter.setIsActive(true);
            recruiter.setImageUrl("default.jpg");
            recruiter.setCompanyName(companyName);
            recruiter.setCompanyAddress("No address updated");

            // Generate OTP
            String otpCode = generateOtp();
            LocalDateTime otpExpiresAt = LocalDateTime.now().plusMinutes(2);

            // Store Recruiter and OTP in session
            HttpSession session = request.getSession();
            session.setAttribute("pendingRecruiter", recruiter);
            session.setAttribute("email", email);
            session.setAttribute("otpCode", otpCode);
            session.setAttribute("otpExpiresAt", otpExpiresAt);

            // Send OTP email
            sendOtpEmail(email, otpCode);

            System.out.println("DEBUG: OTP sent successfully");
            response.sendRedirect("verifyOtp");

        } catch (SQLException ex) {
            System.err.println("SQL ERROR: " + ex.getMessage());
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu: " + ex.getMessage());
            request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
        } catch (MessagingException ex) {
            System.err.println("EMAIL ERROR: " + ex.getMessage());
            request.setAttribute("errorMessage", "Không thể gửi email OTP: " + ex.getMessage());
            request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
        } catch (ServletException | IOException ex) {
            System.err.println("GENERAL ERROR: " + ex.getMessage());
            request.setAttribute("errorMessage", "Đăng ký thất bại: " + ex.getMessage());
            request.getRequestDispatcher("registerRecruiter.jsp").forward(request, response);
        }
    }

    /**
     * Kiểm tra xem Candidate có phải là tài khoản Google không
     */
    private boolean isGoogleAccount(Candidate candidate) {
        if (candidate == null || candidate.getPasswordHash() == null) {
            return false;
        }
        boolean isGoogle = candidate.getPasswordHash().startsWith("GOOGLE_LOGIN_");
        System.out.println("DEBUG: Password hash starts with GOOGLE_LOGIN_: " + isGoogle);
        return isGoogle;
    }

    private String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    private void sendOtpEmail(String toEmail, String otpCode) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        final String username = "taptap3115@gmail.com";
        final String password = "ognv levc llxd fwkm";

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected jakarta.mail.PasswordAuthentication getPasswordAuthentication() {
                return new jakarta.mail.PasswordAuthentication(username, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

            // Set subject with UTF-8 encoding
            message.setSubject("MyJob OTP Xác nhận Tài khoản", "UTF-8");

            // HTML content with proper meta charset
            String htmlContent = "<!DOCTYPE html>"
                    + "<html>"
                    + "<head><meta charset='UTF-8'></head>"
                    + "<body>"
                    + "<p>Mã OTP để xác nhận tài khoản của bạn là: <strong>" + otpCode + "</strong></p>"
                    + "<p>Mã OTP này chỉ khả dụng trong 2 phút.</p>"
                    + "</body>"
                    + "</html>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);

        } catch (MessagingException e) {
            throw e;
        }
    }
}
