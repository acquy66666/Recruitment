package com.recruitment.dto;

import java.sql.Timestamp;


public class AssignmentDTO {
    private int assignmentId;
    private int testId;
    private int candidateId;
    private int jobId;
    private Timestamp assignedAt;
    private Timestamp completedAt;
    private double score;
    private String status;

    
    private String testTitle;
    private String testDescription;

    
    private String candidateName;
    private String candidateEmail;

    
    private String jobTitle;

    public AssignmentDTO() {
    }

    public AssignmentDTO(int assignmentId, int testId, int candidateId, int jobId, Timestamp assignedAt, Timestamp completedAt, double score, String status, String testTitle, String testDescription, String candidateName, String candidateEmail, String jobTitle) {
        this.assignmentId = assignmentId;
        this.testId = testId;
        this.candidateId = candidateId;
        this.jobId = jobId;
        this.assignedAt = assignedAt;
        this.completedAt = completedAt;
        this.score = score;
        this.status = status;
        this.testTitle = testTitle;
        this.testDescription = testDescription;
        this.candidateName = candidateName;
        this.candidateEmail = candidateEmail;
        this.jobTitle = jobTitle;
    }

    public int getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(int assignmentId) {
        this.assignmentId = assignmentId;
    }

    public int getTestId() {
        return testId;
    }

    public void setTestId(int testId) {
        this.testId = testId;
    }

    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
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

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTestTitle() {
        return testTitle;
    }

    public void setTestTitle(String testTitle) {
        this.testTitle = testTitle;
    }

    public String getTestDescription() {
        return testDescription;
    }

    public void setTestDescription(String testDescription) {
        this.testDescription = testDescription;
    }

    public String getCandidateName() {
        return candidateName;
    }

    public void setCandidateName(String candidateName) {
        this.candidateName = candidateName;
    }

    public String getCandidateEmail() {
        return candidateEmail;
    }

    public void setCandidateEmail(String candidateEmail) {
        this.candidateEmail = candidateEmail;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }
    
    
}
