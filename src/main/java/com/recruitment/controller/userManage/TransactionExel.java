/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.TransactionDAO;
import com.recruitment.model.TransactionReportDTO;
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

@WebServlet(name = "TransactionExel", urlPatterns = {"/TransactionExel"})
public class TransactionExel extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TransactionExel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TransactionExel at " + request.getContextPath() + "</h1>");
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
        String searchExel = request.getParameter("searchExel");
        String minTotalStr = request.getParameter("minTotal");
        String maxTotalStr = request.getParameter("maxTotal");
        String sortDate = request.getParameter("sortDate");
        String promotion = request.getParameter("promotion");
        String status = request.getParameter("status");

        String fromDateDayStr = request.getParameter("fromDateDayTransaction");
        String toDateDayStr = request.getParameter("toDateDayTransaction");

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
        BigDecimal minTotal = null;
        BigDecimal maxTotal = null;
        try {
            if (minTotalStr != null && !minTotalStr.trim().isEmpty()) {
                minTotal = new BigDecimal(minTotalStr.trim());
            }
            if (maxTotalStr != null && !maxTotalStr.trim().isEmpty()) {
                maxTotal = new BigDecimal(maxTotalStr.trim());
            }
        } catch (NumberFormatException e) {
            // Optional: xử lý lỗi parse
        }

        // Gọi DAO để lấy dữ liệu lọc
        List<TransactionReportDTO> filteredList = dao.getFilteredTransactionsNew(
                searchExel, minTotal, maxTotal, status, sortDate, promotion, fromDate, toDate
        );

        //Phan trang
        int numAll = filteredList.size();
// Đọc phần trăm hiển thị từ request
        String displayPercentStr = request.getParameter("displayPercent");
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
        var arr = dao.getListTransactionReportByPage(filteredList, start, end);
        session.setAttribute("filteredTransactions", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);

        // Set dữ liệu lọc vào session để dùng lại khi export
//        session.setAttribute("filteredTransactions", filteredList);
        session.setAttribute("searchExel", searchExel);
        session.setAttribute("minTotal", formatCurrency(minTotal));
        session.setAttribute("maxTotal", formatCurrency(maxTotal));
        session.setAttribute("status", status);
        session.setAttribute("sortDate", sortDate);
        session.setAttribute("promotion", promotion);
        session.setAttribute("displayPercent", displayPercent); // giữ lại để hiện ở frontend

        // Sau khi có danh sách `filteredList`
        BigDecimal totalUnitServiceTransaction = BigDecimal.ZERO;
        BigDecimal totalNetRevenueTransaction = BigDecimal.ZERO;
        int totalServiceTransaction = 0;

        for (TransactionReportDTO dto : arr) {
            totalUnitServiceTransaction = totalUnitServiceTransaction.add(dto.getUnitPrice());
            totalNetRevenueTransaction = totalNetRevenueTransaction.add(dto.getTotalPrice());
            totalServiceTransaction++; // Mỗi dòng là 1 dịch vụ => đếm số dịch vụ
        }

        session.setAttribute("totalServiceTransaction", totalServiceTransaction);
        session.setAttribute("totalUnitServiceTransaction", formatCurrency(totalUnitServiceTransaction));
        session.setAttribute("totalNetRevenueTransaction", formatCurrency(totalNetRevenueTransaction));

        session.setAttribute("fromDateDayTransaction", fromDateDayStr);
        session.setAttribute("toDateDayTransaction", toDateDayStr);
        // Điều hướng về trang hiển thị kết quả (hoặc chuyển sang export Excel)
        response.sendRedirect("ReportExportExel.jsp");
//        request.setAttribute("transactionList", filteredList);
//        request.getRequestDispatcher("admin_transaction_excel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        // Lấy dữ liệu từ form
        String searchExel = request.getParameter("searchExel");
        String minTotalStr = request.getParameter("minTotal");
        String maxTotalStr = request.getParameter("maxTotal");
        String sortDate = request.getParameter("sortDate");
        String promotion = request.getParameter("promotion");
        String status = request.getParameter("status");

        String fromDateDayStr = request.getParameter("fromDateDayTransaction");
        String toDateDayStr = request.getParameter("toDateDayTransaction");

        Date fromDate = null;
        Date toDate = null;
        String errorMessageDateTransaction = null;
        try {
            if (fromDateDayStr != null && !fromDateDayStr.trim().isEmpty()) {
                fromDate = java.sql.Date.valueOf(fromDateDayStr); // Yêu cầu định dạng yyyy-MM-dd
            }
            if (toDateDayStr != null && !toDateDayStr.trim().isEmpty()) {
                toDate = java.sql.Date.valueOf(toDateDayStr);
            }
            // ✅ Kiểm tra nếu ngày đến < ngày từ
            if (fromDate != null && toDate != null && toDate.before(fromDate)) {
                errorMessageDateTransaction = "Ngày đến phải lớn hơn hoặc bằng ngày bắt đầu.";
            }
        } catch (IllegalArgumentException e) {
            // Ghi log hoặc set errorMessage nếu cần
            errorMessageDateTransaction = "Vui lòng nhập đúng định dạng ngày (yyyy-MM-dd).";
        }

        // Parse dữ liệu
        BigDecimal minTotal = null;
        BigDecimal maxTotal = null;
        String errorMessage = null;
        try {
            if (minTotalStr != null && !minTotalStr.trim().isEmpty()) {
                minTotal = new BigDecimal(minTotalStr.trim().replaceAll("\\.", ""));
            }
            if (maxTotalStr != null && !maxTotalStr.trim().isEmpty()) {
                maxTotal = new BigDecimal(maxTotalStr.trim().replaceAll("\\.", ""));
            }
            // ❌ Kiểm tra nếu max < min
            if (minTotal != null && maxTotal != null && maxTotal.compareTo(minTotal) < 0) {
                errorMessage = "Giá trị 'Tổng tiền đến' phải lớn hơn hoặc bằng 'Tổng tiền từ'.";
            }
        } catch (NumberFormatException e) {
            errorMessage = "Vui lòng nhập đúng định dạng số tiền (chỉ chứa số hoặc dấu chấm).";
        }
        if (errorMessage != null || errorMessageDateTransaction != null) {
            session.setAttribute("errorMessageDateTransaction", errorMessageDateTransaction);
            session.setAttribute("errorMessage", errorMessage);

            // Format lại để giữ nguyên hiển thị dữ liệu
            session.setAttribute("fromDateDayTransaction", fromDateDayStr);
            session.setAttribute("toDateDayTransaction", toDateDayStr);

            session.setAttribute("searchExel", searchExel);
            session.setAttribute("minTotal", formatCurrency(minTotal));
            session.setAttribute("maxTotal", formatCurrency(maxTotal));
            session.setAttribute("status", status);
            session.setAttribute("sortDate", sortDate);
            session.setAttribute("promotion", promotion);
            response.sendRedirect("ReportExportExel.jsp");
            return;
        }
        // Gọi DAO để lấy dữ liệu lọc
        List<TransactionReportDTO> filteredList = dao.getFilteredTransactionsNew(
                searchExel, minTotal, maxTotal, status, sortDate, promotion, fromDate, toDate
        );
//        try {
//            PrintWriter out = response.getWriter();
//            out.println("Gọi được servlet rồi");
//            List<TransactionReportDTO> list = dao.getFilteredTransactions(
//                    searchExel, minTotal, maxTotal, status, sortDate, promotion
//            );
//            out.println("Số bản ghi: " + list.size());
//            out.println("searchExel: " + searchExel);
//            out.println("minTotal: " + minTotal);
//            out.println("maxTotal: " + maxTotal);
//            out.println("status: " + status);
//            out.println("sortDate: " + sortDate);
//            out.println("promotion: " + promotion);
//            for (TransactionReportDTO dto : list) {
//                out.println(dto.toString());
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        //Phan trang
        int numAll = filteredList.size();

        // Đọc phần trăm hiển thị từ request
        String displayPercentStr = request.getParameter("displayPercent");
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

        var arr = dao.getListTransactionReportByPage(filteredList, start, end);
        session.setAttribute("filteredTransactions", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);

        // Set dữ liệu lọc vào session để dùng lại khi export
        session.setAttribute("searchExel", searchExel);
        session.setAttribute("minTotal", formatCurrency(minTotal));
        session.setAttribute("maxTotal", formatCurrency(maxTotal));
        session.setAttribute("status", status);
        session.setAttribute("sortDate", sortDate);
        session.setAttribute("promotion", promotion);
        session.setAttribute("displayPercent", displayPercent); // giữ lại để hiện ở frontend

        // Sau khi có danh sách `filteredList`
        BigDecimal totalUnitServiceTransaction = BigDecimal.ZERO;
        BigDecimal totalNetRevenueTransaction = BigDecimal.ZERO;
        int totalServiceTransaction = 0;

        for (TransactionReportDTO dto : arr) {
            totalUnitServiceTransaction = totalUnitServiceTransaction.add(dto.getUnitPrice());
            totalNetRevenueTransaction = totalNetRevenueTransaction.add(dto.getTotalPrice());
            totalServiceTransaction++; // Mỗi dòng là 1 dịch vụ => đếm số dịch vụ
        }

        session.setAttribute("totalServiceTransaction", totalServiceTransaction);
        session.setAttribute("totalUnitServiceTransaction", formatCurrency(totalUnitServiceTransaction));
        session.setAttribute("totalNetRevenueTransaction", formatCurrency(totalNetRevenueTransaction));

        session.setAttribute("fromDateDayTransaction", fromDateDayStr);
        session.setAttribute("toDateDayTransaction", toDateDayStr);

        // Điều hướng về trang hiển thị kết quả (hoặc chuyển sang export Excel)
        response.sendRedirect("ReportExportExel.jsp");
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
    }

}

//Set<String> uniqueServices = new HashSet<>();
//BigDecimal totalUnitPrice = BigDecimal.ZERO;
//BigDecimal totalNetRevenue = BigDecimal.ZERO;
//
//for (TransactionReportDTO dto : arr) {
//    uniqueServices.add(dto.getServiceTitle()); // loại trùng
//    totalUnitPrice = totalUnitPrice.add(dto.getUnitPrice());
//    totalNetRevenue = totalNetRevenue.add(dto.getTotalPrice());
//}
//
//int serviceCount = uniqueServices.size();
//
//session.setAttribute("totalServiceTransaction", serviceCount);
//session.setAttribute("totalUnitServiceTransaction", formatCurrency(totalUnitPrice));
//session.setAttribute("totalNetRevenueTransaction", formatCurrency(totalNetRevenue));
