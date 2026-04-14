/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dto;

import java.sql.Timestamp;

/**
 *
 * @author hoang
 */
public class PendingTestDTO {
    private int recruiterId;   
    private String fullName;
    private boolean isActive;
    private String companyName;
    private String credit;
    private int testId;
    private String title;
    private String testStatus;
    private Timestamp createdAt;

    public PendingTestDTO() {
    }

    public PendingTestDTO(int recruiterId, String fullName, boolean isActive, String companyName, String credit, int testId, String title, String testStatus, Timestamp createdAt) {
        this.recruiterId = recruiterId;
        this.fullName = fullName;
        this.isActive = isActive;
        this.companyName = companyName;
        this.credit = credit;
        this.testId = testId;
        this.title = title;
        this.testStatus = testStatus;
        this.createdAt = createdAt;
    }

    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }

    public int getTestId() {
        return testId;
    }

    public void setTestId(int testId) {
        this.testId = testId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTestStatus() {
        return testStatus;
    }

    public void setTestStatus(String testStatus) {
        this.testStatus = testStatus;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    
    
    
}
