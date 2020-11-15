package com.example.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

public class Product implements Serializable {

    private int productId;

    private String productName; // 产品名称

    private String photo; // 图片url

    private String description; // 简短描述

    private double price; // 价格

    private int stock; // 库存

    private double priceSpike; // 秒杀价

    private Date startTime; // 秒杀开始时间

    private Date endTime; // 秒杀结束时间


    public Product(String productName, String photo, String description, double price,
                   int stock, double priceSpike, Date startTime, Date endTime) {
        this.productName = productName;
        this.photo = photo;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.priceSpike = priceSpike;
        this.startTime = startTime;
        this.endTime = endTime;
    }


    public Product(){

    }

    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", photo='" + photo + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", priceSpike=" + priceSpike +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                '}';
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public double getPriceSpike() {
        return priceSpike;
    }

    public void setPriceSpike(double priceSpike) {
        this.priceSpike = priceSpike;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

}
