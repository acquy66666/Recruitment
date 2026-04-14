/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.Industry;
import com.recruitment.model.JobPost;
import com.recruitment.model.Recruiter;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.json.JSONObject;

/**
 *
 * @author Mr Duc
 */
public class JobPostingPageDAO extends DBcontext {

    public JobPost searchJobPostbyJobID(int job_id) {
        String sql = "select*from job_post where job_id = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, job_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new JobPost(
                        rs.getInt("job_id"),
                        rs.getInt("recruiter_id"),
                        rs.getInt("industry_id"),
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<JobPost> getAllJobPost() {
        List<JobPost> list = new ArrayList<>();
        String sql = "select * from job_post";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost p = new JobPost(
                        rs.getInt("job_id"),
                        rs.getInt("recruiter_id"),
                        rs.getInt("industry_id"),
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
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> getSuggestedList(double salaryMin, double salaryMax, int recruiterId, int jobId) {
        List<JobPost> list = new ArrayList<>();
        String sql = "select top 3 * from job_post where salary_min >= ? and salary_max <= ? and industry_id= ? and job_id<> ?  AND status = N'Đã duyệt'";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setDouble(1, salaryMin);
            ps.setDouble(2, salaryMax);
            ps.setInt(3, recruiterId);
            ps.setInt(4, jobId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost p = new JobPost(
                        rs.getInt("job_id"),
                        rs.getInt("recruiter_id"),
                        rs.getInt("industry_id"),
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
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> getRecruiterJobList(int recruiterId, int jobId) {
        List<JobPost> list = new ArrayList<>();
        String sql = "select * from job_post where recruiter_id= ? and job_id<> ? AND status = N'Đã duyệt' order by NEWID()";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            ps.setInt(2, jobId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost p = new JobPost(
                        rs.getInt("job_id"),
                        rs.getInt("recruiter_id"),
                        rs.getInt("industry_id"),
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
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> selectAllJobPostRecruiter(String recruiter_id) {
        List<JobPost> list = new ArrayList<>();
        String sql = "select*from job_post join industry on job_post.industry_id = industry.industry_id where recruiter_id = ? AND status != N'Đã ẩn'";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, recruiter_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Industry industry = new Industry(rs.getInt("industry_id"),
                        rs.getString("name")
                );
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
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status"),
                        industry
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> selectAllJobPostRecruiterInsert(String recruiter_id) {
        List<JobPost> list = new ArrayList<>();
        String sql = "select*from job_post join industry on job_post.industry_id = industry.industry_id where recruiter_id = ? order by created_at DESC";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, recruiter_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Industry industry = new Industry(rs.getInt("industry_id"),
                        rs.getString("name")
                );
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
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status"),
                        industry
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> selectAllJobPostLogo() {
        List<JobPost> list = new ArrayList<>();
        String sql = " select*from job_post join recruiter on job_post.recruiter_id = recruiter.recruiter_id\n"
                + "where job_post.status = N'Đã duyệt' order by job_post.created_at desc";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter(rs.getString("company_logo_url"),
                        rs.getString("company_name"),
                        rs.getString("company_address")
                );
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
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status"),
                        recruiter
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> locationAllJobPost(String recruiterID) {
        List<JobPost> list = new ArrayList<>();
        String sql = "select distinct location from job_post where recruiter_id = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, recruiterID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        rs.getString("location")
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> locationAdminJobPost() {
        List<JobPost> list = new ArrayList<>();
        String sql = "select distinct location from job_post";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        rs.getString("location")
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> positionAllJobPost(String recruiterID) {
        List<JobPost> list = new ArrayList<>();
        String sql = "select distinct job_position\n"
                + "from job_post where recruiter_id = ? ";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, recruiterID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        rs.getString("job_position")
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> positionAdminJobPost() {
        List<JobPost> list = new ArrayList<>();
        String sql = "select distinct job_position\n"
                + "from job_post";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        rs.getString("job_position")
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> statusAllJobPost(String recruiterID) {
        List<JobPost> list = new ArrayList<>();
        String sql = "select distinct status\n"
                + "from job_post where recruiter_id = ? AND status <> N'Đã ẩn'";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, recruiterID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        rs.getString("status")
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> statusAdminJobPost() {
        List<JobPost> list = new ArrayList<>();
        String sql = "select distinct status\n"
                + "from job_post";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPost jobPost = new JobPost(
                        rs.getString("status")
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> searchAllJobPost(String keyWord, String recruiterID) {
        List<JobPost> list = new ArrayList<>();
        String sql = "SELECT * \n"
                + "FROM job_post join industry on job_post.industry_id = industry.industry_id \n"
                + "WHERE (title LIKE ? OR job_position LIKE ?) \n"
                + "  AND recruiter_id = ? \n"
                + "ORDER BY created_at DESC;";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            String search = "%" + keyWord + "%";
            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, recruiterID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Industry industry = new Industry(rs.getInt("industry_id"),
                        rs.getString("name")
                );
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
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status"),
                        industry
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insertJobPosts(String recruiter_id, String jobPosition, String title,
            String location, String jobType,
            BigDecimal salaryMin, BigDecimal salaryMax,
            String experienceLevel,
            String description, String requirement,
            String benefit, Date deadline,
            String status, String industry_id) {

        String sql = "INSERT INTO job_post (recruiter_id, job_position, title, location, job_type, "
                + "salary_min, salary_max, experience_level, description, requirement, benefit, "
                + "created_at, deadline, status, industry_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?, ?, ?)";
        try {
            PreparedStatement ps = c.prepareStatement(sql);

            ps.setString(1, recruiter_id);
            ps.setString(2, jobPosition);
            ps.setString(3, title);
            ps.setString(4, location);
            ps.setString(5, jobType);
            ps.setBigDecimal(6, salaryMin);
            ps.setBigDecimal(7, salaryMax);
            ps.setString(8, experienceLevel);
            ps.setString(9, description);
            ps.setString(10, requirement);
            ps.setString(11, benefit);
            ps.setDate(12, deadline);
            ps.setString(13, status);
            ps.setString(14, industry_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateJobPosts(String jobId, String jobPosition, String title,
            String location, String jobType,
            BigDecimal salaryMin, BigDecimal salaryMax,
            String experienceLevel,
            String description, String requirement,
            String benefit, Date deadline,
            String status, String industryId) {

        String sql = "UPDATE job_post SET "
                + "job_position = ?, title = ?, location = ?, job_type = ?, "
                + "salary_min = ?, salary_max = ?, experience_level = ?, description = ?, "
                + "requirement = ?, benefit = ?, deadline = ?, status = ?, industry_id = ? "
                + "WHERE job_id = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, jobPosition);
            ps.setString(2, title);
            ps.setString(3, location);
            ps.setString(4, jobType);
            ps.setBigDecimal(5, salaryMin);
            ps.setBigDecimal(6, salaryMax);
            ps.setString(7, experienceLevel);
            ps.setString(8, description);
            ps.setString(9, requirement);
            ps.setString(10, benefit);
            ps.setDate(11, deadline);
            ps.setString(12, status);
            ps.setString(13, industryId);
            ps.setString(14, jobId); // Đây là điều kiện WHERE

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void hideJobPost(String jobId) {
        String sql = "UPDATE job_post SET status = N'Đã ẩn' WHERE job_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, jobId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteJobPosts(String jobId) {
        String sql = "-- Xóa phản hồi liên quan qua assignment và job\n"
                + "DELETE FROM response WHERE assignment_id IN (\n"
                + "    SELECT assignment_id FROM assignment WHERE job_id = ?\n"
                + ");\n"
                + "\n"
                + "-- Xóa assignment liên quan\n"
                + "DELETE FROM assignment WHERE job_id = ?;\n"
                + "\n"
                + "-- Xóa application liên quan\n"
                + "DELETE FROM application WHERE job_id = ?;\n"
                + "\n"
                + "-- Xóa bookmark liên quan\n"
                + "DELETE FROM bookmark WHERE job_id = ?;\n"
                + "\n"
                + "-- Cuối cùng xóa job_post\n"
                + "DELETE FROM job_post WHERE job_id = ?;";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, jobId);
            ps.setString(2, jobId);
            ps.setString(3, jobId);
            ps.setString(4, jobId);
            ps.setString(5, jobId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    public List<JobPost> filterJobPost(String recruiterId, String position, String location, String status, String sort, String search) {
//        ArrayList<JobPost> list = new ArrayList<>();
//        String sql = "select*from job_post where 1 = 1";
//        sql += " and recruiter_id = ?";
//
//        if (position != null && !position.trim().isEmpty()) {
//            sql += " and job_position = ?";
//        }
//        if (location != null && !location.trim().isEmpty()) {
//            sql += " AND location = ?";
//        }
//        // Lọc theo status (dropdown)
//        if (status != null && !status.trim().isEmpty()) {
//            sql += " AND status = ?";
////      
//        }
//        if (search != null && !search.trim().isEmpty()) {
//            sql += " and title like ?";
//        }
////        sql += " and created_at >= '2025-05-25' and created_at < '2025-05-26'";
//        if (sort != null) {
//            switch (sort) {
//                case "salary_asc":
//                    sql += " Order by salary_min asc";
//                    break;
//                case "salary_desc":
//                    sql += " ORDER BY salary_max DESC";
//                    break;
//                case "date_asc":
//                    sql += " ORDER BY created_at ASC";
//                    break;
//                case "date_desc":
//                    sql += " ORDER BY created_at DESC";
//                    break;
////                case "status-asc":
////                    sql += " ORDER BY status ASC";
////                    break;
////                case "status-desc":
////                    sql += " ORDER BY status DESC";
////                    break;
//                }
//        }
//        try {
//            PreparedStatement ps = c.prepareStatement(sql);
//            int param = 1;
//            ps.setString(param++, recruiterId);
//            if (position != null && !position.trim().isEmpty()) {
//                ps.setString(param++, position);
//            }
//            if (location != null && !location.trim().isEmpty()) {
//                ps.setString(param++, location);
//            }
//            if (status != null && !status.trim().isEmpty()) {
//                ps.setString(param++, status);
//            }
//            if (search != null && !search.trim().isEmpty()) {
//                ps.setString(param++, "%" + search + "%");
//            }
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                JobPost jobPost = new JobPost(
//                        rs.getInt("job_id"),
//                        rs.getInt("recruiter_id"),
//                        rs.getString("job_position"),
//                        rs.getString("title"),
//                        rs.getString("location"),
//                        rs.getString("job_type"),
//                        rs.getDouble("salary_min"),
//                        rs.getDouble("salary_max"),
//                        rs.getString("experience_level"),
//                        rs.getString("description"),
//                        rs.getString("requirement"),
//                        rs.getString("benefit"),
//                        rs.getTimestamp("created_at").toLocalDateTime(),
//                        rs.getString("deadline"),
//                        rs.getString("status")
//                );
//                list.add(jobPost);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
    //    -------------------------------------------------------------------------------------------------------------
//    public List<JobPost> filterJobPost(String recruiterId, String position, String location, String status, String sort, String search) {
//        List<JobPost> list = new ArrayList<>();
//        String sql = "SELECT * FROM job_post WHERE 1 = 1";
//
//        // Luôn lọc theo recruiter_id
//        sql += " AND recruiter_id = ?";
//
//        // Lọc theo position (dropdown)
//        if (position != null && !position.trim().isEmpty()) {
//            sql += " AND job_position = ?";
//        }
//
//        // Lọc theo location (dropdown)
//        if (location != null && !location.trim().isEmpty()) {
//            sql += " AND location = ?";
//        }
//
//        // Lọc theo status (dropdown)
//        if (status != null && !status.trim().isEmpty()) {
//            sql += " AND status = ?";
//        }
//
//        if (search != null && !search.trim().isEmpty()) {
//            sql += " AND title LIKE ?";
//        }
//        // Sắp xếp
//        if (sort != null) {
//            switch (sort) {
//                case "salary_asc":
//                    sql += " ORDER BY salary_min ASC";
//                    break;
//                case "salary_desc":
//                    sql += " ORDER BY salary_max DESC";
//                    break;
//                case "date_asc":
//                    sql += " ORDER BY created_at ASC";
//                    break;
//                case "date_desc":
//                    sql += " ORDER BY created_at DESC";
//                    break;
//                //                case "status-asc":
//                //                    sql += " ORDER BY status ASC";
//                //                    break;
//                //                case "status-desc":
//                //                    sql += " ORDER BY status DESC";
//                //                    break;
//                }
//        }
//
//        try {
//            PreparedStatement ps = c.prepareStatement(sql);
//            int paramIndex = 1;
//            // Set recruiterId đầu tiên
//            ps.setString(paramIndex++, recruiterId);
//
//            if (position != null && !position.trim().isEmpty()) {
//                ps.setString(paramIndex++, position);
//            }
//            if (location != null && !location.trim().isEmpty()) {
//                ps.setString(paramIndex++, location);
//            }
//            if (status != null && !status.trim().isEmpty()) {
//                ps.setString(paramIndex++, status);
//            }
//            if (search != null && !search.trim().isEmpty()) {
//                ps.setString(paramIndex++, "%" + search + "%");
//            }
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                JobPost jobPost = new JobPost(
//                        rs.getInt("job_id"),
//                        rs.getInt("recruiter_id"),
//                        rs.getString("job_position"),
//                        rs.getString("title"),
//                        rs.getString("location"),
//                        rs.getString("job_type"),
//                        rs.getDouble("salary_min"),
//                        rs.getDouble("salary_max"),
//                        rs.getString("experience_level"),
//                        rs.getString("description"),
//                        rs.getString("requirement"),
//                        rs.getString("benefit"),
//                        rs.getTimestamp("created_at").toLocalDateTime(),
//                        rs.getString("deadline"),
//                        rs.getString("status")
//                );
//                list.add(jobPost);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
//        public List<JobPost> SearchJobPostByJobSeeker(String keyword, String jobType, String experienceLevel, String location) {
//        List<JobPost> list = new ArrayList<>();
//        String sql = "SELECT * FROM job_post "
//                + "JOIN recruiter ON job_post.recruiter_id = recruiter.recruiter_id "
//                + "WHERE 1 = 1";
//
//        // Tìm theo từ khóa ở nhiều cột
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            String[] parts = keyword.split(",");
//            sql += " AND (";
//
//            for (int i = 0; i < parts.length; i++) {
//                String part = parts[i].trim();
//                if (!part.isEmpty()) {
//                    if (i > 0) {
//                        sql += " OR ";
//                    }
//                    sql += "(job_position LIKE ? OR requirement LIKE ? OR title LIKE ? OR company_name LIKE ?)";
//                }
//            }
//
//            sql += ")";
//        }
//
//        if (jobType != null && !jobType.trim().isEmpty()) {
//            sql += " AND job_type = ?";
//        }
//
//        if (experienceLevel != null && !experienceLevel.trim().isEmpty()) {
//            sql += " AND experience_level = ?";
//        }
//
//        if (location != null && !location.trim().isEmpty()) {
//            sql += " AND company_address = ?";
//        }
//
//        try {
//            PreparedStatement ps = c.prepareStatement(sql);
//            int paramIndex = 1;
//
//            if (keyword != null && !keyword.trim().isEmpty()) {
//                String[] parts = keyword.split(",");
//                for (int i = 0; i < parts.length; i++) {
//                    String part = parts[i].trim();
//                    String likeKeyword = "%" + part + "%";
//                    ps.setString(paramIndex++, likeKeyword); // job_position
//                    ps.setString(paramIndex++, likeKeyword); // requirement
//                    ps.setString(paramIndex++, likeKeyword); // title
//                    ps.setString(paramIndex++, likeKeyword); // company_name
//                }
//
//            }
//
//            if (jobType != null && !jobType.trim().isEmpty()) {
//                ps.setString(paramIndex++, jobType);
//            }
//
//            if (experienceLevel != null && !experienceLevel.trim().isEmpty()) {
//                ps.setString(paramIndex++, experienceLevel);
//            }
//
//            if (location != null && !location.trim().isEmpty()) {
//                ps.setString(paramIndex++, location);
//            }
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Recruiter recruiter = new Recruiter(rs.getString("company_logo_url"),
//                        rs.getString("company_name"),
//                        rs.getString("company_address")
//                );
//                JobPost jobPost = new JobPost(
//                        rs.getInt("job_id"),
//                        rs.getInt("recruiter_id"),
//                        rs.getString("job_position"),
//                        rs.getString("title"),
//                        rs.getString("location"),
//                        rs.getString("job_type"),
//                        rs.getDouble("salary_min"),
//                        rs.getDouble("salary_max"),
//                        rs.getString("experience_level"),
//                        rs.getString("description"),
//                        rs.getString("requirement"),
//                        rs.getString("benefit"),
//                        rs.getTimestamp("created_at").toLocalDateTime(),
//                        rs.getString("deadline"),
//                        rs.getString("status"),
//                        recruiter
//                );
//
//                // Nếu bạn có thêm field `company_name` trong JobPost thì bạn có thể thêm vào đây:
//                // jobPost.setCompanyName(rs.getString("company_name"));
//                list.add(jobPost);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
    //    -------------------------------------------------------------------------------------------------------------
    public List<JobPost> SearchJobPostByJobSeeker(String keyword, String jobType, String experienceLevel, String location) {
        List<JobPost> list = new ArrayList<>();
        String sql = "SELECT * FROM job_post "
                + "JOIN recruiter ON job_post.recruiter_id = recruiter.recruiter_id "
                + "WHERE 1 = 1 AND job_post.status = N'Đã duyệt'";

        // Tìm theo từ khóa ở nhiều cột
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (job_position LIKE ? OR requirement LIKE ? OR title LIKE ? OR company_name LIKE ?)";
        }

        if (jobType != null && !jobType.trim().isEmpty()) {
            sql += " AND job_type = ?";
        }

        if (experienceLevel != null && !experienceLevel.trim().isEmpty()) {
            sql += " AND experience_level = ?";
        }

        if (location != null && !location.trim().isEmpty()) {
            sql += " AND company_address = ?";
        }

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String likeKeyword = "%" + keyword + "%";
                ps.setString(paramIndex++, likeKeyword); // job_position
                ps.setString(paramIndex++, likeKeyword); // requirement
                ps.setString(paramIndex++, likeKeyword); // title
                ps.setString(paramIndex++, likeKeyword); // company_name
            }

            if (jobType != null && !jobType.trim().isEmpty()) {
                ps.setString(paramIndex++, jobType);
            }

            if (experienceLevel != null && !experienceLevel.trim().isEmpty()) {
                ps.setString(paramIndex++, experienceLevel);
            }

            if (location != null && !location.trim().isEmpty()) {
                ps.setString(paramIndex++, location);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter(rs.getString("company_logo_url"),
                        rs.getString("company_name"),
                        rs.getString("company_address")
                );
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
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status"),
                        recruiter
                );

                // Nếu bạn có thêm field `company_name` trong JobPost thì bạn có thể thêm vào đây:
                // jobPost.setCompanyName(rs.getString("company_name"));
                list.add(jobPost);
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

    public int totalJobsJobPostsRecruiter(String recruiterId) {

        String sql = "select count(job_id)\n"
                + "from job_post where recruiter_id = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int totalJobsJobPostsRecruiterActive(String recruiterId) {

        String sql = "select count(job_id)\n"
                + "from job_post where recruiter_id = ? and status = 'Active'";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Industry> selectAllIndustry() {
        List<Industry> list = new ArrayList<>();
        String sql = "select*from industry";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Industry industryer = new Industry(rs.getInt("industry_id"),
                        rs.getString("name")
                );
                list.add(industryer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<JobPost> getJobPostTitlesByRecruiterId(int recruiterId) {
        List<JobPost> list = new ArrayList<>();
        String sql = "SELECT jp.job_id, jp.title, jp.status, r.company_name \n"
                + "FROM job_post jp \n"
                + "JOIN recruiter r ON jp.recruiter_id = r.recruiter_id\n"
                + "WHERE jp.recruiter_id = ? AND jp.status = N'Đã duyệt'";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    JobPost job = new JobPost();
                    job.setJobId(rs.getInt("job_id"));
                    job.setTitle(rs.getString("title"));

                    list.add(job);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public JobPost selectJobPostEditByID(String jobId) {
        String sql = "select*from job_post join industry on job_post.industry_id = industry.industry_id where job_id = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, jobId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Industry industry = new Industry(rs.getInt("industry_id"),
                        rs.getString("name")
                );
                return new JobPost(
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
                        rs.getString("status"),
                        industry
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<JobPost> filterJobPostAdvanced(
            String recruiterId,
            String position,
            String location,
            List<String> statuses,
            List<String> jobTypes,
            List<String> experienceLevels,
            List<String> industryID,
            String sort) {

        List<JobPost> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        String sql = "SELECT * FROM job_post WHERE 1=1";

        sql += " AND recruiter_id = ?";
        params.add(recruiterId);

        if (position != null && !position.trim().isEmpty()) {
            sql += " AND job_position = ?";
            params.add(position);
        }

        if (location != null && !location.trim().isEmpty()) {
            sql += " AND location = ?";
            params.add(location);
        }

        if (statuses != null && !statuses.isEmpty()) {
            sql += " AND status IN (" + generatePlaceholders(statuses.size()) + ")";
            params.addAll(statuses);
        } else {
            sql += " AND status <> N'Đã ẩn'";
        }

        if (jobTypes != null && !jobTypes.isEmpty()) {
            sql += " AND job_type IN (" + generatePlaceholders(jobTypes.size()) + ")";
            params.addAll(jobTypes);
        }

        if (experienceLevels != null && !experienceLevels.isEmpty()) {
            sql += " AND experience_level IN (" + generatePlaceholders(experienceLevels.size()) + ")";
            params.addAll(experienceLevels);
        }
        if (industryID != null && !industryID.isEmpty()) {
            sql += " AND industry_id IN (" + generatePlaceholders(industryID.size()) + ")";
            params.addAll(industryID);
        }

//        if (search != null && !search.trim().isEmpty()) {
//            sql += " AND title LIKE ?";
//            params.add("%" + search + "%");
//        }
        // Sort
        if (sort != null) {
            switch (sort) {
                case "salary_asc":
                    sql += " ORDER BY salary_min ASC";
                    break;
                case "salary_desc":
                    sql += " ORDER BY salary_max DESC";
                    break;
                case "date_asc":
                    sql += " ORDER BY deadline ASC";
                    break;
                case "date_desc":
                    sql += " ORDER BY deadline DESC";
                    break;
            }
        }

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
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
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status")
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private String generatePlaceholders(int count) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < count; i++) {
            sb.append("?");
            if (i < count - 1) {
                sb.append(", ");
            }
        }
        return sb.toString();
    }

    public List<JobPost> filterJobPostAdvancedAdmin(
            String position,
            String location,
            List<String> statuses,
            List<String> jobTypes,
            List<String> experienceLevels,
            List<String> industryID,
            String sort, String search) {

        List<JobPost> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        String sql = "SELECT * FROM job_post JOIN industry ON job_post.industry_id = industry.industry_id WHERE 1=1";

        if (position != null && !position.trim().isEmpty()) {
            sql += " AND job_position = ?";
            params.add(position);
        }

        if (location != null && !location.trim().isEmpty()) {
            sql += " AND location = ?";
            params.add(location);
        }

        if (statuses != null && !statuses.isEmpty()) {
            sql += " AND status IN (" + generatePlaceholders(statuses.size()) + ")";
            params.addAll(statuses);
        }

        if (jobTypes != null && !jobTypes.isEmpty()) {
            sql += " AND job_type IN (" + generatePlaceholders(jobTypes.size()) + ")";
            params.addAll(jobTypes);
        }

        if (experienceLevels != null && !experienceLevels.isEmpty()) {
            sql += " AND experience_level IN (" + generatePlaceholders(experienceLevels.size()) + ")";
            params.addAll(experienceLevels);
        }
        if (industryID != null && !industryID.isEmpty()) {
            sql += " AND job_post.industry_id IN (" + generatePlaceholders(industryID.size()) + ")";
            params.addAll(industryID);
        }

//        if (search != null && !search.trim().isEmpty()) {
//            String[] keywords = search.split(",");
//            sql += " AND (";
//            for (int i = 0; i < keywords.length; i++) {
//                if (i > 0) {
//                    sql += " OR ";
//                }
//                sql += "title LIKE ?";
//                params.add("%" + keywords[i].trim() + "%");
//            }
//            sql += ")";
//        }
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND title LIKE ?";
            params.add("%" + search.trim() + "%");
        }
        // Sort
        if (sort != null) {
            switch (sort) {
                case "salary_asc":
                    sql += " ORDER BY salary_min ASC";
                    break;
                case "salary_desc":
                    sql += " ORDER BY salary_max DESC";
                    break;
                case "date_asc":
                    sql += " ORDER BY created_at ASC";
                    break;
                case "date_desc":
                    sql += " ORDER BY created_at DESC";
                    break;
            }
        }

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Industry industry = new Industry(rs.getInt("industry_id"),
                        rs.getString("name")
                );
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
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status"),
                        industry
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
//    public List<JobPost> filterTEST(String recruiterId,
//            String position,
//            List<String> statuses) {
//
//        List<JobPost> list = new ArrayList<>();
//        List<Object> param = new ArrayList<>();
//
//        String sql = "SELECT * FROM job_post WHERE 1=1";
//        sql += " AND recruiter_id = ?";
//        param.add(recruiterId);
//
//        if (position != null && !position.isEmpty()) {
//            sql += " AND position = ?";
//            param.add(position);
//        }
//        if (statuses != null && !statuses.isEmpty()) {
//            sql += " AND status in( " + getHoiCham(statuses.size()) + " )";
//            param.addAll(statuses);
//        }
//        try{
//            PreparedStatement ps = c.prepareStatement(sql);
//            for (int i = 0; i < param.size(); i++) {
//                ps.setObject(i+1, param.get(i));
//            }
//            ResultSet rs = ps.executeQuery();
//            while(rs.next()){
//                JobPost jobPost = new JobPost(
//                        rs.getInt("job_id"),
//                        rs.getInt("recruiter_id"),
//                        rs.getString("job_position"),
//                        rs.getString("title"),
//                        rs.getString("location"),
//                        rs.getString("job_type"),
//                        rs.getDouble("salary_min"),
//                        rs.getDouble("salary_max"),
//                        rs.getString("experience_level"),
//                        rs.getString("description"),
//                        rs.getString("requirement"),
//                        rs.getString("benefit"),
//                        rs.getTimestamp("created_at").toLocalDateTime(),
//                        rs.getString("deadline"),
//                        rs.getString("status")
//                );
//                list.add(jobPost);
//            }
//        }catch(Exception e){
//             e.printStackTrace();
//        }
//        return list;
//    }
//
//    public String getHoiCham(int size) {
//        StringBuilder sb = new StringBuilder();
//        for (int i = 0; i < size; i++) {
//            sb.append("?");
//            if (i < size - 1) {
//                sb.append(",");
//            }
//        }
//        return sb.toString();
//    }
//    public List<JobPost> filterJobPostSearch(String recruiterId, String search) {
//        List<JobPost> list = new ArrayList<>();
//        String sql = "SELECT *\n"
//                + "FROM job_post\n"
//                + "JOIN industry ON job_post.industry_id = industry.industry_id\n"
//                + "WHERE \n"
//                + "    job_post.recruiter_id = ? AND (\n"
//                + "        job_post.title LIKE ? OR\n"
//                + "        job_post.job_position LIKE ? OR\n"
//                + "        job_post.location LIKE ? OR\n"
//                + "        industry.name LIKE ?\n"
//                + "    );";
//
//        try {
//            PreparedStatement ps = c.prepareStatement(sql);
//            ps.setString(1, recruiterId);
//            ps.setString(2, "%" + search + "%");
//            ps.setString(3, "%" + search + "%");
//            ps.setString(4, "%" + search + "%");
//            ps.setString(5, "%" + search + "%");
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                JobPost jobPost = new JobPost(
//                        rs.getInt("job_id"),
//                        rs.getInt("recruiter_id"),
//                        rs.getString("job_position"),
//                        rs.getString("title"),
//                        rs.getString("location"),
//                        rs.getString("job_type"),
//                        rs.getDouble("salary_min"),
//                        rs.getDouble("salary_max"),
//                        rs.getString("experience_level"),
//                        rs.getString("description"),
//                        rs.getString("requirement"),
//                        rs.getString("benefit"),
//                        rs.getTimestamp("created_at").toLocalDateTime(),
//                        rs.getString("deadline"),
//                        rs.getString("status")
//                );
//                list.add(jobPost);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    } 
    //    Ham de test
//    public String testSearch (){
//        String search = "Nhân viên, Test, Thử";
//        String sql ="";
//        if (search != null && !search.trim().isEmpty()) {
//            sql += " AND (";
//            String[] parts = search.split(",");
//            for (int i = 0; i < parts.length; i++) {
//                if(i >0 ){
//                    sql += " OR ";
//                }
//                sql += "job_post.title LIKE ? ";
//            }
//            sql += " )";
//        }
//        return sql;
//            if (search != null && !search.trim().isEmpty()) {
////   bo       ------  sql += " AND job_post.title LIKE ?";
//            sql += " AND (";
//            String[] parts = search.split(",");
//            for (int i = 0; i < parts.length; i++) {
//                if(i > 0 ){
//                    sql += " OR ";
//                }
//                sql += "job_post.title LIKE ? ";
//            }
//            sql += " )";
//        }
//    String[] rawParts = search.split(",");
//List<String> parts = new ArrayList<>();
//for (String part : rawParts) {
//    String trimmed = part.trim();
//    if (!trimmed.isEmpty()) {
//        parts.add(trimmed);
//    }
//}String searchNew = search.replace("\\s+", " ");
//    }   

    public List<JobPost> filterJobPostSearch(String recruiterId, String search) {
        List<JobPost> list = new ArrayList<>();

        String sql = "SELECT * "
                + "FROM job_post "
                + "JOIN industry ON job_post.industry_id = industry.industry_id "
                + "WHERE job_post.recruiter_id = ? AND job_post.status != N'Đã ẩn' ";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND job_post.title LIKE ?";
        }

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, recruiterId);

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(2, "%" + search.trim() + "%");
            }

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
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status")
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<JobPost> selectAllJobPostAdmin() {
        List<JobPost> list = new ArrayList<>();
        String sql = "select*from job_post join industry on job_post.industry_id = industry.industry_id";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Industry industry = new Industry(rs.getInt("industry_id"),
                        rs.getString("name")
                );
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
                        rs.getString("requirement"),
                        rs.getString("benefit"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getString("deadline"),
                        rs.getString("status"),
                        industry
                );
                list.add(jobPost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

//    public boolean useOneCredit(String recruiterId) {
//        int totalCredit = 0;
//        int usedCredit = 0;
//        String totalCreditSql = """
//        SELECT ISNULL(SUM(s.credit), 0) AS total_credit
//        FROM transaction_detail td
//        JOIN [transaction] t ON td.transaction_id = t.transaction_id
//        JOIN service s ON td.service_id = s.service_id
//        WHERE t.recruiter_id = ? AND s.title = N'Online Test – C# haha';
//    """;
//
//        String usedCreditSql = """
//        SELECT COUNT(*) AS used_credit
//        FROM job_post
//        WHERE recruiter_id = ?
//          AND status IN (N'Chờ duyệt', N'Đã duyệt', N'Đã hết hạn')
//    """;
//
//        try {
//            PreparedStatement ps = c.prepareStatement(totalCreditSql);
//            ps.setString(1, recruiterId);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                totalCredit = rs.getInt("total_credit");
//            }
//            rs.close();
//            ps.close();
//
//            ps = c.prepareStatement(usedCreditSql);
//            ps.setString(1, recruiterId);
//            rs = ps.executeQuery();
//            if (rs.next()) {
//                usedCredit = rs.getInt("used_credit");
//            }
//            rs.close();
//            ps.close();
//
//            // So sánh credit đã dùng với credit đã mua
//            return usedCredit < totalCredit;
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return false;
//    }
    public boolean subtractServiceCredit(String recruiterId, String serviceType) {
        String selectSql = "SELECT credit FROM recruiter WHERE recruiter_id = ?";
        String updateSql = "UPDATE recruiter SET credit = ? WHERE recruiter_id = ?";

        try (PreparedStatement psSelect = c.prepareStatement(selectSql)) {
            psSelect.setString(1, recruiterId);

            try (ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    String creditJson = rs.getString("credit");

                    // Chưa mua gói dịch vụ nào
                    if (creditJson == null || creditJson.trim().isEmpty()) {
                        System.out.println("Recruiter chưa có dữ liệu credit.");
                        return false;
                    }

                    JSONObject json = new JSONObject(creditJson);

                    // Không có gói đang yêu cầu
                    if (!json.has(serviceType)) {
                        System.out.println("Recruiter chưa mua gói: " + serviceType);
                        return false;
                    }

                    int currentCredit = json.getInt(serviceType);
                    if (currentCredit <= 0) {
                        System.out.println("Không đủ credit để trừ.");
                        return false;
                    }

                    // Trừ 1 credit
                    json.put(serviceType, currentCredit - 1);

                    try (PreparedStatement psUpdate = c.prepareStatement(updateSql)) {
                        psUpdate.setString(1, json.toString());
                        psUpdate.setString(2, recruiterId);
                        psUpdate.executeUpdate();
                        System.out.println("Trừ credit thành công.");
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean addServiceCredit(String recruiterId, String serviceType) {
        String selectSql = "SELECT credit FROM recruiter WHERE recruiter_id = ?";
        String updateSql = "UPDATE recruiter SET credit = ? WHERE recruiter_id = ?";

        try (PreparedStatement psSelect = c.prepareStatement(selectSql)) {
            psSelect.setString(1, recruiterId);

            try (ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    String creditJson = rs.getString("credit");

                    JSONObject json;

                    if (creditJson == null || creditJson.trim().isEmpty()) {
                        json = new JSONObject();
                    } else {
                        json = new JSONObject(creditJson);
                    }

                    int currentCredit = json.optInt(serviceType, 0);
                    json.put(serviceType, currentCredit + 1);

                    try (PreparedStatement psUpdate = c.prepareStatement(updateSql)) {
                        psUpdate.setString(1, json.toString());
                        psUpdate.setString(2, recruiterId);
                        psUpdate.executeUpdate();
                        System.out.println("Cộng credit thành công.");
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

//    public List<JobPost> filterJobPostSearch(String recruiterId, String search) {
//        List<JobPost> list = new ArrayList<>();
//        StringBuilder sql = new StringBuilder(
//                "SELECT * FROM job_post WHERE recruiter_id = ?"
//        );
//
//        if (search != null && !search.trim().isEmpty()) {
//            String[] parts = search.split(",");
//            sql.append(" AND (");
//            for (int i = 0; i < parts.length; i++) {
//                if (i > 0) {
//                    sql.append(" OR ");
//                }
//                sql.append("title LIKE ?");
//            }
//            sql.append(")");
//        }
//
//        try {
//            PreparedStatement ps = c.prepareStatement(sql.toString());
//            int paramIndex = 1;
//            ps.setString(paramIndex++, recruiterId);
//
//            if (search != null && !search.trim().isEmpty()) {
//                String[] parts = search.split(",");
//                for (String part : parts) {
//                    ps.setString(paramIndex++, "%" + part.trim() + "%");
//                }
//            }
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                JobPost jobPost = new JobPost(
//                        rs.getInt("job_id"),
//                        rs.getInt("recruiter_id"),
//                        rs.getString("job_position"),
//                        rs.getString("title"),
//                        rs.getString("location"),
//                        rs.getString("job_type"),
//                        rs.getDouble("salary_min"),
//                        rs.getDouble("salary_max"),
//                        rs.getString("experience_level"),
//                        rs.getString("description"),
//                        rs.getString("requirement"),
//                        rs.getString("benefit"),
//                        rs.getTimestamp("created_at").toLocalDateTime(),
//                        rs.getString("deadline"),
//                        rs.getString("status")
//                );
//                list.add(jobPost);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
    public static void main(String[] args) {
        JobPostingPageDAO jb = new JobPostingPageDAO();
        // Dữ liệu mẫu để chèn bài đăng tuyển dụng
        String recruiter_id = "2"; // ID nhà tuyển dụng
        String jobPosition = "QA";
        String title = "Tuyển dụng QA";
        String location = "TP.HCM";
        String jobType = "Part-time";
        BigDecimal salaryMin = new BigDecimal("5000.00");
        BigDecimal salaryMax = new BigDecimal("8500.00");
        String experienceLevel = "Junior";
        String description = "Tham gia phát triển giao diện web bằng C++";
        String requirements = "Có kinh nghiệm với ChatGPT.";
        String benefits = "Thưởng lễ, bảo hiểm, giờ làm linh hoạt.";
        Date deadline = Date.valueOf("2025-05-24"); // yyyy-MM-dd
        String status = "Now";
//        jb.insertJobPosts(recruiter_id, jobPosition, title, location, jobType, salaryMin, salaryMax, experienceLevel, description, requirements, benefits, deadline, status);
//        jb.deleteJobPosts("4");
//        List<JobPost> list = jb.selectAllJobPost();
//        for (JobPost jobPost : list) {
//            System.out.println(jobPost.toString());
//        }

//        jb.updateJobPosts("2", "BA", "AI", "Hà Nội", "Part-time", new BigDecimal("200000.00"), new BigDecimal("800000.00"), "Junior", "Việc nhẹ", "Spring Boot", "Nghỉ hè", Date.valueOf("2025-08-30"), "Active", "6");
// Ví dụ lọc: vị trí "Software Developer", ở "Hanoi", trạng thái "Active", sắp xếp theo lương tăng dần
//        List<JobPost> list = jb.filterJobPost(null, null, null, "salary_asc", "T");
//         List<JobPost> list = jb.locationAllJobPost();
//        List<JobPost> list = jb.SearchJobPostByJobSeeker("", "Full-time", "", "Hà Nội");
//        List<JobPost> list = jb.filterJobPost("1", "Developer", "Hà Nội", "Close", null, "Test");
//        for (JobPost jobPost : list) {
//            System.out.println(jobPost.toString());
//        }
//        int total = jb.totalJobsJobPostsRecruiterActive("1");
//        System.out.println(total);
//        jb.insertJobPosts("1", "Backend", "Tuyen dung", "Hồ Chí Minh", "Contract", null, null, null, "Test", null, null, deadline, status);
//            JobPost list = jb.searchJobPostbyJobID(1); 1 DONE
//        List<JobPost> list = jb.selectAllJobPostRecruiter("1");
//        for (JobPost jobPost : list) {
//            System.out.println(jobPost.toString());
//        }
//        List<JobPost> list = jb.filterJobPostAdvanced("2", "", null, null, Arrays.asList("Bán thời gian", "Tự do"), Arrays.asList("1", "2"), null, "date_desc");
//        List<JobPost> list = jb.searchAllJobPost("Nhân", "2");
//        List<JobPost> list = jb.filterJobPostAdvancedAdmin(null, null, Arrays.asList("Đã từ chối"), Arrays.asList("Bán thời gian", "Toàn thời gian", "Thực tập"), Arrays.asList("Nhân viên sơ cấp (1-3 năm)", "Trung cấp (3-5 năm)", "Mới vào nghề (0-1 năm)"), Arrays.asList("1", "8"), "salary_asc", null);
////        List<JobPost> list = jb.filterJobPostAdvancedSearch("2", null, null, null, null, null, null, null, "Nhân, Chuyên");
//        for (JobPost jobPost : list) {
//            System.out.println(jobPost.toString());
//        }
//        jb.deleteJobPosts("1");
        boolean test = jb.subtractServiceCredit("1", "Standard");
    }

    public List<String> getAllJobType() {
        List<String> jobTypes = new ArrayList<>();
        String sql = "SELECT DISTINCT job_type FROM job_post";

        try (PreparedStatement statement = c.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                jobTypes.add(resultSet.getString("job_type"));
            }
        } catch (Exception e) {
            e.printStackTrace();  // or better, log the error
        }

        return jobTypes;
    }

    public List<JobPost> getAllFilteredAvailableJob(String recId, String jobName, String industry, String type, int min, int max, LocalDate fromDate, LocalDate toDate, int page, int pageSize) {
        List<JobPost> list = new ArrayList<>();
        RecruiterDAO r = new RecruiterDAO();
        IndustryDAO i = new IndustryDAO();
        StringBuilder sql = new StringBuilder("""
                                              SELECT j.*
                                              FROM job_post j
                                              JOIN industry i ON j.industry_id = i.industry_id
                                              LEFT JOIN job_advertisement ja ON ja.job_id = j.job_id
                                              WHERE j.recruiter_id = ?
                                                AND j.status = N'Đã duyệt'
                                                AND j.deadline > GETDATE()
                                                AND (
                                                    ja.ad_id IS NULL
                                                    OR ja.end_date < GETDATE()
                                                )""");
        if (jobName != null && !jobName.isEmpty()) {
            sql.append("and j.title like ? ");
        }
        if (industry != null && !industry.isEmpty()) {
            sql.append("and i.name = ? ");
        }
        if (type != null && !type.isEmpty()) {
            sql.append("and j.job_type = ? ");
        }
        sql.append("and j.salary_min >= ? ");
        sql.append("and j.salary_max <= ? ");
        if (fromDate != null) {
            sql.append("and j.deadline >= ? ");
        }
        if (toDate != null) {
            sql.append("and j.deadline <= ? ");
        }
        sql.append("ORDER BY j.deadline DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try {
            PreparedStatement st = c.prepareStatement(sql.toString());
            int paramIndex = 1;
            st.setString(paramIndex++, recId);
            if (jobName != null && !jobName.isEmpty()) {
                st.setString(paramIndex++, "%" + jobName + "%");
            }
            if (industry != null && !industry.isEmpty()) {
                st.setString(paramIndex++, industry);
            }
            if (type != null && !type.isEmpty()) {
                st.setString(paramIndex++, type);
            }
            st.setInt(paramIndex++, min);
            st.setInt(paramIndex++, max);
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
                JobPost jobPost = new JobPost(
                        rs.getInt("job_id"),
                        rs.getInt("recruiter_id"),
                        rs.getInt("industry_id"),
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
                        rs.getString("status"),
                        r.getRecruiterById(rs.getInt("recruiter_id")), i.industryById(rs.getInt("industry_id"))
                );
                list.add(jobPost);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // or better, log the error
        }
        return list;
    }

    public int countFilteredAvailableJobs(String recId, String jobName, String industry, String type, int min, int max, LocalDate fromDate, LocalDate toDate) {
        int total = 0;
        StringBuilder sql = new StringBuilder("""
                                              SELECT COUNT(*) AS total FROM job_post j
                                              JOIN industry i ON j.industry_id = i.industry_id
                                              LEFT JOIN job_advertisement ja ON ja.job_id = j.job_id
                                              WHERE j.recruiter_id = ?
                                              AND j.status = N'Đã duyệt'
                                              AND j.deadline > GETDATE()
                                              AND (
                                                   ja.ad_id IS NULL
                                                   OR ja.end_date < GETDATE()
                                              )""");

        if (jobName != null && !jobName.isEmpty()) {
            sql.append("AND j.title LIKE ? ");
        }
        if (industry != null && !industry.isEmpty()) {
            sql.append("AND i.name = ? ");
        }
        if (type != null && !type.isEmpty()) {
            sql.append("AND j.job_type = ? ");
        }
        sql.append("and j.salary_min >= ? ");
        sql.append("and j.salary_max <= ? ");
        if (fromDate != null) {
            sql.append("AND j.deadline >= ? ");
        }
        if (toDate != null) {
            sql.append("AND j.deadline <= ? ");
        }

        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            st.setString(paramIndex++, recId);
            if (jobName != null && !jobName.isEmpty()) {
                st.setString(paramIndex++, "%" + jobName + "%");
            }
            if (industry != null && !industry.isEmpty()) {
                st.setString(paramIndex++, industry);
            }
            if (type != null && !type.isEmpty()) {
                st.setString(paramIndex++, type);
            }
            st.setInt(paramIndex++, min);
            st.setInt(paramIndex++, max);
            if (fromDate != null) {
                st.setDate(paramIndex++, java.sql.Date.valueOf(fromDate));
            }
            if (toDate != null) {
                st.setDate(paramIndex++, java.sql.Date.valueOf(toDate));
            }

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Consider replacing with proper logging
        }

        return total;
    }

    public List<Recruiter> selectAllCompanyLogo() {
        List<Recruiter> list = new ArrayList<>();
        String sql = "SELECT r.company_logo_url, r.company_name, r.company_address "
                + "FROM job_post jp "
                + "JOIN recruiter r ON jp.recruiter_id = r.recruiter_id "
                + "WHERE jp.status = N'Đã duyệt' "
                + "ORDER BY jp.created_at DESC";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter(
                        rs.getString("company_logo_url"),
                        rs.getString("company_name"),
                        rs.getString("company_address")
                );
                list.add(recruiter);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
