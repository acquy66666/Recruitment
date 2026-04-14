package com.recruitment.controller.recruiter;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dto.JobPostWithApplicationsDTO;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "ApplicationManagement", urlPatterns = {"/ApplicationManagement"})
public class ApplicationManagement extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 5;

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
            ApplicationDAO applicationDAO = new ApplicationDAO();

            // Get filter parameters
            String jobTitle = request.getParameter("jobTitle");
            String status = request.getParameter("status");
            String minApplicationsStr = request.getParameter("minApplications");
            Integer minApplications = null;

            if (minApplicationsStr != null && !minApplicationsStr.trim().isEmpty()) {
                try {
                    minApplications = Integer.parseInt(minApplicationsStr);
                } catch (NumberFormatException e) {
                    // Invalid number format, ignore
                }
            }

            // Get pagination parameters
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            int offset = (currentPage - 1) * RECORDS_PER_PAGE;

            // Get job posts with applications
            List<JobPostWithApplicationsDTO> jobPosts = applicationDAO.getJobPostsWithApplications(
                    recruiter.getRecruiterId(), jobTitle, status, minApplications, offset, RECORDS_PER_PAGE);

            // Get total count for pagination
            int totalRecords = applicationDAO.countJobPostsWithApplications(
                    recruiter.getRecruiterId(), jobTitle, status, minApplications);
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

            // Get individual statistics instead of using DTO
            int totalJobs = applicationDAO.getTotalJobsByRecruiterId(recruiter.getRecruiterId());
          
            int totalApplications = applicationDAO.getTotalApplicationsByRecruiterId(recruiter.getRecruiterId());
            double avgApplicationsPerJob = applicationDAO.getAvgApplicationsPerJobByRecruiterId(recruiter.getRecruiterId());

            // Set attributes for JSP
            request.setAttribute("jobPosts", jobPosts);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);

            // Set individual statistics attributes
            request.setAttribute("totalJobs", totalJobs);
            request.setAttribute("totalApplications", totalApplications);
            request.setAttribute("avgApplicationsPerJob", avgApplicationsPerJob);

            // Set filter values back to form
            request.setAttribute("selectedJobTitle", jobTitle);
            request.setAttribute("selectedStatus", status);
            request.setAttribute("selectedMinApplications", minApplicationsStr);

            // Forward to JSP
            request.getRequestDispatcher("/ApplicationManagement.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/ApplicationManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Application Management Servlet";
    }
}