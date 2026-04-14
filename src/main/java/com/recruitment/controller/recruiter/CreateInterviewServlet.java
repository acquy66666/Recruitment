package com.recruitment.controller.recruiter;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.InterviewDAO;
import com.recruitment.model.Interview;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@WebServlet(name="CreateInterviewServlet", urlPatterns={"/CreateInterview"})
public class CreateInterviewServlet extends HttpServlet {
    
    private ApplicationDAO applicationDAO = new ApplicationDAO();
    private InterviewDAO interviewDAO = new InterviewDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        
        if (recruiter == null) {
            response.sendRedirect("login");
            return;
        }
        
        try {
            // Get applications that can be interviewed (status = Reviewing or Pending)
            List<Map<String, Object>> applications = applicationDAO.getFilteredApplicants(
                recruiter.getRecruiterId(), null, "Interview", null, null, null, 1, 50);
            
            System.out.println("=== DEBUG: Applications for Interview ===");
            System.out.println("Total applications found: " + applications.size());
            
            request.setAttribute("applications", applications);
            request.getRequestDispatcher("CreateInterview.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred: " + e.getMessage());
            request.getRequestDispatcher("CreateInterview.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        
        if (recruiter == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get form parameters
            String applicationIdStr = request.getParameter("applicationId");
            String interviewType = request.getParameter("interviewType");
            String interviewDate = request.getParameter("interviewDate");
            String interviewTime = request.getParameter("interviewTime");
            String location = request.getParameter("location");
            String interviewers = request.getParameter("interviewers");
            String description = request.getParameter("description");
            
            // Validate required fields
            if (applicationIdStr == null || applicationIdStr.trim().isEmpty() || 
                interviewType == null || interviewType.trim().isEmpty() ||
                interviewDate == null || interviewDate.trim().isEmpty() || 
                interviewTime == null || interviewTime.trim().isEmpty()) {
                response.sendRedirect("CreateInterview?error=Please fill all required fields");
                return;
            }
            
            int applicationId = Integer.parseInt(applicationIdStr);
            
            // Combine date and time
            String dateTimeStr = interviewDate + " " + interviewTime + ":00";
            Timestamp interviewDateTime = Timestamp.valueOf(dateTimeStr);
            
            // Check if interview time is in the future
            if (interviewDateTime.before(new Timestamp(System.currentTimeMillis()))) {
                response.sendRedirect("CreateInterview?error=Interview time must be in the future");
                return;
            }
            
            // Create interview object
            Interview interview = new Interview();
            interview.setApplicationId(applicationId);
            interview.setRecruiterId(recruiter.getRecruiterId());
            interview.setInterviewType(interviewType);
            interview.setInterviewTime(interviewDateTime);
            interview.setLocation(location != null ? location.trim() : "");
            interview.setInterviewers(interviewers != null ? interviewers.trim() : "");
            interview.setDescription(description != null ? description.trim() : "");

            // Get candidate_id from application
            try {
                com.recruitment.model.Application app = applicationDAO.getApplicationById(applicationId);
                if (app != null) {
                    interview.setCandidateId(app.getCandidateId());
                    System.out.println("Set candidate_id from application: " + app.getCandidateId());
                }
            } catch (Exception e) {
                System.err.println("Error getting candidate_id: " + e.getMessage());
            }
            
            // Create interview
            int interviewId = interviewDAO.createInterview(interview);
            
            if (interviewId > 0) {
                // Update application status
                applicationDAO.updateStatus(applicationId, "Interview");
                response.sendRedirect("InterviewManager");
            } else {
                response.sendRedirect("CreateInterview?error=Failed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("CreateInterview?error=Invalid input format");
        } catch (IllegalArgumentException e) {
            response.sendRedirect("CreateInterview?error=Invalid date/time format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CreateInterview?error=Database error occurred: " + e.getMessage());
        }
    }
}
