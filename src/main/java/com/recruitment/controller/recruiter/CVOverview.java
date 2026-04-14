/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.recruitment.controller.recruiter;

import com.recruitment.controller.candidate.EditCV;
import com.recruitment.dao.CvDAO;
import com.recruitment.model.Cv;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebServlet(name="CVOverview", urlPatterns={"/CVOverview"})
public class CVOverview extends HttpServlet {
   
 
 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
   
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
      
        String candidateIdStr = request.getParameter("candidateId");

        String rawCVId = request.getParameter("cvId");

        if (rawCVId == null || rawCVId.isEmpty()) {
            response.sendRedirect("CVFilter");
        }

        int cvId = Integer.parseInt(rawCVId);
        int candidateId = Integer.parseInt(candidateIdStr);
        
        String formattedText = "";
        CvDAO dao = new CvDAO();
        Cv cv = new Cv();
        cv = dao.getCvByCvId(cvId);
        try {
            formattedText = dao.getCvJsonById(cvId, candidateId);
        } catch (SQLException ex) {
            Logger.getLogger(EditCV.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("formattedText", formattedText);
        request.setAttribute("cvId", cvId);
        request.setAttribute("cv", cv);
        request.setAttribute("candidateId", candidateId);
        request.getRequestDispatcher("CVOverview.jsp").forward(request, response);
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
