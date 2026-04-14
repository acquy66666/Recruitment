package com.recruitment.model;

public class TransactionDetail {

    private int detailId;
    private int transactionId;
    private int serviceId;
    private double unitPrice;

    // Constructors
    public TransactionDetail() {
    }

    public TransactionDetail(int detailId, int transactionId, int serviceId, double unitPrice) {
        this.detailId = detailId;
        this.transactionId = transactionId;
        this.serviceId = serviceId;
        this.unitPrice = unitPrice;
    }

    

    // Getters and Setters
    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }


    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

}