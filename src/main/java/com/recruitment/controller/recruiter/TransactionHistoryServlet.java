package com.recruitment.controller.recruiter;

import com.recruitment.dao.*;
import com.recruitment.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet(name = "TransactionHistoryServlet", urlPatterns = {"/transactionHistory"})
public class TransactionHistoryServlet extends HttpServlet {
    private TransactionDAO transactionDAO;
    private TransactionDetailDAO detailDAO;
    private ServiceDAO serviceDAO;
    private PromotionDAO promotionDAO;
    private RecruiterDAO recruiterDAO;

    @Override
    public void init() throws ServletException {
        transactionDAO = new TransactionDAO();
        detailDAO = new TransactionDetailDAO();
        serviceDAO = new ServiceDAO();
        promotionDAO = new PromotionDAO();
        recruiterDAO = new RecruiterDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
            if (recruiter == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
                return;
            }

            Map<Integer, Integer> credits = recruiterDAO.getCredits(recruiter.getRecruiterId());
            request.setAttribute("credits", credits);

            String transactionIdStr = request.getParameter("transactionId");
            if (transactionIdStr != null && !transactionIdStr.isEmpty()) {
                int transactionId = Integer.parseInt(transactionIdStr);
                Transaction transaction = transactionDAO.getTransactionById(transactionId);
                if (transaction == null || transaction.getRecruiterId() != recruiter.getRecruiterId()) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Transaction not found or unauthorized.");
                    return;
                }

                List<TransactionDetail> details = detailDAO.getDetailsByTransactionId(transactionId);
                List<TransactionDetailView> detailViews = new ArrayList<>();
                int totalCredits = 0;
                for (TransactionDetail detail : details) {
                    Service service = serviceDAO.getServiceById(detail.getServiceId());
                    if (service != null) {
                        detailViews.add(new TransactionDetailView(detail, service.getTitle(), service.getServiceType(), service.getCredit(), detail.getUnitPrice()));
                        totalCredits += service.getCredit();
                    }
                }

                Promotion promotion = transaction.getPromotionId() != 0 ?
                                     promotionDAO.getPromotionById(transaction.getPromotionId()) : null;

                request.setAttribute("transaction", new TransactionView(transaction, totalCredits));
                request.setAttribute("detailViews", detailViews);
                request.setAttribute("promotion", promotion);
                request.getRequestDispatcher("/transactionDetail.jsp").forward(request, response);
            } else {
                List<Transaction> transactions = transactionDAO.getTransactionsByRecruiterId(recruiter.getRecruiterId());
                List<TransactionView> transactionViews = new ArrayList<>();
                for (Transaction transaction : transactions) {
                    List<TransactionDetail> details = detailDAO.getDetailsByTransactionId(transaction.getTransactionId());
                    int totalCredits = 0;
                    for (TransactionDetail detail : details) {
                        Service service = serviceDAO.getServiceById(detail.getServiceId());
                        if (service != null) {
                            totalCredits += service.getCredit();
                        }
                    }
                    transactionViews.add(new TransactionView(transaction, totalCredits));
                }
                request.setAttribute("transactions", transactionViews);
                request.getRequestDispatcher("/transactionList.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid transaction ID format.");
        }
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}