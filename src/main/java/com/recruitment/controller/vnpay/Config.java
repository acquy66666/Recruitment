package com.recruitment.controller.vnpay;

import jakarta.servlet.http.HttpServletRequest;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/**
 * Configuration and utility methods for VNPay integration.
 */
public class Config {
    public static final String VNP_PAY_URL = validateEnv("VNPAY_PAY_URL", "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html");
    public static final String VNP_RETURN_URL = validateEnv("VNPAY_RETURN_URL", "http://localhost:9999/Recruitment/vnpay/return");
    public static final String VNP_TMN_CODE = validateEnv("VNPAY_TMN_CODE", "7T548FKW");
    public static final String VNP_SECRET_KEY = validateEnv("VNPAY_SECRET_KEY", "LDGAIO40O0JGKEWD5IFA9HMG1JE7C8PM");
    public static final String VNP_API_URL = validateEnv("VNPAY_API_URL", "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction");
   
    private static String validateEnv(String key, String defaultValue) {
        String value = System.getenv(key);
        if (value == null || value.trim().isEmpty()) {
            System.err.println("Warning: Environment variable " + key + " is not set. Using default: " + defaultValue);
            return defaultValue;
        }
        return value;
    }

    public static String hmacSHA512(String key, String data) {
        try {
            if (key == null || data == null) {
                throw new NullPointerException("Key or data is null");
            }
            Mac hmac512 = Mac.getInstance("HmacSHA512");
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmac512.init(secretKeySpec);
            byte[] result = hmac512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("HMAC-SHA512 algorithm not found", e);
        } catch (Exception e) {
            throw new RuntimeException("Error computing HMAC-SHA512", e);
        }
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-FORWARDED-FOR");
        if (ipAddress == null || ipAddress.isEmpty()) {
            ipAddress = request.getRemoteAddr();
        }
        return ipAddress != null ? ipAddress : "Unknown";
    }

    public static String getRandomNumber(int length) {
        Random random = new Random();
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    public static String hashAllFields(Map<String, String> fields) {
        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder sb = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = fields.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                sb.append(fieldName).append('=').append(fieldValue);
                if (itr.hasNext()) {
                    sb.append('&');
                }
            }
        }
        return hmacSHA512(VNP_SECRET_KEY, sb.toString());
    }

    public static String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        sdf.setTimeZone(TimeZone.getTimeZone("Etc/GMT+7"));
        return sdf.format(date);
    }

    static {
        System.out.println("VNPAY_TMN_CODE: " + VNP_TMN_CODE);
        System.out.println("VNPAY_SECRET_KEY: " + VNP_SECRET_KEY);
        System.out.println("VNPAY_PAY_URL: " + VNP_PAY_URL);
        System.out.println("VNPAY_RETURN_URL: " + VNP_RETURN_URL);
        System.out.println("VNPAY_API_URL: " + VNP_API_URL);
    }
}