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
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "ExportTransactionExcel", urlPatterns = {"/ExportTransactionExcel"})
public class ExportTransactionExcel extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExportTransactionExcel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportTransactionExcel at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private TransactionDAO dao = new TransactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        PrintWriter out = response.getWriter();
        // Nhận tham số lọc từ form
        String search = request.getParameter("searchExel");
        String minStr = request.getParameter("minTotal");
        String maxStr = request.getParameter("maxTotal");
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

        BigDecimal minTotal = null, maxTotal = null;
        try {
            if (minStr != null && !minStr.trim().isEmpty()) {
                minTotal = new BigDecimal(minStr.trim().replaceAll("\\.", ""));
            }
            if (maxStr != null && !maxStr.trim().isEmpty()) {
                maxTotal = new BigDecimal(maxStr.trim().replaceAll("\\.", ""));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Có thể log nếu cần
        }
//        out.print("tim"+search);
//        out.print("min" + minStr);
//        out.print("max" +maxStr);
//
//        out.print("sort" +sortDate);
//        out.print("promo" +promotion);
//        out.print("status" +status);
        // Lấy dữ liệu đã lọc từ DAO
        List<TransactionReportDTO> transactions = dao.getFilteredTransactionsNew(search, minTotal, maxTotal, status, sortDate, promotion, fromDate, toDate);

        // Tạo workbook và sheet Excel
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Transaction Report");
        sheet.setColumnWidth(4, 20 * 256); // Cột đơn giá
        sheet.setColumnWidth(5, 20 * 256); // Cột tổng tiền
        sheet.setColumnWidth(6, 25 * 256); // Tổng tiền
        // Format kiểu tiền
        CellStyle currencyStyle = workbook.createCellStyle();
        DataFormat format = workbook.createDataFormat();
        currencyStyle.setDataFormat(format.getFormat("#,##0"));

        // Header
        String[] headers = {"STT", "Mã GD", "Nhà tuyển dụng", "Dịch vụ", "Đơn giá", "Khuyến mãi",
            "Tổng tiền", "Ngày thanh toán", "Phương thức", "Trạng thái"};

        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        // Ghi dữ liệu
        int rowNum = 1;
        int stt = 1;

        int totalServiceCount = 0;
        BigDecimal totalUnitPrice = BigDecimal.ZERO;
        BigDecimal totalRevenue = BigDecimal.ZERO;

        for (TransactionReportDTO dto : transactions) {
            Row row = sheet.createRow(rowNum++);

            row.createCell(0).setCellValue(stt++);
            row.createCell(1).setCellValue(dto.getTransactionId());
            row.createCell(2).setCellValue(dto.getCompanyName());
            row.createCell(3).setCellValue(dto.getServiceTitle());
            // Đơn giá (số thực + format tiền)
            Cell unitPriceCell = row.createCell(4);
            unitPriceCell.setCellValue(dto.getUnitPrice().doubleValue());
            unitPriceCell.setCellStyle(currencyStyle);

            row.createCell(5).setCellValue(dto.getPromotionTitle() != null ? dto.getPromotionTitle() : "Không");
            // Tổng tiền (số thực + format tiền)
            Cell totalPriceCell = row.createCell(6);
            totalPriceCell.setCellValue(dto.getTotalPrice().doubleValue());
            totalPriceCell.setCellStyle(currencyStyle);
            row.createCell(7).setCellValue(dto.getFormattedTransactionDate() != null ? dto.getFormattedTransactionDate() : "");
            row.createCell(8).setCellValue(dto.getPaymentMethod());
            row.createCell(9).setCellValue(dto.getLocalizedStatus());

            totalServiceCount++; // đếm mỗi gói dịch vụ, có trùng
            totalUnitPrice = totalUnitPrice.add(dto.getUnitPrice());
            totalRevenue = totalRevenue.add(dto.getTotalPrice());
        }

        Row totalRow = sheet.createRow(rowNum++);
        // Gộp từ cột A (0) đến C (2) để hiển thị chữ "TỔNG CỘNG"
        sheet.addMergedRegion(new CellRangeAddress(rowNum - 1, rowNum - 1, 0, 2));
        totalRow.createCell(0).setCellValue("TỔNG CỘNG");

// Cột D - Tổng số dịch vụ đã mua (kể cả trùng)
        totalRow.createCell(3).setCellValue(totalServiceCount);

// Cột E - Tổng đơn giá (unitPrice cộng dồn)
        Cell unitPriceCell = totalRow.createCell(4);
        unitPriceCell.setCellValue(totalUnitPrice.doubleValue());
        unitPriceCell.setCellStyle(currencyStyle);

// Cột F - Tổng doanh thu (totalPrice cộng dồn)
        Cell revenueCell = totalRow.createCell(6);
        revenueCell.setCellValue(totalRevenue.doubleValue());
        revenueCell.setCellStyle(currencyStyle);

        // Cấu hình phản hồi
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=transaction_report.xlsx");

        // Ghi file
        try (OutputStream os = response.getOutputStream()) {
            workbook.write(os);
            workbook.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
