package com.recruitment.model;

import java.util.Date;


public class Response {
    private int responseId;
    private int questionId;
    private int assignmentId;
    private String responseText;
    private boolean isCorrect;
    private Date createdDate;

    public Response() {
    }

    public Response(int responseId, int questionId, int assignmentId, String responseText, boolean isCorrect, Date createdDate) {
        this.responseId = responseId;
        this.questionId = questionId;
        this.assignmentId = assignmentId;
        this.responseText = responseText;
        this.isCorrect = isCorrect;
        this.createdDate = createdDate;
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

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
    
}
