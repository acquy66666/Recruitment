package com.recruitment.model;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Date;
import java.util.Locale;

public class Promotion {

    private int promotionId;
    private String promotionType;
    private String title;
    private String promoCode;
    private int quantity;
    private String description;
    private double discountPercent;      // For DECIMAL(5,2)
    private double maxDiscountAmount;      // For DECIMAL(18,2), assuming cents as smallest unit
    private Date startDate;
    private Date endDate;
    private boolean isActive;
    private Date createdAt;

    // Constructors
    public Promotion() {
    }

    public Promotion(int promotionId, String promotionType, String title, String promoCode,
            int quantity, String description, double discountPercent,
            double maxDiscountAmount, Date startDate, Date endDate,
            boolean isActive, Date createdAt) {
        this.promotionId = promotionId;
        this.promotionType = promotionType;
        this.title = title;
        this.promoCode = promoCode;
        this.quantity = quantity;
        this.description = description;
        this.discountPercent = discountPercent;
        this.maxDiscountAmount = maxDiscountAmount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public String getPromotionType() {
        return promotionType;
    }

    public void setPromotionType(String promotionType) {
        this.promotionType = promotionType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPromoCode() {
        return promoCode;
    }

    public void setPromoCode(String promoCode) {
        this.promoCode = promoCode;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public double getMaxDiscountAmount() {
        return maxDiscountAmount;
    }

    public String getFormattedDiscountPercent() {
        return String.format("%.0f", discountPercent);
    }

    public String getFormattedMaxDiscountAmount() {
        return formatMaxDiscount(discountPercent);
    }

    public void setMaxDiscountAmount(double maxDiscountAmount) {
        this.maxDiscountAmount = maxDiscountAmount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    
    private String formatMaxDiscount(Double md) {
        if (md == null) {
            return "";
        }
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator(',');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        return df.format(md);
    }

    
    public String formatSalaryTrieuDong(double amount) {
        if (amount < 1_000_000) {
            DecimalFormatSymbols symbols = new DecimalFormatSymbols(new Locale("vi", "VN"));
            symbols.setGroupingSeparator(',');//Đặt dấu phân cách phần nghìn là dấu chấm (.).
            symbols.setDecimalSeparator('.');//Đặt dấu phân cách phần thập phân là dấu phẩy (,).
            DecimalFormat decimalFormat = new DecimalFormat("#,##0", symbols);
            return decimalFormat.format(amount) + " đồng";
        } else {
            double millions = amount / 1_000_000;
            if (millions == (long) millions) {
                // Là số nguyên, ví dụ 10.0 -> 10 triệu
                return String.format("%d ", (long) millions);
            } else {
                // Có phần thập phân, ví dụ 9.5 triệu
                return String.format("%.1f ", millions);
            }
        }
    }
}
