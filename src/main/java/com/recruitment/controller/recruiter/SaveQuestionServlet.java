package com.recruitment.controller.recruiter;

import com.recruitment.dao.QuestionDAO;
import com.recruitment.model.Question;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import java.io.IOException;
import java.util.Arrays;

@WebServlet("/SaveQuestion")
public class SaveQuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters from request
            String questionIdStr = request.getParameter("questionId");
            int testId = Integer.parseInt(request.getParameter("testId"));
            String questionText = request.getParameter("questionText");
            String questionType = request.getParameter("questionType").trim();

            if (questionText != null) {
                questionText = questionText.replaceAll("\\r?\\n", " ");
            }

            if (questionText != null && !questionText.trim().isEmpty()) {
                questionText = questionText.trim().replaceAll("\\s+", " ");
            }

            if (questionText.isEmpty()) {
                throw new IllegalArgumentException("Question text cannot be empty");
            }

            String correctAnswer;
            String options = null;

            if ("multiple_choice".equals(questionType)) {
                // Collect options for multiple choice questions
                String[] optionArray = {
                    request.getParameter("optionA"),
                    request.getParameter("optionB"),
                    request.getParameter("optionC"),
                    request.getParameter("optionD")
                };

                for (int i = 0; i < optionArray.length; i++) {
                    String opt = optionArray[i];
                    if (opt != null && !opt.trim().isEmpty()) {
                        optionArray[i] = opt.trim().replaceAll("\\s+", " ");
                    } else {
                        optionArray[i] = ""; 
                    }
                }
                
                // Filter out empty options and convert to JSON
                JSONArray optionsJson = new JSONArray();
                int validOptions = 0;
                for (String opt : optionArray) {
                    if (opt != null && !opt.trim().isEmpty()) {
                        optionsJson.put(opt.trim());
                        validOptions++;
                    }
                }

                if (validOptions < 2) {
                    throw new IllegalArgumentException("Multiple choice questions require at least 2 options");
                }

                options = optionsJson.toString();

                correctAnswer = request.getParameter("correctAnswerSelect").trim();
                if (correctAnswer.isEmpty()) {
                    throw new IllegalArgumentException("Correct answer must be selected for multiple choice questions");
                }
            } else {
                correctAnswer = request.getParameter("correctAnswerText").trim();
                if (correctAnswer.isEmpty()) {
                    throw new IllegalArgumentException("Correct answer cannot be empty for text questions");
                }
            }

            if (correctAnswer != null) {
                correctAnswer = correctAnswer.replaceAll("\\r?\\n", " ");
            }

            if (correctAnswer != null && !correctAnswer.trim().isEmpty()) {
                correctAnswer = correctAnswer.trim().replaceAll("\\s+", " ");
            }

            // Create or update question object
            Question question = new Question();
            if (questionIdStr != null && !questionIdStr.trim().isEmpty()) {
                question.setQuestionId(Integer.parseInt(questionIdStr));
            }
            question.setTestId(testId);
            question.setQuestionText(questionText);
            question.setQuestionType(questionType);
            question.setOptions(options);
            question.setCorrectAnswer(correctAnswer);

            // Save to database
            QuestionDAO questionDAO = new QuestionDAO();
            if (question.getQuestionId() > 0) {
                questionDAO.updateQuestion(question);
            } else {
                questionDAO.addQuestion(question);
            }

            // Redirect back to question management page
            response.sendRedirect(request.getContextPath() + "/EditTest?testId=" + testId);

        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error saving question: " + e.getMessage());
        }
    }
}
