package com.example.domain;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {
    
    private int userId;

    private String userName; // 用户名

    private String password; // 密码

    private int privilege; // 权限，1为管理员，0为普通用户

    private double balance; // 余额

    public User(String userName, String password) {
        this.userName = userName;
        this.password = password;
        this.privilege = 0;
        this.balance = 0;
    }


    public User() {

    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getPrivilege() {
        return privilege;
    }

    public void setPrivilege(int privilege) {
        this.privilege = privilege;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

}
