/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.AssignmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author hoang
 */
@WebServlet(name = "GetAssignmentStatsServlet", urlPatterns = {"/GetAssignmentStatsServlet"})
public class GetAssignmentStatsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String jobIdParam = request.getParameter("jobId");
            if (jobIdParam == null || jobIdParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Missing jobId");
            }

            int jobId = Integer.parseInt(jobIdParam);
            AssignmentDAO dao = new AssignmentDAO();
            int assigned = dao.countAssignedCandidates(jobId);
            int available = dao.countAvailableCandidates(jobId);

            response.setContentType("application/json");
            response.getWriter().write("{\"assigned\":" + assigned + ",\"available\":" + available + "}");
        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi trong server
            response.setStatus(500);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"" + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
