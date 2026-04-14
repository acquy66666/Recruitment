/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.Notification;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hoang
 */
public class NotificationDAO extends DBcontext {
    public void createNotification(String recipientType, int recipientId, boolean isGlobal, String title, String message) throws SQLException {
        String sql = "INSERT INTO notification (recipient_type, recipient_id, is_global, title, message) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, recipientType);
            ps.setInt(2, recipientId);
            ps.setBoolean(3, isGlobal);
            ps.setString(4, title);
            ps.setString(5, message);
            ps.executeUpdate();
        }
    }

    public List<Notification> getNotifications(String recipientType, int recipientId) throws SQLException {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notification WHERE (recipient_type = ? AND recipient_id = ?) OR is_global = 1 ORDER BY created_at DESC";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, recipientType);
            ps.setInt(2, recipientId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notification n = new Notification(
                    rs.getInt("id"),
                    rs.getString("recipient_type"),
                    rs.getInt("recipient_id"),
                    rs.getBoolean("is_global"),
                    rs.getString("title"),
                    rs.getString("message"),
                    rs.getTimestamp("created_at")
                );
                list.add(n);
            }
        }
        return list;
    }

    public void markAsRead(int id) throws SQLException {
        String sql = "UPDATE notification SET is_read = 1 WHERE id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
    public int getNotificationCount(String recipientType, int recipientId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM notification WHERE ((recipient_type = ? AND recipient_id = ?) OR is_global = 1)";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, recipientType);
            ps.setInt(2, recipientId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }}
