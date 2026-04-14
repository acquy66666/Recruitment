/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import java.io.FileReader;
import java.io.IOException;
import java.security.KeyFactory;
import java.security.interfaces.RSAPrivateKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

public class JitsiTokenUtil {

    private static final String APP_ID = "vpaas-magic-cookie-8fd3c3b144904eb8b121838389334cdc";
    private static final String TENANT = APP_ID;
    private static final String PRIVATE_KEY_FILE = "private-key.pem"; // ← bạn sửa đường dẫn này!

    // Load RSA private key từ file trong resources (classpath)
    private static RSAPrivateKey loadPrivateKey() throws Exception {
        InputStream is = JitsiTokenUtil.class.getClassLoader().getResourceAsStream(PRIVATE_KEY_FILE);
        if (is == null) {
            throw new RuntimeException("Không tìm thấy file private key: " + PRIVATE_KEY_FILE);
        }

        String privateKeyPEM = new BufferedReader(new InputStreamReader(is))
                .lines()
                .collect(Collectors.joining("\n"));

        String cleanedKey = privateKeyPEM
                .replace("-----BEGIN PRIVATE KEY-----", "")
                .replace("-----END PRIVATE KEY-----", "")
                .replaceAll("\\s", "");

        byte[] decoded = Base64.getDecoder().decode(cleanedKey);
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(decoded);
        KeyFactory kf = KeyFactory.getInstance("RSA");
        return (RSAPrivateKey) kf.generatePrivate(spec);
    }

    public static String generateToken(String roomName, String userName, boolean isModerator) throws Exception {
        RSAPrivateKey privateKey = loadPrivateKey();
        Algorithm algorithm = Algorithm.RSA256(null, privateKey);

        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);
        Date exp = new Date(nowMillis + 3600 * 1000); // 1 giờ

        // Phần header với đúng "kid"
        Map<String, Object> header = new HashMap<>();
        header.put("kid", "vpaas-magic-cookie-8fd3c3b144904eb8b121838389334cdc/03b852"); // <- Đúng key ID trong portal JaaS

        // Phần context
        Map<String, Object> userContext = new HashMap<>();
        userContext.put("name", userName);
        userContext.put("moderator", isModerator);

        Map<String, Object> context = new HashMap<>();
        context.put("user", userContext);

        // Phần features
        Map<String, Object> features = Map.of(
                "livestreaming", true,
                "recording", true,
                "outbound-call", true,
                "transcription", true
        );

        return JWT.create()
                .withHeader(header)
                .withIssuer("chat") // luôn là "chat"
                .withSubject("vpaas-magic-cookie-8fd3c3b144904eb8b121838389334cdc")
                .withAudience("jitsi")
                .withClaim("room", roomName)
                .withClaim("context", context)
                .withClaim("features", features)
                .withIssuedAt(now)
                .withExpiresAt(exp)
                .sign(algorithm);
    }

    // ✅ MAIN để test
//    public static void main(String[] args) {
//        try {
//            String token = generateToken("interview-room-123", "Recruiter A", true);
//            System.out.println("✅ JWT Token: ");
//            System.out.println(token);
//
//            String[] parts = token.split("\\.");
//            if (parts.length == 3) {
//                System.out.println("\n✅ Token hợp lệ: có đủ 3 phần (header.payload.signature)");
//            } else {
//                System.out.println("\n❌ Token KHÔNG hợp lệ: thiếu chữ ký (signature)");
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

}
