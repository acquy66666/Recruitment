/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.AdminDAO;
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
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

/**
 *
 * @author Mr Duc
 */
@WebServlet(name = "ManageAccountPending", urlPatterns = {"/ManageAccountPending"})
public class ManageAccountPending extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageAccountPending</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageAccountPending at " + request.getContextPath() + "</h1>");
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
        RecruiterDAO re = new RecruiterDAO();
        var listAllRecruitersPending = re.manageAllRecruitersPending();
        var positionAccountList = re.getAllRecruiterPositions();
        //Phan trang
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
        var arr = re.getListRecruiterByPage(listAllRecruitersPending, start, end);
        session.setAttribute("listAllRecruitersPending", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);
//        for (Recruiter recruiter : listAllRecruitersPending) {
//            out.println(recruiter.getRecruiterId());
//            out.println(recruiter.getCompanyName());
//            out.println(recruiter.getPhone());
//            out.println(recruiter.getEmail());
//            out.println(recruiter.getCreatedAt());
//        }
        session.setAttribute("positionAccountList", positionAccountList);

        session.removeAttribute("keywordAccount");
        session.removeAttribute("positionAccount");
        session.removeAttribute("fromDateAccount");
        session.removeAttribute("toDateAccount");
        session.removeAttribute("sortAccount");
        session.removeAttribute("currentTab");

        response.sendRedirect("pendingApproval.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        RecruiterDAO re = new RecruiterDAO();

        // Lấy dữ liệu từ form
        String keywordAccount = request.getParameter("keywordAccount");
        String positionAccount = request.getParameter("positionAccount");
        String fromDateAccount = request.getParameter("fromDateAccount");
        String toDateAccount = request.getParameter("toDateAccount");
        String sortAccount = request.getParameter("sortAccount");

        //update status
        String recruiterId = request.getParameter("recruiterId");
        String recruiterName = request.getParameter("recruiterName");

        String isActiveParam = request.getParameter("isActive");
        String actionAccount = request.getParameter("actionAccount");
        if (actionAccount != null && actionAccount.equals("updateActive")) {
            boolean isActive = "1".equals(isActiveParam); // chuyển thành true nếu là "1", false nếu là "0"
            re.updateRecruiterIsActive(recruiterId, isActive);
            session.setAttribute("messageAccount", "Cập nhật tài khoản " + recruiterName + " thành công");
        }
        if (!isValidDateRange(fromDateAccount, toDateAccount)) {
            session.setAttribute("errorAccount", "Ngày đến phải sau hoặc bằng ngày bắt đầu, và đúng định dạng.");
            session.setAttribute("keywordAccount", keywordAccount);
            session.setAttribute("positionAccount", positionAccount);
            session.setAttribute("fromDateAccount", fromDateAccount);
            session.setAttribute("toDateAccount", toDateAccount);
            session.setAttribute("sortAccount", sortAccount);
            response.sendRedirect("pendingApproval.jsp");
            return;
        }
        // Gọi DAO để lọc tài khoản recruiter chưa kích hoạt
        var listAllRecruitersPending = re.filterRecruitersAccountPending(
                keywordAccount, positionAccount, fromDateAccount, toDateAccount, sortAccount
        );

        //Phan trang
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
        var arr = re.getListRecruiterByPage(listAllRecruitersPending, start, end);
        session.setAttribute("listAllRecruitersPending", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);

        session.setAttribute("keywordAccount", keywordAccount);
        session.setAttribute("positionAccount", positionAccount);
        session.setAttribute("fromDateAccount", fromDateAccount);
        session.setAttribute("toDateAccount", toDateAccount);
        session.setAttribute("sortAccount", sortAccount);

        response.sendRedirect("pendingApproval.jsp");
    }

    private boolean isValidDateRange(String fromDateStr, String toDateStr) {
        if (fromDateStr == null || toDateStr == null
                || fromDateStr.isEmpty() || toDateStr.isEmpty()) {
            return true; // Nếu thiếu 1 trong 2 ngày thì không kiểm tra (hợp lệ)
        }

        try {
            LocalDate fromDate = LocalDate.parse(fromDateStr);
            LocalDate toDate = LocalDate.parse(toDateStr);
            return !toDate.isBefore(fromDate); // trả về true nếu toDate >= fromDate
        } catch (DateTimeParseException e) {
            return false; // định dạng ngày không hợp lệ
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
