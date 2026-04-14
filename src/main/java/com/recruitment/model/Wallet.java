/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

/**
 *
 * @author HP
 */

public class Wallet {
    private int walletId; // Maps to wallet_id (INT, PRIMARY KEY)
    private int credit; // Maps to credit (INT, NOT NULL)

    // Default constructor
    public Wallet() {}

    // Parameterized constructor
    public Wallet(int walletId, int credit) {
        this.walletId = walletId;
        this.credit = credit;
    }

    // Getters and Setters
    public int getWalletId() {
        return walletId;
    }

    public void setWalletId(int walletId) {
        this.walletId = walletId;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }
}