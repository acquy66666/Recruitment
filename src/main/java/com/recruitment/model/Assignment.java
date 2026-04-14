package com.recruitment.model;

import java.sql.Timestamp;

public class Assignment {

    private int assignmentId;
    private int testId;
    private int jobId;
    private int candidateId;
    private Timestamp assignedAt;
    private Timestamp completedAt;
    private int totalQuestion;
    private int correctAnswer;
    private double score;
    private String status;

    public Assignment() {
    }

    public Assignment(int assignmentId, int testId, int jobId, int candidateId, Timestamp assignedAt, Timestamp completedAt, int totalQuestion, int correctAnswer, double score, String status) {
        this.assignmentId = assignmentId;
        this.testId = testId;
        this.jobId = jobId;
        this.candidateId = candidateId;
        this.assignedAt = assignedAt;
        this.completedAt = completedAt;
        this.totalQuestion = totalQuestion;
        this.correctAnswer = correctAnswer;
        this.score = score;
        this.status = status;
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

    public int getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(int correctAnswer) {
        this.correctAnswer = correctAnswer;
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

   

    
}
