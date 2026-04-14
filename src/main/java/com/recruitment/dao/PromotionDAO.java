package com.recruitment.dao;

import com.recruitment.model.Promotion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Data Access Object for managing Promotion entities in the database.
 */
public class PromotionDAO extends DBcontext {

    private static final int PAGE_SIZE = 8;

    // Create a new promotion with transaction
    public int insertPromotion(Promotion promotion) throws SQLException {
        c.setAutoCommit(false);
        try {
            String sql = "INSERT INTO [dbo].[promotion] ([promotion_type], [title], [promo_code], [quantity], "
                    + "[description], [discount_percent], [max_discount_amount], [start_date], [end_date], "
                    + "[isActive], [created_at]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
            try (PreparedStatement ps = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, promotion.getPromotionType());
                ps.setString(2, promotion.getTitle());
                ps.setString(3, promotion.getPromoCode());
                ps.setInt(4, promotion.getQuantity());
                ps.setString(5, promotion.getDescription());
                ps.setDouble(6, promotion.getDiscountPercent());
                ps.setDouble(7, promotion.getMaxDiscountAmount());
                ps.setTimestamp(8, promotion.getStartDate() != null ? new Timestamp(promotion.getStartDate().getTime()) : null);
                ps.setTimestamp(9, promotion.getEndDate() != null ? new Timestamp(promotion.getEndDate().getTime()) : null);
                ps.setBoolean(10, promotion.isActive());

                int affectedRows = ps.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Inserting promotion failed, no rows affected.");
                }
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int promotionId = rs.getInt(1);
                        c.commit();
                        return promotionId; // Return the generated promotion_id
                    }
                }
            }
        } catch (SQLException e) {
            c.rollback();
            throw e;
        } finally {
            c.setAutoCommit(true);
        }
        return -1; // If failed
    }

    // Update an existing promotion with transaction
    public void updatePromotion(Promotion promotion) throws SQLException {
        c.setAutoCommit(false);
        try {
            String sql = "UPDATE [dbo].[promotion] SET [promotion_type] = ?, [title] = ?, [promo_code] = ?, "
                    + "[quantity] = ?, [description] = ?, [discount_percent] = ?, [max_discount_amount] = ?, "
                    + "[start_date] = ?, [end_date] = ?, [isActive] = ? WHERE [promotion_id] = ?";
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setString(1, promotion.getPromotionType());
                ps.setString(2, promotion.getTitle());
                ps.setString(3, promotion.getPromoCode());
                ps.setInt(4, promotion.getQuantity());
                ps.setString(5, promotion.getDescription());
                ps.setDouble(6, promotion.getDiscountPercent());
                ps.setDouble(7, promotion.getMaxDiscountAmount());
                ps.setTimestamp(8, promotion.getStartDate() != null ? new Timestamp(promotion.getStartDate().getTime()) : null);
                ps.setTimestamp(9, promotion.getEndDate() != null ? new Timestamp(promotion.getEndDate().getTime()) : null);
                ps.setBoolean(10, promotion.isActive());
                ps.setInt(11, promotion.getPromotionId());

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("No promotion found with ID: " + promotion.getPromotionId());
                }
                c.commit();
            }
        } catch (SQLException e) {
            c.rollback();
            throw e;
        } finally {
            c.setAutoCommit(true);
        }
    }

    public List<String> getAllPromotionType() throws SQLException {
        String sql = "SELECT DISTINCT [promotion_type] FROM [dbo].[promotion]";
        List<String> typeList = new ArrayList<>();
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String type = rs.getString("promotion_type");
                    typeList.add(type);
                }
                return typeList;
            }
        }
    }

    // Delete a promotion by ID
    public void deletePromotion(int promotionId) throws SQLException {
        String sql = "DELETE FROM [dbo].[promotion] WHERE [promotion_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No promotion found with ID: " + promotionId);
            }
        }
    }

    // Get a promotion by ID
    public Promotion getPromotionById(int promotionId) throws SQLException {
        String sql = "SELECT * FROM [dbo].[promotion] WHERE [promotion_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, promotionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPromotion(rs);
                }
            }
        }
        return null;
    }

    // Get a promotion by promo code
    public Promotion getPromotionByPromoCode(String promoCode) throws SQLException {
        String sql = "SELECT * FROM [dbo].[promotion] WHERE [promo_code] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, promoCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPromotion(rs);
                }
            }
        }
        return null;
    }

    // Get filtered and sorted promotions with pagination
    public List<Promotion> getFilteredPromotions(String search, String type, String status,
            String dateFilter, String sortBy, int page) throws SQLException {
        List<Promotion> promotions = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM [dbo].[promotion] WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Search by title or promo code
        if (search != null && !search.trim().isEmpty()) {
            search = search.replaceAll("\\s+", " ");
            sql.append(" AND ([title] LIKE ? OR [promo_code] LIKE ?)");
            params.add("%" + search.trim() + "%");
            params.add("%" + search.trim() + "%");
        }

        // Filter by type
        if (type != null && !type.isEmpty()) {
            sql.append(" AND [promotion_type] = ?");
            params.add(type);
        }

        // Filter by status
        if (status != null && !status.isEmpty()) {
            sql.append(" AND [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }

        // Filter by date
        if (dateFilter != null && !dateFilter.isEmpty()) {
            switch (dateFilter) {
                case "ongoing":
                    sql.append(" AND [start_date] <= GETDATE() AND ( [end_date] >= GETDATE())");
                    break;
                case "upcoming":
                    sql.append(" AND [start_date] > GETDATE()");
                    break;
                case "expired":
                    sql.append(" AND [end_date] < GETDATE()");
                    break;
            }
        }

        // Sorting, default is from newest to oldest
        switch (sortBy != null ? sortBy : "created_at_desc") {
            case "discount_asc":
                sql.append(" ORDER BY [discount_percent] ASC");
                break;
            case "discount_desc":
                sql.append(" ORDER BY [discount_percent] DESC");
                break;
            case "quantity_asc":
                sql.append(" ORDER BY [quantity] ASC");
                break;
            case "quantity_desc":
                sql.append(" ORDER BY [quantity] DESC");
                break;
            default:
                sql.append(" ORDER BY [created_at] DESC");
        }

        // Pagination
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * PAGE_SIZE);
        params.add(PAGE_SIZE);

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    promotions.add(mapResultSetToPromotion(rs));
                }
            }
        }
        return promotions;
    }

    // Get total number of pages for filtered promotions
    public int getTotalPages(String search, String type, String status, String dateFilter) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[promotion] WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND ([title] LIKE ? OR [promo_code] LIKE ?)");
            params.add("%" + search.trim() + "%");
            params.add("%" + search.trim() + "%");
        }

        if (type != null && !type.isEmpty()) {
            sql.append(" AND [promotion_type] = ?");
            params.add(type);
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }

        if (dateFilter != null && !dateFilter.isEmpty()) {
            switch (dateFilter) {
                case "ongoing":
                    sql.append(" AND [start_date] <= GETDATE() AND ([end_date] IS NULL OR [end_date] >= GETDATE())");
                    break;
                case "upcoming":
                    sql.append(" AND [start_date] > GETDATE()");
                    break;
                case "expired":
                    sql.append(" AND [end_date] < GETDATE()");
                    break;
            }
        }

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int totalRecords = rs.getInt(1);
                    return (int) Math.ceil((double) totalRecords / PAGE_SIZE);
                }
            }
        }
        return 0;
    }

    // Check if promo code is unique (excluding a specific promotion ID if provided)
    public boolean isPromoCodeUnique(String promoCode, int excludePromotionId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[promotion] WHERE [promo_code] = ? AND [promotion_id] != ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, promoCode);
            ps.setInt(2, excludePromotionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        }
        return true;
    }

    // Activate or deactivate a promotion
    public void setPromotionActive(int promotionId, boolean isActive) throws SQLException {
        String sql = "UPDATE [dbo].[promotion] SET [isActive] = ? WHERE [promotion_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBoolean(1, isActive);
            ps.setInt(2, promotionId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No promotion found with ID: " + promotionId);
            }
        }
    }

    public List<Promotion> getActivePromotions() throws SQLException {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[promotion] WHERE [isActive] = 1 AND [start_date] <= GETDATE() "
                + "AND ([end_date] IS NULL OR [end_date] >= GETDATE())";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Promotion promotion = new Promotion();
                    promotion.setPromotionId(rs.getInt("promotion_id"));
                    promotion.setPromotionType(rs.getString("promotion_type"));
                    promotion.setTitle(rs.getString("title"));
                    promotion.setPromoCode(rs.getString("promo_code"));
                    promotion.setQuantity(rs.getInt("quantity"));
                    promotion.setDescription(rs.getString("description"));
                    promotion.setDiscountPercent(rs.getDouble("discount_percent"));
                    promotion.setMaxDiscountAmount(rs.getDouble("max_discount_amount"));
                    Timestamp startDate = rs.getTimestamp("start_date");
                    promotion.setStartDate(startDate != null ? new Date(startDate.getTime()) : null);
                    Timestamp endDate = rs.getTimestamp("end_date");
                    promotion.setEndDate(endDate != null ? new Date(endDate.getTime()) : null);
                    promotion.setActive(rs.getBoolean("isActive"));
                    promotion.setCreatedAt(new Date(rs.getTimestamp("created_at").getTime()));
                    promotions.add(promotion);
                }
            }
        }
        return promotions;
    }

    // Helper method to map ResultSet to Promotion object
    private Promotion mapResultSetToPromotion(ResultSet rs) throws SQLException {
        Promotion promotion = new Promotion();
        promotion.setPromotionId(rs.getInt("promotion_id"));
        promotion.setPromotionType(rs.getString("promotion_type"));
        promotion.setTitle(rs.getString("title"));
        promotion.setPromoCode(rs.getString("promo_code"));
        promotion.setQuantity(rs.getInt("quantity"));
        promotion.setDescription(rs.getString("description"));
        promotion.setDiscountPercent(rs.getDouble("discount_percent"));
        promotion.setMaxDiscountAmount(rs.getDouble("max_discount_amount"));
        Timestamp startDate = rs.getTimestamp("start_date");
        promotion.setStartDate(startDate != null ? new Date(startDate.getTime()) : null);
        Timestamp endDate = rs.getTimestamp("end_date");
        promotion.setEndDate(endDate != null ? new Date(endDate.getTime()) : null);
        promotion.setActive(rs.getBoolean("isActive"));
        promotion.setCreatedAt(new Date(rs.getTimestamp("created_at").getTime()));
        return promotion;
    }

    public int countFilteredPromotions(String type) throws SQLException {
        String sql = """
        SELECT COUNT(*) FROM promotion
        WHERE end_date >= GETDATE()
          AND start_date <= GETDATE()
          AND isActive = 1
    """;

        boolean hasTypeFilter = type != null && !type.equalsIgnoreCase("all");
        if (hasTypeFilter) {
            sql += " AND promotion_type = ?";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            if (hasTypeFilter) {
                ps.setString(1, type);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }

    public List<Promotion> getSortedActivePromotions(
            String type,
            String sortEndDate,
            String sortDiscountPercent,
            String sortMaxDiscount,
            String sortRemaining,
            int top,
            int pageIndex
    ) throws SQLException {
        List<Promotion> promotions = new ArrayList<>();

        String baseSql = """
        WITH promo_usage AS (
            SELECT promotion_id, COUNT(*) AS usedCount
            FROM [transaction]
            GROUP BY promotion_id
        )
        SELECT p.*, 
               ISNULL(promo_usage.usedCount, 0) AS usedCount
        FROM promotion p
        LEFT JOIN promo_usage ON p.promotion_id = promo_usage.promotion_id
        WHERE p.end_date >= GETDATE()
          AND p.start_date <= GETDATE()
          AND p.isActive = 1
    """;

        StringBuilder sql = new StringBuilder(baseSql);
        boolean hasTypeFilter = type != null && !type.equalsIgnoreCase("all");
        if (hasTypeFilter) {
            sql.append(" AND p.promotion_type = ? ");
        }

        // 🧭 Sorting
        List<String> orderClauses = new ArrayList<>();
        if (sortEndDate != null && !sortEndDate.isBlank()) {
            orderClauses.add("p.end_date " + ("asc".equalsIgnoreCase(sortEndDate) ? "ASC" : "DESC"));
        }
        if (sortDiscountPercent != null && !sortDiscountPercent.isBlank()) {
            orderClauses.add("p.discount_percent " + ("asc".equalsIgnoreCase(sortDiscountPercent) ? "ASC" : "DESC"));
        }
        if (sortMaxDiscount != null && !sortMaxDiscount.isBlank()) {
            orderClauses.add("p.max_discount_amount " + ("asc".equalsIgnoreCase(sortMaxDiscount) ? "ASC" : "DESC"));
        }
        if (sortRemaining != null && !sortRemaining.isBlank()) {
            orderClauses.add("(p.quantity - ISNULL(promo_usage.usedCount, 0)) " + ("asc".equalsIgnoreCase(sortRemaining) ? "ASC" : "DESC"));
        }

        if (!orderClauses.isEmpty()) {
            sql.append(" ORDER BY ").append(String.join(", ", orderClauses));
        } else {
            sql.append(" ORDER BY p.created_at DESC");
        }

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (hasTypeFilter) {
                ps.setString(paramIndex++, type);
            }
            ps.setInt(paramIndex++, (pageIndex - 1) * top);
            ps.setInt(paramIndex, top);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Promotion promotion = new Promotion();

                    // Core fields
                    promotion.setPromotionId(rs.getInt("promotion_id"));
                    promotion.setPromotionType(rs.getString("promotion_type"));
                    promotion.setTitle(rs.getString("title"));
                    promotion.setPromoCode(rs.getString("promo_code"));

                    // Remaining quantity calculation
                    int originalQuantity = rs.getInt("quantity");
                    int usedCount = rs.getInt("usedCount");
                    promotion.setQuantity(Math.max(originalQuantity - usedCount, 0));

                    // More fields
                    promotion.setDescription(rs.getString("description"));
                    promotion.setDiscountPercent(rs.getDouble("discount_percent"));
                    promotion.setMaxDiscountAmount(rs.getDouble("max_discount_amount"));

                    Timestamp startDate = rs.getTimestamp("start_date");
                    promotion.setStartDate(startDate != null ? new Date(startDate.getTime()) : null);

                    Timestamp endDate = rs.getTimestamp("end_date");
                    promotion.setEndDate(endDate != null ? new Date(endDate.getTime()) : null);

                    promotion.setActive(rs.getBoolean("isActive"));
                    promotion.setCreatedAt(new Date(rs.getTimestamp("created_at").getTime()));

                    promotions.add(promotion);
                }
            }
        }

        return promotions;
    }
}
