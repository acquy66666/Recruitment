/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.recruitment.controller.recruiter;

import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.Industry;
import com.recruitment.model.JobPost;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name="ViewJobPostEdit", urlPatterns={"/ViewJobPostEdit"})
public class ViewJobPostEdit extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewJobPostEdit</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewJobPostEdit at " + request.getContextPath () + "</h1>");
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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String jobIDRequest = request.getParameter("jobId");
        JobPostingPageDAO jb = new JobPostingPageDAO();
        JobPost jobPost = jb.selectJobPostEditByID(jobIDRequest);
        List<Industry> listIndustries = jb.selectAllIndustry();
//        out.print(listIndustries.get(3).getNameIndustry());
        session.setAttribute("listIndustries", listIndustries);
        session.setAttribute("jobPost", jobPost);

//        --------------------------Gui lai du lieu ve-------------------
        String searchONE = request.getParameter("searchONE");
        String positionONE = request.getParameter("positionONE");
        String locationONE = request.getParameter("locationONE");
        String sortONE = request.getParameter("sortONE");
        String pageONE = request.getParameter("pageONE");
        String numpageONE = request.getParameter("numONE");
        // Checkbox values
        // Nhận dữ liệu từ checkbox (có thể null nếu không chọn gì)(chuyen mang sang List de xu li de hon)
        List<String> statusesONE = request.getParameterValues("statusONE") != null
                ? Arrays.asList(request.getParameterValues("statusONE"))
                : Collections.emptyList();

        List<String> jobTypesONE = request.getParameterValues("jobTypeONE") != null
                ? Arrays.asList(request.getParameterValues("jobTypeONE"))
                : Collections.emptyList();

        List<String> experienceLevelsONE = request.getParameterValues("experienceLevelONE") != null
                ? Arrays.asList(request.getParameterValues("experienceLevelONE"))
                : Collections.emptyList();

        List<String> industriesONE = request.getParameterValues("industryONE") != null
                ? Arrays.asList(request.getParameterValues("industryONE"))
                : Collections.emptyList();

//        out.println(search);
//        out.println(position);
//        out.println(locationONE);
//        out.println(sort);
//        out.println(statuses);
//        out.println(jobTypes);
//        out.println(experienceLevels);
//        out.println(industries);
//        out.println(page);
//        out.println(numpage);
        request.setAttribute("numONE", numpageONE);
        request.setAttribute("pageONE", pageONE);
        request.setAttribute("searchONE", searchONE);
        request.setAttribute("positionONE", positionONE);
        request.setAttribute("locationONE", locationONE);
        request.setAttribute("sortONE", sortONE);
//        request.setAttribute("status", status);
        request.setAttribute("selectedStatuses", statusesONE);
        request.setAttribute("selectedJobTypes", jobTypesONE);
        request.setAttribute("selectedExperienceLevels", experienceLevelsONE);
        request.setAttribute("selectedIndustries", industriesONE);
//        response.sendRedirect("EditJobPostingPage.jsp");
        request.getRequestDispatcher("EditJobPostingPage.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
