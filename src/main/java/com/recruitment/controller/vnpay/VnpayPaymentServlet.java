package com.recruitment.controller.vnpay;

import com.recruitment.dao.TransactionDAO;
import com.recruitment.model.Transaction;
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
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Logger;

@WebServlet(name = "VnpayPaymentServlet", urlPatterns = {"/vnpaypayment"})
public class VnpayPaymentServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(VnpayPaymentServlet.class.getName());
    private TransactionDAO transactionDAO;

    @Override
    public void init() throws ServletException {
        transactionDAO = new TransactionDAO();
        LOGGER.info("VnpayPaymentServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Received request for /vnpaypayment");
        HttpSession session = request.getSession(false);
        if (session == null) {
            LOGGER.warning("No session found");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String orderId = (String) session.getAttribute("orderId");
            String vnpTxnRef = (String) session.getAttribute("vnp_TxnRef");
            Integer transactionId = (Integer) session.getAttribute("transactionId");

            if (orderId == null || vnpTxnRef == null || transactionId == null || orderId.isEmpty() || vnpTxnRef.isEmpty()) {
                LOGGER.warning("Missing or empty session attributes: orderId=" + orderId + ", vnp_TxnRef=" + vnpTxnRef + ", transactionId=" + transactionId);
                response.sendRedirect(request.getContextPath() + "/servicepayment");
                return;
            }

            Transaction transaction = transactionDAO.getTransactionById(transactionId);
            if (transaction == null || !transaction.getOrderId().equals(orderId) || !transaction.getVnp_TxnRef().equals(vnpTxnRef)) {
                LOGGER.warning("Invalid transaction: ID=" + transactionId + ", orderId=" + orderId + ", vnp_TxnRef=" + vnpTxnRef);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Transaction not found or invalid");
                return;
            }
            long longPrice = (long) transaction.getPrice() * 100;

            Map<String, String> vnpParams = new HashMap<>();
            vnpParams.put("vnp_Version", "2.1.0");
            vnpParams.put("vnp_Command", "pay");
            vnpParams.put("vnp_TmnCode", Config.VNP_TMN_CODE);
            vnpParams.put("vnp_Amount", String.valueOf(longPrice)); // VND, multiplied by 100
            vnpParams.put("vnp_CurrCode", "VND");
            vnpParams.put("vnp_TxnRef", vnpTxnRef);
            vnpParams.put("vnp_OrderInfo", "Payment for Order #" + orderId);
            vnpParams.put("vnp_OrderType", "recruitment_service");
            vnpParams.put("vnp_Locale", "vn");
            String vnp_ReturnUrl = Config.VNP_RETURN_URL;
            if (vnp_ReturnUrl == null || vnp_ReturnUrl.isEmpty()) {
                LOGGER.severe("vnp_ReturnUrl is null or empty in Config");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Configuration error: vnp_ReturnUrl not set");
                return;
            }
            vnpParams.put("vnp_ReturnUrl", vnp_ReturnUrl);
            vnpParams.put("vnp_IpAddr", Config.getIpAddress(request)); // Dynamic IP
            vnpParams.put("vnp_CreateDate", Config.formatDate(new Date()));

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnpParams.put("vnp_CreateDate", vnp_CreateDate);
            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnpParams.put("vnp_ExpireDate", vnp_ExpireDate);

            // Get bankCode from request parameter
            String bankCode = request.getParameter("bankCode");
            LOGGER.info("Received bankCode parameter: " + bankCode); // Debug log
            if (bankCode != null && !bankCode.trim().isEmpty()) {
                vnpParams.put("vnp_BankCode", bankCode.trim());
            } else {
                LOGGER.warning("No valid bankCode parameter provided, skipping vnp_BankCode");
            }

            List<String> fieldNames = new ArrayList<>(vnpParams.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            for (String fieldName : fieldNames) {
                String fieldValue = vnpParams.get(fieldName);
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    String encodedValue = URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString());
                    hashData.append(fieldName).append('=').append(encodedValue); // Encode for hash
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString())).append('=').append(encodedValue);
                    if (fieldName != fieldNames.get(fieldNames.size() - 1)) {
                        hashData.append('&');
                        query.append('&');
                    }
                }
            }

            String queryUrl = query.toString();
            String vnpSecureHash = Config.hmacSHA512(Config.VNP_SECRET_KEY, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnpSecureHash;
            String paymentUrl = Config.VNP_PAY_URL + "?" + queryUrl;

            LOGGER.info("Redirecting to VNPay payment URL: " + paymentUrl);
            response.sendRedirect(paymentUrl);

        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } catch (Exception e) {
            LOGGER.severe("Unexpected error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error");
        }
    }
}