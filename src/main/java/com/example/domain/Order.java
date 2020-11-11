package com.example.domain;

import java.io.Serializable;
import java.util.Date;

public class Order implements Serializable {

    private int orderId; // 订单编号

    private int productId; // 商品编号

    private int userId; // 用户编号

    private int num; // 购买数量

    private double totalPrice; // 总价

    private String consignee; // 收货人姓名

    private String telephoneNumber; // 电话号码

    private String address; // 收货地址

    private Date createTime; // 订单创建时间

    private boolean isPaid; // 是否付款

    public Order(int productId, int userId, int num, double totalPrice, String consignee,
                 String telephoneNumber, String address, Date createTime) {
        this.productId = productId;
        this.userId = userId;
        this.num = num;
        this.totalPrice = totalPrice;
        this.consignee = consignee;
        this.telephoneNumber = telephoneNumber;
        this.address = address;
        this.createTime = createTime;
        this.isPaid = false;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getTelephoneNumber() {
        return telephoneNumber;
    }

    public void setTelephoneNumber(String telephoneNumber) {
        this.telephoneNumber = telephoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public boolean isPaid() {
        return isPaid;
    }

    public void setPaid(boolean paid) {
        isPaid = paid;
    }
}
