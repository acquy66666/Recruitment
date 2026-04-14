package com.recruitment.controller.recruiter;

import com.recruitment.dao.QuestionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "DeleteQuestion", urlPatterns = {"/DeleteQuestion"})
public class DeleteQuestion extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String IdStr = request.getParameter("questionId");
        String testId = request.getParameter("testId");
        QuestionDAO questionDAO = new QuestionDAO();

        if (IdStr != null && !IdStr.trim().isEmpty()) {
            try {
                int questionId = Integer.parseInt(IdStr);

                // Xóa bản ghi trong database
                boolean deleted = questionDAO.deleteQuestion(questionId);
                if (deleted) {
                    request.setAttribute("successMessage", "Xóa câu hỏi thành công.");
                } else {
                    request.setAttribute("errorMessage", "Không thể xóa câu hỏi.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Câu hỏi không hợp lệ.");
            } catch (SQLException ex) {
                Logger.getLogger(EditTest.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        response.sendRedirect(request.getContextPath() + "/EditTest?testId=" + testId);
    }
}
