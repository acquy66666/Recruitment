package com.recruitment.controller.recruiter;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "JobPostCandidatesServlet", urlPatterns = {"/JobPostCandidates"})
public class JobPostCandidates extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 10;

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

            // Get job ID parameter
            String jobIdParam = request.getParameter("jobId");
            if (jobIdParam == null || jobIdParam.trim().isEmpty()) {
                request.setAttribute("error", "Không tìm thấy thông tin công việc");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            int jobId = Integer.parseInt(jobIdParam);

            // Get job post information
            Map<String, Object> jobPost = applicationDAO.getJobPostById(jobId);
            if (jobPost == null) {
                request.setAttribute("error", "Không tìm thấy thông tin công việc");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            // Get filter parameters
            String status = request.getParameter("status");
            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");
            String searchName = request.getParameter("searchName");

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

            // Get candidates
            List<Map<String, Object>> candidates = applicationDAO.getCandidatesByJobId(
                    jobId, status, dateFrom, dateTo, searchName, offset, RECORDS_PER_PAGE);

            // Get total count for pagination
            int totalRecords = applicationDAO.countCandidatesByJobId(
                    jobId, status, dateFrom, dateTo, searchName);
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

            // Get application statistics for this job
            Map<String, Object> stats = applicationDAO.getJobApplicationStats(jobId);

            // Set attributes for JSP
            request.setAttribute("jobPost", jobPost);
            request.setAttribute("candidates", candidates);
            request.setAttribute("stats", stats);
            request.setAttribute("totalCandidates", totalRecords);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);

            // Set filter values back to form
            request.setAttribute("selectedStatus", status);
            request.setAttribute("selectedDateFrom", dateFrom);
            request.setAttribute("selectedDateTo", dateTo);
            request.setAttribute("selectedSearchName", searchName);

            // Forward to JSP
            request.getRequestDispatcher("/JobPostCandidates.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID công việc không hợp lệ");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            sendJsonResponse(response, false, "Phiên đăng nhập đã hết hạn");
            return;
        }

        String action = request.getParameter("action");
        ApplicationDAO applicationDAO = new ApplicationDAO();

        try {
            if ("changeStatus".equals(action)) {
                handleSingleStatusChange(request, response, applicationDAO, recruiter);
            } else if ("bulkChangeStatus".equals(action)) {
                handleBulkStatusChange(request, response, applicationDAO, recruiter);
            } else {
                sendJsonResponse(response, false, "Hành động không hợp lệ");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonResponse(response, false, "Có lỗi xảy ra: " + e.getMessage());
        }
    }

    private void handleSingleStatusChange(HttpServletRequest request, HttpServletResponse response,
                                        ApplicationDAO applicationDAO, Recruiter recruiter) throws IOException {
        String applicationIdParam = request.getParameter("applicationId");
        String newStatus = request.getParameter("newStatus");

        System.out.println("=== Single Status Change Debug ===");
        System.out.println("Application ID: " + applicationIdParam);
        System.out.println("New Status: " + newStatus);
        System.out.println("Recruiter ID: " + recruiter.getRecruiterId());

        if (applicationIdParam == null || newStatus == null) {
            sendJsonResponse(response, false, "Thông tin không đầy đủ");
            return;
        }

        try {
            int applicationId = Integer.parseInt(applicationIdParam);
            
            // Validate status
            if (!isValidStatus(newStatus)) {
                sendJsonResponse(response, false, "Trạng thái không hợp lệ: " + newStatus);
                return;
            }

            boolean success = applicationDAO.updateSingleApplicationStatus(
                    applicationId, newStatus, recruiter.getRecruiterId());

            System.out.println("Update result: " + success);

            if (success) {
                sendJsonResponse(response, true, "Cập nhật trạng thái thành công");
            } else {
                sendJsonResponse(response, false, "Không thể cập nhật trạng thái. Có thể bạn không có quyền hoặc ứng tuyển không tồn tại.");
            }

        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "ID ứng tuyển không hợp lệ");
        }
    }

    private void handleBulkStatusChange(HttpServletRequest request, HttpServletResponse response,
                                      ApplicationDAO applicationDAO, Recruiter recruiter) throws IOException {
        String applicationIdsParam = request.getParameter("applicationIds");
        String newStatus = request.getParameter("newStatus");

        System.out.println("=== Bulk Status Change Debug ===");
        System.out.println("Application IDs: " + applicationIdsParam);
        System.out.println("New Status: " + newStatus);

        if (applicationIdsParam == null || newStatus == null) {
            sendJsonResponse(response, false, "Thông tin không đầy đủ");
            return;
        }

        try {
            // Parse application IDs
            List<Integer> applicationIds = Arrays.stream(applicationIdsParam.split(","))
                    .map(String::trim)
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());

            if (applicationIds.isEmpty()) {
                sendJsonResponse(response, false, "Không có ứng viên nào được chọn");
                return;
            }

            // Validate status
            if (!isValidStatus(newStatus)) {
                sendJsonResponse(response, false, "Trạng thái không hợp lệ: " + newStatus);
                return;
            }

            boolean success = applicationDAO.updateApplicationStatusBatch(
                    applicationIds, newStatus, recruiter.getRecruiterId());

            if (success) {
                sendJsonResponse(response, true, "Cập nhật trạng thái thành công cho " + applicationIds.size() + " ứng viên");
            } else {
                sendJsonResponse(response, false, "Không thể cập nhật trạng thái");
            }

        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "Danh sách ID ứng tuyển không hợp lệ");
        }
    }

    private boolean isValidStatus(String status) {
        // Updated to match your JSP status options
        return Arrays.asList("Pending", "Interview", "Testing", "Accepted", "Rejected")
                .contains(status);
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Manual JSON construction to avoid dependency issues
        String jsonResponse = String.format(
            "{\"success\": %s, \"message\": \"%s\"}", 
            success, 
            message.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r")
        );

        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse);
            out.flush();
        }
        
        System.out.println("Sending JSON response: " + jsonResponse);
    }

    @Override
    public String getServletInfo() {
        return "Job Post Candidates Management Servlet";
    }
}