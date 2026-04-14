/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.time.LocalDateTime;

public class Bookmark {
    private int bookmarkId;
    private int jobId;
    private int candidateId;
    private LocalDateTime createdAt;
    
    // Job information (for display purposes)
    private String jobTitle;
    private String companyName;
    private String location;
    private String jobType;
    private String experienceLevel;
    private String salaryRange;
    private String shortDescription;
    private LocalDateTime deadline;
    private String status;

    // Constructors
    public Bookmark() {}

    public Bookmark(int jobId, int candidateId) {
        this.jobId = jobId;
        this.candidateId = candidateId;
        this.createdAt = LocalDateTime.now();
    }

    public Bookmark(int bookmarkId, int jobId, int candidateId, LocalDateTime createdAt) {
        this.bookmarkId = bookmarkId;
        this.jobId = jobId;
        this.candidateId = candidateId;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getBookmarkId() {
        return bookmarkId;
    }

    public void setBookmarkId(int bookmarkId) {
        this.bookmarkId = bookmarkId;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // Job information getters and setters
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

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getExperienceLevel() {
        return experienceLevel;
    }

    public void setExperienceLevel(String experienceLevel) {
        this.experienceLevel = experienceLevel;
    }

    public String getSalaryRange() {
        return salaryRange;
    }

    public void setSalaryRange(String salaryRange) {
        this.salaryRange = salaryRange;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public LocalDateTime getDeadline() {
        return deadline;
    }

    public void setDeadline(LocalDateTime deadline) {
        this.deadline = deadline;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Bookmark{" +
                "bookmarkId=" + bookmarkId +
                ", jobId=" + jobId +
                ", candidateId=" + candidateId +
                ", createdAt=" + createdAt +
                ", jobTitle='" + jobTitle + '\'' +
                ", companyName='" + companyName + '\'' +
                '}';
    }
}

