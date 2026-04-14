/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author GBCenter
 */
public class AppliedJobDAO extends DBcontext {

    public class AppliedJob {

        private int jobID;
        private String title;
        private String company;
        private String location;
        private float minSalary;
        private float maxSalary;
        private String jobType;
        private String logo;
        private String status;

        public AppliedJob() {
        }

        public AppliedJob(int jobID, String title, String company, String location, float minSalary, float maxSalary, String jobType, String logo, String status) {
            this.jobID = jobID;
            this.title = title;
            this.company = company;
            this.location = location;
            this.minSalary = minSalary;
            this.maxSalary = maxSalary;
            this.jobType = jobType;
            this.logo = logo;
            this.status = status;
        }

        public int getJobID() {
            return jobID;
        }

        public void setJobID(int jobID) {
            this.jobID = jobID;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getCompany() {
            return company;
        }

        public void setCompany(String company) {
            this.company = company;
        }

        public String getLocation() {
            return location;
        }

        public void setLocation(String location) {
            this.location = location;
        }

        public float getMinSalary() {
            return minSalary;
        }

        public void setMinSalary(float minSalary) {
            this.minSalary = minSalary;
        }

        public float getMaxSalary() {
            return maxSalary;
        }

        public void setMaxSalary(float maxSalary) {
            this.maxSalary = maxSalary;
        }

        public String getJobType() {
            return jobType;
        }

        public void setJobType(String jobType) {
            this.jobType = jobType;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getLogo() {
            return logo;
        }

        public void setLogo(String logo) {
            this.logo = logo;
        }
    }

    public List<AppliedJob> getAll(int id) {
        List<AppliedJob> list = new ArrayList<>();
        String sql = """
                     select a.job_id, jp.title, e.company_name, jp.location, jp.salary_min, jp.salary_max, jp.job_type, e.company_logo_url, a.status from job_post jp
                                          join application a on jp.job_id=a.job_id
                                          join recruiter e on jp.recruiter_id= e.recruiter_id
                                          where a.candidate_id=?""";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AppliedJob a = new AppliedJob(
                        rs.getInt("job_id"),
                        rs.getString("title"),
                        rs.getString("company_name"),
                        rs.getString("location"),
                        rs.getFloat("salary_min"),
                        rs.getFloat("salary_max"),
                        rs.getString("job_type"),
                        rs.getString("company_logo_url"),
                        rs.getString("status")
                );
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi");
        }
        return list;
    }

    public List<AppliedJob> getFilteredAppliedJobs(
            int candidateId,
            String status,
            int daysBack,
            String keyword,
            int top,
            int pageIndex
    ) throws SQLException {
        List<AppliedJob> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT a.job_id, jp.title, e.company_name, jp.location,
               jp.salary_min, jp.salary_max, jp.job_type,
               e.company_logo_url, a.status
        FROM job_post jp
        JOIN application a ON jp.job_id = a.job_id
        JOIN recruiter e ON jp.recruiter_id = e.recruiter_id
        WHERE a.candidate_id = ?
    """);

        List<Object> params = new ArrayList<>();
        params.add(candidateId);

        // Filter by status
        if (status != null && !status.equalsIgnoreCase("All")) {
            sql.append(" AND a.status = ? ");
            params.add(status);
        }

        // Filter by submission time
        if (daysBack > 0) {
            sql.append(" AND a.applied_at >= DATEADD(day, -?, GETDATE()) ");
            params.add(daysBack);
        }

        // Filter by keyword
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("""
            AND (
                jp.title LIKE ? OR
                e.company_name LIKE ? OR
                jp.location LIKE ?
            )
        """);
            String pattern = "%" + keyword.trim() + "%";
            params.add(pattern);
            params.add(pattern);
            params.add(pattern);
        }

        // Sort and paginate
        sql.append(" ORDER BY a.applied_at DESC ");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
        params.add((pageIndex - 1) * top);
        params.add(top);

        try (PreparedStatement st = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof Integer) {
                    st.setInt(i + 1, (int) param);
                } else {
                    st.setString(i + 1, param.toString());
                }
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    AppliedJob a = new AppliedJob(
                            rs.getInt("job_id"),
                            rs.getString("title"),
                            rs.getString("company_name"),
                            rs.getString("location"),
                            rs.getFloat("salary_min"),
                            rs.getFloat("salary_max"),
                            rs.getString("job_type"),
                            rs.getString("company_logo_url"),
                            rs.getString("status")
                    );
                    list.add(a);
                }
            }
        }

        return list;
    }

    public int countFilteredAppliedJobs(
            int candidateId,
            String status,
            int daysBack,
            String keyword
    ) throws SQLException {
        StringBuilder sql = new StringBuilder("""
        SELECT COUNT(*) FROM job_post jp
        JOIN application a ON jp.job_id = a.job_id
        JOIN recruiter e ON jp.recruiter_id = e.recruiter_id
        WHERE a.candidate_id = ?
    """);

        List<Object> params = new ArrayList<>();
        params.add(candidateId);

        if (status != null && !status.equalsIgnoreCase("All")) {
            sql.append(" AND a.status = ? ");
            params.add(status);
        }

        if (daysBack > 0) {
            sql.append(" AND a.submitted_at >= DATEADD(day, -?, GETDATE()) ");
            params.add(daysBack);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("""
            AND (
                jp.title LIKE ? OR
                e.company_name LIKE ? OR
                jp.location LIKE ?
            )
        """);
            String pattern = "%" + keyword.trim() + "%";
            params.add(pattern);
            params.add(pattern);
            params.add(pattern);
        }

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof Integer) {
                    ps.setInt(i + 1, (int) param);
                } else {
                    ps.setString(i + 1, param.toString());
                }
            }

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public List<AppliedJob> getByJobID(int id) {
        List<AppliedJob> list = new ArrayList<>();
        String sql = """
                     select a.job_id, jp.title, e.company_name, jp.location, jp.salary_min, jp.salary_max, jp.job_type, e.company_logo_url, a.status from job_post jp
                                          join application a on jp.job_id=a.job_id
                                          join recruiter e on jp.recruiter_id= e.recruiter_id
                                          where a.job_id=?""";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                AppliedJob a = new AppliedJob(
                        rs.getInt("job_id"),
                        rs.getString("title"),
                        rs.getString("company_name"),
                        rs.getString("location"),
                        rs.getFloat("salary_min"),
                        rs.getFloat("salary_max"),
                        rs.getString("job_type"),
                        rs.getString("company_logo_url"),
                        rs.getString("status")
                );
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi");
        }
        return list;
    }

    public static void main(String[] args) {
        AppliedJobDAO a = new AppliedJobDAO();
        List<AppliedJob> al = a.getAll(1);
        System.out.println(al.get(0).getCompany());
        System.out.println(al.get(0).getMaxSalary());
    }
}
