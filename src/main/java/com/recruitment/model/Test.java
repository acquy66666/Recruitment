/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.time.LocalDateTime;
import java.util.Date;

/**
 *
 * @author hoang
 */
public class Test {
    private int testId;
    private int recruiterId;
    private String title;
    private String description;
    private Date createdAt;
    private String status;

    public Test() {
    }

    public Test(int testId, int recruiterId, String title, String description, Date createdAt, String status) {
        this.testId = testId;
        this.recruiterId = recruiterId;
        this.title = title;
        this.description = description;
        this.createdAt = createdAt;
        this.status = status;
    }

    public int getTestId() {
        return testId;
    }

    public void setTestId(int testId) {
        this.testId = testId;
    }

    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
