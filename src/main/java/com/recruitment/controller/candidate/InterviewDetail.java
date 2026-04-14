/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.dao.InterviewDAO;
import com.recruitment.model.Candidate;
import com.recruitment.model.Interview;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author hoang
 */
@WebServlet(name = "InterviewDetail", urlPatterns = {"/InterviewDetail"})
public class InterviewDetail extends HttpServlet {

    private InterviewDAO interviewDAO = new InterviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            System.out.println("No candidate in session - redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }

        String interviewIdStr = request.getParameter("id");
        if (interviewIdStr == null || interviewIdStr.trim().isEmpty()) {

            request.setAttribute("error", "Mã phỏng vấn là bắt buộc.");
            request.getRequestDispatcher("InterviewDetail.jsp").forward(request, response);
            return;
        }

        try {
            int interviewId = Integer.parseInt(interviewIdStr);
            System.out.println("Getting interview detail for ID: " + interviewId + ", Candidate: " + candidate.getCandidateId());

            Map<String, Object> interviewDetail = interviewDAO.getInterviewDetailForCandidate(interviewId, candidate.getCandidateId());

            if (interviewDetail == null || !((Integer) interviewDetail.get("candidateId")).equals(candidate.getCandidateId())) {

                request.setAttribute("error", "Không tìm thấy phỏng vấn hoặc bạn không có quyền xem.");
                request.getRequestDispatcher("InterviewDetail.jsp").forward(request, response);
                return;
            }

            System.out.println("Interview detail found: " + interviewDetail.get("jobTitle") + " (ID: " + interviewDetail.get("interviewId") + ")");

            request.setAttribute("interview", interviewDetail);
            request.setAttribute("candidate", candidate);

            request.getRequestDispatcher("InterviewDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Mã phỏng vấn không hợp lệ.");
            request.getRequestDispatcher("InterviewDetail.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Lỗi cơ sở dữ liệu xảy ra: " + e.getMessage() + " (SQL State: " + e.getSQLState() + ", Error Code: " + e.getErrorCode() + ")");
            request.getRequestDispatcher("InterviewDetail.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi không mong muốn: " + e.getMessage());
            request.getRequestDispatcher("InterviewDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
