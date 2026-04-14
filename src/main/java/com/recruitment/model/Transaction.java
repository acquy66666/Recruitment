package com.recruitment.model;

import java.time.LocalDateTime;

public class Transaction {
    private int transactionId;
    private int recruiterId;
    private int promotionId;
    private double price;
    private LocalDateTime transactionDate;
    private String paymentMethod;
    private String status;
    private String orderId;
    private String vnp_TxnRef;
    private String vnp_TransactionNo;
    private String json;

    public Transaction() {
    }
    
    public Transaction(int transactionId, int recruiterId, int promotionId, double price, LocalDateTime transactionDate, String paymentMethod, String status, String orderId, String vnp_TxnRef, String vnp_TransactionNo, String json) {
        this.transactionId = transactionId;
        this.recruiterId = recruiterId;
        this.promotionId = promotionId;
        this.price = price;
        this.transactionDate = transactionDate;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.orderId = orderId;
        this.vnp_TxnRef = vnp_TxnRef;
        this.vnp_TransactionNo = vnp_TransactionNo;
        this.json = json;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }

    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public LocalDateTime getTransactionDate() {
        return transactionDate;
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

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getVnp_TxnRef() {
        return vnp_TxnRef;
    }

    public void setVnp_TxnRef(String vnp_TxnRef) {
        this.vnp_TxnRef = vnp_TxnRef;
    }

    public String getVnp_TransactionNo() {
        return vnp_TransactionNo;
    }

    public void setVnp_TransactionNo(String vnp_TransactionNo) {
        this.vnp_TransactionNo = vnp_TransactionNo;
    }

    public String getJson() {
        return json;
    }

    public void setJson(String json) {
        this.json = json;
    }
}