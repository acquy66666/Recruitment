/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.PromotionDAO;
import com.recruitment.model.Promotion;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author GBCenter
 */
@WebServlet(name = "ViewPromotion", urlPatterns = {"/ViewPromotion"})
public class ViewPromotion extends HttpServlet {

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
            out.println("<title>Servlet ViewPromotion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewPromotion at " + request.getContextPath() + "</h1>");
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
        try {
            PromotionDAO p = new PromotionDAO();
            String endDate = request.getParameter("endDate");
            if (endDate == null || endDate.isEmpty()) {
                endDate = "asc";
            }
            String discount = request.getParameter("discount");
            if (discount == null || discount.isEmpty()) {
                discount = "desc";
            }
            String maxDiscount = request.getParameter("maxDiscount");
            if (maxDiscount == null || maxDiscount.isEmpty()) {
                maxDiscount = "desc";
            }
            String remaining = request.getParameter("remaining");
            if (remaining == null || remaining.isEmpty()) {
                remaining = "asc";
            }
            String type = request.getParameter("type");
            if (type == null || type.isEmpty()) {
                type = "all";
            }
            int top = parseIntOrDefault(request.getParameter("top"), 10); // Default: 10 records per page
            int pageIndex = parseIntOrDefault(request.getParameter("page"), 1); // Optional, default to page 1
            int totalPromotions = p.countFilteredPromotions(type); // or include more filters
            int totalPages = (int) Math.ceil((double) totalPromotions / top);
            List<Promotion> list = p.getSortedActivePromotions(type, endDate, discount, maxDiscount, remaining, top, pageIndex);
            List<String> proList = p.getAllPromotionType();
            request.setAttribute("list", list);
            request.setAttribute("endDate", endDate);
            request.setAttribute("discount", discount);
            request.setAttribute("maxDiscount", maxDiscount);
            request.setAttribute("remaining", remaining);
            request.setAttribute("top", top);
            request.setAttribute("page", pageIndex);
            request.setAttribute("proList", proList);
            request.setAttribute("type", type);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("ViewPromotion.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewPromotion.class.getName()).log(Level.SEVERE, null, ex);
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
