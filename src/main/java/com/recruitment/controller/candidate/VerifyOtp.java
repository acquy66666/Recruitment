/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.recruitment.controller.candidate;

import com.recruitment.dao.CandidateDAO;
import com.recruitment.model.Candidate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;

/**
 *
 * @author hoang
 */
@WebServlet(name="VerifyOtp", urlPatterns={"/verifyOtpCandidate"})
public class VerifyOtp extends HttpServlet {
   
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("candidateId") == null) {
            response.sendRedirect("registerCandidate");
            return;
        }
        request.getRequestDispatcher("verifyOtpCandidate.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("candidateId") == null) {
            response.sendRedirect("registerCandidate");
            return;
        }

        try {
            CandidateDAO candidateDAO = new CandidateDAO();

            // Get session attributes
            Integer candidateId = (Integer) session.getAttribute("candidateId");
            String storedOtp = (String) session.getAttribute("otpCode");
            LocalDateTime otpExpiresAt = (LocalDateTime) session.getAttribute("otpExpiresAt");

            // Get submitted OTP
            String submittedOtp = request.getParameter("otp");

            // Check if OTP is expired or invalid
            LocalDateTime now = LocalDateTime.now();
            if (otpExpiresAt == null || storedOtp == null || now.isAfter(otpExpiresAt)) {
                // OTP expired: delete account and wallet
                Candidate candidate = candidateDAO.getCandidateById(candidateId);
                if (candidate != null) {
                    candidateDAO.deleteCandidate(candidateId);
                }
                session.invalidate();
                response.sendRedirect("HomePage");
                return;
            }

            // Verify OTP
            if (!storedOtp.equals(submittedOtp)) {
                request.setAttribute("errorMessage", "Mã OTP không hợp lệ. Vui lòng nhập lại!");
                request.getRequestDispatcher("verifyOtpCandidate.jsp").forward(request, response);
                return;
            }

            // OTP valid: activate account
            candidateDAO.activateCandidate(candidateId); 

            // Clear session
            session.invalidate();

            // Redirect to success page or login
            response.sendRedirect("login");

        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("verifyOtpCandidate.jsp").forward(request, response);
        }
    }
}

