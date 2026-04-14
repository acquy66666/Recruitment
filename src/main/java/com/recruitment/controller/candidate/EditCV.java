/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.candidate;

import com.recruitment.dao.CvDAO;
import com.recruitment.model.Candidate;
import com.recruitment.model.Cv;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author hoang
 */
@WebServlet(name = "EditCV", urlPatterns = {"/EditCV"})
@MultipartConfig
public class EditCV extends HttpServlet {

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

        String rawCVId = request.getParameter("cvId");

        if (rawCVId == null || rawCVId.isEmpty()) {
            session.setAttribute("errorMessage", "CV ID ko tồn tại");
            response.sendRedirect("CandidateProfile");
        }

        int cvId = Integer.parseInt(rawCVId);
        String formattedText = "";
        CvDAO dao = new CvDAO();
        Cv cv = new Cv();
        cv = dao.getCvByCvId(cvId);
        try {
            formattedText = dao.getCvJsonById(cvId, candidateId);
        } catch (SQLException ex) {
            Logger.getLogger(EditCV.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("formattedText", formattedText);
        request.setAttribute("cvId", cvId);
        request.setAttribute("cv", cv);
        request.setAttribute("candidateId", candidateId);
        request.getRequestDispatcher("EditCV.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        if ((Candidate) session.getAttribute("Candidate") == null) {
            response.sendRedirect("login");
            return;
        }

        Map<String, String> formFields = new HashMap<>();
        for (Part part : request.getParts()) {
            String partName = part.getName();
            if (part.getContentType() == null) {
                String value = getPartAsString(part);
                if (value != null) {
                    formFields.put(partName, value.trim());
                } else {
                    formFields.put(partName, "");
                }
            }
        }

        String rawCVId = formFields.get("cvId");
        if (rawCVId == null || rawCVId.isEmpty()) {
            session.setAttribute("errorMessage", "CV ID không tồn tại");
            response.sendRedirect("CandidateProfile");
            return;
        }
        int cvId;
        try {
            cvId = Integer.parseInt(rawCVId);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "CV ID không hợp lệ");
            response.sendRedirect("CandidateProfile");
            return;
        }

        String title = formFields.get("title");
        if (title == null || title.trim().isEmpty()) {
            title = "CV chưa đặt tên";
        } else {
            title = title.trim().replaceAll("\\s+", " ");
        }

        //Ch
        CvDAO dao = new CvDAO();
        Cv cv = dao.getCvByCvId(cvId);
        String fileUrl = "";
        if (cv != null && cv.getCvUrl() != null) {
            fileUrl = cv.getCvUrl();
        }

        Part filePart = request.getPart("cvFile");
        if (filePart != null && filePart.getSize() > 0) {
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String extension = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();
            List<String> allowedExtensions = Arrays.asList(".png", ".jpg", ".jpeg", ".pdf");
            if (!allowedExtensions.contains(extension)) {
                session.setAttribute("errorMessage", "Chỉ cho phép các định dạng: PNG, JPG, JPEG, PDF.");
                response.sendRedirect("EditCV?cvId=" + cvId);
                return;
            }

            String uniqueFileName = "cv_" + System.currentTimeMillis() + "_" + UUID.randomUUID() + extension;
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File savedFile = new File(uploadPath, uniqueFileName);
            filePart.write(savedFile.getAbsolutePath());
            fileUrl = "uploads/" + uniqueFileName;
        }

        // Lưu json trường ttin 
        JSONObject personal = new JSONObject();
        String address = formFields.get("address");

        if (address != null && !address.trim().isEmpty()) {
            address = address.trim().replaceAll("\\s+", " ");
        }

        String birthdate = formFields.get("birthdate");
        birthdate = parseDateFlexible(birthdate);
        if (birthdate == null && formFields.get("birthdate") != null && !formFields.get("birthdate").isEmpty()) {
            request.setAttribute("errorMessage", "Ngày sinh không hợp lệ. Vui lòng nhập đúng định dạng dd/MM/yyyy.");
            request.setAttribute("formFields", formFields);
            request.getRequestDispatcher("EditCV.jsp").forward(request, response);
            return;
        }
        String email = formFields.get("email");
        String phone = formFields.get("phone");
        personal.put("address", address != null ? address : "");
        personal.put("birthdate", birthdate != null ? birthdate : "");
        personal.put("email", email != null ? email : "");
        personal.put("phone_number", phone != null ? phone : "");

        // Lưu vào json
        List<String> skillKeys = new ArrayList<>();
        for (String key : formFields.keySet()) {
            if (key.startsWith("skill_")) {
                skillKeys.add(key);
            }
        }

        Collections.sort(skillKeys, (a, b) -> {
            int indexA = Integer.parseInt(a.split("_")[1]);
            int indexB = Integer.parseInt(b.split("_")[1]);
            return Integer.compare(indexA, indexB);
        });

        JSONArray skills = new JSONArray();
        for (String key : skillKeys) {
            String val = formFields.get(key);
            if (val != null && !val.trim().isEmpty()) {
                val = val.trim().replaceAll("\\s+", " ");
                JSONObject obj = new JSONObject();
                obj.put("skill_name", val);
                skills.put(obj);
            }
        }

        Map<String, JSONObject> eduMap = new HashMap<>();
        for (String key : formFields.keySet()) {
            if (key.startsWith("edu_major_") || key.startsWith("edu_place_")) {
                String[] parts = key.split("_");
                String field = parts[1];
                String index = parts[2];
                String val = formFields.get(key);
                if (val != null && !val.trim().isEmpty()) {
                    val = val.trim().replaceAll("\\s+", " ");
                }
                if (!eduMap.containsKey(index)) {
                    eduMap.put(index, new JSONObject());
                }
                if (field.equals("major")) {
                    eduMap.get(index).put("major", val != null ? val : "");
                }
                if (field.equals("place")) {
                    eduMap.get(index).put("education_place", val != null ? val : "");
                }
            }
        }
        JSONArray education = new JSONArray(eduMap.values());

        Map<String, JSONObject> expMap = new HashMap<>();
        for (String key : formFields.keySet()) {
            if (key.startsWith("exp_pos_") || key.startsWith("exp_place_") || key.startsWith("exp_duration_")) {
                String[] parts = key.split("_");
                String field = parts[1];
                String index = parts[2];
                String val = formFields.get(key);
                if (val != null && !val.trim().isEmpty()) {
                    val = val.trim().replaceAll("\\s+", " ");
                }
                if (!expMap.containsKey(index)) {
                    expMap.put(index, new JSONObject());
                }
                if (field.equals("pos")) {
                    expMap.get(index).put("working_position", val != null ? val : "");
                }
                if (field.equals("place")) {
                    expMap.get(index).put("working_place", val != null ? val : "");
                }
                if (field.equals("duration")) {
                    expMap.get(index).put("working_duration", val != null ? val : "");
                }
            }
        }
        JSONArray experiences = new JSONArray(expMap.values());

        JSONObject fullCV = new JSONObject();
        fullCV.put("personal_information", personal);
        fullCV.put("skill_group", skills);
        fullCV.put("education", education);
        fullCV.put("working_experience", experiences);

        try {
            dao.updateCV(cvId, title, fullCV.toString(), fileUrl);
        } catch (SQLException ex) {
            Logger.getLogger(EditCV.class.getName()).log(Level.SEVERE, "Error updating CV with cvId: " + cvId, ex);
            session.setAttribute("errorMessage", "Lỗi khi cập nhật CV");
            response.sendRedirect("EditCV?cvId=" + cvId);
            return;
        }

        response.sendRedirect("CandidateProfile");
    }

// Helper method to read Part as String
    private String getPartAsString(Part part) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len;
        try (InputStream is = part.getInputStream()) {
            while ((len = is.read(buffer)) != -1) {
                baos.write(buffer, 0, len);
            }
        }
        return baos.toString("UTF-8");
    }

    public static String parseDateFlexible(String input) {
        if (input == null || input.trim().isEmpty()) {
            return null;
        }
        String[] patterns = {
            "yyyy-MM-dd",
            "dd-MM-yyyy",
            "MM/dd/yyyy",
            "dd/MM/yyyy",
            "yyyy/MM/dd",
            "MM.dd.yyyy",
            "dd.MM.yyyy",
            "MM|dd|yyyy",
            "dd|MM|yyyy"
        };

        for (String pattern : patterns) {
            try {
                SimpleDateFormat parser = new SimpleDateFormat(pattern);
                parser.setLenient(false);
                Date date = parser.parse(input);

                // Trả về dạng dd/MM/yyyy
                SimpleDateFormat output = new SimpleDateFormat("dd/MM/yyyy");
                return output.format(date);
            } catch (ParseException ignored) {
            }
        }

        return null;
    }

}
