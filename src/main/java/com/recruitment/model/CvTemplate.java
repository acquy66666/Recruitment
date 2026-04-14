package com.recruitment.model;


public class CvTemplate {
    private int cvId;
    private int candidateId;
    private String title;
    private String htmlContent;

    public CvTemplate() {
    }

    public CvTemplate(int cvId, int candidateId, String title, String htmlContent) {
        this.cvId = cvId;
        this.candidateId = candidateId;
        this.title = title;
        this.htmlContent = htmlContent;
    }

    public int getCvId() {
        return cvId;
    }

    public void setCvId(int cvId) {
        this.cvId = cvId;
    }

    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getHtmlContent() {
        return htmlContent;
    }

    public void setHtmlContent(String htmlContent) {
        this.htmlContent = htmlContent;
    }
    
    
}
