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
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.List;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "ExportRevenueExel", urlPatterns = {"/ExportRevenueExel"})
public class ExportRevenueExel extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExportRevenueExel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportRevenueExel at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    private TransactionDAO dao = new TransactionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nhận dữ liệu lọc từ request
        String searchMonth = request.getParameter("searchMonth");
        String minRevenueStr = request.getParameter("minRevenue");
        String maxRevenueStr = request.getParameter("maxRevenue");
        String promotionRevenue = request.getParameter("promotionRevenue");
        String sortByRevenue = request.getParameter("sortByRevenue");

        BigDecimal minRevenue = null, maxRevenue = null;
        try {
            if (minRevenueStr != null && !minRevenueStr.trim().isEmpty()) {
                minRevenue = new BigDecimal(minRevenueStr.trim().replaceAll("\\.", ""));
            }
            if (maxRevenueStr != null && !maxRevenueStr.trim().isEmpty()) {
                maxRevenue = new BigDecimal(maxRevenueStr.trim().replaceAll("\\.", ""));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Gọi DAO để lấy dữ liệu đã lọc
        List<RevenueByMonthDTO> revenueList = dao.getFilteredRevenueByMonth(
                searchMonth, minRevenue, maxRevenue, promotionRevenue, sortByRevenue
        );

        // Tạo workbook và sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Revenue Report");

        // Format tiền
        CellStyle currencyStyle = workbook.createCellStyle();
        DataFormat format = workbook.createDataFormat();
        currencyStyle.setDataFormat(format.getFormat("#,##0"));

        // Header
        String[] headers = {"STT", "Tháng", "Số giao dịch", "Số nhà tuyển dụng", "Tổng số gói dịch vụ",
            "Tổng trước KM", "Giảm giá", "Doanh thu thuần"};

        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        // Ghi dữ liệu
        int rowNum = 1;
        int stt = 1;

        int totalTransactions = 0;
        int totalRecruiters = 0;
        int totalServices = 0;
        BigDecimal sumBeforeDiscount = BigDecimal.ZERO;
        BigDecimal sumDiscount = BigDecimal.ZERO;
        BigDecimal sumNetRevenue = BigDecimal.ZERO;

        for (RevenueByMonthDTO dto : revenueList) {
            Row row = sheet.createRow(rowNum++);

            row.createCell(0).setCellValue(stt++);
            row.createCell(1).setCellValue(dto.getMonth());
            row.createCell(2).setCellValue(dto.getTransactionCount());
            row.createCell(3).setCellValue(dto.getRecruiterCount());
            row.createCell(4).setCellValue(dto.getTotalServiceCount());

            Cell beforeDiscountCell = row.createCell(5);
            beforeDiscountCell.setCellValue(dto.getTotalBeforeDiscount().doubleValue());
            beforeDiscountCell.setCellStyle(currencyStyle);

            Cell discountCell = row.createCell(6);
            discountCell.setCellValue(dto.getDiscountAmount().doubleValue());
            discountCell.setCellStyle(currencyStyle);

            Cell netRevenueCell = row.createCell(7);
            netRevenueCell.setCellValue(dto.getNetRevenue().doubleValue());
            netRevenueCell.setCellStyle(currencyStyle);

            // Cộng dồn
            totalTransactions += dto.getTransactionCount();
            totalRecruiters += dto.getRecruiterCount();
            totalServices += dto.getTotalServiceCount();
            sumBeforeDiscount = sumBeforeDiscount.add(dto.getTotalBeforeDiscount());
            sumDiscount = sumDiscount.add(dto.getDiscountAmount());
            sumNetRevenue = sumNetRevenue.add(dto.getNetRevenue());
        }

        // Dòng tổng
        Row totalRow = sheet.createRow(rowNum);
        Cell totalLabelCell = totalRow.createCell(0);
        totalLabelCell.setCellValue("TỔNG CỘNG");
        sheet.addMergedRegion(new org.apache.poi.ss.util.CellRangeAddress(rowNum, rowNum, 0, 1));

        totalRow.createCell(2).setCellValue(totalTransactions);
        totalRow.createCell(3).setCellValue(totalRecruiters);
        totalRow.createCell(4).setCellValue(totalServices);

        Cell totalBeforeDiscountCell = totalRow.createCell(5);
        totalBeforeDiscountCell.setCellValue(sumBeforeDiscount.doubleValue());
        totalBeforeDiscountCell.setCellStyle(currencyStyle);

        Cell totalDiscountCell = totalRow.createCell(6);
        totalDiscountCell.setCellValue(sumDiscount.doubleValue());
        totalDiscountCell.setCellStyle(currencyStyle);

        Cell totalNetRevenueCell = totalRow.createCell(7);
        totalNetRevenueCell.setCellValue(sumNetRevenue.doubleValue());
        totalNetRevenueCell.setCellStyle(currencyStyle);

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=revenue_report.xlsx");

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
