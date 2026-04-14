/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.ProfileRecruiterDAO;
import com.recruitment.dao.RecruiterDAO;
import com.recruitment.model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "EditAdminAccountRecruiter", urlPatterns = {"/EditAdminAccountRecruiter"})
public class EditAdminAccountRecruiter extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditAdminAccountRecruiter</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditAdminAccountRecruiter at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            HttpSession session = request.getSession();
            RecruiterDAO re = new RecruiterDAO();
            String recruiterID = request.getParameter("recruiterId");
            int recruiterId = Integer.parseInt(recruiterID);
            var recruiterEdit = re.getRecruiterByIdDUC(recruiterId);
            session.setAttribute("recruiterEdit", recruiterEdit);
            response.sendRedirect("adminEditAccount.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(EditAdminAccountRecruiter.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Gọi DAO để update
        HttpSession session = request.getSession();
        RecruiterDAO dao = new RecruiterDAO();

        String recruiterID = request.getParameter("recruiterId");
        int recruiterId = Integer.parseInt(recruiterID);
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String position = request.getParameter("position");
        String companyName = request.getParameter("companyName");
        String taxCode = request.getParameter("tax");
        String companyAddress = request.getParameter("companyAddress");
        String website = request.getParameter("website");
        String industry = request.getParameter("industry");
        String companyDescription = request.getParameter("companyDescription");

        List<String> errors = validateRecruiterInfo(
                recruiterId, fullName, position, phone,
                companyName, website, companyAddress,
                industry, companyDescription, taxCode
        );
        if (!errors.isEmpty()) {
            // Trả lại form với lỗi và dữ liệu cũ
            request.setAttribute("errorsAcc", errors);

            // Dữ liệu đã nhập
            Recruiter recruiter = new Recruiter();
            recruiter.setRecruiterId(recruiterId);
            recruiter.setEmail(email);
            recruiter.setFullName(fullName);
            recruiter.setPhone(phone);
            recruiter.setPosition(position);
            recruiter.setCompanyName(companyName);
            recruiter.setTaxCode(taxCode);
            recruiter.setCompanyAddress(companyAddress);
            recruiter.setWebsite(website);
            recruiter.setIndustry(industry);
            recruiter.setCompanyDescription(companyDescription);

            request.setAttribute("recruiterEdit", recruiter);

            request.getRequestDispatcher("adminEditAccount.jsp").forward(request, response);
            return;
        }
        dao.updateRecruiterById(
                recruiterId, fullName, phone, position,
                companyName, taxCode, companyAddress,
                website, industry, companyDescription
        );
        if (session.getAttribute("keywordAccount") != null
                && session.getAttribute("positionAccount") != null
                && session.getAttribute("fromDateAccount") != null
                && session.getAttribute("toDateAccount") != null
                && session.getAttribute("sortAccount") != null) {

            String keywordAccount = session.getAttribute("keywordAccount").toString();
            String positionAccount = session.getAttribute("positionAccount").toString();
            String fromDateAccount = session.getAttribute("fromDateAccount").toString();
            String toDateAccount = session.getAttribute("toDateAccount").toString();
            String sortAccount = session.getAttribute("sortAccount").toString();

            var listAllRecruitersPending = dao.filterRecruitersAccountPending(
                    keywordAccount, positionAccount, fromDateAccount, toDateAccount, sortAccount
            );
            var positionAccountList = dao.getAllRecruiterPositions();
            //Phan trang
            int numAll = listAllRecruitersPending.size();
            int numPerPage = 8; // moi trang co 10
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
            var arr = dao.getListRecruiterByPage(listAllRecruitersPending, start, end);
            session.setAttribute("listAllRecruitersPending", arr);
            session.setAttribute("num", numPage);
            session.setAttribute("page", page);

            session.setAttribute("keywordAccount", keywordAccount);
            session.setAttribute("positionAccount", positionAccount);
            session.setAttribute("fromDateAccount", fromDateAccount);
            session.setAttribute("toDateAccount", toDateAccount);
            session.setAttribute("sortAccount", sortAccount);
            session.setAttribute("positionAccountList", positionAccountList);

            session.setAttribute("messageAccount", "Cập nhật thành công");
            // Chuyển hướng hoặc thông báo thành công
            response.sendRedirect("pendingApproval.jsp");
            return;
        }
        var listAllRecruitersPending = dao.manageAllRecruitersPending();
        var positionAccountList = dao.getAllRecruiterPositions();
        int numAll = listAllRecruitersPending.size();
        int numPerPage = 8; // moi trang co 10
        int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
        int start, end;
        int page;
        String tpage = request.getParameter("page");//Lay trang page so may hien tai
        try {
            page = Integer.parseInt(tpage);
        } catch (NumberFormatException e) {
            page = 1;
        }
        start = (page - 1) * numPerPage;
        if (numPerPage * page > numAll) {
            end = numAll;
        } else {
            end = numPerPage * page;
        }
        var arr = dao.getListRecruiterByPage(listAllRecruitersPending, start, end);
        session.setAttribute("listAllRecruitersPending", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);
        session.setAttribute("positionAccountList", positionAccountList);
        session.setAttribute("messageAccount", "Cập nhật thành công");
        response.sendRedirect("pendingApproval.jsp");

    }

    private List<String> validateRecruiterInfo(int recruiterId, String fullName, String position, String phone,
            String companyName, String website, String companyAddress,
            String industry, String companyDescription, String taxCode) {
        ProfileRecruiterDAO pro = new ProfileRecruiterDAO();
        List<String> errors = new ArrayList<>();

        // ======= Thông tin cá nhân =======
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.add("Họ và tên là bắt buộc.");
        }

        if (position == null || position.trim().isEmpty()) {
            errors.add("Chức vụ là bắt buộc.");
        }

        if (phone == null || phone.trim().isEmpty()) {
            errors.add("Số điện thoại là bắt buộc.");
        } else if (!phone.matches("\\d{10,15}")) {
            errors.add("Số điện thoại phải có từ 10 đến 15 chữ số.");
        } else {
            List<Recruiter> existingRecruiters = pro.getListRecruiter();
            for (Recruiter r : existingRecruiters) {
                if (phone.equals(r.getPhone()) && r.getRecruiterId() != recruiterId) {
                    errors.add("Số điện thoại đã tồn tại.");
                    break;
                }
            }
        }
        // ======= Thông tin công ty =======
        if (companyName == null || companyName.trim().isEmpty()) {
            errors.add("Tên công ty là bắt buộc.");
        }

        // Website: không bắt buộc, nhưng nếu có thì kiểm tra định dạng
        if (website != null && !website.trim().isEmpty()) {
            String domainPattern = "^(https?://)?(www\\.)?[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}(/.*)?$";
            if (!website.trim().matches(domainPattern)) {
                errors.add("Định dạng URL trang web không hợp lệ.");
            }
        }

        // Tax code vẫn bắt buộc
        if (taxCode == null || taxCode.trim().isEmpty()) {
            errors.add("Mã số thuế là bắt buộc.");
        } else if (!taxCode.matches("\\d{10,13}")) {
            errors.add("Mã số thuế phải có từ 10 đến 13 chữ số.");
        } else {
            List<Recruiter> existingRecruiters = pro.getListRecruiter();
            for (Recruiter r : existingRecruiters) {
                if (taxCode.equals(r.getTaxCode()) && r.getRecruiterId() != recruiterId) {
                    errors.add("Mã số thuế đã tồn tại.");
                    break;
                }
            }
        }

        return errors;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
