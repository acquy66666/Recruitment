package com.recruitment.controller.recruiter;

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

@WebServlet("/ViewContactInfo")
public class ContactInfoController extends HttpServlet {
    private CandidateProfileDAO candidateProfileDAO;

    @Override
    public void init() throws ServletException {
        candidateProfileDAO = new CandidateProfileDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        // Get recruiter info from session
        Integer recruiterId = null;
        
        // Try to get from Recruiter object first
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        if (recruiter != null) {
            recruiterId = recruiter.getRecruiterId();
        } else {
            // Fallback to separate session attributes
            String userRole = (String) session.getAttribute("userRole");
            recruiterId = (Integer) session.getAttribute("RecruiterId");
            
            if (!"RECRUITER".equals(userRole) || recruiterId == null) {
                out.print("{\"success\": false, \"message\": \"Access denied\"}");
                return;
            }
        }
        
        if (recruiterId == null) {
            out.print("{\"success\": false, \"message\": \"Access denied\"}");
            return;
        }

        String candidateIdStr = request.getParameter("candidateId");
        
        try {
            if (candidateIdStr != null && !candidateIdStr.trim().isEmpty()) {
                int candidateId = Integer.parseInt(candidateIdStr.trim());
            
                // Verify recruiter has access to this candidate
                boolean hasAccess = candidateProfileDAO.hasAccessToCandidate(recruiterId, candidateId);
                if (!hasAccess) {
                    out.print("{\"success\": false, \"message\": \"Access denied to candidate information\"}");
                    return;
                }
            
                // Get candidate profile
                Candidate candidate = candidateProfileDAO.getCandidateProfile(candidateId);
                if (candidate == null) {
                    out.print("{\"success\": false, \"message\": \"Candidate not found\"}");
                    return;
                }
            
                // Prepare contact information with null checks
                String email = "";
                String phone = "";
                String address = "";
                
                if (candidate.getEmail() != null && !candidate.getEmail().trim().isEmpty()) {
                    email = candidate.getEmail().trim();
                }
                
                if (candidate.getPhone() != null && !candidate.getPhone().trim().isEmpty()) {
                    phone = candidate.getPhone().trim();
                }
                
                if (candidate.getAddress() != null && !candidate.getAddress().trim().isEmpty()) {
                    address = candidate.getAddress().trim();
                }
            
                // Create JSON response with proper escaping
                StringBuilder jsonBuilder = new StringBuilder();
                jsonBuilder.append("{\"success\": true");
                jsonBuilder.append(", \"email\": \"").append(escapeJson(email)).append("\"");
                jsonBuilder.append(", \"phone\": \"").append(escapeJson(phone)).append("\"");
                jsonBuilder.append(", \"address\": \"").append(escapeJson(address)).append("\"");
                jsonBuilder.append("}");
            
                out.print(jsonBuilder.toString());
            
            } else {
                out.print("{\"success\": false, \"message\": \"Invalid candidate ID\"}");
            }
        
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Invalid candidate ID format\"}");
        } catch (SQLException e) {
            out.print("{\"success\": false, \"message\": \"Database error\"}");
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Error accessing contact information\"}");
        }
    }
    
    private String escapeJson(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}
