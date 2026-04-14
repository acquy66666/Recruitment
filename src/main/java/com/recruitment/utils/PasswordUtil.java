package com.recruitment.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA algorithm error", e);
        }
    }

    // Check if password length is at least 8 characters
    public static boolean isLengthValid(String password) {
        return password != null && password.length() >= 8;
    }

    // Check if password has at least one digit, one letter, and one uppercase letter
    public static boolean isDifficultyValid(String password) {
        if (password == null) return false;

        boolean hasDigit = false;
        boolean hasUppercase = false;
        boolean hasLetter = false;

        for (char ch : password.toCharArray()) {
            if (Character.isDigit(ch)) {
                hasDigit = true;
            } else if (Character.isUpperCase(ch)) {
                hasUppercase = true;
                hasLetter = true;
            } else if (Character.isLetter(ch)) {
                hasLetter = true;
            }

            // Early exit if all conditions are met
            if (hasDigit && hasUppercase && hasLetter) {
                return true;
            }
        }

        return false;
    }

}
