/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.model.Candidate;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import org.json.JSONObject;

/**
 *
 * @author hoang
 */
@WebServlet(name = "AddCVManual", urlPatterns = {"/AddCVManual"})
public class AddCVManual extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }

        int candidateId = candidate.getCandidateId();

        String filePath = getServletContext().getRealPath("/cvform.json");
        System.out.println(filePath);
        File jsonFile = new File(filePath);

        if (!jsonFile.exists()) {
            response.getWriter().println("File JSON không tồn tại.");
            return;
        }

        StringBuilder jsonContent = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(new FileInputStream(jsonFile), StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonContent.append(line);
            }
        }

        JSONObject cvJson = new JSONObject(jsonContent.toString());
        request.setAttribute("formattedText", cvJson.toString(2));
        request.setAttribute("candidateId", candidateId);
        request.getRequestDispatcher("AddCVManual.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
