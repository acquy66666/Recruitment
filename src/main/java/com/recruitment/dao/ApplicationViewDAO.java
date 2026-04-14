/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.Application;
import com.recruitment.model.Candidate;
import com.recruitment.model.Cv;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author GBCenter
 */
public class ApplicationViewDAO extends DBcontext {

    public class ApplicationView {

        private int applicationId;
        private int candidateId;
        private int cvId;
        private int jobId;
        private String coverLetter;
        private String appliedAt;
        private String status;
        private Candidate candidate;
        private Cv cv;

        public ApplicationView() {
        }

        public ApplicationView(int applicationId, int candidateId, int cvId, int jobId, String coverLetter, String appliedAt, String status, Candidate candidate, Cv cv) {
            this.applicationId = applicationId;
            this.candidateId = candidateId;
            this.cvId = cvId;
            this.jobId = jobId;
            this.coverLetter = coverLetter;
            this.appliedAt = appliedAt;
            this.status = status;
            this.candidate = candidate;
            this.cv = cv;
        }

        public int getApplicationId() {
            return applicationId;
        }

        public void setApplicationId(int applicationId) {
            this.applicationId = applicationId;
        }

        public int getCandidateId() {
            return candidateId;
        }

        public void setCandidateId(int candidateId) {
            this.candidateId = candidateId;
        }

        public int getCvId() {
            return cvId;
        }

        public void setCvId(int cvId) {
            this.cvId = cvId;
        }

        public int getJobId() {
            return jobId;
        }

        public void setJobId(int jobId) {
            this.jobId = jobId;
        }

        public String getCoverLetter() {
            return coverLetter;
        }

        public void setCoverLetter(String coverLetter) {
            this.coverLetter = coverLetter;
        }

        public String getAppliedAt() {
            return appliedAt;
        }

        public void setAppliedAt(String appliedAt) {
            this.appliedAt = appliedAt;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public Candidate getCandidate() {
            return candidate;
        }

        public void setCandidate(Candidate candidate) {
            this.candidate = candidate;
        }

        public Cv getCv() {
            return cv;
        }

        public void setCv(Cv cv) {
            this.cv = cv;
        }
        
    }
    
    public List<ApplicationView> getByJob(int id){
        List<ApplicationView> list = new ArrayList<>();
        String sql = "select * from application where job_id=?";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            CandidateDAO c = new CandidateDAO();
            CvDAO cv = new CvDAO();
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ApplicationView a = new ApplicationView(
                        rs.getInt("application_id"),
                        rs.getInt("candidate_id"),
                        rs.getInt("cv_id"),
                        rs.getInt("job_id"),
                        rs.getString("cover_letter"),
                        rs.getString("applied_at"),
                        rs.getString("status"),
                        c.getCandidateById(rs.getInt("candidate_id")),
                        cv.getCvByCvId(rs.getInt("cv_id"))
                );
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi");
        }
        return list;
    }
    
    
}
