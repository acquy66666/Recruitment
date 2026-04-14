/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.sql.Date;

/**
 *
 * @author GBCenter
 */
public class Application {

    private int applicationId;
    private int candidateId;
    private int cvId;
    private int jobId;
    private String coverLetter;
    private String appliedAt;
    private String status;

    public Application() {
    }

    public Application(int applicationId, int candidateId, int cvId, int jobId, String coverLetter, String appliedAt, String status) {
        this.applicationId = applicationId;
        this.candidateId = candidateId;
        this.cvId = cvId;
        this.jobId = jobId;
        this.coverLetter = coverLetter;
        this.appliedAt = appliedAt;
        this.status = status;
    }

    public Application(int candidateId, int cvId, int jobId, String coverLetter) {
        this.candidateId = candidateId;
        this.cvId = cvId;
        this.jobId = jobId;
        this.coverLetter = coverLetter;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public int getCvId() {
        return cvId;
    }

    public void setCvId(int cvId) {
        this.cvId = cvId;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }

    public String getAppliedAt() {
        return appliedAt;
    }

    public void setAppliedAt(String appliedAt) {
        this.appliedAt = appliedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


}
