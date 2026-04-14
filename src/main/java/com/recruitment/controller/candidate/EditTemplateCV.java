package com.recruitment.controller.candidate;

import com.beust.ah.A;
import com.recruitment.dao.CvTemplateDAO;
import com.recruitment.model.Candidate;
import com.recruitment.model.CvTemplate;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
@WebServlet(name = "EditTemplateCV", urlPatterns = {"/EditTemplateCV"})
public class EditTemplateCV extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }

        String templateIdStr = request.getParameter("templateId");
        CvTemplate cvTemplate = new CvTemplate();

        if (templateIdStr != null && !templateIdStr.trim().isEmpty()) {
            try {
                int templateId = Integer.parseInt(templateIdStr.trim());

                CvTemplateDAO cvDao = new CvTemplateDAO();
                cvTemplate = cvDao.getCvTemplateByIdAndCandidateId(templateId, candidate.getCandidateId());

                request.setAttribute("templateId", templateId);

            } catch (NumberFormatException e) {
                request.setAttribute("errorMsg", "Template ID không hợp lệ.");
            }
        } else {
            request.setAttribute("errorMsg", "Bạn phải chọn một mẫu CV để chỉnh sửa.");
        }

        request.setAttribute("candidateId", candidate.getCandidateId());
        request.setAttribute("cvTemplate", cvTemplate);
        request.getRequestDispatcher("EditTemplateCV.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }
        String idStr = request.getParameter("templateId");
        String html = request.getParameter("htmlContent");
        String title = request.getParameter("title");
        
        if (idStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ");
            return;
        }
        
        if (title == null || title.trim().isEmpty()){
            title = "Mẫu CV chưa đặt tên";
        }
        
         try {
            int templateId = Integer.parseInt(idStr.trim());
            CvTemplateDAO dao = new CvTemplateDAO();
            boolean ok = dao.updateHtmlContent(templateId, candidate.getCandidateId(), html, title);

            if (!ok) {
                request.setAttribute("errorMsg", "Cập nhật thất bại: không tìm thấy hoặc không có quyền.");
                request.getRequestDispatcher("EditTemplateCV.jsp").forward(request, response);
                return;
            }
            response.sendRedirect("CandidateProfile");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Template ID không hợp lệ");
            return;
        } catch (SQLException ex) {
            Logger.getLogger(EditTemplateCV.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
