/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.utils.JitsiTokenUtil;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet(name = "createMeeting", urlPatterns = {"/createMeeting"})
public class createMeeting extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet createMeeting</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet createMeeting at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    private ApplicationDAO dao = new ApplicationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        try {
            HttpSession session = request.getSession();
            String applicationId = request.getParameter("applicationId");
            String candidateName = request.getParameter("candidateName");
//            String recruiterName = request.getParameter("recruiterName");

            String roomName = "interview-room";

            // Tạo token cho nhà tuyển dụng (moderator)
            String recruiterToken = JitsiTokenUtil.generateToken(roomName, "Nhà tuyển dụng", true);
//            String recruiterLink = "https://8x8.vc/vpaas-magic-cookie-8fd3c3b144904eb8b121838389334cdc/"
//                    + roomName + "?jwt=" + recruiterToken;

            // Tạo token cho ứng viên (không phải moderator)
//            String candidateToken = JitsiTokenUtil.generateToken(roomName, candidateName, false);
//            String candidateLink = "https://8x8.vc/vpaas-magic-cookie-8fd3c3b144904eb8b121838389334cdc/"
//                    + roomName + "?jwt=" + candidateToken;

//            dao.updateMeetingTokens(applicationId, candidateToken, recruiterToken);
//            request.setAttribute("candidateName", candidateName);
            request.setAttribute("recruiterToken", recruiterToken);
//            request.setAttribute("candidateToken", candidateToken);

            request.getRequestDispatcher("MeetingZoom.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("❌ Lỗi tạo token: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
