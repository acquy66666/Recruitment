package com.recruitment.dao;

import com.google.gson.Gson;
import com.recruitment.model.Question;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO extends DBcontext {

    public void addQuestion(Question question) throws SQLException {
        String sql = "INSERT INTO question (test_id, question_text, question_type, options, correct_answer) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, question.getTestId());
            ps.setString(2, question.getQuestionText());
            ps.setString(3, question.getQuestionType());
            ps.setString(4, question.getOptions());
            ps.setString(5, question.getCorrectAnswer());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuestion(Question question) throws SQLException {
        String sql = "UPDATE question SET test_id = ?, question_text = ?, question_type = ?, "
                + "options = ?, correct_answer = ? WHERE question_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, question.getTestId());
            ps.setString(2, question.getQuestionText());
            ps.setString(3, question.getQuestionType());
            ps.setString(4, question.getOptions());
            ps.setString(5, question.getCorrectAnswer());
            ps.setInt(6, question.getQuestionId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Question> getQuestionsByTestId(int testId) throws SQLException {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM question WHERE test_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, testId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question question = new Question();
                question.setQuestionId(rs.getInt("question_id"));
                question.setTestId(rs.getInt("test_id"));
                question.setQuestionText(rs.getString("question_text"));
                question.setQuestionType(rs.getString("question_type"));
                question.setOptions(rs.getString("options"));
                question.setCorrectAnswer(rs.getString("correct_answer"));
                questions.add(question);
            }
        }

        return questions;
    }

    public boolean deleteQuestion(int questionId) throws SQLException {
        String sql = "DELETE FROM question WHERE question_id = ?";
        PreparedStatement ps = null;

        try {
            ps = c.prepareStatement(sql);
            ps.setInt(1, questionId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new SQLException("Error deleting question with ID " + questionId, e);
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("Error closing statement: " + e.getMessage());
                }
            }
            if (c != null) {
                try {
                    c.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    }

    public int countMultipleChoiceQuestion(int testId) {
        String sql = "SELECT COUNT(*) FROM question WHERE test_id = ? AND question_type = 'multiple_choice'";
        int count = 0;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, testId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    public int countTextQuestion(int testId) {
        String sql = "SELECT COUNT(*) FROM question WHERE test_id = ? AND question_type = 'text'";
        int count = 0;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, testId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    public int countTotalQuestions(int testId) {
        String sql = "SELECT COUNT(*) FROM question WHERE test_id = ?";
        int count = 0;

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, testId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

}
