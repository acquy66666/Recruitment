/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class TransactionReportDTO {

    private int transactionId;
    private String companyName;
    private String serviceTitle;
    private BigDecimal unitPrice;
    private String promotionTitle;
    private BigDecimal totalPrice;
    private LocalDateTime transactionDate;
    private String paymentMethod;
    private String status;

    public TransactionReportDTO(int transactionId, String companyName, String serviceTitle, BigDecimal unitPrice, String promotionTitle, BigDecimal totalPrice, LocalDateTime transactionDate, String paymentMethod, String status) {
        this.transactionId = transactionId;
        this.companyName = companyName;
        this.serviceTitle = serviceTitle;
        this.unitPrice = unitPrice;
        this.promotionTitle = promotionTitle;
        this.totalPrice = totalPrice;
        this.transactionDate = transactionDate;
        this.paymentMethod = paymentMethod;
        this.status = status;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getServiceTitle() {
        return serviceTitle;
    }

    public void setServiceTitle(String serviceTitle) {
        this.serviceTitle = serviceTitle;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public String getFormattedUnitPrice() {
        BigDecimal value = unitPrice != null ? unitPrice : BigDecimal.ZERO;
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return formatter.format(value);
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getPromotionTitle() {
        return promotionTitle;
    }

    public void setPromotionTitle(String promotionTitle) {
        this.promotionTitle = promotionTitle;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public String getFormattedTotalPrice() {
        BigDecimal value = totalPrice != null ? totalPrice : BigDecimal.ZERO;
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return formatter.format(value);
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LocalDateTime getTransactionDate() {
        return transactionDate;
    }

    public String getFormattedTransactionDate() {
        if (transactionDate == null) {
            return "";
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        return transactionDate.format(formatter);
    }

    public void setTransactionDate(LocalDateTime transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLocalizedStatus() {
        if (status == null) {
            return "Không xác định";
        }
        switch (status.toLowerCase()) {
            case "success":
                return "Thành công";
            case "failed":
                return "Thất bại";
            case "pending":
                return "Đang chờ";
            default:
                return "Không xác định";
        }
    }

    @Override
    public String toString() {
        return "TransactionReportDTO{" + "transactionId=" + transactionId + ", companyName=" + companyName + ", serviceTitle=" + serviceTitle + ", unitPrice=" + unitPrice + ", promotionTitle=" + promotionTitle + ", totalPrice=" + totalPrice + ", transactionDate=" + transactionDate + ", paymentMethod=" + paymentMethod + ", status=" + status + '}';
    }

}
