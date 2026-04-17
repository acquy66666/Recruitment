package com.recruitment.model;

/**
 * Các hằng số status cho job_post.
 * THỐNG NHẤT: tất cả code dùng tiếng Anh.
 */
public final class JobPostStatus {

    public static final String PENDING      = "Pending";
    public static final String APPROVED     = "Approved";
    public static final String REJECTED     = "Rejected";
    public static final String ACTIVE       = "Active";
    public static final String HIDDEN       = "Hidden";
    public static final String EXPIRED      = "Expired";
    public static final String REPORTED      = "Reported";
    public static final String ALL          = "All";

    private JobPostStatus() {}

    public static boolean isValid(String status) {
        return APPROVED.equals(status) || PENDING.equals(status) || REJECTED.equals(status)
                || ACTIVE.equals(status) || HIDDEN.equals(status) || EXPIRED.equals(status)
                || REPORTED.equals(status);
    }
}
