/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.dao.TestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

/**
 *
 * @author hoang
 */
@WebServlet(name = "UpdateStatusServlet", urlPatterns = {"/UpdateStatusServlet"})
public class UpdateStatusServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy tham số
        String testIdRaw = request.getParameter("testId");
        String status = request.getParameter("statusUpdate");
        String keyword = request.getParameter("keyword");
        String recruiterId = request.getParameter("recruiterId");

        // Kiểm tra id và status
        if (testIdRaw == null || testIdRaw.trim().isEmpty() || status == null || status.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số id hoặc status");
            return;
        }

        int testId;
        try {
            testId = Integer.parseInt(testIdRaw);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
            return;
        }

        // Cập nhật trạng thái
        TestDAO testDAO = new TestDAO();
        JobPostingPageDAO jppdao = new JobPostingPageDAO();
        boolean update = false;
        
        if (status.equalsIgnoreCase("Rejected")){
            jppdao.addServiceCredit(recruiterId, "test");
            testDAO.updateTestStatus(testId, status);
            update = true;
        }else{
            testDAO.updateTestStatus(testId, status);
            update = true;
        }

        // Xử lý kết quả cập nhật
        String redirectURL = "PendingTest";
        if (keyword != null && !keyword.isEmpty()) {
            redirectURL += "?keyword=" + URLEncoder.encode(keyword, "UTF-8");
            System.out.println(redirectURL);
        }

        if (update) {
            response.sendRedirect(redirectURL);
        } else {
            // Nếu update thất bại → trả lỗi hoặc redirect có thông báo
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật trạng thái");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
