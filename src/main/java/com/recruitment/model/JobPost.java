/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

/**
 *
 * @author Mr Duc
 */
public class JobPost {

    private int jobId;
    private int recruiterId;
    private int industryId;
    private String jobPosition;
    private String title;
    private String location;
    private String jobType;
    private double salaryMin;
    private double salaryMax;
    private String experienceLevel;
    private String description;
    private String requirement;
    private String benefit;
    private LocalDateTime createdAt;
    private String deadline;
    private String status;
    private Recruiter recruiter;
    private Industry industry;

    public JobPost() {
    }

    public JobPost(String location) {
        this.location = location;
    }

    public JobPost(int jobId, int recruiterId, String jobPosition, String title, String location, String jobType, double salaryMin, double salaryMax, String experienceLevel, String description, String requirement, String benefit, LocalDateTime createdAt, String deadline, String status) {
        this.jobId = jobId;
        this.recruiterId = recruiterId;
        this.jobPosition = jobPosition;
        this.title = title;
        this.location = location;
        this.jobType = jobType;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.experienceLevel = experienceLevel;
        this.description = description;
        this.requirement = requirement;
        this.benefit = benefit;
        this.createdAt = createdAt;
        this.deadline = deadline;
        this.status = status;
    }

    public JobPost(int jobId, int recruiterId, String jobPosition, String title, String location, String jobType, double salaryMin, double salaryMax, String experienceLevel, String description, String requirement, String benefit, LocalDateTime createdAt, String deadline, String status, Recruiter recruiter) {
        this.jobId = jobId;
        this.recruiterId = recruiterId;
        this.jobPosition = jobPosition;
        this.title = title;
        this.location = location;
        this.jobType = jobType;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.experienceLevel = experienceLevel;
        this.description = description;
        this.requirement = requirement;
        this.benefit = benefit;
        this.createdAt = createdAt;
        this.deadline = deadline;
        this.status = status;
        this.recruiter = recruiter;
    }

    public JobPost(int jobId, int recruiterId, int industryId, String jobPosition, String title, String location, String jobType, double salaryMin, double salaryMax, String experienceLevel, String description, String requirement, String benefit, LocalDateTime createdAt, String deadline, String status, Recruiter recruiter) {
        this.jobId = jobId;
        this.recruiterId = recruiterId;
        this.industryId = industryId;
        this.jobPosition = jobPosition;
        this.title = title;
        this.location = location;
        this.jobType = jobType;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.experienceLevel = experienceLevel;
        this.description = description;
        this.requirement = requirement;
        this.benefit = benefit;
        this.createdAt = createdAt;
        this.deadline = deadline;
        this.status = status;
        this.recruiter = recruiter;
    }

    public JobPost(int jobId, int recruiterId, String jobPosition, String title, String location, String jobType, double salaryMin, double salaryMax, String experienceLevel, String description, String requirement, String benefit, LocalDateTime createdAt, String deadline, String status, Industry industry) {
        this.jobId = jobId;
        this.recruiterId = recruiterId;
        this.jobPosition = jobPosition;
        this.title = title;
        this.location = location;
        this.jobType = jobType;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.experienceLevel = experienceLevel;
        this.description = description;
        this.requirement = requirement;
        this.benefit = benefit;
        this.createdAt = createdAt;
        this.deadline = deadline;
        this.status = status;
        this.industry = industry;
    }

    public JobPost(int jobId, int recruiterId, int industryId, String jobPosition, String title, String location, String jobType, double salaryMin, double salaryMax, String experienceLevel, String description, String requirement, String benefit, LocalDateTime createdAt, String deadline, String status, Recruiter recruiter, Industry industry) {
        this.jobId = jobId;
        this.recruiterId = recruiterId;
        this.industryId = industryId;
        this.jobPosition = jobPosition;
        this.title = title;
        this.location = location;
        this.jobType = jobType;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.experienceLevel = experienceLevel;
        this.description = description;
        this.requirement = requirement;
        this.benefit = benefit;
        this.createdAt = createdAt;
        this.deadline = deadline;
        this.status = status;
        this.recruiter = recruiter;
        this.industry = industry;
    }

    public JobPost(int jobId, int recruiterId, int industryId, String jobPosition, String title, String location, String jobType, double salaryMin, double salaryMax, String experienceLevel, String description, String requirement, String benefit, LocalDateTime createdAt, String deadline, String status) {
        this.jobId = jobId;
        this.recruiterId = recruiterId;
        this.industryId = industryId;
        this.jobPosition = jobPosition;
        this.title = title;
        this.location = location;
        this.jobType = jobType;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.experienceLevel = experienceLevel;
        this.description = description;
        this.requirement = requirement;
        this.benefit = benefit;
        this.createdAt = createdAt;
        this.deadline = deadline;
        this.status = status;
    }

    public JobPost(int jobId, String title, LocalDateTime createdAt,String deadline, String status, Recruiter recruiter) {
        this.jobId = jobId;
        this.title = title;
        this.createdAt = createdAt;
        this.deadline = deadline;
        this.status = status;
        this.recruiter = recruiter;
    }

    public JobPost(String jobType, String experienceLevel) {
        this.jobType = jobType;
        this.experienceLevel = experienceLevel;
    }

    public Industry getIndustry() {
        return industry;
    }

    public void setIndustry(Industry industry) {
        this.industry = industry;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }

    public String getJobPosition() {
        return jobPosition;
    }

    public void setJobPosition(String jobPosition) {
        this.jobPosition = jobPosition;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public double getSalaryMin() {
        return salaryMin;
    }

    public void setSalaryMin(double salaryMin) {
        this.salaryMin = salaryMin;
    }

    public double getSalaryMax() {
        return salaryMax;
    }

    public void setSalaryMax(double salaryMax) {
        this.salaryMax = salaryMax;
    }

    public String getExperienceLevel() {
        return experienceLevel;
    }

    public void setExperienceLevel(String experienceLevel) {
        this.experienceLevel = experienceLevel;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }

    public String getBenefit() {
        return benefit;
    }

    public void setBenefit(String benefit) {
        this.benefit = benefit;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Recruiter getRecruiter() {
        return recruiter;
    }

    public int getIndustryId() {
        return industryId;
    }

    public void setIndustryId(int industryId) {
        this.industryId = industryId;
    }

    public void setRecruiter(Recruiter recruiter) {
        this.recruiter = recruiter;
    }

    public String getTimeAgo() {
        LocalDateTime createdAt = this.createdAt;
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(createdAt, now);

        long seconds = duration.getSeconds();
        long minutes = seconds / 60;
        long hours = minutes / 60;
        long days = hours / 24;

        if (seconds < 60) {
            return "Vừa đăng";
        } else if (minutes < 60) {
            return minutes + " phút trước";
        } else if (hours < 24) {
            return hours + " giờ trước";
        } else if (days < 7) {
            return days + " ngày trước";
        } else {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            return createdAt.format(formatter); // hoặc return days + " ngày trước";
        }
    }

    public String dateDaealine() {
        String[] dealineNow = this.deadline.split(" ");
        return dealineNow[0];
    }

    public String dateCreatAt() {
        String[] createAtNow = this.createdAt.toString().split("T");
        return createAtNow[0];
    }

    public String getFormattedSalaryMin() {
        return formatSalary(this.salaryMin);
    }

    public String getFormattedSalaryMax() {
        return formatSalary(this.salaryMax);
    }

    private String formatSalary(Double salary) {
        if (salary == null) {
            return "";
        }
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        return df.format(salary);
    }

//    public String formatSalaryTrieuDong(double amount) {
//        if (amount < 1_000_000) {
//            // Dưới 1 triệu: hiển thị dạng xxx.xxx đồng
//            DecimalFormatSymbols symbols = new DecimalFormatSymbols(new Locale("vi", "VN"));
//            symbols.setGroupingSeparator('.');//Đặt dấu phân cách phần nghìn là dấu chấm (.).
//            symbols.setDecimalSeparator(',');//Đặt dấu phân cách phần thập phân là dấu phẩy (,).
//            DecimalFormat decimalFormat = new DecimalFormat("#,##0", symbols);
//            return decimalFormat.format(amount) + " đồng";
//        } else {
//            // Từ 1 triệu trở lên: hiển thị số triệu, làm tròn 1 chữ số thập phân nếu cần
//            double millions = amount / 1_000_000;
//            if (millions == (long) millions) {
//                // Là số nguyên, ví dụ 10.0 -> 10 triệu
//                return String.format("%d triệu đồng", (long) millions);
//            } else {
//                // Có phần thập phân, ví dụ 9.5 triệu
//                return String.format("%.1f triệu đồng", millions);
//            }
//        }
//    }
//    public String dateDaealine() {
//        String[] dealineNow = this.deadline.split(" ");
//        String[] dealineee = dealineNow[0].split("-");
//        String result = "";
//        for (int i = dealineee.length - 1; i >= 0; i--) {
//            int number = Integer.parseInt(dealineee[i]);
//            if( i < dealineee.length - 1){
//                result += "/";
//            }
//            result += number;
//        }
//        return result;
//    }
    @Override
    public String toString() {
        return "JobPost{" + "jobId=" + jobId + ", recruiterId=" + recruiterId + ", jobPosition=" + jobPosition + ", title=" + title + ", location=" + location + ", jobType=" + jobType + ", salaryMin=" + salaryMin + ", salaryMax=" + salaryMax + ", experienceLevel=" + experienceLevel + ", description=" + description + ", requirement=" + requirement + ", benefit=" + benefit + ", createdAt=" + createdAt + ", deadline=" + deadline + ", status=" + status + ", industry=" + industry + '}';
    }

}
