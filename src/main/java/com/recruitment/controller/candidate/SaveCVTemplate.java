/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.dao.CvTemplateDAO;
import com.recruitment.model.Candidate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "CVTemplate", urlPatterns = {"/CVTemplate"})
public class SaveCVTemplate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }
        
        request.setAttribute("candidateId", candidate.getCandidateId());
        request.getRequestDispatcher("createCV.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }

        String candidateIdStr = request.getParameter("candidateId");
        String title = request.getParameter("title");
        String html = request.getParameter("htmlContent");

        if (candidateIdStr == null || title == null || html == null
                || title.trim().isEmpty() || html.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu dữ liệu bắt buộc");
            return;
        }

        int candidateId;
        try {
            candidateId = Integer.parseInt(candidateIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "candidateId không hợp lệ");
            return;
        }

        CvTemplateDAO dao = new CvTemplateDAO();
        try {
            dao.insert(candidateId, title.trim(), html);
        } catch (Exception e) {
            throw new ServletException("Lỗi khi lưu CV vào DB", e);
        }

        // Chuyển hướng sau khi lưu thành công
        response.sendRedirect(request.getContextPath() + "/CandidateProfile");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
