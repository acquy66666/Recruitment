package com.recruitment.controller;

import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.JobPost;
import com.recruitment.model.Admin;
import com.recruitment.model.Candidate;
import com.recruitment.model.Recruiter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "ReportPostServlet", urlPatterns = {"/ReportPosts"})
public class ReportPostServlet extends HttpServlet {
    
    private final JobPostingPageDAO jobPostingDAO = new JobPostingPageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check user type
        Admin moderator = (Admin) session.getAttribute("Moderator");
        Candidate candidate = (Candidate) session.getAttribute("Candidate");
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        boolean isAuthenticated = moderator != null || candidate != null || recruiter != null;
        
        if (!isAuthenticated) {
            session.setAttribute("error", "Vui lòng đăng nhập để xem bài đăng.");
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get search keyword
        String keyword = request.getParameter("keyword");
        
        // Fetch active job posts
        List<JobPost> allJobPosts = jobPostingDAO.filterJobPostAdvancedAdmin(
                keyword, null, Arrays.asList("Đã duyệt"), null, null, null, "date_desc", null
        );
        
        // Pagination
        int numAll = allJobPosts.size();
        int numPerPage = 10;
        int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
        int page;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            page = 1;
        }
        int start = (page - 1) * numPerPage;
        int end = Math.min(start + numPerPage, numAll);
        
        List<JobPost> paginatedJobPosts = jobPostingDAO.getListJobPostByPage(allJobPosts, start, end);
        
        // Set attributes for JSP
        session.setAttribute("jobPosts", paginatedJobPosts);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);
        session.setAttribute("keyword", keyword);
        session.setAttribute("isModerator", moderator != null);
        
        request.getRequestDispatcher("reportPosts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin moderator = (Admin) session.getAttribute("Moderator");
        
        if (moderator == null) {
            session.setAttribute("error", "Chỉ moderator mới có thể báo cáo bài đăng.");
            response.sendRedirect("ReportPosts");
            return;
        }
        
        String jobId = request.getParameter("jobId");
        String reason = request.getParameter("reason");
        String keyword = request.getParameter("keyword");
        
        if (jobId == null || reason == null || reason.trim().isEmpty()) {
            session.setAttribute("error", "Yêu cầu ID bài đăng và lý do báo cáo.");
            response.sendRedirect("ReportPosts?keyword=" + (keyword != null ? keyword : ""));
            return;
        }
        
        // Verify job post exists and is Đã duyệt
        JobPost jobPost = jobPostingDAO.searchJobPostbyJobID(Integer.parseInt(jobId));
        if (jobPost == null || !"Đã duyệt".equals(jobPost.getStatus())) {
            session.setAttribute("error", "Bài đăng không hợp lệ hoặc không được duyệt.");
            response.sendRedirect("ReportPosts?keyword=" + (keyword != null ? keyword : ""));
            return;
        }
        
        // Update job post status to Reported
        String sql = "UPDATE job_post SET status = 'Reported' WHERE job_id = ?";
        try (PreparedStatement ps = jobPostingDAO.c.prepareStatement(sql)) {
            ps.setInt(1, Integer.parseInt(jobId));
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                session.setAttribute("message", "Báo cáo bài đăng thành công.");
            } else {
                session.setAttribute("error", "Không thể báo cáo bài đăng.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi khi báo cáo bài đăng: " + e.getMessage());
        }
        
        response.sendRedirect("ReportPosts?keyword=" + (keyword != null ? keyword : ""));
    }

    @Override
    public String getServletInfo() {
        return "Servlet for viewing accepted job posts and reporting by moderators";
    }
}