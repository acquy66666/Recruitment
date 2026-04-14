package com.recruitment.controller.recruiter;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.InterviewDAO;
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

@WebServlet(name = "InterviewManager", urlPatterns = {"/InterviewManager"})
public class InterviewManager extends HttpServlet {

    private InterviewDAO interviewDAO = new InterviewDAO();
    private ApplicationDAO applicationDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding for request and response
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Get filter parameters
            String search = request.getParameter("search");
            String jobPosition = request.getParameter("jobPosition");
            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");

            int page = 1;
            int pageSize = 10;

            try {
                String pageParam = request.getParameter("page");
                if (pageParam != null && !pageParam.isEmpty()) {
                    page = Integer.parseInt(pageParam);
                }
            } catch (NumberFormatException e) {
                page = 1;
            }

            int offset = (page - 1) * pageSize;

            System.out.println("=== InterviewManager Debug ===");
            System.out.println("Recruiter ID: " + recruiter.getRecruiterId());
            System.out.println("Search filter: '" + search + "'");
            System.out.println("Job Position filter: " + jobPosition);
            System.out.println("Date From: " + dateFrom);
            System.out.println("Date To: " + dateTo);
            System.out.println("Page: " + page);

            // Get scheduled interviews (candidates with interview records)
            List<Map<String, Object>> interviews = interviewDAO.getScheduledInterviews(
                    recruiter.getRecruiterId(), search, jobPosition, dateFrom, dateTo, offset, pageSize);

            System.out.println("Found " + interviews.size() + " scheduled interviews");

            // Get total count for pagination
            int totalCount = interviewDAO.countScheduledInterviews(
                    recruiter.getRecruiterId(), search, jobPosition, dateFrom, dateTo);
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);

            System.out.println("Total count: " + totalCount + ", Total pages: " + totalPages);

            // Get interview-specific statistics
            Map<String, Object> stats = interviewDAO.getInterviewStats(recruiter.getRecruiterId());

            // Get filter options
            List<Map<String, Object>> jobsWithApplications = applicationDAO.getJobsWithApplications(recruiter.getRecruiterId());
            List<String> jobPositions = applicationDAO.getJobPositions(recruiter.getRecruiterId());

            // Set attributes for JSP
            request.setAttribute("interviews", interviews);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCount", totalCount);

            // Interview-specific statistics
            request.setAttribute("totalInterviews", stats.get("totalInterviews"));
            request.setAttribute("upcomingInterviews", stats.get("upcomingInterviews"));
            request.setAttribute("completedInterviews", stats.get("completedInterviews"));
            request.setAttribute("todayInterviews", stats.get("todayInterviews"));
            request.setAttribute("videoInterviews", stats.get("videoInterviews"));

            // Filter options
            request.setAttribute("jobsWithApplications", jobsWithApplications);
            request.setAttribute("jobPositions", jobPositions);

            request.getRequestDispatcher("InterviewManager.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error in InterviewManager: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("InterviewManager.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding for request and response
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            // Check if it's an AJAX request
            if (isAjaxRequest(request)) {
                sendJsonResponse(response, false, "Phiên đăng nhập đã hết hạn");
            } else {
                response.sendRedirect("login");
            }
            return;
        }

        String action = request.getParameter("action");
        System.out.println("=== POST Request Debug ===");
        System.out.println("Action parameter: '" + action + "'");
        System.out.println("All parameters:");
        request.getParameterMap().forEach((key, values) -> {
            System.out.println("  " + key + ": " + java.util.Arrays.toString(values));
        });

        if ("editInterview".equals(action)) {
            handleEditInterview(request, response, recruiter);
        } else if ("deleteInterview".equals(action)) {
            handleDeleteInterview(request, response, recruiter);
        } else {
            System.out.println("Unknown action: " + action);
            if (isAjaxRequest(request)) {
                sendJsonResponse(response, false, "Hành động không hợp lệ");
            } else {
                doGet(request, response);
            }
        }
    }

    private void handleEditInterview(HttpServletRequest request, HttpServletResponse response, Recruiter recruiter)
            throws ServletException, IOException {

        try {
            // Get form parameters
            String interviewIdStr = request.getParameter("interviewId");
            String interviewDate = request.getParameter("interviewDate");
            String interviewTime = request.getParameter("interviewTime");
            String interviewType = request.getParameter("interviewType");
            String location = request.getParameter("location");
            String interviewers = request.getParameter("interviewers");
            String description = request.getParameter("description");

            System.out.println("=== Edit Interview Debug ===");
            System.out.println("Interview ID: " + interviewIdStr);
            System.out.println("Interview Type: " + interviewType);
            System.out.println("Location: " + location);

            // Validate required fields
            if (interviewIdStr == null || interviewDate == null || interviewTime == null || interviewType == null) {
                request.getSession().setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
                response.sendRedirect("InterviewManager");
                return;
            }

            int interviewId = Integer.parseInt(interviewIdStr);

            // Validate location for ONSITE interviews
            if ("ONSITE".equals(interviewType) && (location == null || location.trim().isEmpty())) {
                request.getSession().setAttribute("error", "Vui lòng nhập địa điểm cho phỏng vấn trực tiếp");
                response.sendRedirect("InterviewManager");
                return;
            }

            // Also check for "in-person" for backward compatibility
            if ("in-person".equals(interviewType) && (location == null || location.trim().isEmpty())) {
                request.getSession().setAttribute("error", "Vui lòng nhập địa điểm cho phỏng vấn trực tiếp");
                response.sendRedirect("InterviewManager");
                return;
            }

            // Combine date and time
            String interviewDateTime = interviewDate + " " + interviewTime + ":00";

            // Update interview
            boolean success = interviewDAO.updateInterview(interviewId, interviewDateTime, location,
                    interviewers, description, interviewType, recruiter.getRecruiterId());

            if (success) {
                request.getSession().setAttribute("success", "Cập nhật thông tin phỏng vấn thành công");
            } else {
                request.getSession().setAttribute("error", "Không thể cập nhật thông tin phỏng vấn. Vui lòng thử lại.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Thông tin phỏng vấn không hợp lệ");
        } catch (Exception e) {
            System.err.println("Error updating interview: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi cập nhật: " + e.getMessage());
        }

        response.sendRedirect("InterviewManager");
    }

    private void handleDeleteInterview(HttpServletRequest request, HttpServletResponse response, Recruiter recruiter)
            throws IOException {

        try {
            String interviewIdStr = request.getParameter("interviewId");

            System.out.println("=== Delete Interview Debug ===");
            System.out.println("Interview ID parameter: '" + interviewIdStr + "'");

            if (interviewIdStr == null || interviewIdStr.trim().isEmpty()) {
                sendJsonResponse(response, false, "Thông tin phỏng vấn không hợp lệ");
                return;
            }

            int interviewId = Integer.parseInt(interviewIdStr);

            System.out.println("Parsed Interview ID: " + interviewId);
            System.out.println("Recruiter ID: " + recruiter.getRecruiterId());

            // Check if interview exists and belongs to this recruiter before deleting
            boolean interviewExists = interviewDAO.interviewExistsForRecruiter(interviewId, recruiter.getRecruiterId());

            if (!interviewExists) {
                sendJsonResponse(response, false, "Không tìm thấy cuộc phỏng vấn hoặc bạn không có quyền xóa");
                return;
            }

            // Delete interview
            boolean success = interviewDAO.deleteInterview(interviewId, recruiter.getRecruiterId());

            if (success) {
                System.out.println("Interview deleted successfully");
                sendJsonResponse(response, true, "Xóa cuộc phỏng vấn thành công");
            } else {
                System.out.println("Failed to delete interview");
                sendJsonResponse(response, false, "Không thể xóa cuộc phỏng vấn. Có thể bạn không có quyền hoặc cuộc phỏng vấn không tồn tại.");
            }

        } catch (NumberFormatException e) {
            System.err.println("Invalid interview ID format: " + e.getMessage());
            sendJsonResponse(response, false, "ID phỏng vấn không hợp lệ");
        } catch (Exception e) {
            System.err.println("Error deleting interview: " + e.getMessage());
            e.printStackTrace();
            sendJsonResponse(response, false, "Có lỗi xảy ra khi xóa: " + e.getMessage());
        }
    }

    // Helper method to check if request is AJAX
    private boolean isAjaxRequest(HttpServletRequest request) {
        String xRequestedWith = request.getHeader("X-Requested-With");
        String contentType = request.getContentType();

        return "XMLHttpRequest".equals(xRequestedWith)
                || (contentType != null && contentType.contains("multipart/form-data"));
    }

    // Helper method for JSON responses with proper UTF-8 encoding
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        // Set response headers for proper UTF-8 encoding
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Create JSON response with proper encoding
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("{");
        jsonBuilder.append("\"success\": ").append(success).append(",");
        jsonBuilder.append("\"message\": \"").append(escapeJsonString(message)).append("\",");
        jsonBuilder.append("\"timestamp\": \"").append(java.time.LocalDateTime.now().toString()).append("\"");
        jsonBuilder.append("}");

        String jsonResponse = jsonBuilder.toString();

        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse);
            out.flush();
        }

        System.out.println("Sending JSON response: " + jsonResponse);
    }

    // Helper method to escape JSON strings properly
    private String escapeJsonString(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t")
                .replace("\b", "\\b")
                .replace("\f", "\\f");
    }
}
