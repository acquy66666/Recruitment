package com.recruitment.model;

public class TransactionDetailView {
    private final TransactionDetail detail;
    private final String serviceName;
    private final String serviceType;
    private final int credit;
    private final double unitPrice;

    public TransactionDetailView(TransactionDetail detail, String serviceName, String serviceType, int credit, double unitPrice) {
        this.detail = detail;
        this.serviceName = serviceName;
        this.serviceType = serviceType;
        this.credit = credit;
        this.unitPrice = unitPrice;
    }

    public TransactionDetail getDetail() { return detail; }
    public String getServiceName() { return serviceName; }
    public String getServiceType() { return serviceType; }
    public int getCredit() { return credit; }
    public double getUnitPrice() { return unitPrice; }
}