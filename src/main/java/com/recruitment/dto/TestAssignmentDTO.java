/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dto;

import java.sql.Timestamp;

public class TestAssignmentDTO {

    private int testId;
    private int recruiterId;
    private String title;
    private String description;
    private String testStatus;
    private int assignmentId;
    private int jobId;
    private int candidateId;
    private Timestamp assignedAt;
    private Timestamp completedAt;
    private int totalQuestion;
    private int score;
    private String assignmentStatus;
    private Timestamp dueDate;

    public TestAssignmentDTO() {
    }

    public TestAssignmentDTO(int testId, int recruiterId, String title, String description, String testStatus, int assignmentId, int jobId, int candidateId, Timestamp assignedAt, Timestamp completedAt, int totalQuestion, int score, String assignmentStatus, Timestamp dueDate) {
        this.testId = testId;
        this.recruiterId = recruiterId;
        this.title = title;
        this.description = description;
        this.testStatus = testStatus;
        this.assignmentId = assignmentId;
        this.jobId = jobId;
        this.candidateId = candidateId;
        this.assignedAt = assignedAt;
        this.completedAt = completedAt;
        this.totalQuestion = totalQuestion;
        this.score = score;
        this.assignmentStatus = assignmentStatus;
        this.dueDate = dueDate;
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

    public String getTestStatus() {
        return testStatus;
    }

    public void setTestStatus(String testStatus) {
        this.testStatus = testStatus;
    }

    public int getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(int assignmentId) {
        this.assignmentId = assignmentId;
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

    public Timestamp getAssignedAt() {
        return assignedAt;
    }

    public void setAssignedAt(Timestamp assignedAt) {
        this.assignedAt = assignedAt;
    }

    public Timestamp getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }

    public int getTotalQuestion() {
        return totalQuestion;
    }

    public void setTotalQuestion(int totalQuestion) {
        this.totalQuestion = totalQuestion;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getAssignmentStatus() {
        return assignmentStatus;
    }

    public void setAssignmentStatus(String assignmentStatus) {
        this.assignmentStatus = assignmentStatus;
    }

    public Timestamp getDueDate() {
        return dueDate;
    }

    public void setDueDate(Timestamp dueDate) {
        this.dueDate = dueDate;
    }
    
    
}
