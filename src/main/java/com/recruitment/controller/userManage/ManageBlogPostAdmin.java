/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.BlogPostDAO;
import com.recruitment.model.BlogPost;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name = "ManageBlogPostAdmin", urlPatterns = {"/ManageBlogPostAdmin"})
public class ManageBlogPostAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageBlogPostAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageBlogPostAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private BlogPostDAO blogPost = new BlogPostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        List<BlogPost> listBlogPost = blogPost.getAllBlogPost();
//        List<String> typeServiceList = service.getAllTypeService();
        //Phan trang
        int numAll = listBlogPost.size();
        int numPerPage = 5; // moi trang co 10
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
        var arr = blogPost.getListBlogPostByPage(listBlogPost, start, end);
        session.setAttribute("listBlogPost", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);
//        session.setAttribute("typeServiceList", typeServiceList);

        session.removeAttribute("currentTab");
        session.removeAttribute("keywordBlog");
        session.removeAttribute("typeCategory");
        session.removeAttribute("fromDateBlog");
        session.removeAttribute("toDateBlog");
        session.removeAttribute("sortBlog");
        response.sendRedirect("manageBlogPost.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String keywordBlog = request.getParameter("keywordBlog");
        String typeCategory = request.getParameter("typeCategory");
        String fromDateBlog = request.getParameter("fromDateBlog");
        String toDateBlog = request.getParameter("toDateBlog");
        String sortBlog = request.getParameter("sortBlog");

        String blogPostId = request.getParameter("blogPostId");
        String statusBlogUpdate = request.getParameter("statusBlogUpdate");
        String actionBlog = request.getParameter("actionBlog");

//        out.print("<h3>Debug Thông tin Blog</h3>");
//        out.print("<ul>");
//        out.print("<li>keywordBlog: " + keywordBlog + "</li>");
//        out.print("<li>typeCategory: " + typeCategory + "</li>");
//        out.print("<li>fromDateBlog: " + fromDateBlog + "</li>");
//        out.print("<li>toDateBlog: " + toDateBlog + "</li>");
//        out.print("<li>sortBlog: " + sortBlog + "</li>");
//        out.print("<li>blogPostId: " + blogPostId + "</li>");
//        out.print("<li>statusBlogUpdate: " + statusBlogUpdate + "</li>");
//        out.print("<li>actionBlog: " + actionBlog + "</li>");
//        out.print("</ul>");
        if (actionBlog != null && actionBlog.equals("updateBlog")) {
            boolean isActive = "1".equals(statusBlogUpdate); // "1" → true, "0" → false
            blogPost.updateIsActiveBlog(isActive, blogPostId);
            session.setAttribute("messageBlogUpdate", "Cập nhật trạng thái thành công");
        }
        if (!isValidDateRange(fromDateBlog, toDateBlog)) {
            session.setAttribute("errorBlog", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("keywordBlog", keywordBlog);
            session.setAttribute("typeCategory", typeCategory);
            session.setAttribute("fromDateBlog", fromDateBlog);
            session.setAttribute("toDateBlog", toDateBlog);
            session.setAttribute("sortBlog", sortBlog);
            response.sendRedirect("manageBlogPost.jsp");
            return;
        }
        List<BlogPost> listBlogPost = blogPost.filterBlogPostAdmin(keywordBlog, typeCategory, fromDateBlog, toDateBlog, sortBlog);
//        for (BlogPost blogPost1 : listBlogPost) {
//            out.println(blogPost1.toString());
//        }
        //Phan trang
        int numAll = listBlogPost.size();
        int numPerPage = 5; // moi trang co 10
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
        var arr = blogPost.getListBlogPostByPage(listBlogPost, start, end);
        session.setAttribute("listBlogPost", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);

        session.setAttribute("keywordBlog", keywordBlog);
        session.setAttribute("typeCategory", typeCategory);
        session.setAttribute("fromDateBlog", fromDateBlog);
        session.setAttribute("toDateBlog", toDateBlog);
        session.setAttribute("sortBlog", sortBlog);
        response.sendRedirect("manageBlogPost.jsp");
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
    }

}
