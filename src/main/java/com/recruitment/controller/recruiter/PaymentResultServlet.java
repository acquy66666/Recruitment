package com.recruitment.controller.recruiter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "PaymentResultServlet", urlPatterns = {"/paymentResult"})
public class PaymentResultServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String status = request.getParameter("status");
        out.println("<!DOCTYPE html><html><head><title>Payment Result</title></head><body>");
        out.println("<h1>Payment Result</h1>");
        out.println("<p>Status: " + (status != null ? status : "unknown") + "</p>");
        if ("error".equals(status)) {
            out.println("<p>Error occurred. Please try again or contact support.</p>");
        } else if ("success".equals(status)) {
            out.println("<p>Payment successful! Thank you.</p>");
        }
        out.println("</body></html>");
        out.close();
    }
}
