/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author Mr Duc
 */
public class RevenueByMonthDTO {

    private String month;
    private int transactionCount;
    private int recruiterCount;
    private int totalServiceCount;
    private BigDecimal totalBeforeDiscount;
    private BigDecimal discountAmount;
    private BigDecimal netRevenue;
    private Date transactionDate;

    public RevenueByMonthDTO() {
    }

    public RevenueByMonthDTO(String month, int transactionCount, int recruiterCount, int totalServiceCount,
            BigDecimal totalBeforeDiscount, BigDecimal discountAmount, BigDecimal netRevenue) {
        this.month = month;
        this.transactionCount = transactionCount;
        this.recruiterCount = recruiterCount;
        this.totalServiceCount = totalServiceCount;
        this.totalBeforeDiscount = totalBeforeDiscount;
        this.discountAmount = discountAmount;
        this.netRevenue = netRevenue;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    // Getters and Setters
    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public int getTransactionCount() {
        return transactionCount;
    }

    public void setTransactionCount(int transactionCount) {
        this.transactionCount = transactionCount;
    }

    public int getRecruiterCount() {
        return recruiterCount;
    }

    public void setRecruiterCount(int recruiterCount) {
        this.recruiterCount = recruiterCount;
    }

    public int getTotalServiceCount() {
        return totalServiceCount;
    }

    public void setTotalServiceCount(int totalServiceCount) {
        this.totalServiceCount = totalServiceCount;
    }

    public BigDecimal getTotalBeforeDiscount() {
        return totalBeforeDiscount;
    }

    public void setTotalBeforeDiscount(BigDecimal totalBeforeDiscount) {
        this.totalBeforeDiscount = totalBeforeDiscount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getNetRevenue() {
        return netRevenue;
    }

    public void setNetRevenue(BigDecimal netRevenue) {
        this.netRevenue = netRevenue;
    }

    public String getFormattedTotalBeforeDiscount() {
        BigDecimal value = totalBeforeDiscount != null ? totalBeforeDiscount : BigDecimal.ZERO;
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return formatter.format(value);
    }

    public String getFormattedDiscountAmount() {
        BigDecimal value = discountAmount != null ? discountAmount : BigDecimal.ZERO;
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return formatter.format(value);
    }

    public String getFormattedNetRevenue() {
        BigDecimal value = netRevenue != null ? netRevenue : BigDecimal.ZERO;
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        return formatter.format(value);
    }

    @Override
    public String toString() {
        return "RevenueByMonthDTO{"
                + "month='" + month + '\''
                + ", transactionCount=" + transactionCount
                + ", recruiterCount=" + recruiterCount
                + ", totalServiceCount=" + totalServiceCount
                + ", totalBeforeDiscount=" + totalBeforeDiscount
                + ", discountAmount=" + discountAmount
                + ", netRevenue=" + netRevenue
                + '}';
    }
}
