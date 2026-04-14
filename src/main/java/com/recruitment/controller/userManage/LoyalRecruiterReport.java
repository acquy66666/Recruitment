/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.RecruiterDAO;
import com.recruitment.dao.RecruiterReportDAO;
import com.recruitment.dao.RecruiterReportDAO.RecruiterReport;
import com.recruitment.dao.TransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author GBCenter
 */
@WebServlet(name = "LoyalRecruiterReport", urlPatterns = {"/LoyalRecruiterReport"})
public class LoyalRecruiterReport extends HttpServlet {

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
            out.println("<title>Servlet LoyalRecruiterReport</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoyalRecruiterReport at " + request.getContextPath() + "</h1>");
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

        RecruiterReportDAO r = new RecruiterReportDAO();

        String topParam = request.getParameter("top");
        String time = request.getParameter("time");
        String pageParam = request.getParameter("page");

        int top = 5;
        if (topParam != null) {
            try {
                top = Integer.parseInt(topParam);
            } catch (NumberFormatException e) {
                /* log */ }
        }

        int currentPage = 1;
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                /* log */ }
        }

        int totalRecords = r.countRecruitersByTime(time); // Add this method to DAO!
        int totalPages = (int) Math.ceil((double) totalRecords / top);

        List<RecruiterReport> list = r.getTopTransactionReport(currentPage, top, time);
        int previousPage = Math.max(currentPage - 1, 1);
        int nextPage = Math.min(currentPage + 1, totalPages);
        request.setAttribute("previousPage", previousPage);
        request.setAttribute("nextPage", nextPage);
        request.setAttribute("list", list);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("top", top);
        request.setAttribute("time", time);

        request.getRequestDispatcher("LoyalRecruiterReport.jsp").forward(request, response);
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
