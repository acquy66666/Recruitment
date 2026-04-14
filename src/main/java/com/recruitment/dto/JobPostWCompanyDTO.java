/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dto;

import com.recruitment.model.JobPost;

/**
 *
 * @author hoang
 */
public class JobPostWCompanyDTO {
    
    private JobPost jobPost;
    private String companyName;
    private String companyLogoUrl;

    public JobPostWCompanyDTO() {
    }

    public JobPostWCompanyDTO(JobPost jobPost, String companyName, String companyLogoUrl) {
        this.jobPost = jobPost;
        this.companyName = companyName;
        this.companyLogoUrl = companyLogoUrl;
    }

    public JobPost getJobPost() {
        return jobPost;
    }

    public void setJobPost(JobPost jobPost) {
        this.jobPost = jobPost;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyLogoUrl() {
        return companyLogoUrl;
    }

    public void setCompanyLogoUrl(String companyLogoUrl) {
        this.companyLogoUrl = companyLogoUrl;
    }
    
    
    
}
