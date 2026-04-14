/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.CvDAO;
import com.recruitment.dto.AppliedCVInfoDTO;
import com.recruitment.model.Cv;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author hoang
 */
@WebServlet(name = "CVFilter", urlPatterns = {"/CVFilter"})
public class CVFilterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            response.sendRedirect("login");
            return;
        }

        CvDAO cvDAO = new CvDAO();

        String search = request.getParameter("search");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String edu = request.getParameter("edu");
        String skill = request.getParameter("skill");
        String workexpStr = request.getParameter("workexp");

        int pageIndex = 1;
        int pageSize = 10;

        String pageParam = request.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            pageIndex = Integer.parseInt(pageParam);
        }

        Integer workexp = null;
        if (workexpStr != null && !workexpStr.isBlank()) {
            try {
                workexp = Integer.parseInt(workexpStr);
            } catch (NumberFormatException e) {
                workexp = null;
            }
        }

        try {

            List<AppliedCVInfoDTO> resultList = cvDAO.searchAppliedCVInfo(search, address, gender, edu, skill, 
                    workexp, pageIndex, pageSize,recruiter.getRecruiterId());

            int totalRecords = cvDAO.countAppliedCVInfo(search, address, gender, edu, skill, workexp, recruiter.getRecruiterId());
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            int totalCount = cvDAO.countDistinctCandidatesByRecruiter(recruiter.getRecruiterId());
            int maleCount = cvDAO.countCandidatesByGender(recruiter.getRecruiterId(), "Male");
            int femaleCount = cvDAO.countCandidatesByGender(recruiter.getRecruiterId(), "Female");
            int otherCount = cvDAO.countCandidatesByGender(recruiter.getRecruiterId(), "Other");

            
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("maleCount", maleCount);
            request.setAttribute("femaleCount", femaleCount);
            request.setAttribute("otherCount", otherCount);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            request.setAttribute("gender", gender);
            request.setAttribute("address", address);
            request.setAttribute("edu", edu);
            request.setAttribute("skill", skill);
            request.setAttribute("workexp", workexp);
            request.setAttribute("page", pageIndex);
            request.setAttribute("resultList", resultList);

            request.getRequestDispatcher("CVFilter.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Lỗi truy vấn", e);
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
