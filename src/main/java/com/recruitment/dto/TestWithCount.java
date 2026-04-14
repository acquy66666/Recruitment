/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dto;

import java.util.Date;


public class TestWithCount {
    private int testId;
    private int recruiterId;
    private String title;
    private String description;
    private Date createdAt;
    private String status;
    private int questionCount;
    private double avgScore;
    private int testTakenCount;
    private double passRate;

    public TestWithCount() {
    }

    public TestWithCount(int testId, int recruiterId, String title, String description, Date createdAt, String status, int questionCount, double avgScore, int testTakenCount, double passRate) {
        this.testId = testId;
        this.recruiterId = recruiterId;
        this.title = title;
        this.description = description;
        this.createdAt = createdAt;
        this.status = status;
        this.questionCount = questionCount;
        this.avgScore = avgScore;
        this.testTakenCount = testTakenCount;
        this.passRate = passRate;
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

    public int getQuestionCount() {
        return questionCount;
    }

    public void setQuestionCount(int questionCount) {
        this.questionCount = questionCount;
    }

    public double getAvgScore() {
        return avgScore;
    }

    public void setAvgScore(double avgScore) {
        this.avgScore = avgScore;
    }

    public int getTestTakenCount() {
        return testTakenCount;
    }

    public void setTestTakenCount(int testTakenCount) {
        this.testTakenCount = testTakenCount;
    }

    public double getPassRate() {
        return passRate;
    }

    public void setPassRate(double passRate) {
        this.passRate = passRate;
    }

    
    
}
