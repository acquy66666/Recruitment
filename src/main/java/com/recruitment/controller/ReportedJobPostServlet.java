package com.recruitment.controller;

import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.JobPost;
import com.recruitment.model.Admin;
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

@WebServlet(name = "ReportedJobPostServlet", urlPatterns = {"/ReportedJobPosts"})
public class ReportedJobPostServlet extends HttpServlet {
    
    private final JobPostingPageDAO jobPostingDAO = new JobPostingPageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("Admin");
        
        if (admin == null) {
            session.setAttribute("error", "Chỉ admin mới có thể xem bài đăng bị báo cáo.");
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get search keyword
        String keyword = request.getParameter("keyword");
        
        // Fetch reported job posts
        List<JobPost> reportedPosts = jobPostingDAO.filterJobPostAdvancedAdmin(
                keyword, null, Arrays.asList("Reported"), null, null, null, "date_desc", null
        );
        
        // Pagination
        int numAll = reportedPosts.size();
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
        
        List<JobPost> paginatedReports = jobPostingDAO.getListJobPostByPage(reportedPosts, start, end);
        
        // Set attributes for JSP
        session.setAttribute("reportedPosts", paginatedReports);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);
        session.setAttribute("keyword", keyword);
        
        request.getRequestDispatcher("reportedJobPosts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("Admin");
        
        if (admin == null) {
            session.setAttribute("error", "Chỉ admin mới có thể thực hiện hành động này.");
            response.sendRedirect("ReportedJobPosts");
            return;
        }
        
        String action = request.getParameter("action");
        String jobId = request.getParameter("jobId");
        String keyword = request.getParameter("keyword");
        
        if (action == null || jobId == null) {
            session.setAttribute("error", "Tham số yêu cầu không hợp lệ.");
            response.sendRedirect("ReportedJobPosts?keyword=" + (keyword != null ? keyword : ""));
            return;
        }
        
        if ("delete".equals(action)) {
            // Delete job post
            jobPostingDAO.deleteJobPosts(jobId);
            session.setAttribute("message", "Xóa bài đăng thành công.");
        } else if ("markReviewed".equals(action)) {
            // Mark as reviewed by setting status back to Đã duyệt
            String sql = "UPDATE job_post SET status = 'Đã duyệt' WHERE job_id = ?";
            try (PreparedStatement ps = jobPostingDAO.c.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(jobId));
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    session.setAttribute("message", "Duyệt lại bài đăng thành công.");
                } else {
                    session.setAttribute("error", "Không thể duyệt lại bài đăng.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                session.setAttribute("error", "Lỗi khi duyệt lại bài đăng: " + e.getMessage());
            }
        }
        
        response.sendRedirect("ReportedJobPosts?keyword=" + (keyword != null ? keyword : ""));
    }

    @Override
    public String getServletInfo() {
        return "Servlet for admins to view and manage reported job posts";
    }
}