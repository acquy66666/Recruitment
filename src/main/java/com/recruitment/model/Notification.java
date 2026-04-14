/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.sql.Timestamp;

/**
 *
 * @author hoang
 */
public class Notification {
    private int id;
    private String recipientType;
    private int recipientId;
    private boolean isGlobal;
    private String title;
    private String message;
    private Timestamp createdAt;

    public Notification(int id, String recipientType, int recipientId, boolean isGlobal, String title, String message, Timestamp createdAt) {
        this.id = id;
        this.recipientType = recipientType;
        this.recipientId = recipientId;
        this.isGlobal = isGlobal;
        this.title = title;
        this.message = message;
        this.createdAt = createdAt;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRecipientType() {
        return recipientType;
    }

    public void setRecipientType(String recipientType) {
        this.recipientType = recipientType;
    }

    public int getRecipientId() {
        return recipientId;
    }

    public void setRecipientId(int recipientId) {
        this.recipientId = recipientId;
    }

    public boolean isIsGlobal() {
        return isGlobal;
    }

    public void setIsGlobal(boolean isGlobal) {
        this.isGlobal = isGlobal;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    
    
}
