package com.recruitment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/test")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'><title>Test Page</title></head>");
        out.println("<body>");
        out.println("<h1>Server is working!</h1>");
        out.println("<p>Context Path: " + request.getContextPath() + "</p>");
        out.println("<p>Server Info: " + getServletContext().getServerInfo() + "</p>");

        // Test database connection
        try {
            com.recruitment.dao.DBcontext db = new com.recruitment.dao.DBcontext();
            if (db.c != null) {
                out.println("<p style='color:green;'>Database Connected: OK</p>");
            } else {
                out.println("<p style='color:red;'>Database Connected: FAILED (c is null)</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Database Error: " + e.getMessage() + "</p>");
        }

        out.println("<hr>");
        out.println("<h2>Quick Links:</h2>");
        out.println("<ul>");
        out.println("<li><a href='" + request.getContextPath() + "/login'>Login</a></li>");
        out.println("<li><a href='" + request.getContextPath() + "/login.jsp'>Login JSP</a></li>");
        out.println("<li><a href='" + request.getContextPath() + "/register.jsp'>Register JSP</a></li>");
        out.println("<li><a href='" + request.getContextPath() + "/HomePage.jsp'>HomePage JSP</a></li>");
        out.println("</ul>");
        out.println("</body></html>");
    }
}