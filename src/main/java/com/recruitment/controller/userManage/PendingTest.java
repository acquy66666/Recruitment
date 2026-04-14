/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.TestDAO;
import com.recruitment.dto.PendingTestDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author hoang
 */
@WebServlet(name = "PendingTest", urlPatterns = {"/PendingTest"})
public class PendingTest extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession().getAttribute("Admin") == null  && request.getSession().getAttribute("Moderator") == null) {
            response.sendRedirect("login");
            return;
        }

        String search = request.getParameter("keyword");

        int pageSize = Integer.parseInt(request.getParameter("pageSize") != null ? request.getParameter("pageSize") : "10");
        int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");

        TestDAO testDAO = new TestDAO();
        List<PendingTestDTO> list = testDAO.getPendingTests(search, page, pageSize);

        request.setAttribute("list", list);
        request.setAttribute("keyword", search);
        request.getRequestDispatcher("/PendingTest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("keyword");

        int pageSize = Integer.parseInt(request.getParameter("pageSize") != null ? request.getParameter("pageSize") : "10");
        int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");

        TestDAO testDAO = new TestDAO();
        List<PendingTestDTO> list = testDAO.getPendingTests(search, page, pageSize);

        request.setAttribute("list", list);
        request.setAttribute("keyword", search);
        request.getRequestDispatcher("/PendingTest.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
