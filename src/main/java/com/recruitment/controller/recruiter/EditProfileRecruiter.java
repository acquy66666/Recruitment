/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.ProfileRecruiterDAO;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name = "EditProfileRecruiter", urlPatterns = {"/EditProfileRecruiter"})
public class EditProfileRecruiter extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditProfileRecruiter</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProfileRecruiter at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        ProfileRecruiterDAO proRe = new ProfileRecruiterDAO();
        if ((Recruiter) session.getAttribute("Recruiter") == null) {
            response.sendRedirect("login");
            return;
        }
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        String recruiterID = Integer.toString(recruiter.getRecruiterId());
        Recruiter recru = proRe.getRecruiterById(recruiterID);
//        out.println(recru.getCompanyDescription());
//        out.println(recru.getIndustry());

        session.setAttribute("recruiter", recru);
        session.setAttribute("recruiterId", recruiterID);
        response.sendRedirect("EmployerProfile.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
//        String recruiterId = request.getParameter("recruiterId");
        HttpSession session = request.getSession();
        if ((Recruiter) session.getAttribute("Recruiter") == null) {
            response.sendRedirect("login");
            return;
        }
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        String recruiterID = Integer.toString(recruiter.getRecruiterId());
        ProfileRecruiterDAO proRe = new ProfileRecruiterDAO();
        // Servlet xử lý form chỉnh sửa Personal Info
        if ("editPersonal".equals(action)) {
            String fullName = request.getParameter("fullName");
            String position = request.getParameter("position");
            String phone = request.getParameter("phone");
//            String address = request.getParameter("address");
//            String imageUrl = request.getParameter("imageUrl");

            List<String> errors = validateRecruiterProfile(fullName, position, phone);

            if (!errors.isEmpty()) {
                request.setAttribute("activeTab", "personal");
                request.setAttribute("errorsPersonal", errors);

                request.setAttribute("fullName", fullName);
                request.setAttribute("position", position);
                request.setAttribute("phone", phone);
                request.setAttribute("openEditModalPerson", true); // dùng cái này để trigger mở modal

                request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
                return;
            }

            proRe.updatePersonalInfo(recruiterID, fullName, phone, position);
            request.setAttribute("messagePersonal", "Update thành công");
            session.setAttribute("activeTab", "personal");
        } else if ("editCompany".equals(action)) {
            // Servlet xử lý form chỉnh sửa Company Info
            String companyName = request.getParameter("companyName");
            String website = request.getParameter("website");
//            String companyPhone = request.getParameter("companyPhone");
            String companyAddress = request.getParameter("companyAddress");
            String industry = request.getParameter("industry");
//            String companyLogoUrl = request.getParameter("companyLogoUrl");
            String companyDescription = request.getParameter("companyDescription");
            String taxCode = request.getParameter("tax");
            List<String> errors = validateCompany(companyName, website, companyAddress, industry, companyDescription, taxCode);

            if (!errors.isEmpty()) {
                request.setAttribute("activeTab", "company");
                request.setAttribute("errorsCompany", errors);

                request.setAttribute("companyName", companyName);
                request.setAttribute("website", website);
                request.setAttribute("location", companyAddress);
                request.setAttribute("industry", industry);
                request.setAttribute("companyDescription", companyDescription);
                request.setAttribute("tax", taxCode);
                request.setAttribute("openEditModalCompany", true); // dùng cái này để trigger mở modal

                request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
                return;
            }
//            out.println("Recruiter Id: " + recruiterId + "<br>");
//            out.println("Company Name: " + companyName + "<br>");
//            out.println("Website: " + website + "<br>");
//            out.println("Company Phone: " + companyPhone + "<br>");
//            out.println("Industry: " + industry + "<br>");
//            out.println("Company Logo URL: " + companyLogoUrl + "<br>");
//            out.println("Company Description: " + companyDescription + "<br>");
            proRe.updateCompanyInfo(recruiterID, companyName, website, companyAddress, industry, companyDescription, taxCode);
            request.setAttribute("messageCompany", "Update thành công");
            session.setAttribute("activeTab", "company");
        }
        Recruiter recru = proRe.getRecruiterById(recruiterID);
        session.setAttribute("recruiter", recru);
//        response.sendRedirect("EmployerProfile.jsp");
        request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
    }

    private List<String> validateRecruiterProfile(String fullName, String position, String phone) {
        ProfileRecruiterDAO pro = new ProfileRecruiterDAO();
        List<String> errors = new ArrayList<>();

        if (fullName == null || fullName.trim().isEmpty()) {
            errors.add("Full name is required.");
        }

        if (position == null || position.trim().isEmpty()) {
            errors.add("Position is required.");
        }

        if (phone == null || phone.trim().isEmpty()) {
            errors.add("Phone number is required.");
        } else if (!phone.matches("\\d{10,15}")) {
            errors.add("Phone number must be 10–15 digits.");
        } else {
            List<Recruiter> existingRecruiters = pro.getListRecruiter();
            for (Recruiter r : existingRecruiters) {
                if (phone.equals(r.getPhone())) {
                    errors.add("Phone number already exists.");
                    break;
                }
            }
        }

//        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
//            // Chỉ kiểm tra nếu người dùng nhập URL
//            if (!imageUrl.matches("^(http|https)://.*\\.(jpg|jpeg|png|gif)$")) {
//                errors.add("Image URL personal must be a valid image link (jpg, png, gif).");
//            }
//        }
//        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
//            // Chỉ kiểm tra nếu người dùng nhập URL
//            if (!imageUrl.endsWith("jpg")) {
//                errors.add("Image URL personal must be a valid image link (jpg).");
//            }
//        }
        return errors;
    }

    private List<String> validateCompany(String companyName, String website, String companyAddress,
            String industry, String companyDescription, String taxCode) {
        ProfileRecruiterDAO pro = new ProfileRecruiterDAO();
        List<String> errors = new ArrayList<>();

        if (companyName == null || companyName.trim().isEmpty()) {
            errors.add("Company name is required.");
        }

//        if (website != null && !website.trim().isEmpty()) {
//            if (!website.matches("^(https?://)?[\\w.-]+\\.[a-z]{2,}(/.*)?$")) {
//                errors.add("Invalid website URL format.");
//            }
//        }
        if (website != null && !website.trim().isEmpty()) {
            String domainPattern = "^(https?://)?(www\\.)?[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}(/.*)?$";
            if (!website.trim().matches(domainPattern)) {
                errors.add("Invalid website URL format.");
            }
        }

        if (companyAddress == null || companyAddress.trim().isEmpty()) {
            errors.add("Company address is required.");
        }

        if (industry == null || industry.trim().isEmpty()) {
            errors.add("Industry is required.");
        }

        if (taxCode == null || taxCode.trim().isEmpty()) {
            errors.add("Tax code is required.");
        } else if (!taxCode.matches("\\d{10,13}")) {
            errors.add("Tax code must be 10–13 digits.");
        } else {
            List<Recruiter> existingRecruiters = pro.getListRecruiter();
            for (Recruiter r : existingRecruiters) {
                if (taxCode.equals(r.getTaxCode())) {
                    errors.add("Tax code already exists.");
                    break;
                }
            }
        }

//        if (companyLogoUrl != null && !companyLogoUrl.trim().isEmpty()) {
//            if (!companyLogoUrl.matches("^(https?://).+\\.(jpg|jpeg|png|gif)$")) {
//                errors.add("Logo URL must be a valid image link (jpg, png, gif).");
//            }
//        }
        if (companyDescription == null || companyDescription.trim().isEmpty()) {
            errors.add("Company description is required.");
        } else if (companyDescription.length() < 30) {
            errors.add("Company description must be at least 30 characters long.");
        }

        return errors;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
//phone = phone.replace(/'/g, "");
//phone = phone.replace("'", "");
//phone = phone.replaceAll("[^\\d]", ""); // Xóa ký tự không phải số
//                if (phone.equals(r.getPhone()) && r.getRecruiterId() != recruiterID ) {
//                    errors.add("Phone number already exists.");
//                    break;
//                }
