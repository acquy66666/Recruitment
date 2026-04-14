package com.recruitment.controller.candidate;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import javax.imageio.ImageIO;

import net.sourceforge.tess4j.Tesseract;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;

import org.json.*;

@WebServlet("/OCRServlet")
@MultipartConfig
public class OCRServlet extends HttpServlet {

    public static String callGeminiAPI(String ocrText) throws IOException {
        String apiKey = "AIzaSyAQRvyJkur3eMttSr9mRgMQksfehS7J3JY";
        String url = "https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=" + apiKey;

        String prompt = """
Dưới đây là nội dung CV thu được bằng OCR. Hãy trích xuất và định dạng lại theo đúng cấu trúc JSON sau:

{
              "personal_information": {
                "address": "",
                "birthdate": "",
                "email": "",
                "phone_number": ""
              },
              "skill_group": [
                { "skill_name": "" }
              ],
                "education": [
                    {
                    "major": "",
                    "education_place": ""
                    }
                ],
              "working_experience": [
                {
                  "working_duration": "",
                  "working_place": "",
                  "working_position": ""
                }
              ]
            }                                                                        

Chỉ trả về JSON (không giải thích). Nếu trường rỗng thì trả về "tên trường: (Không thể nhận diện tự động)". Dưới đây là nội dung CV:

""" + ocrText;

        String escapedPrompt = prompt.replace("\"", "\\\"");

        String jsonInput = """
        {
          "contents": [
            {
              "parts": [
                {
                  "text": "%s"
                }
              ]
            }
          ]
        }
        """.formatted(escapedPrompt);

        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(jsonInput.getBytes(StandardCharsets.UTF_8));
        }

        int status = conn.getResponseCode();
        InputStream responseStream = (status >= 200 && status < 300)
                ? conn.getInputStream()
                : conn.getErrorStream();

        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(responseStream, StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }

        return response.toString();
    }

    public static JSONObject extractFormattedJson(String geminiResponse) {
        JSONObject response = new JSONObject(geminiResponse);
        String rawText = response.getJSONArray("candidates")
                .getJSONObject(0)
                .getJSONObject("content")
                .getJSONArray("parts")
                .getJSONObject(0)
                .getString("text");

        if (rawText.startsWith("```json")) {
            rawText = rawText.replaceFirst("```json\\s*", "");
        }
        if (rawText.endsWith("```")) {
            rawText = rawText.substring(0, rawText.length() - 3).trim();
        }

        return new JSONObject(rawText);
    }

    private List<File> convertAllPagesToImages(File pdfFile) throws IOException {
        List<File> imageFiles = new ArrayList<>();
        PDDocument document = PDDocument.load(pdfFile);
        PDFRenderer renderer = new PDFRenderer(document);
        for (int i = 0; i < document.getNumberOfPages(); i++) {
            BufferedImage image = renderer.renderImageWithDPI(i, 300);
            File imageFile = new File(pdfFile.getParent(), "temp_page_" + i + ".png");
            ImageIO.write(image, "png", imageFile);
            imageFiles.add(imageFile);
        }
        document.close();
        return imageFiles;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Part filePart = request.getPart("cvFile");
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();

        List<String> allowedExtensions = Arrays.asList(".png", ".jpg", ".jpeg", ".pdf");
        if (!allowedExtensions.contains(extension)) {
            session.setAttribute("errorMessage", "Chỉ cho phép các định dạng: PNG, JPG, JPEG, PDF.");
            response.sendRedirect("CandidateProfile");
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

        String ocrText = "";

        try {
            Tesseract tesseract = new Tesseract();
           
            String tessDataPath = getServletContext().getRealPath("/tessdata");

            
            File tessDataDir = new File(tessDataPath);
           

            if (tessDataDir.exists()) {
                File[] files = tessDataDir.listFiles();
                for (File file : files) {
                    System.out.println("- " + file.getName() + " (size: " + file.length() + " bytes)");
                }
            }

            File vieFile = new File(tessDataPath, "vie.traineddata");
            System.out.println("vie.traineddata exists: " + vieFile.exists());
            System.out.println("vie.traineddata path: " + vieFile.getAbsolutePath());

            if (!vieFile.exists()) {
                throw new RuntimeException("File vie.traineddata không tồn tại!");
            }

            tesseract.setDatapath(tessDataPath);
            tesseract.setLanguage("vie");

            if (extension.equals(".pdf")) {

                List<File> imageFiles = convertAllPagesToImages(savedFile);
                StringBuilder allText = new StringBuilder();
                for (File image : imageFiles) {
                    allText.append(tesseract.doOCR(image)).append("\n--- PAGE BREAK ---\n");
                    image.delete();
                }
                ocrText = allText.toString();
            } else {

                ocrText = tesseract.doOCR(savedFile);
            }

            // Gửi sang Gemini
            String geminiResponse = callGeminiAPI(ocrText);
            JSONObject formattedJson = extractFormattedJson(geminiResponse);

            request.setAttribute("ocrText", ocrText);
            request.setAttribute("fileUrl", "uploads/" + uniqueFileName);
            request.setAttribute("formattedText", formattedJson.toString(2));
            request.getRequestDispatcher("PreviewUploadedCV.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Lỗi OCR: " + e.getMessage());
            response.sendRedirect("CandidateProfile");
            return;
        }
    }

}
