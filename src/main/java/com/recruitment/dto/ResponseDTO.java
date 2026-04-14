/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nfs://netbeans/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dto;

/**
 *
 * @author hoang
 */
public class ResponseDTO {
    private int responseId;
    private int questionId;
    private int assignmentId;
    private String responseText;
    private boolean isCorrect;
    private int testId;
    private String questionText;
    private String correctAnswer;
    private int jobId;
    private int candidateId;

    public ResponseDTO() {
    }

    public ResponseDTO(int responseId, int questionId, int assignmentId, String responseText, boolean isCorrect,
                       int testId, String questionText, String correctAnswer, int jobId, int candidateId) {
        this.responseId = responseId;
        this.questionId = questionId;
        this.assignmentId = assignmentId;
        this.responseText = responseText;
        this.isCorrect = isCorrect;
        this.testId = testId;
        this.questionText = questionText;
        this.correctAnswer = correctAnswer;
        this.jobId = jobId;
        this.candidateId = candidateId;
    }

    public int getResponseId() {
        return responseId;
    }

    public void setResponseId(int responseId) {
        this.responseId = responseId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(int assignmentId) {
        this.assignmentId = assignmentId;
    }

    public String getResponseText() {
        return responseText;
    }

    public void setResponseText(String responseText) {
        this.responseText = responseText;
    }

    public boolean isCorrect() {
        return isCorrect;
    }

    public void setCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public int getTestId() {
        return testId;
    }

    public void setTestId(int testId) {
        this.testId = testId;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
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
}