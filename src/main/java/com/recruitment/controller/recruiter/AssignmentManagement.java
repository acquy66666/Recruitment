/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.AssignmentDAO;
import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.dao.TestDAO;
import com.recruitment.dto.AssignmentDTO;
import com.recruitment.dto.TestWithCount;
import com.recruitment.model.Assignment;
import com.recruitment.model.Candidate;
import com.recruitment.model.JobPost;
import com.recruitment.model.Recruiter;
import com.recruitment.model.Test;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
@WebServlet(name = "AssignmentManagement", urlPatterns = {"/AssignmentManagement"})
public class AssignmentManagement extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            response.sendRedirect("login");
            return;
        }

        int pageSize = Integer.parseInt(request.getParameter("pageSize") != null ? request.getParameter("pageSize") : "10");
        int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
        String testIdStr = request.getParameter("testId");
        int testId = 0;
        if (testIdStr != null && !testIdStr.trim().isEmpty()) {
            testId = Integer.parseInt(testIdStr.trim());
        }

        String jobIdStr = request.getParameter("jobId");
        int jobId = 0;
        if (jobIdStr != null && !jobIdStr.trim().isEmpty()) {
            jobId = Integer.parseInt(jobIdStr.trim());
        }

        String searchKeyword = request.getParameter("search");
        String status = request.getParameter("status");

        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");

        Timestamp assignedFromDate = null;
        Timestamp assignedToDate = null;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        if (fromDateStr != null && !fromDateStr.isEmpty()) {
            assignedFromDate = Timestamp.valueOf(LocalDate.parse(fromDateStr, formatter).atStartOfDay());
        }
        if (toDateStr != null && !toDateStr.isEmpty()) {
            assignedToDate = Timestamp.valueOf(LocalDate.parse(toDateStr, formatter).plusDays(1).atStartOfDay());
        }

        String scoreRange = request.getParameter("scoreRange");
        Double minScore = null;
        Double maxScore = null;

        if (scoreRange != null && scoreRange.contains("-")) {
            String[] parts = scoreRange.split("-");
            try {
                minScore = Double.parseDouble(parts[0]);
                maxScore = Double.parseDouble(parts[1]);
            } catch (NumberFormatException ignored) {
            }
        }

        AssignmentDAO assignmentDAO = new AssignmentDAO();

        int totalRecords = assignmentDAO.countAssignmentsByRecruiterId(recruiter.getRecruiterId(), searchKeyword, status, jobId, testId, assignedFromDate, assignedToDate, minScore, maxScore);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        List<AssignmentDTO> aList = assignmentDAO.getAssignmentsByRecruiterId(recruiter.getRecruiterId(), searchKeyword, status, jobId, testId, assignedFromDate, assignedToDate, minScore, maxScore, page, pageSize);
        TestDAO testDAO = new TestDAO();
        List<TestWithCount> testFilter = testDAO.getAllTestsById(recruiter.getRecruiterId());

        JobPostingPageDAO postingPageDAO = new JobPostingPageDAO();
        List<JobPost> jobFilter = postingPageDAO.getJobPostTitlesByRecruiterId(recruiter.getRecruiterId());

        List<String> statusFilter = assignmentDAO.getAllAssignmentStatuses();
        
        int completedCount = assignmentDAO.countAssignmentByRecruiterAndStatus(recruiter.getRecruiterId(), "completed");
        int doingCount = assignmentDAO.countAssignmentByRecruiterAndStatus(recruiter.getRecruiterId(), "doing");
        int totalCount = assignmentDAO.countAssignmentByRecruiter(recruiter.getRecruiterId());
       

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("completedCount", completedCount);
        request.setAttribute("doingCount", doingCount);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("aList", aList);
        request.setAttribute("testFilter", testFilter);
        request.setAttribute("jobFilter", jobFilter);
        request.setAttribute("statusFilter", statusFilter);
        request.getRequestDispatcher("/AssignmentManagement.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dueDateStr = request.getParameter("dueDate");
        String jobIdStr = request.getParameter("jobId");
        String testIdStr = request.getParameter("testId");

        if (jobIdStr != null && !jobIdStr.trim().isEmpty()
                && testIdStr != null && !testIdStr.trim().isEmpty()
                && dueDateStr != null && !dueDateStr.trim().isEmpty()) {

            try {
                int jobId = Integer.parseInt(jobIdStr);
                int testId = Integer.parseInt(testIdStr);

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                LocalDateTime localDue = LocalDateTime.parse(dueDateStr, formatter);
                Timestamp dueDate = Timestamp.valueOf(localDue);

                AssignmentDAO dao = new AssignmentDAO();
                List<Candidate> cList = dao.getCandidatesCanBeAssigned(jobId);

                int countAssigned = 0;
                for (Candidate candidate : cList) {
                    int candidateId = candidate.getCandidateId();
                    if (!dao.isAssignmentExists(jobId, candidateId)) {
                        dao.assignTestToCandidate(testId, jobId, candidateId, dueDate);
                        countAssigned++;
                    } else {
                        System.out.println("❌ Candidate ID " + candidateId + " đã có bài test.");
                    }
                }

                System.out.println("Tổng số ứng viên được giao bài: " + countAssigned);

                // ✅ Gửi thông báo thành công và chuyển hướng
                request.getSession().setAttribute("message", "Đã giao bài test cho " + countAssigned + " ứng viên.");
                response.sendRedirect("AssignmentManagement");

            } catch (Exception e) {
                e.printStackTrace();
                // ✅ Gửi thông báo lỗi
                request.getSession().setAttribute("error", "Lỗi xử lý: " + e.getMessage());
                response.sendRedirect("AssignmentManagement");
            }

        } else {
            // ✅ Trường hợp thiếu dữ liệu
            request.getSession().setAttribute("error", "Thiếu dữ liệu: jobId, testId hoặc dueDate.");
            response.sendRedirect("AssignmentManagement");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
