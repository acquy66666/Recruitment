/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.RecruiterDAO;
import com.recruitment.dao.TransactionDAO;
import com.recruitment.model.Recruiter;
import com.recruitment.model.Transaction;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author GBCenter
 */
@WebServlet(name = "RevenueReport", urlPatterns = {"/RevenueReport"})
public class RevenueReport extends HttpServlet {

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
            out.println("<title>Servlet RevenueReport</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueReport at " + request.getContextPath() + "</h1>");
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
        try {
            TransactionDAO t = new TransactionDAO();
            RecruiterDAO r = new RecruiterDAO();

            int id = Integer.parseInt(request.getParameter("recruiterID"));
            Recruiter recruiter = r.getRecruiterById(id);
            int rangeMonths = parseIntOrDefault(request.getParameter("rangeMonths"), 3);
            Map<String, Double> revenueMap = t.getMonthlyRevenueByRecruiter(id, rangeMonths);
            Map<String, Double> monthlyReport = t.getMonthlyComparisonReport(id);
            List<String> monthLabels = new ArrayList<>(revenueMap.keySet());
            List<Double> monthlyRevenue = new ArrayList<>(revenueMap.values());

            String time = request.getParameter("time");
            if (time == null || time.isEmpty()) {
                time = "all"; // Default: Tất cả
            }

            String payMethod = request.getParameter("payMethod");
            if (payMethod == null || payMethod.isEmpty()) {
                payMethod = "all"; // Default: Tất cả
            }

            String sortPrice = request.getParameter("sortPrice");
            if (sortPrice == null || sortPrice.isEmpty()) {
                sortPrice = "desc"; // Default: Giảm dần
            }

            String sortDate = request.getParameter("sortDate");
            if (sortDate == null || sortDate.isEmpty()) {
                sortDate = "desc"; // Default: Mới nhất
            }

            int top = parseIntOrDefault(request.getParameter("pageSize"), 10); // Default: 10 records per page
            int pageIndex = parseIntOrDefault(request.getParameter("page"), 1); // Optional, default to page 1
            List<Transaction> list = t.getFilteredTransactionsByRecruiter(id, payMethod, time, sortDate, sortPrice, top, pageIndex);
            int totalRecords = t.countFilteredTransactionsByRecruiter(id, time, payMethod);
            int totalPages = (int) Math.ceil((double) totalRecords / top);
            if (pageIndex < 1) {
                pageIndex = 1;
            } else if (pageIndex > totalPages && totalPages > 0) {
                pageIndex = totalPages;
            }
            List<String> payments = t.getAllPaymentMethods();

            request.setAttribute("time", time);
            request.setAttribute("payMethod", payMethod);
            request.setAttribute("sortPrice", sortPrice);
            request.setAttribute("sortDate", sortDate);
            request.setAttribute("pageSize", top);
            request.setAttribute("pageIndex", pageIndex);
            request.setAttribute("recruiter", recruiter);
            request.setAttribute("list", list);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("payments", payments);
            request.setAttribute("monthLabels", monthLabels);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("rangeMonths", rangeMonths);
            request.setAttribute("monthlyReport", monthlyReport);

            response.getWriter().print(monthlyReport.isEmpty());
            request.getRequestDispatcher("RevenueReport.jsp").forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(RevenueReport.class.getName()).log(Level.SEVERE, null, ex);
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
        doGet(request, response);
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
