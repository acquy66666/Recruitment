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
import java.util.List;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name = "JobPostingPage", urlPatterns = {"/JobPostingPage"})
public class JobPostingPage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet JobPostingPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet JobPostingPage at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        JobPostingPageDAO jb = new JobPostingPageDAO();
        HttpSession session = request.getSession();
        if ((Recruiter) session.getAttribute("Recruiter") == null) {
            response.sendRedirect("login");
            return;
        }
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        String recruiterID = Integer.toString(recruiter.getRecruiterId());
        List<JobPost> listJobPost = jb.selectAllJobPostRecruiterInsert(recruiterID);
        List<Industry> listIndustries = jb.selectAllIndustry();
        session.setAttribute("listJobPost", listJobPost);
        session.setAttribute("listIndustries", listIndustries);
        if (request.getParameter("search") != null && !(request.getParameter("search")).isEmpty()) {
            String search = request.getParameter("search").trim();
            listJobPost = jb.searchAllJobPost(search, recruiterID);
            request.setAttribute("keyWord", search);
            request.setAttribute("listJobPost", listJobPost);

            request.getRequestDispatcher("JobPostingPage.jsp").forward(request, response);
        } else {
            response.sendRedirect("JobPostingPage.jsp");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        JobPostingPageDAO jb = new JobPostingPageDAO();
        PrintWriter out = response.getWriter();
        if ((Recruiter) session.getAttribute("Recruiter") == null) {
            response.sendRedirect("login");
            return;
        }
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        String recruiterID = Integer.toString(recruiter.getRecruiterId());

        List<JobPost> listJobPostOne = jb.selectAllJobPostRecruiterInsert(recruiterID);
        String industryID = request.getParameter("industry");
        String jobTitle = request.getParameter("jobTitle").trim();
        String jobPosition = request.getParameter("jobPosition").trim();
        String location = request.getParameter("location");
        String jobType = request.getParameter("jobType");
        String experienceLevel = request.getParameter("experienceLevel");

        String salaryMinStr = request.getParameter("salaryMin");
        String salaryMaxStr = request.getParameter("salaryMax");
        BigDecimal salaryMin = (salaryMinStr == null || salaryMinStr.isEmpty()) ? null : new BigDecimal(salaryMinStr);
        BigDecimal salaryMax = (salaryMaxStr == null || salaryMaxStr.isEmpty()) ? null : new BigDecimal(salaryMaxStr);
//        BigDecimal test = new BigDecimal(salaryMinStr);Mot lop trong Java luu duoi dang chuoi so thap phan bo nho phu thuoc vao may tinh

        String jobDescription = request.getParameter("jobDescription");
        String requirements = request.getParameter("requirements");
        String benefits = request.getParameter("benefits");

//        String contactEmail = request.getParameter("contactEmail");
        String applicationDeadline = request.getParameter("applicationDeadline");
//        Date dealine = Date.valueOf(applicationDeadline);

//        JobPostingPageDAO jb = new JobPostingPageDAO();
//        for (JobPost jobPost : listJobPostOne) {
//            if (jobPost.getTitle().equals(jobTitle.trim())) {
//                request.setAttribute("errors", "Ten tieu de da trung");
//                request.setAttribute("jobTitle", jobTitle);
//                request.setAttribute("jobPosition", jobPosition);
//                request.setAttribute("location", location);
//                request.setAttribute("jobType", jobType);
//                request.setAttribute("experienceLevel", experienceLevel);
//                request.setAttribute("salaryMin", salaryMinStr);
//                request.setAttribute("salaryMax", salaryMaxStr);
//                request.setAttribute("jobDescription", jobDescription);
//                request.setAttribute("requirements", requirements);
//                request.setAttribute("benefits", benefits);
//                request.setAttribute("industryID", industryID);
//// request.setAttribute("contactEmail", contactEmail);
//                request.setAttribute("applicationDeadline", applicationDeadline);
//                request.getRequestDispatcher("JobPostingPage.jsp").forward(request, response);
//                return;
//            }
//        }
        List<String> errors = validateJobPost(
                jobTitle, jobPosition, location, jobType, experienceLevel,
                salaryMinStr, salaryMaxStr, jobDescription, requirements,
                benefits, applicationDeadline, industryID
        );
//        out.println("<h3>Thông tin nhận được từ form:</h3>");
//        out.println("<p>Job Title: " + jobTitle + "</p>");
//        out.println("<p>Job Position: " + jobPosition + "</p>");
//        out.println("<p>Location: " + location + "</p>");
//        out.println("<p>Job Type: " + jobType + "</p>");
//        out.println("<p>Experience Level: " + experienceLevel + "</p>");
//        out.println("<p>Salary Min: " + salaryMinStr + "</p>");
//        out.println("<p>Salary Max: " + salaryMaxStr + "</p>");
//        out.println("<p>Job Description: " + jobDescription + "</p>");
//        out.println("<p>Requirements: " + requirements + "</p>");
//        out.println("<p>Benefits: " + benefits + "</p>");
//        out.println("<p>Deadline: " + applicationDeadline + "</p>");
        if (!errors.isEmpty()) {
            double salaryMinnn = Double.parseDouble(salaryMinStr);
            double salaryMaxx = Double.parseDouble(salaryMaxStr);
            request.setAttribute("errors", errors);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobPosition", jobPosition);
            request.setAttribute("location", location);
            request.setAttribute("jobType", jobType);
            request.setAttribute("experienceLevel", experienceLevel);
            request.setAttribute("salaryMin", formatSalary(salaryMinnn));
            request.setAttribute("salaryMax", formatSalary(salaryMaxx));
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("requirements", requirements);
            request.setAttribute("benefits", benefits);
            request.setAttribute("industryID", industryID);
// request.setAttribute("contactEmail", contactEmail);
            request.setAttribute("applicationDeadline", applicationDeadline);
            request.getRequestDispatcher("JobPostingPage.jsp").forward(request, response);
            return;
        }
        Date dealine = Date.valueOf(applicationDeadline);
        boolean canUseCredit = jb.subtractServiceCredit(recruiterID, "jobPost");
        if (!canUseCredit) {
            double salaryMinnn = Double.parseDouble(salaryMinStr);
            double salaryMaxx = Double.parseDouble(salaryMaxStr);
            request.setAttribute("errors", errors);
            request.setAttribute("jobTitle", jobTitle);
            request.setAttribute("jobPosition", jobPosition);
            request.setAttribute("location", location);
            request.setAttribute("jobType", jobType);
            request.setAttribute("experienceLevel", experienceLevel);
            request.setAttribute("salaryMin", formatSalary(salaryMinnn));
            request.setAttribute("salaryMax", formatSalary(salaryMaxx));
            request.setAttribute("jobDescription", jobDescription);
            request.setAttribute("requirements", requirements);
            request.setAttribute("benefits", benefits);
            request.setAttribute("industryID", industryID);
// request.setAttribute("contactEmail", contactEmail);
            request.setAttribute("applicationDeadline", applicationDeadline);
            request.setAttribute("errors", "Bạn đã hết lượt đăng bài. Vui lòng mua thêm gói dịch vụ để tiếp tục.");
            request.getRequestDispatcher("JobPostingPage.jsp").forward(request, response);
            return;
        }
        //thieu status
        jb.insertJobPosts(recruiterID, jobPosition, jobTitle, location, jobType, salaryMin, salaryMax, experienceLevel, jobDescription, requirements, benefits, dealine, "Pending", industryID);
        request.setAttribute("message", "Thêm dữ liệu thành công");
        // Sau đó bạn có thể xử lý dữ liệu, lưu vào DB, forward sang trang khác, v.v.
        List<JobPost> listJobPost = jb.selectAllJobPostRecruiterInsert(recruiterID);
        session.setAttribute("listJobPost", listJobPost);
        request.getRequestDispatcher("JobPostingPage.jsp").forward(request, response);
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
            errors.add("Tên công việc là bắt buộc.");
        } else if (jobTitle.length() < 3 || jobTitle.length() > 100) {
            errors.add("Tên công việc phải từ 3 đến 100 ký tự.");
        }
        if (jobPosition == null || jobPosition.trim().isEmpty()) {
            errors.add("Chức danh công việc là bắt buộc.");
        } else if (jobPosition.length() < 3 || jobPosition.length() > 100) {
            errors.add("Chức danh công việc phải từ 3 đến 100 ký tự.");
        }
        if (location == null || location.trim().isEmpty()) {
            errors.add("Địa điểm là bắt buộc.");
        }
        if (jobType == null || jobType.trim().isEmpty()) {
            errors.add("Loại hình công việc là bắt buộc.");
        }
        if (experienceLevel == null || experienceLevel.trim().isEmpty()) {
            errors.add("Số năm kinh nghiệm là bắt buộc.");
        }
        if (jobDescription == null || jobDescription.trim().isEmpty()) {
            errors.add("Mô tả là bắt buộc.");
        } else if (jobDescription.trim().length() < 30) {
            errors.add("Mô tả công việc phải có ít nhất 30 ký tự.");
        }
        if (requirements == null || requirements.trim().isEmpty()) {
            errors.add("Yêu cầu là bắt buộc.");
        } else if (requirements.trim().length() < 30) {
            errors.add("Yêu cầu phải có ít nhất 30 ký tự.");
        }
        if (benefits == null || benefits.trim().isEmpty()) {
            errors.add("Lợi ích là bắt buộc.");
        }
        if (industryID == null || industryID.trim().isEmpty()) {
            errors.add("Ngành nghề là bắt buộc.");
        }

//        // Validate email
//        if (contactEmail == null || contactEmail.trim().isEmpty()) {
//            errors.add("Contact email is required.");
//        } else if (!contactEmail.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
//            errors.add("Invalid email format.");
//        }
        //Validate salary
//        try {
//            if (salaryMinStr != null && !salaryMinStr.isEmpty()) {
//                new BigDecimal(salaryMinStr);
//            }
//            if (salaryMaxStr != null && !salaryMaxStr.isEmpty()) {
//                new BigDecimal(salaryMaxStr);
//            }
//
//            if (salaryMinStr != null && !salaryMinStr.isEmpty()
//                    && salaryMaxStr != null && !salaryMaxStr.isEmpty()) {
//                BigDecimal min = new BigDecimal(salaryMinStr);
//                BigDecimal max = new BigDecimal(salaryMaxStr);
//                if(min.compareTo(max) > 0){
//                   errors.add("Minimum salary cannot be greater than maximum salary."); 
//                }
//            }
//        } catch (NumberFormatException e) {
//            errors.add("Salary must be valid number");
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
                    errors.add("Khoảng giá trị không hợp lệ: Min phải nhỏ hơn Max.");
                }
            }
        } catch (NumberFormatException e) {
            errors.add("Lương phải là số hợp lệ");
        }
        //Validate Date
//        if (applicationDeadline == null || applicationDeadline.trim().isEmpty()) {
//            errors.add("Application deadline is required.");
//        } else {
//            try {
//                Date dealine = Date.valueOf(applicationDeadline);
//                Date today = Date.valueOf(LocalDate.now());
//                if (!dealine.after(today)) {
//                    errors.add("Application deadline must be in the future.");
//                }
//            } catch (IllegalArgumentException e) {
//                errors.add("Application deadline is required.");
//            }
//        }

        if (applicationDeadline == null || applicationDeadline.isEmpty()) {
            errors.add("Thời hạn là bắt buộc");
        } else {
            try {
                Date dateDeadline = Date.valueOf(applicationDeadline);
                Date dateNow = Date.valueOf(LocalDate.now());
                if (!dateDeadline.after(dateNow)) {
                    errors.add("Vui lòng chọn ngày kết thúc nằm trong tương lai.");
                }
            } catch (IllegalArgumentException e) {
                errors.add("Vui lòng chọn thời hạn.");
            }
        }

        return errors;
    }

    public String formatSalary(double salary) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        return df.format(salary);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

//    }
//--phan cach thap phan -- 
//symbols.setDecimalSeparator(',');
//DecimalFormat df = new DecimalFormat("#,##0.00", symbols);
// Sẽ in: 1.234.567,89
