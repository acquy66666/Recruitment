/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author hoang
 */
public class JobSeeker {
    
    private int jobSeekerId;
    private String username;
    private String passwordHash;
    private String gender;
    private Date birthday; 
    private String phone;
    private String address;
    private String email;
    private Timestamp createdAt; 
    private boolean isActive;
    private String fullName;
    private String imageUrl;
    private String socialMediaUrl;

    public JobSeeker() {
    }

    public JobSeeker(int jobSeekerId, String username, String passwordHash, String gender, Date birthday, String phone, String address, String email, Timestamp createdAt, boolean isActive, String fullName, String imageUrl, String socialMediaUrl) {
        this.jobSeekerId = jobSeekerId;
        this.username = username;
        this.passwordHash = passwordHash;
        this.gender = gender;
        this.birthday = birthday;
        this.phone = phone;
        this.address = address;
        this.email = email;
        this.createdAt = createdAt;
        this.isActive = isActive;
        this.fullName = fullName;
        this.imageUrl = imageUrl;
        this.socialMediaUrl = socialMediaUrl;
    }

    

    public int getJobSeekerId() {
        return jobSeekerId;
    }

    public void setJobSeekerId(int jobSeekerId) {
        this.jobSeekerId = jobSeekerId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getSocialMediaUrl() {
        return socialMediaUrl;
    }

    public void setSocialMediaUrl(String socialMediaUrl) {
        this.socialMediaUrl = socialMediaUrl;
    }
    
    
    
}
