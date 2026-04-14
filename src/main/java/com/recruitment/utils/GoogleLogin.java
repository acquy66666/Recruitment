package com.recruitment.utils;

import com.recruitment.model.GoogleAccount;
import com.recruitment.constant.Iconstant;
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;


public class GoogleLogin {
    
  
    public static String getToken(String code) throws IOException {
        if (code == null || code.trim().isEmpty()) {
            throw new IllegalArgumentException("Authorization code cannot be null or empty");
        }
        
        try {
            // Sử dụng URL đúng
            URL url = new URL("https://oauth2.googleapis.com/token");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            // Set request properties
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setDoOutput(true);
            
            // Tạo request body sử dụng constants từ Iconstant
            String requestBody = "client_id=" + URLEncoder.encode(Iconstant.GOOGLE_CLIENT_ID, StandardCharsets.UTF_8) +
                               "&client_secret=" + URLEncoder.encode(Iconstant.GOOGLE_CLIENT_SECRET, StandardCharsets.UTF_8) +
                               "&redirect_uri=" + URLEncoder.encode(Iconstant.GOOGLE_REDIRECT_URI, StandardCharsets.UTF_8) +
                               "&code=" + URLEncoder.encode(code, StandardCharsets.UTF_8) +
                               "&grant_type=" + URLEncoder.encode(Iconstant.GOOGLE_GRANT_TYPE, StandardCharsets.UTF_8);
            
            System.out.println("Request body: " + requestBody); // Debug
            
            // Gửi request
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }
            
            // Kiểm tra response code
            int responseCode = conn.getResponseCode();
            System.out.println("Response code: " + responseCode); // Debug
            
            if (responseCode != 200) {
                String errorResponse = readErrorResponse(conn);
                System.out.println("Error response: " + errorResponse); // Debug
                throw new IOException("HTTP error " + responseCode + ": " + errorResponse);
            }
            
            // Đọc response
            String response = readResponse(conn.getInputStream());
            System.out.println("Token response: " + response); // Debug
            
            // Parse JSON manually (không dùng Gson)
            String accessToken = extractJsonValue(response, "access_token");
            
            if (accessToken == null || accessToken.isEmpty()) {
                throw new IOException("No access token in response: " + response);
            }
            
            System.out.println("Access token received: " + accessToken.substring(0, Math.min(10, accessToken.length())) + "..."); // Debug
            
            return accessToken;
            
        } catch (Exception e) {
            e.printStackTrace(); 
            throw new IOException("Failed to get access token: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get user info from Google API
     */
    public static GoogleAccount getUserInfo(String accessToken) throws IOException {
        if (accessToken == null || accessToken.trim().isEmpty()) {
            throw new IllegalArgumentException("Access token cannot be null or empty");
        }
        
        try {
            // Sử dụng URL từ Iconstant
            String urlString = Iconstant.GOOGLE_LINK_GET_USER_INFO + accessToken;
            System.out.println("User info URL: " + urlString); // Debug
            
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            // Set request properties
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            
            // Kiểm tra response code
            int responseCode = conn.getResponseCode();
            System.out.println("User info response code: " + responseCode); // Debug
            
            if (responseCode != 200) {
                String errorResponse = readErrorResponse(conn);
                System.out.println("User info error: " + errorResponse); // Debug
                throw new IOException("HTTP error " + responseCode + ": " + errorResponse);
            }
            
            // Đọc response
            String response = readResponse(conn.getInputStream());
            System.out.println("User info response: " + response); // Debug
            
            // Parse JSON manually thành GoogleAccount object
            GoogleAccount googleAccount = parseGoogleAccount(response);
            
            // Validate
            if (googleAccount == null || googleAccount.getEmail() == null) {
                throw new IOException("Invalid user info from Google: " + response);
            }
            
            System.out.println("Google account parsed: " + googleAccount.getEmail()); // Debug
            
            return googleAccount;
            
        } catch (Exception e) {
            e.printStackTrace(); 
            throw new IOException("Failed to get user info: " + e.getMessage(), e);
        }
    }
    
    
    private static GoogleAccount parseGoogleAccount(String jsonResponse) {
        GoogleAccount account = new GoogleAccount();
        
        try {
           
            account.setId(extractJsonValue(jsonResponse, "id"));
            account.setEmail(extractJsonValue(jsonResponse, "email"));
            account.setName(extractJsonValue(jsonResponse, "name"));
            account.setGiven_name(extractJsonValue(jsonResponse, "given_name"));
            account.setFamily_name(extractJsonValue(jsonResponse, "family_name"));
            
            String verifiedEmail = extractJsonValue(jsonResponse, "verified_email");
            account.setVerified_email("true".equals(verifiedEmail));
            
        } catch (Exception e) {
            System.out.println("Error parsing Google account: " + e.getMessage());
        }
        
        return account;
    }
    
    /**
     * Extract value từ JSON string (simple parser)
     */
    private static String extractJsonValue(String json, String key) {
        try {
            String searchKey = "\"" + key + "\"";
            int keyIndex = json.indexOf(searchKey);
            
            if (keyIndex == -1) {
                return null;
            }
            
            // Tìm dấu : sau key
            int colonIndex = json.indexOf(":", keyIndex);
            if (colonIndex == -1) {
                return null;
            }
            
            // Tìm giá trị sau dấu :
            int valueStart = colonIndex + 1;
            
            // Skip whitespace
            while (valueStart < json.length() && Character.isWhitespace(json.charAt(valueStart))) {
                valueStart++;
            }
            
            if (valueStart >= json.length()) {
                return null;
            }
            
            // Kiểm tra xem giá trị có phải string không (bắt đầu bằng ")
            if (json.charAt(valueStart) == '"') {
                // String value
                int valueEnd = json.indexOf('"', valueStart + 1);
                if (valueEnd == -1) {
                    return null;
                }
                return json.substring(valueStart + 1, valueEnd);
            } else {
                // Non-string value (boolean, number)
                int valueEnd = valueStart;
                while (valueEnd < json.length() && 
                       json.charAt(valueEnd) != ',' && 
                       json.charAt(valueEnd) != '}' && 
                       json.charAt(valueEnd) != ']') {
                    valueEnd++;
                }
                return json.substring(valueStart, valueEnd).trim();
            }
            
        } catch (Exception e) {
            System.out.println("Error extracting JSON value for key '" + key + "': " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Đọc response từ InputStream
     */
    private static String readResponse(InputStream inputStream) throws IOException {
        StringBuilder response = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
        }
        return response.toString();
    }
    
    /**
     * Đọc error response
     */
    private static String readErrorResponse(HttpURLConnection conn) {
        try {
            InputStream errorStream = conn.getErrorStream();
            if (errorStream != null) {
                return readResponse(errorStream);
            }
        } catch (IOException e) {
        }
        return "Unknown error";
    }
}

