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
import java.util.List;

@WebServlet(name = "BlogListPage", urlPatterns = {"/BlogListPage"})
public class BlogListPage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BlogListPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogListPage at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private BlogPostDAO dao = new BlogPostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        var blogList = dao.getListBlogPost();
        var category = dao.getBlogCountByCategory();
        var blogListTop5 = dao.getListBlogPostTop5();

        //Phan trang
        int numAll = blogList.size();
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
        var arr = dao.getListBlogPostByPage(blogList, start, end);
        session.setAttribute("blogList", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);

        session.setAttribute("category", category);
        session.setAttribute("blogListTop5", blogListTop5);

        session.removeAttribute("keySearchListBlog");
        session.removeAttribute("sortBlogList");
        session.removeAttribute("categoryBlogPublish");
//        session.removeAttribute("page");

        response.sendRedirect("BlogListPage.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
//        var blogList = dao.getListBlogPost();
        String keySearchListBlog = request.getParameter("keySearchListBlog");
        String sortBlogList = request.getParameter("sortBlogList");
        String categoryBlogPublish = request.getParameter("categoryBlogPublish");
        List<BlogPost> blogList;
//        if (categoryBlogPublish != null && !categoryBlogPublish.isEmpty()) {
//            blogList = dao.filterBlogPostUserByCategory(categoryBlogPublish);
//            session.setAttribute("categoryBlogPublish", categoryBlogPublish);
//        } else {
//            blogList = dao.filterBlogPostUser(keySearchListBlog, sortBlogList);
//            session.removeAttribute("categoryBlogPublish");
//        }
        if (keySearchListBlog != null) {
            keySearchListBlog = keySearchListBlog.trim();
            session.setAttribute("keySearchListBlog", keySearchListBlog);
        } else {
            keySearchListBlog = (String) session.getAttribute("keySearchListBlog");
            if (keySearchListBlog == null) {
                keySearchListBlog = "";
            }
        }

        if (sortBlogList != null) {
            sortBlogList = sortBlogList.trim();
            session.setAttribute("sortBlogList", sortBlogList);
        } else {
            sortBlogList = (String) session.getAttribute("sortBlogList");
            if (sortBlogList == null) {
                sortBlogList = "";
            }
        }
        if (categoryBlogPublish != null) {
            if (categoryBlogPublish.isBlank()) {
                categoryBlogPublish = "";
                session.removeAttribute("categoryBlogPublish");
            } else {
                categoryBlogPublish = categoryBlogPublish.trim();
                session.setAttribute("categoryBlogPublish", categoryBlogPublish);
            }
        } else {
            categoryBlogPublish = (String) session.getAttribute("categoryBlogPublish");
            if (categoryBlogPublish == null) {
                categoryBlogPublish = "";
            }
        }
        blogList = dao.filterBlogPostUserNew(keySearchListBlog, sortBlogList, categoryBlogPublish);
        //Phan trang
        int numAll = blogList.size();
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
        var arr = dao.getListBlogPostByPage(blogList, start, end);
        session.setAttribute("blogList", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);

        session.setAttribute("keySearchListBlog", keySearchListBlog);
        session.setAttribute("sortBlogList", sortBlogList);

        response.sendRedirect("BlogListPage.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

