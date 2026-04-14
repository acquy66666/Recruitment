/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

/**
 *
 * @author GBCenter
 */
public class Cv {
    private int cvId;
    private int candidateId;
    private String title;
    private boolean isDefault;
    private String appliedAt;
    private String updatedAt;
    private String status;
    private String cvUrl;
    private String cvJson;

    public Cv() {
    }

    public Cv(int cvId, int candidateId, String title, boolean isDefault, String appliedAt, String updatedAt, String status) {
        this.cvId = cvId;
        this.candidateId = candidateId;
        this.title = title;
        this.isDefault = isDefault;
        this.appliedAt = appliedAt;
        this.updatedAt = updatedAt;
        this.status = status;
    }

    public Cv(int cvId, int candidateId, String title, boolean isDefault, String appliedAt, String updatedAt, String status, String cvUrl) {
        this.cvId = cvId;
        this.candidateId = candidateId;
        this.title = title;
        this.isDefault = isDefault;
        this.appliedAt = appliedAt;
        this.updatedAt = updatedAt;
        this.status = status;
        this.cvUrl = cvUrl;
    }

    public Cv(int cvId, int candidateId, String title, boolean isDefault, String appliedAt, String updatedAt, String status, String cvUrl, String cvJson) {
        this.cvId = cvId;
        this.candidateId = candidateId;
        this.title = title;
        this.isDefault = isDefault;
        this.appliedAt = appliedAt;
        this.updatedAt = updatedAt;
        this.status = status;
        this.cvUrl = cvUrl;
        this.cvJson = cvJson;
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

    public boolean isIsDefault() {
        return isDefault;
    }

    public void setIsDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }

    public String getAppliedAt() {
        return appliedAt;
    }

    public void setAppliedAt(String appliedAt) {
        this.appliedAt = appliedAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCvUrl() {
        return cvUrl;
    }

    public void setCvUrl(String cvUrl) {
        this.cvUrl = cvUrl;
    }
   
    public String getCvJson() {
        return cvJson;
    }

    public void setCvJson(String cvJson) {
        this.cvJson = cvJson;
    }
    
}
