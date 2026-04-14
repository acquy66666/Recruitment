/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.ServiceDAO;
import com.recruitment.dao.ServiceViewDAO;
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author GBCenter
 */
@WebServlet(name = "ViewServicePackage", urlPatterns = {"/ViewServicePackage"})
public class ViewServicePackage extends HttpServlet {

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
            out.println("<title>Servlet ViewServicePackage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewServicePackage at " + request.getContextPath() + "</h1>");
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
            Recruiter rec = (Recruiter) request.getSession().getAttribute("Recruiter");
            int id = rec.getRecruiterId();
            ServiceViewDAO dao = new ServiceViewDAO();
            ServiceDAO s = new ServiceDAO();
            // 🧩 Grab sorting/filtering parameters from request
            String type = request.getParameter("type"); 
            if (type == null || type.isEmpty()) {
                type = "all";
            }

            String sortBy = "count"; 

            String sortOrder = request.getParameter("sortOrder"); 
            if (sortOrder == null || sortOrder.isEmpty()) {
                sortOrder = "desc";
            }

            int top = parseIntOrDefault(request.getParameter("top"), 10); // items per page
            int pageIndex = parseIntOrDefault(request.getParameter("page"), 1); // page index
            List<ServiceViewDAO.ServiceView> list = dao.getFilteredServiceViewsByRecruiter(id, type, sortBy, sortOrder, top, pageIndex);
            List<String> sList = s.getAllServiceTypes();

            int totalRecords = dao.countAllServiceViewsByRecruiter(id, type);
            int totalPages = (int) Math.ceil((double) totalRecords / top);

            request.setAttribute("list", list);
            request.setAttribute("type", type);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("top", top);
            request.setAttribute("page", pageIndex);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("sList", sList);

            request.getRequestDispatcher("ViewServicePackage.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // optional: log to file
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý dữ liệu dịch vụ.");
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
