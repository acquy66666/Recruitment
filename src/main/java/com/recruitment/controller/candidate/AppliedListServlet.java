/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.dao.AppliedJobDAO;
import com.recruitment.dao.AppliedJobDAO.AppliedJob;
import com.recruitment.model.Candidate;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

/**
 *
 * @author GBCenter
 */
@WebServlet(name = "AppliedListServlet", urlPatterns = {"/AppliedListPage"})
public class AppliedListServlet extends HttpServlet {

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
            out.println("<title>Servlet AppliedListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AppliedListServlet at " + request.getContextPath() + "</h1>");
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
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            Candidate c = (Candidate) request.getSession().getAttribute("Candidate");
            int userId = c.getCandidateId();
            String status = Optional.ofNullable(request.getParameter("status")).orElse("All");
            String timeStr = Optional.ofNullable(request.getParameter("time")).orElse("All");
            String keyword = Optional.ofNullable(request.getParameter("keyword")).orElse("");
            int daysBack = timeStr.equalsIgnoreCase("All") ? 0 : parseIntOrDefault(timeStr, 0);

            int top = parseIntOrDefault(request.getParameter("top"), 10);
            int pageIndex = parseIntOrDefault(request.getParameter("page"), 1);

            AppliedJobDAO appDao = new AppliedJobDAO();
            List<AppliedJob> appliedJobs = appDao.getFilteredAppliedJobs(
                    userId, status, daysBack, keyword, top, pageIndex
            );

            int totalRecords = appDao.countFilteredAppliedJobs(userId, status, daysBack, keyword);
            int totalPages = (int) Math.ceil((double) totalRecords / top);

            request.setAttribute("data", appliedJobs);
            request.setAttribute("status", status);
            request.setAttribute("time", timeStr);
            request.setAttribute("keyword", keyword);
            request.setAttribute("top", top);
            request.setAttribute("page", pageIndex);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("result", totalRecords);

            request.getRequestDispatcher("AppliedListPage.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý danh sách ứng tuyển.");
        }
    }

    private int parseIntOrDefault(String value, int defaultVal) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultVal;
        }
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
