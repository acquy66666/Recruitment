/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.JobAdvertisement;
import com.recruitment.model.JobPost;
import com.recruitment.model.Recruiter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author GBCenter
 */
public class JobAdvertisementDAO extends DBcontext {

    public List<JobAdvertisement> getAllJobAd() {
        List<JobAdvertisement> list = new ArrayList<>();
        RecruiterDAO r = new RecruiterDAO();
        JobPostingPageDAO j = new JobPostingPageDAO();
        String sql = "select * from job_advertisement";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = r.getRecruiterById(rs.getInt("recruiter_id"));
                JobPost jobPost = j.searchJobPostbyJobID(rs.getInt("job_id"));
                JobAdvertisement a = new JobAdvertisement(
                        rs.getInt("ad_id"),
                        rs.getInt("job_id"),
                        rs.getInt("recruiter_id"),
                        rs.getString("description"),
                        rs.getString("thumbnail_url"),
                        rs.getTimestamp("start_date").toLocalDateTime(),
                        rs.getTimestamp("end_date").toLocalDateTime(),
                        rs.getString("status"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        recruiter, jobPost
                );
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi");
        }
        return list;
    }

    public void addAd(int jobId, int recruiterId, String description, String thumbnailUrl, LocalDate startDate, LocalDate endDate) {
        String sql = """
        INSERT INTO [dbo].[job_advertisement]
        ([job_id], [recruiter_id], [description], [thumbnail_url], [start_date], [end_date], [status], [created_at])
        VALUES (?, ?, ?, ?, ?, ?, 'Pending', GETDATE())
    """;
        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, jobId);
            st.setInt(2, recruiterId);
            st.setString(3, description);
            st.setString(4, thumbnailUrl);
            st.setDate(5, java.sql.Date.valueOf(startDate));
            st.setDate(6, java.sql.Date.valueOf(endDate));
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAd(int id, String status) {
        String sql = "update [dbo].[job_advertisement] set status= ? where ad_id=?";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Loi ket noi");
        }
    }

    public List<Integer> getJobIds() {
        List<Integer> jobList = new ArrayList<>();
        String sql = "SELECT DISTINCT job_id FROM job_advertisement";
        try {
            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                jobList.add(rs.getInt("job_id"));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi kết nối: " + e.getMessage());
        }

        return jobList;
    }

    public static void main(String[] args) {
        JobAdvertisementDAO j = new JobAdvertisementDAO();
        System.out.println(j.getAllJobAd().get(0).getRecruiter().getFullName());
    }

    public List<JobAdvertisement> searchJobAds(String jobName, String status, LocalDate fromDate, LocalDate toDate, int page, int pageSize) {
        List<JobAdvertisement> list = new ArrayList<>();
        RecruiterDAO r = new RecruiterDAO();
        JobPostingPageDAO j = new JobPostingPageDAO();
        StringBuilder sql = new StringBuilder("SELECT a.* FROM job_advertisement a ");
        sql.append("JOIN job_post j ON j.job_id = a.job_id WHERE 1=1 ");

        if (jobName != null && !jobName.isEmpty()) {
            sql.append("AND j.title LIKE ? ");
        }
        if (status != null && !status.isEmpty()) {
            sql.append("AND a.status = ? ");
        }
        if (fromDate != null) {
            sql.append("AND a.created_at >= ? ");
        }
        if (toDate != null) {
            sql.append("AND a.created_at <= ? ");
        }

        sql.append("ORDER BY a.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement st = c.prepareStatement(sql.toString());
            int paramIndex = 1;
            if (jobName != null && !jobName.isEmpty()) {
                st.setString(paramIndex++, "%" + jobName + "%");
            }
            if (status != null && !status.isEmpty()) {
                st.setString(paramIndex++, status);
            }
            if (fromDate != null) {
                st.setDate(paramIndex++, java.sql.Date.valueOf(fromDate));
            }
            if (toDate != null) {
                st.setDate(paramIndex++, java.sql.Date.valueOf(toDate));
            }
            st.setInt(paramIndex++, (page - 1) * pageSize);
            st.setInt(paramIndex++, pageSize);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Timestamp tsStart = rs.getTimestamp("start_date");
                LocalDateTime startDate = (tsStart != null) ? tsStart.toLocalDateTime() : null;

                Timestamp tsEnd = rs.getTimestamp("end_date");
                LocalDateTime endDate = (tsEnd != null) ? tsEnd.toLocalDateTime() : null;

                Timestamp tsCreated = rs.getTimestamp("created_at");
                LocalDateTime createdDate = (tsCreated != null) ? tsCreated.toLocalDateTime() : null;

                Recruiter recruiter = r.getRecruiterById(rs.getInt("recruiter_id"));
                JobPost jobPost = j.searchJobPostbyJobID(rs.getInt("job_id"));
                JobAdvertisement a = new JobAdvertisement(
                        rs.getInt("ad_id"),
                        rs.getInt("job_id"),
                        rs.getInt("recruiter_id"),
                        rs.getString("description"),
                        rs.getString("thumbnail_url"),
                        startDate,
                        endDate,
                        rs.getString("status"),
                        createdDate,
                        recruiter, jobPost
                );
                list.add(a);
            }

        } catch (SQLException e) {
            System.out.println("Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
        }

        return list;
    }

    public int countJobAds(String jobName, String status, LocalDate fromDate, LocalDate toDate) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM job_advertisement a ");
        sql.append("JOIN job_post j ON j.job_id = a.job_id WHERE 1=1 ");

        if (jobName != null && !jobName.isEmpty()) {
            sql.append("AND j.title LIKE ? ");
        }
        if (status != null && !status.isEmpty()) {
            sql.append("AND a.status = ? ");
        }
        if (fromDate != null) {
            sql.append("AND a.created_at >= ? ");
        }
        if (toDate != null) {
            sql.append("AND a.created_at <= ? ");
        }

        try {
            PreparedStatement st = c.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (jobName != null && !jobName.isEmpty()) {
                st.setString(paramIndex++, "%" + jobName + "%");
            }
            if (status != null && !status.isEmpty()) {
                st.setString(paramIndex++, status);
            }
            if (fromDate != null) {
                st.setDate(paramIndex++, java.sql.Date.valueOf(fromDate));
            }
            if (toDate != null) {
                st.setDate(paramIndex++, java.sql.Date.valueOf(toDate));
            }

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println("Lỗi khi đếm job ads: " + e.getMessage());
        }

        return count;
    }

}
