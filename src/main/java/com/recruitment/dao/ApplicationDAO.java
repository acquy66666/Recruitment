/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.dto.JobPostWithApplicationsDTO;
import com.recruitment.model.Application;
import com.recruitment.model.ApplicationScheduleDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author GBCenter
 */
public class ApplicationDAO extends DBcontext {

    public List<Application> checkApplyByJobId(int id1, int id2) {
        List<Application> list = new ArrayList<>();
        String sql = "select * from application where job_id=? and candidate_id=? and status in ('Pending', 'Interview', 'Testing', 'Accepted')";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id1);
            st.setInt(2, id2);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Application a = new Application(
                        rs.getInt("application_id"),
                        rs.getInt("candidate_id"),
                        rs.getInt("cv_id"),
                        rs.getInt("job_id"),
                        rs.getString("cover_letter"),
                        rs.getString("applied_at"),
                        rs.getString("status")
                );
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
        }
        return list;
    }

    public List<Application> checkApplyByJobId2(int id1, int id2) {
        List<Application> list = new ArrayList<>();
        String sql = "select a.application_id, a.candidate_id, a.cv_id, a.job_id, a.cover_letter, a.applied_at, a.status from application a where job_id=? and candidate_id=?";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id1);
            st.setInt(2, id2);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Application a = new Application(
                        rs.getInt("application_id"),
                        rs.getInt("candidate_id"),
                        rs.getInt("cv_id"),
                        rs.getInt("job_id"),
                        rs.getString("cover_letter"),
                        rs.getString("applied_at"),
                        rs.getString("status")
                );
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
        }
        return list;
    }

    public void updateStatus(int applicationId, String status) throws SQLException {
        String sql = "UPDATE application SET status = ? WHERE application_id = ?";
        PreparedStatement stmt = c.prepareStatement(sql);
        stmt.setString(1, status);
        stmt.setInt(2, applicationId);
        stmt.executeUpdate();
    }

    public void addApplication(int candidateId, int cvId, int jobId, String coverLetter) {
        String sql = """
                   insert into [dbo].[application] (candidate_id, cv_id, job_id, cover_letter, applied_at, interview_time
                   ,interview_description, status)
                   values (?,?,?,?,GETDATE(), NULL, NULL, 'Pending')""";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, candidateId);
            st.setInt(2, cvId);
            st.setInt(3, jobId);
            st.setString(4, coverLetter);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
        }
    }

    public void removeApplication(int candidateId, int jobId) {
        String sql = """
                     DELETE FROM [dbo].[application]
                           WHERE candidate_id= ? and job_id= ?""";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, candidateId);
            st.setInt(2, jobId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
        }
    }

    public List<Application> getApplicationsByCandidateAndRecruiter(int candidateId, Integer recruiterId) {
        List<Application> applications = new ArrayList<>();
        String sql = """
            SELECT a.*, j.title as job_title, j.job_position, c.full_name as candidate_name,
               cv.title as cv_title, cv.cv_url
            FROM [application] a
            INNER JOIN [job_post] j ON a.job_id = j.job_id
            INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id
            INNER JOIN [cv] cv ON a.cv_id = cv.cv_id
            WHERE a.candidate_id = ? AND j.recruiter_id = ?
            ORDER BY a.applied_at DESC
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            ps.setInt(2, recruiterId.intValue());

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setCandidateId(rs.getInt("candidate_id"));
                app.setCvId(rs.getInt("cv_id"));
                app.setJobId(rs.getInt("job_id"));
                app.setCoverLetter(rs.getString("cover_letter"));
                app.setAppliedAt(rs.getString("applied_at"));
                app.setStatus(rs.getString("status"));
                applications.add(app);
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
        }
        return applications;
    }

    // Get all applicants for a recruiter with pagination
    public List<Map<String, Object>> getAllApplicantsByRecruiter(int recruiterId, int page, int pageSize) {
        List<Map<String, Object>> applicants = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = """
            SELECT 
                a.application_id,
                a.applied_at,
                a.status,
                a.cover_letter,
                c.candidate_id,
                ISNULL(c.full_name, 'Unknown User') as full_name,
                ISNULL(c.email, '') as email,
                ISNULL(c.phone, 'N/A') as phone,
                ISNULL(c.address, 'N/A') as address,
                ISNULL(c.image_url, '') as image_url,
                ISNULL(c.gender, 'Other') as gender,
                c.birthdate,
                ISNULL(cv.cv_id, 0) as cv_id,
                ISNULL(cv.title, 'No CV') as cv_title,
                jp.job_id,
                jp.title as job_title,
                jp.job_position,
                jp.location,
                jp.job_type,
                jp.experience_level
            FROM [application] a
            INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
            LEFT JOIN [cv] cv ON a.cv_id = cv.cv_id
            INNER JOIN [job_post] jp ON a.job_id = jp.job_id
            WHERE jp.recruiter_id = ?
            ORDER BY a.applied_at DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, recruiterId);
            st.setInt(2, offset);
            st.setInt(3, pageSize);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Map<String, Object> applicant = new HashMap<>();
                applicant.put("applicationId", rs.getInt("application_id"));
                applicant.put("candidateId", rs.getInt("candidate_id"));
                applicant.put("fullName", rs.getString("full_name"));
                applicant.put("email", rs.getString("email"));
                applicant.put("phone", rs.getString("phone"));
                applicant.put("address", rs.getString("address"));
                applicant.put("imageUrl", rs.getString("image_url"));
                applicant.put("gender", rs.getString("gender"));
                applicant.put("birthdate", rs.getDate("birthdate"));
                applicant.put("appliedAt", rs.getTimestamp("applied_at"));
                applicant.put("status", rs.getString("status"));
                applicant.put("coverLetter", rs.getString("cover_letter"));
                applicant.put("cvId", rs.getInt("cv_id"));
                applicant.put("cvTitle", rs.getString("cv_title"));
                applicant.put("jobId", rs.getInt("job_id"));
                applicant.put("jobTitle", rs.getString("job_title"));
                applicant.put("jobPosition", rs.getString("job_position"));
                applicant.put("location", rs.getString("location"));
                applicant.put("jobType", rs.getString("job_type"));
                applicant.put("experienceLevel", rs.getString("experience_level"));

                applicants.add(applicant);

                System.out.println("Found applicant: " + rs.getString("full_name") + " (ID: " + rs.getInt("candidate_id") + ")");
            }
            System.out.println("Total applicants found: " + applicants.size());
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
            e.printStackTrace();
        }

        return applicants;
    }

    public List<Map<String, Object>> getFilteredApplicants(int recruiterId, String jobPosition,
            String status, String experience, String dateFrom, String dateTo, int page, int pageSize) {
        return getFilteredApplicantsWithSearch(recruiterId, jobPosition, status, experience,
                dateFrom, dateTo, null, page, pageSize);
    }

    public List<Map<String, Object>> getFilteredApplicantsWithSearch(int recruiterId, String jobPosition,
            String status, String experience, String dateFrom, String dateTo, String search, int page, int pageSize) {
        List<Map<String, Object>> applicants = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("""
            SELECT 
                a.application_id,
                a.applied_at,
                a.status,
                a.cover_letter,
                c.candidate_id,
                ISNULL(c.full_name, 'Unknown User') as full_name,
                ISNULL(c.email, '') as email,
                ISNULL(c.phone, 'N/A') as phone,
                ISNULL(c.address, 'N/A') as address,
                ISNULL(c.image_url, '') as image_url,
                ISNULL(cv.cv_id, 0) as cv_id,
                ISNULL(cv.title, 'No CV') as cv_title,
                jp.job_id,
                jp.title as job_title,
                jp.job_position,
                jp.location,
                jp.job_type,
                jp.experience_level
            FROM [application] a
            INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
            LEFT JOIN [cv] cv ON a.cv_id = cv.cv_id
            INNER JOIN [job_post] jp ON a.job_id = jp.job_id
            WHERE jp.recruiter_id = ?
        """);

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        // Add filters
        if (jobPosition != null && !jobPosition.trim().isEmpty()) {
            sql.append(" AND jp.job_position = ?");
            params.add(jobPosition);
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND a.status = ?");
            params.add(status);
        }
        if (experience != null && !experience.trim().isEmpty()) {
            sql.append(" AND jp.experience_level = ?");
            params.add(experience);
        }
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND a.applied_at >= ?");
            params.add(dateFrom);
        }
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND a.applied_at <= ?");
            params.add(dateTo + " 23:59:59");
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND ISNULL(c.full_name, '') LIKE ?");
            String searchPattern = "%" + search.trim() + "%";
            params.add(searchPattern);
        }

        sql.append(" ORDER BY a.applied_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        System.out.println("=== Search Query Debug ===");
        System.out.println("SQL: " + sql.toString());
        System.out.println("Search parameter: " + search);
        System.out.println("Total parameters: " + params.size());

        try {
            PreparedStatement st = c.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
                System.out.println("Param " + (i + 1) + ": " + params.get(i));
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Map<String, Object> applicant = new HashMap<>();
                applicant.put("applicationId", rs.getInt("application_id"));
                applicant.put("candidateId", rs.getInt("candidate_id"));
                applicant.put("fullName", rs.getString("full_name"));
                applicant.put("email", rs.getString("email"));
                applicant.put("phone", rs.getString("phone"));
                applicant.put("address", rs.getString("address"));
                applicant.put("imageUrl", rs.getString("image_url"));
                applicant.put("appliedAt", rs.getTimestamp("applied_at"));
                applicant.put("status", rs.getString("status"));
                applicant.put("coverLetter", rs.getString("cover_letter"));
                applicant.put("cvId", rs.getInt("cv_id"));
                applicant.put("cvTitle", rs.getString("cv_title"));
                applicant.put("jobId", rs.getInt("job_id"));
                applicant.put("jobTitle", rs.getString("job_title"));
                applicant.put("jobPosition", rs.getString("job_position"));
                applicant.put("location", rs.getString("location"));
                applicant.put("jobType", rs.getString("job_type"));
                applicant.put("experienceLevel", rs.getString("experience_level"));
                applicants.add(applicant);

                System.out.println("Found filtered applicant: " + rs.getString("full_name"));
            }
            System.out.println("Found " + applicants.size() + " results");
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
            e.printStackTrace();
        }
        return applicants;
    }

    public int getTotalApplicantsCount(int recruiterId) {
        String sql = """
            SELECT COUNT(*) as total
            FROM [application] a
            INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
            INNER JOIN [job_post] jp ON a.job_id = jp.job_id
            WHERE jp.recruiter_id = ?
        """;

        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, recruiterId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                int total = rs.getInt("total");
                System.out.println("Total applicants count: " + total);
                return total;
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    public int getFilteredApplicantsCount(int recruiterId, String jobPosition,
            String status, String experience, String dateFrom, String dateTo) {
        return getFilteredApplicantsCountWithSearch(recruiterId, jobPosition, status,
                experience, dateFrom, dateTo, null);
    }

    public int getFilteredApplicantsCountWithSearch(int recruiterId, String jobPosition,
            String status, String experience, String dateFrom, String dateTo, String search) {
        StringBuilder sql = new StringBuilder("""
            SELECT COUNT(*) as total
            FROM [application] a
            INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
            INNER JOIN [job_post] jp ON a.job_id = jp.job_id
            WHERE jp.recruiter_id = ?
        """);

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        // Add same filters as getFilteredApplicantsWithSearch
        if (jobPosition != null && !jobPosition.trim().isEmpty()) {
            sql.append(" AND jp.job_position = ?");
            params.add(jobPosition);
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND a.status = ?");
            params.add(status);
        }
        if (experience != null && !experience.trim().isEmpty()) {
            sql.append(" AND jp.experience_level = ?");
            params.add(experience);
        }
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND a.applied_at >= ?");
            params.add(dateFrom);
        }
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND a.applied_at <= ?");
            params.add(dateTo + " 23:59:59");
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND ISNULL(c.full_name, '') LIKE ?");
            String searchPattern = "%" + search.trim() + "%";
            params.add(searchPattern);
        }

        System.out.println("=== getFilteredApplicantsCountWithSearch Debug ===");
        System.out.println("SQL: " + sql.toString());

        try {
            PreparedStatement st = c.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("total");
                System.out.println("Filtered count: " + count);
                return count;
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // Get applicant statistics
    public Map<String, Object> getApplicantStats(int recruiterId) {
        Map<String, Object> stats = new HashMap<>();

        String sql = """
            SELECT 
                COUNT(*) as total_applications,
                COUNT(CASE WHEN a.status = 'Pending' THEN 1 END) as pending_count,
                COUNT(CASE WHEN a.status = 'Reviewing' THEN 1 END) as reviewing_count,
                COUNT(CASE WHEN a.status = 'Interview' THEN 1 END) as interview_count,
                COUNT(CASE WHEN a.status = 'Accepted' THEN 1 END) as accepted_count,
                COUNT(CASE WHEN a.status = 'Rejected' THEN 1 END) as rejected_count
            FROM [application] a
            INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
            INNER JOIN [job_post] jp ON a.job_id = jp.job_id
            WHERE jp.recruiter_id = ?
        """;

        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, recruiterId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                stats.put("totalApplications", rs.getInt("total_applications"));
                stats.put("pendingCount", rs.getInt("pending_count"));
                stats.put("reviewingCount", rs.getInt("reviewing_count"));
                stats.put("interviewCount", rs.getInt("interview_count"));
                stats.put("acceptedCount", rs.getInt("accepted_count"));
                stats.put("rejectedCount", rs.getInt("rejected_count"));

                System.out.println("Stats - Total: " + rs.getInt("total_applications"));
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
            e.printStackTrace();
        }

        return stats;
    }

    // Update application status with reason
    public boolean updateApplicationStatus(int applicationId, int recruiterId, String status, String reason) {
        // First verify that this application belongs to this recruiter
        String verifySql = """
            SELECT COUNT(*) as count
            FROM [application] a
            INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
            INNER JOIN [job_post] jp ON a.job_id = jp.job_id
            WHERE a.application_id = ? AND jp.recruiter_id = ?
        """;

        try {
            // Verify ownership
            PreparedStatement verifyPs = c.prepareStatement(verifySql);
            verifyPs.setInt(1, applicationId);
            verifyPs.setInt(2, recruiterId);
            ResultSet rs = verifyPs.executeQuery();
            if (rs.next() && rs.getInt("count") == 0) {
                return false; // Application doesn't belong to this recruiter
            }

            // Update status
            String updateSql = "UPDATE [application] SET status = ? WHERE application_id = ?";
            PreparedStatement updatePs = c.prepareStatement(updateSql);
            updatePs.setString(1, status);
            updatePs.setInt(2, applicationId);

            int rowsAffected = updatePs.executeUpdate();

            // Log the reason if provided
            if (reason != null && !reason.trim().isEmpty() && rowsAffected > 0) {
                System.out.println("Application " + applicationId + " status changed to " + status + ". Reason: " + reason);
            }

            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
            return false;
        }
    }

    // Get applicant detail
    public Map<String, Object> getApplicantDetail(int applicationId, int recruiterId) {
        String sql = """
            SELECT 
                a.application_id,
                a.applied_at,
                a.status,
                a.cover_letter,
                c.candidate_id,
                ISNULL(c.full_name, 'Unknown User') as full_name,
                ISNULL(c.email, '') as email,
                ISNULL(c.phone, 'N/A') as phone,
                ISNULL(c.address, 'N/A') as address,
                ISNULL(c.image_url, '') as image_url,
                ISNULL(c.gender, 'Other') as gender,
                c.birthdate,
                ISNULL(cv.cv_id, 0) as cv_id,
                ISNULL(cv.title, 'No CV') as cv_title,
                jp.job_id,
                jp.title as job_title,
                jp.job_position,
                jp.location,
                jp.job_type,
                jp.experience_level,
                jp.description as job_description,
                jp.requirement as job_requirement
            FROM [application] a
            INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
            LEFT JOIN [cv] cv ON a.cv_id = cv.cv_id
            INNER JOIN [job_post] jp ON a.job_id = jp.job_id
            WHERE a.application_id = ? AND jp.recruiter_id = ?
        """;

        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, applicationId);
            st.setInt(2, recruiterId);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Map<String, Object> applicant = new HashMap<>();
                applicant.put("applicationId", rs.getInt("application_id"));
                applicant.put("appliedAt", rs.getTimestamp("applied_at"));
                applicant.put("status", rs.getString("status"));
                applicant.put("coverLetter", rs.getString("cover_letter"));
                applicant.put("candidateId", rs.getInt("candidate_id"));
                applicant.put("fullName", rs.getString("full_name"));
                applicant.put("email", rs.getString("email"));
                applicant.put("phone", rs.getString("phone"));
                applicant.put("address", rs.getString("address"));
                applicant.put("imageUrl", rs.getString("image_url"));
                applicant.put("gender", rs.getString("gender"));
                applicant.put("birthdate", rs.getDate("birthdate"));
                applicant.put("cvId", rs.getInt("cv_id"));
                applicant.put("cvTitle", rs.getString("cv_title"));
                applicant.put("jobId", rs.getInt("job_id"));
                applicant.put("jobTitle", rs.getString("job_title"));
                applicant.put("jobPosition", rs.getString("job_position"));
                applicant.put("location", rs.getString("location"));
                applicant.put("jobType", rs.getString("job_type"));
                applicant.put("experienceLevel", rs.getString("experience_level"));
                applicant.put("jobDescription", rs.getString("job_description"));
                applicant.put("jobRequirement", rs.getString("job_requirement"));
                return applicant;
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Get job positions for filter dropdown
    // Get job positions for filter dropdown
    public List<String> getJobPositions(int recruiterId) {
        List<String> positions = new ArrayList<>();
        String sql = """
            SELECT DISTINCT jp.job_position
            FROM [job_post] jp
            INNER JOIN [application] a ON jp.job_id = a.job_id
            INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
            WHERE jp.recruiter_id = ?
            ORDER BY jp.job_position
        """;

        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, recruiterId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                positions.add(rs.getString("job_position"));
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
        }

        return positions;
    }

    public List<Map<String, Object>> getJobsWithApplications(int recruiterId) {
        List<Map<String, Object>> jobs = new ArrayList<>();

        String sql = """
            SELECT 
                jp.job_id,
                jp.title,
                jp.job_position,
                jp.location,
                jp.job_type,
                jp.created_at,
                jp.deadline,
                COUNT(a.application_id) as application_count,
                COUNT(CASE WHEN a.status = 'Pending' THEN 1 END) as pending_count,
                COUNT(CASE WHEN a.status = 'Reviewing' THEN 1 END) as reviewing_count,
                COUNT(CASE WHEN a.status = 'Interview' THEN 1 END) as interview_count,
                COUNT(CASE WHEN a.status = 'Accepted' THEN 1 END) as accepted_count,
                COUNT(CASE WHEN a.status = 'Rejected' THEN 1 END) as rejected_count
            FROM [job_post] jp
            LEFT JOIN [application] a ON jp.job_id = a.job_id
            LEFT JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
            WHERE jp.recruiter_id = ?
            GROUP BY jp.job_id, jp.title, jp.job_position, jp.location, jp.job_type, jp.created_at, jp.deadline
            HAVING COUNT(a.application_id) > 0
            ORDER BY jp.created_at DESC
        """;

        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, recruiterId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Map<String, Object> job = new HashMap<>();
                job.put("jobId", rs.getInt("job_id"));
                job.put("title", rs.getString("title"));
                job.put("job_position", rs.getString("job_position"));
                job.put("location", rs.getString("location"));
                job.put("jobType", rs.getString("job_type"));
                job.put("createdAt", rs.getTimestamp("created_at"));
                job.put("deadline", rs.getTimestamp("deadline"));
                job.put("applicationCount", rs.getInt("application_count"));
                job.put("pendingCount", rs.getInt("pending_count"));
                job.put("reviewingCount", rs.getInt("reviewing_count"));
                job.put("interviewCount", rs.getInt("interview_count"));
                job.put("acceptedCount", rs.getInt("accepted_count"));
                job.put("rejectedCount", rs.getInt("rejected_count"));

                jobs.add(job);
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi: " + e.getMessage());
        }

        return jobs;
    }

    public static void main(String[] args) {
        ApplicationDAO a = new ApplicationDAO();
        List<Application> list = a.checkApplyByJobId(1, 1);
        System.out.println(list.size());
    }

    public Application getApplicationById(int applicationId) throws SQLException {
        String sql = "SELECT * FROM application WHERE application_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, applicationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToApplication(rs);
                }
            }
        }
        return null;
    }

    public int createApplication(Application application) throws SQLException {
        c.setAutoCommit(false);
        try {
            String sql = "INSERT INTO application (candidate_id, cv_id, job_id, cover_letter, applied_at, status) VALUES (?, ?, ?, ?, GETDATE(), 'Pending')";

            try (PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, application.getCandidateId());
                ps.setInt(2, application.getCvId());
                ps.setInt(3, application.getJobId());
                ps.setString(4, application.getCoverLetter());

                int affectedRows = ps.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Creating application failed, no rows affected.");
                }

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int applicationId = rs.getInt(1);
                        c.commit();
                        return applicationId;
                    }
                }
            }
        } catch (SQLException e) {
            c.rollback();
            throw e;
        } finally {
            c.setAutoCommit(true);
        }
        return -1;
    }

    public List<Map<String, Object>> getApplicationsForInterview(int recruiterId) throws SQLException {
        List<Map<String, Object>> applications = new ArrayList<>();
        String sql = """
            SELECT DISTINCT
                a.application_id,
                a.candidate_id,
                a.job_id,
                a.status,
                a.applied_at,
                COALESCE(c.full_name, c.email, 'Ứng viên không xác định') as full_name,
                c.email as candidate_email,
                c.image_url as image_url,
                j.job_position as job_title,
                j.company_name,
                r.full_name as recruiter_name
            FROM application a
            INNER JOIN candidate c ON a.candidate_id = c.candidate_id
            INNER JOIN job_post j ON a.job_id = j.job_id
            INNER JOIN recruiter r ON j.recruiter_id = r.recruiter_id
            WHERE j.recruiter_id = ? 
            AND a.status IN ('Pending', 'Reviewing')
            AND c.isActive = 1
            ORDER BY a.applied_at DESC
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> application = new HashMap<>();
                    application.put("applicationId", rs.getInt("application_id"));
                    application.put("candidateId", rs.getInt("candidate_id"));
                    application.put("jobId", rs.getInt("job_id"));
                    application.put("status", rs.getString("status"));
                    application.put("appliedAt", rs.getTimestamp("applied_at"));
                    application.put("fullName", rs.getString("full_name"));
                    application.put("candidateEmail", rs.getString("candidate_email"));
                    application.put("imageUrl", rs.getString("image_url"));
                    application.put("jobTitle", rs.getString("job_title"));
                    application.put("companyName", rs.getString("company_name"));
                    application.put("recruiterName", rs.getString("recruiter_name"));

                    applications.add(application);
                }
            }
        }

        return applications;
    }

    private Application mapResultSetToApplication(ResultSet rs) throws SQLException {
        Application application = new Application();
        application.setApplicationId(rs.getInt("application_id"));
        application.setCandidateId(rs.getInt("candidate_id"));
        application.setCvId(rs.getInt("cv_id"));
        application.setJobId(rs.getInt("job_id"));
        application.setCoverLetter(rs.getString("cover_letter"));
        application.setAppliedAt(rs.getString("applied_at"));
        application.setStatus(rs.getString("status"));
        return application;
    }

//    public void updateMeetingTokens(String applicationId, String candidateToken, String recruiterToken) {
//        String sql = "UPDATE application SET candidate_token = ?, recruiter_token = ? WHERE application_id = ?";
//        try (PreparedStatement ps = c.prepareStatement(sql)) {
//
//            ps.setString(1, candidateToken);
//            ps.setString(2, recruiterToken);
//            ps.setString(3, applicationId);
//
//            ps.executeUpdate(); // không cần trả về
//        } catch (SQLException e) {
//            e.printStackTrace(); // hoặc log lỗi theo logger nếu bạn có
//        }
//    }
    public List<ApplicationScheduleDTO> getScheduledInterviewsByRecruiterId(int recruiterId) {
        List<ApplicationScheduleDTO> list = new ArrayList<>();

        String sql = """
                SELECT 
                    a.application_id,
                    c.full_name AS candidate_name,
                    c.email AS candidate_email,
                    j.title AS job_title,
                    i.interview_time,
                    i.description AS interview_description,
                    a.status
                FROM Interview i
                JOIN application a ON i.application_id = a.application_id
                JOIN candidate c ON a.candidate_id = c.candidate_id
                JOIN job_post j ON a.job_id = j.job_id
                WHERE i.interview_time IS NOT NULL
                  AND i.recruiter_id = ?
                ORDER BY i.interview_time ASC
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, recruiterId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ApplicationScheduleDTO is = new ApplicationScheduleDTO();
                    is.setApplicationId(rs.getInt("application_id"));
                    is.setCandidateName(rs.getString("candidate_name"));
                    is.setCandidateEmail(rs.getString("candidate_email"));
                    is.setJobTitle(rs.getString("job_title"));
                    is.setInterviewTime(rs.getTimestamp("interview_time"));
                    is.setInterviewDescription(rs.getString("interview_description"));
                    is.setStatus(rs.getString("status"));
                    list.add(is);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public ApplicationScheduleDTO getInterviewDetailByApplicationId(int applicationId) {
        String sql = """
        SELECT 
            a.application_id,
            c.full_name AS candidate_name,
            c.email AS candidate_email,
            j.title AS job_title,
            a.interview_time,
            a.interview_description,
            a.status
        FROM application a
        JOIN candidate c ON a.candidate_id = c.candidate_id
        JOIN job_post j ON a.job_id = j.job_id
        WHERE a.application_id = ?
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, applicationId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ApplicationScheduleDTO i = new ApplicationScheduleDTO();
                i.setApplicationId(rs.getInt("application_id"));
                i.setCandidateName(rs.getString("candidate_name"));
                i.setCandidateEmail(rs.getString("candidate_email"));
                i.setJobTitle(rs.getString("job_title"));
                i.setInterviewTime(rs.getTimestamp("interview_time"));
                i.setInterviewDescription(rs.getString("interview_description"));
                i.setStatus(rs.getString("status"));
                return i;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public int countApplicationsByCandidateId(int candidateId) {
        String sql = "SELECT COUNT(*) FROM application WHERE candidate_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<ApplicationScheduleDTO> getInterviewsByCandidateId(int candidateId) {
        List<ApplicationScheduleDTO> list = new ArrayList<>();
        String sql = """
        SELECT 
            a.application_id,
            r.company_name AS company_name,
            r.email AS recruiter_email,
            j.title AS job_title,
            i.interview_time,
            i.description AS interview_description,
            a.status
        FROM Interview i
        JOIN application a ON i.application_id = a.application_id
        JOIN job_post j ON a.job_id = j.job_id
        JOIN recruiter r ON j.recruiter_id = r.recruiter_id
        WHERE i.interview_time IS NOT NULL
          AND i.candidate_id = ?
        ORDER BY i.interview_time ASC;
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ApplicationScheduleDTO dto = new ApplicationScheduleDTO();
                dto.setApplicationId(rs.getInt("application_id"));
                dto.setRecruiterName(rs.getString("company_name"));   // thêm thuộc tính này trong DTO
                dto.setRecruiterEmail(rs.getString("recruiter_email")); // thêm thuộc tính này trong DTO
                dto.setJobTitle(rs.getString("job_title"));
                dto.setInterviewTime(rs.getTimestamp("interview_time"));
                dto.setInterviewDescription(rs.getString("interview_description"));
                dto.setStatus(rs.getString("status"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

// Fix the SQL Server pagination syntax in your existing methods
    public List<JobPostWithApplicationsDTO> getJobPostsWithApplications(int recruiterId, String jobTitle,
            String status, Integer minApplications, int offset, int limit) {
        List<JobPostWithApplicationsDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT jp.job_id, jp.title, jp.location, jp.status, jp.created_at, jp.deadline, ");
        sql.append("r.company_name, "); // Add company name from recruiter table
        sql.append("COUNT(a.application_id) as total_applications, ");
        sql.append("SUM(CASE WHEN a.status = 'Pending' THEN 1 ELSE 0 END) as pending_count, ");
        sql.append("SUM(CASE WHEN a.status = 'Accepted' THEN 1 ELSE 0 END) as accepted_count, ");
        sql.append("SUM(CASE WHEN a.status = 'Rejected' THEN 1 ELSE 0 END) as rejected_count ");
        sql.append("FROM job_post jp ");
        sql.append("LEFT JOIN application a ON jp.job_id = a.job_id ");
        sql.append("LEFT JOIN recruiter r ON jp.recruiter_id = r.recruiter_id "); // Join with recruiter table
        sql.append("WHERE jp.recruiter_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        if (jobTitle != null && !jobTitle.trim().isEmpty()) {
            sql.append("AND jp.title LIKE ? ");
            params.add("%" + jobTitle + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND jp.status = ? ");
            params.add(status);
        }

        sql.append("GROUP BY jp.job_id, jp.title, jp.location, jp.status, jp.created_at, jp.deadline, r.company_name ");
        sql.append("HAVING COUNT(a.application_id) > 0 ");

        if (minApplications != null && minApplications > 0) {
            sql.append("AND COUNT(a.application_id) >= ? ");
            params.add(minApplications);
        }

        sql.append("ORDER BY jp.created_at DESC ");
        // SQL Server pagination syntax
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                JobPostWithApplicationsDTO job = new JobPostWithApplicationsDTO();
                job.setJobId(rs.getInt("job_id"));
                job.setJobTitle(rs.getString("title"));
                job.setCompanyName(rs.getString("company_name")); // Now gets actual company name
                job.setLocation(rs.getString("location"));
                job.setStatus(rs.getString("status"));
                job.setPostedDate(rs.getDate("created_at"));
                job.setDeadline(rs.getDate("deadline"));
                job.setTotalApplications(rs.getInt("total_applications"));
                job.setPendingCount(rs.getInt("pending_count"));
                job.setAcceptedCount(rs.getInt("accepted_count"));
                job.setRejectedCount(rs.getInt("rejected_count"));
                list.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Replace your existing countJobPostsWithApplications method with this corrected version
    public int countJobPostsWithApplications(int recruiterId, String jobTitle, String status, Integer minApplications) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM ( ");
        sql.append("    SELECT DISTINCT jp.job_id ");
        sql.append("    FROM job_post jp ");
        sql.append("    LEFT JOIN application a ON jp.job_id = a.job_id ");
        sql.append("    WHERE jp.recruiter_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        if (jobTitle != null && !jobTitle.trim().isEmpty()) {
            sql.append("    AND jp.title LIKE ? ");
            params.add("%" + jobTitle + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("    AND jp.status = ? ");
            params.add(status);
        }

        sql.append("    GROUP BY jp.job_id ");
        sql.append("    HAVING COUNT(a.application_id) > 0 ");

        if (minApplications != null && minApplications > 0) {
            sql.append("    AND COUNT(a.application_id) >= ? ");
            params.add(minApplications);
        }

        sql.append(") AS job_counts");

        int count = 0;
        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error in countJobPostsWithApplications: " + e.getMessage());
            e.printStackTrace();
        }

        return count;
    }

    // Add these methods to your existing ApplicationDAO class
    public int getTotalJobsByRecruiterId(int recruiterId) {
        String sql = """
        SELECT COUNT(DISTINCT jp.job_id) 
        FROM job_post jp 
        LEFT JOIN Application a ON jp.job_id = a.job_id 
        WHERE jp.recruiter_id = ? 
        AND a.job_id IS NOT NULL
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalJobsByRecruiterId: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    public int getTotalApplicationsByRecruiterId(int recruiterId) {
        String sql = """
        SELECT COUNT(a.application_id) 
        FROM application a 
        INNER JOIN job_post jp ON a.job_id = jp.job_id 
        WHERE jp.recruiter_id = ?
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalApplicationsByRecruiterId: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    public double getAvgApplicationsPerJobByRecruiterId(int recruiterId) {
        String sql = """
        SELECT 
            CASE WHEN COUNT(DISTINCT jp.job_id) > 0 THEN 
                ROUND(CAST(COUNT(a.application_id) AS DECIMAL) / COUNT(DISTINCT jp.job_id), 1) 
            ELSE 0 END as avg_applications
        FROM job_post jp
        LEFT JOIN application a ON jp.job_id = a.job_id
        WHERE jp.recruiter_id = ?
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("avg_applications");
            }
        } catch (SQLException e) {
            System.out.println("Error in getAvgApplicationsPerJobByRecruiterId: " + e.getMessage());
            e.printStackTrace();
        }

        return 0.0;
    }

    // Add these methods to your existing ApplicationDAO class
    public List<Map<String, Object>> getCandidatesByJobId(int jobId, String status, String dateFrom,
            String dateTo, String searchName, int offset, int limit) {
        List<Map<String, Object>> candidates = new ArrayList<>();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT ");
        sql.append("    a.application_id, ");
        sql.append("    a.applied_at, ");
        sql.append("    a.status, ");
        sql.append("    a.cover_letter, ");
        sql.append("    c.candidate_id, ");
        sql.append("    ISNULL(c.full_name, 'Unknown User') as full_name, ");
        sql.append("    ISNULL(c.email, '') as email, ");
        sql.append("    ISNULL(c.phone, 'N/A') as phone, ");
        sql.append("    ISNULL(c.address, 'N/A') as address, ");
        sql.append("    ISNULL(c.image_url, '') as image_url, ");
        sql.append("    ISNULL(c.gender, 'Other') as gender, ");
        sql.append("    c.birthdate, ");
        sql.append("    ISNULL(cv.cv_id, 0) as cv_id, ");
        sql.append("    ISNULL(cv.title, 'No CV') as cv_title ");
        sql.append("FROM [application] a ");
        sql.append("INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1 ");
        sql.append("LEFT JOIN [cv] cv ON a.cv_id = cv.cv_id ");
        sql.append("WHERE a.job_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(jobId);

        // Add filters
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }

        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append("AND a.applied_at >= ? ");
            params.add(dateFrom);
        }

        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append("AND a.applied_at <= ? ");
            params.add(dateTo + " 23:59:59");
        }

        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append("AND ISNULL(c.full_name, '') LIKE ? ");
            params.add("%" + searchName.trim() + "%");
        }

        sql.append("ORDER BY a.applied_at DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> candidate = new HashMap<>();
                candidate.put("applicationId", rs.getInt("application_id"));
                candidate.put("candidateId", rs.getInt("candidate_id"));
                candidate.put("fullName", rs.getString("full_name"));
                candidate.put("email", rs.getString("email"));
                candidate.put("phoneNumber", rs.getString("phone"));
                candidate.put("address", rs.getString("address"));
                candidate.put("imageUrl", rs.getString("image_url"));
                candidate.put("gender", rs.getString("gender"));
                candidate.put("birthdate", rs.getDate("birthdate"));
                candidate.put("appliedAt", rs.getTimestamp("applied_at"));
                candidate.put("status", rs.getString("status"));
                candidate.put("coverLetter", rs.getString("cover_letter"));
                candidate.put("cvId", rs.getInt("cv_id"));
                candidate.put("cvTitle", rs.getString("cv_title"));
                candidate.put("experience", "0"); // Add actual experience calculation if available
                candidates.add(candidate);
            }
        } catch (SQLException e) {
            System.out.println("Error in getCandidatesByJobId: " + e.getMessage());
            e.printStackTrace();
        }

        return candidates;
    }

    public int countCandidatesByJobId(int jobId, String status, String dateFrom, String dateTo, String searchName) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) ");
        sql.append("FROM [application] a ");
        sql.append("INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1 ");
        sql.append("WHERE a.job_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(jobId);

        // Add same filters as getCandidatesByJobId
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }

        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append("AND a.applied_at >= ? ");
            params.add(dateFrom);
        }

        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append("AND a.applied_at <= ? ");
            params.add(dateTo + " 23:59:59");
        }

        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append("AND ISNULL(c.full_name, '') LIKE ? ");
            params.add("%" + searchName.trim() + "%");
        }

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error in countCandidatesByJobId: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    public Map<String, Object> getJobPostById(int jobId) {
        String sql = """
        SELECT 
            jp.job_id,
            jp.title,
            jp.location,
            jp.status,
            jp.created_at,
            jp.deadline,
            jp.description,
            jp.requirement,
            r.company_name
        FROM job_post jp
        INNER JOIN recruiter r ON jp.recruiter_id = r.recruiter_id
        WHERE jp.job_id = ?
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Map<String, Object> jobPost = new HashMap<>();
                jobPost.put("jobId", rs.getInt("job_id"));
                jobPost.put("jobTitle", rs.getString("title"));
                jobPost.put("location", rs.getString("location"));
                jobPost.put("status", rs.getString("status"));
                jobPost.put("postedDate", rs.getDate("created_at"));
                jobPost.put("deadline", rs.getDate("deadline"));
                jobPost.put("description", rs.getString("description"));
                jobPost.put("requirement", rs.getString("requirement"));
                jobPost.put("companyName", rs.getString("company_name"));
                return jobPost;
            }
        } catch (SQLException e) {
            System.out.println("Error in getJobPostById: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    public Map<String, Object> getJobApplicationStats(int jobId) {
        String sql = """
        SELECT 
            COUNT(*) as total_applications,
            COUNT(CASE WHEN status = 'Pending' THEN 1 END) as pending_count,
            COUNT(CASE WHEN status = 'Reviewing' THEN 1 END) as reviewing_count,
            COUNT(CASE WHEN status = 'Interview' THEN 1 END) as interview_count,
            COUNT(CASE WHEN status = 'Testing' THEN 1 END) as testing_count,
            COUNT(CASE WHEN status = 'Accepted' THEN 1 END) as accepted_count,
            COUNT(CASE WHEN status = 'Rejected' THEN 1 END) as rejected_count
        FROM [application] a
        INNER JOIN [candidate] c ON a.candidate_id = c.candidate_id AND c.isActive = 1
        WHERE a.job_id = ?
        """;

        Map<String, Object> stats = new HashMap<>();

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                stats.put("totalApplications", rs.getInt("total_applications"));
                stats.put("pendingCount", rs.getInt("pending_count"));
                stats.put("reviewingCount", rs.getInt("reviewing_count"));
                stats.put("interviewCount", rs.getInt("interview_count"));
                stats.put("testingCount", rs.getInt("testing_count"));
                stats.put("acceptedCount", rs.getInt("accepted_count"));
                stats.put("rejectedCount", rs.getInt("rejected_count"));
            }
        } catch (SQLException e) {
            System.out.println("Error in getJobApplicationStats: " + e.getMessage());
            e.printStackTrace();
        }

        return stats;
    }

    public boolean updateApplicationStatusBatch(List<Integer> applicationIds, String newStatus, int recruiterId) {
        if (applicationIds == null || applicationIds.isEmpty()) {
            return false;
        }

        // Create placeholders for IN clause
        String placeholders = String.join(",", Collections.nCopies(applicationIds.size(), "?"));

        String sql = """
        UPDATE [application] 
        SET status = ? 
        WHERE application_id IN (%s) 
        AND job_id IN (
            SELECT job_id FROM job_post WHERE recruiter_id = ?
        )
        """.formatted(placeholders);

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, newStatus);

            // Set application IDs
            for (int i = 0; i < applicationIds.size(); i++) {
                ps.setInt(i + 2, applicationIds.get(i));
            }

            // Set recruiter ID
            ps.setInt(applicationIds.size() + 2, recruiterId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error in updateApplicationStatusBatch: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateSingleApplicationStatus(int applicationId, String newStatus, int recruiterId) {
        String sql = """
        UPDATE [application] 
        SET status = ? 
        WHERE application_id = ? 
        AND job_id IN (
            SELECT job_id FROM job_post WHERE recruiter_id = ?
        )
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, applicationId);
            ps.setInt(3, recruiterId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error in updateSingleApplicationStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
