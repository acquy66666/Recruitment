/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.AdminStatisticsDAO;
import com.recruitment.model.TopStatDTO;
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
import java.util.List;
import java.util.Map;

@WebServlet(name = "UserStatistics", urlPatterns = {"/UserStatistics"})
public class UserStatistics extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserStatistics</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserStatistics at " + request.getContextPath() + "</h1>");
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

        int totalRecruiters = dao.getTotalRecruiters();
        int totalCandidates = dao.getTotalCandidates();
        int totalActive = dao.getTotalActiveAccounts();
        int totalInactive = dao.getTotalInactiveAccounts();
        List<TopStatDTO> getTop5CandidatesByApplications = dao.getTop5CandidatesByApplications();
        List<TopStatDTO> getTop5RecruitersByJobPosts = dao.getTop5RecruitersByJobPosts();

        String fromDate = request.getParameter("fromDateUser");
        String toDate = request.getParameter("toDateUser");
        String jobSeekerOrder = request.getParameter("jobSeekerOrder");
        String recruiterOrder = request.getParameter("recruiterOrder");
        String registrationOrder = request.getParameter("registrationOrder");

        if (!isValidDateRange(fromDate, toDate)) {
            session.setAttribute("errorUserStatistic", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("fromDateUser", fromDate);
            session.setAttribute("toDateUser", toDate);
            response.sendRedirect("UserStatistics.jsp");
            return;
        }

        // Gọi các DAO để lấy dữ liệu đã lọc
        Map<String, Integer> jobSeekerGrowth = dao.getJobSeekerGrowthByMonth(fromDate, toDate, jobSeekerOrder);
        Map<String, Integer> recruiterGrowth = dao.getRecruiterGrowthByMonth(fromDate, toDate, recruiterOrder);
        Map<String, Integer> genderDistribution = dao.getUserGenderDistribution(fromDate, toDate);
        Map<String, Integer> registrationByMonth = dao.getUserRegistrationByMonth(fromDate, toDate, registrationOrder);

        // Lưu dữ liệu vào session
        session.setAttribute("jobSeekerGrowth", jobSeekerGrowth);
        session.setAttribute("recruiterGrowth", recruiterGrowth);
        session.setAttribute("genderDistribution", genderDistribution);
        session.setAttribute("registrationByMonth", registrationByMonth);
        session.setAttribute("totalCandidates", totalCandidates);
        session.setAttribute("totalRecruiters", totalRecruiters);
        session.setAttribute("totalActive", totalActive);
        session.setAttribute("totalInactive", totalInactive);

        session.setAttribute("getTop5CandidatesByApplications", getTop5CandidatesByApplications);
        session.setAttribute("getTop5RecruitersByJobPosts", getTop5RecruitersByJobPosts);

        session.removeAttribute("fromDateUser");
        session.removeAttribute("toDateUser");
        session.removeAttribute("jobSeekerOrder");
        session.removeAttribute("recruiterOrder");
        session.removeAttribute("registrationOrder");
        session.removeAttribute("currentTab");

        response.sendRedirect("UserStatistics.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String fromDate = request.getParameter("fromDateUser");
        String toDate = request.getParameter("toDateUser");
        String jobSeekerOrder = request.getParameter("jobSeekerOrder");
        String recruiterOrder = request.getParameter("recruiterOrder");
        String registrationOrder = request.getParameter("registrationOrder");

        if (!isValidDateRange(fromDate, toDate)) {
            session.setAttribute("errorUserStatistic", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("fromDateUser", fromDate);
            session.setAttribute("toDateUser", toDate);
            session.setAttribute("jobSeekerOrder", jobSeekerOrder);
            session.setAttribute("recruiterOrder", recruiterOrder);
            session.setAttribute("registrationOrder", registrationOrder);
            response.sendRedirect("UserStatistics.jsp");
            return;
        }
// Gọi các DAO để lấy dữ liệu đã lọc
        Map<String, Integer> jobSeekerGrowth = dao.getJobSeekerGrowthByMonth(fromDate, toDate, jobSeekerOrder);
        Map<String, Integer> recruiterGrowth = dao.getRecruiterGrowthByMonth(fromDate, toDate, recruiterOrder);
        Map<String, Integer> genderDistribution = dao.getUserGenderDistribution(fromDate, toDate);
        Map<String, Integer> registrationByMonth = dao.getUserRegistrationByMonth(fromDate, toDate, registrationOrder);

// Đưa vào session để hiển thị lại
        session.setAttribute("jobSeekerGrowth", jobSeekerGrowth);
        session.setAttribute("recruiterGrowth", recruiterGrowth);
        session.setAttribute("registrationByMonth", registrationByMonth);
        session.setAttribute("genderDistribution", genderDistribution);

        session.setAttribute("fromDateUser", fromDate);
        session.setAttribute("toDateUser", toDate);
        session.setAttribute("jobSeekerOrder", jobSeekerOrder);
        session.setAttribute("recruiterOrder", recruiterOrder);
        session.setAttribute("registrationOrder", registrationOrder);

        response.sendRedirect("UserStatistics.jsp");
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
