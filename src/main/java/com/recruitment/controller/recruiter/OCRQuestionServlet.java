package com.recruitment.controller.recruiter;

import com.recruitment.dao.QuestionDAO;
import com.recruitment.model.Question;
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

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;

import org.json.*;

@WebServlet("/OCRQuestionServlet")
@MultipartConfig
public class OCRQuestionServlet extends HttpServlet {

    public static String callGeminiAPI(String ocrText) throws IOException {
        String apiKey = "AIzaSyAQRvyJkur3eMttSr9mRgMQksfehS7J3JY";
        String url = "https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=" + apiKey;

        String prompt = """
        Dưới đây là nội dung chứa danh sách các câu hỏi trắc nghiệm thu được từ OCR.
        Hãy trích xuất từng câu hỏi và định dạng thành danh sách JSON sau:

        [
          {
            "question_text": "",
            "question_type": "multiple_choice",
            "options": ["", "", "", ""],
            "correct_answer": ""
          }
        ]

        Chỉ trả về JSON (không giải thích). Nếu không rõ đáp án thì để "correct_answer": "(Không xác định)". "correct_answer" phải để dạng đầy đủ
        Nếu ít hơn 2 đáp án thì bỏ qua câu đó. Bỏ qua các câu hỏi không phải dạng trắc nghiệm.

        Dưới đây là nội dung:
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

    public static JSONArray extractFormattedJSONArray(String geminiResponse) {
        JSONObject response = new JSONObject(geminiResponse);

        if (response.has("error")) {
            JSONObject error = response.getJSONObject("error");
            int code = error.optInt("code", -1);
            String message = error.optString("message", "Unknown error");

            throw new RuntimeException("Gemini API error " + code + ": " + message);
        }
        
        String rawText = response.getJSONArray("candidates")
                .getJSONObject(0)
                .getJSONObject("content")
                .getJSONArray("parts")
                .getJSONObject(0)
                .getString("text");

        // Clean up markdown
        if (rawText.startsWith("```json")) {
            rawText = rawText.replaceFirst("```json\\s*", "");
        }
        if (rawText.endsWith("```")) {
            rawText = rawText.substring(0, rawText.length() - 3).trim();
        }

        return new JSONArray(rawText);
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

    private String extractTextFromWord(File file) throws Exception {
        String extension = file.getName().toLowerCase();

        if (extension.endsWith(".docx")) {
            try (FileInputStream fis = new FileInputStream(file)) {
                XWPFDocument document = new XWPFDocument(fis);
                XWPFWordExtractor extractor = new XWPFWordExtractor(document);
                return extractor.getText();
            }
        } else if (extension.endsWith(".doc")) {
            try (FileInputStream fis = new FileInputStream(file)) {
                HWPFDocument document = new HWPFDocument(fis);
                WordExtractor extractor = new WordExtractor(document);
                return extractor.getText();
            }
        }

        return "";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int testId = Integer.parseInt(request.getParameter("testId"));

        Part filePart = request.getPart("questionFile");
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();

        List<String> allowedExtensions = Arrays.asList(".png", ".jpg", ".jpeg", ".pdf", ".doc", ".docx");
        if (!allowedExtensions.contains(extension)) {
            session.setAttribute("errorMessage", "Chỉ cho phép các định dạng: PNG, JPG, JPEG, PDF, DOC, DOCX.");
            response.sendRedirect("EditTest?testId=" + testId);
            return;
        }

        String uniqueFileName = "testQuestion_" + System.currentTimeMillis() + "_" + UUID.randomUUID() + extension;
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File savedFile = new File(uploadPath, uniqueFileName);
        filePart.write(savedFile.getAbsolutePath());

        String ocrText;

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

            } else if (extension.equals(".doc") || extension.equals(".docx")) {
                ocrText = extractTextFromWord(savedFile);

            } else {
                ocrText = tesseract.doOCR(savedFile);
            }

            // Gửi sang Gemini
            String geminiResponse = callGeminiAPI(ocrText);
            System.out.println(geminiResponse);
            JSONArray questionList = extractFormattedJSONArray(geminiResponse);

            QuestionDAO dao = new QuestionDAO();
            for (int i = 0; i < questionList.length(); i++) {
                JSONObject obj = questionList.getJSONObject(i);

                String questionText = obj.optString("question_text", null);
                String questionType = obj.optString("question_type", "multiple_choice");
                JSONArray options = obj.optJSONArray("options");
                String correctAnswer = obj.optString("correct_answer", "(Không xác định)");

                if (questionText == null || options == null || options.length() < 2) {
                    continue;
                }

                Question question = new Question();
                question.setTestId(testId);
                question.setQuestionText(questionText);
                question.setQuestionType(questionType);
                question.setOptions(options.toString());
                question.setCorrectAnswer(correctAnswer);

                dao.addQuestion(question);
            }

            response.sendRedirect("EditTest?testId=" + testId);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi OCR: " + e.getMessage());
        }
    }
}
