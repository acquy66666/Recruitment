/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import org.json.JSONObject;

@MultipartConfig
@WebServlet(name = "uploadImageContentJSON", urlPatterns = {"/uploadImageContentJSON"})
public class uploadImageContentJSON extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet uploadImageContentJSON</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet uploadImageContentJSON at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private static final String UPLOAD_DIR = "uploadsEditor"; // Thư mục chứa ảnh

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String contentType = request.getContentType();

        // 1. UPLOAD FILE TỪ MÁY (byFile)
        if (contentType != null && contentType.toLowerCase().startsWith("multipart/")) {
            try {
                Part filePart = request.getPart("image");
                if (filePart == null || filePart.getSize() == 0) {
                    out.write("{\"success\": 0, \"message\": \"Không có file được gửi lên.\"}");
                    return;
                }

                // Validate loại file
                String submittedFileName = filePart.getSubmittedFileName().toLowerCase();
                if (!(submittedFileName.endsWith(".jpg") || submittedFileName.endsWith(".jpeg")
                        || submittedFileName.endsWith(".png") || submittedFileName.endsWith(".gif"))) {
                    out.write("{\"success\": 0, \"message\": \"Chỉ cho phép ảnh JPG, PNG, GIF.\"}");
                    return;
                }

                // Lưu file vào thư mục
                String fileName = "img_" + System.currentTimeMillis() + "_" + submittedFileName;
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadPath + File.separator + fileName);

                // Trả về JSON thành công
                String fileUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;
                out.write("{\"success\": 1, \"file\": { \"url\": \"" + fileUrl + "\" }}");

            } catch (Exception e) {
                e.printStackTrace();
                out.write("{\"success\": 0, \"message\": \"Lỗi trong quá trình upload.\"}");
            }
            return;
        }

        // 2. UPLOAD ẢNH BẰNG URL (byUrl)
        if (contentType != null && contentType.contains("application/json")) {
            try (BufferedReader reader = request.getReader()) {
                StringBuilder jsonBuilder = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonBuilder.append(line);
                }

                JSONObject json = new JSONObject(jsonBuilder.toString());
                String imageUrl = json.getString("url");

                // Tải ảnh từ URL
                URL url = new URL(imageUrl);
                String fileExtension = imageUrl.substring(imageUrl.lastIndexOf(".")).toLowerCase();

                if (!(fileExtension.endsWith(".jpg") || fileExtension.endsWith(".jpeg")
                        || fileExtension.endsWith(".png") || fileExtension.endsWith(".gif"))) {
                    out.write("{\"success\": 0, \"message\": \"Chỉ cho phép ảnh JPG, PNG, GIF.\"}");
                    return;
                }

                String fileName = "img_" + System.currentTimeMillis() + fileExtension;
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Ghi ảnh vào server
                try (InputStream in = url.openStream(); FileOutputStream fos = new FileOutputStream(uploadPath + File.separator + fileName)) {
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = in.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }

                String fileUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;
                out.write("{\"success\": 1, \"file\": { \"url\": \"" + fileUrl + "\" }}");

            } catch (Exception e) {
                e.printStackTrace();
                out.write("{\"success\": 0, \"message\": \"Lỗi khi tải ảnh từ URL.\"}");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
