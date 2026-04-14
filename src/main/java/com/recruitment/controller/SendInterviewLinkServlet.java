/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.model.ApplicationScheduleDTO;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Properties;
import jakarta.mail.internet.MimeUtility;
import java.io.UnsupportedEncodingException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "SendInterviewLinkServlet", urlPatterns = {"/SendInterviewLinkServlet"})
public class SendInterviewLinkServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SendInterviewLinkServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendInterviewLinkServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Thay bằng mail của bạn và app password
    private static final String SENDER_EMAIL = "taptap3115@gmail.com";
    private static final String SENDER_PASSWORD = "ognv levc llxd fwkm";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String applicationIdStr = request.getParameter("application_id");

        try {
            int applicationId = Integer.parseInt(applicationIdStr);

            // Lấy thông tin từ DB
            ApplicationDAO appDao = new ApplicationDAO();
            ApplicationScheduleDTO interview = appDao.getInterviewDetailByApplicationId(applicationId); // Bạn cần viết hàm này

            if (interview != null) {
                String to = interview.getCandidateEmail();
                String subject = "📅 Lịch phỏng vấn từ JobHub";
                String formattedDate = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(interview.getInterviewTime());
                String meetingLink = "https://8x8.vc/vpaas-magic-cookie-8fd3c3b144904eb8b121838389334cdc/interview-room"; // Hoặc lấy từ DB nếu có

                String content = String.format(
                        "<p>Xin chào <strong>%s</strong>,</p>"
                        + "<p>Bạn đã được mời tham gia phỏng vấn cho vị trí: <strong>%s</strong>.</p>"
                        + "<p>🕓 <strong>Thời gian:</strong> %s</p>"
                        + "<p>📝 <strong>Ghi chú:</strong> %s</p>"
                        + "<p>👉 <strong>Link phòng phỏng vấn:</strong> <a href='%s'>Tham gia phỏng vấn</a></p>"
                        + "<br><p>Trân trọng,<br/>Đội ngũ <b>JobHub</b></p>",
                        interview.getCandidateName(),
                        interview.getJobTitle(),
                        formattedDate,
                        interview.getInterviewDescription() != null ? interview.getInterviewDescription() : "Không có",
                        meetingLink
                );

                sendEmail(to, subject, content);

                request.setAttribute("message", "Email đã được gửi thành công!");
            } else {
                request.setAttribute("message", "Không tìm thấy thông tin ứng viên.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Có lỗi xảy ra khi gửi email.");
        }

        request.getRequestDispatcher("scheduledInterviews.jsp").forward(request, response);
    }

    private void sendEmail(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(SENDER_EMAIL));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            try {
                msg.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(SendInterviewLinkServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
