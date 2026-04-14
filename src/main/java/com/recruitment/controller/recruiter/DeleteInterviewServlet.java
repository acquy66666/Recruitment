package com.recruitment.controller.recruiter;

import com.recruitment.dao.InterviewDAO;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "DeleteInterviewServlet", urlPatterns = {"/DeleteInterview"})
public class DeleteInterviewServlet extends HttpServlet {

    private InterviewDAO interviewDAO = new InterviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding for request and response
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Log request details
        String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        System.out.println("=== Delete Interview Request - " + currentTime + " ===");
        System.out.println("User: hoaghaii");
        System.out.println("Request Method: " + request.getMethod());
        System.out.println("Request URI: " + request.getRequestURI());

        // Check session and authentication
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            System.out.println("ERROR: No authenticated recruiter found in session");
            session.setAttribute("error", "Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
            response.sendRedirect("login");
            return;
        }

        System.out.println("Authenticated Recruiter ID: " + recruiter.getRecruiterId());

        // Log all request parameters for debugging
        System.out.println("Request Parameters:");
        request.getParameterMap().forEach((key, values) -> {
            System.out.println("  " + key + ": " + java.util.Arrays.toString(values));
        });

        try {
            // Get interview ID from request
            String interviewIdStr = request.getParameter("interviewId");
            
            if (interviewIdStr == null || interviewIdStr.trim().isEmpty()) {
                System.out.println("ERROR: Missing or empty interviewId parameter");
                session.setAttribute("error", "Thiếu thông tin ID phỏng vấn");
                response.sendRedirect("InterviewManager");
                return;
            }

            int interviewId;
            try {
                interviewId = Integer.parseInt(interviewIdStr.trim());
                System.out.println("Parsed Interview ID: " + interviewId);
            } catch (NumberFormatException e) {
                System.out.println("ERROR: Invalid interview ID format: " + interviewIdStr);
                session.setAttribute("error", "ID phỏng vấn không hợp lệ");
                response.sendRedirect("InterviewManager");
                return;
            }

            // Validate interview exists and belongs to current recruiter
            System.out.println("Checking if interview exists for recruiter...");
            boolean interviewExists = interviewDAO.interviewExistsForRecruiter(interviewId, recruiter.getRecruiterId());
            
            if (!interviewExists) {
                System.out.println("ERROR: Interview not found or doesn't belong to recruiter");
                session.setAttribute("error", "Không tìm thấy cuộc phỏng vấn hoặc bạn không có quyền xóa");
                response.sendRedirect("InterviewManager");
                return;
            }

            System.out.println("Interview validation passed. Proceeding with deletion...");

            // Get interview details for confirmation (optional - for logging purposes)
            String candidateName = request.getParameter("candidateName");
            String interviewDate = request.getParameter("interviewDate");
            
            if (candidateName != null && interviewDate != null) {
                System.out.println("Deleting interview for candidate: " + candidateName + " on " + interviewDate);
            }

            // Perform deletion
            boolean deleteSuccess = interviewDAO.deleteInterview(interviewId, recruiter.getRecruiterId());

            if (deleteSuccess) {
                System.out.println("SUCCESS: Interview deleted successfully");
                
                // Log successful deletion
                System.out.println("Deletion completed at: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                System.out.println("User: hoaghaii");
                
                session.setAttribute("success", "Đã xóa cuộc phỏng vấn thành công!");
            } else {
                System.out.println("ERROR: Failed to delete interview from database");
                session.setAttribute("error", "Không thể xóa cuộc phỏng vấn. Vui lòng thử lại sau.");
            }

        } catch (Exception e) {
            System.err.println("EXCEPTION in DeleteInterviewServlet: " + e.getMessage());
            e.printStackTrace();
            
            session.setAttribute("error", "Có lỗi hệ thống xảy ra: " + e.getMessage());
        }

        System.out.println("=== Delete Interview Request Complete ===\n");
        
        // Always redirect back to InterviewManager
        response.sendRedirect("InterviewManager");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Redirect POST requests to GET
        System.out.println("POST request to DeleteInterview - redirecting to GET");
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "DeleteInterviewServlet - Handles deletion of interview records via GET method with form submission";
    }
}