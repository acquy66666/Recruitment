package com.recruitment.controller.vnpay;

import com.recruitment.dao.TransactionDAO;
import com.recruitment.model.Transaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;
import org.json.JSONObject;

@WebServlet(name = "VnpayQueryServlet", urlPatterns = {"/vnpay/query"})
public class VnpayQueryServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(VnpayQueryServlet.class.getName());
    private TransactionDAO transactionDAO;

    @Override
    public void init() throws ServletException {
        transactionDAO = new TransactionDAO();
        LOGGER.info("VnpayQueryServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Received POST request for /vnpay/query");
        response.setContentType("application/json");
        JSONObject responseJson = new JSONObject();

        try {
            String vnpTxnRef = request.getParameter("vnp_TxnRef");
            String orderId = request.getParameter("orderId");

            LOGGER.info("Parameters - vnp_TxnRef: " + vnpTxnRef + ", orderId: " + orderId);

            if ((vnpTxnRef == null || vnpTxnRef.isEmpty()) && (orderId == null || orderId.isEmpty())) {
                responseJson.put("code", "99");
                responseJson.put("message", "vnp_TxnRef or orderId is required");
                LOGGER.warning("Missing required parameters");
                request.setAttribute("responseJson", responseJson.toString());
                request.getRequestDispatcher("/vnpayQuery.jsp").forward(request, response);
                return;
            }

            Transaction transaction = null;
            if (vnpTxnRef != null && !vnpTxnRef.isEmpty()) {
                transaction = transactionDAO.getTransactionByVnpTxnRef(vnpTxnRef);
            } else if (orderId != null && !orderId.isEmpty()) {
                transaction = transactionDAO.getTransactionByOrderId(orderId);
                if (transaction != null) {
                    vnpTxnRef = transaction.getVnp_TxnRef();
                }
            }

            if (transaction == null) {
                responseJson.put("code", "99");
                responseJson.put("message", "Transaction not found");
                LOGGER.warning("Transaction not found for vnp_TxnRef: " + vnpTxnRef + ", orderId: " + orderId);
                request.setAttribute("responseJson", responseJson.toString());
                request.getRequestDispatcher("/vnpayQuery.jsp").forward(request, response);
                return;
            }

            LOGGER.info("Found transaction: " + transaction.getVnp_TxnRef());

            Map<String, String> fields = new HashMap<>();
            fields.put("vnp_Command", "querydr");
            fields.put("vnp_Version", "2.1.0");
            fields.put("vnp_TmnCode", Config.VNP_TMN_CODE);
            fields.put("vnp_TxnRef", vnpTxnRef);

            LocalDateTime ldt = transaction.getTransactionDate();
            Date date = Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());
            fields.put("vnp_TransactionDate", Config.formatDate(date));
            fields.put("vnp_CreateDate", Config.formatDate(new Date()));
            fields.put("vnp_IpAddr", Config.getIpAddress(request));

            String secureHash = Config.hashAllFields(fields);
            fields.put("vnp_SecureHash", secureHash);

            StringBuilder postData = new StringBuilder();
            for (Map.Entry<String, String> entry : fields.entrySet()) {
                if (postData.length() > 0) {
                    postData.append('&');
                }
                postData.append(URLEncoder.encode(entry.getKey(), StandardCharsets.UTF_8))
                        .append('=')
                        .append(URLEncoder.encode(entry.getValue(), StandardCharsets.UTF_8));
            }

            URL url = new URL(Config.VNP_API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);
            conn.setConnectTimeout(30000);
            conn.setReadTimeout(30000);

            conn.getOutputStream().write(postData.toString().getBytes(StandardCharsets.UTF_8));

            StringBuilder responseData = new StringBuilder();
            int responseCode = conn.getResponseCode();
            LOGGER.info("VNPay API response code: " + responseCode);

            BufferedReader br;
            if (responseCode == HttpURLConnection.HTTP_OK) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
            }
            String line;
            while ((line = br.readLine()) != null) {
                responseData.append(line);
            }
            br.close();
            conn.disconnect();

            JSONObject vnpayResponse = new JSONObject(responseData.toString());
            String responseCodeVnpay = vnpayResponse.optString("vnp_ResponseCode", "99");
            String transactionStatus = mapVnpayResponseCode(responseCodeVnpay);
            String vnpTransactionNo = vnpayResponse.optString("vnp_TransactionNo", "");

            transactionDAO.updateTransactionStatus(vnpTxnRef, transactionStatus, vnpTransactionNo, vnpayResponse.toString());

            responseJson.put("code", "00");
            responseJson.put("message", "Query successful");
            responseJson.put("data", vnpayResponse);
            LOGGER.info("VNPay Query - TxnRef: " + vnpTxnRef + ", Status: " + transactionStatus);

            request.setAttribute("responseJson", responseJson.toString());
            request.getRequestDispatcher("/vnpayQuery.jsp").forward(request, response);

        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            responseJson.put("code", "99");
            responseJson.put("message", "Database error occurred");
            request.setAttribute("responseJson", responseJson.toString());
            request.getRequestDispatcher("/vnpayQuery.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.severe("Unexpected error: " + e.getMessage());
            responseJson.put("code", "99");
            responseJson.put("message", "Internal server error");
            request.setAttribute("responseJson", responseJson.toString());
            request.getRequestDispatcher("/vnpayQuery.jsp").forward(request, response);
        }
    }

    private String mapVnpayResponseCode(String code) {
        switch (code) {
            case "00": return "success";
            case "01": return "pending";
            case "02": return "failed";
            default: return "unknown";
        }
    }
}