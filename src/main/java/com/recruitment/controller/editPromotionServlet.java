package com.recruitment.controller;

import com.recruitment.dao.PromotionDAO;
import com.recruitment.model.Promotion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Date;

@WebServlet(name = "/editPromotionServlet", urlPatterns = {"/editPromotion"})
public class editPromotionServlet extends HttpServlet {

    private PromotionDAO promotionDAO;

    @Override
    public void init() {
        promotionDAO = new PromotionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get promotion ID
            int promotionId = Integer.parseInt(request.getParameter("promotionId"));
            Promotion promotion = promotionDAO.getPromotionById(promotionId);

            if (promotion == null) {
                request.setAttribute("errorMessage", "Không tìm thấy khuyến mãi.");
                request.getRequestDispatcher("promotionManagement.jsp").forward(request, response);
                return;
            }

            // Check for error message and form data from doPost
            String errorMessage = request.getParameter("errorMessage");
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("promotionType", request.getParameter("promotionType"));
                request.setAttribute("title", request.getParameter("title"));
                request.setAttribute("promoCode", request.getParameter("promoCode"));
                request.setAttribute("quantity", request.getParameter("quantity"));
                request.setAttribute("description", request.getParameter("description"));
                request.setAttribute("discountPercent", request.getParameter("discountPercent"));
                request.setAttribute("maxDiscountAmount", request.getParameter("maxDiscountAmount"));
                request.setAttribute("startDate", request.getParameter("startDate"));
                request.setAttribute("endDate", request.getParameter("endDate"));
                request.setAttribute("isActive", request.getParameter("isActive"));
            }

            // Pass promotion to JSP
            request.setAttribute("promotion", promotion);
            request.getRequestDispatcher("editPromotion.jsp").forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            request.setAttribute("errorMessage", "Lỗi khi tải khuyến mãi: " + e.getMessage());
            request.getRequestDispatcher("promotionManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form parameters
            int promotionId = Integer.parseInt(request.getParameter("promotionId"));
            String promotionType = request.getParameter("promotionType");
            String title = request.getParameter("title");
            String promoCode = request.getParameter("promoCode");
            String quantityStr = request.getParameter("quantity");
            String description = request.getParameter("description");
            String discountPercentStr = request.getParameter("discountPercent");
            String maxDiscountAmountStr = request.getParameter("maxDiscountAmount");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            boolean isActive = request.getParameter("isActive") != null;

            // Validate inputs
            if (promotionType == null || promotionType.trim().isEmpty() || promotionType.length() > 50) {
                throw new IllegalArgumentException("Loại khuyến mãi không hợp lệ.");
            }

            if (title == null || title.trim().isEmpty() || title.length() > 255) {
                throw new IllegalArgumentException("Tiêu đề không hợp lệ.");
            }

            if (promoCode == null || !promoCode.matches("^[A-Za-z0-9]{6}$")
                    || !promotionDAO.isPromoCodeUnique(promoCode, promotionId)) {
                throw new IllegalArgumentException("Mã khuyến mãi không hợp lệ hoặc đã tồn tại.");
            }

            int quantity = Integer.parseInt(quantityStr);
            if (quantity < 1 || quantity > 200) {
                throw new IllegalArgumentException("Số lượng phải từ 1 đến 200.");
            }

            if (description != null && description.length() > 255) {
                throw new IllegalArgumentException("Mô tả quá dài (tối đa 255 ký tự).");
            }

            double discountPercent = Double.parseDouble(discountPercentStr);
            if (discountPercent < 5 || discountPercent > 50) {
                throw new IllegalArgumentException("Phần trăm giảm giá phải từ 5 đến 50.");
            }

            double maxDiscountAmount = Double.parseDouble(maxDiscountAmountStr.replace(",", ""));
            if (maxDiscountAmount < 5000 || maxDiscountAmount > 2000000) {
                throw new IllegalArgumentException("Số tiền giảm tối đa phải từ 5,000 đến 2,000,000.");
            }
            
            // Create Promotion object
            Promotion promotion = new Promotion();
            promotion.setPromotionId(promotionId);
            promotion.setPromotionType(promotionType);
            promotion.setTitle(title);
            promotion.setPromoCode(promoCode);
            promotion.setQuantity(quantity);
            promotion.setDescription(description);
            promotion.setDiscountPercent(discountPercent);
            promotion.setMaxDiscountAmount(maxDiscountAmount);
            try {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDate startDate1 = LocalDate.parse(startDateStr, formatter);
                LocalDate today = LocalDate.now();

                if (startDate1.isBefore(today)) {
                    throw new IllegalArgumentException("Ngày bắt đầu phải từ hôm nay trở đi.");
                }
                LocalDate endDate1 = LocalDate.parse(endDateStr, formatter);
                if (!endDate1.isAfter(startDate1)) {
                    throw new IllegalArgumentException("Ngày kết thúc phải sau ngày bắt đầu.");
                }
                Date startDate = java.sql.Date.valueOf(startDate1);
                Date endDate = java.sql.Date.valueOf(endDate1);
                promotion.setStartDate(startDate);
                promotion.setEndDate(endDate);
            } catch (DateTimeParseException e) {
                throw new IllegalArgumentException("Định dạng ngày không hợp lệ. Định dạng hợp lệ là yyyy-MM-dd.");
            }
            promotion.setActive(isActive);

            // Update promotion
            promotionDAO.updatePromotion(promotion);

            // Construct redirect URL with query parameters
            StringBuilder redirectUrl = new StringBuilder("managePromotions?");
            String page = request.getParameter("page") != null ? request.getParameter("page") : "1";
            String search = request.getParameter("search") != null ? request.getParameter("search") : "";
            String type = request.getParameter("type") != null ? request.getParameter("type") : "";
            String status = request.getParameter("status") != null ? request.getParameter("status") : "";
            String dateFilter = request.getParameter("dateFilter") != null ? request.getParameter("dateFilter") : "";
            String sortBy = request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "created_at_desc";

            redirectUrl.append("page=").append(java.net.URLEncoder.encode(page, "UTF-8"));
            redirectUrl.append("&search=").append(java.net.URLEncoder.encode(search, "UTF-8"));
            redirectUrl.append("&type=").append(java.net.URLEncoder.encode(type, "UTF-8"));
            redirectUrl.append("&status=").append(java.net.URLEncoder.encode(status, "UTF-8"));
            redirectUrl.append("&dateFilter=").append(java.net.URLEncoder.encode(dateFilter, "UTF-8"));
            redirectUrl.append("&sortBy=").append(java.net.URLEncoder.encode(sortBy, "UTF-8"));
            redirectUrl.append("&successMessage=").append(java.net.URLEncoder.encode("Cập nhật khuyến mãi thành công!", "UTF-8"));

            response.sendRedirect(redirectUrl.toString());

        } catch (IOException | SQLException | IllegalArgumentException e) {
            // Log the error for debugging
            System.err.println("Error during promotion update: " + e.getMessage());

            // Construct redirect URL with error message and form data
            StringBuilder errorRedirectUrl = new StringBuilder("editPromotion?");
            errorRedirectUrl.append("promotionId=").append(request.getParameter("promotionId"));
            errorRedirectUrl.append("&errorMessage=").append(java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
            errorRedirectUrl.append("&promotionType=").append(java.net.URLEncoder.encode(request.getParameter("promotionType") != null ? request.getParameter("promotionType") : "", "UTF-8"));
            errorRedirectUrl.append("&title=").append(java.net.URLEncoder.encode(request.getParameter("title") != null ? request.getParameter("title") : "", "UTF-8"));
            errorRedirectUrl.append("&promoCode=").append(java.net.URLEncoder.encode(request.getParameter("promoCode") != null ? request.getParameter("promoCode") : "", "UTF-8"));
            errorRedirectUrl.append("&quantity=").append(request.getParameter("quantity") != null ? request.getParameter("quantity") : "");
            errorRedirectUrl.append("&description=").append(java.net.URLEncoder.encode(request.getParameter("description") != null ? request.getParameter("description") : "", "UTF-8"));
            errorRedirectUrl.append("&discountPercent=").append(request.getParameter("discountPercent") != null ? request.getParameter("discountPercent") : "");
            errorRedirectUrl.append("&maxDiscountAmount=").append(request.getParameter("maxDiscountAmount") != null ? request.getParameter("maxDiscountAmount") : "");
            errorRedirectUrl.append("&startDate=").append(request.getParameter("startDate") != null ? request.getParameter("startDate") : "");
            errorRedirectUrl.append("&endDate=").append(request.getParameter("endDate") != null ? request.getParameter("endDate") : "");
            errorRedirectUrl.append("&isActive=").append(request.getParameter("isActive") != null ? "on" : "");
            errorRedirectUrl.append("&page=").append(request.getParameter("page") != null ? request.getParameter("page") : "1");
            errorRedirectUrl.append("&search=").append(java.net.URLEncoder.encode(request.getParameter("search") != null ? request.getParameter("search") : "", "UTF-8"));
            errorRedirectUrl.append("&type=").append(java.net.URLEncoder.encode(request.getParameter("type") != null ? request.getParameter("type") : "", "UTF-8"));
            errorRedirectUrl.append("&status=").append(java.net.URLEncoder.encode(request.getParameter("status") != null ? request.getParameter("status") : "", "UTF-8"));
            errorRedirectUrl.append("&dateFilter=").append(java.net.URLEncoder.encode(request.getParameter("dateFilter") != null ? request.getParameter("dateFilter") : "", "UTF-8"));
            errorRedirectUrl.append("&sortBy=").append(java.net.URLEncoder.encode(request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "created_at_desc", "UTF-8"));

            response.sendRedirect(errorRedirectUrl.toString());
        }
    }

}
