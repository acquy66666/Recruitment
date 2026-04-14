package com.recruitment.dao;

import com.recruitment.dto.AssignmentDTO;
import com.recruitment.dto.TestAssignmentDTO;
import com.recruitment.model.Assignment;
import com.recruitment.model.Candidate;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO extends DBcontext {

    public List<Assignment> getAssignmentsByCandidateId(int candidateId) {
        List<Assignment> list = new ArrayList<>();
        String sql = "SELECT * FROM assignment WHERE candidate_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Assignment a = new Assignment();
                a.setAssignmentId(rs.getInt("assignment_id"));
                a.setTestId(rs.getInt("test_id"));
                a.setJobId(rs.getInt("job_id"));
                a.setCandidateId(rs.getInt("candidate_id"));
                a.setAssignedAt(rs.getTimestamp("assigned_at"));
                a.setCompletedAt(rs.getTimestamp("completed_at"));
                a.setTotalQuestion(rs.getInt("total_question"));
                a.setCorrectAnswer(rs.getInt("correct_answer"));
                a.setScore(rs.getDouble("score"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public Assignment getAssignmentByIdAndCandidate(int assignmentId, int candidateId) {
        Assignment a = null;
        String sql = "SELECT * FROM assignment WHERE assignment_id = ? AND candidate_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ps.setInt(2, candidateId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                a = new Assignment();
                a.setAssignmentId(rs.getInt("assignment_id"));
                a.setTestId(rs.getInt("test_id"));
                a.setJobId(rs.getInt("job_id"));
                a.setCandidateId(rs.getInt("candidate_id"));
                a.setAssignedAt(rs.getTimestamp("assigned_at"));
                a.setCompletedAt(rs.getTimestamp("completed_at"));
                a.setTotalQuestion(rs.getInt("total_question"));
                a.setCorrectAnswer(rs.getInt("correct_answer"));
                a.setScore(rs.getDouble("score"));
                a.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return a;
    }

    public boolean updateAssignment(Assignment assignment) {
        String sql = """
        UPDATE assignment
        SET completed_at = ?, correct_answer = ?, score = ?, total_question = ?, status = ?
        WHERE assignment_id = ? AND candidate_id = ?
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setTimestamp(1, assignment.getCompletedAt());
            ps.setInt(2, assignment.getCorrectAnswer());
            ps.setDouble(3, assignment.getScore());
            ps.setInt(4, assignment.getTotalQuestion());
            ps.setString(5, assignment.getStatus());
            ps.setInt(6, assignment.getAssignmentId());
            ps.setInt(7, assignment.getCandidateId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<AssignmentDTO> getAssignmentsByRecruiterId(int recruiterId) {
        List<AssignmentDTO> list = new ArrayList<>();
        String sql = """
        SELECT 
            a.assignment_id,
            a.test_id,
            a.candidate_id,
            a.job_id,
            a.assigned_at,
            a.completed_at,
            a.score,
            a.status,

            t.title AS test_title,
            t.description AS test_description,

            c.full_name AS candidate_name,
            c.email AS candidate_email,

            j.title AS job_title
        FROM assignment a
        JOIN test t ON a.test_id = t.test_id
        JOIN candidate c ON a.candidate_id = c.candidate_id
        JOIN job_post j ON a.job_id = j.job_id
        WHERE t.recruiter_id = ?
        """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AssignmentDTO assignment = new AssignmentDTO();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setTestId(rs.getInt("test_id"));
                assignment.setCandidateId(rs.getInt("candidate_id"));
                assignment.setJobId(rs.getInt("job_id"));
                assignment.setAssignedAt(rs.getTimestamp("assigned_at") != null ? rs.getTimestamp("assigned_at") : null);
                assignment.setCompletedAt(rs.getTimestamp("completed_at") != null ? rs.getTimestamp("completed_at") : null);
                assignment.setScore(rs.getDouble("score"));
                assignment.setStatus(rs.getString("status"));

                assignment.setTestTitle(rs.getString("test_title"));
                assignment.setTestDescription(rs.getString("test_description"));
                assignment.setCandidateName(rs.getString("candidate_name"));
                assignment.setCandidateEmail(rs.getString("candidate_email"));
                assignment.setJobTitle(rs.getString("job_title"));

                list.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<AssignmentDTO> getAssignmentsByRecruiterId(
            int recruiterId,
            String searchKeyword,
            String status,
            Integer jobId,
            Integer testId,
            Timestamp assignedFromDate,
            Timestamp assignedToDate,
            Double minScore,
            Double maxScore,
            int page,
            int pageSize
    ) {
        List<AssignmentDTO> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        StringBuilder sql = new StringBuilder("""
        SELECT 
            a.assignment_id,
            a.test_id,
            a.candidate_id,
            a.job_id,
            a.assigned_at,
            a.completed_at,
            a.score,
            a.status,
            t.title AS test_title,
            t.description AS test_description,
            c.full_name AS candidate_name,
            c.email AS candidate_email,
            j.title AS job_title
        FROM assignment a
        JOIN test t ON a.test_id = t.test_id
        JOIN candidate c ON a.candidate_id = c.candidate_id
        JOIN job_post j ON a.job_id = j.job_id
        WHERE t.recruiter_id = ?
    """);

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (c.full_name LIKE ? OR c.email LIKE ?)");
            String keyword = "%" + searchKeyword.trim() + "%";
            params.add(keyword);
            params.add(keyword);
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND a.status = ?");
            params.add(status);
        }

        if (jobId != null && jobId != 0) {
            sql.append(" AND a.job_id = ?");
            params.add(jobId);
        }

        if (testId != null && testId != 0) {
            sql.append(" AND a.test_id = ?");
            params.add(testId);
        }

        if (assignedFromDate != null) {
            sql.append(" AND a.assigned_at >= ?");
            params.add(assignedFromDate);
        }

        if (assignedToDate != null) {
            sql.append(" AND a.assigned_at <= ?");
            params.add(assignedToDate);
        }

        if (minScore != null) {
            sql.append(" AND a.score >= ?");
            params.add(minScore);
        }

        if (maxScore != null) {
            sql.append(" AND a.score <= ?");
            params.add(maxScore);
        }

        sql.append(" ORDER BY a.assigned_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AssignmentDTO assignment = new AssignmentDTO();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setTestId(rs.getInt("test_id"));
                assignment.setCandidateId(rs.getInt("candidate_id"));
                assignment.setJobId(rs.getInt("job_id"));
                assignment.setAssignedAt(rs.getTimestamp("assigned_at"));
                assignment.setCompletedAt(rs.getTimestamp("completed_at"));
                assignment.setScore(rs.getDouble("score"));
                assignment.setStatus(rs.getString("status"));
                assignment.setTestTitle(rs.getString("test_title"));
                assignment.setTestDescription(rs.getString("test_description"));
                assignment.setCandidateName(rs.getString("candidate_name"));
                assignment.setCandidateEmail(rs.getString("candidate_email"));
                assignment.setJobTitle(rs.getString("job_title"));
                list.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countAssignmentsByRecruiterId(
            int recruiterId,
            String searchKeyword,
            String status,
            Integer jobId,
            Integer testId,
            Timestamp assignedFromDate,
            Timestamp assignedToDate,
            Double minScore,
            Double maxScore
    ) {
        StringBuilder sql = new StringBuilder("""
        SELECT COUNT(*) 
        FROM assignment a
        JOIN test t ON a.test_id = t.test_id
        JOIN candidate c ON a.candidate_id = c.candidate_id
        JOIN job_post j ON a.job_id = j.job_id
        WHERE t.recruiter_id = ?
    """);

        List<Object> params = new ArrayList<>();
        params.add(recruiterId);

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (c.full_name LIKE ? OR c.email LIKE ?)");
            String keyword = "%" + searchKeyword.trim() + "%";
            params.add(keyword);
            params.add(keyword);
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND a.status = ?");
            params.add(status);
        }

        if (jobId != null && jobId != 0) {
            sql.append(" AND a.job_id = ?");
            params.add(jobId);
        }

        if (testId != null && testId != 0) {
            sql.append(" AND a.test_id = ?");
            params.add(testId);
        }

        if (assignedFromDate != null) {
            sql.append(" AND a.assigned_at >= ?");
            params.add(assignedFromDate);
        }

        if (assignedToDate != null) {
            sql.append(" AND a.assigned_at <= ?");
            params.add(assignedToDate);
        }

        if (minScore != null) {
            sql.append(" AND a.score >= ?");
            params.add(minScore);
        }

        if (maxScore != null) {
            sql.append(" AND a.score <= ?");
            params.add(maxScore);
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
            e.printStackTrace();
        }

        return 0;
    }

    public List<String> getAllAssignmentStatuses() {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT DISTINCT status FROM assignment";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String status = rs.getString("status");
                if (status != null) {
                    statuses.add(status);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statuses;
    }

    public int countAvailableCandidates(int jobId) {
        String sql = """
        SELECT COUNT(DISTINCT a.candidate_id)
        FROM application a
        WHERE a.job_id = ?
          AND a.status = 'Testing'
          AND a.candidate_id NOT IN (
              SELECT candidate_id
              FROM assignment
              WHERE job_id = ?
          )
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setInt(2, jobId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int countAssignedCandidates(int jobId) {
        String sql = """
        SELECT COUNT(DISTINCT candidate_id)
        FROM assignment
        WHERE job_id = ?
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public boolean assignTestToCandidate(int testId, int jobId, int candidateId, Timestamp dueDate) throws SQLException {
        String sql = """
        INSERT INTO assignment (test_id, job_id, candidate_id, assigned_at, due_date, status)
        VALUES (?, ?, ?, CURRENT_TIMESTAMP, ?, 'doing')
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, testId);
            ps.setInt(2, jobId);
            ps.setInt(3, candidateId);
            ps.setTimestamp(4, dueDate);

            return ps.executeUpdate() > 0;
        }
    }

    public boolean isAssignmentExists(int jobId, int candidateId) throws SQLException {
        String sql = "SELECT 1 FROM assignment WHERE job_id = ? AND candidate_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setInt(2, candidateId);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // đã tồn tại
        }
    }

    public List<Candidate> getCandidatesCanBeAssigned(int jobId) throws SQLException {
        List<Candidate> list = new ArrayList<>();

        String sql = """
        SELECT DISTINCT c.candidate_id, c.full_name, c.email, c.phone
        FROM application a
        JOIN candidate c ON a.candidate_id = c.candidate_id
        WHERE a.job_id = ?
          AND a.status = 'Testing'
          AND a.candidate_id NOT IN (
              SELECT candidate_id
              FROM assignment
              WHERE job_id = ?
          )
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setInt(2, jobId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Candidate c = new Candidate();
                c.setCandidateId(rs.getInt("candidate_id"));
                c.setFullName(rs.getString("full_name"));
                c.setEmail(rs.getString("email"));
                c.setPhone(rs.getString("phone"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Assignment getAssignmentById(int assignmentId) throws SQLException {
        String sql = """
        SELECT assignment_id, test_id, job_id, candidate_id, 
               assigned_at, completed_at, total_question, 
               correct_answer, score, status
        FROM assignment
        WHERE assignment_id = ?
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Assignment a = new Assignment();
                    a.setAssignmentId(rs.getInt("assignment_id"));
                    a.setTestId(rs.getInt("test_id"));
                    a.setJobId(rs.getInt("job_id"));
                    a.setCandidateId(rs.getInt("candidate_id"));
                    a.setAssignedAt(rs.getTimestamp("assigned_at"));
                    a.setCompletedAt(rs.getTimestamp("completed_at"));
                    a.setTotalQuestion(rs.getInt("total_question"));
                    a.setCorrectAnswer(rs.getInt("correct_answer"));
                    a.setScore(rs.getDouble("score"));
                    a.setStatus(rs.getString("status"));
                    return a;
                }
            }
        }

        return null;
    }

    public boolean updateResultByAssignmentId(int assignmentId, int correctAnswer, double score) throws SQLException {
        String sql = """
        UPDATE assignment 
        SET correct_answer = ?, score = ?
        WHERE assignment_id = ?
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, correctAnswer);
            ps.setDouble(2, score);
            ps.setInt(3, assignmentId);
            return ps.executeUpdate() > 0;
        }
    }

    public List<TestAssignmentDTO> getTestWithAssignmentsByCandidateId(int candidateId) {
        List<TestAssignmentDTO> list = new ArrayList<>();
        String sql = """
        SELECT t.test_id, t.recruiter_id, t.title, t.description, t.status AS test_status,
               a.assignment_id, a.job_id, a.candidate_id, a.assigned_at, a.completed_at,
               a.total_question, a.score, a.status AS assignment_status, a.due_date
        FROM test t
        LEFT JOIN assignment a ON t.test_id = a.test_id
        WHERE a.candidate_id = ?
          AND a.status = 'doing'
          AND a.due_date >= ?
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TestAssignmentDTO dto = new TestAssignmentDTO();
                dto.setTestId(rs.getInt("test_id"));
                dto.setRecruiterId(rs.getInt("recruiter_id"));
                dto.setTitle(rs.getString("title"));
                dto.setDescription(rs.getString("description"));
                dto.setTestStatus(rs.getString("test_status"));
                dto.setAssignmentId(rs.getInt("assignment_id"));
                dto.setJobId(rs.getInt("job_id"));
                dto.setCandidateId(rs.getInt("candidate_id"));
                dto.setAssignedAt(rs.getTimestamp("assigned_at"));
                dto.setCompletedAt(rs.getTimestamp("completed_at"));
                dto.setTotalQuestion(rs.getInt("total_question"));
                dto.setScore(rs.getInt("score"));
                dto.setAssignmentStatus(rs.getString("assignment_status"));
                dto.setDueDate(rs.getTimestamp("due_date"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countAssignmentByRecruiterAndStatus(int recruiterId, String status) {
        String sql = "SELECT COUNT(*) "
                + "FROM assignment a "
                + "JOIN test t ON a.test_id = t.test_id "
                + "WHERE t.recruiter_id = ? AND a.status = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setString(2, status);
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

    public int countAssignmentByRecruiter(int recruiterId) {
        String sql = "SELECT COUNT(*) "
                + "FROM assignment a "
                + "JOIN test t ON a.test_id = t.test_id "
                + "WHERE t.recruiter_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
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

    public int countCorrectResponsesByAssignment(int assignmentId) {
    String sql = """
        SELECT COUNT(*) as correct_count
        FROM response
        WHERE assignment_id = ? AND is_correct = 1
    """;

    try (PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, assignmentId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("correct_count");
            }
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi đếm câu trả lời đúng: " + e.getMessage());
    }

    return 0; // Nếu lỗi hoặc không có dữ liệu
}


}
