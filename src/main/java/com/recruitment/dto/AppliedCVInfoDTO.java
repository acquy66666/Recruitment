/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dto;

import java.util.Date;

/**
 *
 * @author hoang
 */
public class AppliedCVInfoDTO {
    private int cvId;
    private String cvJson;
    private String cvUrl;

    private int candidateId;
    private String fullName;
    private String gender;
    private Date birthdate;
    private String address;
    private String email;
    private String phone;
    private String imageUrl;

    public AppliedCVInfoDTO() {
    }

    public AppliedCVInfoDTO(int cvId, String cvJson, int candidateId, String fullName, String gender, Date birthdate, String address, String email, String phone) {
        this.cvId = cvId;
        this.cvJson = cvJson;
        this.candidateId = candidateId;
        this.fullName = fullName;
        this.gender = gender;
        this.birthdate = birthdate;
        this.address = address;
        this.email = email;
        this.phone = phone;
    }

    public int getCvId() {
        return cvId;
    }

    public void setCvId(int cvId) {
        this.cvId = cvId;
    }

    public String getCvJson() {
        return cvJson;
    }

    public void setCvJson(String cvJson) {
        this.cvJson = cvJson;
    }

    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Date birthdate) {
        this.birthdate = birthdate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCvUrl() {
        return cvUrl;
    }

    public void setCvUrl(String cvUrl) {
        this.cvUrl = cvUrl;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
  
    
}
