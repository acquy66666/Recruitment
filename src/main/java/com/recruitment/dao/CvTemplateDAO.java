package com.recruitment.dao;

import com.recruitment.model.CvTemplate;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CvTemplateDAO extends DBcontext {

    public void insert(int candidateId, String title, String htmlContent) throws SQLException {

        String sql = "INSERT INTO cv_template(candidate_id, title, html_content) VALUES(?, ?, ?)";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, candidateId);
            ps.setNString(2, title);
            ps.setNString(3, htmlContent);
            ps.executeUpdate();
        }
    }

    public List<CvTemplate> getAllCvTemplatesByCandidateId(int candidateId) {
        List<CvTemplate> list = new ArrayList<>();
        String sql = "SELECT id, candidate_id, title, html_content, created_at "
                + "FROM cv_template WHERE candidate_id = ?";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, candidateId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CvTemplate cv = new CvTemplate();
                cv.setCvId(rs.getInt("id"));
                cv.setCandidateId(rs.getInt("candidate_id"));
                cv.setTitle(rs.getString("title"));
                cv.setHtmlContent(rs.getString("html_content"));

                list.add(cv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public String getHtmlContentByIdAndCandidate(int templateId, int candidateId) {
        String sql = "SELECT html_content "
                + "FROM cv_template "
                + "WHERE id = ? AND candidate_id = ?";
        String html = null;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, templateId);
            ps.setInt(2, candidateId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    html = rs.getString("html_content");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return html;
    }

    public CvTemplate getCvTemplateByIdAndCandidateId(int id, int candidateId) {
        CvTemplate cv = null;
        String sql = "SELECT * FROM cv_template WHERE id = ? AND candidate_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, candidateId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                cv = new CvTemplate();
                cv.setCvId(rs.getInt("id"));
                cv.setCandidateId(rs.getInt("candidate_id"));
                cv.setTitle(rs.getString("title"));
                cv.setHtmlContent(rs.getString("html_content"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cv;
    }

    public boolean updateHtmlContent(int templateId, int candidateId, String htmlContent, String title)
            throws SQLException {
        String sql = "UPDATE cv_template "
                + "SET html_content = ?, title = ? "
                + "WHERE id = ? AND candidate_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setNString(1, htmlContent);
            ps.setString(2, title);
            ps.setInt(3, templateId);
            ps.setInt(4, candidateId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteCVTemplateByIdAndCandidate(int cvId, int candidateId) {
    String sql = "DELETE FROM cv_template WHERE id = ? AND candidate_id = ?";
    try (PreparedStatement ps = c.prepareStatement(sql)) {

        ps.setInt(1, cvId);
        ps.setInt(2, candidateId);

        int affectedRows = ps.executeUpdate();
        return affectedRows > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

}
