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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

@WebServlet(name = "createPromotionServlet", urlPatterns = {"/createPromotion"})
public class createPromotionServlet extends HttpServlet {

    private PromotionDAO promotionDAO;

    @Override
    public void init() throws ServletException {
        promotionDAO = new PromotionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("createPromotion.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form parameters
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

            // Store form data for repopulation
            request.setAttribute("promotionType", promotionType);
            request.setAttribute("title", title);
            request.setAttribute("promoCode", promoCode);
            request.setAttribute("quantity", quantityStr);
            request.setAttribute("description", description);
            request.setAttribute("discountPercent", discountPercentStr);
            request.setAttribute("maxDiscountAmount", maxDiscountAmountStr);
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);
            request.setAttribute("isActive", isActive ? "on" : null);

            // Validate inputs
            if (promotionType == null || promotionType.trim().isEmpty() || promotionType.length() > 50) {
                throw new IllegalArgumentException("Loại khuyến mãi không hợp lệ.");
            }

            if (title == null || title.trim().isEmpty() || title.length() > 100) {
                throw new IllegalArgumentException("Tiêu đề không hợp lệ.");
            }

            if (promoCode == null || !promoCode.matches("^[A-Za-z0-9]{6}$") ) {
                throw new IllegalArgumentException("Mã khuyến mãi không hợp lệ (gồm 6 chữ cái hoặc số).");
            }
            
            if(!promotionDAO.isPromoCodeUnique(promoCode, 0)) {
                throw new IllegalArgumentException("Mã khuyến mãi đã tồn tại.");
            }

            int quantity;
            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity < 1) {
                    throw new IllegalArgumentException("Số lượng phải lớn hơn hoặc bằng 1.");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Số lượng không hợp lệ.");
            }

            if (description != null && description.length() > 255) {
                throw new IllegalArgumentException("Mô tả quá dài (tối đa 255 ký tự).");
            }

            double discountPercent;
            try {
                discountPercent = Double.parseDouble(discountPercentStr);
                if (discountPercent < 5 || discountPercent > 50) {
                    throw new IllegalArgumentException("Phần trăm giảm giá phải từ 5 đến 50.");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Phần trăm giảm giá không hợp lệ.");
            }

            double maxDiscountAmount;
            try {
                maxDiscountAmount = Double.parseDouble(maxDiscountAmountStr);
                if (maxDiscountAmount < 5000 || maxDiscountAmount > 2000000) {
                    throw new IllegalArgumentException("Số tiền giảm tối đa phải từ 5,000 đến 2,000,000.");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Số tiền giảm tối đa không hợp lệ.");
            }

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate;
            try {
                startDate = dateFormat.parse(startDateStr);
                Date today = new Date();
                today.setHours(0);
                today.setMinutes(0);
                today.setSeconds(0);
                if (startDate.before(today)) {
                    throw new IllegalArgumentException("Ngày bắt đầu phải từ hôm nay trở đi.");
                }
            } catch (IllegalArgumentException | ParseException e) {
                throw new IllegalArgumentException("Ngày bắt đầu không hợp lệ.");
            }

            Date endDate = null;
            if (endDateStr != null && !endDateStr.isEmpty()) {
                try {
                    endDate = dateFormat.parse(endDateStr);
                    if (endDate.compareTo(startDate) <= 0) {
                        throw new IllegalArgumentException("Ngày kết thúc phải sau ngày bắt đầu.");
                    }
                } catch (IllegalArgumentException | ParseException e) {
                    throw new IllegalArgumentException("Ngày kết thúc không hợp lệ.");
                }
            }

            // Create Promotion object
            Promotion promotion = new Promotion();
            promotion.setPromotionType(promotionType);
            promotion.setTitle(title);
            promotion.setPromoCode(promoCode);
            promotion.setQuantity(quantity);
            promotion.setDescription(description);
            promotion.setDiscountPercent(discountPercent);
            promotion.setMaxDiscountAmount(maxDiscountAmount);
            promotion.setStartDate(startDate);
            promotion.setEndDate(endDate);
            promotion.setActive(isActive);

            // Insert promotion
            int promotionId = promotionDAO.insertPromotion(promotion);
            if (promotionId <= 0) {
                throw new SQLException("Không thể tạo khuyến mãi.");
            }

            // Redirect to promotion management
            response.sendRedirect("managePromotions");

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("generatedPromoCode", generateUniquePromoCode());
            request.getRequestDispatcher("createPromotion.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.setAttribute("generatedPromoCode", generateUniquePromoCode());
            request.getRequestDispatcher("createPromotion.jsp").forward(request, response);
        }
    }

    private String generateUniquePromoCode() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        String promoCode;
        boolean isUnique = false;
        int maxAttempts = 10;

        try {
            while (!isUnique && maxAttempts-- > 0) {
                StringBuilder sb = new StringBuilder(6);
                for (int i = 0; i < 6; i++) {
                    sb.append(characters.charAt(random.nextInt(characters.length())));
                }
                promoCode = sb.toString();
                if (promotionDAO.isPromoCodeUnique(promoCode, 0)) {
                    return promoCode;
                }
            }
        } catch (SQLException e) {
            // Log error and return a fallback code
        }

        return "P" + Long.toHexString(System.currentTimeMillis()).substring(0, 5).toUpperCase();
    }
}