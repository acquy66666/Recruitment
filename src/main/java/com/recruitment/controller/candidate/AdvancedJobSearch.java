package com.recruitment.controller.candidate;

import com.recruitment.dao.AdvancedSearchDAO;
import com.recruitment.dto.JobPostWCompanyDTO;
import com.recruitment.model.Industry;
import com.recruitment.model.JobPost;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdvancedJobSearch", urlPatterns = {"/AdvancedJobSearch"})
public class AdvancedJobSearch extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AdvancedSearchDAO advancedSearchDAO = new AdvancedSearchDAO();

        List<JobPost> filterJobTypeList = advancedSearchDAO.getFilterJobTypeList();
        List<JobPost> filterJobExpList = advancedSearchDAO.getFilterJobExpList();
        List<Industry> industry = advancedSearchDAO.getFilterIndustryList();
        List<JobPost> location = advancedSearchDAO.getFilterLocationList();

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

        List<JobPostWCompanyDTO> jobList = advancedSearchDAO.filterJobPosts(
                jobType, expLevel, salaryMin, salaryMax, sort, searchQuery, industId, getLocation, page, pageSize);

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

        request.getRequestDispatcher("AdvancedJobSearch.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Candidate Advanced Job Search";
    }
    
//    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
//            searchQuery = searchQuery.trim().replaceAll("\\s+", " ");
//        }
}
