/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.recruitment.controller;

import com.google.gson.JsonObject;
import com.recruitment.dao.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author hoang
 */
@WebServlet("/read")
public class NotificationReadServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        // Get notification ID from URL
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.length() <= 1) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        String[] pathParts = pathInfo.split("/");
        if (pathParts.length < 2) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int notificationId;
        try {
            notificationId = Integer.parseInt(pathParts[1]);
        } catch (NumberFormatException e) {
            res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        // Check if user is logged in
        if (session.getAttribute("Recruiter") == null && 
            session.getAttribute("Candidate") == null && 
            session.getAttribute("Admin") == null && 
            session.getAttribute("Moderator") == null) {
            res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        
        try {
            NotificationDAO dao = new NotificationDAO();
            // Note: You'll need to add this method to NotificationDAO
            // dao.markAsRead(notificationId);
            
            JsonObject response = new JsonObject();
            response.addProperty("success", true);
            res.getWriter().write(response.toString());
            
        } catch (Exception e) {
            e.printStackTrace();
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
            JsonObject response = new JsonObject();
            response.addProperty("success", false);
            response.addProperty("error", "Internal server error");
            res.getWriter().write(response.toString());
        }
    }
}

