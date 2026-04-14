/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller;

import com.google.gson.Gson;
import com.recruitment.dao.NotificationDAO;
import com.recruitment.model.Notification;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        // Get user info from session
        String userType = null;
        Integer userId = null;
        
        if (session.getAttribute("Recruiter") != null) {
            userType = "recruiter";
            userId = ((com.recruitment.model.Recruiter) session.getAttribute("Recruiter")).getRecruiterId();
        } else if (session.getAttribute("Candidate") != null) {
            userType = "candidate";
            userId = ((com.recruitment.model.Candidate) session.getAttribute("Candidate")).getCandidateId();
        } else if (session.getAttribute("Admin") != null) {
            userType = "admin";
            userId = ((com.recruitment.model.Admin) session.getAttribute("Admin")).getId();
        } else if (session.getAttribute("Moderator") != null) {
            userType = "moderator";
            userId = ((com.recruitment.model.Moderator) session.getAttribute("Moderator")).getModeratorsId();
        }

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        
        if (userId == null || userType == null) {
            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            res.getWriter().write("{\"error\": \"Unauthorized\"}");
            return;
        }

        try {
            NotificationDAO dao = new NotificationDAO();
            List<Notification> notifications = dao.getNotifications(userType, userId);
            
            Gson gson = new Gson();
            String json = gson.toJson(notifications);
            res.getWriter().write(json);
            
        } catch (Exception e) {
            e.printStackTrace();
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            res.getWriter().write("{\"error\": \"Internal server error\"}");
        }
    }
}

