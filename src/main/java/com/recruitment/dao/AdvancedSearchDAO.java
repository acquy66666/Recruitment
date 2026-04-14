/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.dto.JobPostWCompanyDTO;
import com.recruitment.model.Industry;
import com.recruitment.model.JobPost;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdvancedSearchDAO extends DBcontext {

    public List<JobPostWCompanyDTO> getAllJobPostWithCompany() {
        List<JobPostWCompanyDTO> list = new ArrayList<>();
        String sql = "SELECT  \n"
                + "    jp.job_id, jp.recruiter_id, \n"
                + "    jp.title, jp.job_position, jp.location, jp.job_type, \n"
                + "    jp.salary_min, jp.salary_max, jp.experience_level, \n"
                + "    jp.description, jp.created_at, \n"
                + "    r.company_name, r.company_logo_url \n"
                + "FROM job_post jp \n"
                + "JOIN recruiter r ON jp.recruiter_id = r.recruiter_id \n"
                + "WHERE jp.status = N'Đã duyệt'";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        rs.getInt("job_id"),
                        rs.getInt("recruiter_id"),
                        rs.getString("job_position"),
                        rs.getString("title"),
                        rs.getString("location"),
                        rs.getString("job_type"),
                        rs.getDouble("salary_min"),
                        rs.getDouble("salary_max"),
                        rs.getString("experience_level"),
                        rs.getString("description"),
                        null, null,
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        null, "Đã duyệt"
                );

                String companyName = rs.getString("company_name");
                String logoUrl = rs.getString("company_logo_url");

                JobPostWCompanyDTO dto = new JobPostWCompanyDTO(jobPost, companyName, logoUrl);
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<JobPost> getFilterJobTypeList() {
        List<JobPost> filterList = new ArrayList<>();
        String sql = "select distinct job_type from job_post";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        rs.getString("job_type"),
                        null
                );

                filterList.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return filterList;
    }

    public List<JobPost> getFilterJobExpList() {
        List<JobPost> filterList = new ArrayList<>();
        String sql = "select distinct experience_level from job_post";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        null,
                        rs.getString("experience_level")
                );

                filterList.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return filterList;
    }

    public List<JobPost> getFilterLocationList() {
        List<JobPost> filterList = new ArrayList<>();
        String sql = "select distinct location from job_post";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        rs.getString("location")
                );

                filterList.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return filterList;
    }

    public List<Industry> getFilterIndustryList() {
        List<Industry> filterList = new ArrayList<>();
        String sql = "select * from industry";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Industry industry = new Industry(
                        rs.getInt("industry_id"),
                        rs.getString("name")
                );

                filterList.add(industry);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return filterList;
    }

    public int countAllJobPost() {
        return getAllJobPostWithCompany().size();
    }

    public List<JobPostWCompanyDTO> filterJobPosts(String jobType, String expLevel, Double salaryFrom, Double salaryTo, String sort, String searchQuery, Integer industryId, String location, int page, int pageSize) {
        List<JobPostWCompanyDTO> list = new ArrayList<>();
        String sql = "SELECT jp.*, r.company_name, r.company_logo_url "
                + "FROM job_post jp "
                + "JOIN recruiter r ON jp.recruiter_id = r.recruiter_id "
                + "WHERE jp.status = N'Đã duyệt'";

        if (jobType != null && !jobType.isEmpty()) {
            sql += " AND jp.job_type = ?";
        }
        if (expLevel != null && !expLevel.isEmpty()) {
            sql += " AND jp.experience_level = ?";
        }
        if (salaryFrom != null) {
            sql += " AND jp.salary_min >= ?";
        }
        if (salaryTo != null) {
            sql += " AND jp.salary_max <= ?";
        }
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql += " AND (jp.title LIKE ? OR jp.job_position LIKE ? OR jp.description LIKE ?)";
        }
        if (industryId != null) {
            sql += " AND jp.industry_id = ?";
        }
        if (location != null && !location.trim().isEmpty()) {
            sql += " AND jp.location LIKE ?";
        }

        // ORDER BY
        if (sort != null) {
            switch (sort) {
                case "salaryAsc":
                    sql += " ORDER BY jp.salary_min ASC";
                    break;
                case "salaryDesc":
                    sql += " ORDER BY jp.salary_max DESC";
                    break;
                case "lastest":
                    sql += " ORDER BY jp.created_at DESC";
                    break;
                default:
                    sql += " ORDER BY jp.job_id DESC";
            }
        } else {
            sql += " ORDER BY jp.created_at DESC";
        }

        // Phân trang (SQL Server style)
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            int idx = 1;

            if (jobType != null && !jobType.isEmpty()) {
                ps.setString(idx++, jobType);
            }
            if (expLevel != null && !expLevel.isEmpty()) {
                ps.setString(idx++, expLevel);
            }
            if (salaryFrom != null) {
                ps.setDouble(idx++, salaryFrom);
            }
            if (salaryTo != null) {
                ps.setDouble(idx++, salaryTo);
            }
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String keyword = "%" + searchQuery.trim() + "%";
                ps.setString(idx++, keyword); // title
                ps.setString(idx++, keyword); // job_position
                ps.setString(idx++, keyword); // description
            }
            if (industryId != null) {
                ps.setInt(idx++, industryId);
            }
            if (location != null && !location.trim().isEmpty()) {
                ps.setString(idx++, "%" + location.trim() + "%");
            }

            // OFFSET + LIMIT
            ps.setInt(idx++, (page - 1) * pageSize);
            ps.setInt(idx++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost job = new JobPost(
                        rs.getInt("job_id"),
                        rs.getInt("recruiter_id"),
                        rs.getString("job_position"),
                        rs.getString("title"),
                        rs.getString("location"),
                        rs.getString("job_type"),
                        rs.getDouble("salary_min"),
                        rs.getDouble("salary_max"),
                        rs.getString("experience_level"),
                        rs.getString("description"),
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status")
                );

                list.add(new JobPostWCompanyDTO(
                        job,
                        rs.getString("company_name"),
                        rs.getString("company_logo_url")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countFilteredJobPosts(String jobType, String expLevel, Double salaryFrom, Double salaryTo, String searchQuery, Integer industryId, String location) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM job_post jp "
                + "WHERE jp.status = 'Active'";

        if (jobType != null && !jobType.isEmpty()) {
            sql += " AND jp.job_type = ?";
        }
        if (expLevel != null && !expLevel.isEmpty()) {
            sql += " AND jp.experience_level = ?";
        }
        if (salaryFrom != null) {
            sql += " AND jp.salary_min >= ?";
        }
        if (salaryTo != null) {
            sql += " AND jp.salary_max <= ?";
        }
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql += " AND (jp.title LIKE ? OR jp.job_position LIKE ? OR jp.description LIKE ?)";
        }
        if (industryId != null) {
            sql += " AND jp.industry_id = ?";
        }
        if (location != null && !location.trim().isEmpty()) {
            sql += " AND jp.location LIKE ?";
        }

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            int idx = 1;

            if (jobType != null && !jobType.isEmpty()) {
                ps.setString(idx++, jobType);
            }
            if (expLevel != null && !expLevel.isEmpty()) {
                ps.setString(idx++, expLevel);
            }
            if (salaryFrom != null) {
                ps.setDouble(idx++, salaryFrom);
            }
            if (salaryTo != null) {
                ps.setDouble(idx++, salaryTo);
            }
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String keyword = "%" + searchQuery.trim() + "%";
                ps.setString(idx++, keyword); // title
                ps.setString(idx++, keyword); // job_position
                ps.setString(idx++, keyword); // description
            }
            if (industryId != null) {
                ps.setInt(idx++, industryId);
            }
            if (location != null && !location.trim().isEmpty()) {
                ps.setString(idx++, "%" + location.trim() + "%");
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

}
