package com.example.service;

import com.example.dao.UserDao;
import com.example.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    public boolean hasMatchUser(String userName, String password) {
        int matchCount = userDao.getMatchCount(userName, password);
        return matchCount > 0;
    }

    public boolean hasMatchUser(String userName) {
        int matchCount = userDao.getMatchCount(userName);
        return matchCount > 0;
    }

    public User findUserByUserName(String userName) {
        return userDao.findUserByUserName(userName);
    }

    /**
     * 注册
     */
    public void register(String userName, String password) {
        User user = new User(userName, password);
        userDao.insertUser(user);
    }

    /**
     * 充值服务
     */
    public void recharge(int amount, int userId) {
        User user = userDao.findUserById(userId);
        userDao.updateBalance(user.getBalance() + amount, userId);
    }

}
