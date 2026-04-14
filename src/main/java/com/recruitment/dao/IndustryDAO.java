/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.Industry;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author GBCenter
 */
public class IndustryDAO extends DBcontext {
    public Industry industryById(int id){
        String sql="select * from industry where industry_id=?";
        try {
            PreparedStatement st = c.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new Industry(
                        rs.getInt("industry_id"),
                        rs.getString("name")
                );
            }
        } catch (SQLException e) {
            System.out.println("Loi ket noi");
        }
        return null;
    }
}
