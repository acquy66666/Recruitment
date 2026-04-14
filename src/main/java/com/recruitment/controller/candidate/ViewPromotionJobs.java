/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.dao.AdvancedSearchDAO;
import com.recruitment.dao.JobAdvertisementDAO;
import com.recruitment.dto.JobPostWCompanyDTO;
import com.recruitment.model.Industry;
import com.recruitment.model.JobPost;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author GBCenter
 */
@WebServlet(name = "ViewPromotionJobs", urlPatterns = {"/ViewPromotionJobs"})
public class ViewPromotionJobs extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AdvancedSearchDAO advancedSearchDAO = new AdvancedSearchDAO();
        JobAdvertisementDAO jobAdDAO = new JobAdvertisementDAO();
        List<JobPost> filterJobTypeList = advancedSearchDAO.getFilterJobTypeList();
        List<JobPost> filterJobExpList = advancedSearchDAO.getFilterJobExpList();
        List<Industry> industry = advancedSearchDAO.getFilterIndustryList();
        List<JobPost> location = advancedSearchDAO.getFilterLocationList();
        List<Integer> promotedList = jobAdDAO.getJobIds();

        // Phân trang
        int page = 1;
        int pageSize = 8;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        String jobType = request.getParameter("jobType");
        String expLevel = request.getParameter("expLevel");
        String sort = request.getParameter("sort");
        String searchQuery = request.getParameter("searchQuery");
        String industryId = request.getParameter("industryId");
        String getLocation = request.getParameter("location");

        Double salaryMin = null;
        Double salaryMax = null;
        Integer industId = null;
        String err = "";

        if (industryId != null && !industryId.isEmpty()) {
            industId = Integer.parseInt(industryId);
        }

        try {
            String sMin = request.getParameter("salaryMin");
            String sMax = request.getParameter("salaryMax");
            if (sMin != null && !sMin.isEmpty()) {
                salaryMin = Double.parseDouble(sMin);
            }
            if (sMax != null && !sMax.isEmpty()) {
                salaryMax = Double.parseDouble(sMax);
            }
        } catch (NumberFormatException e) {
            err = "Vui lòng nhập số hợp lệ.";
        }

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            searchQuery = searchQuery.trim().replaceAll("\\s+", " ");
        }

        List<JobPostWCompanyDTO> jobListA = advancedSearchDAO.filterJobPosts(
                jobType, expLevel, salaryMin, salaryMax, sort, searchQuery, industId, getLocation, page, pageSize);
        List<JobPostWCompanyDTO> jobList = new ArrayList<>();
        for (Integer i : promotedList) {
            for (JobPostWCompanyDTO j : jobListA) {
                if (j.getJobPost().getJobId() == i) {
                    jobList.add(j);
                    break;
                }
            }
        }
        int filteredCount = advancedSearchDAO.countFilteredJobPosts(jobType, expLevel, salaryMin, salaryMax, searchQuery, industId, getLocation);

        int totalPages = (int) Math.ceil(filteredCount * 1.0 / pageSize);

        request.setAttribute("err", err);
        request.setAttribute("location", location);
        request.setAttribute("filteredCount", filteredCount);
        request.setAttribute("industry", industry);
        request.setAttribute("jobList", jobList);
        request.setAttribute("filterJobTypeList", filterJobTypeList);
        request.setAttribute("filterJobExpList", filterJobExpList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", pageSize);

        request.getRequestDispatcher("ViewPromotionJobs.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
