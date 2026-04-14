package com.recruitment.dao;

import com.recruitment.model.Candidate;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CandidateProfileDAO extends DBcontext {

    public Candidate getCandidateProfile(int candidateId) {
        Candidate candidate = null;
        String sql = "SELECT candidate_id, full_name, gender, birthdate, phone, address, email, image_url, social_media_url, isActive "
                + "FROM candidate WHERE candidate_id = ?";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, candidateId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                candidate = new Candidate();
                candidate.setCandidateId(rs.getInt("candidate_id"));
                candidate.setFullName(rs.getString("full_name"));
                candidate.setGender(rs.getString("gender"));
                candidate.setBirthdate(rs.getObject("birthdate", LocalDate.class));
                candidate.setPhone(rs.getString("phone"));
                candidate.setAddress(rs.getString("address"));
                candidate.setEmail(rs.getString("email"));
                candidate.setActive(rs.getBoolean("isActive"));
                candidate.setImageUrl(rs.getString("image_url"));
                candidate.setSocialMediaUrl(rs.getString("social_media_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return candidate;
    }

    public void updateProfile(int id, String fullName, String gender, LocalDate birthday,
            String phone, String address) throws SQLException {
        String sql = "UPDATE candidate SET full_name = ?, gender = ?, birthdate = ?, phone = ?, address = ? WHERE candidate_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, gender);
            ps.setDate(3, java.sql.Date.valueOf(birthday));
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setInt(6, id);
            ps.executeUpdate();
        }
    }

    public void updateCandidateAvatar(int candidateId, String imageUrl) {
        String sql = "UPDATE candidate SET image_url = ? WHERE candidate_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, imageUrl);
            ps.setInt(2, candidateId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void uploadCV(int candidateId, String cvUrl) {
        String sql = "INSERT INTO cv (candidate_id, cv_url) VALUES (?, ?)";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            ps.setString(2, cvUrl);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isEmailDuplicateCandidate(int candidateId, String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM candidate WHERE email = ? AND candidate_id != ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, email);
            st.setInt(2, candidateId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public boolean isPhoneDuplicateCandidate(int candidateId, String phone) throws SQLException {
        String sql = "SELECT COUNT(*) FROM candidate WHERE phone = ? AND candidate_id != ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, phone);
            st.setInt(2, candidateId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }



    public List<String> getAllPhonesExcept(int candidateId) {
        List<String> phones = new ArrayList<>();
        String sql = "SELECT phone FROM candidate WHERE candidate_id <> ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    phones.add(rs.getString("phone"));
                }
            }

        } catch (SQLException e) {
            // Bạn có thể log hoặc ném lại exception tuỳ dự án
            e.printStackTrace();
        }

        return phones;
    }

    public void updateProfile(int id, String fullName, String gender, LocalDate birthday, String phone, String email, String address) throws SQLException {
        String sql = "UPDATE candidate SET full_name = ?, gender = ?, birthdate = ?, phone = ?, email = ?, address = ? WHERE candidate_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, gender);
            ps.setDate(3, java.sql.Date.valueOf(birthday));
            ps.setString(4, phone);
            ps.setString(5, email);
            ps.setString(6, address);
            ps.setInt(7, id);
            ps.executeUpdate();
        }

    }

    public boolean hasAccessToCandidate(int recruiterId, int candidateId) throws SQLException {

        String sql = """
            SELECT COUNT(*) FROM [dbo].[application] a
            JOIN [dbo].[job_post] j ON a.[job_id] = j.[job_id]
            WHERE a.[candidate_id] = ? AND j.[recruiter_id] = ?
        """;


        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            ps.setInt(2, recruiterId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }


    public void logContactAccess(int recruiterId, int candidateId, String ipAddress, String userAgent) throws SQLException {
        String sql = """
            INSERT INTO [dbo].[contact_access_log] ([recruiter_id], [candidate_id], [points_deducted], [ip_address], [user_agent]) 
            VALUES (?, ?, 0, ?, ?)
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setInt(2, candidateId);
            ps.setString(3, ipAddress);
            ps.setString(4, userAgent);
            ps.executeUpdate();
        }
    }

}
