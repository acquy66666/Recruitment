package com.recruitment.controller.recruiter;

import com.recruitment.dao.BlogPostDAO;
import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.JobPost;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "HomePage", urlPatterns = {"/HomePage"})
public class HomePage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomePage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePage at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private BlogPostDAO dao = new BlogPostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        JobPostingPageDAO jb = new JobPostingPageDAO();
        List<JobPost> listJobPost = jb.selectAllJobPostLogo();
        var blogList = dao.getListBlogPostTop3();
        var companyList = jb.selectAllCompanyLogo();
        session.setAttribute("listJobPost", listJobPost);
        session.setAttribute("listBlogHomePage", blogList);
        session.setAttribute("companyList", companyList);
        response.sendRedirect("HomePage.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        JobPostingPageDAO jb = new JobPostingPageDAO();
        PrintWriter out = response.getWriter();
        String keyWord = request.getParameter("keyWord");
        String location = request.getParameter("location");
        String jobType = request.getParameter("jobType");
        String experienceLevel = request.getParameter("experienceLevel");

        List<JobPost> listJobPostSearch = jb.SearchJobPostByJobSeeker(keyWord, jobType, experienceLevel, location);

//        out.println(keyWord);
//        out.println(location);
//        out.println(jobType);
//        out.println(experienceLevel);
        request.setAttribute("listJobPostSearch", listJobPostSearch);
        request.setAttribute("keyWord", keyWord);
        request.setAttribute("location", location);
        request.setAttribute("jobType", jobType);
        request.setAttribute("experienceLevel", experienceLevel);

        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
