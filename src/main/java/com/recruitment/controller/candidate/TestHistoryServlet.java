package com.recruitment.controller.candidate;

import com.recruitment.dao.AssignmentDAO;
import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.dao.TestDAO;
import com.recruitment.model.Assignment;
import com.recruitment.model.Candidate;
import com.recruitment.model.JobPost;
import com.recruitment.model.Test;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "TestHistoryServlet", urlPatterns = {"/TestHistory"})
public class TestHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Fetch completed assignments
            AssignmentDAO assignmentDAO = new AssignmentDAO();
            List<Assignment> assignments = assignmentDAO.getAssignmentsByCandidateId(candidate.getCandidateId());

            // Fetch test and job details
            TestDAO testDAO = new TestDAO();
            JobPostingPageDAO jobDAO = new JobPostingPageDAO();
            List<TestHistoryItem> historyItems = new ArrayList<>();

            for (Assignment ass : assignments) {
                Test test = testDAO.getTestById(ass.getTestId());
                JobPost job = jobDAO.searchJobPostbyJobID(ass.getJobId());
                if (test != null && job != null) {
                    TestHistoryItem item = new TestHistoryItem();
                    item.setAssignment(ass);
                    item.setTestTitle(test.getTitle());
                    item.setJobTitle(job.getTitle());
                    historyItems.add(item);
                }
            }

            request.setAttribute("historyItems", historyItems);

            // Handle request to view specific result
            String assignmentIdStr = request.getParameter("assignmentId");
            if (assignmentIdStr != null) {
                int assignmentId = Integer.parseInt(assignmentIdStr);
                Assignment selectedAss = assignmentDAO.getAssignmentByIdAndCandidate(assignmentId, candidate.getCandidateId());
                if (selectedAss != null) {
                    Test test = testDAO.getTestById(selectedAss.getTestId());
                    request.setAttribute("assignment", selectedAss);
                    request.setAttribute("test", test);
                    request.getRequestDispatcher("/TestResult.jsp").forward(request, response);
                    return;
                }
            }

            request.getRequestDispatcher("/TestHistory.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid assignment ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving test history: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for displaying candidate test history";
    }

    // Helper class to hold history item data
    public static class TestHistoryItem {
        private Assignment assignment;
        private String testTitle;
        private String jobTitle;

        public Assignment getAssignment() {
            return assignment;
        }

        public void setAssignment(Assignment assignment) {
            this.assignment = assignment;
        }

        public String getTestTitle() {
            return testTitle;
        }

        public void setTestTitle(String testTitle) {
            this.testTitle = testTitle;
        }

        public String getJobTitle() {
            return jobTitle;
        }

        public void setJobTitle(String jobTitle) {
            this.jobTitle = jobTitle;
        }
    }
}