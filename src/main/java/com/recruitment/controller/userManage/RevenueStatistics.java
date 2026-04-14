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
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name = "RevenueStatistics", urlPatterns = {"/RevenueStatistics"})
public class RevenueStatistics extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RevenueStatistics</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueStatistics at " + request.getContextPath() + "</h1>");
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

        BigDecimal totalRevenue = dao.getTotalRevenue(); // Tổng doanh thu toàn thời gian
        BigDecimal currentMonthRevenue = dao.getCurrentMonthRevenue(); // Doanh thu tháng hiện tại
        int currentMonthTransactions = dao.getCurrentMonthTransactionCount(); // Số giao dịch trong tháng
        int currentMonthTransactionsSuccess = dao.getCurrentMonthTransactionCountSuccess(); // Số giao dịch trong tháng thanh cong

        double revenueGrowthRate = dao.getRevenueGrowthRateComparedToLastMonth(); // % tăng trưởng doanh thu so với tháng trước
        double transactionGrowthRate = dao.getTransactionGrowthRateComparedToLastMonth(); // % tăng trưởng số giao dịch

        double transactionGrowthRateALL = dao.getTransactionGrowthRateComparedToLastMonthALL(); // % tăng trưởng số giao dịch

        BigDecimal avgRevenuePerMonth = dao.getAverageRevenuePerMonth(); // Doanh thu TB/tháng
        double avgTransactionPerDay = dao.getAverageTransactionCountPerDay(); // Giao dịch TB/ngày
        BigDecimal avgTransactionValue = dao.getAverageTransactionValue(); // Giá trị giao dịch TB

        List<TopStatDTO> top5RecruitersBySpending = dao.getTop5RecruitersBySpending(); // Top 5 nhà tuyển dụng chi nhiều nhất

        String fromDate = request.getParameter("fromDateRevenue");
        String toDate = request.getParameter("toDateRevenue");
        String revenueMonthOrder = request.getParameter("revenueMonthOrder");
        String revenueServiceOrder = request.getParameter("revenueServiceOrder");
        String transactionDayOrder = request.getParameter("transactionDayOrder");
        String topServiceOrder = request.getParameter("topServiceOrder");

        if (!isValidDateRange(fromDate, toDate)) {
            session.setAttribute("errorRevenueStatistic", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("fromDateRevenue", fromDate);
            session.setAttribute("toDateRevenue", toDate);
            response.sendRedirect("RevenueStatistics.jsp");
            return;
        }

        // Gọi các DAO để lấy dữ liệu đã lọc
        Map<String, Integer> revenueByMonthGrowth = dao.getRevenueByMonth(fromDate, toDate, revenueMonthOrder);
        Map<String, Integer> revenueByServiceGrowth = dao.getRevenueByService(fromDate, toDate, revenueServiceOrder);
        Map<String, Integer> transactionPerMonthGrowth = dao.getTransactionPerMonth(fromDate, toDate, transactionDayOrder);
        Map<String, Integer> topServicesGrowth = dao.getTopServices(fromDate, toDate, topServiceOrder);

        // Lưu dữ liệu vào session
        session.setAttribute("revenueByMonthGrowth", revenueByMonthGrowth);
        session.setAttribute("revenueByServiceGrowth", revenueByServiceGrowth);
        session.setAttribute("transactionPerMonthGrowth", transactionPerMonthGrowth);
        session.setAttribute("topServicesGrowth", topServicesGrowth);

        session.setAttribute("totalRevenue", totalRevenue);
        session.setAttribute("currentMonthRevenue", currentMonthRevenue);
        session.setAttribute("currentMonthTransactions", currentMonthTransactions);
        session.setAttribute("currentMonthTransactionsSuccess", currentMonthTransactionsSuccess);
        session.setAttribute("revenueGrowthRate", revenueGrowthRate);
        session.setAttribute("transactionGrowthRate", transactionGrowthRate);
        session.setAttribute("transactionGrowthRateALL", transactionGrowthRateALL);

        session.setAttribute("avgRevenuePerMonth", avgRevenuePerMonth);
        session.setAttribute("avgTransactionPerDay", avgTransactionPerDay);
        session.setAttribute("avgTransactionValue", avgTransactionValue);

        session.setAttribute("top5RecruitersBySpending", top5RecruitersBySpending);

        session.removeAttribute("fromDateRevenue");
        session.removeAttribute("toDateRevenue");
        session.removeAttribute("revenueMonthOrder");
        session.removeAttribute("revenueServiceOrder");
        session.removeAttribute("transactionDayOrder");
        session.removeAttribute("topServiceOrder");
        session.removeAttribute("currentTab");

        response.sendRedirect("RevenueStatistics.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String fromDate = request.getParameter("fromDateRevenue");
        String toDate = request.getParameter("toDateRevenue");
        String revenueMonthOrder = request.getParameter("revenueMonthOrder");
        String revenueServiceOrder = request.getParameter("revenueServiceOrder");
        String transactionDayOrder = request.getParameter("transactionDayOrder");
        String topServiceOrder = request.getParameter("topServiceOrder");

        if (!isValidDateRange(fromDate, toDate)) {
            session.setAttribute("errorRevenueStatistic", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("fromDateRevenue", fromDate);
            session.setAttribute("toDateRevenue", toDate);
            session.setAttribute("revenueMonthOrder", revenueMonthOrder);
            session.setAttribute("revenueServiceOrder", revenueServiceOrder);
            session.setAttribute("transactionDayOrder", transactionDayOrder);
            session.setAttribute("topServiceOrder", topServiceOrder);
            response.sendRedirect("RevenueStatistics.jsp");
            return;
        }
// Gọi các DAO để lấy dữ liệu đã lọc
        // Gọi các DAO để lấy dữ liệu đã lọc
        Map<String, Integer> revenueByMonthGrowth = dao.getRevenueByMonth(fromDate, toDate, revenueMonthOrder);
        Map<String, Integer> revenueByServiceGrowth = dao.getRevenueByService(fromDate, toDate, revenueServiceOrder);
        Map<String, Integer> transactionPerMonthGrowth = dao.getTransactionPerMonth(fromDate, toDate, transactionDayOrder);
        Map<String, Integer> topServicesGrowth = dao.getTopServices(fromDate, toDate, topServiceOrder);

// Đưa vào session để hiển thị lại
        session.setAttribute("revenueByMonthGrowth", revenueByMonthGrowth);
        session.setAttribute("revenueByServiceGrowth", revenueByServiceGrowth);
        session.setAttribute("transactionPerMonthGrowth", transactionPerMonthGrowth);
        session.setAttribute("topServicesGrowth", topServicesGrowth);

        session.setAttribute("fromDateRevenue", fromDate);
        session.setAttribute("toDateRevenue", toDate);
        session.setAttribute("revenueMonthOrder", revenueMonthOrder);
        session.setAttribute("revenueServiceOrder", revenueServiceOrder);
        session.setAttribute("transactionDayOrder", transactionDayOrder);
        session.setAttribute("topServiceOrder", topServiceOrder);

        response.sendRedirect("RevenueStatistics.jsp");
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
    }

}
