/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Mr Duc
 */
public class DBcontext {
    public Connection c;

    public DBcontext() {
        // #region agent log - DB connection debug
        System.err.println("[DB_DEBUG] Attempting database connection...");
        System.err.println("[DB_DEBUG] URL: jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=RecruitmentDBFinal;encrypt=false;trustServerCertificate=true;sharedMemory=true");
        System.err.println("[DB_DEBUG] Username: sa");
        // #endregion
        try {
            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=RecruitmentDBFinal;encrypt=false;trustServerCertificate=true;sharedMemory=true";
            String username = "sa";
            String pass = "123456";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.err.println("[DB_DEBUG] Driver loaded successfully, now connecting...");
            c = DriverManager.getConnection(url, username, pass);
            // #region agent log
            System.err.println("[DB_DEBUG] SUCCESS - Database connection established, c=" + c);
            // #endregion
        } catch (ClassNotFoundException e) {
            // #region agent log
            System.err.println("[DB_DEBUG] FAILURE - ClassNotFoundException: " + e.getMessage());
            e.printStackTrace();
            // #endregion
            throw new RuntimeException("SQL Server JDBC Driver not found. Please add the driver JAR to your project.", e);
        } catch (SQLException e) {
            // #region agent log
            System.err.println("[DB_DEBUG] FAILURE - SQLException: " + e.getMessage());
            System.err.println("[DB_DEBUG] SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode());
            e.printStackTrace();
            // #endregion
            throw new RuntimeException("Cannot connect to SQL Server database. Please check your database configuration.", e);
        }
    }

    public void closeConnection() {
        try {
            if (c != null && !c.isClosed()) {
                c.close();
                System.out.println("Connection closed successfully.");
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
    public static void main(String[] args) {
        DBcontext d = new DBcontext();
    }
}
