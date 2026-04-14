package com.recruitment.controller.recruiter;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.CandidateProfileDAO;
import com.recruitment.model.Candidate;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

@WebServlet("/CandidatePro")
public class CandidateProfileController extends HttpServlet {

    private CandidateProfileDAO candidateProfileDAO;
    private ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
        candidateProfileDAO = new CandidateProfileDAO();
        applicationDAO = new ApplicationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        // ✅ SỬA: Lấy Recruiter object từ session
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        Integer recruiterId = (recruiter != null) ? recruiter.getRecruiterId() : null;

        // ✅ SỬA: Security check đơn giản hơn
        if (recruiter == null || recruiterId == null) {
            response.sendRedirect("login.jsp?error=Access denied");
            return;
        }

        String candidateIdStr = request.getParameter("candidateId");
        String applicationIdStr = request.getParameter("applicationId");

        try {
            if (candidateIdStr != null) {
                int candidateId = Integer.parseInt(candidateIdStr);

                // Verify recruiter has access to this candidate
                if (!candidateProfileDAO.hasAccessToCandidate(recruiterId, candidateId)) {
                    response.sendRedirect("InterviewManager?error=Access denied to candidate information");
                    return;
                }

                // Get candidate profile
                Candidate candidate = candidateProfileDAO.getCandidateProfile(candidateId);
                if (candidate == null) {
                    response.sendRedirect("InterviewManager?error=Candidate not found");
                    return;
                }

                // Get candidate's applications for this recruiter
                if (applicationDAO != null) {
                    candidate.setApplications(
                            applicationDAO.getApplicationsByCandidateAndRecruiter(candidateId, recruiterId)
                    );
                }

                // Set attributes for JSP - NO POINTS NEEDED
                request.setAttribute("candidate", candidate);
                request.setAttribute("recruiterId", recruiterId);
                request.setAttribute("applicationId", applicationIdStr);

                // Forward to candidate profile page
                request.getRequestDispatcher("CandidateDetail.jsp").forward(request, response);

            } else {
                response.sendRedirect("InterviewManager?error=Invalid candidate ID");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("InterviewManager?error=Invalid candidate ID format");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("InterviewManager?error=Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("InterviewManager?error=Error loading candidate information");
        }
    }
}
