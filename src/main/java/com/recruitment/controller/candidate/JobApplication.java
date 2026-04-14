/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.dao.CvDAO;
import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.Application;
import com.recruitment.model.Candidate;
import com.recruitment.model.Cv;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author GBCenter
 */
@WebServlet(name = "JobApplication", urlPatterns = {"/JobApplication"})
public class JobApplication extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet JobApplication</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet JobApplication at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int jobID = Integer.parseInt(request.getParameter("jobID"));
        Candidate c = (Candidate) request.getSession().getAttribute("Candidate");
        int user = c.getCandidateId();
        JobPostingPageDAO j = new JobPostingPageDAO();
        ApplicationDAO a = new ApplicationDAO();
        CvDAO cd = new CvDAO();
        String mes = "";
        List<Cv> cvList = cd.getCvByCandidateId(user);
        List<Application> aList = a.checkApplyByJobId2(jobID, user);
        String coverLetter = request.getParameter("coverLetter");
        String cvID = request.getParameter("cv");
        response.getWriter().print(aList.size());
        if (aList.size()>0) {
            request.getRequestDispatcher("SuccessApplicationPage").forward(request, response);
        } else if (cvID == null) {
            request.setAttribute("list", cvList);
            request.getRequestDispatcher("JobApplication.jsp").forward(request, response);
        } else if (cvID.isBlank() || coverLetter.isBlank()) {
            mes = "Thiếu thông tin. Đề nghị nhập đầy đủ";
            request.setAttribute("list", cvList);
            request.setAttribute("mes", mes);
            request.getRequestDispatcher("JobApplication.jsp").forward(request, response);
        } else {
            int cv = Integer.parseInt(cvID);
            a.addApplication(user, cv, jobID, coverLetter);
            request.setAttribute("list", cvList);
            request.setAttribute("mes", mes);
            request.getRequestDispatcher("SuccessApplicationPage").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
