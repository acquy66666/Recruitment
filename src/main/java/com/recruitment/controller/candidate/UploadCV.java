package com.recruitment.controller.candidate;

import com.recruitment.dao.CandidateProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/UploadCV")
@MultipartConfig
public class UploadCV extends HttpServlet {

    private final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            
            Part filePart = request.getPart("cvFile");
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String contentType = filePart.getContentType();

            
            if (!isAllowedContentType(contentType)) {
                session.setAttribute("errorMessage", "Chỉ cho phép file PDF, PNG, JPEG, JPG");
                response.sendRedirect("CandidateProfile");
                return;
            }

          
            String idRaw = request.getParameter("candidateId");
            if (idRaw == null || idRaw.isEmpty()) {
                session.setAttribute("errorMessage", "Thiếu mã ứng viên.");
                response.sendRedirect("CandidateProfile");
                return;
            }
            int candidateId = Integer.parseInt(idRaw);

           
            String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
            String fileName = "cv_" + candidateId + "_" + System.currentTimeMillis() + extension;

           
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            
            String fullPath = uploadPath + File.separator + fileName;
            filePart.write(fullPath);

            
            String fileUrl = UPLOAD_DIR + "/" + fileName;
            CandidateProfileDAO dao = new CandidateProfileDAO();
            dao.uploadCV(candidateId, fileUrl);

           
            session.setAttribute("errorMessage", "Upload CV thành công!");
            response.sendRedirect("CandidateProfile");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Đã xảy ra lỗi khi upload: " + e.getMessage());
            response.sendRedirect("CandidateProfile");
        }
    }

    private boolean isAllowedContentType(String contentType) {
        return contentType.equals("application/pdf")
                || contentType.equals("image/png")
                || contentType.equals("image/jpeg");
    }
}
