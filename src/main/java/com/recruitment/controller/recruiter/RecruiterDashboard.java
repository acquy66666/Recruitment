/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.RecruiterDAO;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hoang
 */
@WebServlet(name = "RecruiterDashboard", urlPatterns = {"/RecruiterDashboard"})
public class RecruiterDashboard extends HttpServlet {

    private RecruiterDAO recruiterDAO;

    @Override
    public void init() throws ServletException {
        recruiterDAO = new RecruiterDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            int recruiterId = recruiter.getRecruiterId();

            // Get dashboard statistics
            Map<String, Object> dashboardStats = recruiterDAO.getDashboardStatistics(recruiterId);

            // Set statistics attributes
            request.setAttribute("totalActiveJobs", dashboardStats.get("totalActiveJobs"));
            request.setAttribute("totalApplications", dashboardStats.get("totalApplications"));
            request.setAttribute("totalInterviews", dashboardStats.get("totalInterviews"));
            request.setAttribute("currentCredits", dashboardStats.get("currentCredits"));
            request.setAttribute("totalNotifications", dashboardStats.get("totalNotifications"));

            // Get chart data
            List<Map<String, Object>> jobApplicationStats = recruiterDAO.getJobApplicationStats(recruiterId);
            List<Map<String, Object>> dailyApplicationStats = recruiterDAO.getDailyApplicationStats(recruiterId, 7);

            request.setAttribute("jobStats", jobApplicationStats);
            request.setAttribute("dailyStats", dailyApplicationStats);

            // Get recent data lists
            List<Map<String, Object>> recentJobs = recruiterDAO.getRecentJobs(recruiterId, 5);
            List<Map<String, Object>> newApplications = recruiterDAO.getNewApplications(recruiterId, 5);
            List<Map<String, Object>> upcomingInterviews = recruiterDAO.getUpcomingInterviews(recruiterId, 5);
            List<Map<String, Object>> transactions = recruiterDAO.getRecentTransactions(recruiterId, 10);
            List<Map<String, Object>> notifications = recruiterDAO.getRecentNotifications(recruiterId, 10);

            request.setAttribute("recentJobs", recentJobs);
            request.setAttribute("newApplications", newApplications);
            request.setAttribute("upcomingInterviews", upcomingInterviews);
            request.setAttribute("transactions", transactions);
            request.setAttribute("notifications", notifications);

            request.setAttribute("recruiter", recruiter);

            request.getRequestDispatcher("RecruiterDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải dashboard: " + e.getMessage());
            request.getRequestDispatcher("RecruiterDashboard.jsp").forward(request, response);
        }
    }
}
