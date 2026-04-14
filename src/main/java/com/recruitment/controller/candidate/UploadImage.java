/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.dao.CandidateProfileDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

@WebServlet("/UploadImageServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UploadImage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    private final String UPLOAD_DIR = "uploads"; // thư mục chứa ảnh    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String candidateIdStr = request.getParameter("candidateId");
        int candidateId;

        try {
            candidateId = Integer.parseInt(candidateIdStr);
            if (candidateId <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID không hợp lệ");
            response.sendRedirect("CandidateProfile");
            return;
        }

        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            session.setAttribute("errorMessage", "Không có file được tải lên");
            response.sendRedirect("CandidateProfile");
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String contentType = filePart.getContentType();

        if (!contentType.startsWith("image/") || !fileName.matches("(?i).+\\.(jpg|jpeg|png)$")) {
            session.setAttribute("errorMessage", "Chỉ hỗ trợ ảnh JPG, JPEG, PNG");
            response.sendRedirect("CandidateProfile");
            return;
        }

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String newFileName = "avatar_" + candidateId + "_" + System.currentTimeMillis() + "_" + fileName;
        String filePath = uploadPath + File.separator + newFileName;
        filePart.write(filePath);

        String relativePath = UPLOAD_DIR + "/" + newFileName;
        CandidateProfileDAO dao = new CandidateProfileDAO();
        dao.updateCandidateAvatar(candidateId, relativePath);

        response.sendRedirect("CandidateProfile");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
