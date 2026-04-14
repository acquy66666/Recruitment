/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.model;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

/**
 *
 * @author HP
 */
public class Service {

    private int serviceId;
    private String title;
    private int credit;
    private String serviceType;
    private String description;
    private boolean isActive;
    private String imgUrl;
    private double price;

    public Service() {
    }

    public Service(int serviceId, String title, int credit, String serviceType, String description, boolean isActive, String imgUrl, double price) {
        this.serviceId = serviceId;
        this.title = title;
        this.credit = credit;
        this.serviceType = serviceType;
        this.description = description;
        this.isActive = isActive;
        this.imgUrl = imgUrl;
        this.price = price;
    }

    public Service(String serviceType) {
        this.serviceType = serviceType;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getFormattedPrice() {
        return formattedPrice(price);
    }

    public String formattedPrice(double amount) {
        if (amount < 1_000_000) {
            // Dưới 1 triệu: hiển thị dạng xxx,xxx đồng
            DecimalFormatSymbols symbols = new DecimalFormatSymbols(new Locale("vi", "VN"));
            symbols.setGroupingSeparator(',');//Đặt dấu phân cách phần nghìn là dấu chấm (.).
            symbols.setDecimalSeparator('.');//Đặt dấu phân cách phần thập phân là dấu phẩy (,).
            DecimalFormat decimalFormat = new DecimalFormat("#,##0", symbols);
            return decimalFormat.format(amount) + " đồng";
        } else {
            // Từ 1 triệu trở lên: hiển thị số triệu, làm tròn 1 chữ số thập phân nếu cần
            double millions = amount / 1_000_000;
            if (millions == (long) millions) {
                // Là số nguyên, ví dụ 10.0 -> 10 triệu
                return String.format("%d triệu đồng", (long) millions);
            } else {
                // Có phần thập phân, ví dụ 9.5 triệu
                return String.format("%.1f triệu đồng", millions);
            }
        }
    }

    public String getFormattedCredit() {
        return formatCredit(this.credit);
    }

    public String getFormattedPriceNew() {
        return formatPriceNew(this.price);
    }

    private String formatCredit(Integer credit) {
        if (credit == null) {
            return "";
        }
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        return df.format(credit);
    }

    private String formatPriceNew(Double salary) {
        if (salary == null) {
            return "";
        }
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        return df.format(salary);
    }

    public String formatPriceView(double salary) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        return df.format(salary);
    }

    @Override
    public String toString() {
        return "Service{" + "serviceId=" + serviceId + ", title=" + title + ", credit=" + credit + ", serviceType=" + serviceType + ", description=" + description + ", isActive=" + isActive + ", imgUrl=" + imgUrl + ", price=" + price + '}';
    }

}
