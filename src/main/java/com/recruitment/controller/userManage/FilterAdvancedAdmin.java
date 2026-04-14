/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.AdminDAO;
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


@WebServlet(name = "FilterAdvancedAdmin", urlPatterns = {"/FilterAdvancedAdmin"})
public class FilterAdvancedAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FilterAdvancedAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FilterAdvancedAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        JobPostingPageDAO jb = new JobPostingPageDAO();
        List<JobPost> listJobPostAdmin = jb.selectAllJobPostAdmin();
        List<Industry> listIndustries = jb.selectAllIndustry();
        List<JobPost> listPositionJobPost = jb.positionAdminJobPost();
        List<JobPost> listLocationJobPost = jb.locationAdminJobPost();
        List<JobPost> listStatusJobPost = jb.statusAdminJobPost();

        //Phan trang
        int numPS = listJobPostAdmin.size();//lay so san pham
        int numberPage = 10; // moi trang 4 sp
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
        var arr = jb.getListJobPostByPage(listJobPostAdmin, start, end);

        session.setAttribute("listJobPostAdmin", arr);
        session.setAttribute("num", numpage);
        session.setAttribute("page", page);
        session.setAttribute("listIndustries", listIndustries);
        session.setAttribute("listPositionJobPost", listPositionJobPost);
        session.setAttribute("listLocationJobPost", listLocationJobPost);
        session.setAttribute("listStatusJobPost", listStatusJobPost);
        session.setAttribute("editJob", "advanced");

        session.removeAttribute("search");
        session.removeAttribute("position");
        session.removeAttribute("location");
        session.removeAttribute("sort");
        session.removeAttribute("selectedStatuses");
        session.removeAttribute("selectedJobTypes");
        session.removeAttribute("selectedExperienceLevels");
        session.removeAttribute("selectedIndustries");

        response.sendRedirect("adminFilterAdvanced.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        JobPostingPageDAO jb = new JobPostingPageDAO();
        AdminDAO admin = new AdminDAO();
        HttpSession session = request.getSession();

        String search = request.getParameter("search");
        String position = request.getParameter("position");
        String location = request.getParameter("location");
        String sort = request.getParameter("sort");

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
        String jobId = request.getParameter("jobId");
        String statusUpdate = request.getParameter("statusUpdate");
        String action = request.getParameter("action");
        if (action != null && action.equals("updateStatus")) {
            admin.updateStatusJobPosts(statusUpdate, jobId);
            session.setAttribute("message", "Cập nhật trạng thái thành công");
        }

        List<JobPost> listJobPostAdmin = jb.filterJobPostAdvancedAdmin(position, location, statuses, jobTypes, experienceLevels, industries, sort, search);
        //Phan trang
        int numPS = listJobPostAdmin.size();//lay so san pham
        int numberPage = 10; // moi trang 4 sp
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
        var arr = jb.getListJobPostByPage(listJobPostAdmin, start, end);

        session.setAttribute("listJobPostAdmin", arr);
        session.setAttribute("num", numpage);
        session.setAttribute("page", page);
        session.setAttribute("search", search);
        session.setAttribute("position", position);
        session.setAttribute("location", location);
        session.setAttribute("sort", sort);
//        request.setAttribute("status", status);
        session.setAttribute("selectedStatuses", statuses);
        session.setAttribute("selectedJobTypes", jobTypes);
        session.setAttribute("selectedExperienceLevels", experienceLevels);
        session.setAttribute("selectedIndustries", industries);
        session.setAttribute("editJob", "advanced");

        response.sendRedirect("adminFilterAdvanced.jsp");
//        request.getRequestDispatcher("adminFilterAdvanced.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
