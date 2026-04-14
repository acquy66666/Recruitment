/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class BlogPost {

    private int blogId;
    private int adminId;
    private String title;
    private String thumbnailUrl;
    private String summary;
    private String contentJson;
    private String category;
    private boolean isPublished;
    private LocalDateTime publishedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public BlogPost(int blogId, int adminId, String title, String thumbnailUrl, String summary, String contentJson, String category, boolean isPublished, LocalDateTime publishedAt, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.blogId = blogId;
        this.adminId = adminId;
        this.title = title;
        this.thumbnailUrl = thumbnailUrl;
        this.summary = summary;
        this.contentJson = contentJson;
        this.category = category;
        this.isPublished = isPublished;
        this.publishedAt = publishedAt;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public BlogPost(int blogId, int adminId, String title, String summary, String category, String contentJson, String thumbnailUrl, boolean isPublished) {
        this.blogId = blogId;
        this.adminId = adminId;
        this.title = title;
        this.summary = summary;
        this.category = category;
        this.contentJson = contentJson;
        this.thumbnailUrl = thumbnailUrl;
        this.isPublished = isPublished;
    }

    public BlogPost(int adminId, String title, String summary, String category,
            String contentJson, String thumbnailUrl, boolean isPublished) {
        this.adminId = adminId;
        this.title = title;
        this.summary = summary;
        this.category = category;
        this.contentJson = contentJson;
        this.thumbnailUrl = thumbnailUrl;
        this.isPublished = isPublished;
    }

    public BlogPost(int adminId, String category) {
        this.adminId = adminId;
        this.category = category;
    }


    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getContentJson() {
        return contentJson;
    }

    public void setContentJson(String contentJson) {
        this.contentJson = contentJson;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public boolean isIsPublished() {
        return isPublished;
    }

    public void setIsPublished(boolean isPublished) {
        this.isPublished = isPublished;
    }

    public LocalDateTime getPublishedAt() {
        return publishedAt;
    }

    public void setPublishedAt(LocalDateTime publishedAt) {
        this.publishedAt = publishedAt;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getTimeAgo(LocalDateTime time) {
        if (time == null) {
            return "";
        }

        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(time, now);

        long seconds = duration.getSeconds();
        long minutes = seconds / 60;
        long hours = minutes / 60;
        long days = hours / 24;

        if (seconds < 60) {
            return "Vừa đăng";
        } else if (minutes < 60) {
            return minutes + " phút trước";
        } else if (hours < 24) {
            return hours + " giờ trước";
        } else if (days < 7) {
            return days + " ngày trước";
        } else {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            return time.format(formatter);
        }
    }

    public String dateCreatAt() {
        String[] createAtNow = this.createdAt.toString().split("T");
        return createAtNow[0];
    }

    @Override
    public String toString() {
        return "BlogPost{" + "blogId=" + blogId + ", adminId=" + adminId + ", title=" + title + ", thumbnailUrl=" + thumbnailUrl + ", summary=" + summary + ", contentJson=" + contentJson + ", category=" + category + ", isPublished=" + isPublished + ", publishedAt=" + publishedAt + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }

}
//    public String getTimeAgo(LocalDateTime time) {
//        if (time == null) {
//            return "";
//        }
//
//        LocalDateTime now = LocalDateTime.now();
//        Duration duration = Duration.between(time, now);
//
//        long seconds = duration.getSeconds();
//        long minutes = seconds / 60;
//        long hours = minutes / 60;
//        long days = hours / 24;
//
//        if (seconds < 60) {
//            return "Vừa đăng";
//        } else if (minutes < 60) {
//            return minutes + " phút trước";
//        } else if (hours < 24) {
//            return hours + " giờ trước";
//        } else if (days < 7) {
//            return days + " ngày trước";
//        } else {
//            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
//            return time.format(formatter);
//        }
//    }