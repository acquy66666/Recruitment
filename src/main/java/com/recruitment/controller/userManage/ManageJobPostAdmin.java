/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.AdminDAO;
import com.recruitment.model.JobPost;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet(name = "ManageJobPostAdmin", urlPatterns = {"/ManageJobPostAdmin"})
public class ManageJobPostAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageJobPostAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageJobPostAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        AdminDAO admin = new AdminDAO();
        admin.updateExpiredJobPosts();
        var manageJobPost = admin.manageAllJobPost();

        //Phan trang
        int numAll = manageJobPost.size();
        int numPerPage = 10; // moi trang co 10
        int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
        int start, end;
        int page;
        String tpage = request.getParameter("page");//Lay trang page so may hien tai
        try {
            page = Integer.parseInt(tpage);
        } catch (NumberFormatException e) {
            page = 1;
        }
        start = (page - 1) * numPerPage;
        if (numPerPage * page > numAll) {
            end = numAll;
        } else {
            end = numPerPage * page;
        }
        var arr = admin.getListJobPostByPage(manageJobPost, start, end);
        session.setAttribute("manageJobPost", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);
        session.setAttribute("editJob", "normal");
        session.setAttribute("currentTab", "all");

        session.removeAttribute("keyword");
        session.removeAttribute("status");
        session.removeAttribute("fromDate");
        session.removeAttribute("toDate");
        session.removeAttribute("sort");
//        for (JobPost jobPost : manageJobPost) {
//            response.getWriter().println(jobPost.getJobId());
//            response.getWriter().println(jobPost.getTitle());
//            response.getWriter().println(jobPost.getStatus());
//            response.getWriter().println(jobPost.getCreatedAt());
//            response.getWriter().println(jobPost.getRecruiter().getCompanyName());
//            response.getWriter().println(jobPost.getRecruiter().getEmail());
//        }
        response.sendRedirect("managePosts.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        AdminDAO admin = new AdminDAO();
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String sort = request.getParameter("sort");

        String jobId = request.getParameter("jobId");
        String statusUpdate = request.getParameter("statusUpdate");
        String action = request.getParameter("action");
        if (action != null && action.equals("updateStatus")) {
            admin.updateStatusJobPostsNew(statusUpdate, jobId);
            session.setAttribute("message", "Cập nhật trạng thái thành công");
        }
//        response.getWriter().println(keyword);
//        response.getWriter().println(status);
//        response.getWriter().println(fromDate);
//        response.getWriter().println(toDate);
//        response.getWriter().println(sort);
        if (!isValidDateRange(fromDate, toDate)) {
            session.setAttribute("errorJobPost", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("keyword", keyword);
            session.setAttribute("status", status);
            session.setAttribute("fromDate", fromDate);
            session.setAttribute("toDate", toDate);
            session.setAttribute("sort", sort);
            response.sendRedirect("managePosts.jsp");
            return;
        }
        var manageJobPost = admin.filterAllJobPost(keyword, status, fromDate, toDate, sort);

        //Phan trang
        int numAll = manageJobPost.size();
        int numPerPage = 10; // moi trang co 10
        int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
        int start, end;
        int page;
        String tpage = request.getParameter("page");//Lay trang page so may hien tai
        try {
            page = Integer.parseInt(tpage);
        } catch (NumberFormatException e) {
            page = 1;
        }
        start = (page - 1) * numPerPage;
        if (numPerPage * page > numAll) {
            end = numAll;
        } else {
            end = numPerPage * page;
        }
//--------------------------------------------Phan trang dong -----------------------------------------
//        String percentStr = request.getParameter("percent");
//        int percent;
//        try {
//            percent = Integer.parseInt(percentStr);
//            if (percent <= 0 || percent > 100) {
//                percent = 20; // mặc định 20% nếu giá trị không hợp lệ
//            }
//        } catch (NumberFormatException e) {
//            percent = 20; // mặc định nếu không nhập
//        }
//
//        int numAll = manageJobPost.size();
//        int numPerPage = (int) Math.ceil(numAll * percent / 100.0);
//        if (numPerPage == 0) {
//            numPerPage = 1;
//        }
//
//        int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
//
//        int page;
//        try {
//            page = Integer.parseInt(request.getParameter("page"));
//        } catch (NumberFormatException e) {
//            page = 1;
//        }
//
//        int start = (page - 1) * numPerPage;
//        int end = Math.min(start + numPerPage, numAll);
//        session.setAttribute("percent", percent);
//-----------------------------------------------------------------------------------------------
//        int numPerPage = (int)Math.ceil(numAll * 30 / 100.0); // moi trang co 10
//------------------------------------------------------------------------------------------------

        var arr = admin.getListJobPostByPage(manageJobPost, start, end);
        session.setAttribute("manageJobPost", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);

        session.setAttribute("keyword", keyword);
        session.setAttribute("status", status);
        session.setAttribute("fromDate", fromDate);
        session.setAttribute("toDate", toDate);
        session.setAttribute("sort", sort);
        session.setAttribute("editJob", "normal");

        response.sendRedirect("managePosts.jsp");
    }

    private boolean isValidDateRange(String fromDateStr, String toDateStr) {
        if (fromDateStr == null || toDateStr == null
                || fromDateStr.isEmpty() || toDateStr.isEmpty()) {
            return true; // Nếu thiếu 1 trong 2 ngày thì không kiểm tra (hợp lệ)
        }

        try {
            LocalDate fromDate = LocalDate.parse(fromDateStr);
            LocalDate toDate = LocalDate.parse(toDateStr);
            return !toDate.isBefore(fromDate); // trả về true nếu toDate >= fromDate
        } catch (DateTimeParseException e) {
            return false; // định dạng ngày không hợp lệ
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
