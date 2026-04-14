/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dto;

import java.util.Date;

/**
 *
 * @author hoang
 */
public class JobPostWithApplicationsDTO {

    private int jobId;
    private String jobTitle;
    private String companyName;
    private String location;
    private String status;
    private Date postedDate;
    private Date deadline;
    private int totalApplications;
    private int pendingCount;
    private int acceptedCount;
    private int rejectedCount;

    // Constructors
    public JobPostWithApplicationsDTO() {
    }

    public JobPostWithApplicationsDTO(int jobId, String jobTitle, String companyName, String location,
            String status, Date postedDate, Date deadline, int totalApplications,
            int pendingCount, int acceptedCount, int rejectedCount) {
        this.jobId = jobId;
        this.jobTitle = jobTitle;
        this.companyName = companyName;
        this.location = location;
        this.status = status;
        this.postedDate = postedDate;
        this.deadline = deadline;
        this.totalApplications = totalApplications;
        this.pendingCount = pendingCount;
        this.acceptedCount = acceptedCount;
        this.rejectedCount = rejectedCount;
    }

    // Getters and Setters
    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(Date postedDate) {
        this.postedDate = postedDate;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public int getTotalApplications() {
        return totalApplications;
    }

    public void setTotalApplications(int totalApplications) {
        this.totalApplications = totalApplications;
    }

    public int getPendingCount() {
        return pendingCount;
    }

    public void setPendingCount(int pendingCount) {
        this.pendingCount = pendingCount;
    }

    public int getAcceptedCount() {
        return acceptedCount;
    }

    public void setAcceptedCount(int acceptedCount) {
        this.acceptedCount = acceptedCount;
    }

    public int getRejectedCount() {
        return rejectedCount;
    }

    public void setRejectedCount(int rejectedCount) {
        this.rejectedCount = rejectedCount;
    }
}
