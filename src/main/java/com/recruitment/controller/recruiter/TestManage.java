/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.recruiter;

import com.recruitment.dao.TestDAO;
import com.recruitment.dto.TestWithCount;
import com.recruitment.model.Recruiter;
import com.recruitment.model.Test;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 *
 * @author hoang
 */
@WebServlet(name = "TestManage", urlPatterns = {"/TestManage"})
public class TestManage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            TestDAO testDAO = new TestDAO(); // nếu constructor không có tham số OK

            HttpSession session = request.getSession();
            Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

            if (recruiter == null) {
                response.sendRedirect("login");
                return;
            }
            String searchQuery = request.getParameter("searchQuery");
            String status = request.getParameter("status");

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                searchQuery = searchQuery.trim().replaceAll("\\s+", " ");
            }

            int totalCount = testDAO.countTestByRecruiterId(recruiter.getRecruiterId());
            int acceptedCount = testDAO.countTestByRecruiterIdAndStatus(recruiter.getRecruiterId(), "Accepted");
            int pendingCount = testDAO.countTestByRecruiterIdAndStatus(recruiter.getRecruiterId(), "Pending");
            int rejectedCount = testDAO.countTestByRecruiterIdAndStatus(recruiter.getRecruiterId(), "Rejected");

            List<TestWithCount> testList = testDAO.getAllTestList(searchQuery, status, recruiter.getRecruiterId());

            request.setAttribute("totalCount", totalCount);
            request.setAttribute("acceptedCount", acceptedCount);
            request.setAttribute("pendingCount", pendingCount);
            request.setAttribute("rejectedCount", rejectedCount);
            request.setAttribute("recruiterId", recruiter.getRecruiterId());
            request.setAttribute("testList", testList);
            request.getRequestDispatcher("TestManage.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // hoặc xử lý lỗi rõ ràng hơn
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String idStr = request.getParameter("recruiterId");

        if (title != null && !title.trim().isEmpty()) {
            title = title.trim().replaceAll("\\s+", " ");
        }

        if (description != null && !description.trim().isEmpty()) {
            description = description.trim().replaceAll("\\s+", " ");
        }

        boolean success = false;

        if (idStr != null && !idStr.isEmpty()) {
            int recruiterId = Integer.parseInt(idStr);

            Test test = new Test();
            test.setTitle(title);
            test.setDescription(description);
            test.setRecruiterId(recruiterId);
            test.setCreatedAt(new Date());
            test.setStatus("None");

            TestDAO testDAO = new TestDAO();
            success = testDAO.insertTest(test);
        }

        if (success) {
            response.sendRedirect("TestManage"); // load lại danh sách
        } else {
            request.setAttribute("error", "Tạo bài test thất bại.");
            request.getRequestDispatcher("TestManage.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
