/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.time.LocalDateTime;

/**
 *
 * @author Mr Duc
 */
public class Recruiter {

    private int recruiterId;
    private String passwordHash;
    private String fullName;
    private String position;
    private String phone;
    private String email;
    private LocalDateTime createdAt;
    private boolean isActive;
    private String imageUrl;
    private String companyName;
    private String companyAddress;
    private String taxCode;
    private String website;
    private String companyLogoUrl;
    private String industry;
    private String companyDescription;
    private String credit;
    
    public Recruiter() {
    }

    public Recruiter(int recruiterId, String passwordHash, String fullName, String position, String phone, String email, LocalDateTime createdAt, boolean isActive, String imageUrl, String companyName, String companyAddress, String taxCode, String website, String companyLogoUrl, String industry, String companyDescription, String credit) {
        this.recruiterId = recruiterId;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.position = position;
        this.phone = phone;
        this.email = email;
        this.createdAt = createdAt;
        this.isActive = isActive;
        this.imageUrl = imageUrl;
        this.companyName = companyName;
        this.companyAddress = companyAddress;
        this.taxCode = taxCode;
        this.website = website;
        this.companyLogoUrl = companyLogoUrl;
        this.industry = industry;
        this.companyDescription = companyDescription;
        this.credit = credit;
    }

    public Recruiter(String companyLogoUrl, String companyName, String companyAddress) {
        this.companyLogoUrl = companyLogoUrl;
        this.companyName = companyName;
        this.companyAddress = companyAddress;
    }

    public Recruiter(String email, String companyName) {
        this.email = email;
        this.companyName = companyName;
    }

    public Recruiter(int recruiterId, String fullName, String position, String phone, String email, LocalDateTime createdAt, boolean isActive, String companyName) {
        this.recruiterId = recruiterId;
        this.fullName = fullName;
        this.position = position;
        this.phone = phone;
        this.email = email;
        this.createdAt = createdAt;
        this.isActive = isActive;
        this.companyName = companyName;
    }
    
    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getCompanyDescription() {
        return companyDescription;
    }

    public void setCompanyDescription(String companyDescription) {
        this.companyDescription = companyDescription;
    }

    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress;
    }

    public String getTaxCode() {
        return taxCode;
    }

    public void setTaxCode(String taxCode) {
        this.taxCode = taxCode;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getCompanyLogoUrl() {
        return companyLogoUrl;
    }

    public void setCompanyLogoUrl(String companyLogoUrl) {
        this.companyLogoUrl = companyLogoUrl;
    }

    public String dateCreateNow() {
        String test = this.createdAt.toString();
        String[] deteNow = test.split("T");
        return deteNow[0];
    }

    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }
  
    @Override
    public String toString() {
        return "Recruiter{" + "recruiterId=" + recruiterId + ", passwordHash=" + passwordHash + ", fullName=" + fullName + ", position=" + position + ", phone=" + phone + ", email=" + email + ", createdAt=" + createdAt + ", isActive=" + isActive + ", imageUrl=" + imageUrl + ", companyName=" + companyName + ", companyAddress=" + companyAddress + ", website=" + website + ", companyLogoUrl=" + companyLogoUrl + ", industry=" + industry + ", companyDescription=" + companyDescription + '}';
    }

}
