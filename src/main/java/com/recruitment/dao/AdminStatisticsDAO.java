/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.TopStatDTO;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Mr Duc
 */
public class AdminStatisticsDAO extends DBcontext {

    public int getTotalCandidates() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM candidate where isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getTotalRecruiters() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM recruiter where isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getTotalJobPosts() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total\n"
                + "FROM job_post j\n"
                + "JOIN recruiter r ON j.recruiter_id = r.recruiter_id\n"
                + "WHERE j.status = N'Đã duyệt' AND r.isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getTotalJobPostsAll() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total\n"
                + "FROM job_post j\n"
                + "JOIN recruiter r ON j.recruiter_id = r.recruiter_id WHERE r.isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getTotalServices() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM service where isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getTotalActiveAccounts() {
        int total = 0;
        String sql = """
        SELECT COUNT(*) AS total FROM candidate WHERE isActive = 1
        UNION ALL
        SELECT COUNT(*) FROM recruiter WHERE isActive = 1
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                total += rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getTotalInactiveAccounts() {
        int total = 0;
        String sql = """
        SELECT COUNT(*) AS total FROM candidate WHERE isActive = 0
        UNION ALL
        SELECT COUNT(*) FROM recruiter WHERE isActive = 0
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                total += rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getApproveJobs() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total\n"
                + "    FROM job_post j\n"
                + "    JOIN recruiter r ON j.recruiter_id = r.recruiter_id\n"
                + "    WHERE j.status = N'Đã duyệt' AND r.isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getPendingJobs() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total\n"
                + "        FROM job_post j\n"
                + "        JOIN recruiter r ON j.recruiter_id = r.recruiter_id\n"
                + "        WHERE j.status = N'Chờ duyệt' AND r.isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getRejectedJobs() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total\n"
                + "        FROM job_post j\n"
                + "        JOIN recruiter r ON j.recruiter_id = r.recruiter_id\n"
                + "        WHERE j.status = N'Đã từ chối' AND r.isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getExpiredJobs() {
        int total = 0;
        String sql = "    SELECT COUNT(*) AS total\n"
                + "    FROM job_post j\n"
                + "    JOIN recruiter r ON j.recruiter_id = r.recruiter_id\n"
                + "    WHERE j.deadline < GETDATE() AND r.isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public int getTotalApplications() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total\n"
                + "        FROM application a\n"
                + "        JOIN candidate c ON a.candidate_id = c.candidate_id\n"
                + "        JOIN job_post j ON a.job_id = j.job_id\n"
                + "        JOIN recruiter r ON j.recruiter_id = r.recruiter_id\n"
                + "        WHERE c.isActive = 1 AND j.status = N'Đã duyệt' AND r.isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    public BigDecimal getTotalRevenue() {
        String sql = "SELECT SUM(price) AS total \n"
                + "FROM [transaction] \n"
                + "WHERE status = 'success';";
        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal("total") != null ? rs.getBigDecimal("total") : BigDecimal.ZERO;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
//Doanh thu tháng hiện tại

    public BigDecimal getCurrentMonthRevenue() {
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();
        int year = today.getYear();

        String sql = """
        SELECT SUM(price) AS total
        FROM [transaction]
        WHERE MONTH(transaction_date) = ? AND YEAR(transaction_date) = ? AND status = 'success'
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal("total") != null ? rs.getBigDecimal("total") : BigDecimal.ZERO;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return BigDecimal.ZERO;
    }
//Tổng số giao dịch trong tháng

    public int getCurrentMonthTransactionCount() {
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();
        int year = today.getYear();

        String sql = """
        SELECT COUNT(*) AS total
        FROM [transaction]
        WHERE MONTH(transaction_date) = ? AND YEAR(transaction_date) = ?
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getCurrentMonthTransactionCountSuccess() {
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();
        int year = today.getYear();

        String sql = """
        SELECT COUNT(*) AS total
        FROM [transaction]
        WHERE MONTH(transaction_date) = ? AND YEAR(transaction_date) = ? AND status = 'success'
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
//Doanh thu trung bình/tháng

    public BigDecimal getAverageRevenuePerMonth() {
        String sql = """
        SELECT AVG(monthly_total) AS avg_total
        FROM (
            SELECT YEAR(transaction_date) AS y, MONTH(transaction_date) AS m, SUM(price) AS monthly_total
            FROM [transaction] WHERE status = 'success'
            GROUP BY YEAR(transaction_date), MONTH(transaction_date)
        ) AS monthly_data
    """;
        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal("avg_total") != null ? rs.getBigDecimal("avg_total") : BigDecimal.ZERO;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
//Giao dịch trung bình/ngày

    public BigDecimal getAverageTransactionPerDay() {
        String sql = """
        SELECT CAST(COUNT(*) AS DECIMAL) / COUNT(DISTINCT CAST(transaction_date AS DATE)) AS avg_per_day
        FROM [transaction]
    """;
        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal("avg_per_day") != null ? rs.getBigDecimal("avg_per_day") : BigDecimal.ZERO;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
//Giá trị giao dịch trung bình

    public BigDecimal getAverageTransactionValue() {
        String sql = "SELECT AVG(price) AS avg_price FROM [transaction]  WHERE status = 'success' ";
        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal("avg_price") != null ? rs.getBigDecimal("avg_price") : BigDecimal.ZERO;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

//    public Map<String, Integer> getRevenueByMonth(int year) {
//        Map<String, Integer> result = new LinkedHashMap<>();
//
//        String sql = "SELECT MONTH(transaction_date) AS month, SUM(price) AS total "
//                + "FROM [transaction] "
//                + "WHERE YEAR(transaction_date) = ? "
//                + "GROUP BY MONTH(transaction_date) "
//                + "ORDER BY month";
//
//        try (PreparedStatement ps = c.prepareStatement(sql)) {
//            ps.setInt(1, year);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                int month = rs.getInt("month");
//                int total = rs.getInt("total");
//                result.put("Tháng " + month, total);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return result;
//    }
    public Map<String, Integer> getRevenueByMonth(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();

        String sql = "SELECT YEAR(transaction_date) AS year, MONTH(transaction_date) AS month, SUM(price) AS total "
                + "FROM [transaction] WHERE status = 'Success'";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(transaction_date AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(transaction_date AS DATE) <= ?";
        }

        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += " GROUP BY YEAR(transaction_date), MONTH(transaction_date) ORDER BY total ASC";
                break;
            case "DESC":
                sql += " GROUP BY YEAR(transaction_date), MONTH(transaction_date) ORDER BY total DESC";
                break;
            default:
                sql += " GROUP BY YEAR(transaction_date), MONTH(transaction_date) ORDER BY YEAR(transaction_date), MONTH(transaction_date)";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int year = rs.getInt("year");
                    int month = rs.getInt("month");
                    String key = String.format("%d-%02d", year, month); // Ví dụ: "2024-07"
                    map.put(key, rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

//    public Map<String, Integer> getJobPostCountByMonth(int year) {
//        Map<String, Integer> result = new LinkedHashMap<>();
//        String sql = "SELECT MONTH(created_at) AS month, COUNT(*) AS total "
//                + "FROM job_post "
//                + "WHERE YEAR(created_at) = ? "
//                + "GROUP BY MONTH(created_at) "
//                + "ORDER BY month";
//
//        try (PreparedStatement ps = c.prepareStatement(sql)) {
//            ps.setInt(1, year);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                int month = rs.getInt("month");
//                int total = rs.getInt("total");
//                result.put("Tháng " + month, total);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return result;
//    }
    public Map<String, Integer> getJobPostCountByMonth(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();

        String sql = "SELECT YEAR(j.created_at) AS year, MONTH(j.created_at) AS month, COUNT(*) AS count "
                + "FROM job_post j "
                + "JOIN recruiter r ON j.recruiter_id = r.recruiter_id "
                + "WHERE j.status = N'Đã duyệt' AND r.isActive = 1";

        if (fromDate != null && !fromDate.trim().isEmpty()) {
            sql += " AND CAST(j.created_at AS DATE) >= ?";
        }
        if (toDate != null && !toDate.trim().isEmpty()) {
            sql += " AND CAST(j.created_at AS DATE) <= ?";
        }

        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += " GROUP BY YEAR(j.created_at), MONTH(j.created_at) ORDER BY count ASC";
                break;
            case "DESC":
                sql += " GROUP BY YEAR(j.created_at), MONTH(j.created_at) ORDER BY count DESC";
                break;
            default:
                sql += " GROUP BY YEAR(j.created_at), MONTH(j.created_at) ORDER BY YEAR(j.created_at), MONTH(j.created_at)";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int index = 1;
            if (fromDate != null && !fromDate.trim().isEmpty()) {
                ps.setDate(index++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.trim().isEmpty()) {
                ps.setDate(index++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int year = rs.getInt("year");
                    int month = rs.getInt("month");
                    String key = String.format("%d-%02d", year, month);
                    map.put(key, rs.getInt("count"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

//    public Map<String, Integer> getJobPostByIndustry() {
//        Map<String, Integer> result = new LinkedHashMap<>();
//        String sql = "SELECT i.name AS industry, COUNT(*) AS total "
//                + "FROM job_post j JOIN industry i ON j.industry_id = i.industry_id "
//                + "GROUP BY i.name ORDER BY total DESC";
//
//        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
//            while (rs.next()) {
//                result.put(rs.getString("industry"), rs.getInt("total"));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return result;
//    }
    public Map<String, Integer> getJobCountByIndustry(String fromDate, String toDate) {
        Map<String, Integer> map = new LinkedHashMap<>();

        String sql = "SELECT i.name, COUNT(*) AS count "
                + "FROM job_post j "
                + "JOIN industry i ON j.industry_id = i.industry_id "
                + "JOIN recruiter r ON j.recruiter_id = r.recruiter_id "
                + "WHERE j.status = N'Đã duyệt' AND r.isActive = 1";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(j.created_at AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(j.created_at AS DATE) <= ?";
        }

        sql += " GROUP BY i.name ORDER BY count DESC";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("name"), rs.getInt("count"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public Map<String, Integer> getJobSeekerGrowthByMonth(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT YEAR(created_at) AS year, MONTH(created_at) AS month, COUNT(*) AS total FROM candidate WHERE isActive = 1";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) <= ?";
        }

        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += " GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY total ASC";
                break;
            case "DESC":
                sql += " GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY total DESC";
                break;
            default:
                sql += " GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY YEAR(created_at), MONTH(created_at)";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int year = rs.getInt("year");
                    int month = rs.getInt("month");
                    String key = String.format("%d-%02d", year, month); // Ví dụ: "2024-08"
                    map.put(key, rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public Map<String, Integer> getRecruiterGrowthByMonth(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT YEAR(created_at) AS year, MONTH(created_at) AS month, COUNT(*) AS total FROM recruiter WHERE isActive = 1";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) <= ?";
        }

        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += " GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY total ASC";
                break;
            case "DESC":
                sql += " GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY total DESC";
                break;
            default:
                sql += " GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY YEAR(created_at), MONTH(created_at)";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int year = rs.getInt("year");
                    int month = rs.getInt("month");
                    String key = String.format("%d-%02d", year, month); // Ví dụ: "2024-08"
                    map.put(key, rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public Map<String, Integer> getUserGenderDistribution(String fromDate, String toDate) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT gender, COUNT(*) AS total FROM candidate WHERE isActive = 1";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) <= ?";
        }

        sql += " GROUP BY gender";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("gender"), rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public Map<String, Integer> getUserRegistrationByMonth(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();

        String sql = "SELECT YEAR(created_at) AS year, MONTH(created_at) AS month, COUNT(*) AS total "
                + "FROM ("
                + "    SELECT created_at FROM candidate WHERE isActive = 1 "
                + "    UNION ALL "
                + "    SELECT created_at FROM recruiter WHERE isActive = 1"
                + ") AS combined "
                + "WHERE 1=1";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(created_at AS DATE) <= ?";
        }

        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += " GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY total ASC";
                break;
            case "DESC":
                sql += " GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY total DESC";
                break;
            default:
                sql += " GROUP BY YEAR(created_at), MONTH(created_at) ORDER BY YEAR(created_at), MONTH(created_at)";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int year = rs.getInt("year");
                    int month = rs.getInt("month");
                    String key = String.format("%d-%02d", year, month); // Ví dụ: "2024-07"
                    map.put(key, rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public List<TopStatDTO> getTop5CandidatesByApplications() {
        List<TopStatDTO> list = new ArrayList<>();
        String sql = """
        SELECT c.full_name, COUNT(*) AS total
        FROM application a
        JOIN candidate c ON a.candidate_id = c.candidate_id WHERE c.isActive = 1
        GROUP BY c.full_name
        ORDER BY total DESC
        OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String name = rs.getString("full_name");
                int total = rs.getInt("total");
                list.add(new TopStatDTO(name, total));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<TopStatDTO> getTop5RecruitersByJobPosts() {
        List<TopStatDTO> list = new ArrayList<>();
        String sql = """
        SELECT r.company_name, COUNT(*) AS total
        FROM job_post j
        JOIN recruiter r ON j.recruiter_id = r.recruiter_id WHERE r.isActive = 1
        GROUP BY r.company_name
        ORDER BY total DESC
        OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String name = rs.getString("company_name");
                int total = rs.getInt("total");
                list.add(new TopStatDTO(name, total));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<TopStatDTO> getTop5JobPostsByApplications() {
        List<TopStatDTO> list = new ArrayList<>();
        String sql = """
        SELECT j.title, COUNT(*) AS total
                FROM application a
                JOIN job_post j ON a.job_id = j.job_id
                JOIN recruiter r ON j.recruiter_id = r.recruiter_id
                WHERE j.status = N'Đã duyệt' AND r.isActive = 1
                GROUP BY j.title
                ORDER BY total DESC
                OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String title = rs.getString("title");
                int total = rs.getInt("total");
                list.add(new TopStatDTO(title, total));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

//    public double getApprovalRate() {
//        String sql = "SELECT "
//                + "SUM(CASE WHEN status = N'Đã duyệt' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS rate "
//                + "FROM job_post";
//
//        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
//            if (rs.next()) {
//                return rs.getDouble("rate");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }
    public double getAvgApplicationsPerJobPost() {
        String sql = "SELECT COUNT(*) * 1.0 / (SELECT COUNT(*) FROM job_post) AS avg_applications FROM application";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("avg_applications");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public double getAvgJobPostsPerDay() {
        String sql = "SELECT COUNT(*) * 1.0 / \n"
                + "       (DATEDIFF(DAY, MIN(j.created_at), MAX(j.created_at)) + 1) AS avg_per_day\n"
                + "FROM job_post j\n"
                + "JOIN recruiter r ON j.recruiter_id = r.recruiter_id\n"
                + "WHERE j.status = N'Đã duyệt' AND r.isActive = 1";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("avg_per_day");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public String getHottestIndustryName() {
        String sql = """
        SELECT i.name, COUNT(*) AS total
                FROM application a
                JOIN candidate c ON a.candidate_id = c.candidate_id
                JOIN job_post j ON a.job_id = j.job_id
                JOIN recruiter r ON j.recruiter_id = r.recruiter_id
                JOIN industry i ON j.industry_id = i.industry_id
                WHERE c.isActive = 1 AND r.isActive = 1 AND j.status = N'Đã duyệt'
                GROUP BY i.name
                ORDER BY total DESC
                OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "Không xác định";
    }

    public Map<String, Integer> getJobPostCountByIndustry(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT i.name, COUNT(*) AS total  \n"
                + "             FROM job_post j \n"
                + "             JOIN industry i ON j.industry_id = i.industry_id \n"
                + "             JOIN recruiter r ON j.recruiter_id = r.recruiter_id \n"
                + "            WHERE j.status = N'Đã duyệt' AND r.isActive = 1";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(j.created_at AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(j.created_at AS DATE) <= ?";
        }

        sql += " GROUP BY i.name ";
        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += "ORDER BY total ASC";
                break;
            case "DESC":
                sql += "ORDER BY total DESC";
                break;
            default:
                sql += "ORDER BY i.name";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("name"), rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public Map<String, Integer> getApplicationCountByIndustry(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT i.name, COUNT(*) AS total "
                + "FROM application a "
                + "JOIN job_post j ON a.job_id = j.job_id "
                + "JOIN recruiter r ON j.recruiter_id = r.recruiter_id "
                + "JOIN industry i ON j.industry_id = i.industry_id "
                + "WHERE j.status = N'Đã duyệt' AND r.isActive = 1";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(a.applied_at AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(a.applied_at AS DATE) <= ?";
        }

        sql += " GROUP BY i.name ";
        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += "ORDER BY total ASC";
                break;
            case "DESC":
                sql += "ORDER BY total DESC";
                break;
            default:
                sql += "ORDER BY i.name";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("name"), rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public Map<String, Integer> getJobPostStatusDistribution(String fromDate, String toDate) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT j.status, COUNT(*) AS total "
                + "FROM job_post j "
                + "JOIN recruiter r ON j.recruiter_id = r.recruiter_id "
                + "WHERE r.isActive = 1";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(j.created_at AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(j.created_at AS DATE) <= ?";
        }

        sql += " GROUP BY j.status";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("status"), rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public Map<String, Integer> getRevenueByService(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT s.title, SUM(td.unit_price) AS total "
                + "FROM transaction_detail td "
                + "JOIN service s ON td.service_id = s.service_id "
                + "JOIN [transaction] t ON td.transaction_id = t.transaction_id "
                + "WHERE t.status = 'Success'";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(t.transaction_date AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(t.transaction_date AS DATE) <= ?";
        }

        sql += " GROUP BY s.title";

        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += " ORDER BY total ASC";
                break;
            case "DESC":
                sql += " ORDER BY total DESC";
                break;
            default:
                sql += " ORDER BY s.title";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("title"), rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public Map<String, Integer> getTransactionPerMonth(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT YEAR(transaction_date) AS year, MONTH(transaction_date) AS month, COUNT(*) AS total "
                + "FROM [transaction] WHERE status = 'Success'";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(transaction_date AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(transaction_date AS DATE) <= ?";
        }

        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += " GROUP BY YEAR(transaction_date), MONTH(transaction_date) ORDER BY total ASC";
                break;
            case "DESC":
                sql += " GROUP BY YEAR(transaction_date), MONTH(transaction_date) ORDER BY total DESC";
                break;
            default:
                sql += " GROUP BY YEAR(transaction_date), MONTH(transaction_date) ORDER BY YEAR(transaction_date), MONTH(transaction_date)";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int year = rs.getInt("year");
                    int month = rs.getInt("month");
                    String key = String.format("%d-%02d", year, month); // Ví dụ: "2024-07"
                    map.put(key, rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public Map<String, Integer> getTopServices(String fromDate, String toDate, String sortOrder) {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT s.title, COUNT(*) AS total "
                + "FROM transaction_detail td "
                + "JOIN service s ON td.service_id = s.service_id "
                + "JOIN [transaction] t ON td.transaction_id = t.transaction_id "
                + "WHERE t.status = 'Success'";

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND CAST(t.transaction_date AS DATE) >= ?";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND CAST(t.transaction_date AS DATE) <= ?";
        }

        sql += " GROUP BY s.title";

        switch (sortOrder != null ? sortOrder.toUpperCase() : "") {
            case "ASC":
                sql += " ORDER BY total ASC";
                break;
            case "DESC":
                sql += " ORDER BY total DESC";
                break;
            default:
                sql += " ORDER BY s.title";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int i = 1;
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(fromDate));
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setDate(i++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("title"), rs.getInt("total"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    public List<TopStatDTO> getTop5RecruitersBySpending() {
        List<TopStatDTO> list = new ArrayList<>();
        String sql = """
        SELECT r.company_name, SUM(t.price) AS total
                FROM [transaction] t
                JOIN recruiter r ON t.recruiter_id = r.recruiter_id
                WHERE t.status = 'success' AND r.isActive = 1
                GROUP BY r.company_name
                ORDER BY total DESC
                OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String name = rs.getString("company_name");
                int total = rs.getBigDecimal("total").intValue(); // hoặc trả về BigDecimal nếu DTO hỗ trợ
                list.add(new TopStatDTO(name, total));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public double getRevenueGrowthRateComparedToLastMonth() {
        String sql = """
        SELECT
            SUM(CASE WHEN MONTH(transaction_date) = MONTH(GETDATE()) AND YEAR(transaction_date) = YEAR(GETDATE()) THEN price ELSE 0 END) AS current_month,
            SUM(CASE WHEN MONTH(transaction_date) = MONTH(DATEADD(MONTH, -1, GETDATE())) AND YEAR(transaction_date) = YEAR(DATEADD(MONTH, -1, GETDATE())) THEN price ELSE 0 END) AS last_month
        FROM [transaction]
        WHERE status = N'Success'
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                double current = rs.getDouble("current_month");
                double last = rs.getDouble("last_month");

                if (last == 0) {
                    return current > 0 ? 100 : 0;
                }
                return ((current - last) / last) * 100;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTransactionGrowthRateComparedToLastMonth() {
        String sql = """
        SELECT
            COUNT(CASE WHEN MONTH(transaction_date) = MONTH(GETDATE()) AND YEAR(transaction_date) = YEAR(GETDATE()) THEN 1 END) AS current_month,
            COUNT(CASE WHEN MONTH(transaction_date) = MONTH(DATEADD(MONTH, -1, GETDATE())) AND YEAR(transaction_date) = YEAR(DATEADD(MONTH, -1, GETDATE())) THEN 1 END) AS last_month
        FROM [transaction]
        WHERE status = N'Success'
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int current = rs.getInt("current_month");
                int last = rs.getInt("last_month");

                if (last == 0) {
                    return current > 0 ? 100 : 0;
                }
                return ((double) (current - last) / last) * 100;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTransactionGrowthRateComparedToLastMonthALL() {
        String sql = """
        SELECT
            COUNT(CASE 
                      WHEN MONTH(transaction_date) = MONTH(GETDATE()) 
                           AND YEAR(transaction_date) = YEAR(GETDATE()) 
                      THEN 1 
                      ELSE NULL 
                 END) AS current_month,
            COUNT(CASE 
                      WHEN MONTH(transaction_date) = MONTH(DATEADD(MONTH, -1, GETDATE())) 
                           AND YEAR(transaction_date) = YEAR(DATEADD(MONTH, -1, GETDATE())) 
                      THEN 1 
                      ELSE NULL 
                 END) AS last_month
        FROM [transaction]
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int current = rs.getInt("current_month");
                int last = rs.getInt("last_month");

                if (last == 0) {
                    return current > 0 ? 100 : 0;
                }
                return ((double) (current - last) / last) * 100;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getAverageTransactionCountPerDay() {
        String sql = """
        SELECT COUNT(*) * 1.0 / COUNT(DISTINCT CAST(transaction_date AS DATE)) AS avg_per_day
        FROM [transaction]
        WHERE status = N'Success'
    """;

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("avg_per_day");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

}
