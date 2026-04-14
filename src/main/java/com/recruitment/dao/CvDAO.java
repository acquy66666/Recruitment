/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.dto.AppliedCVInfoDTO;
import com.recruitment.model.Cv;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author GBCenter
 */
public class CvDAO extends DBcontext {

    public List<Cv> getCvByCandidateId(int id) {
        List<Cv> list = new ArrayList<>();
        String sql = "select * from cv where candidate_id=? and status = 'ACTIVE'";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Cv a = new Cv(
                        rs.getInt("cv_id"),
                        rs.getInt("candidate_id"),
                        rs.getString("title"),
                        rs.getBoolean("isDefault"),
                        rs.getString("created_at"),
                        rs.getString("updated_at"),
                        rs.getString("status"),
                        rs.getString("cv_url")
                );
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi");
        }
        return list;
    }

    public Cv getCvByCvId(int id) {
        String sql = "select * from cv where cv_id=?";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Cv(
                        rs.getInt("cv_id"),
                        rs.getInt("candidate_id"),
                        rs.getString("title"),
                        rs.getBoolean("isDefault"),
                        rs.getString("created_at"),
                        rs.getString("updated_at"),
                        rs.getString("status"),
                        rs.getString("cv_url")
                );
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi");
        }
        return null;
    }

    public Cv getCvByCvIdd(int id) {
        String sql = "select * from cv where cv_id=?";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Cv(
                        rs.getInt("cv_id"),
                        rs.getInt("candidate_id"),
                        rs.getString("title"),
                        rs.getBoolean("isDefault"),
                        rs.getString("created_at"),
                        rs.getString("updated_at"),
                        rs.getString("status"),
                        rs.getString("cv_url"),
                        rs.getString("cv_json")
                );
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noii");
            e.printStackTrace();
        }
        return null;
    }

    public void saveCV(int candidateId, String title, String json, String cvUrl) throws SQLException {
        String sql = "INSERT INTO cv (candidate_id, title, cv_json, cv_url, created_at, updated_at, isDefault, status) "
                + "VALUES (?, ?, ?, ?, GETDATE(), GETDATE(), 0, 'ACTIVE')";

        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, candidateId);
            st.setString(2, title);
            st.setString(3, json);
            st.setString(4, cvUrl);
            st.executeUpdate();
        }
    }

    public void updateCV(int cvId, String title, String json, String cvUrl) throws SQLException {
        String sql = "UPDATE cv SET title = ?, cv_json = ?, cv_url = ?, updated_at = GETDATE() "
                + "WHERE cv_id = ?";

        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setString(1, title);
            st.setString(2, json);
            st.setString(3, cvUrl);
            st.setInt(4, cvId);
            st.executeUpdate();
        }
    }

    public boolean deleteById(int cvId) {
        String sql = "DELETE FROM cv WHERE cv_id = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, cvId);
            int rows = st.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean existsInApplication(int cvId) {
        String sql = "SELECT 1 FROM application WHERE cv_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, cvId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // có bản ghi => true
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateCVStatus(int cvId, String status) {
        String sql = "UPDATE cv SET status = ? WHERE cv_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, cvId);
            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteOrHideCV(int cvId) {
        if (!existsInApplication(cvId)) {
            return deleteById(cvId);
        } else {
            return updateCVStatus(cvId, "Hidden");
        }
    }
    
    public String getFileUrlByIdandCandidateId(int cvId, int candidateId) {
        String sql = "select * from cv where cv_id = ? and candidate_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, cvId);
            ps.setInt(2, candidateId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("file_url");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getCvJsonById(int cvId, int candidateId) throws SQLException {
        String sql = "SELECT cv_json FROM cv WHERE cv_id = ? AND candidate_id = ?";
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, cvId);
            st.setInt(2, candidateId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("cv_json");
                }
            }
        }
        return null;
    }

    public List<AppliedCVInfoDTO> searchAppliedCVInfo(
            String keyword, String address, String gender,
            String edu, String skill, Integer workexpMin,
            int pageIndex, int pageSize,
            int recruiterId
    ) throws SQLException {
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasAddress = address != null && !address.trim().isEmpty();
        boolean hasGender = gender != null && !gender.trim().isEmpty();
        boolean hasEdu = edu != null && !edu.trim().isEmpty();
        boolean hasSkill = skill != null && !skill.trim().isEmpty();
        boolean hasWorkexp = workexpMin != null;

        StringBuilder sql = new StringBuilder("""
        SELECT DISTINCT cv.cv_id, cv.cv_json, cv.cv_url,
                        c.candidate_id, c.full_name, c.gender,
                        c.birthdate, c.address, c.email, c.phone, c.image_url
        FROM application a
        JOIN cv ON a.cv_id = cv.cv_id
        JOIN candidate c ON cv.candidate_id = c.candidate_id
        JOIN job_post j ON a.job_id = j.job_id
    """);

        if (hasEdu) {
            sql.append("""
            CROSS APPLY OPENJSON(cv.cv_json, '$.education')
            WITH (
                education_place NVARCHAR(255) '$.education_place',
                major NVARCHAR(255) '$.major'
            ) AS edu
        """);
        }

        if (hasSkill) {
            sql.append("""
            CROSS APPLY OPENJSON(cv.cv_json, '$.skill_group')
            WITH (
                skill_name NVARCHAR(255) '$.skill_name'
            ) AS sk
        """);
        }

        if (hasWorkexp) {
            sql.append("""
            OUTER APPLY (
                SELECT COUNT(*) AS work_count
                FROM OPENJSON(cv.cv_json, '$.working_experience')
            ) AS wx
        """);
        }

        sql.append(" WHERE j.recruiter_id = ?");

        if (hasKeyword) {
            sql.append(" AND (c.full_name LIKE ? OR c.email LIKE ? OR c.phone LIKE ?)");
        }
        if (hasAddress) {
            sql.append(" AND c.address LIKE ?");
        }
        if (hasGender) {
            sql.append(" AND c.gender = ?");
        }
        if (hasEdu) {
            sql.append(" AND (edu.education_place LIKE ? OR edu.major LIKE ?)");
        }
        if (hasSkill) {
            sql.append(" AND sk.skill_name LIKE ?");
        }
        if (hasWorkexp) {
            sql.append(" AND ISNULL(wx.work_count, 0) >= ?");
        }

        sql.append(" ORDER BY cv.cv_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setInt(index++, recruiterId); // recruiter_id filter

            if (hasKeyword) {
                String like = "%" + keyword + "%";
                ps.setString(index++, like);
                ps.setString(index++, like);
                ps.setString(index++, like);
            }
            if (hasAddress) {
                ps.setString(index++, "%" + address + "%");
            }
            if (hasGender) {
                ps.setString(index++, gender);
            }
            if (hasEdu) {
                String likeEdu = "%" + edu + "%";
                ps.setString(index++, likeEdu);
                ps.setString(index++, likeEdu);
            }
            if (hasSkill) {
                ps.setString(index++, "%" + skill + "%");
            }
            if (hasWorkexp) {
                ps.setInt(index++, workexpMin);
            }

            ps.setInt(index++, (pageIndex - 1) * pageSize); // OFFSET
            ps.setInt(index++, pageSize);                  // FETCH

            ResultSet rs = ps.executeQuery();
            List<AppliedCVInfoDTO> list = new ArrayList<>();
            while (rs.next()) {
                AppliedCVInfoDTO dto = new AppliedCVInfoDTO();
                dto.setCvId(rs.getInt("cv_id"));
                dto.setCvJson(rs.getString("cv_json"));
                dto.setCvUrl(rs.getString("cv_url"));
                dto.setCandidateId(rs.getInt("candidate_id"));
                dto.setFullName(rs.getString("full_name"));
                dto.setGender(rs.getString("gender"));
                dto.setBirthdate(rs.getDate("birthdate"));
                dto.setAddress(rs.getString("address"));
                dto.setEmail(rs.getString("email"));
                dto.setPhone(rs.getString("phone"));
                dto.setImageUrl(rs.getString("image_url"));
                list.add(dto);
            }

            return list;
        }
    }

    public int countAppliedCVInfo(
            String keyword, String address, String gender,
            String edu, String skill, Integer workexpMin,
            int recruiterId
    ) throws SQLException {
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasAddress = address != null && !address.trim().isEmpty();
        boolean hasGender = gender != null && !gender.trim().isEmpty();
        boolean hasEdu = edu != null && !edu.trim().isEmpty();
        boolean hasSkill = skill != null && !skill.trim().isEmpty();
        boolean hasWorkexp = workexpMin != null;

        StringBuilder sql = new StringBuilder("""
        SELECT COUNT(DISTINCT cv.cv_id)
        FROM application a
        JOIN cv ON a.cv_id = cv.cv_id
        JOIN candidate c ON cv.candidate_id = c.candidate_id
        JOIN job_post j ON a.job_id = j.job_id
    """);

        if (hasEdu) {
            sql.append("""
            CROSS APPLY OPENJSON(cv.cv_json, '$.education')
            WITH (
                education_place NVARCHAR(255) '$.education_place',
                major NVARCHAR(255) '$.major'
            ) AS edu
        """);
        }

        if (hasSkill) {
            sql.append("""
            CROSS APPLY OPENJSON(cv.cv_json, '$.skill_group')
            WITH (
                skill_name NVARCHAR(255) '$.skill_name'
            ) AS sk
        """);
        }

        if (hasWorkexp) {
            sql.append("""
            OUTER APPLY (
                SELECT COUNT(*) AS work_count
                FROM OPENJSON(cv.cv_json, '$.working_experience')
            ) AS wx
        """);
        }

        sql.append(" WHERE j.recruiter_id = ?");

        if (hasKeyword) {
            sql.append(" AND (c.full_name LIKE ? OR c.email LIKE ? OR c.phone LIKE ?)");
        }
        if (hasAddress) {
            sql.append(" AND c.address LIKE ?");
        }
        if (hasGender) {
            sql.append(" AND c.gender = ?");
        }
        if (hasEdu) {
            sql.append(" AND (edu.education_place LIKE ? OR edu.major LIKE ?)");
        }
        if (hasSkill) {
            sql.append(" AND sk.skill_name LIKE ?");
        }
        if (hasWorkexp) {
            sql.append(" AND ISNULL(wx.work_count, 0) >= ?");
        }

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setInt(index++, recruiterId);

            if (hasKeyword) {
                String like = "%" + keyword + "%";
                ps.setString(index++, like);
                ps.setString(index++, like);
                ps.setString(index++, like);
            }
            if (hasAddress) {
                ps.setString(index++, "%" + address + "%");
            }
            if (hasGender) {
                ps.setString(index++, gender);
            }
            if (hasEdu) {
                String likeEdu = "%" + edu + "%";
                ps.setString(index++, likeEdu);
                ps.setString(index++, likeEdu);
            }
            if (hasSkill) {
                ps.setString(index++, "%" + skill + "%");
            }
            if (hasWorkexp) {
                ps.setInt(index++, workexpMin);
            }

            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int countDistinctCandidatesByRecruiter(int recruiterId) {
        String sql = "SELECT COUNT(DISTINCT a.candidate_id) AS total_candidates "
                + "FROM application a "
                + "JOIN job_post jp ON a.job_id = jp.job_id "
                + "WHERE jp.recruiter_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total_candidates");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countCandidatesByGender(int recruiterId, String gender) {
        String sql = "SELECT COUNT(DISTINCT a.candidate_id) AS total "
                + "FROM application a "
                + "JOIN job_post jp ON a.job_id = jp.job_id "
                + "JOIN candidate c ON a.candidate_id = c.candidate_id "
                + "WHERE jp.recruiter_id = ? AND c.gender = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, recruiterId);
            ps.setString(2, gender);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

}
