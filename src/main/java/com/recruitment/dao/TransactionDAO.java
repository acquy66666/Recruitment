package com.recruitment.dao;

import com.recruitment.model.RevenueByMonthDTO;
import com.recruitment.model.Transaction;
import com.recruitment.model.TransactionReportDTO;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Data Access Object for managing Transaction entities in the database.
 */
public class TransactionDAO extends DBcontext {

    // Insert a new transaction
    public int insertTransaction(Transaction transaction) throws SQLException {
        String sql = "INSERT INTO [dbo].[transaction] ([recruiter_id], [promotion_id], [price], "
                + "[transaction_date], [payment_method], [status], [order_id], [vnp_txn_ref], "
                + "[vnp_transaction_no], [json]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, transaction.getRecruiterId());
            setNullableInt(ps, 2, transaction.getPromotionId());
            ps.setDouble(3, transaction.getPrice());
            ps.setTimestamp(4, toTimestamp(transaction.getTransactionDate()));
            ps.setString(5, transaction.getPaymentMethod());
            ps.setString(6, transaction.getStatus());
            ps.setString(7, transaction.getOrderId());
            ps.setString(8, transaction.getVnp_TxnRef());
            ps.setString(9, transaction.getVnp_TransactionNo());
            ps.setString(10, transaction.getJson());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Inserting transaction failed, no rows affected.");
            }
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated transaction_id
                }
            }
        }
        return -1; // If failed
    }

    // Update an existing transaction
    public boolean updateTransaction(Transaction transaction) throws SQLException {
        if (transaction == null) {
            return false; // Invalid input
        }

        String sql = "UPDATE [dbo].[transaction] SET [status] = ?, [vnp_transaction_no] = ?, [json] = ?, [order_id] = ?, [price] = ?, [payment_method] = ?, [transaction_date] = ?, [vnp_txn_ref] = ? WHERE [transaction_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, transaction.getStatus());
            ps.setString(2, transaction.getVnp_TransactionNo() != null ? transaction.getVnp_TransactionNo() : "");
            ps.setString(3, transaction.getJson() != null ? transaction.getJson() : "");
            ps.setString(4, transaction.getOrderId() != null ? transaction.getOrderId() : "");
            ps.setDouble(5, transaction.getPrice());
            ps.setString(6, transaction.getPaymentMethod() != null ? transaction.getPaymentMethod() : "");
            ps.setTimestamp(7, transaction.getTransactionDate() != null ? java.sql.Timestamp.valueOf(transaction.getTransactionDate()) : null);
            ps.setString(8, transaction.getVnp_TxnRef() != null ? transaction.getVnp_TxnRef() : "");
            ps.setInt(9, transaction.getTransactionId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Update transaction status and VNPay transaction number by vnp_txn_ref
    public boolean updateTransactionStatus(String vnpTxnRef, String status, String vnpTransactionNo, String responseJson) throws SQLException {
        if (vnpTxnRef == null || status == null) {
            return false; // Invalid input parameters
        }

        String sql = "UPDATE [dbo].[transaction] SET [status] = ?, [vnp_transaction_no] = ?, [json] = ? WHERE [vnp_txn_ref] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, vnpTransactionNo != null ? vnpTransactionNo : "");
            ps.setString(3, responseJson != null ? responseJson : "");
            ps.setString(4, vnpTxnRef);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Update transaction status by order_id
    public void updateTransactionStatusByOrderId(String orderId, String status, String vnpTransactionNo, String responseJson) throws SQLException {
        String sql = "UPDATE [dbo].[transaction] SET [status] = ?, [vnp_transaction_no] = ?, [json] = ? "
                + "WHERE [order_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, vnpTransactionNo);
            ps.setString(3, responseJson);
            ps.setString(4, orderId);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No transactions found with order_id: " + orderId);
            }
        }
    }

    // Delete a transaction by ID
    public void deleteTransaction(int transactionId) throws SQLException {
        String sql = "DELETE FROM [dbo].[transaction] WHERE [transaction_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, transactionId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No transaction found with ID: " + transactionId);
            }
        }
    }

    // Get a transaction by ID
    public Transaction getTransactionById(int transactionId) throws SQLException {
        String sql = "SELECT * FROM [dbo].[transaction] WHERE [transaction_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, transactionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTransaction(rs);
                }
            }
        }
        return null;
    }

    // Get transaction by VNPay transaction reference
    public Transaction getTransactionByVnpTxnRef(String vnpTxnRef) throws SQLException {
        String sql = "SELECT * FROM [dbo].[transaction] WHERE [vnp_txn_ref] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, vnpTxnRef);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTransaction(rs);
                }
            }
        }
        return null;
    }

    // Get transaction by order ID (returns first transaction)
    public Transaction getTransactionByOrderId(String orderId) throws SQLException {
        String sql = "SELECT * FROM [dbo].[transaction] WHERE [order_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTransaction(rs);
                }
            }
        }
        return null;
    }

    // Get all transactions by order ID
    public List<Transaction> getTransactionsByOrderId(String orderId) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[transaction] WHERE [order_id] = ? ORDER BY [transaction_id]";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    transactions.add(mapResultSetToTransaction(rs));
                }
            }
        }
        return transactions;
    }

    // Get transactions by recruiter ID
    public List<Transaction> getTransactionsByRecruiterId(int recruiterId) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[transaction] WHERE [recruiter_id] = ? ORDER BY [transaction_date] DESC";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    transactions.add(mapResultSetToTransaction(rs));
                }
            }
        }
        return transactions;
    }

    // Helper method to map ResultSet to Transaction object
    private Transaction mapResultSetToTransaction(ResultSet rs) throws SQLException {
        Transaction transaction = new Transaction();
        transaction.setTransactionId(rs.getInt("transaction_id"));
        transaction.setRecruiterId(rs.getInt("recruiter_id"));
        int promotionId = rs.getInt("promotion_id");
        if (rs.wasNull()) {
            transaction.setPromotionId(0);
        } else {
            transaction.setPromotionId(promotionId);
        }
        transaction.setPrice(rs.getDouble("price"));
        Timestamp transactionDate = rs.getTimestamp("transaction_date");
        transaction.setTransactionDate(transactionDate != null ? transactionDate.toLocalDateTime() : null);
        transaction.setPaymentMethod(rs.getString("payment_method"));
        transaction.setStatus(rs.getString("status"));
        transaction.setOrderId(rs.getString("order_id"));
        transaction.setVnp_TxnRef(rs.getString("vnp_txn_ref"));
        transaction.setVnp_TransactionNo(rs.getString("vnp_transaction_no"));
        transaction.setJson(rs.getString("json"));
        return transaction;
    }

    // Helper method to set nullable integer in PreparedStatement
    private void setNullableInt(PreparedStatement ps, int index, int value) throws SQLException {
        if (value == 0) {
            ps.setNull(index, java.sql.Types.INTEGER);
        } else {
            ps.setInt(index, value);
        }
    }

    // Helper method to convert LocalDateTime to Timestamp
    private Timestamp toTimestamp(LocalDateTime dateTime) {
        return dateTime != null ? Timestamp.valueOf(dateTime) : null;
    }

    public List<TransactionReportDTO> getFilteredTransactions(String search, BigDecimal minTotal, BigDecimal maxTotal,
            String status, String sortDate, String promotion) {
        List<TransactionReportDTO> list = new ArrayList<>();
        String sql = "SELECT t.transaction_id, r.company_name, s.title AS service_title, td.unit_price, "
                + "p.title AS promotion_title, t.price, t.transaction_date, "
                + "t.payment_method, t.status "
                + "FROM [transaction] t "
                + "JOIN recruiter r ON t.recruiter_id = r.recruiter_id "
                + "JOIN transaction_detail td ON t.transaction_id = td.transaction_id "
                + "JOIN service s ON td.service_id = s.service_id "
                + "LEFT JOIN promotion p ON t.promotion_id = p.promotion_id "
                + "WHERE 1=1 ";

        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql += "AND (r.company_name LIKE ? OR s.title LIKE ?) ";
            String keyword = "%" + search.trim() + "%";
            params.add(keyword);
            params.add(keyword);
        }

        if (minTotal != null) {
            sql += "AND t.price >= ? ";
            params.add(minTotal);
        }

        if (maxTotal != null) {
            sql += "AND t.price <= ? ";
            params.add(maxTotal);
        }
        if (status != null && !status.trim().isEmpty() && !"all".equalsIgnoreCase(status)) {
            sql += "AND t.status = ? ";
            params.add(status.trim());
        }

        if (promotion != null && !promotion.trim().isEmpty() && !promotion.equalsIgnoreCase("all")) {
            if (promotion.equalsIgnoreCase("yes")) {
                sql += "AND t.promotion_id IS NOT NULL ";
            } else if (promotion.equalsIgnoreCase("no")) {
                sql += "AND t.promotion_id IS NULL ";
            }
        }

        if (sortDate != null && sortDate.equalsIgnoreCase("asc")) {
            sql += "ORDER BY t.transaction_date ASC";
        } else {
            sql += "ORDER BY t.transaction_date DESC";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TransactionReportDTO dto = new TransactionReportDTO(
                        rs.getInt("transaction_id"),
                        rs.getString("company_name"),
                        rs.getString("service_title"),
                        rs.getBigDecimal("unit_price"),
                        rs.getString("promotion_title"),
                        rs.getBigDecimal("price"),
                        rs.getTimestamp("transaction_date").toLocalDateTime(),
                        rs.getString("payment_method"),
                        rs.getString("status")
                );
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<TransactionReportDTO> getListTransactionReportByPage(List<TransactionReportDTO> list, int start, int end) {
        ArrayList<TransactionReportDTO> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<RevenueByMonthDTO> getRevenueListByPage(List<RevenueByMonthDTO> list, int start, int end) {
        ArrayList<RevenueByMonthDTO> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<String> getAvailableRevenueMonths() {
        List<String> months = new ArrayList<>();
        String sql = "SELECT DISTINCT FORMAT(transaction_date, 'MM-yyyy') AS month "
                + "FROM [transaction] "
                + "WHERE status = 'success' "
                + "ORDER BY month DESC";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                months.add(rs.getString("month"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return months;
    }

    public List<RevenueByMonthDTO> getFilteredRevenueByMonth(
            String searchMonth,
            BigDecimal minRevenue,
            BigDecimal maxRevenue,
            String promotion,
            String sortByRevenue
    ) {
        List<RevenueByMonthDTO> list = new ArrayList<>();
        String sql = "SELECT FORMAT(t.transaction_date, 'MM-yyyy') AS month, "
                + "       COUNT(DISTINCT t.transaction_id) AS transaction_count, "
                + "       COUNT(DISTINCT t.recruiter_id) AS recruiter_count, "
                + "       COUNT(td.service_id) AS total_service_count, "
                + "       SUM(td.unit_price) AS total_before_discount, "
                + "       SUM(td.unit_price) - SUM(t.price) AS discount_amount, "
                + "       SUM(t.price) AS net_revenue "
                + "FROM [transaction] t "
                + "JOIN transaction_detail td ON t.transaction_id = td.transaction_id "
                + "WHERE t.status = 'success' ";

        List<Object> params = new ArrayList<>();

        // Lọc theo tháng
        if (searchMonth != null && !searchMonth.trim().isEmpty()) {
            sql += "AND FORMAT(t.transaction_date, 'MM-yyyy') = ? ";
            params.add(searchMonth.trim());
        }

        // Lọc theo khuyến mãi
        if (promotion != null && !promotion.equalsIgnoreCase("all")) {
            if (promotion.equalsIgnoreCase("yes")) {
                sql += "AND t.promotion_id IS NOT NULL ";
            } else if (promotion.equalsIgnoreCase("no")) {
                sql += "AND t.promotion_id IS NULL ";
            }
        }

        sql += "GROUP BY FORMAT(t.transaction_date, 'MM-yyyy') ";

// ✅ Luôn bọc subquery, bất kể có lọc theo doanh thu hay không
        sql = "SELECT * FROM (" + sql + ") AS temp WHERE 1=1 ";

        if (minRevenue != null) {
            sql += " AND temp.net_revenue >= ? ";
            params.add(minRevenue);
        }
        if (maxRevenue != null) {
            sql += " AND temp.net_revenue <= ? ";
            params.add(maxRevenue);
        }

        // Sắp xếp
        if (sortByRevenue != null) {
            switch (sortByRevenue) {
                case "month_asc":
                    sql += " ORDER BY temp.month ASC ";
                    break;
                case "month_desc":
                    sql += " ORDER BY temp.month DESC ";
                    break;
                case "revenue_asc":
                    sql += " ORDER BY temp.net_revenue ASC ";
                    break;
                case "revenue_desc":
                    sql += " ORDER BY temp.net_revenue DESC ";
                    break;
                case "service_asc":
                    sql += " ORDER BY temp.total_service_count ASC ";
                    break;
                case "service_desc":
                    sql += " ORDER BY temp.total_service_count DESC ";
                    break;
                default:
                    sql += " ORDER BY temp.month ASC ";
            }
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RevenueByMonthDTO dto = new RevenueByMonthDTO();
                dto.setMonth(rs.getString("month"));
                dto.setTransactionCount(rs.getInt("transaction_count"));
                dto.setRecruiterCount(rs.getInt("recruiter_count"));
                dto.setTotalServiceCount(rs.getInt("total_service_count"));
                // Tránh null
                BigDecimal beforeDiscount = rs.getBigDecimal("total_before_discount");
                dto.setTotalBeforeDiscount(beforeDiscount != null ? beforeDiscount : BigDecimal.ZERO);

                BigDecimal discount = rs.getBigDecimal("discount_amount");
                dto.setDiscountAmount(discount != null ? discount : BigDecimal.ZERO);

                BigDecimal net = rs.getBigDecimal("net_revenue");
                dto.setNetRevenue(net != null ? net : BigDecimal.ZERO);
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<RevenueByMonthDTO> getFilteredRevenueByDateRange(
            Date fromDate,
            Date toDate,
            BigDecimal minRevenue,
            BigDecimal maxRevenue,
            String promotion,
            String sortByRevenue
    ) {
        List<RevenueByMonthDTO> list = new ArrayList<>();
        String sql = "SELECT CAST(t.transaction_date AS DATE) AS transaction_date, "
                + "       COUNT(DISTINCT t.transaction_id) AS transaction_count, "
                + "       COUNT(DISTINCT t.recruiter_id) AS recruiter_count, "
                + "       COUNT(td.service_id) AS total_service_count, "
                + "       SUM(td.unit_price) AS total_before_discount, "
                + "       SUM(td.unit_price) - SUM(t.price) AS discount_amount, "
                + "       SUM(t.price) AS net_revenue "
                + "FROM [transaction] t "
                + "JOIN transaction_detail td ON t.transaction_id = td.transaction_id "
                + "WHERE t.status = 'success' ";

        List<Object> params = new ArrayList<>();

        // Lọc theo khoảng ngày
        if (fromDate != null) {
            sql += "AND CAST(t.transaction_date AS DATE) >= ? ";
            params.add(fromDate);
        }
        if (toDate != null) {
            sql += "AND CAST(t.transaction_date AS DATE) <= ? ";
            params.add(toDate);
        }

        // Lọc theo khuyến mãi
        if (promotion != null && !promotion.equalsIgnoreCase("all")) {
            if (promotion.equalsIgnoreCase("yes")) {
                sql += "AND t.promotion_id IS NOT NULL ";
            } else if (promotion.equalsIgnoreCase("no")) {
                sql += "AND t.promotion_id IS NULL ";
            }
        }

        // Gộp theo ngày
        sql += "GROUP BY CAST(t.transaction_date AS DATE) ";

        // Bọc subquery để lọc tiếp theo doanh thu
        sql = "SELECT * FROM (" + sql + ") AS temp WHERE 1=1 ";

        if (minRevenue != null) {
            sql += "AND temp.net_revenue >= ? ";
            params.add(minRevenue);
        }
        if (maxRevenue != null) {
            sql += "AND temp.net_revenue <= ? ";
            params.add(maxRevenue);
        }

        // Sắp xếp
        if (sortByRevenue != null) {
            switch (sortByRevenue) {
                case "month_asc":
                    sql += " ORDER BY temp.transaction_date ASC ";
                    break;
                case "month_desc":
                    sql += " ORDER BY temp.transaction_date DESC ";
                    break;
                case "revenue_asc":
                    sql += " ORDER BY temp.net_revenue ASC ";
                    break;
                case "revenue_desc":
                    sql += " ORDER BY temp.net_revenue DESC ";
                    break;
                case "service_asc":
                    sql += " ORDER BY temp.total_service_count ASC ";
                    break;
                case "service_desc":
                    sql += " ORDER BY temp.total_service_count DESC ";
                    break;
                default:
                    sql += " ORDER BY temp.transaction_date ASC ";
            }
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();

//            BigDecimal totalBeforeDiscount = BigDecimal.ZERO;
//            BigDecimal totalDiscount = BigDecimal.ZERO;
//            BigDecimal totalNetRevenue = BigDecimal.ZERO;
//            int totalTransactionCount = 0;
//            int totalRecruiterCount = 0;
//            int totalServiceCount = 0;
            while (rs.next()) {
                RevenueByMonthDTO dto = new RevenueByMonthDTO();
                dto.setTransactionDate(rs.getDate("transaction_date"));
                dto.setTransactionCount(rs.getInt("transaction_count"));
                dto.setRecruiterCount(rs.getInt("recruiter_count"));
                dto.setTotalServiceCount(rs.getInt("total_service_count"));

                BigDecimal beforeDiscount = rs.getBigDecimal("total_before_discount");
                dto.setTotalBeforeDiscount(beforeDiscount != null ? beforeDiscount : BigDecimal.ZERO);

                BigDecimal discount = rs.getBigDecimal("discount_amount");
                dto.setDiscountAmount(discount != null ? discount : BigDecimal.ZERO);

                BigDecimal net = rs.getBigDecimal("net_revenue");
                dto.setNetRevenue(net != null ? net : BigDecimal.ZERO);

//                // 👉 Cộng dồn
//                totalTransactionCount += dto.getTransactionCount();
//                totalRecruiterCount += dto.getRecruiterCount();
//                totalServiceCount += dto.getTotalServiceCount();
//                totalBeforeDiscount = totalBeforeDiscount.add(dto.getTotalBeforeDiscount());
//                totalDiscount = totalDiscount.add(dto.getDiscountAmount());
//                totalNetRevenue = totalNetRevenue.add(dto.getNetRevenue());
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<String> getAllPaymentMethods() throws SQLException {
        List<String> paymentMethods = new ArrayList<>();
        String sql = "SELECT DISTINCT payment_method FROM [transaction]";

        try (PreparedStatement stmt = c.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String method = rs.getString("payment_method");
                if (method != null && !method.trim().isEmpty()) {
                    paymentMethods.add(method);
                }
            }
        }
        return paymentMethods;
    }

    public List<Transaction> getFilteredTransactionsByRecruiter(int recruiterId, String payMethod, String time, String sortDate, String sortPrice, int top, int pageIndex) {
        List<Transaction> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM [transaction] WHERE recruiter_id = ?");

        // Apply time filtering
        switch (time.toLowerCase()) {
            case "month":
                sql.append(" AND MONTH(transaction_date) = MONTH(GETDATE()) AND YEAR(transaction_date) = YEAR(GETDATE())");
                break;
            case "quarter":
                sql.append(" AND DATEPART(QUARTER, transaction_date) = DATEPART(QUARTER, GETDATE()) AND YEAR(transaction_date) = YEAR(GETDATE())");
                break;
            case "year":
                sql.append(" AND YEAR(transaction_date) = YEAR(GETDATE())");
                break;
            // "all" → no additional condition
        }

        boolean filterPayment = !"all".equalsIgnoreCase(payMethod);
        if (filterPayment) {
            sql.append(" AND payment_method = ?");
        }

        // Sorting
        List<String> order = new ArrayList<>();
        if ("asc".equalsIgnoreCase(sortDate)) {
            order.add("transaction_date ASC");
        } else {
            order.add("transaction_date DESC"); // default
        }
        if ("asc".equalsIgnoreCase(sortPrice)) {
            order.add("price ASC");
        } else if ("desc".equalsIgnoreCase(sortPrice)) {
            order.add("price DESC");
        }

        if (!order.isEmpty()) {
            sql.append(" ORDER BY ").append(String.join(", ", order));
        }

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            int index = 1;
            st.setInt(index++, recruiterId);
            if (filterPayment) {
                st.setString(index++, payMethod);
            }
            st.setInt(index++, (pageIndex - 1) * top); // OFFSET
            st.setInt(index, top);                     // FETCH NEXT

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Transaction t = new Transaction();
                    t.setTransactionId(rs.getInt("transaction_id"));
                    t.setRecruiterId(rs.getInt("recruiter_id"));
                    t.setPromotionId(rs.getInt("promotion_id"));
                    t.setPrice(rs.getDouble("price"));
                    t.setTransactionDate(rs.getTimestamp("transaction_date").toLocalDateTime());
                    t.setPaymentMethod(rs.getString("payment_method"));
                    t.setStatus(rs.getString("status"));
                    list.add(t);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countFilteredTransactionsByRecruiter(int recruiterId, String time, String payMethod) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [transaction] WHERE recruiter_id = ?");

        // Apply time filter
        switch (time.toLowerCase()) {
            case "month":
                sql.append(" AND MONTH(transaction_date) = MONTH(GETDATE()) AND YEAR(transaction_date) = YEAR(GETDATE())");
                break;
            case "quarter":
                sql.append(" AND DATEPART(QUARTER, transaction_date) = DATEPART(QUARTER, GETDATE()) AND YEAR(transaction_date) = YEAR(GETDATE())");
                break;
            case "year":
                sql.append(" AND YEAR(transaction_date) = YEAR(GETDATE())");
                break;
            // "all" → no additional condition
        }

        // Apply payment method filter
        if (!"all".equalsIgnoreCase(payMethod)) {
            sql.append(" AND payment_method = ?");
        }

        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            st.setInt(1, recruiterId);
            if (!"all".equalsIgnoreCase(payMethod)) {
                st.setString(2, payMethod);
            }

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public Map<String, Double> getMonthlyRevenueByRecruiter(int recruiterId, int monthsBack) {
        Map<String, Double> monthlyRevenue = new LinkedHashMap<>();
        String sql = "SELECT FORMAT(transaction_date, 'MM/yyyy') AS monthYear, SUM(price) AS total "
                + "FROM [transaction] "
                + "WHERE recruiter_id = ? AND transaction_date >= DATEADD(MONTH, -?, GETDATE()) "
                + "GROUP BY FORMAT(transaction_date, 'MM/yyyy') "
                + "ORDER BY MIN(transaction_date)";

        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, recruiterId);
            st.setInt(2, monthsBack);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    String label = rs.getString("monthYear");
                    double amount = rs.getDouble("total");
                    monthlyRevenue.put(label, amount);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return monthlyRevenue;
    }

    public Map<String, Double> getMonthlyComparisonReport(int recruiterId) {
        Map<String, Double> report = new HashMap<>();

        String currentMonthSql = "SELECT SUM(price) AS totalSpent, COUNT(*) AS totalTransactions, AVG(price) AS averageSpending "
                + "FROM [transaction] "
                + "WHERE recruiter_id = ? AND MONTH(transaction_date) = MONTH(GETDATE()) AND YEAR(transaction_date) = YEAR(GETDATE())";

        String lastMonthSql = "SELECT SUM(price) AS totalSpent, COUNT(*) AS totalTransactions, AVG(price) AS averageSpending "
                + "FROM [transaction] "
                + "WHERE recruiter_id = ? AND MONTH(transaction_date) = MONTH(DATEADD(MONTH, -1, GETDATE())) AND YEAR(transaction_date) = YEAR(DATEADD(MONTH, -1, GETDATE()))";

        try (PreparedStatement currentStmt = c.prepareStatement(currentMonthSql); PreparedStatement lastStmt = c.prepareStatement(lastMonthSql)) {

            currentStmt.setInt(1, recruiterId);
            lastStmt.setInt(1, recruiterId);

            ResultSet currentRs = currentStmt.executeQuery();
            ResultSet lastRs = lastStmt.executeQuery();

            if (currentRs.next() && lastRs.next()) {
                double currentSpent = currentRs.getDouble("totalSpent");
                double currentCount = currentRs.getDouble("totalTransactions");
                double currentAvg = currentRs.getDouble("averageSpending");

                double lastSpent = lastRs.getDouble("totalSpent");
                double lastCount = lastRs.getDouble("totalTransactions");
                double lastAvg = lastRs.getDouble("averageSpending");

                report.put("totalSpent", currentSpent);
                report.put("totalTransactions", currentCount);
                report.put("averageSpending", currentAvg);

                // Calculate % changes
                report.put("changeSpent", lastSpent == 0 ? 0 : ((currentSpent - lastSpent) / lastSpent) * 100);
                report.put("changeCount", lastCount == 0 ? 0 : ((currentCount - lastCount) / lastCount) * 100);
                report.put("changeAvg", lastAvg == 0 ? 0 : ((currentAvg - lastAvg) / lastAvg) * 100);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return report;
    }

    public List<TransactionReportDTO> getFilteredTransactionsNew(String search, BigDecimal minTotal, BigDecimal maxTotal,
            String status, String sortDate, String promotion, Date fromDate, Date toDate) {

        List<TransactionReportDTO> list = new ArrayList<>();
        String sql = "SELECT t.transaction_id, r.company_name, s.title AS service_title, td.unit_price, "
                + "p.title AS promotion_title, t.price, t.transaction_date, "
                + "t.payment_method, t.status "
                + "FROM [transaction] t "
                + "JOIN recruiter r ON t.recruiter_id = r.recruiter_id "
                + "JOIN transaction_detail td ON t.transaction_id = td.transaction_id "
                + "JOIN service s ON td.service_id = s.service_id "
                + "LEFT JOIN promotion p ON t.promotion_id = p.promotion_id "
                + "WHERE 1=1 ";

        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql += "AND (r.company_name LIKE ? OR s.title LIKE ?) ";
            String keyword = "%" + search.trim() + "%";
            params.add(keyword);
            params.add(keyword);
        }

        if (minTotal != null) {
            sql += "AND t.price >= ? ";
            params.add(minTotal);
        }

        if (maxTotal != null) {
            sql += "AND t.price <= ? ";
            params.add(maxTotal);
        }

        if (status != null && !status.trim().isEmpty() && !"all".equalsIgnoreCase(status)) {
            sql += "AND t.status = ? ";
            params.add(status.trim());
        }

        if (promotion != null && !promotion.trim().isEmpty() && !promotion.equalsIgnoreCase("all")) {
            if (promotion.equalsIgnoreCase("yes")) {
                sql += "AND t.promotion_id IS NOT NULL ";
            } else if (promotion.equalsIgnoreCase("no")) {
                sql += "AND t.promotion_id IS NULL ";
            }
        }

        if (fromDate != null) {
            sql += "AND CAST(t.transaction_date AS DATE) >= ? ";
            params.add(fromDate);
        }
        if (toDate != null) {
            sql += "AND CAST(t.transaction_date AS DATE) <= ? ";
            params.add(toDate);
        }

        if (sortDate != null && sortDate.equalsIgnoreCase("asc")) {
            sql += "ORDER BY t.transaction_date ASC";
        } else {
            sql += "ORDER BY t.transaction_date DESC";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TransactionReportDTO dto = new TransactionReportDTO(
                        rs.getInt("transaction_id"),
                        rs.getString("company_name"),
                        rs.getString("service_title"),
                        rs.getBigDecimal("unit_price"),
                        rs.getString("promotion_title"),
                        rs.getBigDecimal("price"),
                        rs.getTimestamp("transaction_date").toLocalDateTime(),
                        rs.getString("payment_method"),
                        rs.getString("status")
                );
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static void main(String[] args) {
        TransactionDAO tran = new TransactionDAO();
        var list = tran.getFilteredTransactionsNew(
                null, null, null,
                null, null, null,
                java.sql.Date.valueOf("2025-07-13"), java.sql.Date.valueOf("2025-07-16"));
        for (TransactionReportDTO revenueByMonthDTO : list) {
            System.out.println(revenueByMonthDTO.toString());
        }
    }

}
