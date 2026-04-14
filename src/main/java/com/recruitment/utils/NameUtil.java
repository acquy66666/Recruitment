package com.recruitment.utils;

public class NameUtil {
    public static boolean validateName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        String nameRegex = "^[\\p{L} ]+$";
        return name.matches(nameRegex);
    }
    
    public static boolean validateName2(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        String nameRegex = "^[\\p{L}0-9 ]+$";
        return name.matches(nameRegex);
    }
    
    public static boolean validateAddress(String address) {
        if (address == null || address.trim().isEmpty()) {
            return false;
        }
        // Allows letters, numbers, spaces, and common address punctuation
        String addressRegex = "^[\\p{L}\\p{N}\\p{P}\\s]+$";
        return address.matches(addressRegex);
    }
}