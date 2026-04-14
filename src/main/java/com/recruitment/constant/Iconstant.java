package com.recruitment.constant;

public class Iconstant {

    // ====================== Google OAuth 2.0 ======================
    public static final String GOOGLE_CLIENT_ID = "YOUR_CLIENT_ID";
    public static final String GOOGLE_CLIENT_SECRET = "YOUR_CLIENT_SECRET";
    public static final String GOOGLE_REDIRECT_URI = "http://localhost:8080/Recruitment/login";
    public static final String GOOGLE_GRANT_TYPE = "authorization_code";
    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v2/userinfo?access_token=";

    // ====================== VNPAY Payment ======================
    public static final String VNP_TMN_CODE = "YOUR_TMN_CODE";
    public static final String VNP_HASH_SECRET = "YOUR_HASH_SECRET";
    public static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static final String VNP_RETURN_URL = "http://localhost:8080/Recruitment/PaymentResult";

    // ====================== Email Configuration ======================
    public static final String SMTP_HOST = "smtp.gmail.com";
    public static final String SMTP_PORT = "587";
    public static final String EMAIL_USERNAME = "your_email@gmail.com";
    public static final String EMAIL_PASSWORD = "your_app_password";

    // ====================== Application URLs ======================
    public static final String BASE_URL = "http://localhost:8080/Recruitment";
    public static final String DOMAIN = "http://localhost:8080";
}
