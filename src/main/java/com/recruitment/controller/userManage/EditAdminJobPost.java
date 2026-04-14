/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.AdminDAO;
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
@WebServlet(name = "EditAdminJobPost", urlPatterns = {"/EditAdminJobPost"})
public class EditAdminJobPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditAdminJobPost</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditAdminJobPost at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String jobIDRequest = request.getParameter("jobId");
        JobPostingPageDAO jb = new JobPostingPageDAO();
        JobPost jobPost = jb.selectJobPostEditByID(jobIDRequest);
        List<Industry> listIndustries = jb.selectAllIndustry();
        session.setAttribute("jobPost", jobPost);
        session.setAttribute("listIndustries", listIndustries);
        response.sendRedirect("adminEditJobPost.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        AdminDAO admin = new AdminDAO();

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
        String applicationDeadline = request.getParameter("applicationDeadline");

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

            request.setAttribute("applicationDeadline", applicationDeadline);
            request.getRequestDispatcher("adminEditJobPost.jsp").forward(request, response);
            return;

        }
        Date dealine = Date.valueOf(applicationDeadline);
        //thieu status
        jb.updateJobPosts(jobId, jobPosition, jobTitle, location, jobType, salaryMin, salaryMax, experienceLevel, jobDescription, requirements, benefits, dealine, "Chờ duyệt", industryID);
        var manageJobPost = admin.manageAllJobPost();
        var listJobPostAdmin = jb.selectAllJobPostAdmin();
        session.setAttribute("message", "Cập nhật bài đăng thành công");
        String editJob = session.getAttribute("editJob").toString();
//        PrintWriter out = response.getWriter();
//        checkSessionAttributes(session, out, "num", "page", "keyword", "status", "fromDate", "toDate", "sort");
        if (editJob.equals("normal")
                && session.getAttribute("keyword") == null && session.getAttribute("status") == null
                && session.getAttribute("fromDate") == null && session.getAttribute("toDate") == null
                && session.getAttribute("sort") == null) {
            //Phan trang
            int numAll = manageJobPost.size();
            int numPerPage = 10; // moi trang co 10
            int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
            int start, end;
            int page;
            Object tpage = session.getAttribute("page");//Lay trang page so may hien tai
            try {
                page = Integer.parseInt(tpage.toString());
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
            response.sendRedirect("managePosts.jsp");
            return;
        }
        if (editJob.equals("normal")
                && session.getAttribute("keyword") != null && session.getAttribute("status") != null
                && session.getAttribute("fromDate") != null && session.getAttribute("toDate") != null
                && session.getAttribute("sort") != null) {
            String keyword = session.getAttribute("keyword").toString();
            String status = session.getAttribute("status").toString();
            String fromDate = session.getAttribute("fromDate").toString();
            String toDate = session.getAttribute("toDate").toString();
            String sort = session.getAttribute("sort").toString();

//            String jobIdE = session.getAttribute("jobId").toString();
//            String statusUpdate = session.getAttribute("statusUpdate").toString();
//            String action = request.getParameter("action");
//            if (action != null && action.equals("updateStatus")) {
//                admin.updateStatusJobPosts(statusUpdate, jobId);
//                session.setAttribute("message", "Cập nhật trạng thái thành công");
//            }
//        response.getWriter().println(keyword);
//        response.getWriter().println(status);
//        response.getWriter().println(fromDate);
//        response.getWriter().println(toDate);
//        response.getWriter().println(sort);
            var manageJobPostFilter = admin.filterAllJobPost(keyword, status, fromDate, toDate, sort);
            //Phan trang
            int numAll = manageJobPostFilter.size();
            int numPerPage = 10; // moi trang co 10
            int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
            int start, end;
            int page;
            Object tpage = session.getAttribute("page");
            try {
                page = Integer.parseInt(tpage.toString());
            } catch (NumberFormatException e) {
                page = 1;
            }
            start = (page - 1) * numPerPage;
            if (numPerPage * page > numAll) {
                end = numAll;
            } else {
                end = numPerPage * page;
            }
            var arr = admin.getListJobPostByPage(manageJobPostFilter, start, end);
            session.setAttribute("manageJobPost", arr);
            response.sendRedirect("managePosts.jsp");
            return;
        }
//        session.removeAttribute("search");
//        session.removeAttribute("position");
//        session.removeAttribute("location");
//        session.removeAttribute("sort");
//        session.removeAttribute("selectedStatuses");
//        session.removeAttribute("selectedJobTypes");
//        session.removeAttribute("selectedExperienceLevels");
//        session.removeAttribute("selectedIndustries");
        if (editJob.equals("advanced")
                && session.getAttribute("search") == null
                && session.getAttribute("position") == null
                && session.getAttribute("location") == null
                && session.getAttribute("sort") == null
                && session.getAttribute("selectedStatuses") == null
                && session.getAttribute("selectedJobTypes") == null
                && session.getAttribute("selectedExperienceLevels") == null
                && session.getAttribute("selectedIndustries") == null) {
            //Phan trang
            int numPS = listJobPostAdmin.size();//lay so san pham
            int numberPage = 10; // moi trang 4 sp
            //Tinh so trang page
            int numpage = numPS / numberPage + (numPS % numberPage == 0 ? 0 : 1); //neu chia het thi ok con du thi them 1 page
//        Vong lap in ra sp tu start den end
            int start, end;
            Object tpage = session.getAttribute("page");//Lay trang page so may hien tai
            int page;
            try {
                page = Integer.parseInt(tpage.toString());
            } catch (NumberFormatException e) {
                page = 1;//loi thi cho ve 1
            }

            start = (page - 1) * numberPage;
            //neu so san pham cua so trang > tong sp thi 
            if (page * numberPage > numPS) {
                end = numPS;
            } else {
                end = page * numberPage;
            }
            var arr = jb.getListJobPostByPage(listJobPostAdmin, start, end);

            session.setAttribute("listJobPostAdmin", arr);
            response.sendRedirect("adminFilterAdvanced.jsp");
            return;
        }
        if (editJob.equals("advanced")
                && session.getAttribute("search") != null
                && session.getAttribute("position") != null
                && session.getAttribute("location") != null
                && session.getAttribute("sort") != null
                && session.getAttribute("selectedStatuses") != null
                && session.getAttribute("selectedJobTypes") != null
                && session.getAttribute("selectedExperienceLevels") != null
                && session.getAttribute("selectedIndustries") != null) {

            String search = session.getAttribute("search").toString();
            String position = session.getAttribute("position").toString();
            String locationAdvanced = session.getAttribute("location").toString();
            String sort = session.getAttribute("sort").toString();

            // Checkbox values
            // Nhận dữ liệu từ checkbox (có thể null nếu không chọn gì)(chuyen mang sang List de xu li de hon)
            List<String> statuses = session.getAttribute("selectedStatuses") != null
                    ? (List<String>) session.getAttribute("selectedStatuses")
                    : Collections.emptyList();

            List<String> jobTypes = session.getAttribute("selectedJobTypes") != null
                    ? (List<String>) session.getAttribute("selectedJobTypes")
                    : Collections.emptyList();

            List<String> experienceLevels = session.getAttribute("selectedExperienceLevels") != null
                    ? (List<String>) session.getAttribute("selectedExperienceLevels")
                    : Collections.emptyList();

            List<String> industries = session.getAttribute("selectedIndustries") != null
                    ? (List<String>) session.getAttribute("selectedIndustries")
                    : Collections.emptyList();

//            checkSessionAttributes(session, out,
//                    "search", "position", "location", "sort",
//                    "selectedStatuses", "selectedJobTypes", "selectedExperienceLevels", "selectedIndustries"
//            );
            List<JobPost> listJobPostAdminSearch = jb.filterJobPostAdvancedAdmin(position, locationAdvanced, statuses, jobTypes, experienceLevels, industries, sort, search);
            //Phan trang
            int numPS = listJobPostAdminSearch.size();//lay so san pham
            int numberPage = 10; // moi trang 4 sp
            //Tinh so trang page
            int numpage = numPS / numberPage + (numPS % numberPage == 0 ? 0 : 1); //neu chia het thi ok con du thi them 1 page
//        Vong lap in ra sp tu start den end
            int start, end;
            Object tpage = session.getAttribute("page");//Lay trang page so may hien tai
            int page;
            try {
                page = Integer.parseInt(tpage.toString());
            } catch (NumberFormatException e) {
                page = 1;//loi thi cho ve 1
            }

            start = (page - 1) * numberPage;
            //neu so san pham cua so trang > tong sp thi 
            if (page * numberPage > numPS) {
                end = numPS;
            } else {
                end = page * numberPage;
            }
            var arr = jb.getListJobPostByPage(listJobPostAdminSearch, start, end);

            session.setAttribute("listJobPostAdmin", arr);
            response.sendRedirect("adminFilterAdvanced.jsp");
            return;
        }
        if(session.getAttribute("currentTab").equals("pending") ){
            var manageJobPostFilter = admin.filterAllJobPost(null, "Chờ duyệt", null, null, null);
            //Phan trang
            int numAll = manageJobPostFilter.size();
            int numPerPage = 10; // moi trang co 10
            int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
            int start, end;
            int page;
            Object tpage = session.getAttribute("page");
            try {
                page = Integer.parseInt(tpage.toString());
            } catch (NumberFormatException e) {
                page = 1;
            }
            start = (page - 1) * numPerPage;
            if (numPerPage * page > numAll) {
                end = numAll;
            } else {
                end = numPerPage * page;
            }
            var arr = admin.getListJobPostByPage(manageJobPostFilter, start, end);
            session.setAttribute("manageJobPost", arr);
            session.setAttribute("status", "Chờ duyệt");
            response.sendRedirect("managePosts.jsp");
            return;
        }

    }

//    private void checkSessionAttributes(HttpSession session, PrintWriter out, String... keys) {
//        out.println("<div style='background:#f8f9fa; padding:10px; border:1px solid #ccc;'>");
//        for (String key : keys) {
//            Object value = session.getAttribute(key);
//            if (value == null) {
//                out.println("⚠️ Thiếu session key: <b>" + key + "</b><br>");
//            } else if (value instanceof String && ((String) value).trim().isEmpty()) {
//                out.println("⚠️ Session key: <b>" + key + "</b> có giá trị <i>rỗng</i><br>");
//            } else if (value instanceof List) {
//                List<?> list = (List<?>) value;
//                if (list.isEmpty()) {
//                    out.println("⚠️ Session key: <b>" + key + "</b> là List nhưng <i>rỗng</i><br>");
//                } else {
//                    out.println("✅ Session key: <b>" + key + "</b> = " + list + "<br>");
//                }
//            } else {
//                out.println("✅ Có session key: <b>" + key + "</b> = " + value + "<br>");
//            }
//        }
//        out.println("</div>");
//    }

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
