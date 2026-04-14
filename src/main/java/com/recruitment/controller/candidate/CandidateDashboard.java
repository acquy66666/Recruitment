/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.recruitment.controller.candidate;

import com.recruitment.dao.AdvancedSearchDAO;
import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.AssignmentDAO;
import com.recruitment.dao.InterviewDAO;
import com.recruitment.dto.JobPostWCompanyDTO;
import com.recruitment.dto.TestAssignmentDTO;
import com.recruitment.model.Candidate;
import com.recruitment.model.Interview;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
@WebServlet(name="CandidateDashboard", urlPatterns={"/CandidateDashboard"})
public class CandidateDashboard extends HttpServlet {
   
   
  
   
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
            
            
            AssignmentDAO assignmentDAO = new  AssignmentDAO();
            List<TestAssignmentDTO> assList = assignmentDAO.getTestWithAssignmentsByCandidateId(candidate.getCandidateId());
            
            ApplicationDAO applicationDAO = new ApplicationDAO();
            int applicationCount = applicationDAO.countApplicationsByCandidateId(candidate.getCandidateId());
            
            InterviewDAO interviewDAO = new InterviewDAO();
            int interviewCount = interviewDAO.countInterviewsByCandidate(candidate.getCandidateId());
            List<Interview> iList = interviewDAO.getInterviewsByCandidate(candidate.getCandidateId());
            
            AdvancedSearchDAO jobDAO = new AdvancedSearchDAO();
            List<JobPostWCompanyDTO> jobList = jobDAO.getAllJobPostWithCompany();
            
            Collections.shuffle(jobList); // xáo trộn danh sách
            List<JobPostWCompanyDTO> randomJobs = jobList.subList(0, Math.min(3, jobList.size()));
            
            int count = 0;
            for (TestAssignmentDTO testAssignmentDTO : assList) {
                count++;
            }
            
            request.setAttribute("candidate", candidate);
            request.setAttribute("jobList", randomJobs);
            request.setAttribute("interviewCount", interviewCount);
            request.setAttribute("applicationCount", applicationCount);
            request.setAttribute("interviewList", iList);
            request.setAttribute("assList", assList);
            request.setAttribute("assCount", count);
            request.getRequestDispatcher("CandidateDashboard.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CandidateDashboard.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
  
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
