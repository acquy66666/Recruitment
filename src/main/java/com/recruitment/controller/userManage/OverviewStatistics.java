/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.AdminStatisticsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Map;

@WebServlet(name = "OverviewStatistics", urlPatterns = {"/OverviewStatistics"})
public class OverviewStatistics extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OverviewStatistics</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OverviewStatistics at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private AdminStatisticsDAO dao = new AdminStatisticsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        int totalServices = dao.getTotalServices();
        int totalJobPosts = dao.getTotalJobPosts();
        int totalRecruiters = dao.getTotalRecruiters();
        int totalCandidates = dao.getTotalCandidates();

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String postOrder = request.getParameter("postOrder");
        String revenueOrder = request.getParameter("revenueOrder");

        Map<String, Integer> revenueData = dao.getRevenueByMonth(fromDate, toDate, revenueOrder);
        Map<String, Integer> jobPostMonthData = dao.getJobPostCountByMonth(fromDate, toDate, postOrder);
        Map<String, Integer> jobPostIndustryData = dao.getJobCountByIndustry(fromDate, toDate);

        session.setAttribute("revenueData", revenueData);
        session.setAttribute("jobPostMonthData", jobPostMonthData);
        session.setAttribute("jobPostIndustryData", jobPostIndustryData);
        session.setAttribute("totalCandidates", totalCandidates);
        session.setAttribute("totalRecruiters", totalRecruiters);
        session.setAttribute("totalJobPosts", totalJobPosts);
        session.setAttribute("totalServices", totalServices);

        session.removeAttribute("fromDate");
        session.removeAttribute("toDate");
        session.removeAttribute("postOrder");
        session.removeAttribute("revenueOrder");
        session.removeAttribute("currentTab");
        response.sendRedirect("OverviewStatistics.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String postOrder = request.getParameter("postOrder");
        String revenueOrder = request.getParameter("revenueOrder");

        if (!isValidDateRange(fromDate, toDate)) {
            session.setAttribute("errorOverview", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("fromDate", fromDate);
            session.setAttribute("toDate", toDate);
            session.setAttribute("postOrder", postOrder);
            session.setAttribute("revenueOrder", revenueOrder);
            response.sendRedirect("OverviewStatistics.jsp");
            return;
        }
        Map<String, Integer> revenueData = dao.getRevenueByMonth(fromDate, toDate, revenueOrder);
        Map<String, Integer> jobPostMonthData = dao.getJobPostCountByMonth(fromDate, toDate, postOrder);
        Map<String, Integer> jobPostIndustryData = dao.getJobCountByIndustry(fromDate, toDate);

        session.setAttribute("revenueData", revenueData);
        session.setAttribute("jobPostMonthData", jobPostMonthData);
        session.setAttribute("jobPostIndustryData", jobPostIndustryData);

        session.setAttribute("postOrder", postOrder);
        session.setAttribute("revenueOrder", revenueOrder);
        session.setAttribute("fromDate", fromDate);
        session.setAttribute("toDate", toDate);
        response.sendRedirect("OverviewStatistics.jsp");

    }

    private boolean isValidDateRange(String fromDateStr, String toDateStr) {
        if (fromDateStr == null || toDateStr == null
                || fromDateStr.isEmpty() || toDateStr.isEmpty()) {
            return true; // Nếu thiếu 1 trong 2 ngày thì không kiểm tra (hợp lệ)
        }

        try {
            LocalDate fromDate = LocalDate.parse(fromDateStr);
            LocalDate toDate = LocalDate.parse(toDateStr);
            return !toDate.isBefore(fromDate); // trả về true nếu toDate >= fromDate
        } catch (DateTimeParseException e) {
            return false; // định dạng ngày không hợp lệ
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
