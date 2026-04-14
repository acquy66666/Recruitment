package com.recruitment.controller.recruiter;

import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.JobPost;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "DeleteJobPostingPage", urlPatterns = {"/DeleteJobPostingPage"})
public class DeleteJobPostingPage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteJobPostingPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteJobPostingPage at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        JobPostingPageDAO jb = new JobPostingPageDAO();
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        String recruiterID = Integer.toString(recruiter.getRecruiterId());
        
        String jobId = request.getParameter("jobId");
        jb.hideJobPost(jobId);
        List<JobPost> listJobPost = jb.selectAllJobPostRecruiter(recruiterID);
        
        session.setAttribute("listJobPost", listJobPost);
        response.sendRedirect("ManageJobPost");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
