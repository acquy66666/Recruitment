/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.Industry;
import com.recruitment.model.JobAdvertisement;
import com.recruitment.model.JobPost;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author GBCenter
 */
@WebServlet(name = "CreatePromotionRequest", urlPatterns = {"/CreatePromotionRequest"})
public class CreatePromotionRequest extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreatePromotionRequest</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreatePromotionRequest at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
            Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

            if (recruiter == null) {
                response.sendRedirect("login");
                return;
            }
        
        Recruiter rec = (Recruiter) request.getSession().getAttribute("Recruiter");
        String id = String.valueOf(rec.getRecruiterId());
        JobPostingPageDAO j = new JobPostingPageDAO();
        List<Industry> iList = j.selectAllIndustry();
        List<String> tList = j.getAllJobType();
        int page = 1;
        int pageSize = 10;
        int minSalary = 0;
        int maxSalary = Integer.MAX_VALUE;
        String minStr = request.getParameter("minSalary");
        String maxStr = request.getParameter("maxSalary");
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            page = 1;
        }
        try {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        } catch (NumberFormatException e) {
            pageSize = 10;
        }
        try {
            minSalary = Integer.parseInt(minStr);
        } catch (NumberFormatException e) {
            minSalary = 0;
        }
        try {
            maxSalary = Integer.parseInt(maxStr);
        } catch (NumberFormatException e) {
            maxSalary = Integer.MAX_VALUE;
        }
        String jobName = request.getParameter("jobName");
        String industry = request.getParameter("industry");
        String jobType = request.getParameter("jobType");
        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        LocalDate fromDate = (fromDateStr != null && !fromDateStr.isEmpty()) ? LocalDate.parse(fromDateStr) : null;
        LocalDate toDate = (toDateStr != null && !toDateStr.isEmpty()) ? LocalDate.parse(toDateStr) : null;
        List<JobPost> list = j.getAllFilteredAvailableJob(id, jobName, industry, jobType, minSalary, maxSalary, fromDate, toDate, page, pageSize);
        int totalRecords = j.countFilteredAvailableJobs(id, jobName, industry, jobType, minSalary, maxSalary, fromDate, toDate);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("jobName", jobName);
        request.setAttribute("industry", industry);
        request.setAttribute("jobType", jobType);
        request.setAttribute("fromDate", fromDateStr);
        request.setAttribute("toDate", toDateStr);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("total", totalRecords);
        request.setAttribute("tList", tList);
        request.setAttribute("iList", iList);
        request.setAttribute("maxSalary", maxStr);
        request.setAttribute("minSalary", minStr);
        request.getRequestDispatcher("CreatePromotionRequest.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
