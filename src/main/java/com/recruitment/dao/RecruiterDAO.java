package com.recruitment.dao;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.recruitment.model.Recruiter;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for managing Recruiter entities in the database.
 */
public class RecruiterDAO extends DBcontext {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    public int insertRecruiter(Recruiter recruiter) throws SQLException {
        c.setAutoCommit(false);
        try {
            String sql = "INSERT INTO [dbo].[recruiter] ([password_hash], [full_name], [position], [phone], [email], [created_at], [isActive], [image_url], [company_name], [company_address], [tax_code], [website], [company_logo_url],  [company_description]) "
                    + "VALUES (?, ?, ?, ?, ?, GETDATE(), ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement st = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                st.setString(1, recruiter.getPasswordHash());
                st.setString(2, recruiter.getFullName());
                st.setString(3, recruiter.getPosition());
                st.setString(4, recruiter.getPhone());
                st.setString(5, recruiter.getEmail());
                st.setBoolean(6, recruiter.isIsActive());
                st.setString(7, recruiter.getImageUrl());
                st.setString(8, recruiter.getCompanyName());
                st.setString(9, recruiter.getCompanyAddress());
                st.setString(10, recruiter.getTaxCode());
                st.setString(11, recruiter.getWebsite());
                st.setString(12, recruiter.getCompanyLogoUrl());
                st.setString(13, recruiter.getCompanyDescription());

                int affectedRows = st.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Inserting recruiter failed, no rows affected.");
                }
                try (ResultSet rs = st.getGeneratedKeys()) {
                    if (rs.next()) {
                        int recruiterId = rs.getInt(1);
                        c.commit();
                        return recruiterId; // return the generated recruiter_id
                    }
                }
            }
        } catch (SQLException e) {
            c.rollback();
            throw e;
        } finally {
            c.setAutoCommit(true);
        }
        return -1; // if failed
    }

    // Update an existing Recruiter
    public void updateRecruiter(Recruiter recruiter) throws SQLException {
        String sql = "UPDATE [dbo].[recruiter] SET [password_hash] = ?, [full_name] = ?, [position] = ?, "
                + "[phone] = ?, [email] = ?, [isActive] = ?, [image_url] = ?, [company_name] = ?, "
                + "[company_address] = ?, [tax_code] = ?, [website] = ?, [company_logo_url] = ?, "
                + "[company_description] = ? WHERE [recruiter_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, recruiter.getPasswordHash());
            st.setString(2, recruiter.getFullName());
            st.setString(3, recruiter.getPosition());
            st.setString(4, recruiter.getPhone());
            st.setString(5, recruiter.getEmail());
            st.setBoolean(6, recruiter.isIsActive());
            st.setString(7, recruiter.getImageUrl()); // Nullable
            st.setString(8, recruiter.getCompanyName());
            st.setString(9, recruiter.getCompanyAddress()); // Nullable
            st.setString(10, recruiter.getTaxCode()); // Nullable
            st.setString(11, recruiter.getWebsite()); // Nullable
            st.setString(12, recruiter.getCompanyLogoUrl()); // Nullable
            st.setString(13, recruiter.getCompanyDescription()); // Nullable
            st.setInt(14, recruiter.getRecruiterId());
            int rowsAffected = st.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No recruiter found with ID: " + recruiter.getRecruiterId());
            }
        }
    }

    // Change Recruiter password by email
    public void changeRecruiterPasswordByEmail(String email, String newPasswordHash) throws SQLException {
        String sql = "UPDATE [dbo].[recruiter] SET [password_hash] = ? WHERE [email] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, newPasswordHash);
            st.setString(2, email);
            int rowsAffected = st.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No recruiter found with email: " + email);
            }
        }
    }

    // Delete a Recruiter by ID
    public void deleteRecruiter(int recruiterId) throws SQLException {
        try {
            Recruiter recruiter = getRecruiterById(recruiterId);
            if (recruiter != null) {
                // Delete Recruiter
                String sql = "DELETE FROM [dbo].[recruiter] WHERE [recruiter_id] = ?";
                try (PreparedStatement st = c.prepareStatement(sql)) {
                    st.setInt(1, recruiterId);
                    st.executeUpdate();
                }
            }
        } catch (SQLException e) {
            throw e;
        }
    }

    // Get all Recruiters
    public List<Recruiter> getAllRecruiter() throws SQLException {
        String sql = "SELECT [recruiter_id], [password_hash], [full_name], [position], [phone], [email], [created_at], [isActive], [image_url], [company_name], [company_address], [tax_code], [website], [company_logo_url], [company_description] FROM [dbo].[recruiter]";
        List<Recruiter> recruiters = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Recruiter recruiter = mapResultSetToRecruiter(rs);
                    recruiters.add(recruiter);
                }
            }
        }
        return recruiters;
    }

    // Get Recruiter by email or phone
    public Recruiter getRecruiterByEmailOrPhone(String criteria) throws SQLException {
        String sql = "SELECT [recruiter_id], [password_hash], [full_name], [position], [phone], [email], [created_at], [isActive], [image_url], [company_name], [company_address], [tax_code], [website], [company_logo_url], [company_description] FROM [dbo].[recruiter] WHERE [email] = ? or [phone] = ? or [tax_code] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, criteria);
            st.setString(2, criteria);
            st.setString(3, criteria);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRecruiter(rs);
                }
            }
        }
        return null;
    }

    // Get Recruiter by phone
    public Recruiter getRecruiterByPhone(String phone) throws SQLException {
        String sql = "SELECT [recruiter_id], [password_hash], [full_name], [position], [phone], [email], [created_at], [isActive], [image_url], [company_name], [company_address], [tax_code], [website], [company_logo_url], [company_description] FROM [dbo].[recruiter] WHERE [phone] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, phone);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRecruiter(rs);
                }
            }
        }
        return null;
    }

    public void activateRecruiter(int recruiterId) throws SQLException {
        String sql = "UPDATE [dbo].[recruiter] SET [isActive] = ? WHERE [recruiter_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setBoolean(1, true);
            st.setInt(2, recruiterId);
            st.executeUpdate();
        }
    }

    // Get Recruiter by ID
    public Recruiter getRecruiterById(int recruiterId) throws SQLException {
        String sql = "SELECT [recruiter_id], [password_hash], [full_name], [position], [phone], [email], [created_at], [isActive], [image_url], [company_name], [company_address], [tax_code], [website], [company_logo_url], [company_description] FROM [dbo].[recruiter] WHERE [recruiter_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, recruiterId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRecruiter(rs);
                }
            }
        }
        return null;
    }

    public List<Recruiter> getPaginatedRecruiters(String status, int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT [recruiter_id], [password_hash], [full_name], [position], [phone], [email], [created_at], [isActive], [image_url], [company_name], [company_address], [tax_code], [website], [company_logo_url], [industry], [company_description] FROM [dbo].[recruiter]");
        List<Object> params = new ArrayList<>();
        if (status != null && !status.isEmpty()) {
            sql.append(" WHERE [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }
        sql.append(" ORDER BY [recruiter_id] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        List<Recruiter> recruiters = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    recruiters.add(mapResultSetToRecruiter(rs));
                }
            }
        }
        return recruiters;
    }

    // Get total number of recruiters with status filter
    public int getTotalRecruiters(String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[recruiter]");
        List<Object> params = new ArrayList<>();
        if (status != null && !status.isEmpty()) {
            sql.append(" WHERE [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }
        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Get total number of recruiters
    public int getTotalRecruiters() throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[recruiter]";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Get paginated recruiters by full name or email
    // Get paginated recruiters by full name or email
    public List<Recruiter> getPaginatedRecruitersByNameOrEmail(String query, String status, int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT [recruiter_id], [password_hash], [full_name], [position], [phone], [email], [created_at], [isActive], [image_url], [company_name], [company_address], [tax_code], [website], [company_logo_url], [industry], [company_description] FROM [dbo].[recruiter] WHERE ([full_name] LIKE ? OR [email] LIKE ?)");
        List<Object> params = new ArrayList<>();
        params.add("%" + query + "%");
        params.add("%" + query + "%");
        if (status != null && !status.isEmpty()) {
            sql.append(" AND [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }
        sql.append(" ORDER BY [recruiter_id] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        List<Recruiter> recruiters = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    recruiters.add(mapResultSetToRecruiter(rs));
                }
            }
        }
        return recruiters;
    }

    // Get total number of recruiters by full name or email
    public int getTotalRecruitersByNameOrEmail(String query, String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[recruiter] WHERE ([full_name] LIKE ? OR [email] LIKE ?)");
        List<Object> params = new ArrayList<>();
        params.add("%" + query + "%");
        params.add("%" + query + "%");
        if (status != null && !status.isEmpty()) {
            sql.append(" AND [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }
        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public String getPasswordHashByRecruiterId(String recruiter_id) {
        String sql = "select password_hash from recruiter where recruiter_id = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, recruiter_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("password_hash");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePasswordHashByRecruiterId(String passwordHash, String recruiter_id) {
        String sql = "update recruiter set password_hash = ? where recruiter_id = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, passwordHash);
            ps.setString(2, recruiter_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get credits for a recruiter by ID
    public Map<Integer, Integer> getCredits(int recruiterId) throws SQLException {
        String sql = "SELECT [credit] FROM [dbo].[recruiter] WHERE [recruiter_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String creditJson = rs.getString("credit");
                    if (creditJson == null || creditJson.trim().isEmpty()) {
                        return new HashMap<>();
                    }
                    try {
                        return objectMapper.readValue(creditJson, HashMap.class);
                    } catch (IOException e) {
                        throw new SQLException("Failed to parse credit JSON: " + e.getMessage());
                    }
                }
            }
        }
        return new HashMap<>();
    }

    // Update credits for a recruiter
    public boolean updateCredits(int recruiterId, Map<String, Integer> credits) throws SQLException, JsonProcessingException {
        String sql = "UPDATE [dbo].[recruiter] SET [credit] = ? WHERE [recruiter_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            String creditJson = credits.isEmpty() ? "{}" : objectMapper.writeValueAsString(credits);
            ps.setString(1, creditJson);
            ps.setInt(2, recruiterId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                return false;
            }
            return true;
        } catch (SQLException | JsonProcessingException e) {
            throw e;
        }
    }

    // Helper method to map ResultSet to Recruiter object
    private Recruiter mapResultSetToRecruiter(ResultSet rs) throws SQLException {
        Recruiter recruiter = new Recruiter();
        recruiter.setRecruiterId(rs.getInt("recruiter_id"));
        recruiter.setPasswordHash(rs.getString("password_hash"));
        recruiter.setFullName(rs.getString("full_name"));
        recruiter.setPosition(rs.getString("position"));
        recruiter.setPhone(rs.getString("phone"));
        recruiter.setEmail(rs.getString("email"));
        recruiter.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
        recruiter.setIsActive(rs.getBoolean("isActive"));
        recruiter.setImageUrl(rs.getString("image_url"));
        recruiter.setCompanyName(rs.getString("company_name"));
        recruiter.setCompanyAddress(rs.getString("company_address"));
        recruiter.setTaxCode(rs.getString("tax_code"));
        recruiter.setWebsite(rs.getString("website"));
        recruiter.setCompanyLogoUrl(rs.getString("company_logo_url"));
        recruiter.setCompanyDescription(rs.getString("company_description"));
        recruiter.setCredit("credit");
        return recruiter;
    }

    public List<Recruiter> manageAllRecruitersPending() {
        List<Recruiter> list = new ArrayList<>();
        String sql = "SELECT recruiter_id, full_name, position, company_name, email, phone, created_at, isActive FROM recruiter WHERE isActive = 0;";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Recruiter recruiter = new Recruiter(
                        rs.getInt("recruiter_id"),
                        rs.getString("full_name"),
                        rs.getString("position"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getBoolean("isActive"),
                        rs.getString("company_name")
                );
                list.add(recruiter);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void updateRecruiterIsActive(String recruiterId, boolean isActive) {
        String sql = "UPDATE recruiter SET isActive = ? WHERE recruiter_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBoolean(1, isActive);
            ps.setString(2, recruiterId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Recruiter> getListRecruiterByPage(List<Recruiter> list, int start, int end) {
        ArrayList<Recruiter> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<Recruiter> filterRecruitersAccountPending(String keyword, String position, String fromDate, String toDate, String sort) {
        List<Recruiter> list = new ArrayList<>();
        String sql = "SELECT recruiter_id, full_name, position, phone, email, created_at, isActive, company_name "
                + "FROM recruiter WHERE isActive = 0"; // Chỉ lấy recruiter chưa kích hoạt

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (full_name LIKE ? OR company_name LIKE ?)";
        }

        if (position != null && !position.trim().isEmpty()) {
            sql += " AND position = ?";
        }

        if (fromDate != null && !fromDate.trim().isEmpty()) {
            sql += " AND CAST(created_at AS DATE) >= ?";
        }

        if (toDate != null && !toDate.trim().isEmpty()) {
            sql += " AND CAST(created_at AS DATE) <= ?";
        }

        if (sort != null && !sort.trim().isEmpty()) {
            switch (sort) {
                case "created_at_desc_account":
                    sql += " ORDER BY created_at DESC";
                    break;
                case "created_at_asc_account":
                    sql += " ORDER BY created_at ASC";
                    break;
                case "title_asc_account":
                    sql += " ORDER BY full_name ASC";
                    break;
                case "title_desc_account":
                    sql += " ORDER BY full_name DESC";
                    break;
            }
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String like = "%" + keyword.trim() + "%";
                ps.setString(index++, like);
                ps.setString(index++, like);
            }

            if (position != null && !position.trim().isEmpty()) {
                ps.setString(index++, position.trim());
            }

            if (fromDate != null && !fromDate.trim().isEmpty()) {
                ps.setDate(index++, Date.valueOf(fromDate));
            }

            if (toDate != null && !toDate.trim().isEmpty()) {
                ps.setDate(index++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Recruiter recruiter = new Recruiter(
                            rs.getInt("recruiter_id"),
                            rs.getString("full_name"),
                            rs.getString("position"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getBoolean("isActive"),
                            rs.getString("company_name")
                    );
                    list.add(recruiter);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<String> getAllRecruiterPositions() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT position FROM recruiter where isActive = 0";
        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("position"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateRecruiterById(int recruiterId, String fullName, String phone, String position,
            String companyName, String taxCode, String companyAddress,
            String website, String industry, String companyDescription) {
        String sql = "UPDATE recruiter SET full_name = ?, phone = ?, position = ?, company_name = ?, "
                + "tax_code = ?, company_address = ?, website = ?, industry = ?, company_description = ? "
                + "WHERE recruiter_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, position);
            ps.setString(4, companyName);
            ps.setString(5, taxCode);
            ps.setString(6, companyAddress);
            ps.setString(7, website);
            ps.setString(8, industry);
            ps.setString(9, companyDescription);
            ps.setInt(10, recruiterId);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Recruiter getRecruiterByIdDUC(int recruiterId) throws SQLException {
        String sql = "SELECT [recruiter_id], [password_hash], [full_name], [position], [phone], [email], [created_at], [isActive], [image_url], [company_name], [company_address], [tax_code], [website], [company_logo_url], [company_description], [credit], [industry] FROM [dbo].[recruiter] WHERE [recruiter_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, recruiterId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Recruiter recruiter = new Recruiter();
                    recruiter.setRecruiterId(rs.getInt("recruiter_id"));
                    recruiter.setPasswordHash(rs.getString("password_hash"));
                    recruiter.setFullName(rs.getString("full_name"));
                    recruiter.setPosition(rs.getString("position"));
                    recruiter.setPhone(rs.getString("phone"));
                    recruiter.setEmail(rs.getString("email"));
                    recruiter.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    recruiter.setIsActive(rs.getBoolean("isActive"));
                    recruiter.setImageUrl(rs.getString("image_url"));
                    recruiter.setCompanyName(rs.getString("company_name"));
                    recruiter.setCompanyAddress(rs.getString("company_address"));
                    recruiter.setTaxCode(rs.getString("tax_code"));
                    recruiter.setWebsite(rs.getString("website"));
                    recruiter.setCompanyLogoUrl(rs.getString("company_logo_url"));
                    recruiter.setCompanyDescription(rs.getString("company_description"));
                    recruiter.setCredit(rs.getString("credit"));
                    recruiter.setIndustry(rs.getString("industry"));
                    return recruiter;
                }
            }
        }
        return null;
    }

    public boolean isEmailDuplicateRecruiter(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM recruiter WHERE email = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, email);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public boolean isPhoneDuplicateRecruiter(String phone) throws SQLException {
        String sql = "SELECT COUNT(*) FROM recruiter WHERE phone = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, phone);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public Map<String, Object> getDashboardStatistics(int recruiterId) throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        String sql = """
            SELECT 
                (SELECT COUNT(*) FROM job_post WHERE recruiter_id = ? AND status = 'ACTIVE') as totalActiveJobs,
                (SELECT COUNT(*) FROM application a 
                 JOIN job_post j ON a.job_id = j.job_id 
                 WHERE j.recruiter_id = ?) as totalApplications,
                (SELECT COUNT(*) FROM interview i 
                 JOIN application a ON i.application_id = a.application_id 
                 JOIN job_post j ON a.job_id = j.job_id 
                 WHERE j.recruiter_id = ?) as totalInterviews,
                (SELECT ISNULL(credit, 0) FROM recruiter WHERE recruiter_id = ?) as currentCredits
        """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, recruiterId);
            stmt.setInt(2, recruiterId);
            stmt.setInt(3, recruiterId);
            stmt.setInt(4, recruiterId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                stats.put("totalActiveJobs", rs.getInt("totalActiveJobs"));
                stats.put("totalApplications", rs.getInt("totalApplications"));
                stats.put("totalInterviews", rs.getInt("totalInterviews"));
              
            }
        }
        return stats;
    }

    /**
     * Get job application statistics for bar chart
     */
    public List<Map<String, Object>> getJobApplicationStats(int recruiterId) throws SQLException {
        List<Map<String, Object>> stats = new ArrayList<>();
        String sql = """
            SELECT TOP 10 j.title as jobTitle, COUNT(a.application_id) as applicationCount
            FROM job_post j
            LEFT JOIN application a ON j.job_id = a.job_id
            WHERE j.recruiter_id = ? AND j.status = 'ACTIVE'
            GROUP BY j.job_id, j.title
            ORDER BY applicationCount DESC
        """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, recruiterId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> stat = new HashMap<>();
                stat.put("jobTitle", rs.getString("jobTitle"));
                stat.put("applicationCount", rs.getInt("applicationCount"));
                stats.add(stat);
            }
        }
        return stats;
    }

    /**
     * Get daily application statistics for line chart
     */
    public List<Map<String, Object>> getDailyApplicationStats(int recruiterId, int days) throws SQLException {
        List<Map<String, Object>> stats = new ArrayList<>();
        String sql = """
            SELECT CAST(a.applied_at AS DATE) as date, COUNT(*) as count
            FROM application a
            JOIN job_post j ON a.job_id = j.job_id
            WHERE j.recruiter_id = ? AND a.applied_at >= DATEADD(day, -?, GETDATE())
            GROUP BY CAST(a.applied_at AS DATE)
            ORDER BY date ASC
        """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, recruiterId);
            stmt.setInt(2, days);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> stat = new HashMap<>();
                stat.put("date", rs.getDate("date"));
                stat.put("count", rs.getInt("count"));
                stats.add(stat);
            }
        }
        return stats;
    }

    /**
     * Get recent job posts
     */
    public List<Map<String, Object>> getRecentJobs(int recruiterId, int limit) throws SQLException {
        List<Map<String, Object>> jobs = new ArrayList<>();
        String sql = """
              SELECT TOP (?) 
                        j.job_id, 
                        j.title, 
                        j.created_at,
                        COUNT(a.application_id) as applicationCount
                    FROM job_post j
                    LEFT JOIN application a ON j.job_id = a.job_id
                    WHERE j.recruiter_id = ?
                    GROUP BY j.job_id, j.title, j.created_at
                    ORDER BY j.created_at DESC
        """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, recruiterId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> job = new HashMap<>();
                job.put("jobId", rs.getInt("job_id"));
                job.put("title", rs.getString("title"));
                job.put("createdDate", rs.getTimestamp("created_at"));
                job.put("applicationCount", rs.getInt("applicationCount"));
                jobs.add(job);
            }
        }
        return jobs;
    }

    /**
     * Get new applications
     */
    public List<Map<String, Object>> getNewApplications(int recruiterId, int limit) throws SQLException {
        List<Map<String, Object>> applications = new ArrayList<>();
        String sql = """
            SELECT TOP (?) c.full_name as candidateName, j.title as jobTitle, a.applied_at
            FROM application a
            JOIN candidate c ON a.candidate_id = c.candidate_id
            JOIN job_post j ON a.job_id = j.job_id
            WHERE j.recruiter_id = ?
            ORDER BY a.applied_at DESC
        """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, recruiterId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> application = new HashMap<>();
                application.put("candidateName", rs.getString("candidateName"));
                application.put("jobTitle", rs.getString("jobTitle"));
                application.put("appliedDate", rs.getTimestamp("applied_at"));
                applications.add(application);
            }
        }
        return applications;
    }

    /**
     * Get upcoming interviews
     */
    public List<Map<String, Object>> getUpcomingInterviews(int recruiterId, int limit) throws SQLException {
        List<Map<String, Object>> interviews = new ArrayList<>();
        String sql = """
            SELECT TOP (?) c.full_name as candidateName, j.title as jobTitle, 
                   i.interview_time, i.interview_type
            FROM interview i
            JOIN application a ON i.application_id = a.application_id
            JOIN candidate c ON a.candidate_id = c.candidate_id
            JOIN job_post j ON a.job_id = j.job_id
            WHERE j.recruiter_id = ? AND i.interview_time > GETDATE()
            ORDER BY i.interview_time ASC
        """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, recruiterId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> interview = new HashMap<>();
                interview.put("candidateName", rs.getString("candidateName"));
                interview.put("jobTitle", rs.getString("jobTitle"));
                interview.put("interviewTime", rs.getTimestamp("interview_time"));
                interview.put("interviewType", rs.getString("interview_type"));
                interviews.add(interview);
            }
        }
        return interviews;
    }

    public List<Map<String, Object>> getRecentTransactions(int recruiterId, int limit) throws SQLException {
        List<Map<String, Object>> transactions = new ArrayList<>();
        String sql = """
            SELECT TOP (?) 
                t.transaction_id as id, 
                s.title as serviceName, 
                p.title as packageName, 
                t.price as amount, 
                t.transaction_date as paymentDate, 
                t.status
            FROM transaction t
            LEFT JOIN transaction_detail td ON t.transaction_id = td.transaction_id
            LEFT JOIN service s ON td.service_id = s.service_id
            LEFT JOIN promotion p ON t.promotion_id = p.promotion_id
            WHERE t.recruiter_id = ?
            ORDER BY t.transaction_date DESC;
        """;

        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, recruiterId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> transaction = new HashMap<>();
                transaction.put("id", rs.getInt("id"));
                transaction.put("serviceName", rs.getString("serviceName"));
                transaction.put("packageName", rs.getString("packageName"));
                transaction.put("amount", rs.getBigDecimal("amount"));
                transaction.put("paymentDate", rs.getTimestamp("paymentDate"));
                transaction.put("status", rs.getString("status"));
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            // If transaction table doesn't exist, return empty list
            System.out.println("Transaction table not found: " + e.getMessage());
        }
        return transactions;
    }

    public List<Map<String, Object>> getRecentNotifications(int recruiterId, int limit) throws SQLException {
        List<Map<String, Object>> notifications = new ArrayList<>();
        String sql = """
            SELECT TOP (?) n.id, n.title, n.message, n.type, n.created_at, n.is_read as isRead
            FROM notification n
            WHERE n.recipient_id = ? AND n.recipient_type = 'recruiter'
            ORDER BY n.created_at DESC
        """;
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, recruiterId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> notification = new HashMap<>();
                notification.put("notificationId", rs.getInt("id")); // Use 'id' from table
                notification.put("title", rs.getString("title"));
                notification.put("message", rs.getString("message"));
                notification.put("type", rs.getString("type")); // Use 'type' from table
                notification.put("createdDate", rs.getTimestamp("created_at")); // Use 'created_at' from table
                notification.put("isRead", rs.getBoolean("isRead"));
                notifications.add(notification);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching recent notifications: " + e.getMessage());
        }
        return notifications;
    }

    public List<String> getAllPhones() {
        List<String> phones = new ArrayList<>();
        String sql = "SELECT phone FROM recruiter";

        try (Statement stmt = c.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                phones.add(rs.getString("phone"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return phones;
    }

    public String getCreditByRecruiterId(int recruiterId) {
        String sql = "SELECT credit FROM recruiter WHERE recruiter_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("credit");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        RecruiterDAO re = new RecruiterDAO();
//        var list = re.filterRecruitersAccountPending("Võ", null, "2025-06-23", "2025-06-25", "title_asc_account");
//        for (Recruiter recruiter : list) {
//            System.out.println(recruiter.toString());
//        }
        Recruiter r;
        try {
            r = re.getRecruiterByIdDUC(1);
            System.out.println(r.getIndustry());
        } catch (SQLException ex) {
            Logger.getLogger(RecruiterDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
