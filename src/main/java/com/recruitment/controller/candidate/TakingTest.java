package com.recruitment.controller.candidate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.recruitment.dao.AssignmentDAO;
import com.recruitment.dao.QuestionDAO;
import com.recruitment.dao.ResponseDAO;
import com.recruitment.dao.TestDAO;
import com.recruitment.model.Assignment;
import com.recruitment.model.Candidate;
import com.recruitment.model.Question;
import com.recruitment.model.Response;
import com.recruitment.model.Test;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "TakingTest", urlPatterns = {"/TakingTest"})
public class TakingTest extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Candidate candidate = (Candidate) session.getAttribute("Candidate");

            if (candidate == null) {
                response.sendRedirect("login");
                return;
            }

            String assignmentIdStr = request.getParameter("assignmentId");
            if (assignmentIdStr == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing assignment ID");
                return;
            }
            int assignmentId = Integer.parseInt(assignmentIdStr);

            AssignmentDAO assignmentDAO = new AssignmentDAO();
            Assignment ass = assignmentDAO.getAssignmentByIdAndCandidate(assignmentId, candidate.getCandidateId());
            if (ass == null) {
                request.setAttribute("errorMessage", "Bạn không có quyền truy cập bài test này.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            QuestionDAO questionDAO = new QuestionDAO();
            List<Question> questions = questionDAO.getQuestionsByTestId(ass.getTestId());

            int totalQuestion = questions.size();

            TestDAO testDAO = new TestDAO();
            Test test = testDAO.getTestById(ass.getTestId());
            if (test == null) {
                request.setAttribute("errorMessage", "Bài test không tồn tại.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            ObjectMapper mapper = new ObjectMapper();
            for (Question question : questions) {
                if (question.getOptions() != null && !question.getOptions().isEmpty()) {
                    try {
                        List<String> optionsList = mapper.readValue(
                                question.getOptions(),
                                new TypeReference<List<String>>() {}
                        );
                        question.setOptionsList(optionsList);
                    } catch (Exception e) {
                        System.err.println("Error parsing options for question " + question.getQuestionId() + ": " + e.getMessage());
                        question.setOptionsList(new ArrayList<>());
                    }
                } else {
                    question.setOptionsList(new ArrayList<>());
                }
            }

            request.setAttribute("totalQuestion", totalQuestion);
            request.setAttribute("questions", questions);
            request.setAttribute("test", test);
            request.setAttribute("assignment", ass);
            request.getRequestDispatcher("/TakingTest.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid assignment ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error retrieving questions: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            String testIdStr = request.getParameter("testId");
            String candidateIdStr = request.getParameter("candidateId");
            String assignmentIdStr = request.getParameter("assignmentId");

            if (testIdStr == null || candidateIdStr == null || assignmentIdStr == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                return;
            }

            int testId = Integer.parseInt(testIdStr);
            int candidateId = Integer.parseInt(candidateIdStr);
            int assignmentId = Integer.parseInt(assignmentIdStr);

            AssignmentDAO assignmentDAO = new AssignmentDAO();
            Assignment assignment = assignmentDAO.getAssignmentByIdAndCandidate(assignmentId, candidateId);
            if (assignment == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid assignment");
                return;
            }

            QuestionDAO questionDAO = new QuestionDAO();
            List<Question> questions = questionDAO.getQuestionsByTestId(testId);

            ObjectMapper mapper = new ObjectMapper();
            for (Question question : questions) {
                if (question.getOptions() != null && !question.getOptions().isEmpty()) {
                    try {
                        List<String> optionsList = mapper.readValue(
                                question.getOptions(),
                                new TypeReference<List<String>>() {}
                        );
                        question.setOptionsList(optionsList);
                    } catch (Exception e) {
                        System.err.println("Error parsing options for question " + question.getQuestionId() + ": " + e.getMessage());
                        question.setOptionsList(new ArrayList<>());
                    }
                }
            }

            ResponseDAO responseDAO = new ResponseDAO();
            List<Response> responses = new ArrayList<>();
            int correctAnswers = 0;
            int totalAnswered = 0;

            for (Question question : questions) {
                String answerParam = "answer_" + question.getQuestionId();
                String userAnswer = request.getParameter(answerParam);

                if (userAnswer != null && !userAnswer.trim().isEmpty()) {
                    totalAnswered++;
                    Response responseObj = new Response();
                    responseObj.setQuestionId(question.getQuestionId());
                    responseObj.setAssignmentId(assignment.getAssignmentId());
                    responseObj.setResponseText(userAnswer.trim());

                    boolean isCorrect = false;
                    if (question.getQuestionType().equals("multiple_choice")) {
                        isCorrect = userAnswer.trim().equalsIgnoreCase(question.getCorrectAnswer().trim());
                    } else {
                        String correctAnswer = question.getCorrectAnswer().toLowerCase();
                        String userAnswerLower = userAnswer.toLowerCase();
                        isCorrect = userAnswerLower.equalsIgnoreCase(correctAnswer);
                    }

                    responseObj.setIsCorrect(isCorrect);
                    if (isCorrect) {
                        correctAnswers++;
                    }

                    responses.add(responseObj);
                }
            }

            for (Response resp : responses) {
                try {
                    responseDAO.saveResponse(resp);
                } catch (Exception e) {
                    System.err.println("Error saving response for question " + resp.getQuestionId() + ": " + e.getMessage());
                }
            }

            double score = 0;
            if (questions.size() > 0) {
                score = ((double) correctAnswers / questions.size()) * 100;
                score = Math.round(score * 100.0) / 100.0;
            }

            assignment.setStatus("completed");
            assignment.setCompletedAt(new Timestamp(System.currentTimeMillis()));
            assignment.setCorrectAnswer(correctAnswers);
            assignment.setTotalQuestion(questions.size());
            assignment.setScore(score);
            assignmentDAO.updateAssignment(assignment);

            request.setAttribute("assignment", assignment);
            TestDAO testDAO = new TestDAO();
            Test test = testDAO.getTestById(testId);
            request.setAttribute("test", test);
            request.getRequestDispatcher("/TestResult.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error processing test submission: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for taking and submitting tests";
    }
}