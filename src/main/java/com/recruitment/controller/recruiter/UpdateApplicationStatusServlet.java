/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.recruitment.controller.recruiter;

import com.google.gson.Gson;
import com.recruitment.dao.ApplicationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author hoang
 */
@WebServlet(name="UpdateApplicationStatusServlet", urlPatterns={"/update-application-status"})
public class UpdateApplicationStatusServlet extends HttpServlet {
    
    private ApplicationDAO applicationDAO;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
        gson = new Gson();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Integer recruiterId = (Integer) session.getAttribute("recruiterId");
        
        Map<String, Object> result = new HashMap<>();
        
        if (recruiterId == null) {
            result.put("success", false);
            result.put("message", "Phiên đăng nhập đã hết hạn");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            writeJsonResponse(response, result);
            return;
        }
        
        try {
            // Lấy parameters
            String applicationIdStr = request.getParameter("applicationId");
            String status = request.getParameter("status");
            String reason = request.getParameter("reason");
            
            if (applicationIdStr == null || status == null) {
                result.put("success", false);
                result.put("message", "Thiếu thông tin cần thiết");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                writeJsonResponse(response, result);
                return;
            }
            
            int applicationId = Integer.parseInt(applicationIdStr);
            
            // Validate status
            if (!isValidStatus(status)) {
                result.put("success", false);
                result.put("message", "Trạng thái không hợp lệ");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                writeJsonResponse(response, result);
                return;
            }
            
            // Cập nhật trạng thái
            boolean success = applicationDAO.updateApplicationStatus(applicationId, recruiterId, status, reason);
            
            if (success) {
                result.put("success", true);
                result.put("message", getSuccessMessage(status));
            } else {
                result.put("success", false);
                result.put("message", "Không thể cập nhật trạng thái. Vui lòng kiểm tra lại.");
            }
            
        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("message", "ID ứng tuyển không hợp lệ");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Có lỗi xảy ra: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        
        writeJsonResponse(response, result);
    }
    
    private boolean isValidStatus(String status) {
        return status.equals("Accepted") || status.equals("Rejected") || 
               status.equals("Interview") || status.equals("Reviewing");
    }
    
    private String getSuccessMessage(String status) {
        switch (status) {
            case "Accepted":
                return "Đã chấp nhận ứng viên thành công!";
            case "Rejected":
                return "Đã từ chối ứng viên thành công!";
            case "Interview":
                return "Đã chuyển ứng viên sang phỏng vấn!";
            case "Reviewing":
                return "Đã chuyển ứng viên sang đang xem xét!";
            default:
                return "Cập nhật trạng thái thành công!";
        }
    }
    
    private void writeJsonResponse(HttpServletResponse response, Map<String, Object> result) 
            throws IOException {
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(result));
            out.flush();
        }
    }
}
