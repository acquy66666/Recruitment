package com.recruitment.controller.candidate;

import com.recruitment.dao.CandidateProfileDAO;
import com.recruitment.dao.CvDAO;
import com.recruitment.dao.CvTemplateDAO;
import com.recruitment.dao.RecruiterDAO;
import com.recruitment.model.Candidate;
import com.recruitment.model.Cv;
import com.recruitment.model.CvTemplate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "CandidateProfile", urlPatterns = {"/CandidateProfile"})
public class CandidateProfile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");

        if (candidate == null) {
            response.sendRedirect("login");
            return;
        }

        int candidateId = candidate.getCandidateId();

        CandidateProfileDAO candidateProfileDAO = new CandidateProfileDAO();
        candidate = candidateProfileDAO.getCandidateProfile(candidateId);

        String cvIdStr = request.getParameter("cvId");
        CvDAO cvDAO = new CvDAO();
        CvTemplateDAO cvTemplateDAO = new CvTemplateDAO();

        if (cvIdStr != null && !cvIdStr.trim().isEmpty()) {
            try {
                int cvId = Integer.parseInt(cvIdStr);

                boolean hasApplication = cvDAO.existsInApplication(cvId);
                boolean result = cvDAO.deleteOrHideCV(cvId);

                if (result) {
                    if (hasApplication) {
                        request.setAttribute("successMessage", "CV đã được ẩn do đã từng dùng để ứng tuyển.");
                    } else {
                        request.setAttribute("successMessage", "Xóa CV thành công.");
                    }
                } else {
                    request.setAttribute("errorMessage", "Không thể xử lý CV.");
                }

            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID CV không hợp lệ.");
            }
        }

        CandidateProfileDAO candidateDAO = new CandidateProfileDAO();
        RecruiterDAO recruiterDAO = new RecruiterDAO();
        List<String> candidatePhones = candidateDAO.getAllPhonesExcept(candidateId);
        List<String> recruiterPhones = recruiterDAO.getAllPhones();

        List<String> phoneList = new ArrayList<>();
        phoneList.addAll(candidatePhones);
        phoneList.addAll(recruiterPhones);

        List<Cv> cvList = cvDAO.getCvByCandidateId(candidateId);
        List<CvTemplate> cvTemplateList = cvTemplateDAO.getAllCvTemplatesByCandidateId(candidateId);

        // Gửi về trang JSP
        request.setAttribute("candidate", candidate);
        request.setAttribute("cvList", cvList);
        request.setAttribute("phoneList", phoneList);
        request.setAttribute("cvTemplateList", cvTemplateList);
        request.getRequestDispatcher("CandidateProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int candidateId = Integer.parseInt(request.getParameter("candidateId"));

            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String birthdateStr = request.getParameter("birthdate");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            HttpSession session = request.getSession();

            if (fullName == null || fullName.trim().isEmpty()
                    || gender == null || gender.trim().isEmpty()
                    || birthdateStr == null || birthdateStr.trim().isEmpty()
                    || phone == null || phone.trim().isEmpty()
                    || address == null || address.trim().isEmpty()) {

                session.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin.");
                response.sendRedirect("CandidateProfile");
                return;
            }

            if (!gender.equalsIgnoreCase("Male") && !gender.equalsIgnoreCase("Female")) {
                session.setAttribute("errorMessage", "Giới tính không hợp lệ.");
                response.sendRedirect("CandidateProfile");
                return;
            }

            LocalDate birthdate;
            try {
                birthdate = LocalDate.parse(birthdateStr);
                if (birthdate.isAfter(LocalDate.now())) {
                    session.setAttribute("errorMessage", "Ngày sinh không được ở tương lai.");
                    response.sendRedirect("CandidateProfile");
                    return;
                }
            } catch (Exception e) {
                session.setAttribute("errorMessage", "Ngày sinh không hợp lệ.");
                response.sendRedirect("CandidateProfile");
                return;
            }

            if (fullName != null && !fullName.trim().isEmpty()) {
                fullName = fullName.trim().replaceAll("\\s+", " ");
            }

            if (address != null && !address.trim().isEmpty()) {
                address = address.trim().replaceAll("\\s+", " ");
            }

            CandidateProfileDAO candidateDAO = new CandidateProfileDAO();

            if (candidateDAO.isPhoneDuplicateCandidate(candidateId, phone)) {
                session.setAttribute("errorMessage", "Số điện thoại đã tồn tại. Vui lòng sử dụng số khác.");
                response.sendRedirect("CandidateProfile");
                return;
            }

            RecruiterDAO recruiterDAO = new RecruiterDAO();

            if (recruiterDAO.getRecruiterByEmailOrPhone(phone) != null) {
                session.setAttribute("errorMessage", "Số điện thoại đã tồn tại. Vui lòng sử dụng số khác.");
                response.sendRedirect("CandidateProfile");
                return;
            }

            candidateDAO.updateProfile(candidateId, fullName, gender, birthdate, phone, address);

            session.setAttribute("successMessage", "Cập nhật thành công!");
            response.sendRedirect("CandidateProfile");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(CandidateProfile.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Candidate Profile Page";
    }// </editor-fold>

}
