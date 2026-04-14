package com.recruitment.model;

import java.time.LocalDateTime;

public class Moderator {
    private int moderatorsId;
    private String department;
    private String username;
    private String passwordHash;
    private LocalDateTime createdAt;
    private boolean isActive;

    // Constructors
    public Moderator() {
    }

    public Moderator(int moderatorsId, String department, String username, String passwordHash, LocalDateTime createdAt, boolean isActive) {
        this.moderatorsId = moderatorsId;
        this.department = department;
        this.username = username;
        this.passwordHash = passwordHash;
        this.createdAt = createdAt;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getModeratorsId() {
        return moderatorsId;
    }

    public void setModeratorsId(int moderatorsId) {
        this.moderatorsId = moderatorsId;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

}
