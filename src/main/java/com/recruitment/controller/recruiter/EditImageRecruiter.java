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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet(name = "EditImageRecruiter", urlPatterns = {"/EditImageRecruiter"})
public class EditImageRecruiter extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditImageRecruiter</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditImageRecruiter at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    private final String UPLOAD_DIR = "uploadsRecruiter"; // thư mục chứa ảnh    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        String recruiterID = Integer.toString(recruiter.getRecruiterId());
        String action = request.getParameter("action");

        if ("editPersonal".equals(action)) {
            Part filePart = request.getPart("imageRecruiter");//lay file anh
            if (!isValidImageFile(filePart)) {
                request.setAttribute("activeTab", "personal");
                request.setAttribute("errorIMG", "Chỉ được tải lên file ảnh (.jpg, .png, .gif)!");
                request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
                return;
            }
            //Lay ten file anh duong dan cuoi thoi vd anh1.png (co duoi .png/jpg luon) thoi k lay C:\\
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            //Tao duong dan tuyet doi tren web app de go len thay dc anh luon nhung chua co ten file
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            //Tao thu muc neu chua co
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Tạo tên file mới để tránh trùng
            String newFileName = "personal_" + recruiterID + "_" + System.currentTimeMillis() + "_" + fileName;
            //Tao duong dan de luu file vao co them ten file
            String filePath = uploadPath + File.separator + newFileName;
            filePart.write(filePath);

            //Luu duong dan vao database
            String relativePath = UPLOAD_DIR + "/" + newFileName;
            ProfileRecruiterDAO proRe = new ProfileRecruiterDAO();
            proRe.updatePersonalImg(recruiterID, relativePath);
            session.setAttribute("activeTab", "personal");
        } else if ("editCompany".equals(action)) {
            Part filePart = request.getPart("imageRecruiterCompany");
            if (!isValidImageFile(filePart)) {
                request.setAttribute("activeTab", "company");
                request.setAttribute("errorIMG", "Chỉ được tải lên file ảnh (.jpg, .png, .gif)!");
                request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
                return;
            }
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String newFileName = "company_" + recruiterID + "_" + System.currentTimeMillis() + "_" + fileName;
            String filePath = uploadPath + File.separator + newFileName;
            filePart.write(filePath);

            //Luu duong dan vao database
            String relativePath = UPLOAD_DIR + "/" + newFileName;
            ProfileRecruiterDAO proRe = new ProfileRecruiterDAO();
            proRe.updateCompanyImg(recruiterID, relativePath);
            session.setAttribute("activeTab", "company");
        }
        response.sendRedirect("EditProfileRecruiter");
    }

    public boolean isValidImageFile(Part filePart) {
        String contentType = filePart.getContentType();
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString().toLowerCase();
        return contentType != null && contentType.startsWith("image/")
                && (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")
                || fileName.endsWith(".png") || fileName.endsWith(".gif"));
    }

//                if(!isValidImageFile(filePart)){
//                 request.setAttribute("activeTab", "company");
//                 request.setAttribute("errorIMG", "Chỉ được tải lên file ảnh (.jpg, .png, .gif)!");
//                 request.getRequestDispatcher("EmployerProfile.jsp").forward(request, response);
//                 return;
//            }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
