/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.Recruiter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author GBCenter
 */
public class RecruiterReportDAO extends DBcontext {

    public class RecruiterReport {

        private int recruiterID;
        private double totalPrice;
        private LocalDateTime lastTransaction;
        private Recruiter recruiter;

        public RecruiterReport(int recruiterID, double totalPrice, LocalDateTime lastTransaction, Recruiter recruiter) {
            this.recruiterID = recruiterID;
            this.totalPrice = totalPrice;
            this.lastTransaction = lastTransaction;
            this.recruiter = recruiter;
        }

        public int getRecruiterID() {
            return recruiterID;
        }

        public void setRecruiterID(int recruiterID) {
            this.recruiterID = recruiterID;
        }

        public double getTotalPrice() {
            return totalPrice;
        }

        public void setTotalPrice(double totalPrice) {
            this.totalPrice = totalPrice;
        }

        public LocalDateTime getLastTransaction() {
            return lastTransaction;
        }

        public void setLastTransaction(LocalDateTime lastTransaction) {
            this.lastTransaction = lastTransaction;
        }

        public Recruiter getRecruiter() {
            return recruiter;
        }

        public void setRecruiter(Recruiter recruiter) {
            this.recruiter = recruiter;
        }

    }

    public List<RecruiterReport> getTopTransactionReport(int pageNumber, int pageSize, String time) {
        List<RecruiterReport> list = new ArrayList<>();
        RecruiterDAO r = new RecruiterDAO();

        int offset = (pageNumber - 1) * pageSize;

        String sql = """
        SELECT recruiter_id,
               SUM(price) AS total_price,
               MAX(transaction_date) AS last_transaction_date
        FROM [transaction]""";

        if ("month".equals(time)) {
            sql += """
            WHERE MONTH(transaction_date) = MONTH(GETDATE())
              AND YEAR(transaction_date) = YEAR(GETDATE())""";
        } else if ("quarter".equals(time)) {
            sql += """
            WHERE DATEPART(quarter, transaction_date) = DATEPART(quarter, GETDATE())
              AND YEAR(transaction_date) = YEAR(GETDATE())""";
        } else if ("year".equals(time)) {
            sql += """
            WHERE YEAR(transaction_date) = YEAR(GETDATE())""";
        }

        sql += """
        GROUP BY recruiter_id
        ORDER BY SUM(price) DESC
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY""";

        try (PreparedStatement st = c.prepareStatement(sql)) {
            st.setInt(1, offset);
            st.setInt(2, pageSize);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    RecruiterReport a = new RecruiterReport(
                            rs.getInt("recruiter_id"),
                            rs.getDouble("total_price"),
                            rs.getTimestamp("last_transaction_date").toLocalDateTime(),
                            r.getRecruiterByIdDUC(rs.getInt("recruiter_id"))
                    );
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging to a file or console
        }

        return list;
    }

    public int countRecruitersByTime(String time) {
        String sql = "SELECT COUNT(DISTINCT recruiter_id) FROM [transaction]";
        if ("month".equals(time)) {
            sql += " WHERE MONTH(transaction_date) = MONTH(GETDATE()) AND YEAR(transaction_date) = YEAR(GETDATE())";
        } else if ("quarter".equals(time)) {
            sql += " WHERE DATEPART(quarter, transaction_date) = DATEPART(quarter, GETDATE()) AND YEAR(transaction_date) = YEAR(GETDATE())";
        } else if ("year".equals(time)) {
            sql += " WHERE YEAR(transaction_date) = YEAR(GETDATE())";
        }
        try (PreparedStatement st = c.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
