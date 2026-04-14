package com.recruitment.dao;

import com.recruitment.model.Moderator;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for managing Moderator entities in the database.
 */
public class ModeratorDAO extends DBcontext {

    // Insert a new Moderator
    public int insertModerator(Moderator moderator) throws SQLException {
        String sql = "INSERT INTO [dbo].[moderator] ([department], [username], [password_hash], [created_at], [isActive]) VALUES (?, ?, ?, GETDATE(), ?)";
        try (PreparedStatement st = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            st.setString(1, moderator.getDepartment());
            st.setString(2, moderator.getUsername());
            st.setString(3, moderator.getPasswordHash());
            st.setBoolean(4, moderator.isActive());
            int affectedRows = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Inserting moderator failed, no rows affected.");
            }
            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated moderators_id
                }
            }
        }
        return -1; // If failed
    }

    // Update an existing Moderator
    public void updateModerator(Moderator moderator) throws SQLException {
        String sql = "UPDATE [dbo].[moderator] SET [department] = ?, [username] = ?, [password_hash] = ?, [isActive] = ? WHERE [moderators_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, moderator.getDepartment());
            st.setString(2, moderator.getUsername());
            st.setString(3, moderator.getPasswordHash());
            st.setBoolean(4, moderator.isActive());
            st.setInt(5, moderator.getModeratorsId());
            st.executeUpdate();
        }
    }

    // Change Moderator password by username
    public void changeModeratorPasswordByUsername(String username, String newPasswordHash) throws SQLException {
        String sql = "UPDATE [dbo].[moderator] SET [password_hash] = ? WHERE [username] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, newPasswordHash);
            st.setString(2, username);
            int rowsAffected = st.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No moderator found with username: " + username);
            }
        }
    }

    // Delete a Moderator by ID
    public void deleteModerator(int moderatorsId) throws SQLException {
        String sql = "DELETE FROM [dbo].[moderator] WHERE [moderators_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, moderatorsId);
            st.executeUpdate();
        }
    }

    // Get all Moderators
    public List<Moderator> getAllModerators() throws SQLException {
        String sql = "SELECT [moderators_id], [department], [username], [password_hash], [created_at], [isActive] FROM [dbo].[moderator]";
        List<Moderator> moderators = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Moderator moderator = new Moderator();
                    moderator.setModeratorsId(rs.getInt("moderators_id"));
                    moderator.setDepartment(rs.getString("department"));
                    moderator.setUsername(rs.getString("username"));
                    moderator.setPasswordHash(rs.getString("password_hash"));
                    moderator.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    moderator.setActive(rs.getBoolean("isActive"));
                    moderators.add(moderator);
                }
            }
        }
        return moderators;
    }

    // Get Moderator by username
    public Moderator getModeratorByUsername(String username) throws SQLException {
        String sql = "SELECT [moderators_id], [department], [username], [password_hash], [created_at], [isActive] FROM [dbo].[moderator] WHERE [username] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Moderator moderator = new Moderator();
                    moderator.setModeratorsId(rs.getInt("moderators_id"));
                    moderator.setDepartment(rs.getString("department"));
                    moderator.setUsername(rs.getString("username"));
                    moderator.setPasswordHash(rs.getString("password_hash"));
                    moderator.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    moderator.setActive(rs.getBoolean("isActive"));
                    return moderator;
                }
            }
        }
        return null;
    }

    // Get Moderator by ID
    public Moderator getModeratorById(int moderatorsId) throws SQLException {
        String sql = "SELECT [moderators_id], [department], [username], [password_hash], [created_at], [isActive] FROM [dbo].[moderator] WHERE [moderators_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, moderatorsId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Moderator moderator = new Moderator();
                    moderator.setModeratorsId(rs.getInt("moderators_id"));
                    moderator.setDepartment(rs.getString("department"));
                    moderator.setUsername(rs.getString("username"));
                    moderator.setPasswordHash(rs.getString("password_hash"));
                    moderator.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    moderator.setActive(rs.getBoolean("isActive"));
                    return moderator;
                }
            }
        }
        return null;
    }
    
    // Get paginated moderators
    public List<Moderator> getPaginatedModerators(int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT [moderators_id], [department], [username], [password_hash], [created_at], [isActive] FROM [dbo].[moderator] ORDER BY [moderators_id] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        List<Moderator> moderators = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, offset);
            st.setInt(2, pageSize);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Moderator moderator = new Moderator();
                    moderator.setModeratorsId(rs.getInt("moderators_id"));
                    moderator.setDepartment(rs.getString("department"));
                    moderator.setUsername(rs.getString("username"));
                    moderator.setPasswordHash(rs.getString("password_hash"));
                    moderator.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    moderator.setActive(rs.getBoolean("isActive"));
                    moderators.add(moderator);
                }
            }
        }
        return moderators;
    }

    // Get total number of moderators
    public int getTotalModerators() throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[moderator]";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Get paginated moderators by username
    public List<Moderator> getPaginatedModeratorsByUsername(String username, int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT [moderators_id], [department], [username], [password_hash], [created_at], [isActive] FROM [dbo].[moderator] WHERE [username] LIKE ? ORDER BY [moderators_id] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        List<Moderator> moderators = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, "%" + username + "%");
            st.setInt(2, offset);
            st.setInt(3, pageSize);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Moderator moderator = new Moderator();
                    moderator.setModeratorsId(rs.getInt("moderators_id"));
                    moderator.setDepartment(rs.getString("department"));
                    moderator.setUsername(rs.getString("username"));
                    moderator.setPasswordHash(rs.getString("password_hash"));
                    moderator.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
                    moderator.setActive(rs.getBoolean("isActive"));
                    moderators.add(moderator);
                }
            }
        }
        return moderators;
    }

    // Get total number of moderators by username
    public int getTotalModeratorsByUsername(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[moderator] WHERE [username] LIKE ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, "%" + username + "%");
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
}