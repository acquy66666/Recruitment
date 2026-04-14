
package com.recruitment.model;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class TransactionView {
    private final Transaction transaction;
    private final int totalCredits;

    public TransactionView(Transaction transaction, int totalCredits) {
        this.transaction = transaction;
        this.totalCredits = totalCredits;
    }

    public int getTransactionId() { return transaction.getTransactionId(); }
    public String getOrderId() { return transaction.getOrderId(); }
    public LocalDateTime getDateTime() { return transaction.getTransactionDate(); }
    // New getter for Date to support fmt:formatDate
    public Date getDateTimeAsDate() {
        return transaction.getTransactionDate() != null ?
               Date.from(transaction.getTransactionDate().atZone(ZoneId.systemDefault()).toInstant()) :
               null;
    }
    public double getPrice() { return transaction.getPrice(); }
    public String getStatus() { return transaction.getStatus(); }
    public String getPaymentMethod() { return transaction.getPaymentMethod(); }
    public int getTotalCredits() { return totalCredits; }
    public String getVnp_TxnRef() { return transaction.getVnp_TxnRef(); }
    public String getVnp_TransactionNo() { return transaction.getVnp_TransactionNo(); }
}
