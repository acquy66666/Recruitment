/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.recruitment.controller.userManage;

import com.recruitment.dao.AdminDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name="PendingJobPosts", urlPatterns={"/PendingJobPosts"})
public class PendingJobPosts extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PendingJobPosts</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PendingJobPosts at " + request.getContextPath () + "</h1>");
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
//        String keyword = request.getParameter("keyword");
//        String status = request.getParameter("status");
//        String fromDate = request.getParameter("fromDate");
//        String toDate = request.getParameter("toDate");
//        String sort = request.getParameter("sort");
//        response.getWriter().println(keyword);
//        response.getWriter().println(status);
//        response.getWriter().println(fromDate);
//        response.getWriter().println(toDate);
//        response.getWriter().println(sort);

        var manageJobPost = admin.filterAllJobPost(null, "Pending", null, null, null);
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
        session.setAttribute("currentTab", "pending");

        session.setAttribute("status", "Pending");
        session.removeAttribute("keyword");
        session.removeAttribute("fromDate");
        session.removeAttribute("toDate");
        session.removeAttribute("sort");
        
        response.sendRedirect("managePosts.jsp");
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
