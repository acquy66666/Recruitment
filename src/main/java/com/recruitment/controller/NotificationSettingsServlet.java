package com.recruitment.controller;

import com.recruitment.model.Candidate;
import com.recruitment.model.Recruiter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "NotificationSettingsServlet", urlPatterns = {"/NotificationSettings"})
public class NotificationSettingsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in - use existing session attributes
        Candidate candidate = (Candidate) session.getAttribute("Candidate");
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        
        if (candidate == null && recruiter == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Forward to JSP
        request.getRequestDispatcher("NotificationSettings.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Get notification settings
        String jobEmailAlert = request.getParameter("jobEmailAlert");
        String jobPushAlert = request.getParameter("jobPushAlert");
        String jobEmailFrequency = request.getParameter("jobEmailFrequency");
        String applicationEmail = request.getParameter("applicationEmail");
        String interviewReminder = request.getParameter("interviewReminder");
        String testNotification = request.getParameter("testNotification");
        String newsUpdates = request.getParameter("newsUpdates");
        String promotions = request.getParameter("promotions");
        
        // Save settings to session or database
        session.setAttribute("notification_jobEmailAlert", jobEmailAlert != null);
        session.setAttribute("notification_jobPushAlert", jobPushAlert != null);
        session.setAttribute("notification_jobEmailFrequency", jobEmailFrequency != null ? jobEmailFrequency : "daily");
        session.setAttribute("notification_applicationEmail", applicationEmail != null);
        session.setAttribute("notification_interviewReminder", interviewReminder != null);
        session.setAttribute("notification_testNotification", testNotification != null);
        session.setAttribute("notification_newsUpdates", newsUpdates != null);
        session.setAttribute("notification_promotions", promotions != null);
        
        // Set success message
        session.setAttribute("notificationMessage", "Cài đặt thông báo đã được lưu thành công!");
        session.setAttribute("notificationType", "success");
        
        // Redirect back to settings page
        response.sendRedirect("NotificationSettings");
    }
}
