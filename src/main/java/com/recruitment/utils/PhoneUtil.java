package com.recruitment.utils;

public class PhoneUtil {
    public static boolean validatePhoneNumber(String phone)  {
        // Check null or empty
        if (phone == null || phone.isEmpty()) {
            return false;
        }
        // Validate length >= 7, starts with 0, and all digits

        return phone.matches("^0\\d{6,}$");
    }
}
