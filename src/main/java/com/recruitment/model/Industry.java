/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

/**
 *
 * @author Mr Duc
 */
public class Industry {
    private int industryId;
    private String nameIndustry;

    public Industry(int industryId, String nameIndustry) {
        this.industryId = industryId;
        this.nameIndustry = nameIndustry;
    }

    public int getIndustryId() {
        return industryId;
    }

    public void setIndustryId(int industryId) {
        this.industryId = industryId;
    }

    public String getNameIndustry() {
        return nameIndustry;
    }

    public void setNameIndustry(String nameIndustry) {
        this.nameIndustry = nameIndustry;
    }

    @Override
    public String toString() {
        return "Industry{" + "industryId=" + industryId + ", nameIndustry=" + nameIndustry + '}';
    }
    
    
}
