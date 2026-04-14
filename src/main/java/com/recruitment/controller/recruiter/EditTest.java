package com.recruitment.controller.recruiter;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.dao.QuestionDAO;
import com.recruitment.dao.RecruiterDAO;
import com.recruitment.dao.TestDAO;
import com.recruitment.model.Question;
import com.recruitment.model.Recruiter;
import com.recruitment.model.Test;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONObject;

@WebServlet(name = "EditTest", urlPatterns = {"/EditTest"})
public class EditTest extends HttpServlet {

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

            String testIdStr = request.getParameter("testId");
            int testId = Integer.parseInt(testIdStr);

            QuestionDAO questionDAO = new QuestionDAO();
            List<Question> questions = questionDAO.getQuestionsByTestId(testId);

            TestDAO testDAO = new TestDAO();
            Test test = testDAO.getTestByIdAndRecruiterId(testId, recruiter.getRecruiterId());
            if (test == null) {
                request.setAttribute("errorMessage", "Bạn không có quyền truy cập bài test này.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            int textQuestionCount = questionDAO.countTextQuestion(testId);
            int mtpQuestionCount = questionDAO.countMultipleChoiceQuestion(testId);
            int totalQuestion = questionDAO.countTotalQuestions(testId);
            int assCount = testDAO.getAssignmentCountByTestId(testId);
            double avgScore = testDAO.getAverageScoreByTestId(testId);
            double passRate = testDAO.getPassRateByTestId(testId);

            ObjectMapper mapper = new ObjectMapper();
            for (Question question : questions) {
                if (question.getOptions() != null && !question.getOptions().isEmpty()) {
                    try {
                        List<String> optionsList = mapper.readValue(
                                question.getOptions(),
                                new TypeReference<List<String>>() {
                        }
                        );
                        question.setOptionsList(optionsList);
                    } catch (Exception e) {

                        System.err.println("Error parsing options for question " + question.getQuestionId() + ": " + e.getMessage());
                        question.setOptionsList(new ArrayList<>()); // Set empty list to avoid null issues
                    }
                } else {
                    question.setOptionsList(new ArrayList<>()); // Set empty list for non-multiple-choice questions
                }
            }

            request.setAttribute("questions", questions);
            request.setAttribute("assCount", assCount);
            request.setAttribute("avgScore", avgScore);
            request.setAttribute("passRate", passRate);
            request.setAttribute("test", test);
            request.setAttribute("totalQuestion", totalQuestion);
            request.setAttribute("textQuestionCount", textQuestionCount);
            request.setAttribute("mtpQuestionCount", mtpQuestionCount);
            request.getRequestDispatcher("/EditTest.jsp").forward(request, response);

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

        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        String testIdStr = request.getParameter("testId");
        TestDAO testDAO = new TestDAO();
        JobPostingPageDAO jobPostingPageDAO = new JobPostingPageDAO();

        System.out.println(action);
        if (testIdStr != null && !testIdStr.trim().isEmpty()) {
            try {
                int testId = Integer.parseInt(testIdStr);

                if ("delete".equalsIgnoreCase(action)) {
                    if (testDAO.isTestInUse(testId)) {
                        session.setAttribute("errorMessage", "Không thể xóa bài thi vì đang được sử dụng.");
                        response.sendRedirect("EditTest?testId=" + testId);
                        return;
                    } else {
                        boolean deleted = testDAO.deleteTest(testId);
                        if (deleted) {
                            session.setAttribute("successMessage", "Xóa bài thi thành công.");
                        } else {
                            session.setAttribute("errorMessage", "Xóa bài thi thất bại.");
                        }
                    }
                    response.sendRedirect("TestManage");
                    return;
                    
                } else if ("updateStatus".equalsIgnoreCase(action)) {
                    String status = "Pending";

                    boolean deductCredit = jobPostingPageDAO.subtractServiceCredit(String.valueOf(recruiter.getRecruiterId()), "test");

                    if (deductCredit) {

                        boolean update = testDAO.updateTestStatus(testId, recruiter.getRecruiterId(), status);

                        if (update) {
                            System.out.println("Gửi yêu cầu thành công. Đã trừ 1 credit từ 'test");
                            session.setAttribute("successMessage", "Gửi yêu cầu thành công. Đã trừ 1 credit từ 'test'.");
                        } else {
                            System.out.println("Không đủ credit 'test' để gửi yêu cầu.");
                            session.setAttribute("errorMessage", "Không đủ credit 'test' để gửi yêu cầu.");
                            response.sendRedirect("EditTest?testId=" + testId);
                            return;
                        }
                    } else {
                        session.setAttribute("errorMessage", "Bạn đã hết lượt hoặc chưa mua gói bài thi");
                        System.out.println("Bạn đã hết lượt hoặc chưa mua gói bài thi");
                    }

                    response.sendRedirect("EditTest?testId=" + testId);
                    return;
                } else if ("update".equalsIgnoreCase(action)) {
                    String title = request.getParameter("title");
                    String description = request.getParameter("description");

                    if (title != null && !title.trim().isEmpty()) {
                        title = title.trim().replaceAll("\\s+", " ");
                    }

                    if (description != null && !description.trim().isEmpty()) {
                        description = description.trim().replaceAll("\\s+", " ");
                    }

                    Test test = new Test();
                    test.setTestId(testId);
                    test.setTitle(title);
                    test.setDescription(description);
                    test.setCreatedAt(new Date());
                    test.setRecruiterId(recruiter.getRecruiterId());

                    boolean updated = testDAO.updateTest(test);
                    if (updated) {
                        session.setAttribute("successMessage", "Cập nhật thành công.");
                    } else {
                        session.setAttribute("errorMessage", "Không thể cập nhật bài thi.");
                    }
                    response.sendRedirect("EditTest?testId=" + testId);
                    return;
                }

            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID không hợp lệ.");
            } catch (Exception e) {
                Logger.getLogger(EditTest.class.getName()).log(Level.SEVERE, null, e);
            }
        }

        response.sendRedirect("TestManage");
    }
}
