/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.utils;

/**
 *
 * @author HP
 */
public class EmailValidator {
    public static boolean validateEmail(String email)  {
        String emailRegex = "^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$";
        return !(email == null || !email.matches(emailRegex));
    }
}
