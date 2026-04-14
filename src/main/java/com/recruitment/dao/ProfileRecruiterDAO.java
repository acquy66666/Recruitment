/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.Recruiter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Mr Duc
 */
public class ProfileRecruiterDAO extends DBcontext {

    public Recruiter getRecruiterById(String id) {
        String sql = "SELECT * FROM recruiter where recruiter_id = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Recruiter(
                        rs.getInt("recruiter_id"),
                        rs.getString("password_hash"),
                        rs.getString("full_name"),
                        rs.getString("position"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getBoolean("isActive"),
                        rs.getString("image_url"),
                        rs.getString("company_name"),
                        rs.getString("company_address"),
                        rs.getString("tax_code"),
                        rs.getString("website"),
                        rs.getString("company_logo_url"),
                        rs.getString("industry"),
                        rs.getString("company_description"),
                        rs.getString("credit")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePersonalInfo(String recruiterId, String fullName, String phone, String position) {
        String sql = "UPDATE recruiter SET "
                + "full_name = ?, phone = ?, position = ? "
                + "WHERE recruiter_id = ?";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, position);
            ps.setString(4, recruiterId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updatePersonalImg(String recruiterId, String imageUrl) {
        String sql = "UPDATE recruiter SET "
                + "image_url = ? "
                + "WHERE recruiter_id = ?";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, imageUrl);
            ps.setString(2, recruiterId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCompanyInfo(String recruiterId, String companyName, String website, String companyAddress,
            String industry, String companyDescription, String taxCode) {

        String sql = "UPDATE recruiter SET company_name = ?, website = ?, company_address = ?, "
                + "industry = ?, company_description = ?, tax_code = ? WHERE recruiter_id = ?";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, companyName);
            ps.setString(2, website);
            ps.setString(3, companyAddress);
            ps.setString(4, industry);
//            ps.setString(5, companyLogoUrl);
            ps.setString(5, companyDescription);
            ps.setString(6, taxCode);
            ps.setString(7, recruiterId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCompanyImg(String recruiterId, String companyLogoUrl) {

        String sql = "UPDATE recruiter SET company_logo_url = ? WHERE recruiter_id = ?";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, companyLogoUrl);
            ps.setString(2, recruiterId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Recruiter> getListRecruiter() {
        List<Recruiter> list = new ArrayList<>();
        String sql = "SELECT * FROM recruiter";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
//            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter(
                        rs.getInt("recruiter_id"),
                        rs.getString("password_hash"),
                        rs.getString("full_name"),
                        rs.getString("position"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getBoolean("isActive"),
                        rs.getString("image_url"),
                        rs.getString("company_name"),
                        rs.getString("company_address"),
                        rs.getString("tax_code"),
                        rs.getString("website"),
                        rs.getString("company_logo_url"),
                        rs.getString("industry"),
                        rs.getString("company_description"),
                        rs.getString("credit")
                );
                list.add(recruiter);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        ProfileRecruiterDAO profileRe = new ProfileRecruiterDAO();
//        Recruiter re = profileRe.getRecruiterById("2");
//        profileRe.updatePersonalInfo("1", "Pham Van D", "0123456789", "testImg", "Marketing");
//        profileRe.updateCompanyInfo("2", "Enterprise Inc.", "https://enterprise.com", "Cao Bằng", "Technology, Business", "Sao bị lỗi vậy bạn ơiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiooooooo", "123456789");
//        System.out.println(re.toString());
//         profileRe.updatePersonalInfo("2", "Bob Tran Le", "09871234567", "Business");
//        profileRe.updateCompanyImg("1", "Test.imgg");
        List<Recruiter> recruiterA = profileRe.getListRecruiter();
        for (Recruiter recruiterN : recruiterA) {
            System.out.println(recruiterN.toString());
        }
    
    }
}
