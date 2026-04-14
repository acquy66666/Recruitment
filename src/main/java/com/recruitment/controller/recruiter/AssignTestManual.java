/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.AssignmentDAO;
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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
@WebServlet(name = "AssignTestManual", urlPatterns = {"/AssignTestManual"})
public class AssignTestManual extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

            int candidateId = Integer.parseInt(request.getParameter("candidateId"));
            int jobId = Integer.parseInt(request.getParameter("jobId"));
            int testId = Integer.parseInt(request.getParameter("testId"));
            String dueDateStr = request.getParameter("dueDate");
            String email = request.getParameter("candidateEmail");

            AssignmentDAO assignmentDAO = new AssignmentDAO();

            boolean isAssigned = false;

            isAssigned = assignmentDAO.isAssignmentExists(jobId, candidateId);

            if (isAssigned) {
                request.getSession().setAttribute("error", "Ứng viên đã tồn tại bài làm trước đó");
                response.sendRedirect("AssignmentManagement");
                return;
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime localDue = LocalDateTime.parse(dueDateStr, formatter);
            Timestamp dueDate = Timestamp.valueOf(localDue);

            if (assignmentDAO.assignTestToCandidate(testId, jobId, candidateId, dueDate)) {
                request.getSession().setAttribute("message", "Đã giao bài cho ứng viên " + email);
                response.sendRedirect("AssignmentManagement");
                return;
            } else {
                request.getSession().setAttribute("error", "Lỗi giao bài cho ứng viên");
                response.sendRedirect("AssignmentManagement");
                return;
            }

        } catch (SQLException ex) {
            Logger.getLogger(AssignTestManual.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("error", "Lỗi giao bài cho ứng viên");
            response.sendRedirect("AssignmentManagement");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
