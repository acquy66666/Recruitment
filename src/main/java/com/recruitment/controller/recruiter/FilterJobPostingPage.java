/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "FilterJobPostingPage", urlPatterns = {"/FilterJobPostingPage"})
public class FilterJobPostingPage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FilterJobPostingPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FilterJobPostingPage at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        JobPostingPageDAO jb = new JobPostingPageDAO();
        HttpSession session = request.getSession();

        String search = request.getParameter("search");
        String position = request.getParameter("position");
        String location = request.getParameter("location");
        String sort = request.getParameter("sort");
//        String status = request.getParameter("status");

        // Checkbox values
        // Nhận dữ liệu từ checkbox (có thể null nếu không chọn gì)(chuyen mang sang List de xu li de hon)
        List<String> statuses = request.getParameterValues("status") != null
                ? Arrays.asList(request.getParameterValues("status"))
                : Collections.emptyList();
        
        List<String> jobTypes = request.getParameterValues("jobType") != null
                ? Arrays.asList(request.getParameterValues("jobType"))
                : Collections.emptyList();

        List<String> experienceLevels = request.getParameterValues("experienceLevel") != null
                ? Arrays.asList(request.getParameterValues("experienceLevel"))
                : Collections.emptyList();

        List<String> industries = request.getParameterValues("industry") != null
                ? Arrays.asList(request.getParameterValues("industry"))
                : Collections.emptyList();
//        out.println(search);
//        out.println(position);
//        out.println(location);
//        out.println(sort);
//        out.println(statuses);
//        out.println(jobTypes);
//        out.println(experienceLevels);
//        out.println(industries);
//        out.println("Statuses: " + Arrays.toString(statusesREQUEST));
//        out.println("Job Types: " + Arrays.toString(jobTypesREQUEST));
//        out.println("Experience Levels: " + Arrays.toString(experienceLevelsREQUEST));
//        out.println("Industries: " + Arrays.toString(industriesREQUEST));
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        String recruiterID = Integer.toString(recruiter.getRecruiterId());
        if (search != null && !search.trim().isEmpty()) {
            List<JobPost> listJobPost = jb.filterJobPostSearch(recruiterID, search.trim());
            //Phan trang
            int numPS = listJobPost.size();//lay so san pham
            int numberPage = 12; // moi trang 4 sp
            //Tinh so trang page
            int numpage = numPS / numberPage + (numPS % numberPage == 0 ? 0 : 1); //neu chia het thi ok con du thi them 1 page
//        Vong lap in ra sp tu start den end
            int start, end;
            String tpage = request.getParameter("page");//Lay trang page so may hien tai
            int page;
            try {
                page = Integer.parseInt(tpage);
            } catch (NumberFormatException e) {
                page = 1;//loi thi cho ve 1
            }

            start = (page - 1) * numberPage;
            //neu so san pham cua so trang > tong sp thi 
            if (page * numberPage > numPS) {
                end = numPS;
            } else {
                end = page * numberPage;
            }
            var arr = jb.getListJobPostByPage(listJobPost, start, end);

            request.setAttribute("listJobPost", arr);
            request.setAttribute("num", numpage);
            request.setAttribute("page", page);
            request.setAttribute("search", search);
            request.getRequestDispatcher("ManageJobPost.jsp").forward(request, response);
            return;
        }

//        List<JobPost> listJobPost = jb.filterJobPost(recruiterID, position, location, status, sort, search);
        List<JobPost> listJobPost = jb.filterJobPostAdvanced(recruiterID, position, location, statuses, jobTypes, experienceLevels, industries, sort);

//            session.setAttribute("listJobPost", listJobPost);
        //Phan trang
        int numPS = listJobPost.size();//lay so san pham
        int numberPage = 12; // moi trang 4 sp
        //Tinh so trang page
        int numpage = numPS / numberPage + (numPS % numberPage == 0 ? 0 : 1); //neu chia het thi ok con du thi them 1 page
//        Vong lap in ra sp tu start den end
        int start, end;
        String tpage = request.getParameter("page");//Lay trang page so may hien tai
        int page;
        try {
            page = Integer.parseInt(tpage);
        } catch (NumberFormatException e) {
            page = 1;//loi thi cho ve 1
        }

        start = (page - 1) * numberPage;
        //neu so san pham cua so trang > tong sp thi 
        if (page * numberPage > numPS) {
            end = numPS;
        } else {
            end = page * numberPage;
        }
        var arr = jb.getListJobPostByPage(listJobPost, start, end);

        request.setAttribute("listJobPost", arr);
        request.setAttribute("num", numpage);
        request.setAttribute("page", page);
        request.setAttribute("search", search);
        request.setAttribute("position", position);
        request.setAttribute("location", location);
        request.setAttribute("sort", sort);
//        request.setAttribute("status", status);
        request.setAttribute("selectedStatuses", statuses);
        request.setAttribute("selectedJobTypes", jobTypes);
        request.setAttribute("selectedExperienceLevels", experienceLevels);
        request.setAttribute("selectedIndustries", industries);

        request.getRequestDispatcher("ManageJobPost.jsp").forward(request, response);
//            response.sendRedirect("ManageJobPost.jsp");
//        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
//String[] arr = request.getParameterValues("status");
//List<String> list = arr != null ? Arrays.asList(arr) : Collections.emptyList();