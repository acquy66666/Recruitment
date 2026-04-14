/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.dto.PendingTestDTO;
import com.recruitment.dto.TestWithCount;
import com.recruitment.model.Test;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hoang
 */
public class TestDAO extends DBcontext {

    public List<TestWithCount> getAllTestsById(int recruiterId) {
        List<TestWithCount> list = new ArrayList<>();
        String sql = "SELECT * FROM test WHERE recruiter_id = ? AND status = 'Accepted'";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, recruiterId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TestWithCount test = new TestWithCount();
                int testId = rs.getInt("test_id");
                test.setTestId(rs.getInt("test_id"));
                test.setRecruiterId(rs.getInt("recruiter_id"));
                test.setTitle(rs.getString("title"));
                test.setDescription(rs.getString("description"));
                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) {
                    test.setCreatedAt(ts); // Timestamp extends java.util.Date
                }
                test.setStatus(rs.getString("status"));
                test.setAvgScore(getAssignmentCountByTestId(testId));
                test.setPassRate(getPassRateByTestId(testId));
                test.setTestTakenCount(getAssignmentCountByTestId(testId));
                
                list.add(test);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<TestWithCount> getAllTestList(String keyword, String status, int recruiterId) {
        List<TestWithCount> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
            SELECT 
                t.test_id, t.recruiter_id, t.title, t.description, t.status, t.created_at,
                COUNT(q.question_id) AS question_count
            FROM test t
            LEFT JOIN question q ON t.test_id = q.test_id
            WHERE t.recruiter_id = ?
        """);

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND t.title LIKE ?");
        }

        if (status != null && !status.trim().isEmpty() && !"all".equalsIgnoreCase(status)) {
            sql.append(" AND t.status = ?");
        }

        sql.append(" GROUP BY t.test_id, t.recruiter_id, t.title, t.description, t.status, t.created_at");

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, recruiterId);

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
            }

            if (status != null && !status.trim().isEmpty() && !"all".equalsIgnoreCase(status)) {
                ps.setString(paramIndex++, status.toLowerCase());
            }

            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
               
                int testId = rs.getInt("test_id");
                TestWithCount test = new TestWithCount();
                test.setTestId(rs.getInt("test_id"));
                test.setRecruiterId(rs.getInt("recruiter_id"));
                test.setTitle(rs.getString("title"));
                test.setDescription(rs.getString("description"));
                test.setStatus(rs.getString("status"));
                test.setCreatedAt(rs.getTimestamp("created_at"));
                test.setQuestionCount(rs.getInt("question_count"));
                
                test.setAvgScore(getAverageScoreByTestId(testId));
                test.setPassRate(getPassRateByTestId(testId));
                test.setTestTakenCount(getAssignmentCountByTestId(testId));
                
                list.add(test);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public double getAverageScoreByTestId(int testId) throws SQLException {
        String sql = """
            SELECT AVG(score) as average_score 
            FROM assignment 
            WHERE test_id = ?
            """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, testId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                double avgScore = rs.getDouble("average_score");
                System.out.println("Average score for testId " + testId + ": " + avgScore); // Gỡ lỗi
                return rs.wasNull() ? 0.0 : avgScore;
            }
            System.out.println("No data found for testId " + testId); // Gỡ lỗi
            return 0.0;
        }
    }

    public int getAssignmentCountByTestId(int testId) throws SQLException {
        String sql = """
            SELECT COUNT(*) as assignment_count 
            FROM assignment 
            WHERE test_id = ?
            """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, testId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("assignment_count");
            }
            return 0; 
        }
    }
    
    public double getPassRateByTestId(int testId) throws SQLException {
        String sql = """
            SELECT 
                (SUM(CASE WHEN score >= 60 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as pass_rate 
            FROM assignment 
            WHERE test_id = ?
            """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, testId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                double passRate = rs.getDouble("pass_rate");
                return passRate > 0 ? passRate : 0.0; 
            }
            return 0.0; 
        }
    }

    public Test getTestById(int testId) {
        Test test = null;
        String sql = "SELECT * FROM test WHERE test_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, testId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    test = new Test();
                    test.setTestId(rs.getInt("test_id"));
                    test.setRecruiterId(rs.getInt("recruiter_id"));
                    test.setTitle(rs.getString("title"));
                    test.setDescription(rs.getString("description"));

                    Timestamp ts = rs.getTimestamp("created_at");
                    if (ts != null) {
                        test.setCreatedAt(ts);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return test;
    }

    public Test getTestByIdAndRecruiterId(int testId, int recruiterId) {
        Test test = null;
        String sql = "SELECT * FROM test WHERE test_id = ? AND recruiter_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, testId);
            ps.setInt(2, recruiterId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                test = new Test();
                test.setTestId(rs.getInt("test_id"));
                test.setRecruiterId(rs.getInt("recruiter_id"));
                test.setTitle(rs.getString("title"));
                test.setDescription(rs.getString("description"));
                test.setCreatedAt(rs.getTimestamp("created_at"));
                test.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return test;
    }

    public boolean insertTest(Test test) {
        String sql = "INSERT INTO test (recruiter_id, title, description, created_at, status) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, test.getRecruiterId());
            ps.setString(2, test.getTitle());
            ps.setString(3, test.getDescription());
            ps.setTimestamp(4, new Timestamp(test.getCreatedAt().getTime()));
            ps.setString(5, test.getStatus());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateTest(Test test) {
        String sql = "UPDATE test SET title = ?, description = ?, created_at = ? WHERE test_id = ? AND recruiter_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, test.getTitle());
            ps.setString(2, test.getDescription());
            ps.setTimestamp(3, new Timestamp(test.getCreatedAt().getTime()));
            ps.setInt(4, test.getTestId());
            ps.setInt(5, test.getRecruiterId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateTestStatus(int testId, int recruiterId, String status) {
        String sql = "UPDATE test SET status = ? WHERE test_id = ? AND recruiter_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, testId);
            ps.setInt(3, recruiterId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateTestStatus(int testId, String status) {
        String sql = "UPDATE test SET status = ? WHERE test_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, testId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteTest(int testId) throws SQLException {
        String sql = "DELETE FROM test WHERE test_id = ?";
        PreparedStatement ps = null;

        try {
            ps = c.prepareStatement(sql);
            ps.setInt(1, testId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error deleting test with ID " + testId, e);
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("Error closing statement: " + e.getMessage());
                }
            }
            if (c != null) {
                try {
                    c.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    }

    public int countTestsByRecruiter(int recruiterId) {
        String sql = "SELECT COUNT(*) FROM test WHERE recruiter_id = ?";
        int count = 0;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    public List<PendingTestDTO> getPendingTests(
            String searchKeyword,
            int page,
            int pageSize
    ) {
        List<PendingTestDTO> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder("""
            SELECT 
                r.recruiter_id, r.full_name, r.isActive, r.company_name, r.credit,
                t.test_id, t.title, t.status AS test_status, t.created_at
            FROM recruiter r
            LEFT JOIN test t ON r.recruiter_id = t.recruiter_id
            WHERE t.status = 'Pending'
              AND r.isActive = 1
        """);

        List<Object> params = new ArrayList<>();

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (t.title LIKE ? OR r.company_name LIKE ?)");
            String keyword = "%" + searchKeyword.trim() + "%";
            params.add(keyword);
            params.add(keyword);
        }

        sql.append(" ORDER BY t.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PendingTestDTO dto = new PendingTestDTO();
                dto.setRecruiterId(rs.getInt("recruiter_id"));
                dto.setFullName(rs.getString("full_name"));
                dto.setIsActive(rs.getBoolean("isActive"));
                dto.setCompanyName(rs.getString("company_name"));
                dto.setCredit(rs.getString("credit"));
                dto.setTestId(rs.getInt("test_id"));
                dto.setTitle(rs.getString("title"));
                dto.setTestStatus(rs.getString("test_status"));
                dto.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean isTestInUse(int testId) {
        String sql = "SELECT COUNT(*) FROM assignment WHERE test_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, testId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0; // true nếu có bản ghi sử dụng test
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public int countTestByRecruiterId(int recruiterId) {
        String sql = "SELECT COUNT(*) FROM test WHERE recruiter_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countTestByRecruiterIdAndStatus(int recruiterId, String status) {
        String sql = "SELECT COUNT(*) FROM test WHERE recruiter_id = ? AND status = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setString(2, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Số lượng bài test theo recruiter + status
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

}
