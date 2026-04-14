/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.AdminStatisticsDAO;
import com.recruitment.model.TopStatDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name = "JobPostStatistics", urlPatterns = {"/JobPostStatistics"})
public class JobPostStatistics extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet JobPostStatistics</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet JobPostStatistics at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    private AdminStatisticsDAO dao = new AdminStatisticsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        int totalJobPosts = dao.getTotalJobPostsAll();
        int totalApproveJobs = dao.getApproveJobs();
        int totalPendingJobs = dao.getPendingJobs();
        int totalRejectedJobs = dao.getRejectedJobs();
        int totalExpiredJobs = dao.getExpiredJobs();
        int totalApplications = dao.getTotalApplications();
        int totalJobPost = dao.getTotalJobPosts();

        List<TopStatDTO> top5JobPosts = dao.getTop5JobPostsByApplications();
        double approvalRate =  (double) totalApproveJobs / (totalApproveJobs + totalPendingJobs + totalRejectedJobs);
        double avgAppPerPost = (double) totalApplications / totalJobPosts;
        double avgJobPerDay = dao.getAvgJobPostsPerDay();
        String hottestIndustry = dao.getHottestIndustryName();

//        List<TopStatDTO> getTop5CandidatesByApplications = dao.getTop5CandidatesByApplications();
//        List<TopStatDTO> getTop5RecruitersByJobPosts = dao.getTop5RecruitersByJobPosts();
        String fromDate = request.getParameter("fromDateJobPost");
        String toDate = request.getParameter("toDateJobPost");
        String jobIndustryOrder = request.getParameter("jobIndustryOrder");
        String applicationByIndustryOrder = request.getParameter("applicationByIndustryOrder");
        String jobPostMonthOrder = request.getParameter("jobPostMonthOrder");

        if (!isValidDateRange(fromDate, toDate)) {
            session.setAttribute("errorJobPostStatistic", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("fromDateJobPost", fromDate);
            session.setAttribute("toDateJobPost", toDate);
            response.sendRedirect("JobPostStatistics.jsp");
            return;
        }

        // Gọi các DAO để lấy dữ liệu đã lọc
        Map<String, Integer> jobPostCountGrowth = dao.getJobPostCountByIndustry(fromDate, toDate, jobIndustryOrder);
        Map<String, Integer> applicationCountByIndustry = dao.getApplicationCountByIndustry(fromDate, toDate, applicationByIndustryOrder);
        Map<String, Integer> jobPostStatusDistribution = dao.getJobPostStatusDistribution(fromDate, toDate);
        Map<String, Integer> jobPostCountByMonth = dao.getJobPostCountByMonth(fromDate, toDate, jobPostMonthOrder);

        // Lưu dữ liệu vào session
        session.setAttribute("jobPostCountGrowth", jobPostCountGrowth);
        session.setAttribute("applicationCountByIndustry", applicationCountByIndustry);
        session.setAttribute("jobPostStatusDistribution", jobPostStatusDistribution);
        session.setAttribute("jobPostCountByMonth", jobPostCountByMonth);

        session.setAttribute("totalJobPosts", totalJobPosts);
        session.setAttribute("totalApproveJobs", totalApproveJobs);
        session.setAttribute("totalPendingJobs", totalPendingJobs);
        session.setAttribute("totalRejectedJobs", totalRejectedJobs);
        session.setAttribute("totalExpiredJobs", totalExpiredJobs);
        session.setAttribute("totalApplications", totalApplications);

        session.setAttribute("top5JobPosts", top5JobPosts);
        session.setAttribute("approvalRate", approvalRate);
        session.setAttribute("avgAppPerPost", avgAppPerPost);
        session.setAttribute("avgJobPerDay", avgJobPerDay);
        session.setAttribute("hottestIndustry", hottestIndustry);

//        session.setAttribute("getTop5CandidatesByApplications", getTop5CandidatesByApplications);
//        session.setAttribute("getTop5RecruitersByJobPosts", getTop5RecruitersByJobPosts);
        session.removeAttribute("fromDateJobPost");
        session.removeAttribute("toDateJobPost");
        session.removeAttribute("jobIndustryOrder");
        session.removeAttribute("applicationByIndustryOrder");
        session.removeAttribute("jobPostMonthOrder");
        session.removeAttribute("currentTab");

        response.sendRedirect("JobPostStatistics.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String fromDate = request.getParameter("fromDateJobPost");
        String toDate = request.getParameter("toDateJobPost");
        String jobIndustryOrder = request.getParameter("jobIndustryOrder");
        String applicationByIndustryOrder = request.getParameter("applicationByIndustryOrder");
        String jobPostMonthOrder = request.getParameter("jobPostMonthOrder");

        if (!isValidDateRange(fromDate, toDate)) {
            session.setAttribute("errorJobPostStatistic", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("fromDateJobPost", fromDate);
            session.setAttribute("toDateJobPost", toDate);
            session.setAttribute("jobIndustryOrder", jobIndustryOrder);
            session.setAttribute("applicationByIndustryOrder", applicationByIndustryOrder);
            session.setAttribute("jobPostMonthOrder", jobPostMonthOrder);
            response.sendRedirect("JobPostStatistics.jsp");
            return;
        }
// Gọi các DAO để lấy dữ liệu đã lọc
        // Gọi các DAO để lấy dữ liệu đã lọc
        Map<String, Integer> jobPostCountGrowth = dao.getJobPostCountByIndustry(fromDate, toDate, jobIndustryOrder);
        Map<String, Integer> applicationCountByIndustry = dao.getApplicationCountByIndustry(fromDate, toDate, applicationByIndustryOrder);
        Map<String, Integer> jobPostStatusDistribution = dao.getJobPostStatusDistribution(fromDate, toDate);
        Map<String, Integer> jobPostCountByMonth = dao.getJobPostCountByMonth(fromDate, toDate, jobPostMonthOrder);

// Đưa vào session để hiển thị lại
        session.setAttribute("jobPostCountGrowth", jobPostCountGrowth);
        session.setAttribute("applicationCountByIndustry", applicationCountByIndustry);
        session.setAttribute("jobPostStatusDistribution", jobPostStatusDistribution);
        session.setAttribute("jobPostCountByMonth", jobPostCountByMonth);

        session.setAttribute("fromDateJobPost", fromDate);
        session.setAttribute("toDateJobPost", toDate);
        session.setAttribute("jobIndustryOrder", jobIndustryOrder);
        session.setAttribute("applicationByIndustryOrder", applicationByIndustryOrder);
        session.setAttribute("jobPostMonthOrder", jobPostMonthOrder);

        response.sendRedirect("JobPostStatistics.jsp");
    }

    private boolean isValidDateRange(String fromDateStr, String toDateStr) {
        if (fromDateStr == null || toDateStr == null
                || fromDateStr.isEmpty() || toDateStr.isEmpty()) {
            return true; // Nếu thiếu 1 trong 2 ngày thì không kiểm tra (hợp lệ)
        }

        try {
            LocalDate fromDate = LocalDate.parse(fromDateStr);
            LocalDate toDate = LocalDate.parse(toDateStr);
            return !toDate.isBefore(fromDate); // trả về true nếu toDate >= fromDate
        } catch (DateTimeParseException e) {
            return false; // định dạng ngày không hợp lệ
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
