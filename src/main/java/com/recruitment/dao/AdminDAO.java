package com.recruitment.dao;

import com.recruitment.model.Admin;
import com.recruitment.model.Industry;
import com.recruitment.model.JobPost;
import com.recruitment.model.Recruiter;
import java.sql.Date;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for managing Admin entities in the database.
 */
public class AdminDAO extends DBcontext {

    // Insert a new Admin
    public int insertAdmin(Admin admin) throws SQLException {
        String sql = "INSERT INTO [dbo].[admin] ([username], [password_hash], [role], [created_at], [isActive]) VALUES (?, ?, ?, GETDATE(), ?)";
        try (PreparedStatement st = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            st.setString(1, admin.getUsername());
            st.setString(2, admin.getPasswordHash());
            st.setString(3, admin.getRole());
            st.setBoolean(4, admin.isActive());
            int affectedRows = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Inserting admin failed, no rows affected.");
            }
            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated admin_id
                }
            }
        }
        return -1; // If failed
    }

    // Update an existing Admin
    public void updateAdmin(Admin admin) throws SQLException {
        c.setAutoCommit(false);
        try {
            String sql = "UPDATE [dbo].[admin] SET [username] = ?, [password_hash] = ?, [role] = ?, [created_at] = ?, [isActive] = ? WHERE [admin_id] = ?";
            try (PreparedStatement st = c.prepareStatement(sql)) {
                st.setString(1, admin.getUsername());
                st.setString(2, admin.getPasswordHash());
                st.setString(3, admin.getRole());
                st.setTimestamp(4, admin.getCreatedAt() != null ? Timestamp.valueOf(admin.getCreatedAt()) : null);
                st.setBoolean(5, admin.isActive());
                st.setInt(6, admin.getId());
                int rowsAffected = st.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("No admin found with ID: " + admin.getId());
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

    // Delete an Admin by ID
    public void deleteAdmin(int adminId) throws SQLException {
        c.setAutoCommit(false);
        try {
            String sql = "DELETE FROM [dbo].[admin] WHERE [admin_id] = ?";
            try (PreparedStatement st = c.prepareStatement(sql)) {
                st.setInt(1, adminId);
                int rowsAffected = st.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("No admin found with ID: " + adminId);
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

    // Get Admin by ID
    public Admin getAdminById(int adminId) throws SQLException {
        String sql = "SELECT [admin_id], [username], [password_hash], [role], [created_at], [isActive] FROM [dbo].[admin] WHERE [admin_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, adminId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAdmin(rs);
                }
            }
        }
        return null;
    }

    // Get Admin by username
    public Admin getAdminByUsername(String username) throws SQLException {
        String sql = "SELECT [admin_id], [username], [password_hash], [role], [created_at], [isActive] FROM [dbo].[admin] WHERE [username] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAdmin(rs);
                }
            }
        }
        return null;
    }

    // Get all Admins
    public List<Admin> getAllAdmins() throws SQLException {
        String sql = "SELECT [admin_id], [username], [password_hash], [role], [created_at], [isActive] FROM [dbo].[admin]";
        List<Admin> admins = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    admins.add(mapResultSetToAdmin(rs));
                }
            }
        }
        return admins;
    }

    // Get paginated admins with status filter
    public List<Admin> getPaginatedAdmins(String status, int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT [admin_id], [username], [password_hash], [role], [created_at], [isActive] FROM [dbo].[admin]");
        List<Object> params = new ArrayList<>();
        if (status != null && !status.isEmpty()) {
            sql.append(" WHERE [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }
        sql.append(" ORDER BY [admin_id] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        List<Admin> admins = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    admins.add(mapResultSetToAdmin(rs));
                }
            }
        }
        return admins;
    }

    // Get total number of admins with status filter
    public int getTotalAdmins(String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[admin]");
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

    // Get paginated admins by username with status filter
    public List<Admin> getPaginatedAdminsByUsername(String username, String status, int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT [admin_id], [username], [password_hash], [role], [created_at], [isActive] FROM [dbo].[admin] WHERE [username] LIKE ?");
        List<Object> params = new ArrayList<>();
        params.add("%" + username + "%");
        if (status != null && !status.isEmpty()) {
            sql.append(" AND [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }
        sql.append(" ORDER BY [admin_id] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        List<Admin> admins = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    admins.add(mapResultSetToAdmin(rs));
                }
            }
        }
        return admins;
    }

    // Get total number of admins by username with status filter
    public int getTotalAdminsByUsername(String username, String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[admin] WHERE [username] LIKE ?");
        List<Object> params = new ArrayList<>();
        params.add("%" + username + "%");
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

    public List<JobPost> manageAllJobPost() {
        List<JobPost> list = new ArrayList<>();
        String sql = "select job_post.job_id, job_post.title, recruiter.company_name, recruiter.email, job_post.status,job_post.created_at, job_post.deadline\n"
                + "from job_post join recruiter on job_post.recruiter_id = recruiter.recruiter_id";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Recruiter recruiter = new Recruiter(rs.getString("email"),
                            rs.getString("company_name")
                    );
                    JobPost jobPost = new JobPost(
                            rs.getInt("job_id"),
                            rs.getString("title"),
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getString("deadline"),
                            rs.getString("status"),
                            recruiter
                    );
                    list.add(jobPost);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateExpiredJobPosts() {
        String sql = "UPDATE job_post SET status = 'Expired' WHERE deadline < CAST(GETDATE() AS DATE) AND status != 'Expired';";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateStatusJobPosts(String status, String jobID) {
        String sql = "UPDATE job_post SET status = ? WHERE job_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, jobID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateStatusJobPostsNew(String status, String jobID) {
        String selectSql = "SELECT status, recruiter_id FROM job_post WHERE job_id = ?";
        String updateSql = "UPDATE job_post SET status = ? WHERE job_id = ?";

        try (PreparedStatement psSelect = c.prepareStatement(selectSql)) {
            psSelect.setString(1, jobID);
            try (ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    String oldStatus = rs.getString("status");
                    String recruiterId = rs.getString("recruiter_id");

                    try (PreparedStatement psUpdate = c.prepareStatement(updateSql)) {
                        psUpdate.setString(1, status);
                        psUpdate.setString(2, jobID);
                        psUpdate.executeUpdate();
                    }

                    // Xử lý cộng/trừ credit
                    if (!oldStatus.equals(status)) {
                        JobPostingPageDAO creditDAO = new JobPostingPageDAO();

                        if ("Rejected".equals(status)) {
                            creditDAO.addServiceCredit(recruiterId, "jobPost");
                        } else if ("Pending".equals(status)) {
                            creditDAO.subtractServiceCredit(recruiterId, "jobPost");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<JobPost> filterAllJobPost(String keyword, String status, String fromDate, String toDate, String sort) {
        List<JobPost> list = new ArrayList<>();
        String sql = "SELECT job_post.job_id, job_post.title, recruiter.company_name, recruiter.email, "
                + "job_post.status, job_post.created_at, job_post.deadline "
                + "FROM job_post JOIN recruiter ON job_post.recruiter_id = recruiter.recruiter_id "
                + "WHERE 1=1";

        // Bộ lọc
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (job_post.title LIKE ? OR recruiter.company_name LIKE ?)";
        }

        if (status != null && !status.trim().isEmpty()) {
            sql += " AND job_post.status = ?";
        }

        if (fromDate != null && !fromDate.trim().isEmpty()) {
            sql += " AND CAST(job_post.created_at AS DATE) >= ?";
        }

        if (toDate != null && !toDate.trim().isEmpty()) {
            sql += " AND CAST(job_post.created_at AS DATE) <= ?";
        }

        // Sắp xếp
        if (sort != null && !sort.isEmpty()) {
            switch (sort) {
                case "created_at_desc":
                    sql += " ORDER BY job_post.created_at DESC";
                    break;
                case "created_at_asc":
                    sql += " ORDER BY job_post.created_at ASC";
                    break;
                case "title_asc":
                    sql += " ORDER BY job_post.title ASC";
                    break;
                case "title_desc":
                    sql += " ORDER BY job_post.title DESC";
                    break;
            }
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String like = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, like);
                ps.setString(paramIndex++, like);
            }

            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            if (fromDate != null && !fromDate.trim().isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(fromDate));
            }

            if (toDate != null && !toDate.trim().isEmpty()) {
                ps.setDate(paramIndex++, Date.valueOf(toDate));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Recruiter recruiter = new Recruiter(
                            rs.getString("email"),
                            rs.getString("company_name")
                    );

                    JobPost jobPost = new JobPost(
                            rs.getInt("job_id"),
                            rs.getString("title"),
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getString("deadline"),
                            rs.getString("status"),
                            recruiter
                    );

                    list.add(jobPost);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<JobPost> getListJobPostByPage(List<JobPost> list, int start, int end) {
        ArrayList<JobPost> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    // Helper method to map ResultSet to Admin object
    private Admin mapResultSetToAdmin(ResultSet rs) throws SQLException {
        Admin admin = new Admin();
        admin.setId(rs.getInt("admin_id"));
        admin.setUsername(rs.getString("username"));
        admin.setPasswordHash(rs.getString("password_hash"));
        admin.setRole(rs.getString("role"));
        Timestamp createdAt = rs.getTimestamp("created_at");
        admin.setCreatedAt(createdAt != null ? createdAt.toLocalDateTime() : null);
        admin.setActive(rs.getBoolean("isActive"));
        return admin;
    }
}
