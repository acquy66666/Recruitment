/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.JobPost;
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
@WebServlet(name="ViewJobApplicantsServlet", urlPatterns={"/view-job-applicants"})
public class ViewJobApplicantsServlet extends HttpServlet {
    
    private ApplicationDAO applicationDAO;
    private JobPostingPageDAO jobDAO;
    
    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
        jobDAO = new JobPostingPageDAO();
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
        
        int recruiterId = recruiter.getRecruiterId();
        
        try {
            // Lấy parameters từ request
            String jobPosition = request.getParameter("jobPosition");
            String status = request.getParameter("status");
            String experience = request.getParameter("experience");
            String dateFrom = request.getParameter("dateFrom");
            String dateTo = request.getParameter("dateTo");
            
            // Convert empty strings thành null để tránh lỗi SQL
            jobPosition = (jobPosition != null && !jobPosition.trim().isEmpty()) ? jobPosition.trim() : null;
            status = (status != null && !status.trim().isEmpty()) ? status.trim() : null;
            experience = (experience != null && !experience.trim().isEmpty()) ? experience.trim() : null;
            dateFrom = (dateFrom != null && !dateFrom.trim().isEmpty()) ? dateFrom.trim() : null;
            dateTo = (dateTo != null && !dateTo.trim().isEmpty()) ? dateTo.trim() : null;
            
            // Pagination
            int page = 1;
            int pageSize = 10;
            try {
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                    if (page < 1) page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
            
            List<Map<String, Object>> applicants;
            int totalApplicants;
            
            // LUÔN LUÔN load dữ liệu - nếu có filter thì dùng filtered, không thì lấy tất cả
            if (jobPosition != null || status != null || experience != null || dateFrom != null || dateTo != null) {
                // Có filter - sử dụng filtered query
                applicants = applicationDAO.getFilteredApplicants(
                    recruiterId, jobPosition, status, experience, dateFrom, dateTo, page, pageSize);
                totalApplicants = applicationDAO.getFilteredApplicantsCount(
                    recruiterId, jobPosition, status, experience, dateFrom, dateTo);
            } else {
                // Không có filter - lấy tất cả applicants
                applicants = applicationDAO.getAllApplicantsByRecruiter(recruiterId, page, pageSize);
                totalApplicants = applicationDAO.getTotalApplicantsCount(recruiterId);
            }
            
            // Lấy thống kê
            Map<String, Object> stats = applicationDAO.getApplicantStats(recruiterId);
            
            // Lấy danh sách jobs với applications để hiển thị trong filter
            List<Map<String, Object>> jobsWithApplications = applicationDAO.getJobsWithApplications(recruiterId);
            
            // Lấy job positions từ jobs có applications
            List<JobPost> jobPositions = jobDAO.positionAllJobPost(String.valueOf(recruiterId));
            
            // Tính toán pagination
            int totalPages = (int) Math.ceil((double) totalApplicants / pageSize);
            int startItem = (page - 1) * pageSize + 1;
            int endItem = Math.min(page * pageSize, totalApplicants);
            
            // Set attributes
            request.setAttribute("applicants", applicants);
            request.setAttribute("stats", stats);
            request.setAttribute("jobsWithApplications", jobsWithApplications);
            request.setAttribute("jobPositions", jobPositions);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalApplicants", totalApplicants);
            request.setAttribute("startItem", startItem);
            request.setAttribute("endItem", endItem);
            request.setAttribute("pageSize", pageSize);
            
            // Set filter values để giữ lại trong form
            request.setAttribute("selectedJobPosition", request.getParameter("jobPosition"));
            request.setAttribute("selectedStatus", request.getParameter("status"));
            request.setAttribute("selectedExperience", request.getParameter("experience"));
            request.setAttribute("selectedDateFrom", request.getParameter("dateFrom"));
            request.setAttribute("selectedDateTo", request.getParameter("dateTo"));
            
            request.getRequestDispatcher("viewJobApplicants.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách ứng viên: " + e.getMessage());
            request.getRequestDispatcher("viewJobApplicants.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // THÊM DEBUG LOGGING CHI TIẾT
        System.out.println("=== POST REQUEST DEBUG ===");
        System.out.println("Content-Type: " + request.getContentType());
        System.out.println("Character Encoding: " + request.getCharacterEncoding());
        
        // In tất cả parameters
        System.out.println("All parameters:");
        request.getParameterMap().forEach((key, values) -> {
            System.out.println("  " + key + " = " + String.join(", ", values));
        });
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        
        if (recruiter == null) {
            System.out.println("ERROR: No recruiter in session");
            out.print("{\"success\": false, \"message\": \"Phiên đăng nhập đã hết hạn\"}");
            return;
        }
        
        int recruiterId = recruiter.getRecruiterId();
        System.out.println("Recruiter ID: " + recruiterId);
        
        try {
            String action = request.getParameter("action");
            String applicationIdStr = request.getParameter("applicationId");
            String reason = request.getParameter("reason");
            
            System.out.println("Received parameters:");
            System.out.println("  action: '" + action + "'");
            System.out.println("  applicationId: '" + applicationIdStr + "'");
            System.out.println("  reason: '" + reason + "'");
            
            // Kiểm tra kỹ hơn các parameters
            if (applicationIdStr == null || applicationIdStr.trim().isEmpty()) {
                System.out.println("ERROR: applicationId is null or empty");
                out.print("{\"success\": false, \"message\": \"Thiếu applicationId\"}");
                return;
            }
            
            if (action == null || action.trim().isEmpty()) {
                System.out.println("ERROR: action is null or empty");
                out.print("{\"success\": false, \"message\": \"Thiếu action\"}");
                return;
            }
            
            int applicationId;
            try {
                applicationId = Integer.parseInt(applicationIdStr.trim());
                System.out.println("Parsed applicationId: " + applicationId);
            } catch (NumberFormatException e) {
                System.out.println("ERROR: Invalid applicationId format: " + applicationIdStr);
                out.print("{\"success\": false, \"message\": \"ID ứng tuyển không hợp lệ: " + applicationIdStr + "\"}");
                return;
            }
            
            String status = null;
            String successMessage = null;
            
            switch (action.trim()) {
                case "approve":
                    status = "Accepted";
                    successMessage = "Đã duyệt ứng viên thành công!";
                    break;
                case "reject":
                    status = "Rejected";
                    successMessage = "Đã từ chối ứng viên thành công!";
                    break;
                case "interview":
                    status = "Interview";
                    successMessage = "Đã mời ứng viên phỏng vấn thành công!";
                    break;
                case "pending":
                    status = "Pending";
                    successMessage = "Đã hoàn tác quyết định thành công!";
                    break;
                case "changeStatus":
                    // Xử lý thay đổi trạng thái từ dropdown
                    String newStatus = request.getParameter("newStatus");
                    System.out.println("  newStatus: '" + newStatus + "'");
                    
                    if (newStatus == null || newStatus.trim().isEmpty()) {
                        System.out.println("ERROR: newStatus is null or empty");
                        out.print("{\"success\": false, \"message\": \"Thiếu trạng thái mới\"}");
                        return;
                    }
                    
                    // Validate trạng thái hợp lệ
                    switch (newStatus.trim()) {
                        case "Pending":
                            status = "Pending";
                            successMessage = "Đã chuyển trạng thái thành 'Chờ xử lý'!";
                            break;
                        case "Reviewing":
                            status = "Reviewing";
                            successMessage = "Đã chuyển trạng thái thành 'Đang xem xét'!";
                            break;
                        case "Interview":
                            status = "Interview";
                            successMessage = "Đã chuyển trạng thái thành 'Phỏng vấn'!";
                            break;
                        case "Testing":
                            status = "Testing";
                            successMessage = "Đã chuyển trạng thái thành 'Đang test'!";
                            break;
                        case "Accepted":
                            status = "Accepted";
                            successMessage = "Đã chuyển trạng thái thành 'Đã duyệt'!";
                            break;
                        case "Rejected":
                            status = "Rejected";
                            successMessage = "Đã chuyển trạng thái thành 'Từ chối'!";
                            break;
                        default:
                            System.out.println("ERROR: Invalid newStatus: " + newStatus);
                            out.print("{\"success\": false, \"message\": \"Trạng thái không hợp lệ: " + newStatus + "\"}");
                            return;
                    }
                    break;
                default:
                    System.out.println("ERROR: Invalid action: " + action);
                    out.print("{\"success\": false, \"message\": \"Hành động không hợp lệ: " + action + "\"}");
                    return;
            }
            
            System.out.println("Updating application " + applicationId + " to status: " + status);
            
            // Update application status
            boolean success = applicationDAO.updateApplicationStatus(applicationId, recruiterId, status, reason);
            
            System.out.println("Update result: " + success);
            
            if (success) {
                System.out.println("SUCCESS: " + successMessage);
                out.print("{\"success\": true, \"message\": \"" + successMessage + "\"}");
            } else {
                System.out.println("FAILED: Could not update status");
                out.print("{\"success\": false, \"message\": \"Không thể cập nhật trạng thái. Vui lòng kiểm tra lại.\"}");
            }
            
        } catch (Exception e) {
            System.out.println("EXCEPTION in doPost: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        } finally {
            System.out.println("=== END POST REQUEST DEBUG ===");
        }
    }
}
