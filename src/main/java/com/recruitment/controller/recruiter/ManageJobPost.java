/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.Industry;
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

/**
 *
 * @author Mr Duc
 */
@WebServlet(name = "ManageJobPost", urlPatterns = {"/ManageJobPost"})
public class ManageJobPost extends HttpServlet {

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
            out.println("<title>Servlet ManageJobPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageJobPost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        JobPostingPageDAO jb = new JobPostingPageDAO();
        HttpSession session = request.getSession();
        if ((Recruiter) session.getAttribute("Recruiter") == null) {
            response.sendRedirect("login");
            return;
        }
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        String recruiterID = Integer.toString(recruiter.getRecruiterId());
        List<JobPost> listJobPost = jb.selectAllJobPostRecruiter(recruiterID);
        List<Industry> listIndustries = jb.selectAllIndustry();
        session.setAttribute("listIndustries", listIndustries);

        int listtotalJobsJobPosts = jb.totalJobsJobPostsRecruiter(recruiterID);
        int listtotalJobsJobPostsActive = jb.totalJobsJobPostsRecruiterActive(recruiterID);

        List<JobPost> listPositionJobPost = jb.positionAllJobPost(recruiterID);
        List<JobPost> listLocationJobPost = jb.locationAllJobPost(recruiterID);
        List<JobPost> listStatusJobPost = jb.statusAllJobPost(recruiterID);

//        HttpSession session = request.getSession();
//        session.setAttribute("listJobPost", listJobPost);
        session.setAttribute("listPositionJobPost", listPositionJobPost);
        session.setAttribute("listLocationJobPost", listLocationJobPost);
        session.setAttribute("listStatusJobPost", listStatusJobPost);

        session.setAttribute("listtotalJobsJobPosts", listtotalJobsJobPosts);
        session.setAttribute("listtotalJobsJobPostsActive", listtotalJobsJobPostsActive);

//        int tongSoJobPost = listJobPost.size();
//        int moiTrangCo = 4;
//        int soPage = tongSoJobPost / moiTrangCo + (tongSoJobPost % moiTrangCo == 0 ? 0 : 1);
//        String tpage = request.getParameter("page");;
//        int page;
//        try{
//            page = Integer.parseInt(tpage);
//        }catch(Exception e){
//            page = 1;
//        }
//        int start = (page - 1)*moiTrangCo;
//        int end;
//        if(moiTrangCo * page > tongSoJobPost){
//            end = tongSoJobPost;
//        }else{
//            end = moiTrangCo*page;
//        }
//        var arr = jb.getListJobPostByPage(listJobPost, start, end);
//        request.setAttribute("num", soPage);
//        request.setAttribute("listJobPost", arr);
//        request.setAttribute("page", page);
//        
//        ----------------------------------------------------------------------------
        //Phan trang
        int numPS = listJobPost.size();//lay so san pham
        int numberPage = 12; // moi trang 7 sp
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
        String message = (String) session.getAttribute("message");
        if (message != null) {
            request.setAttribute("message", message);
            session.removeAttribute("message"); // 👈 xóa ngay sau khi đọc
        }
//         ----------------------------------------------------------------------------
        request.getRequestDispatcher("ManageJobPost.jsp").forward(request, response);

//        response.sendRedirect("ManageJobPost.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JobPostingPageDAO jb = new JobPostingPageDAO();
        HttpSession session = request.getSession();
        String search = request.getParameter("searchONE");
        String position = request.getParameter("positionONE");
        String location = request.getParameter("locationONE");
        String sort = request.getParameter("sortONE");
//        String status = request.getParameter("status");

        // Checkbox values
        // Nhận dữ liệu từ checkbox (có thể null nếu không chọn gì)(chuyen mang sang List de xu li de hon)
        List<String> statuses = request.getParameterValues("statusONE") != null
                ? Arrays.asList(request.getParameterValues("statusONE"))
                : Collections.emptyList();

        List<String> jobTypes = request.getParameterValues("jobTypeONE") != null
                ? Arrays.asList(request.getParameterValues("jobTypeONE"))
                : Collections.emptyList();

        List<String> experienceLevels = request.getParameterValues("experienceLevelONE") != null
                ? Arrays.asList(request.getParameterValues("experienceLevelONE"))
                : Collections.emptyList();

        List<String> industries = request.getParameterValues("industryONE") != null
                ? Arrays.asList(request.getParameterValues("industryONE"))
                : Collections.emptyList();
//        out.println(search);
//        out.println(position);
//        out.println(location);
//        out.println(sort);
//        out.println(statuses);
//        out.println(jobTypes);
//        out.println(experienceLevels);
//        out.println(industries);
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
            String tpage = request.getParameter("pageONE");//Lay trang page so may hien tai
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
            request.setAttribute("message", "Cập nhật thành công");
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
        String tpage = request.getParameter("pageONE");//Lay trang page so may hien tai
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
//        String message = (String) session.getAttribute("message");
//        if (message != null) {
            request.setAttribute("message", "Cập nhật thành công");
//            session.removeAttribute("message"); // 👈 xóa ngay sau khi đọc
//        }
        request.getRequestDispatcher("ManageJobPost.jsp").forward(request, response);
//            response.sendRedirect("ManageJobPost.jsp");
//        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

