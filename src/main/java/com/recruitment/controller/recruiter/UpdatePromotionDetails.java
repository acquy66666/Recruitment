/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.JobAdvertisementDAO;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Date;

/**
 *
 * @author GBCenter
 */
@WebServlet(name = "UpdatePromotionDetails", urlPatterns = {"/UpdatePromotionDetails"})
public class UpdatePromotionDetails extends HttpServlet {

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
            out.println("<title>Servlet UpdatePromotionDetails</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePromotionDetails at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Recruiter rec = (Recruiter) request.getSession().getAttribute("Recruiter");
        int recruiterId = (rec != null) ? rec.getRecruiterId() : 0;

        String jobIdStr = request.getParameter("jobId");
        String description = request.getParameter("description");
        String startDateStr = request.getParameter("startDate");

        int jobId = 0;
        try {
            jobId = Integer.parseInt(jobIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID công việc không hợp lệ.");
            response.sendRedirect("CreatePromotionRequest");
            return;
        }

        if (description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "Mô tả không được để trống.");
            response.sendRedirect("CreatePromotionRequest");
            return;
        }

        LocalDate startDate = null;
        LocalDate endDate = null;
        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = LocalDate.parse(startDateStr); // Format: yyyy-MM-dd
                endDate = startDate.plusDays(30);
            } else {
                request.setAttribute("error", "Ngày bắt đầu không được để trống.");
                response.sendRedirect("CreatePromotionRequest");
                return;
            }
        } catch (DateTimeParseException e) {
            request.setAttribute("error", "Ngày bắt đầu không đúng định dạng.");
            response.sendRedirect("CreatePromotionRequest");
            return;
        }

        // Save to DB
        try {
            JobAdvertisementDAO ja = new JobAdvertisementDAO();
            ja.addAd(jobId, recruiterId, description, null, startDate, endDate);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể lưu đơn quảng cáo. Vui lòng thử lại sau.");
            response.sendRedirect("CreatePromotionRequest");
            return;
        }

        // Optional: Add success feedback
        request.setAttribute("success", "Đơn quảng cáo đã được tạo thành công.");
        response.sendRedirect("CreatePromotionRequest");
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
