/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.TransactionDAO;
import com.recruitment.model.RevenueByMonthDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Date;
import java.util.List;

@WebServlet(name = "RevenueExel2", urlPatterns = {"/RevenueExel2"})
public class RevenueExel2 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RevenueExel2</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueExel2 at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private TransactionDAO dao = new TransactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // Lấy dữ liệu từ form
        String fromDateDayStr = request.getParameter("fromDateDay");
        String toDateDayStr = request.getParameter("toDateDay");
        String minRevenueStr = request.getParameter("minRevenueDay");
        String maxRevenueStr = request.getParameter("maxRevenueDay");
        String promotionRevenue = request.getParameter("promotionRevenueDay");
        String sortByRevenue = request.getParameter("sortByRevenueDay");

        Date fromDate = null;
        Date toDate = null;
        try {
            if (fromDateDayStr != null && !fromDateDayStr.trim().isEmpty()) {
                fromDate = java.sql.Date.valueOf(fromDateDayStr); // Yêu cầu định dạng yyyy-MM-dd
            }
            if (toDateDayStr != null && !toDateDayStr.trim().isEmpty()) {
                toDate = java.sql.Date.valueOf(toDateDayStr);
            }
        } catch (IllegalArgumentException e) {
            // Ghi log hoặc set errorMessage nếu cần
            e.printStackTrace();
        }
        // Parse dữ liệu
        BigDecimal minRevenue = null;
        BigDecimal maxRevenue = null;
        try {
            if (minRevenueStr != null && !minRevenueStr.trim().isEmpty()) {
                minRevenue = new BigDecimal(minRevenueStr.trim());
            }
            if (maxRevenueStr != null && !maxRevenueStr.trim().isEmpty()) {
                maxRevenue = new BigDecimal(maxRevenueStr.trim());
            }
        } catch (NumberFormatException e) {
            // Optional: xử lý lỗi parse
        }
        // Gọi DAO để lấy dữ liệu lọc
        List<RevenueByMonthDTO> filteredList = dao.getFilteredRevenueByDateRange(
                fromDate, toDate, minRevenue, maxRevenue, promotionRevenue, sortByRevenue
        );

        //Phan trang
        int numAll = filteredList.size();
// Đọc phần trăm hiển thị từ request
        String displayPercentStr = request.getParameter("displayPercentRevenue");
        int displayPercent = 100;
        try {
            if (displayPercentStr != null && !displayPercentStr.trim().isEmpty()) {
                displayPercent = Integer.parseInt(displayPercentStr.trim());
            }
        } catch (NumberFormatException e) {
            displayPercent = 100;
        }

        int numPerPage = (numAll * displayPercent) / 100;
        numPerPage = Math.max(numPerPage, 1); // đảm bảo không bị 0

        int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
        int page;
        String tpage = request.getParameter("page");//Lay trang page so may hien tai
        try {
            page = Integer.parseInt(tpage);
        } catch (NumberFormatException e) {
            page = 1;
        }
        // Xác định vị trí bắt đầu và kết thúc
        int start = (page - 1) * numPerPage;
        int end = Math.min(page * numPerPage, numAll);
        List<RevenueByMonthDTO> pagedList = dao.getRevenueListByPage(filteredList, start, end);
//        List<String> availableMonths = dao.getAvailableRevenueMonths();
//        session.setAttribute("availableMonths", availableMonths);

        session.setAttribute("revenueListDay", pagedList);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);

        // Set dữ liệu lọc vào session để dùng lại khi export
//        session.setAttribute("filteredTransactions", filteredList);
        session.setAttribute("fromDateDay", fromDateDayStr);
        session.setAttribute("toDateDay", toDateDayStr);
        session.setAttribute("minRevenueDay", formatCurrency(minRevenue));
        session.setAttribute("maxRevenueDay", formatCurrency(maxRevenue));
        session.setAttribute("promotionRevenueDay", promotionRevenue);
        session.setAttribute("sortByRevenueDay", sortByRevenue);
        session.setAttribute("displayPercentRevenueDay", displayPercentStr);

        // Sau khi có danh sách `filteredList`
        BigDecimal totalBeforeDiscount = BigDecimal.ZERO;
        BigDecimal totalDiscount = BigDecimal.ZERO;
        BigDecimal totalNetRevenue = BigDecimal.ZERO;
        int totalTransaction = 0;
        int totalRecruiter = 0;
        int totalService = 0;

        for (RevenueByMonthDTO dto : filteredList) {
            totalTransaction += dto.getTransactionCount();
            totalRecruiter += dto.getRecruiterCount();
            totalService += dto.getTotalServiceCount();
            totalBeforeDiscount = totalBeforeDiscount.add(dto.getTotalBeforeDiscount());
            totalDiscount = totalDiscount.add(dto.getDiscountAmount());
            totalNetRevenue = totalNetRevenue.add(dto.getNetRevenue());
        }

        session.setAttribute("totalTransactionDay", totalTransaction);
        session.setAttribute("totalRecruiterDay", totalRecruiter);
        session.setAttribute("totalServiceDay", totalService);
        session.setAttribute("totalBeforeDiscountDay", formatCurrency(totalBeforeDiscount));
        session.setAttribute("totalDiscountDay", formatCurrency(totalDiscount));
        session.setAttribute("totalNetRevenueDay", formatCurrency(totalNetRevenue));

        // Điều hướng về trang hiển thị kết quả (hoặc chuyển sang export Excel)
        response.sendRedirect("ReportExportExel3.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        // Lấy dữ liệu từ form
        String fromDateDayStr = request.getParameter("fromDateDay");
        String toDateDayStr = request.getParameter("toDateDay");
        String minRevenueStr = request.getParameter("minRevenueDay");
        String maxRevenueStr = request.getParameter("maxRevenueDay");
        String promotionRevenue = request.getParameter("promotionRevenueDay");
        String sortByRevenue = request.getParameter("sortByRevenueDay");

        Date fromDate = null;
        Date toDate = null;
        String errorMessageDate = null;
        try {
            if (fromDateDayStr != null && !fromDateDayStr.trim().isEmpty()) {
                fromDate = java.sql.Date.valueOf(fromDateDayStr); // Yêu cầu định dạng yyyy-MM-dd
            }
            if (toDateDayStr != null && !toDateDayStr.trim().isEmpty()) {
                toDate = java.sql.Date.valueOf(toDateDayStr);
            }
            // ✅ Kiểm tra nếu ngày đến < ngày từ
            if (fromDate != null && toDate != null && toDate.before(fromDate)) {
                errorMessageDate = "Ngày đến phải lớn hơn hoặc bằng ngày bắt đầu.";
            }
        } catch (IllegalArgumentException e) {
            errorMessageDate = "Vui lòng nhập đúng định dạng ngày (yyyy-MM-dd).";
        }
        // Parse dữ liệu
        BigDecimal minRevenue = null;
        BigDecimal maxRevenue = null;
        String errorMessageRevenue = null;
        try {
            if (minRevenueStr != null && !minRevenueStr.trim().isEmpty()) {
                minRevenue = new BigDecimal(minRevenueStr.trim().replaceAll("\\.", ""));
            }
            if (maxRevenueStr != null && !maxRevenueStr.trim().isEmpty()) {
                maxRevenue = new BigDecimal(maxRevenueStr.trim().replaceAll("\\.", ""));
            }
            // ❌ Kiểm tra nếu max < min
            if (minRevenue != null && maxRevenue != null && maxRevenue.compareTo(minRevenue) < 0) {
                errorMessageRevenue = "Giá trị 'Tổng tiền đến' phải lớn hơn hoặc bằng 'Tổng tiền từ'.";
            }
        } catch (NumberFormatException e) {
            errorMessageRevenue = "Vui lòng nhập đúng định dạng số tiền (chỉ chứa số hoặc dấu chấm).";
        }
        if (errorMessageRevenue != null || errorMessageDate != null) {
            session.setAttribute("errorMessageRevenueDay", errorMessageRevenue);
            session.setAttribute("errorMessageDateDay", errorMessageDate);

            // Format lại dữ liệu đã nhập để giữ nguyên hiển thị
            session.setAttribute("fromDateDay", fromDateDayStr);
            session.setAttribute("toDateDay", toDateDayStr);
            session.setAttribute("minRevenueDay", formatCurrency(minRevenue));
            session.setAttribute("maxRevenueDay", formatCurrency(maxRevenue));
            session.setAttribute("sortByRevenueDay", sortByRevenue);
            session.setAttribute("promotionRevenueDay", promotionRevenue);

            response.sendRedirect("ReportExportExel3.jsp");
            return;
        }

        // In debug ra trình duyệt
//        out.println("<h3>=== DỮ LIỆU NHẬN TỪ FORM ===</h3>");
//        out.println("<p>searchMonth: " + searchMonth + "</p>");
//        out.println("<p>minRevenueStr: " + minRevenueStr + "</p>");
//        out.println("<p>maxRevenueStr: " + maxRevenueStr + "</p>");
//        out.println("<p>promotionRevenue: " + promotionRevenue + "</p>");
//        out.println("<p>sortByRevenue: " + sortByRevenue + "</p>");
//// In giá trị sau khi parse
//        out.println("<h3>=== GIÁ TRỊ SAU KHI PARSE ===</h3>");
//        out.println("<p>minRevenue: " + minRevenue + "</p>");
//        out.println("<p>maxRevenue: " + maxRevenue + "</p>");
//        // Gọi DAO để lấy dữ liệu lọc
        List<RevenueByMonthDTO> filteredList = dao.getFilteredRevenueByDateRange(
                fromDate, toDate, minRevenue, maxRevenue, promotionRevenue, sortByRevenue
        );

        //Phan trang
        int numAll = filteredList.size();
// Đọc phần trăm hiển thị từ request
        String displayPercentStr = request.getParameter("displayPercentRevenueDay");
        int displayPercent = 100;
        try {
            if (displayPercentStr != null && !displayPercentStr.trim().isEmpty()) {
                displayPercent = Integer.parseInt(displayPercentStr.trim());
            }
        } catch (NumberFormatException e) {
            displayPercent = 100;
        }

        int numPerPage = (numAll * displayPercent) / 100;
        numPerPage = Math.max(numPerPage, 1); // đảm bảo không bị 0

        int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
        int page;
        String tpage = request.getParameter("page");//Lay trang page so may hien tai
        try {
            page = Integer.parseInt(tpage);
        } catch (NumberFormatException e) {
            page = 1;
        }
        // Xác định vị trí bắt đầu và kết thúc
        int start = (page - 1) * numPerPage;
        int end = Math.min(page * numPerPage, numAll);
        List<RevenueByMonthDTO> pagedList = dao.getRevenueListByPage(filteredList, start, end);
        session.setAttribute("revenueListDay", pagedList);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);

        // Set dữ liệu lọc vào session để dùng lại khi export
//        session.setAttribute("filteredTransactions", filteredList);
        session.setAttribute("fromDateDay", fromDateDayStr);
        session.setAttribute("toDateDay", toDateDayStr);
        session.setAttribute("minRevenueDay", formatCurrency(minRevenue));
        session.setAttribute("maxRevenueDay", formatCurrency(maxRevenue));
        session.setAttribute("promotionRevenueDay", promotionRevenue);
        session.setAttribute("sortByRevenueDay", sortByRevenue);
        session.setAttribute("displayPercentRevenueDay", displayPercentStr);

        // Sau khi có danh sách `filteredList`
        BigDecimal totalBeforeDiscount = BigDecimal.ZERO;
        BigDecimal totalDiscount = BigDecimal.ZERO;
        BigDecimal totalNetRevenue = BigDecimal.ZERO;
        int totalTransaction = 0;
        int totalRecruiter = 0;
        int totalService = 0;

        for (RevenueByMonthDTO dto : pagedList) {
            totalTransaction += dto.getTransactionCount();
            totalRecruiter += dto.getRecruiterCount();
            totalService += dto.getTotalServiceCount();
            totalBeforeDiscount = totalBeforeDiscount.add(dto.getTotalBeforeDiscount());
            totalDiscount = totalDiscount.add(dto.getDiscountAmount());
            totalNetRevenue = totalNetRevenue.add(dto.getNetRevenue());
        }

        session.setAttribute("totalTransactionDay", totalTransaction);
        session.setAttribute("totalRecruiterDay", totalRecruiter);
        session.setAttribute("totalServiceDay", totalService);
        session.setAttribute("totalBeforeDiscountDay", formatCurrency(totalBeforeDiscount));
        session.setAttribute("totalDiscountDay", formatCurrency(totalDiscount));
        session.setAttribute("totalNetRevenueDay", formatCurrency(totalNetRevenue));

        // Điều hướng về trang hiển thị kết quả (hoặc chuyển sang export Excel)
        response.sendRedirect("ReportExportExel3.jsp");
    }

    public String formatCurrency(BigDecimal salary) {
        if (salary == null) {
            return "";
        }

        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        return df.format(salary);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
