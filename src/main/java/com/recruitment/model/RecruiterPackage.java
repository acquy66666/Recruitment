package com.recruitment.model;

import java.util.Date;

public class RecruiterPackage {

    private int recruiterPackageId;
    private int recruiterId;
    private int serviceId;
    private int transactionId;
    private int totalCredit;
    private int usedCredit;
    private Date startDate;
    private Date endDate;
    private String status;

    // Constructors
    public RecruiterPackage() {
        this.usedCredit = 0;
        this.status = "active";
    }

    public RecruiterPackage(int recruiterId, int serviceId, int transactionId, int totalCredit, 
                            Date startDate, Date endDate) {
        this.recruiterId = recruiterId;
        this.serviceId = serviceId;
        this.transactionId = transactionId;
        this.totalCredit = totalCredit;
        this.usedCredit = 0;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = "active";
    }

    // Getters and Setters
    public int getRecruiterPackageId() {
        return recruiterPackageId;
    }

    public void setRecruiterPackageId(int recruiterPackageId) {
        this.recruiterPackageId = recruiterPackageId;
    }

    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public int getTotalCredit() {
        return totalCredit;
    }

    public void setTotalCredit(int totalCredit) {
        this.totalCredit = totalCredit;
    }

    public int getUsedCredit() {
        return usedCredit;
    }

    public void setUsedCredit(int usedCredit) {
        this.usedCredit = usedCredit;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}