/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.utils;

/**
 *
 * @author HP
 */
public class taxCodeUtil {

    public static boolean validateTaxCode(String tc) {
        if (tc == null || tc.trim().isEmpty()) {
            return false;
        }
        
        String nameRegex = "\\d+$";
        return tc.matches(nameRegex);
    }
    
    public static boolean validLengTaxCode(String tc) {
        if (tc == null || tc.trim().isEmpty()) {
            return false;
        }
        return (tc.length()<=20 && tc.length()>=8);
    }
}
