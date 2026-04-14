package com.recruitment.controller;

import com.recruitment.model.Candidate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PortfolioServlet", urlPatterns = {"/Portfolio"})
public class PortfolioServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in - use existing session attribute
        Candidate candidate = (Candidate) session.getAttribute("Candidate");
        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Forward to JSP
        request.getRequestDispatcher("PortfolioPage.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        Candidate candidate = (Candidate) session.getAttribute("Candidate");
        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Get action type
        String action = request.getParameter("action");
        
        if ("addProject".equals(action)) {
            // Handle add project
            String projectName = request.getParameter("projectName");
            String description = request.getParameter("description");
            String projectType = request.getParameter("projectType");
            String year = request.getParameter("year");
            String technologies = request.getParameter("technologies");
            String projectUrl = request.getParameter("projectUrl");
            
            // TODO: Save project to database
            
            session.setAttribute("portfolioMessage", "Dự án '" + projectName + "' đã được thêm thành công!");
            session.setAttribute("portfolioType", "success");
            
        } else if ("addCertification".equals(action)) {
            // Handle add certification
            String certName = request.getParameter("certName");
            String issuer = request.getParameter("issuer");
            String certDate = request.getParameter("certDate");
            
            // TODO: Save certification to database
            
            session.setAttribute("portfolioMessage", "Chứng chỉ đã được thêm thành công!");
            session.setAttribute("portfolioType", "success");
            
        } else if ("addExperience".equals(action)) {
            // Handle add experience
            String position = request.getParameter("position");
            String company = request.getParameter("company");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String description = request.getParameter("description");
            
            // TODO: Save experience to database
            
            session.setAttribute("portfolioMessage", "Kinh nghiệm làm việc đã được thêm thành công!");
            session.setAttribute("portfolioType", "success");
        }
        
        // Redirect back to portfolio page
        response.sendRedirect("Portfolio");
    }
}
