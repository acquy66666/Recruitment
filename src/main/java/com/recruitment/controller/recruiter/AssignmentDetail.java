/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.recruitment.dao.AssignmentDAO;
import com.recruitment.dao.CandidateDAO;
import com.recruitment.dao.QuestionDAO;
import com.recruitment.dao.ResponseDAO;
import com.recruitment.dao.TestDAO;
import com.recruitment.model.Assignment;
import com.recruitment.model.Candidate;
import com.recruitment.model.Question;
import com.recruitment.model.Recruiter;
import com.recruitment.model.Response;
import com.recruitment.model.Test;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hoang
 */
@WebServlet(name = "AssignmentDetail", urlPatterns = {"/AssignmentDetail"})
public class AssignmentDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();
            Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

            if (recruiter == null) {
                response.sendRedirect("login");
                return;
            }

            String assignmentIdStr = request.getParameter("assignmentId");
            int assignmentId = Integer.parseInt(assignmentIdStr);

            String candidateIdStr = request.getParameter("candidateId");
            int candidateId = Integer.parseInt(candidateIdStr);

            AssignmentDAO assignmentDAO = new AssignmentDAO();
            Assignment assignment = assignmentDAO.getAssignmentById(assignmentId);

            QuestionDAO questionDAO = new QuestionDAO();
            List<Question> questions = questionDAO.getQuestionsByTestId(assignment.getTestId());

            ResponseDAO responseDAO = new ResponseDAO();
            Map<Integer, Response> responseMap = responseDAO.getResponsesByAssignmentId(assignmentId);

            CandidateDAO candidateDAO = new CandidateDAO();
            Candidate candidate = candidateDAO.getCandidateById(candidateId);

            TestDAO testDAO = new TestDAO();
            Test test = testDAO.getTestByIdAndRecruiterId(assignment.getTestId(), recruiter.getRecruiterId());
            if (test == null) {
                request.setAttribute("errorMessage", "Bạn không có quyền truy cập bài test này.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            ObjectMapper mapper = new ObjectMapper();
            for (Question question : questions) {
                if (question.getOptions() != null && !question.getOptions().isEmpty()) {
                    List<String> optionsList = mapper.readValue(question.getOptions(), new TypeReference<List<String>>() {
                    });
                    question.setOptionsList(optionsList);
                } else {
                    question.setOptionsList(new ArrayList<>());
                }

                Response r = responseMap.get(question.getQuestionId());
                if (r != null) {
                    question.setUserResponse(r.getResponseText());
                    question.setIsCorrect(r.isCorrect());
                    question.setResponseId(r.getResponseId());
                } else {
                    question.setUserResponse(null);
                    question.setIsCorrect(false);
                    question.setResponseId(0);
                }
            }
            
            request.setAttribute("candidate", candidate);
            request.setAttribute("questions", questions);
            request.setAttribute("assignment", assignment);
            request.setAttribute("test", test);
            request.getRequestDispatcher("/AssignmentDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid test ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error retrieving questions: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

            if (recruiter == null) {
                response.sendRedirect("login");
                return;
            }

            // Get form parameters
            int responseId = Integer.parseInt(request.getParameter("responseId"));
            int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
            int candidateId = Integer.parseInt(request.getParameter("candidateId"));
            boolean newIsCorrect = Boolean.parseBoolean(request.getParameter("isCorrect"));
            ResponseDAO responseDAO = new ResponseDAO();
            AssignmentDAO assignmentDAO = new AssignmentDAO();
            Assignment assignment = assignmentDAO.getAssignmentById(assignmentId);

            int totalQuestion = assignment.getTotalQuestion();
            int oldCorrectAns = assignment.getCorrectAnswer();
            int correctAns = oldCorrectAns;

            Response responseObj = responseDAO.getResponseById(responseId);

            boolean oldIsCorrect = responseObj.isCorrect();
            if (oldIsCorrect == false && newIsCorrect == true) {
                correctAns = oldCorrectAns + 1;
            } else if (oldIsCorrect == true && newIsCorrect == false) {
                correctAns = oldCorrectAns - 1;
            }

            double score = 0;
            score = ((double) correctAns / totalQuestion * 100);
            score = Math.round(score * 100.0) / 100.0;

            assignmentDAO.updateResultByAssignmentId(assignmentId, correctAns, score);

            responseDAO.updateIsCorrectByResponseId(responseId, newIsCorrect);

            response.sendRedirect("AssignmentDetail?assignmentId=" + assignmentId + "&candidateId=" + candidateId);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameter format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error updating evaluation: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
