/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.JobPostingPageDAO;
import com.recruitment.model.Industry;
import com.recruitment.model.JobPost;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name = "EditJobPostingPage", urlPatterns = {"/EditJobPostingPage"})
public class EditJobPostingPage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditJobPostingPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditJobPostingPage at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
//        HttpSession session = request.getSession();
//        String jobIDRequest = request.getParameter("jobId");
//        JobPostingPageDAO jb = new JobPostingPageDAO();
//        JobPost jobPost = jb.selectJobPostEditByID(jobIDRequest);
//        List<Industry> listIndustries = jb.selectAllIndustry();
//
//        session.setAttribute("listIndustries", listIndustries);
//        session.setAttribute("jobPost", jobPost);
//
////        --------------------------Gui lai du lieu ve-------------------
//        String searchONE = request.getParameter("searchONE");
//        String positionONE = request.getParameter("positionONE");
//        String locationONE = request.getParameter("locationONE");
//        String sortONE = request.getParameter("sortONE");
//        String pageONE = request.getParameter("pageONE");
//        String numpageONE = request.getParameter("numONE");
//        // Checkbox values
//        // Nhận dữ liệu từ checkbox (có thể null nếu không chọn gì)(chuyen mang sang List de xu li de hon)
//        List<String> statusesONE = request.getParameterValues("statusONE") != null
//                ? Arrays.asList(request.getParameterValues("statusONE"))
//                : Collections.emptyList();
//
//        List<String> jobTypesONE = request.getParameterValues("jobTypeONE") != null
//                ? Arrays.asList(request.getParameterValues("jobTypeONE"))
//                : Collections.emptyList();
//
//        List<String> experienceLevelsONE = request.getParameterValues("experienceLevelONE") != null
//                ? Arrays.asList(request.getParameterValues("experienceLevelONE"))
//                : Collections.emptyList();
//
//        List<String> industriesONE = request.getParameterValues("industryONE") != null
//                ? Arrays.asList(request.getParameterValues("industryONE"))
//                : Collections.emptyList();
//
//        request.setAttribute("numONE", numpageONE);
//        request.setAttribute("pageONE", pageONE);
//        request.setAttribute("searchONE", searchONE);
//        request.setAttribute("positionONE", positionONE);
//        request.setAttribute("locationONE", locationONE);
//        request.setAttribute("sortONE", sortONE);
////        request.setAttribute("status", status);
//        request.setAttribute("selectedStatuses", statusesONE);
//        request.setAttribute("selectedJobTypes", jobTypesONE);
//        request.setAttribute("selectedExperienceLevels", experienceLevelsONE);
//        request.setAttribute("selectedIndustries", industriesONE);
//
//        request.getRequestDispatcher("EditJobPostingPage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        if ((Recruiter) session.getAttribute("Recruiter") == null) {
            response.sendRedirect("login");
            return;
        }
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        String recruiterID = Integer.toString(recruiter.getRecruiterId());
//        String action = request.getParameter("action");
        String industryID = request.getParameter("industry");
        String jobId = request.getParameter("jobId");
        String jobTitle = request.getParameter("jobTitle").trim();
        String jobPosition = request.getParameter("jobPosition").trim();
        String location = request.getParameter("location");
        String jobType = request.getParameter("jobType");
        String experienceLevel = request.getParameter("experienceLevel");

        String salaryMinStr = request.getParameter("salaryMin");
        String salaryMaxStr = request.getParameter("salaryMax");
        BigDecimal salaryMin = (salaryMinStr == null || salaryMinStr.isEmpty()) ? null : new BigDecimal(salaryMinStr);
        BigDecimal salaryMax = (salaryMaxStr == null || salaryMaxStr.isEmpty()) ? null : new BigDecimal(salaryMaxStr);

        String jobDescription = request.getParameter("jobDescription");
        String requirements = request.getParameter("requirements");
        String benefits = request.getParameter("benefits");

//        String contactEmail = request.getParameter("contactEmail");
        String applicationDeadline = request.getParameter("applicationDeadline");

//        ------------------Loc phan trang------------------------
        String searchONE = request.getParameter("searchONE");
        String positionONE = request.getParameter("positionONE");
        String locationONE = request.getParameter("locationONE");
        String sortONE = request.getParameter("sortONE");
        String pageONE = request.getParameter("pageONE");
        String numpageONE = request.getParameter("numONE");
        // Checkbox values
        // Nhận dữ liệu từ checkbox (có thể null nếu không chọn gì)(chuyen mang sang List de xu li de hon)
        List<String> statusesONE = request.getParameterValues("statusONE") != null
                ? Arrays.asList(request.getParameterValues("statusONE"))
                : Collections.emptyList();

        List<String> jobTypesONE = request.getParameterValues("jobTypeONE") != null
                ? Arrays.asList(request.getParameterValues("jobTypeONE"))
                : Collections.emptyList();

        List<String> experienceLevelsONE = request.getParameterValues("experienceLevelONE") != null
                ? Arrays.asList(request.getParameterValues("experienceLevelONE"))
                : Collections.emptyList();

        List<String> industriesONE = request.getParameterValues("industryONE") != null
                ? Arrays.asList(request.getParameterValues("industryONE"))
                : Collections.emptyList();

        JobPostingPageDAO jb = new JobPostingPageDAO();
        List<String> errors = validateJobPost(
                jobTitle, jobPosition, location, jobType, experienceLevel,
                salaryMinStr, salaryMaxStr, jobDescription, requirements,
                benefits, applicationDeadline, industryID
        );

        if (!errors.isEmpty()) {
            Double salaryMinFormat = Double.parseDouble(salaryMinStr);
            Double salaryMaxFormat = Double.parseDouble(salaryMaxStr);
            request.setAttribute("errors", errors);
            request.setAttribute("jobId", jobId);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobPosition", jobPosition);
            request.setAttribute("location", location);
            request.setAttribute("jobType", jobType);
            request.setAttribute("experienceLevel", experienceLevel);
            request.setAttribute("salaryMin", formatSalary(salaryMinFormat));
            request.setAttribute("salaryMax", formatSalary(salaryMaxFormat));
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("requirements", requirements);
            request.setAttribute("benefits", benefits);
            request.setAttribute("industryID", industryID);

//             ------------------Loc phan trang------------------------
            request.setAttribute("numONE", numpageONE);
            request.setAttribute("pageONE", pageONE);
            request.setAttribute("searchONE", searchONE);
            request.setAttribute("positionONE", positionONE);
            request.setAttribute("locationONE", locationONE);
            request.setAttribute("sortONE", sortONE);
//        request.setAttribute("status", status);
            request.setAttribute("selectedStatuses", statusesONE);
            request.setAttribute("selectedJobTypes", jobTypesONE);
            request.setAttribute("selectedExperienceLevels", experienceLevelsONE);
            request.setAttribute("selectedIndustries", industriesONE);
// request.setAttribute("contactEmail", contactEmail);
            request.setAttribute("applicationDeadline", applicationDeadline);
            request.getRequestDispatcher("EditJobPostingPage.jsp").forward(request, response);
            return;

        }
        Date dealine = Date.valueOf(applicationDeadline);
        //thieu status
        jb.updateJobPosts(jobId, jobPosition, jobTitle, location, jobType, salaryMin, salaryMax, experienceLevel, jobDescription, requirements, benefits, dealine, "Pending", industryID);
//        session.setAttribute("message", "Cập nhật thành công");
////        // Ví dụ in ra console để kiểm tra
////        out.println("Job Title: " + jobTitle);
////        out.println("Job Position: " + jobPosition);
////        out.println("Location: " + location);
////        out.println("Job Type: " + jobType);
////        out.println("Experience Level: " + experienceLevel);
////        out.println("Salary Min: " + salaryMin);
////        out.println("Salary Max: " + salaryMax);
////        out.println("Job Description: " + jobDescription);
////        out.println("Requirements: " + requirements);
////        out.println("Benefits: " + benefits);
////        out.println("Contact Email: " + contactEmail);
////        out.println("Application Deadline: " + applicationDeadline);
//
//        // Sau đó bạn có thể xử lý dữ liệu, lưu vào DB, forward sang trang khác, v.v.
//        List<JobPost> listJobPost = jb.selectAllJobPostRecruiter(recruiterID);
//        session.setAttribute("listJobPost", listJobPost);

//        out.println("Test search:"+searchONE);
//        out.println("Test position:"+positionONE);
//        out.println("Test locationONE:"+locationONE);
//        out.println("Test sort:"+sortONE);
//        out.println("Test statuses:"+statusesONE);
//        out.println("Test jobTypes:"+jobTypesONE);
//        out.println("Test experienceLevels:"+experienceLevelsONE);
//        out.println("Test industries:"+industriesONE);
//        out.println("Test page:"+pageONE);
//        out.println("Test numpage:"+numpageONE);
        request.setAttribute("numONE", numpageONE);
        request.setAttribute("pageONE", pageONE);
        request.setAttribute("searchONE", searchONE);
        request.setAttribute("positionONE", positionONE);
        request.setAttribute("locationONE", locationONE);
        request.setAttribute("sortONE", sortONE);
//        request.setAttribute("status", status);
        request.setAttribute("statusONE", statusesONE);
        request.setAttribute("jobTypeONE", jobTypesONE);
        request.setAttribute("experienceLevelONE", experienceLevelsONE);
        request.setAttribute("industryONE", industriesONE);
//        --------------Gui du lieu sang doPost--------------------------------
        request.getRequestDispatcher("ManageJobPost").forward(request, response);

    }

    public String formatSalary(Double salary) {
        if (salary == null) {
            return "";
        }
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        return df.format(salary);
    }

    public List<String> validateJobPost(
            String jobTitle,
            String jobPosition,
            String location,
            String jobType,
            String experienceLevel,
            String salaryMinStr,
            String salaryMaxStr,
            String jobDescription,
            String requirements,
            String benefits,
            String applicationDeadline,
            String industryID
    ) {
        List<String> errors = new ArrayList<>();

        // Validate text fields
        if (jobTitle == null || jobTitle.trim().isEmpty()) {
            errors.add("Job title is required.");
        }
        if (jobPosition == null || jobPosition.trim().isEmpty()) {
            errors.add("Job position is required.");
        }
        if (location == null || location.trim().isEmpty()) {
            errors.add("Location is required.");
        }
        if (jobType == null || jobType.trim().isEmpty()) {
            errors.add("Job type is required.");
        }
        if (experienceLevel == null || experienceLevel.trim().isEmpty()) {
            errors.add("Experience level is required.");
        }
        if (jobDescription == null || jobDescription.trim().isEmpty()) {
            errors.add("Job description is required.");
        }
        if (requirements == null || requirements.trim().isEmpty()) {
            errors.add("Requirements are required.");
        }
        if (benefits == null || benefits.trim().isEmpty()) {
            errors.add("Benefits are required.");
        }
        if (industryID == null || industryID.trim().isEmpty()) {
            errors.add("industry are required.");
        }
//        // Validate email
//        if (contactEmail == null || contactEmail.trim().isEmpty()) {
//            errors.add("Contact email is required.");
//        } else if (!contactEmail.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
//            errors.add("Invalid email format.");
//        }

//        Validate Salary
        try {
            if (salaryMinStr != null && !salaryMinStr.isEmpty()) {
                new BigDecimal(salaryMinStr);
            }
            if (salaryMaxStr != null && !salaryMaxStr.isEmpty()) {
                new BigDecimal(salaryMaxStr);
            }
//            if (value.compareTo(BigDecimal.valueOf(100)) > 0) {
            if (salaryMinStr != null && !salaryMinStr.isEmpty() && salaryMaxStr != null && !salaryMaxStr.isEmpty()) {
                BigDecimal min = new BigDecimal(salaryMinStr);
                BigDecimal max = new BigDecimal(salaryMaxStr);
                if (min.compareTo(BigDecimal.ZERO) <= 0 || max.compareTo(BigDecimal.ZERO) <= 0) {
                    errors.add("Không được nhập lương bé hơn bằng 0");
                } else if (min.compareTo(max) >= 0) {
                    errors.add("Min luôn bé hơn Max");
                }
            }
        } catch (NumberFormatException e) {
            errors.add("Lương phải là số hợp lệ");
        }

        if (applicationDeadline == null || applicationDeadline.isEmpty()) {
            errors.add("Application deadline is required.");
        } else {
            try {
                Date dateDeadline = Date.valueOf(applicationDeadline);
                Date dateNow = Date.valueOf(LocalDate.now());
                if (!dateDeadline.after(dateNow)) {
                    errors.add("Date dealine phải ở tương lai");
                }
            } catch (IllegalArgumentException e) {
                errors.add("Vui lòng chọn Dealine.");
            }
        }
        return errors;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
