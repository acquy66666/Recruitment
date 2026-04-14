package com.recruitment.controller.recruiter;

import com.recruitment.dao.AssignmentDAO;
import com.recruitment.dao.QuestionDAO;
import com.recruitment.dao.ResponseDAO;
import com.recruitment.dto.ResponseDTO;
import com.recruitment.model.Assignment;
import com.recruitment.model.Question;
import com.recruitment.model.Recruiter;
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

@WebServlet("/EvaluateByGemini")
@MultipartConfig
public class EvaluateByGemini extends HttpServlet {

    public static String callGeminiAPI(String ocrText) throws IOException {
        String apiKey = "AIzaSyAQRvyJkur3eMttSr9mRgMQksfehS7J3JY";
        String url = "https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=" + apiKey;

        String escapedPrompt = ocrText.replace("\"", "\\\"");

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

        // Loại bỏ markdown nếu có
        rawText = rawText.replaceAll("(?i)```json", "").replaceAll("```", "").trim();

        // Cố gắng tìm đoạn JSON array trong rawText
        int startIndex = rawText.indexOf('[');
        int endIndex = rawText.lastIndexOf(']');

        if (startIndex == -1 || endIndex == -1 || endIndex <= startIndex) {
            throw new JSONException("Không tìm thấy JSONArray hợp lệ trong kết quả Gemini:\n" + rawText);
        }

        String jsonArrayString = rawText.substring(startIndex, endIndex + 1);

        return new JSONArray(jsonArrayString);
    }

    public String evaluateResponsesWithGemini(int assignmentId, int recruiterId) throws IOException {
        ResponseDAO dao = new ResponseDAO();

        String initialJson = dao.getResponseJsonAndEvaluate(assignmentId);

        String prompt = """
        Bạn là hệ thống đánh giá câu trả lời trắc nghiệm theo ngữ nghĩa. Dưới đây là danh sách các câu hỏi, đáp án đúng, và câu trả lời của người dùng. Các câu hỏi có thể được gửi dưới dạng văn bản hoặc ảnh bôi màu để làm nổi bật lựa chọn.
        
        Hãy đánh giá xem câu trả lời người dùng có đúng không theo các quy tắc:
        
            Không so sánh chuỗi chính xác từng từ. Hãy so sánh theo ngữ nghĩa và nội dung logic.
            Nếu câu hỏi là dạng đúng/sai liên quan đến biểu thức toán học, hãy:
                Phân tích biểu thức trong câu hỏi để hiểu bản chất đúng/sai.
                Nếu người dùng trả lời bằng cách khẳng định vế trái lớn hơn, hoặc dùng từ đồng nghĩa như "lớn hơn", "đúng rồi", "vế trái lớn hơn vế phải", thì hiểu là "Đúng".
                Nếu người dùng phản bác hoặc nói "sai rồi", "bé hơn", "không đúng", hiểu là "Sai".
            Nếu câu hỏi được gửi dưới dạng ảnh bôi màu (ví dụ: lựa chọn được tô vàng), hãy nhận diện lựa chọn được bôi màu và so sánh dựa trên ngữ nghĩa của lựa chọn đó.
            Đặt "is_correct" là true nếu ý nghĩa khớp với "correct_answer".
        
        Chỉ trả về JSON sau khi cập nhật trường "is_correct" đúng.
        
        Dữ liệu:
        """ + initialJson;

        String response = callGeminiAPI(prompt);
        return extractFormattedJSONArray(response).toString();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            response.sendRedirect("login");
            return;
        }

        int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
        int candidateId = Integer.parseInt(request.getParameter("candidateId"));

        try {

            int recruiterId = recruiter.getRecruiterId();

            String evaluationResult = evaluateResponsesWithGemini(assignmentId, recruiterId);
            session.setAttribute("evaluationResult", evaluationResult);
            System.out.println(evaluationResult);
            
            ResponseDAO dao = new ResponseDAO();
            dao.updateIsCorrectFromJson(evaluationResult, assignmentId);
            
            AssignmentDAO assignmentDAO = new AssignmentDAO();
            Assignment assignment = assignmentDAO.getAssignmentById(assignmentId);

            int totalQuestion = assignment.getTotalQuestion();
            int correctAns = assignmentDAO.countCorrectResponsesByAssignment(assignmentId);
            
            double score = 0;
            score = ((double) correctAns / totalQuestion * 100);
            score = Math.round(score * 100.0) / 100.0;
            
             assignmentDAO.updateResultByAssignmentId(assignmentId, correctAns, score);

            response.sendRedirect("AssignmentDetail?assignmentId=" + assignmentId + "&candidateId=" + candidateId);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi xử lý: " + e.getMessage());
        }
    }
}
