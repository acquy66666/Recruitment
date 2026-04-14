package com.recruitment.controller.candidate;

import com.recruitment.dao.CvDAO;
import com.recruitment.model.Candidate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/SaveCVServlet")
@MultipartConfig
public class SaveCVServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if ((Candidate) session.getAttribute("Candidate") == null) {
            response.sendRedirect("login");
            return;
        }
        Candidate candidate = (Candidate) session.getAttribute("Candidate");
        int candidateId = candidate.getCandidateId();

        Map<String, String[]> paramMap = request.getParameterMap();

        // 1. Thông tin cá nhân
        JSONObject personal = new JSONObject();

        String address = request.getParameter("address");
        if (address != null && !address.trim().isEmpty()) {
            address = address.trim().replaceAll("\\s+", " ");
        }
        String birthdate = request.getParameter("birthdate");
        birthdate = parseDateFlexible(birthdate);
        if (birthdate == null) {
            request.setAttribute("errorMessage", "Ngày sinh không hợp lệ. Vui lòng nhập đúng định dạng dd/MM/yyyy.");
            request.getRequestDispatcher("PreviewUploadedCV.jsp").forward(request, response);
            return;
        }

        String email = request.getParameter("email");

        String phone = request.getParameter("phone");

        personal.put("address", address);
        personal.put("birthdate", birthdate);
        personal.put("email", email);
        personal.put("phone_number", phone);

        // 2. Kỹ năng
        JSONArray skills = new JSONArray();
        for (String key : paramMap.keySet()) {
            if (key.startsWith("skill_")) {
                String val = request.getParameter(key);
                if (val != null && !val.trim().isEmpty()) {
                    val = val.trim().replaceAll("\\s+", " ");
                    JSONObject obj = new JSONObject();
                    obj.put("skill_name", val);
                    skills.put(obj);
                }
            }
        }

        // 3. Học vấn
        Map<String, JSONObject> eduMap = new HashMap<>();
        for (String key : paramMap.keySet()) {
            if (key.startsWith("edu_major_") || key.startsWith("edu_place_")) {
                String[] parts = key.split("_");
                String field = parts[1]; // major or place
                String index = parts[2];
                String val = request.getParameter(key);
                if (val != null && !val.trim().isEmpty()) {
                    val = val.trim().replaceAll("\\s+", " ");
                }
                if (!eduMap.containsKey(index)) {
                    eduMap.put(index, new JSONObject());
                }
                if (field.equals("major")) {
                    eduMap.get(index).put("major", val);
                }
                if (field.equals("place")) {
                    eduMap.get(index).put("education_place", val);
                }
            }
        }
        JSONArray education = new JSONArray(eduMap.values());

        // 4. Kinh nghiệm
        Map<String, JSONObject> expMap = new HashMap<>();
        for (String key : paramMap.keySet()) {
            if (key.startsWith("exp_pos_") || key.startsWith("exp_place_") || key.startsWith("exp_duration_")) {
                String[] parts = key.split("_");
                String field = parts[1]; // pos, place, duration
                String index = parts[2];
                String val = request.getParameter(key);
                if (val != null && !val.trim().isEmpty()) {
                    val = val.trim().replaceAll("\\s+", " ");
                }
                if (!expMap.containsKey(index)) {
                    expMap.put(index, new JSONObject());
                }
                if (field.equals("pos")) {
                    expMap.get(index).put("working_position", val);
                }
                if (field.equals("place")) {
                    expMap.get(index).put("working_place", val);
                }
                if (field.equals("duration")) {
                    expMap.get(index).put("working_duration", val);
                }
            }
        }
        JSONArray experiences = new JSONArray(expMap.values());

        
        JSONObject fullCV = new JSONObject();
        fullCV.put("personal_information", personal);
        fullCV.put("skill_group", skills);
        fullCV.put("education", education);
        fullCV.put("working_experience", experiences);

        String title = "CV chưa đặt tên";
        String fileUrl = "";
        CvDAO dao = new CvDAO();

        Part filePart = request.getPart("cvFile");
        if (filePart != null && filePart.getSize() > 0) {

            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String extension = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();

            List<String> allowedExtensions = Arrays.asList(".png", ".jpg", ".jpeg", ".pdf");
            if (!allowedExtensions.contains(extension)) {
                session.setAttribute("errorMessage", "Chỉ cho phép các định dạng: PNG, JPG, JPEG, PDF.");
                response.sendRedirect("AddCVManual");
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
        } else {
            fileUrl = request.getParameter("fileUrl");
        }

        try {
            dao.saveCV(candidateId, title, fullCV.toString(), fileUrl);
        } catch (SQLException ex) {
            Logger.getLogger(SaveCVServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("cvJson", fullCV.toString(2));
        response.sendRedirect("CandidateProfile");
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
