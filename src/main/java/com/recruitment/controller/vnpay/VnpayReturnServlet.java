package com.recruitment.controller.vnpay;

import com.recruitment.dao.TransactionDAO;
import com.recruitment.dao.TransactionDetailDAO;
import com.recruitment.dao.ServiceDAO;
import com.recruitment.dao.RecruiterDAO;
import com.recruitment.model.Transaction;
import com.recruitment.model.TransactionDetail;
import com.recruitment.model.Service;
import com.recruitment.model.Recruiter;
import com.recruitment.utils.CreditManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Logger;

@WebServlet(name = "VnpayReturnServlet", urlPatterns = {"/vnpay/return"})
public class VnpayReturnServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(VnpayReturnServlet.class.getName());
    private TransactionDAO transactionDAO;
    private TransactionDetailDAO transactionDetailDAO;
    private ServiceDAO serviceDAO;
    private RecruiterDAO recruiterDAO;

    @Override
    public void init() throws ServletException {
        transactionDAO = new TransactionDAO();
        transactionDetailDAO = new TransactionDetailDAO();
        serviceDAO = new ServiceDAO();
        recruiterDAO = new RecruiterDAO();
        LOGGER.info("VnpayReturnServlet initialized");
    }

@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Received VNPay return request");
        HttpSession session = request.getSession(false);
        if (session == null) {
            LOGGER.warning("No session found");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String vnp_TxnRef = request.getParameter("vnp_TxnRef");
            String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
            String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
            Integer transactionId = (Integer) session.getAttribute("transactionId");

            LOGGER.info("Processing return - vnp_TxnRef: " + vnp_TxnRef + ", ResponseCode: " + vnp_ResponseCode + ", transactionId: " + transactionId);

            if (vnp_TxnRef == null || vnp_ResponseCode == null || transactionId == null) {
                LOGGER.warning("Missing parameters: vnp_TxnRef=" + vnp_TxnRef + ", vnp_ResponseCode=" + vnp_ResponseCode + ", transactionId=" + transactionId);
                session.setAttribute("paymentMessage", "Missing or invalid payment parameters.");
                response.sendRedirect(request.getContextPath() + "/ErrorPayment.jsp");
                return;
            }

            Transaction transaction = transactionDAO.getTransactionById(transactionId);
            if (transaction == null || !transaction.getVnp_TxnRef().equals(vnp_TxnRef)) {
                LOGGER.warning("Invalid transaction: ID=" + transactionId + ", vnp_TxnRef=" + vnp_TxnRef);
                session.setAttribute("paymentMessage", "Transaction not found or invalid.");
                response.sendRedirect(request.getContextPath() + "/ErrorPayment.jsp");
                return;
            }

            // Verify VNPay response
            Map<String, String> vnpParams = new HashMap<>();
            Enumeration<String> paramNames = request.getParameterNames();
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                if (paramValue != null && !paramValue.isEmpty()) {
                    vnpParams.put(paramName, paramValue);
                }
            }

            String vnp_SecureHash = vnpParams.remove("vnp_SecureHash");
            if (vnp_SecureHash == null) {
                LOGGER.warning("Missing vnp_SecureHash parameter");
                updateTransactionStatus(transactionId, "failed");
                session.setAttribute("paymentMessage", "Missing security hash in payment response.");
                response.sendRedirect(request.getContextPath() + "/ErrorPayment.jsp");
                return;
            }

            String hashData = createHashDataForVerification(vnpParams);
            String calculatedHash = Config.hmacSHA512(Config.VNP_SECRET_KEY, hashData);
            
            LOGGER.info("Hash verification - HashData: " + hashData);
            LOGGER.info("Hash verification - Received: " + vnp_SecureHash);
            LOGGER.info("Hash verification - Calculated: " + calculatedHash);

            if (!vnp_SecureHash.equals(calculatedHash)) {
                LOGGER.warning("Invalid secure hash for vnp_TxnRef=" + vnp_TxnRef);
                updateTransactionStatus(transactionId, "failed");
                session.setAttribute("paymentMessage", "Invalid payment response signature.");
                response.sendRedirect(request.getContextPath() + "/ErrorPayment.jsp");
                return;
            }

            Map<String, Object> paymentInfo = new HashMap<>();
            paymentInfo.put("transactionId", transaction.getTransactionId());
            paymentInfo.put("orderId", transaction.getOrderId());
            paymentInfo.put("vnpTxnRef", transaction.getVnp_TxnRef());
            paymentInfo.put("amount", transaction.getPrice());
            paymentInfo.put("paymentMethod", transaction.getPaymentMethod());
            paymentInfo.put("transactionDate", transaction.getTransactionDate().toString());
            paymentInfo.put("vnpTransactionNo", vnp_TransactionNo != null ? vnp_TransactionNo : "N/A");

            if ("00".equals(vnp_ResponseCode)) {
                transaction.setStatus("success");
                transaction.setVnp_TransactionNo(vnp_TransactionNo != null ? vnp_TransactionNo : "");
                boolean transactionUpdated = transactionDAO.updateTransaction(transaction);
                if (!transactionUpdated) {
                    LOGGER.severe("Failed to update transaction status to success for transactionId: " + transactionId);
                    paymentInfo.put("status", "failed");
                    paymentInfo.put("message", "Payment processed but transaction update failed.");
                    session.setAttribute("paymentInfo", paymentInfo);
                    response.sendRedirect(request.getContextPath() + "/ErrorPayment.jsp");
                    return;
                }

                boolean creditsUpdated = updateRecruiterCredits(transactionId, session);
                LOGGER.info("Credits update status: " + (creditsUpdated ? "Success" : "Failed"));

                paymentInfo.put("status", "success");
                paymentInfo.put("message", creditsUpdated ? "Payment completed successfully." : "Payment completed but failed to update credits.");
                session.setAttribute("paymentInfo", paymentInfo);
                response.sendRedirect(request.getContextPath() + "/SuccessPayment.jsp");
            } else {
                updateTransactionStatus(transactionId, "failed");
                LOGGER.info("Payment failed for transactionId=" + transactionId + ", vnp_TxnRef=" + vnp_TxnRef + ", ResponseCode=" + vnp_ResponseCode);
                paymentInfo.put("status", "failed");
                paymentInfo.put("message", "Payment failed. Response code: " + vnp_ResponseCode);
                session.setAttribute("paymentInfo", paymentInfo);
                response.sendRedirect(request.getContextPath() + "/ErrorPayment.jsp");
            }

        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            session.setAttribute("paymentMessage", "Database error occurred during payment processing.");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } catch (Exception e) {
            LOGGER.severe("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("paymentMessage", "An unexpected error occurred during payment processing.");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error");
        }
    }

    private String createHashDataForVerification(Map<String, String> params) {
        try {
            List<String> fieldNames = new ArrayList<>(params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            
            for (String fieldName : fieldNames) {
                String fieldValue = params.get(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    String encodedValue = URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString());
                    hashData.append(fieldName).append('=').append(encodedValue);
                    if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                        hashData.append('&');
                    }
                }
            }
            
            return hashData.toString();
        } catch (Exception e) {
            LOGGER.severe("Error creating hash data: " + e.getMessage());
            return "";
        }
    }

    private boolean updateRecruiterCredits(int transactionId, HttpSession session) {
        try {
            List<TransactionDetail> transactionDetails = transactionDetailDAO.getDetailsByTransactionId(transactionId);
            if (transactionDetails == null || transactionDetails.isEmpty()) {
                LOGGER.warning("No transaction details found for transactionId: " + transactionId);
                return false;
            }

            Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
            if (recruiter == null) {
                LOGGER.warning("No recruiter found in session for transactionId: " + transactionId);
                return false;
            }

            String creditsJson = recruiter.getCredit();
            if (creditsJson == null) {
                LOGGER.info("Recruiter credits JSON is null for recruiterId: " + recruiter.getRecruiterId() + ", initializing as empty");
                creditsJson = "{}";
            }
            Map<String, Integer> existingCredits = CreditManager.parseCreditsFromJson(creditsJson);
            LOGGER.info("Existing credits for recruiter " + recruiter.getRecruiterId() + ": " + existingCredits);

            Map<String, Integer> newCredits = new HashMap<>();
            for (TransactionDetail detail : transactionDetails) {
                Service service = serviceDAO.getServiceById(detail.getServiceId());
                if (service == null) {
                    LOGGER.warning("Service not found for serviceId: " + detail.getServiceId());
                    continue;
                }
                String serviceType = service.getServiceType();
                int credits = service.getCredit();
                if (serviceType != null && credits > 0) {
                    newCredits.merge(serviceType, credits, Integer::sum);
                    LOGGER.info("Adding " + credits + " credits for service type: " + serviceType);
                } else {
                    LOGGER.warning("Invalid service type or credits: serviceType=" + serviceType + ", credits=" + credits);
                }
            }

            if (newCredits.isEmpty()) {
                LOGGER.warning("No valid credits to add for transactionId: " + transactionId);
                return false;
            }

            Map<String, Integer> updatedCredits = CreditManager.addCredits(existingCredits, newCredits);
            LOGGER.info("Updated credits: " + updatedCredits);

            String updatedCreditsJson = CreditManager.convertCreditsToJson(updatedCredits);
            recruiter.setCredit(updatedCreditsJson);
            boolean updateSuccess = recruiterDAO.updateCredits(recruiter.getRecruiterId(), updatedCredits);
            if (!updateSuccess) {
                LOGGER.severe("Failed to update recruiter credits in database for recruiterId: " + recruiter.getRecruiterId());
                return false;
            }

            session.setAttribute("Recruiter", recruiter);
            LOGGER.info("Successfully updated recruiter " + recruiter.getRecruiterId() + " credits: " + updatedCreditsJson);
            LOGGER.info("Credits summary: " + CreditManager.formatCreditsForDisplay(updatedCreditsJson));
            return true;

        } catch (SQLException e) {
            LOGGER.severe("Database error while updating recruiter credits: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            LOGGER.severe("Unexpected error while updating recruiter credits: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private void updateTransactionStatus(int transactionId, String status) throws SQLException {
        Transaction transaction = transactionDAO.getTransactionById(transactionId);
        if (transaction != null) {
            transaction.setStatus(status);
            boolean updateSuccess = transactionDAO.updateTransaction(transaction);
            if (updateSuccess) {
                LOGGER.info("Transaction status updated to " + status + " for transactionId: " + transactionId);
            } else {
                LOGGER.warning("Failed to update transaction status for transactionId: " + transactionId);
            }
        } else {
            LOGGER.warning("Transaction not found for ID: " + transactionId);
        }
    }
}