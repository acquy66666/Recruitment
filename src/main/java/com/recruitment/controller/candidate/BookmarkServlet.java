package com.recruitment.controller.candidate;

import com.recruitment.dao.BookmarkDAO;
import com.recruitment.model.Candidate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/bookmark-job")
public class BookmarkServlet extends HttpServlet {

    private final BookmarkDAO bookmarkDAO = new BookmarkDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");
        
        if (candidate == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int candidateId = candidate.getCandidateId();
            
            // Get bookmarked jobs
            List<Map<String, Object>> bookmarkedJobs = bookmarkDAO.getBookmarkedJobs(candidateId);
            int totalBookmarks = bookmarkDAO.getBookmarkedJobsCount(candidateId);
            
            // Set attributes for JSP
            request.setAttribute("bookmarkedJobs", bookmarkedJobs);
            request.setAttribute("totalBookmarks", totalBookmarks);
            
            // Forward to bookmark page
            request.getRequestDispatcher("bookmark.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi tải danh sách việc làm đã lưu.");
            request.setAttribute("totalBookmarks", 0);
            request.setAttribute("bookmarkedJobs", null);
            
            request.getRequestDispatcher("bookmark.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("Candidate");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        Map<String, Object> jsonResponse = new HashMap<>();
        
        if (candidate == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Bạn cần đăng nhập để sử dụng tính năng này.");
            jsonResponse.put("redirect", "login.jsp");
            out.print(gson.toJson(jsonResponse));
            out.flush();
            return;
        }

        String action = request.getParameter("action");
        String jobIdStr = request.getParameter("jobId");
        
        if (action == null || action.trim().isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Thiếu thông tin hành động.");
            out.print(gson.toJson(jsonResponse));
            out.flush();
            return;
        }
        
        if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Thiếu thông tin ID việc làm.");
            out.print(gson.toJson(jsonResponse));
            out.flush();
            return;
        }

        try {
            int jobId = Integer.parseInt(jobIdStr.trim());
            int candidateId = candidate.getCandidateId();
            
            boolean success = false;
            
            switch (action.toLowerCase().trim()) {
                case "add":
                    if (bookmarkDAO.isBookmarked(candidateId, jobId)) {
                        jsonResponse.put("success", false);
                        jsonResponse.put("message", "Việc làm này đã được lưu trước đó.");
                        jsonResponse.put("isBookmarked", true);
                    } else {
                        success = bookmarkDAO.addBookmark(candidateId, jobId);
                        jsonResponse.put("success", success);
                        jsonResponse.put("message", success ? "Đã lưu việc làm thành công." : "Không thể lưu việc làm. Vui lòng thử lại.");
                        jsonResponse.put("isBookmarked", success);
                    }
                    break;
                    
                case "remove":
                    // Force removal - always attempt to remove
                    success = bookmarkDAO.removeBookmark(candidateId, jobId);
                    jsonResponse.put("success", success);
                    jsonResponse.put("message", success ? "Đã bỏ lưu việc làm thành công." : "Không thể bỏ lưu việc làm. Vui lòng thử lại.");
                    jsonResponse.put("isBookmarked", false);
                    jsonResponse.put("jobId", jobId); // Include jobId for frontend
                    break;
                    
                case "toggle":
                    boolean isCurrentlyBookmarked = bookmarkDAO.isBookmarked(candidateId, jobId);
                    if (isCurrentlyBookmarked) {
                        success = bookmarkDAO.removeBookmark(candidateId, jobId);
                        jsonResponse.put("message", success ? "Đã bỏ lưu việc làm." : "Không thể bỏ lưu việc làm.");
                    } else {
                        success = bookmarkDAO.addBookmark(candidateId, jobId);
                        jsonResponse.put("message", success ? "Đã lưu việc làm." : "Không thể lưu việc làm.");
                    }
                    jsonResponse.put("success", success);
                    jsonResponse.put("isBookmarked", success ? !isCurrentlyBookmarked : isCurrentlyBookmarked);
                    break;
                    
                case "check":
                    boolean isBookmarked = bookmarkDAO.isBookmarked(candidateId, jobId);
                    jsonResponse.put("success", true);
                    jsonResponse.put("isBookmarked", isBookmarked);
                    break;
                    
                default:
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Hành động không hợp lệ: " + action);
            }
            
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "ID việc làm không hợp lệ.");
        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Có lỗi cơ sở dữ liệu xảy ra.");
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Có lỗi hệ thống xảy ra. Vui lòng thử lại sau.");
        }
        
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
}
