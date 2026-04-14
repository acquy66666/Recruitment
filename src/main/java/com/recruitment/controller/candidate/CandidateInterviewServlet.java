package com.recruitment.controller.candidate;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.InterviewDAO;
import com.recruitment.model.Candidate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CandidateInterviewServlet", urlPatterns = {"/CandidateInterview"})
public class CandidateInterviewServlet extends HttpServlet {

    private InterviewDAO interviewDAO = new InterviewDAO();
    private ApplicationDAO dao = new ApplicationDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            System.out.println("DEBUG: No candidate in session, redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get filter parameter - FIX: Đảm bảo biến filter được khai báo đúng
            String filter = request.getParameter("filter");
            if (filter == null) {
                filter = "all";
            }

            List<Map<String, Object>> interviews;

            // Get interviews based on filter
            if ("upcoming".equals(filter)) {
                System.out.println("DEBUG: Getting upcoming interviews...");
                interviews = interviewDAO.getUpcomingInterviewsByCandidate(candidate.getCandidateId());
            } else {
                System.out.println("DEBUG: Getting all interviews...");
                interviews = interviewDAO.getDetailedInterviewsByCandidate(candidate.getCandidateId());
            }

            // Get statistics
            int totalInterviews = interviewDAO.countInterviewsByCandidate(candidate.getCandidateId());
            List<Map<String, Object>> upcomingInterviews = interviewDAO.getUpcomingInterviewsByCandidate(candidate.getCandidateId());
            int upcomingCount = upcomingInterviews.size();
            int completedCount = totalInterviews - upcomingCount;

            // Set attributes for JSP
            request.setAttribute("interviews", interviews);
            request.setAttribute("totalInterviews", totalInterviews);
            request.setAttribute("upcomingCount", upcomingCount);
            request.setAttribute("completedCount", completedCount);
            request.setAttribute("currentFilter", filter);
            request.setAttribute("candidate", candidate);

//            code them vao the duc
            var listScheduleCandidate = dao.getInterviewsByCandidateId(candidate.getCandidateId());
            session.setAttribute("listScheduleCandidate", listScheduleCandidate);

            request.getRequestDispatcher("CandidateViewInterview.jsp").forward(request, response);

        } catch (SQLException e) {

            request.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu: " + e.getMessage() + " (SQL State: " + e.getSQLState() + ", Error Code: " + e.getErrorCode() + ")");
            request.setAttribute("candidate", candidate);
            request.setAttribute("totalInterviews", 0);
            request.setAttribute("upcomingCount", 0);
            request.setAttribute("completedCount", 0);
            request.setAttribute("currentFilter", request.getParameter("filter") != null ? request.getParameter("filter") : "all");
            request.getRequestDispatcher("CandidateViewInterview.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
