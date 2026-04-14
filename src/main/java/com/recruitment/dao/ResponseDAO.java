package com.recruitment.dao;

import com.recruitment.dto.ResponseDTO;
import com.recruitment.model.Response;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

public class ResponseDAO extends DBcontext {

    // Save a single response
    public boolean saveResponse(Response response) throws SQLException {
        String sql = "INSERT INTO response (question_id, assignment_id, response_text, is_correct) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, response.getQuestionId());
            stmt.setInt(2, response.getAssignmentId());
            stmt.setString(3, response.getResponseText());
            stmt.setBoolean(4, response.isCorrect());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Get the generated response_id
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        response.setResponseId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    // Get all responses for an assignment
    public Map<Integer, Response> getResponsesByAssignmentId(int assignmentId) throws SQLException {
        String sql = "SELECT * FROM response WHERE assignment_id = ?";
        Map<Integer, Response> map = new HashMap<>();
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Response r = new Response();
                r.setResponseId(rs.getInt("response_id"));
                r.setQuestionId(rs.getInt("question_id"));
                r.setResponseText(rs.getString("response_text"));
                r.setIsCorrect(rs.getBoolean("is_correct"));
                map.put(r.getQuestionId(), r);
            }
        }
        return map;
    }

    public boolean updateIsCorrectByResponseId(int responseId, boolean isCorrect) throws SQLException {
        String sql = "UPDATE response SET is_correct = ? WHERE response_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBoolean(1, isCorrect);
            ps.setInt(2, responseId);
            return ps.executeUpdate() > 0;
        }
    }

    public Response getResponseById(int responseId) throws SQLException {
        String sql = """
        SELECT response_id, question_id, assignment_id, 
               response_text, is_correct
        FROM response
        WHERE response_id = ?
    """;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, responseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Response r = new Response();
                    r.setResponseId(rs.getInt("response_id"));
                    r.setQuestionId(rs.getInt("question_id"));
                    r.setAssignmentId(rs.getInt("assignment_id"));
                    r.setResponseText(rs.getString("response_text"));
                    r.setIsCorrect(rs.getBoolean("is_correct"));
                    return r;
                }
            }
        }

        return null;
    }

    // Get responses for a specific question in an assignment
    public Response getResponseByQuestionAndAssignment(int questionId, int assignmentId) throws SQLException {
        String sql = "SELECT * FROM response WHERE question_id = ? AND assignment_id = ?";

        try (PreparedStatement stmt = c.prepareStatement(sql)) {

            stmt.setInt(1, questionId);
            stmt.setInt(2, assignmentId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Response response = new Response();
                    response.setResponseId(rs.getInt("response_id"));
                    response.setQuestionId(rs.getInt("question_id"));
                    response.setAssignmentId(rs.getInt("assignment_id"));
                    response.setResponseText(rs.getString("response_text"));
                    response.setIsCorrect(rs.getBoolean("is_correct"));

                    return response;
                }
            }
        }
        return null;
    }

    // Update a response
    public boolean updateResponse(Response response) throws SQLException {
        String sql = "UPDATE response SET response_text = ?, is_correct = ? WHERE response_id = ?";

        try (PreparedStatement stmt = c.prepareStatement(sql)) {

            stmt.setString(1, response.getResponseText());
            stmt.setBoolean(2, response.isCorrect());
            stmt.setInt(3, response.getResponseId());

            return stmt.executeUpdate() > 0;
        }
    }

    // Get count of correct answers for an assignment
    public int getCorrectAnswersCount(int assignmentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM response WHERE assignment_id = ? AND is_correct = true";

        try (PreparedStatement stmt = c.prepareStatement(sql)) {

            stmt.setInt(1, assignmentId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Get total responses count for an assignment
    public int getTotalResponsesCount(int assignmentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM response WHERE assignment_id = ?";

        try (PreparedStatement stmt = c.prepareStatement(sql)) {

            stmt.setInt(1, assignmentId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public String getResponseJsonAndEvaluate(int assignmentId) {
        List<ResponseDTO> list = new ArrayList<>();
        String sql = """
        SELECT r.response_id, r.question_id, r.assignment_id, r.response_text, r.is_correct,
               q.question_text, q.correct_answer, a.test_id, a.job_id, a.candidate_id
        FROM response r
        JOIN question q ON r.question_id = q.question_id
        JOIN assignment a ON r.assignment_id = a.assignment_id
        WHERE r.assignment_id = ? AND q.question_type = 'text'
        """;
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, assignmentId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ResponseDTO dto = new ResponseDTO(
                        rs.getInt("response_id"),
                        rs.getInt("question_id"),
                        rs.getInt("assignment_id"),
                        rs.getString("response_text"),
                        rs.getBoolean("is_correct"),
                        rs.getInt("test_id"),
                        rs.getString("question_text"),
                        rs.getString("correct_answer"),
                        rs.getInt("job_id"),
                        rs.getInt("candidate_id")
                );
                list.add(dto);
            }
            // Chuyển list sang JSON
            JSONArray jsonArray = new JSONArray();
            for (ResponseDTO dto : list) {
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("question_text", dto.getQuestionText());
                jsonObj.put("correct_answer", dto.getCorrectAnswer());
                jsonObj.put("user_answer", dto.getResponseText());
                jsonObj.put("is_correct", dto.isCorrect());
                jsonArray.put(jsonObj);
            }
            return jsonArray.toString();
        } catch (SQLException e) {
            System.out.println("Loi ket noi DB");
            e.printStackTrace();
            return new JSONArray().toString();
        }
    }

    public void updateIsCorrectFromJson(String jsonData, int assignmentId) {
        String sql = """
        UPDATE response
        SET is_correct = ?
        WHERE question_id = (
            SELECT question_id
            FROM question
            WHERE question_text = ?
        ) AND assignment_id = ?
        """;
        try {
            JSONArray jsonArray = new JSONArray(jsonData);
            PreparedStatement st = c.prepareStatement(sql);
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObj = jsonArray.getJSONObject(i);
                String questionText = jsonObj.getString("question_text");
                boolean isCorrect = jsonObj.getBoolean("is_correct");

                st.setBoolean(1, isCorrect);
                st.setString(2, questionText);
                st.setInt(3, assignmentId);
                st.addBatch();
            }
            st.executeBatch();
        } catch (SQLException e) {
            System.out.println("Loi ket noi");
        }
    }

}
