package com.recruitment.dao;

import com.recruitment.model.Interview;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InterviewDAO extends DBcontext {

    public List<Interview> getAllInterviews() throws SQLException {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT * FROM Interview ORDER BY interview_time DESC";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                interviews.add(mapResultSetToInterview(rs));
            }
        }
        return interviews;
    }

    public List<Interview> getInterviewsByRecruiter(int recruiterId) throws SQLException {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT * FROM Interview WHERE recruiter_id = ? ORDER BY interview_time DESC";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    interviews.add(mapResultSetToInterview(rs));
                }
            }
        }
        return interviews;
    }

    public Interview getInterviewById(int interviewId) throws SQLException {
        String sql = "SELECT * FROM Interview WHERE interview_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, interviewId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToInterview(rs);
                }
            }
        }
        return null;
    }

    public Map<String, Object> getInterviewDetailForCandidate(int interviewId, int candidateId) throws SQLException {
        String sql = """
            SELECT 
                i.interview_id,
                i.interview_time,
                i.interview_type,
                ISNULL(i.location, '') as location,
                ISNULL(i.interviewers, '') as interviewers,
                ISNULL(i.description, '') as description,
                ISNULL(a.application_id, 0) as application_id,
                ISNULL(a.status, 'N/A') as application_status,
                a.applied_at,
                c.candidate_id,
                ISNULL(c.full_name, 'Unknown') as candidate_name,
                ISNULL(c.email, '') as candidate_email,
                ISNULL(c.phone, '') as candidate_phone,
                ISNULL(jp.job_id, 0) as job_id,
                ISNULL(jp.title, 'N/A') as job_title,
                ISNULL(jp.description, '') as job_description,
                r.recruiter_id,
                ISNULL(r.full_name, 'Unknown') as recruiter_name,
                ISNULL(r.email, '') as recruiter_email,
                ISNULL(r.phone, '') as recruiter_phone
            FROM Interview i
            LEFT JOIN application a ON i.application_id = a.application_id
            LEFT JOIN candidate c ON i.candidate_id = c.candidate_id
            LEFT JOIN job_post jp ON a.job_id = jp.job_id
            LEFT JOIN recruiter r ON i.recruiter_id = r.recruiter_id
            WHERE i.interview_id = ? AND i.candidate_id = ?
        """;

        System.out.println("=== DEBUG getInterviewDetailForCandidate ===");
        System.out.println("Interview ID: " + interviewId + ", Candidate ID: " + candidateId);
        System.out.println("SQL Query: " + sql); // Log the full SQL query

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, interviewId);
            ps.setInt(2, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> interview = new HashMap<>();
                    try {
                        interview.put("interviewId", rs.getInt("interview_id"));
                        interview.put("interviewTime", rs.getTimestamp("interview_time"));
                        interview.put("interviewType", rs.getString("interview_type"));
                        interview.put("location", rs.getString("location"));
                        interview.put("interviewers", rs.getString("interviewers"));
                        interview.put("description", rs.getString("description"));
                        interview.put("applicationId", rs.getInt("application_id"));
                        interview.put("applicationStatus", rs.getString("application_status"));
                        interview.put("appliedAt", rs.getTimestamp("applied_at"));
                        interview.put("candidateId", rs.getInt("candidate_id"));
                        interview.put("candidateName", rs.getString("candidate_name"));
                        interview.put("candidateEmail", rs.getString("candidate_email"));
                        interview.put("candidatePhone", rs.getString("candidate_phone"));
                        interview.put("jobId", rs.getInt("job_id"));
                        interview.put("jobTitle", rs.getString("job_title"));
                        interview.put("jobDescription", rs.getString("job_description"));
                        // Removed jobRequirements, jobBenefits, salaryRange
                        interview.put("recruiterId", rs.getInt("recruiter_id"));
                        interview.put("recruiterName", rs.getString("recruiter_name"));
                        interview.put("recruiterEmail", rs.getString("recruiter_email"));
                        interview.put("recruiterPhone", rs.getString("recruiter_phone"));

                        System.out.println("Found interview detail: " + rs.getString("job_title") + " (ID: " + rs.getInt("interview_id") + ")");
                        return interview;
                    } catch (SQLException e) {
                        System.err.println("ERROR: Failed to retrieve column from ResultSet in getInterviewDetailForCandidate: " + e.getMessage());
                        e.printStackTrace();
                        throw e;
                    }
                }
            }
        }

        System.out.println("No interview detail found for ID: " + interviewId);
        return null;
    }

    public int createInterview(Interview interview) throws SQLException {
        c.setAutoCommit(false);
        try {
            String sql = "INSERT INTO Interview (application_id, candidate_id, recruiter_id, interview_time, interview_type, location, interviewers, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                if (interview.getApplicationId() != null) {
                    ps.setInt(1, interview.getApplicationId());
                } else {
                    ps.setNull(1, Types.INTEGER);
                }

                if (interview.getCandidateId() != null) {
                    ps.setInt(2, interview.getCandidateId());
                } else {
                    ps.setNull(2, Types.INTEGER);
                }

                ps.setInt(3, interview.getRecruiterId());
                ps.setTimestamp(4, interview.getInterviewTime());
                ps.setString(5, interview.getInterviewType());
                ps.setString(6, interview.getLocation());
                ps.setString(7, interview.getInterviewers());
                ps.setString(8, interview.getDescription());

                int affectedRows = ps.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Creating interview failed, no rows affected.");
                }

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int interviewId = rs.getInt(1);
                        c.commit();
                        return interviewId;
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

    public boolean updateInterview(Interview interview) throws SQLException {
        String sql = "UPDATE Interview SET application_id = ?, candidate_id = ?, recruiter_id = ?, interview_time = ?, interview_type = ? WHERE interview_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            if (interview.getApplicationId() != null) {
                ps.setInt(1, interview.getApplicationId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }

            if (interview.getCandidateId() != null) {
                ps.setInt(2, interview.getCandidateId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }

            ps.setInt(3, interview.getRecruiterId());
            ps.setTimestamp(4, interview.getInterviewTime());
            ps.setString(5, interview.getInterviewType());
            ps.setInt(6, interview.getInterviewId());

            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteInterview(int interviewId) throws SQLException {
        String sql = "DELETE FROM Interview WHERE interview_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, interviewId);
            return ps.executeUpdate() > 0;
        }
    }

    public List<Interview> getInterviewsByCandidate(int candidateId) throws SQLException {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT * FROM Interview WHERE candidate_id = ? ORDER BY interview_time DESC";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    interviews.add(mapResultSetToInterview(rs));
                }
            }
        }
        return interviews;
    }

    public List<Interview> getUpcomingInterviews(int recruiterId) throws SQLException {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT * FROM Interview WHERE recruiter_id = ? AND interview_time > GETDATE() ORDER BY interview_time ASC";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    interviews.add(mapResultSetToInterview(rs));
                }
            }
        }
        return interviews;
    }

    public List<Map<String, Object>> getDetailedInterviewsByCandidate(int candidateId) throws SQLException {
        List<Map<String, Object>> interviews = new ArrayList<>();

        System.out.println("=== DEBUG getDetailedInterviewsByCandidate ===");
        System.out.println("candidateId: " + candidateId);

        String sql = """
            SELECT 
                i.interview_id,
                i.interview_time,
                i.interview_type,
                ISNULL(a.application_id, 0) as application_id,
                ISNULL(a.status, 'N/A') as application_status,
                a.applied_at,
                c.candidate_id,
                ISNULL(c.full_name, 'Unknown') as candidate_name,
                ISNULL(c.email, '') as candidate_email,
                ISNULL(c.phone, '') as candidate_phone,
                ISNULL(c.image_url, '') as candidate_image,
                ISNULL(jp.job_id, 0) as job_id,
                ISNULL(jp.title, 'N/A') as job_title,
                ISNULL(jp.location, '') as job_location,
                r.recruiter_id,
                ISNULL(r.full_name, 'Unknown') as recruiter_name,
                ISNULL(r.email, '') as recruiter_email,
                ISNULL(r.phone, '') as recruiter_phone
            FROM Interview i
            LEFT JOIN application a ON i.application_id = a.application_id
            LEFT JOIN candidate c ON i.candidate_id = c.candidate_id
            LEFT JOIN job_post jp ON a.job_id = jp.job_id
            LEFT JOIN recruiter r ON i.recruiter_id = r.recruiter_id
            WHERE i.candidate_id = ? AND c.candidate_id IS NOT NULL
            ORDER BY i.interview_time DESC
        """;

        System.out.println("SQL Query: " + sql);

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> interview = new HashMap<>();
                    try {
                        interview.put("interviewId", rs.getInt("interview_id"));
                        interview.put("interviewTime", rs.getTimestamp("interview_time"));
                        interview.put("interviewType", rs.getString("interview_type"));
                        interview.put("applicationId", rs.getInt("application_id"));
                        interview.put("applicationStatus", rs.getString("application_status"));
                        interview.put("appliedAt", rs.getTimestamp("applied_at"));
                        interview.put("jobId", rs.getInt("job_id"));
                        interview.put("jobTitle", rs.getString("job_title"));
                        interview.put("jobLocation", rs.getString("job_location"));
                        interview.put("recruiterId", rs.getInt("recruiter_id"));
                        interview.put("recruiterName", rs.getString("recruiter_name"));
                        interview.put("recruiterEmail", rs.getString("recruiter_email"));
                        interview.put("recruiterPhone", rs.getString("recruiter_phone"));
                        interviews.add(interview);

                        System.out.println("Found interview: ID=" + rs.getInt("interview_id")
                                + ", Job=" + rs.getString("job_title")
                                + ", Location=" + rs.getString("job_location"));
                    } catch (SQLException e) {
                        System.err.println("ERROR: Failed to retrieve column from ResultSet in getDetailedInterviewsByCandidate: " + e.getMessage());
                        e.printStackTrace();
                        throw e;
                    }
                }
            }
        }

        System.out.println("Total interviews found: " + interviews.size());
        System.out.println("=== END DEBUG getDetailedInterviewsByCandidate ===");

        return interviews;
    }

    public List<Map<String, Object>> getUpcomingInterviewsByCandidate(int candidateId) throws SQLException {
        List<Map<String, Object>> interviews = new ArrayList<>();

        System.out.println("=== DEBUG getUpcomingInterviewsByCandidate ===");
        System.out.println("candidateId: " + candidateId);

        String sql = """
            SELECT 
                i.interview_id,
                i.interview_time,
                i.interview_type,
                ISNULL(a.application_id, 0) as application_id,
                ISNULL(a.status, 'N/A') as application_status,
                a.applied_at,
                ISNULL(jp.job_id, 0) as job_id,
                ISNULL(jp.title, 'N/A') as job_title,
                ISNULL(jp.location, '') as job_location,
                r.recruiter_id,
                ISNULL(r.full_name, 'Unknown') as recruiter_name,
                ISNULL(r.email, '') as recruiter_email,
                ISNULL(r.phone, '') as recruiter_phone
            FROM Interview i
            LEFT JOIN application a ON i.application_id = a.application_id
            LEFT JOIN job_post jp ON a.job_id = jp.job_id
            LEFT JOIN recruiter r ON i.recruiter_id = r.recruiter_id
            LEFT JOIN candidate c ON i.candidate_id = c.candidate_id
            WHERE i.candidate_id = ? AND i.interview_time > GETDATE() AND c.candidate_id IS NOT NULL
            ORDER BY i.interview_time ASC
        """;

        System.out.println("SQL Query: " + sql);

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> interview = new HashMap<>();
                    try {
                        interview.put("interviewId", rs.getInt("interview_id"));
                        interview.put("interviewTime", rs.getTimestamp("interview_time"));
                        interview.put("interviewType", rs.getString("interview_type"));
                        interview.put("applicationId", rs.getInt("application_id"));
                        interview.put("applicationStatus", rs.getString("application_status"));
                        interview.put("appliedAt", rs.getTimestamp("applied_at"));
                        interview.put("jobId", rs.getInt("job_id"));
                        interview.put("jobTitle", rs.getString("job_title"));
                        interview.put("jobLocation", rs.getString("job_location"));
                        interview.put("recruiterId", rs.getInt("recruiter_id"));
                        interview.put("recruiterName", rs.getString("recruiter_name"));
                        interview.put("recruiterEmail", rs.getString("recruiter_email"));
                        interview.put("recruiterPhone", rs.getString("recruiter_phone"));
                        interviews.add(interview);

                        System.out.println("Found upcoming interview: ID=" + rs.getInt("interview_id")
                                + ", Job=" + rs.getString("job_title")
                                + ", Location=" + rs.getString("job_location"));
                    } catch (SQLException e) {
                        System.err.println("ERROR: Failed to retrieve column from ResultSet in getUpcomingInterviewsByCandidate: " + e.getMessage());
                        e.printStackTrace();
                        throw e;
                    }
                }
            }
        }

        System.out.println("Total upcoming interviews found: " + interviews.size());
        System.out.println("=== END DEBUG getUpcomingInterviewsByCandidate ===");

        return interviews;
    }

    public int countInterviewsByCandidate(int candidateId) throws SQLException {
        System.out.println("=== DEBUG countInterviewsByCandidate ===");
        System.out.println("candidateId: " + candidateId);

        String sql = """
            SELECT COUNT(*) as total 
            FROM Interview i
            INNER JOIN candidate c ON i.candidate_id = c.candidate_id
            WHERE i.candidate_id = ? AND c.candidate_id IS NOT NULL
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("total");
                    System.out.println("Interview count: " + count);
                    return count;
                }
            }
        }

        System.out.println("No count found, returning 0");
        return 0;
    }

    private Interview mapResultSetToInterview(ResultSet rs) throws SQLException {
        Interview interview = new Interview();
        interview.setInterviewId(rs.getInt("interview_id"));

        int applicationId = rs.getInt("application_id");
        if (!rs.wasNull()) {
            interview.setApplicationId(applicationId);
        }

        int candidateId = rs.getInt("candidate_id");
        if (!rs.wasNull()) {
            interview.setCandidateId(candidateId);
        }

        interview.setRecruiterId(rs.getInt("recruiter_id"));
        interview.setInterviewTime(rs.getTimestamp("interview_time"));
        interview.setInterviewType(rs.getString("interview_type"));

        return interview;
    }

    public List<Map<String, Object>> getScheduledInterviews(int recruiterId, String search, String jobPosition,
            String dateFrom, String dateTo, int offset, int limit) {
        List<Map<String, Object>> interviews = new ArrayList<>();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT ");
        sql.append("    i.interview_id, ");
        sql.append("    i.application_id, ");
        sql.append("    i.candidate_id, ");
        sql.append("    i.recruiter_id, ");
        sql.append("    i.interview_time, ");
        sql.append("    i.location, ");
        sql.append("    i.interviewers, ");
        sql.append("    i.description, ");
        sql.append("    i.interview_type, ");
        sql.append("    c.full_name, ");
        sql.append("    c.email, ");
        sql.append("    c.phone, ");
        sql.append("    c.image_url, ");
        sql.append("    a.applied_at, ");
        sql.append("    a.status, ");
        sql.append("    jp.title as job_title, ");
        sql.append("    jp.job_position ");
        sql.append("FROM Interview i ");
        sql.append("INNER JOIN application a ON i.application_id = a.application_id ");
        sql.append("INNER JOIN candidate c ON i.candidate_id = c.candidate_id AND c.isActive = 1 ");
        sql.append("INNER JOIN job_post jp ON a.job_id = jp.job_id ");
        sql.append("WHERE i.recruiter_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        // Add filters
        if (jobPosition != null && !jobPosition.trim().isEmpty()) {
            sql.append("AND jp.job_position = ? ");
            params.add(jobPosition);
        }

        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append("AND i.interview_time >= ? ");
            params.add(dateFrom);
        }

        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append("AND i.interview_time <= ? ");
            params.add(dateTo + " 23:59:59");
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND ISNULL(c.full_name, '') LIKE ? ");
            params.add("%" + search.trim() + "%");
        }

        sql.append("ORDER BY i.interview_time DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> interview = new HashMap<>();
                interview.put("interviewId", rs.getInt("interview_id"));
                interview.put("applicationId", rs.getInt("application_id"));
                interview.put("candidateId", rs.getInt("candidate_id"));
                interview.put("recruiterId", rs.getInt("recruiter_id"));
                interview.put("interviewTime", rs.getTimestamp("interview_time"));
                interview.put("location", rs.getString("location"));
                interview.put("interviewers", rs.getString("interviewers"));
                interview.put("description", rs.getString("description"));
                interview.put("interviewType", rs.getString("interview_type"));
                interview.put("fullName", rs.getString("full_name"));
                interview.put("email", rs.getString("email"));
                interview.put("phoneNumber", rs.getString("phone"));
                interview.put("imageUrl", rs.getString("image_url"));
                interview.put("appliedAt", rs.getTimestamp("applied_at"));
                interview.put("status", rs.getString("status"));
                interview.put("jobTitle", rs.getString("job_title"));
                interview.put("jobPosition", rs.getString("job_position"));
                interview.put("phone", rs.getString("phone"));
                interviews.add(interview);
            }
        } catch (SQLException e) {
            System.out.println("Error in getScheduledInterviews: " + e.getMessage());
            e.printStackTrace();
        }

        return interviews;
    }

    public int countScheduledInterviews(int recruiterId, String search, String jobPosition, String dateFrom, String dateTo) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) ");
        sql.append("FROM Interview i ");
        sql.append("INNER JOIN application a ON i.application_id = a.application_id ");
        sql.append("INNER JOIN candidate c ON i.candidate_id = c.candidate_id AND c.isActive = 1 ");
        sql.append("INNER JOIN job_post jp ON a.job_id = jp.job_id ");
        sql.append("WHERE i.recruiter_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        // Add same filters as getScheduledInterviews
        if (jobPosition != null && !jobPosition.trim().isEmpty()) {
            sql.append("AND jp.job_position = ? ");
            params.add(jobPosition);
        }

        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append("AND i.interview_time >= ? ");
            params.add(dateFrom);
        }

        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append("AND i.interview_time <= ? ");
            params.add(dateTo + " 23:59:59");
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND ISNULL(c.full_name, '') LIKE ? ");
            params.add("%" + search.trim() + "%");
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
            System.out.println("Error in countScheduledInterviews: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    // Update the getInterviewStats method in ApplicationDAO
    public Map<String, Object> getInterviewStats(int recruiterId) {
        Map<String, Object> stats = new HashMap<>();

        String sql = """
        SELECT 
            COUNT(*) as total_interviews,
            COUNT(CASE WHEN i.interview_time > GETDATE() THEN 1 END) as upcoming_interviews,
            COUNT(CASE WHEN i.interview_time <= GETDATE() THEN 1 END) as completed_interviews,
            COUNT(CASE WHEN CAST(i.interview_time AS DATE) = CAST(GETDATE() AS DATE) THEN 1 END) as today_interviews,
            COUNT(CASE WHEN i.interview_type = 'video' THEN 1 END) as video_interviews
        FROM Interview i
        WHERE i.recruiter_id = ?
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                stats.put("totalInterviews", rs.getInt("total_interviews"));
                stats.put("upcomingInterviews", rs.getInt("upcoming_interviews"));
                stats.put("completedInterviews", rs.getInt("completed_interviews"));
                stats.put("todayInterviews", rs.getInt("today_interviews"));
                stats.put("videoInterviews", rs.getInt("video_interviews"));
            }
        } catch (SQLException e) {
            System.out.println("Error in getInterviewStats: " + e.getMessage());
            e.printStackTrace();
        }

        return stats;
    }

    // Add these methods to your InterviewDAO class if they don't exist
    public boolean deleteInterview(int interviewId, int recruiterId) {
        String sql = """
        DELETE FROM Interview 
        WHERE interview_id = ? AND recruiter_id = ?
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, interviewId);
            ps.setInt(2, recruiterId);

            int rowsAffected = ps.executeUpdate();

            System.out.println("Delete interview - Rows affected: " + rowsAffected);

            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error in deleteInterview: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean interviewExistsForRecruiter(int interviewId, int recruiterId) {
        String sql = """
        SELECT COUNT(*) as count 
        FROM Interview 
        WHERE interview_id = ? AND recruiter_id = ?
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, interviewId);
            ps.setInt(2, recruiterId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
            return false;

        } catch (SQLException e) {
            System.out.println("Error in interviewExistsForRecruiter: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateInterview(int interviewId, String interviewTime, String location,
            String interviewers, String description, String interviewType, int recruiterId) {
        String sql = """
        UPDATE Interview 
        SET interview_time = ?, 
            location = ?, 
            interviewers = ?, 
            description = ?, 
            interview_type = ?
        WHERE interview_id = ? AND recruiter_id = ?
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, interviewTime);
            ps.setString(2, location);
            ps.setString(3, interviewers);
            ps.setString(4, description);
            ps.setString(5, interviewType);
            ps.setInt(6, interviewId);
            ps.setInt(7, recruiterId);

            int rowsAffected = ps.executeUpdate();

            System.out.println("Update interview - Rows affected: " + rowsAffected);

            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error in updateInterview: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
