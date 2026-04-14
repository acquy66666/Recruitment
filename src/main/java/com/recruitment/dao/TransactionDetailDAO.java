package com.recruitment.dao;

import com.recruitment.model.TransactionDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for managing TransactionDetail entities in the database.
 */
public class TransactionDetailDAO extends DBcontext {

    // Insert a new transaction detail
    public int insertTransactionDetail(TransactionDetail detail) throws SQLException {
        String sql = "INSERT INTO [dbo].[transaction_detail] ([transaction_id], [service_id], [unit_price]) " +
                     "VALUES (?, ?, ?)";
        try (PreparedStatement ps = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, detail.getTransactionId());
            ps.setInt(2, detail.getServiceId());
            ps.setDouble(3, detail.getUnitPrice());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Inserting transaction detail failed, no rows affected.");
            }
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated detail_id
                }
            }
        }
        return -1; // If failed
    }

    // Update an existing transaction detail
    public void updateTransactionDetail(TransactionDetail detail) throws SQLException {
        String sql = "UPDATE [dbo].[transaction_detail] SET [transaction_id] = ?, [service_id] = ?, [unit_price] = ? " +
                     "WHERE [detail_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, detail.getTransactionId());
            ps.setInt(2, detail.getServiceId());
            ps.setDouble(3, detail.getUnitPrice());
            ps.setInt(4, detail.getDetailId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No transaction detail found with ID: " + detail.getDetailId());
            }
        }
    }

    // Delete a transaction detail by ID
    public void deleteTransactionDetail(int detailId) throws SQLException {
        String sql = "DELETE FROM [dbo].[transaction_detail] WHERE [detail_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, detailId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No transaction detail found with ID: " + detailId);
            }
        }
    }

    // Get a transaction detail by ID
    public TransactionDetail getTransactionDetailById(int detailId) throws SQLException {
        String sql = "SELECT * FROM [dbo].[transaction_detail] WHERE [detail_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, detailId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTransactionDetail(rs);
                }
            }
        }
        return null;
    }

    // Get all transaction details for a transaction
    public List<TransactionDetail> getDetailsByTransactionId(int transactionId) throws SQLException {
        List<TransactionDetail> details = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[transaction_detail] WHERE [transaction_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, transactionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    details.add(mapResultSetToTransactionDetail(rs));
                }
            }
        }
        return details;
    }

    // Helper method to map ResultSet to TransactionDetail object
    private TransactionDetail mapResultSetToTransactionDetail(ResultSet rs) throws SQLException {
        TransactionDetail detail = new TransactionDetail();
        detail.setDetailId(rs.getInt("detail_id"));
        detail.setTransactionId(rs.getInt("transaction_id"));
        detail.setServiceId(rs.getInt("service_id"));
        detail.setUnitPrice(rs.getDouble("unit_price"));
        return detail;
    }
}