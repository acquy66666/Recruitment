/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.dao.CvTemplateDAO;
import com.recruitment.model.Candidate;
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
@WebServlet(name = "DeleteCVTemplate", urlPatterns = {"/DeleteCVTemplate"})
public class DeleteCVTemplate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }

        int cvId = Integer.parseInt(request.getParameter("cvId"));
        int candidateId = candidate.getCandidateId();

        CvTemplateDAO dao = new CvTemplateDAO();
        boolean deleted = dao.deleteCVTemplateByIdAndCandidate(cvId, candidateId);

        if (deleted) {
            request.setAttribute("successMessage", "Xóa CV thành công.");
        } else {
            request.setAttribute("errorMessage", "Không thể xóa CV trong database.");
        }
        response.sendRedirect("CandidateProfile");
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
