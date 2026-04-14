package com.recruitment.dao;

import com.recruitment.dto.CandidateApplicationDTO;
import com.recruitment.model.Candidate;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for managing Candidate entities in the database.
 */
public class CandidateDAO extends DBcontext {

    // Insert a new Candidate
    public int insertCandidate(Candidate candidate) throws SQLException {
        String sql = "INSERT INTO [dbo].[candidate] ([password_hash], [full_name], [gender], [birthdate], [phone], [address], [email], [created_at], [isActive], [image_url], [social_media_url]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), ?, ?, ?)";
        try (PreparedStatement st = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            st.setString(1, candidate.getPasswordHash());
            st.setString(2, candidate.getFullName());
            st.setString(3, candidate.getGender());
            st.setObject(4, candidate.getBirthdate());
            st.setString(5, candidate.getPhone());
            st.setString(6, candidate.getAddress());
            st.setString(7, candidate.getEmail());
            st.setBoolean(8, candidate.isActive());
            st.setString(9, candidate.getImageUrl());
            st.setString(10, candidate.getSocialMediaUrl());

            int affectedRows = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Inserting candidate failed, no rows affected.");
            }
            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated candidate_id
                }
            }
        }
        return -1; // If failed
    }

    // Update an existing Candidate
    public void updateCandidate(Candidate candidate) throws SQLException {
        String sql = "UPDATE [dbo].[candidate] SET [password_hash] = ?, [full_name] = ?, [gender] = ?, [birthdate] = ?, [phone] = ?, [address] = ?, [email] = ?, [isActive] = ?, [image_url] = ?, [social_media_url] = ? WHERE [candidate_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, candidate.getPasswordHash());
            st.setString(2, candidate.getFullName());
            st.setString(3, candidate.getGender());
            st.setObject(4, candidate.getBirthdate());
            st.setString(5, candidate.getPhone());
            st.setString(6, candidate.getAddress());
            st.setString(7, candidate.getEmail());
            st.setBoolean(8, candidate.isActive());
            st.setString(9, candidate.getImageUrl());
            st.setString(10, candidate.getSocialMediaUrl());
            st.setInt(11, candidate.getCandidateId());
            int rowsAffected = st.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No candidate found with ID: " + candidate.getCandidateId());
            }
        }
    }

    // Change Candidate password by email
    public void changeCandidatePasswordByEmail(String email, String newPasswordHash) throws SQLException {
        String sql = "UPDATE [dbo].[candidate] SET [password_hash] = ? WHERE [email] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, newPasswordHash);
            st.setString(2, email);
            int rowsAffected = st.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No candidate found with email: " + email);
            }
        }
    }

    // Delete a Candidate by ID
    public void deleteCandidate(int candidateId) throws SQLException {
        String sql = "DELETE FROM [dbo].[candidate] WHERE [candidate_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            int rowsAffected = st.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No candidate found with ID: " + candidateId);
            }
        }
    }

    // Get all Candidates
    public List<Candidate> getAllCandidate() throws SQLException {
        String sql = "SELECT [candidate_id], [password_hash], [full_name], [gender], [birthdate], [phone], [address], [email], [created_at], [isActive], [image_url], [social_media_url] FROM [dbo].[candidate]";
        List<Candidate> candidates = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql)) {
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    candidates.add(mapResultSetToCandidate(rs));
                }
            }
        }
        return candidates;
    }

    // Get Candidate by email
    public Candidate getCandidateByEmail(String email) throws SQLException {
        String sql = "SELECT [candidate_id], [password_hash], [full_name], [gender], [birthdate], [phone], [address], [email], [created_at], [isActive], [image_url], [social_media_url] FROM [dbo].[candidate] WHERE [email] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCandidate(rs);
                }
            }
        }
        return null;
    }

    // Get Candidate by phone
    public Candidate getCandidateByPhone(String phone) throws SQLException {
        String sql = "SELECT [candidate_id], [password_hash], [full_name], [gender], [birthdate], [phone], [address], [email], [created_at], [isActive], [image_url], [social_media_url] FROM [dbo].[candidate] WHERE [phone] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, phone);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCandidate(rs);
                }
            }
        }
        return null;
    }

    // Activate Candidate
    public void activateCandidate(int candidateId) throws SQLException {
        String sql = "UPDATE [dbo].[candidate] SET [isActive] = ? WHERE [candidate_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setBoolean(1, true);
            st.setInt(2, candidateId);
            int rowsAffected = st.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No candidate found with ID: " + candidateId);
            }
        }
    }

    // Get Candidate by ID
    public Candidate getCandidateById(int candidateId) throws SQLException {
        String sql = "SELECT [candidate_id], [password_hash], [full_name], [gender], [birthdate], [phone], [address], [email], [created_at], [isActive], [image_url], [social_media_url] FROM [dbo].[candidate] WHERE [candidate_id] = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCandidate(rs);
                }
            }
        }
        return null;
    }

    // Get paginated candidates with status filter
    public List<Candidate> getPaginatedCandidates(String status, int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT [candidate_id], [password_hash], [full_name], [gender], [birthdate], [phone], [address], [email], [created_at], [isActive], [image_url], [social_media_url] FROM [dbo].[candidate]");
        List<Object> params = new ArrayList<>();
        if (status != null && !status.isEmpty()) {
            sql.append(" WHERE [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }
        sql.append(" ORDER BY [candidate_id] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        List<Candidate> candidates = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    candidates.add(mapResultSetToCandidate(rs));
                }
            }
        }
        return candidates;
    }

    // Get total number of candidates with status filter
    public int getTotalCandidates(String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[candidate]");
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

    // Get paginated candidates by full name or email with status filter
    public List<Candidate> getPaginatedCandidatesByNameOrEmail(String query, String status, int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT [candidate_id], [password_hash], [full_name], [gender], [birthdate], [phone], [address], [email], [created_at], [isActive], [image_url], [social_media_url] FROM [dbo].[candidate] WHERE ([full_name] LIKE ? OR [email] LIKE ?)");
        List<Object> params = new ArrayList<>();
        params.add("%" + query + "%");
        params.add("%" + query + "%");
        if (status != null && !status.isEmpty()) {
            sql.append(" AND [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }
        sql.append(" ORDER BY [candidate_id] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        List<Candidate> candidates = new ArrayList<>();
        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    candidates.add(mapResultSetToCandidate(rs));
                }
            }
        }
        return candidates;
    }

    // Get total number of candidates by full name or email with status filter
    public int getTotalCandidatesByNameOrEmail(String query, String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[candidate] WHERE ([full_name] LIKE ? OR [email] LIKE ?)");
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

    // Helper method to map ResultSet to Candidate object
    private Candidate mapResultSetToCandidate(ResultSet rs) throws SQLException {
        Candidate candidate = new Candidate();
        candidate.setCandidateId(rs.getInt("candidate_id"));
        candidate.setPasswordHash(rs.getString("password_hash"));
        candidate.setFullName(rs.getString("full_name"));
        candidate.setGender(rs.getString("gender"));
        candidate.setBirthdate(rs.getObject("birthdate", LocalDate.class));
        candidate.setPhone(rs.getString("phone"));
        candidate.setAddress(rs.getString("address"));
        candidate.setEmail(rs.getString("email"));
        candidate.setCreatedAt(rs.getObject("created_at", LocalDateTime.class));
        candidate.setActive(rs.getBoolean("isActive"));
        candidate.setImageUrl(rs.getString("image_url"));
        candidate.setSocialMediaUrl(rs.getString("social_media_url"));
        return candidate;
    }

    public List<CandidateApplicationDTO> searchCandidatesByEmailAndRecruiter(String email, int recruiterId) {
        List<CandidateApplicationDTO> candidates = new ArrayList<>();
        String sql = """
        SELECT DISTINCT c.candidate_id, c.full_name, c.email, c.phone, c.isActive, j.job_id, j.title
        FROM candidate c
        JOIN application a ON c.candidate_id = a.candidate_id
        JOIN job_post j ON a.job_id = j.job_id
        WHERE c.email LIKE ?
          AND a.status = 'Testing'
          AND j.recruiter_id = ?
          AND c.isActive = 1
        ORDER BY c.full_name
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, "%" + email + "%");
            ps.setInt(2, recruiterId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CandidateApplicationDTO candidate = new CandidateApplicationDTO();
                candidate.setCandidateId(rs.getInt("candidate_id"));
                candidate.setFullName(rs.getString("full_name"));
                candidate.setEmail(rs.getString("email"));
                candidate.setPhone(rs.getString("phone"));
                candidate.setActive(rs.getBoolean("isActive"));
                candidate.setJobId(rs.getInt("job_id"));
                candidate.setJobTitle(rs.getString("title"));
                candidates.add(candidate);
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }

        return candidates;
    }

}
