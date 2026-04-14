package com.recruitment.controller.recruiter;

import com.recruitment.controller.vnpay.Config;
import com.recruitment.dao.*;
import com.recruitment.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.*;
import java.util.logging.Logger;

@WebServlet(name = "ServicePaymentServlet", urlPatterns = {"/servicepayment"})
public class ServicePaymentServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ServicePaymentServlet.class.getName());
    private ServiceDAO serviceDAO;
    private PromotionDAO promotionDAO;
    private TransactionDAO transactionDAO;
    private TransactionDetailDAO transactionDetailDAO;
    private RecruiterDAO recruiterDAO;

    @Override
    public void init() throws ServletException {
        serviceDAO = new ServiceDAO();
        promotionDAO = new PromotionDAO();
        transactionDAO = new TransactionDAO();
        transactionDetailDAO = new TransactionDetailDAO();
        recruiterDAO = new RecruiterDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Recruiter") == null) {
            LOGGER.warning("No session or recruiter found in doGet");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Integer> selectedServiceIds = (List<Integer>) session.getAttribute("selectedServiceIds");
        if (selectedServiceIds == null || selectedServiceIds.isEmpty()) {
            LOGGER.info("No selected services in session, redirecting to buyServices");
            response.sendRedirect(request.getContextPath() + "/buyServices");
            return;
        }

        try {
            List<Service> selectedServices = new ArrayList<>();
            for (Integer serviceId : selectedServiceIds) {
                if (serviceId != null) {
                    Service service = serviceDAO.getServiceById(serviceId);
                    if (service != null) {
                        selectedServices.add(service);
                    } else {
                        LOGGER.warning("Service not found for ID: " + serviceId);
                    }
                }
            }
            if (selectedServices.isEmpty()) {
                LOGGER.warning("No valid services found for selected IDs");
                response.sendRedirect(request.getContextPath() + "/buyServices");
                return;
            }

            request.setAttribute("selectedServices", selectedServices);
            request.setAttribute("activePromotions", Optional.ofNullable(promotionDAO.getActivePromotions()).orElse(new ArrayList<>()));
            request.getRequestDispatcher("/ServicePayment.jsp").forward(request, response);

        } catch (SQLException e) {
            LOGGER.severe("doGet SQL error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Recruiter") == null) {
            LOGGER.warning("No session or recruiter found in doPost");
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Session expired. Please log in.");
            return;
        }

        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
        List<Integer> selectedServiceIds = (List<Integer>) session.getAttribute("selectedServiceIds");
        if (selectedServiceIds == null || selectedServiceIds.isEmpty()) {
            LOGGER.info("No selected services in session, redirecting to buyServices");
            response.sendRedirect(request.getContextPath() + "/buyServices");
            return;
        }

        try {
            List<TransactionDetail> transactionDetails = new ArrayList<>();
            double totalAmount = 0.0;
            int totalCredits = 0;
            Map<Integer, Integer> serviceCredits = new HashMap<>();

            for (Integer serviceId : selectedServiceIds) {
                if (serviceId != null) {
                    Service service = serviceDAO.getServiceById(serviceId);
                    if (service != null) {
                        transactionDetails.add(new TransactionDetail(0, 0, serviceId, service.getPrice()));
                        totalAmount += service.getPrice();
                        totalCredits += service.getCredit();
                        serviceCredits.merge(serviceId, service.getCredit(), Integer::sum);
                    } else {
                        LOGGER.warning("Service not found for ID: " + serviceId);
                    }
                }
            }

            if (transactionDetails.isEmpty() || totalAmount <= 0.0) {
                LOGGER.warning("No valid services selected or total amount invalid: " + totalAmount);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No valid services selected.");
                return;
            }

            int promotionId = 0;
            double discountAmount = 0.0;
            String promoIdStr = request.getParameter("promotionId");
            if (promoIdStr != null && !promoIdStr.trim().isEmpty()) {
                try {
                    promotionId = Integer.parseInt(promoIdStr);
                } catch (NumberFormatException e) {
                    LOGGER.warning("Invalid promotion ID format: " + promoIdStr);
                }
            }

            if (promotionId > 0) {
                Promotion promotion = promotionDAO.getPromotionById(promotionId);
                if (isPromotionValid(promotion)) {
                    Double discountPercent = Optional.ofNullable(promotion.getDiscountPercent()).orElse(0.0);
                    Double maxDiscountAmount = Optional.ofNullable(promotion.getMaxDiscountAmount()).orElse(0.0);
                    LOGGER.info("Applying promotion ID: " + promotionId + ", Discount Percent: " + discountPercent + ", Max Discount: " + maxDiscountAmount);
                    if (discountPercent > 0.0 && !Double.isNaN(discountPercent)) {
                        discountAmount = Math.min(totalAmount * discountPercent / 100.0, maxDiscountAmount);
                        totalAmount = Math.max(0.0, totalAmount - discountAmount);
                        promotion.setQuantity(promotion.getQuantity()-1);
                        promotionDAO.updatePromotion(promotion);
                    } else {
                        LOGGER.warning("Invalid promotion values: Discount Percent=" + discountPercent + ", Max Discount=" + maxDiscountAmount);
                    }
                } else {
                    LOGGER.info("Promotion ID " + promotionId + " is invalid or not found.");
                }
            }

            if (Double.isNaN(totalAmount) || totalAmount < 0.0) {
                LOGGER.severe("Total amount after discount is invalid: " + totalAmount);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid total amount after discount.");
                return;
            }

            String orderId = UUID.randomUUID().toString();
            String vnpTxnRef = Config.getRandomNumber(8);
            Transaction transaction = new Transaction();
            transaction.setRecruiterId(recruiter.getRecruiterId());
            transaction.setPromotionId(promotionId);
            transaction.setPrice(totalAmount);
            transaction.setTransactionDate(LocalDateTime.now());
            transaction.setPaymentMethod("VNPay");
            transaction.setStatus("pending");
            transaction.setOrderId(orderId);
            transaction.setVnp_TxnRef(vnpTxnRef);
            transaction.setVnp_TransactionNo("");
            transaction.setJson("{}");
            int transactionId = transactionDAO.insertTransaction(transaction);

            for (TransactionDetail detail : transactionDetails) {
                detail.setTransactionId(transactionId);
                transactionDetailDAO.insertTransactionDetail(detail);
            }

            session.setAttribute("totalCredits", totalCredits);
            session.setAttribute("orderId", orderId);
            session.setAttribute("vnp_TxnRef", vnpTxnRef);
            session.setAttribute("transactionId", transactionId);
            session.removeAttribute("selectedServiceIds");
            response.sendRedirect(request.getContextPath() + "/vnpaypayment");

        } catch (SQLException e) {
            LOGGER.severe("doPost SQL error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        } catch (Exception e) {
            LOGGER.severe("doPost general error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error: " + e.getMessage());
        }
    }

    private boolean isPromotionValid(Promotion promo) {
        return promo != null && promo.isActive() && promo.getQuantity() > 0 &&
               Optional.ofNullable(promo.getDiscountPercent()).orElse(0.0) > 0 &&
               Optional.ofNullable(promo.getMaxDiscountAmount()).orElse(0.0) >= 0;
    }
}