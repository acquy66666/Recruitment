package com.recruitment.utils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class CreditManager {
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static Map<String, Integer> parseCreditsFromJson(String creditsJson) {
        if (creditsJson == null || creditsJson.trim().isEmpty() || "{}".equals(creditsJson.trim())) {
            return new HashMap<>();
        }
        try {
            TypeReference<Map<String, Integer>> typeRef = new TypeReference<Map<String, Integer>>() {};
            Map<String, Integer> credits = objectMapper.readValue(creditsJson, typeRef);
            credits.replaceAll((key, value) -> Math.max(0, value != null ? value : 0));
            return credits;
        } catch (IOException e) {
            return new HashMap<>();
        }
    }

    public static String convertCreditsToJson(Map<String, Integer> credits) {
        try {
            if (credits == null || credits.isEmpty()) {
                return "{}";
            }
            Map<String, Integer> cleanedCredits = new HashMap<>();
            for (Map.Entry<String, Integer> entry : credits.entrySet()) {
                if (entry.getKey() != null && entry.getValue() != null && entry.getValue() >= 0) {
                    cleanedCredits.put(entry.getKey(), entry.getValue());
                }
            }
            return objectMapper.writeValueAsString(cleanedCredits);
        } catch (IOException e) {
            return "{}";
        }
    }

    public static Map<String, Integer> addCredits(Map<String, Integer> existingCredits, 
                                                 Map<String, Integer> creditsToAdd) {
        Map<String, Integer> result = new HashMap<>(existingCredits);
        for (Map.Entry<String, Integer> entry : creditsToAdd.entrySet()) {
            String serviceType = entry.getKey();
            Integer creditsToAddAmount = entry.getValue();
            if (serviceType != null && creditsToAddAmount != null && creditsToAddAmount > 0) {
                result.merge(serviceType, creditsToAddAmount, Integer::sum);
            }
        }
        return result;
    }

    public static boolean subtractCredits(Map<String, Integer> existingCredits, 
                                        String serviceType, int creditsToSubtract) {
        if (serviceType == null || creditsToSubtract <= 0) {
            return false;
        }
        int currentCredits = existingCredits.getOrDefault(serviceType, 0);
        if (currentCredits < creditsToSubtract) {
            return false;
        }
        existingCredits.put(serviceType, currentCredits - creditsToSubtract);
        return true;
    }

    public static int getCreditsForServiceType(String creditsJson, String serviceType) {
        Map<String, Integer> credits = parseCreditsFromJson(creditsJson);
        return credits.getOrDefault(serviceType, 0);
    }

    public static boolean hasSufficientCredits(String creditsJson, String serviceType, int requiredCredits) {
        return getCreditsForServiceType(creditsJson, serviceType) >= requiredCredits;
    }

    public static int getTotalCredits(String creditsJson) {
        Map<String, Integer> credits = parseCreditsFromJson(creditsJson);
        return credits.values().stream().mapToInt(Integer::intValue).sum();
    }

    public static String formatCreditsForDisplay(String creditsJson) {
        Map<String, Integer> credits = parseCreditsFromJson(creditsJson);
        if (credits.isEmpty()) {
            return "No credits available";
        }
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, Integer> entry : credits.entrySet()) {
            if (sb.length() > 0) {
                sb.append(", ");
            }
            sb.append(entry.getKey()).append(": ").append(entry.getValue());
        }
        return sb.toString();
    }

    public static String toJson(Map<String, Integer> credits) {
        try {
            return objectMapper.writeValueAsString(credits != null ? credits : new HashMap<>());
        } catch (IOException e) {
            return "{}";
        }
    }
}