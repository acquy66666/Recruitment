package com.recruitment.controller;

import com.recruitment.model.Candidate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "WriteReviewServlet", urlPatterns = {"/WriteReviewServlet"})
public class WriteReviewServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to company reviews page
        response.sendRedirect("CompanyReviews.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in - use existing session attribute
        Candidate candidate = (Candidate) session.getAttribute("Candidate");
        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Get review data
        String companyId = request.getParameter("companyId");
        String rating = request.getParameter("rating");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String pros = request.getParameter("pros");
        String cons = request.getParameter("cons");
        String recommend = request.getParameter("recommend");
        
        // Validate input
        if (companyId == null || rating == null || title == null || content == null) {
            session.setAttribute("reviewMessage", "Vui lòng điền đầy đủ thông tin!");
            session.setAttribute("reviewType", "danger");
            response.sendRedirect("CompanyReviews.jsp");
            return;
        }
        
        // TODO: Save review to database
        
        // Set success message
        session.setAttribute("reviewMessage", "Cảm ơn bạn đã gửi đánh giá! Đánh giá của bạn sẽ được kiểm duyệt trước khi hiển thị.");
        session.setAttribute("reviewType", "success");
        
        // Redirect back to company reviews page
        response.sendRedirect("CompanyReviews.jsp");
    }
}
